`timescale 1ns / 1ps
module dut(
 input clk,rst, in,
 output detect
 );
 localparam s0 = 2'b00,
            s1 = 2'b01, 
            s2 = 2'b10,
            s3 = 2'b11;
  reg [1:0] pstate, nstate;
  always@(posedge clk or negedge rst)
  begin
   if (!rst) 
      pstate <= s0;
   else 
      pstate <= nstate;
  end
  always@(pstate or in)
  begin
   case(pstate)
    s0: begin
      if (in == 1)
        nstate = s1;
      else 
        nstate = s0;
    end
     s1: nstate = s2;
     s2: begin
       if (in == 1)
         nstate = s3;
       else 
         nstate = s0;
     end
     s3: 
     nstate = s2;
     default nstate = s0;
   endcase
  end
  assign detect = ((pstate == 1) && ((in == 1)|(in == 0)));
  endmodule

  /* `timescale 1ns / 1ps
module tb( );
 reg rst, clk, in;
 wire detect;
 
 //instantiate 
 dut uut(
         .rst(rst),
         .clk(clk),
         .in(in),
         .detect(detect)
 );
 
 initial begin
   clk = 0;
   forever #5 clk = ~ clk;
 end
 
 initial begin
  rst = 0;
  in = 0;
  $monitor (" in = %0d, detect = %0d", in, detect);
  #5 rst = 1;
  #15 in = 1;
  #15 in = 1;
  #15 in = 1;
  #15 in = 0;
  #15 in = 1;
  $finish ;
 end
  
endmodule
*/
