# FPGA-VHDL-uart-receiver
# The VHDL code designed for uart receiver with buad rate = 9600 and cpu clock = 50 MHz is below:
--------------------------------------------------------------------------------
-- Company: 
-- Engineer: Alireza Eskandari
--
-- Create Date:   18:40:22 04/12/2025
-- Design Name:   
-- Module Name:   D:/fpga/Projects/P14_uart_rx/uart_rx_tb.vhd
-- Project Name:  P14_uart_rx
-- Target Device:  xc6slx16-2ftg256
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: uart_rx
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY uart_rx_tb IS
END uart_rx_tb;
 
ARCHITECTURE behavior OF uart_rx_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT uart_rx
    PORT(
         clk : IN  std_logic;
         rx : IN  std_logic;
         dout : OUT  std_logic_vector(7 downto 0);
         valid : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal rx : std_logic := '0';

 	--Outputs
   signal dout : std_logic_vector(7 downto 0);
   signal valid : std_logic;

   -- Clock period definitions
   constant clk_period : time := 20 ns;
	constant data: std_logic_vector(7 downto 0) := x"9B";
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: uart_rx PORT MAP (
          clk => clk,
          rx => rx,
          dout => dout,
          valid => valid
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
	rx <= '1'; wait for 104.16 us; --idle
	rx <= '0'; wait for 140.16 us; --start
     for i in 0 to 7 loop
			rx <= data(i); --data
			wait for 104.16 us;
	  end loop;
	  rx <= '1'; wait for 104.16 us; --stop
      wait;
   end process;

END;

