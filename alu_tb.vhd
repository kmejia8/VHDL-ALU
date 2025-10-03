------------------------------------------------------------------------------------------
-- The following code was used to test a 32-bit VHDL ALU.
--
-- This code is provided here solely for educational and portfolio purposes.  
-- No permission is granted to copy, modify, or redistribute this code.  
------------------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity alu_tb is
end alu_tb;

architecture Behavioral of alu_tb is
component alu
    port(   A, B : in std_logic_vector(31 downto 0);
            ALUCntl : in std_logic_vector(3 downto 0);
            Shamt : in std_logic_vector(4 downto 0);
            Dout : out std_logic_vector(31 downto 0);
            Zero, Overflow, Carryout : out std_logic;
            Carryin : in std_logic
    );
end component;

-- testbench signals
signal A_tb, B_tb, Dout_tb : std_logic_vector(31 downto 0);
signal ALUCntl_tb : std_logic_vector(3 downto 0);
signal Shamt_tb : std_logic_vector(4 downto 0);
signal Zero_tb, Overflow_tb, Carryout_tb, Carryin_tb : std_logic;

begin
    -- mapping ports to testbench signals
    uut: alu port map(
        A => A_tb,
        B => B_tb,
        ALUCntl => ALUCntl_tb,
        Shamt => Shamt_tb,
        Dout => Dout_tb,
        Zero => Zero_tb,
        Overflow => Overflow_tb,
        Carryout => Carryout_tb,
        Carryin => Carryin_tb
    );

    process
    begin
        -- Row 1
        A_tb <= X"FFFF0000"; 
        B_tb <= X"0000FFFF"; 
        ALUCntl_tb <= "0000"; 
        Shamt_tb <= "00000";
        Carryin_tb <= '0';
        wait for 10 ns;

        -- Row 2
        A_tb <= X"FFFF0000"; 
        B_tb <= X"0000FFFF";
        ALUCntl_tb <= "0001"; 
        Shamt_tb <= "00000";
        Carryin_tb <= '0';
        wait for 10 ns;
        
        -- Row 3
        A_tb <= X"AAAAAAAA"; 
        B_tb <= X"5555AAAA"; 
        ALUCntl_tb <= "0010"; 
        Shamt_tb <= "00000";
        Carryin_tb <= '0';
        wait for 10 ns;
        
        -- Row 4
        A_tb <= X"AAAAAAAA"; 
        B_tb <= X"5555555A"; 
        ALUCntl_tb <= "0011"; 
        Shamt_tb <= "00000";
        Carryin_tb <= '0';
        wait for 10 ns;
        
        -- Row 5
        A_tb <= X"00000001"; 
        B_tb <= X"00000000"; 
        ALUCntl_tb <= "0100"; 
        Shamt_tb <= "00000";
        Carryin_tb <= '0';
        wait for 10 ns;
        
        -- Row 6
        A_tb <= X"00000001"; 
        B_tb <= X"00000000"; 
        ALUCntl_tb <= "0100"; 
        Shamt_tb <= "00000";
        Carryin_tb <= '1';
        wait for 10 ns;
        
        -- Row 7
        A_tb <= X"12345678"; 
        B_tb <= X"12345678"; 
        ALUCntl_tb <= "0100"; 
        Shamt_tb <= "00000";
        Carryin_tb <= '0';
        wait for 10 ns;
        
        -- Row 8
        A_tb <= X"12345678"; 
        B_tb <= X"12345678"; 
        ALUCntl_tb <= "0100"; 
        Shamt_tb <= "00000";
        Carryin_tb <= '1';
        wait for 10 ns;
        
        -- Row 9
        A_tb <= X"00000001"; 
        B_tb <= X"FFFFFFFF"; 
        ALUCntl_tb <= "0100"; 
        Shamt_tb <= "00000";
        Carryin_tb <= '0';
        wait for 10 ns;
        
        -- Row 10
        A_tb <= X"00000001"; 
        B_tb <= X"FFFFFFFF"; 
        ALUCntl_tb <= "0100"; 
        Shamt_tb <= "00000";
        Carryin_tb <= '1';
        wait for 10 ns;
        
        -- Row 11
        A_tb <= X"00000001"; 
        B_tb <= X"7FFFFFFF"; 
        ALUCntl_tb <= "0100"; 
        Shamt_tb <= "00000";
        Carryin_tb <= '1';
        wait for 10 ns;
        
        -- Row 12
        A_tb <= X"80000001"; 
        B_tb <= X"80000000"; 
        ALUCntl_tb <= "0100"; 
        Shamt_tb <= "00000";
        Carryin_tb <= '1';
        wait for 10 ns;
        
        -- Row 13
        A_tb <= X"00000000"; 
        B_tb <= X"00000001"; 
        ALUCntl_tb <= "0101"; 
        Shamt_tb <= "00000"; 
        Carryin_tb <= '0';
        wait for 10 ns;
        
        -- Row 14
        A_tb <= X"12345678"; 
        B_tb <= X"12345678"; 
        ALUCntl_tb <= "0101"; 
        Shamt_tb <= "00000"; 
        Carryin_tb <= '0';
        wait for 10 ns;
        
        -- Row 15
        A_tb <= X"12345678"; 
        B_tb <= X"12345677"; 
        ALUCntl_tb <= "0101"; 
        Shamt_tb <= "00000"; 
        Carryin_tb <= '0';
        wait for 10 ns;
        
        -- Row 16
        A_tb <= X"7FFFFFFF"; 
        B_tb <= X"FFFFFFFF"; 
        ALUCntl_tb <= "0101"; 
        Shamt_tb <= "00000"; 
        Carryin_tb <= '0';
        wait for 10 ns;
        
        -- Row 17
        A_tb <= X"00000000"; 
        B_tb <= X"0000FFFF"; 
        ALUCntl_tb <= "0110"; 
        Shamt_tb <= "00100"; 
        Carryin_tb <= '0';
        wait for 10 ns;
        
        -- Row 18
        A_tb <= X"00000000"; 
        B_tb <= X"FFFF0000"; 
        ALUCntl_tb <= "0110"; 
        Shamt_tb <= "00100"; 
        Carryin_tb <= '0';
        wait for 10 ns;
        
        -- Row 19
        A_tb <= X"FFFFFFFF"; 
        B_tb <= X"00000001"; 
        ALUCntl_tb <= "1000"; 
        Shamt_tb <= "00000"; 
        Carryin_tb <= '0';
        wait for 10 ns;
        
        -- Row 20
        A_tb <= X"FFFFFFFF"; 
        B_tb <= X"00000001"; 
        ALUCntl_tb <= "1001"; 
        Shamt_tb <= "00000"; 
        Carryin_tb <= '0';
        wait for 10 ns;

        wait;
    end process;
end Behavioral;
