module addition(input [31:0]in1,
					input [31:0]in2,
					output [31:0]s,
					output overflow);
	
	wire [31:0]c;
	
	wire res31;
	wire rein1_31;
	wire rein2_31;
	
	wire [3:0]ofc;
	
	// addition
	hadder add0(in1[0], in2[0], c[0], s[0]);//first half adder to get the first carry
	
	genvar i; //generate counter
	generate // full adders for 1 to 31 bit.
		for(i = 1; i <= 31; i = i + 1) begin : add_loop
			fadder add1_31(in1[i], in2[i], c[i-1], c[i], s[i]);
		end
	endgenerate
	
	//check adder overflow = in1[31]&in2[31]&sreverse[31] + in1reverse[31]&in2reverse[31]&s[31]
	not re_s_31(res31, s[31]);
	not re_in1_31(rein1_31, in1[31]);
	not re_in2_31(rein2_31, in2[31]);
	
	and of1(ofc[0], in1[31], in2[31]);
	and of2(ofc[1], ofc[0], res31);
	and of3(ofc[2], rein1_31, rein2_31);
	and of4(ofc[3], ofc[2], s[31]);
	or ofr(overflow, ofc[1], ofc[3]);
	
endmodule
