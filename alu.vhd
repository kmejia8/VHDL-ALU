------------------------------------------------------------------------------------------
-- Written by Karla Mejia
--
-- The code was developed to implement a 32-bit Arithmetic and Logic Unit (ALU) 
-- as part of the MIPS datapath design. To achieve this, multiple functions 
-- were added to support logical operations, addition/subtraction with carry, 
-- shifting, and set-less-than comparisons.
--
-- Modifications included extending the operand size to account for carryout 
-- and overflow detection, adding conditional statements for signed/unsigned 
-- comparisons, and mapping control signals to specific ALU functions using 
-- a "with-select-when".
--
-- The ALU is capable of generating correct result values for each operation 
-- and updating flags (Zero, Carryout, Overflow) to reflect the computation 
-- outcomes. This is one of the fundamental parts of the overall MIPS datapath.
-- 
-- This code is provided here solely for educational and portfolio purposes.  
-- No permission is granted to copy, modify, or redistribute this code.  
------------------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity alu is
    port(   A, B : in std_logic_vector(31 downto 0);
            ALUCntl : in std_logic_vector(3 downto 0);
            Shamt : in std_logic_vector(4 downto 0);
            Dout : out std_logic_vector(31 downto 0);
            Zero, Overflow, Carryout : out std_logic;
            Carryin : in std_logic
    );
end alu;

architecture Behavioral of alu is
signal ALU_result : std_logic_vector(31 downto 0);
signal extended_A, extended_B : std_logic_vector(32 downto 0);
signal add_result, sub_result : std_logic_vector(32 downto 0);
signal slt_result, sltu_result : std_logic_vector(31 downto 0);

begin
    -- padding signals with 0 to handle carryout and overflow
    extended_A <= '0' & A;
    extended_B <= '0' & B;

    -- Doing addition and subtraction with longer bits, also considering Carryin
    add_result <= std_logic_vector(unsigned(extended_A) + unsigned(extended_B) + unsigned'("0" & Carryin));
    sub_result <= std_logic_vector(unsigned(extended_A) - unsigned(extended_B));

    -- computing SLT and SLTU, sets signal to 1 if A < B, else sets to 0
    slt_result <= x"00000001" when signed(A) < signed(B) else x"00000000"; 
    sltu_result <= x"00000001" when unsigned(A) < unsigned(B) else x"00000000"; 

    -- using with select when to determine result based off of ALUCntl
    with ALUCntl select
        ALU_result <= A and B when "0000", -- AND
                      A or B when "0001", -- OR
                      A xor B when "0010", -- XOR
                      not (A or B) when "0011", -- NOR
                      add_result(31 downto 0) when "0100", -- ADD
                      sub_result(31 downto 0) when "0101", -- SUB
                      std_logic_vector(shift_left(unsigned(B), to_integer(unsigned(Shamt)))) when "0110", -- SLL
                      std_logic_vector(shift_right(unsigned(B), to_integer(unsigned(Shamt)))) when "0111", -- SRL
                      slt_result when "1000", -- SLT
                      sltu_result when "1001", -- SLTU
                      A when others; -- stores result as A if none of the functions chosen

    -- CarryOut is most left bit when doing addition, else its always 0
    Carryout <= add_result(32) when ALUCntl = "0100" else '0';

    -- Overflow for addition is A'B'S + ABS' for 32nd bit
    -- Overflow for subtraction is AB'S' + A'BS for 32nd bit
    Overflow <= ((not extended_A(31) and not extended_B(31) and add_result(31)) or
                (extended_A(31) and extended_B(31) and not add_result(31)))
                when ALUCntl = "0100" else
                ((extended_A(31) and not extended_B(31) and not sub_result(31)) or
                 (not extended_A(31) and extended_B(31) and sub_result(31)))
                when ALUCntl = "0101" else '0';

    -- Zero Flag
    Zero <= '1' when ALU_result = x"00000000" else '0';

    -- assigns final result to Dout
    Dout <= ALU_result;
end Behavioral;
