Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <BAY104-F3387CCB50D8B5E0CA2C7DAC1A50@phx.gbl>
From: "blookk -" <blookk@hotmail.com>
To: bluez-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/html; charset=iso-8859-1; format=flowed
Subject: [Bluez-devel] compiling hciconfig for ARM
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Thu, 23 Dec 2004 21:08:12 +0000

<html><div style='background-color:'><FONT size=2>
<P class=RTE>I have compiled the Bluez Utils and Libs 2.11 for a ARM platform, concretly for the CPU ARM7TDMI.<BR>I have done the compilation with uClibc-0.9.19 and in "hciconfig" tool I have a problem when I make"hciconfig -a" or "hciconfig hci0 name" or "hciconfig hci0 class" and other.<BR>All this problems occurs in file "hci.c", in function "int hci_send_req(int dd, struct hci_request *r, int to)".<BR>In this function when the program execute "n = poll(&amp;p, 1, to)" I obtain a kernel panic like this (executing hciconfig -a):</P>
<P class=RTE></P>
<P class=RTE>......</P></FONT><PRE class=RTE>Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3<BR>Link policy: RSWITCH HOLD SNIFF PARK<BR>Link mode: SLAVE ACCEPT</PRE><PRE class=RTE>Unhandled fault: alignment exception (93) at 0x00000001</PRE><PRE class=RTE>fault-common.c(97): start_code=0xeb000040, start_stack=0xe1a00004)</PRE><PRE class=RTE>Internal error: Oops: 0</PRE><PRE class=RTE>CPU: 0</PRE><PRE class=RTE>pc : [&lt;00007294&gt;] lr : [&lt;00030001&gt;] Not tainted</PRE><PRE class=RTE>sp : 00147dac ip : 00000004 fp : 00147e40</PRE><PRE class=RTE>r10: 00148080 r9 : 60000013 r8 : 001d8404</PRE><PRE class=RTE>r7 : 00f44b40 r6 : 00000000 r5 : e1dc30b3 r4 : 60000013</PRE><PRE class=RTE>r3 : 00000000 r2 : 0014602c r1 : 00147dac r0 : 00000004</PRE><PRE class=RTE>Flags: nzCv IRQs off FIQs on Mode SVC_32 Segment kernel</PRE><PRE class=RTE>Control: 0</PRE><PRE class=RTE>Process swapper (pid: 
0, stackpage=00147000)</PRE><PRE class=RTE>Stack:</PRE><PRE class=RTE>00147d80: 00030</PRE><PRE class=RTE>00147da0: 00007294 20000093 ffffffff 00000004 00000000 00030001 00000005 00147</PRE><PRE class=RTE>00147dc0: 00147dcc 000a32e0 001112f0 c0f44a00 00000000 00147e14 00147de4 00f44</PRE><PRE class=RTE>00147de0: 00f44a00 00b18000 00147e0c 00147df8 000a820c 0001d6f8 00f44a00 00f44</PRE><PRE class=RTE>00147e00: 00147e20 00147e10 000a8224 000a8168 00000000 00000000 001d8400 00b18</PRE><PRE class=RTE>00147e20: 001d8404 001d8570 00147e58 e1dc30b3 00147e78 00147eac 00147e44 00007</PRE><PRE class=RTE>00147e40: 00007264 0000000e 000000c0 00000c14 00000006 00000040 00acc040 00000</PRE><PRE class=RTE>00147e60: 00f44b40 001d8404 60000093 00148080 00147eac 00d4800c 00147e8c 00acc</PRE><PRE class=RTE>00147e80: 000f5968 60000013 ffffffff 00f44b40 001d8404 00000000 001d849c 00000</PRE><PRE 
class=RTE>00147ea0: 00147ecc 00147eb0 000f3344 000f58d4 001d8474 00000000 00000000 00148</PRE><PRE class=RTE>00147ec0: 00147eec 00147ed0 000102b4 000f32d4 00148098 00000001 fffffff6 0016a</PRE><PRE class=RTE>00147ee0: 00147f18 00147ef0 0000fff0 00010244 00000000 00000000 04000000 00163</PRE><PRE class=RTE>00147f00: 001633a0 0016a9e0 00147f58 00147f28 00147f1c 000100a8 0000ff48 00147</PRE><PRE class=RTE>00147f20: 00147f2c 000035fc 000100a4 00147f8c 00002ab0 00003aa0 000041bc 60000</PRE><PRE class=RTE>00147f40: ffffffff 001637ac 00147fac 00147f58 00002980 000034e0 001e0000 00163</PRE><PRE class=RTE>00147f60: 00000000 00000000 00004194 00146000 00146000 00146000 00004194 00163</PRE><PRE class=RTE>00147f80: 001637ac 00147fac 00147fb0 00147fa0 00003aa0 000041bc 60000013 fffff</PRE><PRE class=RTE>00147fa0: 00147fd4 00147fb0 00003aa0 000041a4 0016c274 00148000 001637d8 162d3</PRE><PRE 
class=RTE>00147fc0: 0018d1c0 fbda068c 00147fe4 00147fd8 00002034 00003a54 00147ffc 00147</PRE><PRE class=RTE>00147fe0: 001564cc 00002010 0014a99c ffb00000 00000000 00148000 00001644 00156</PRE><PRE class=RTE>Backtrace:</PRE><PRE class=RTE>Function entered at [&lt;00007254&gt;] from [&lt;00007f98&gt;]</PRE><PRE class=RTE>r5 = 00147E78 r4 = E1DC30B3</PRE><PRE class=RTE>Function entered at [&lt;000f58c4&gt;] from [&lt;000f3344&gt;]</PRE><PRE class=RTE>r8 = 00000000 r7 = 001D849C r6 = 00000000 r5 = 001D8404</PRE><PRE class=RTE>r4 = 00F44B40</PRE><PRE class=RTE>Function entered at [&lt;000f32c4&gt;] from [&lt;000102b4&gt;]</PRE><PRE class=RTE>r7 = 00148040 r6 = 00000000 r5 = 00000000 r4 = 001D8474</PRE><PRE class=RTE>Function entered at [&lt;00010234&gt;] from [&lt;0000fff0&gt;]</PRE><PRE class=RTE>r7 = 0016A9E0 r6 = FFFFFFF6 r5 = 00000001 r4 = 00148098</PRE><PRE class=RTE>Function entered at 
[&lt;0000ff38&gt;] from [&lt;000100a8&gt;]</PRE><PRE class=RTE>Function entered at [&lt;00010094&gt;] from [&lt;000035fc&gt;]</PRE><PRE class=RTE>Function entered at [&lt;000034d0&gt;] from [&lt;00002980&gt;]</PRE><PRE class=RTE>Function entered at [&lt;00004194&gt;] from [&lt;00003aa0&gt;]</PRE><PRE class=RTE>Function entered at [&lt;00003a44&gt;] from [&lt;00002034&gt;]</PRE><PRE class=RTE>Function entered at [&lt;00002000&gt;] from [&lt;001564cc&gt;]</PRE><PRE class=RTE>Function entered at [&lt;001563c0&gt;] from [&lt;00001644&gt;]</PRE><PRE class=RTE>r4 = FFB00000</PRE><PRE class=RTE>Code: e50be08c e3cd2d7f (e594303c) e3c2203f e50b3088</PRE><PRE class=RTE>Kernel panic: Aiee, killing interrupt handler</PRE><PRE class=RTE>In interrupt handler - not syncing</PRE><FONT size=2>
<P class=RTE>-----</P>
<P class=RTE>What can I do for solve this problem?</P>
<P class=RTE>thanks.</P></FONT></div></html>



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
