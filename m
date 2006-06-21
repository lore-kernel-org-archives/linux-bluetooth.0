Return-Path: <lucharse@yahoo.com.cn>
Message-ID: <20060621080938.23246.qmail@web15801.mail.cnb.yahoo.com>
Date: Wed, 21 Jun 2006 16:09:38 +0800 (CST)
From: Mingfan lu <lucharse@yahoo.com.cn>
Subject: =?gb2312?q?=BB=D8=B8=B4=A3=BA=20Re:=20[Bluez-devel]=20RE=A3=BA=20RE:=20FW?=
 =?gb2312?q?D=A3=BA=20Re:=20Re:Request=20with=20RSSI?=
To: marcel@holtmann.org, BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1150873857.3950.7.camel@localhost>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1648018744-1150877378=:18445"
List-ID: <bluez-devel.lists.sourceforge.net>

--0-1648018744-1150877378=:18445
Content-Type: text/plain; charset=gb2312
Content-Transfer-Encoding: 8bit

mylinux:/home/lucharse/ContentPushing # hciconfig hci0 version
hci0:   Type: USB
        BD Address: 00:11:67:19:3D:EC ACL MTU: 678:8 SCO MTU: 48:10
        HCI Ver: 1.2 (0x2) HCI Rev: 0x1f4 LMP Ver: 1.2 (0x2) LMP Subver: 0x1f4
        Manufacturer: Integrated System Solution Corp. (57)


Marcel Holtmann <marcel@holtmann.org> –¥µ¿£∫  Hi,

> I want to get RSSI value when inquiring, and my dongole support the
> feature:
> mylinux:/home/lucharse# hciconfig hci0 features
> hci0: Type: USB
> BD Address: 00:11:67:19:3D:EC ACL MTU: 678:8 SCO MTU: 48:10
> Features: 0xbf 0xfe 0x8d 0x78 0x08 0x18 0x00 0x00
> <3-slot packets> <5-slot packets> > offset>
> 
> > packets>
> 

> 

> > RSSI>
> 
> 
> I set the inquiry mode to 1 which is inquiry with RSSI:
> 
> mylinux:/home/lucharse# hciconfig hci0 inqmode 1
> mylinux:/home/lucharse# hciconfig hci0 inqmode
> hci0: Type: USB
> BD Address: 00:11:67:19:3D:EC ACL MTU: 678:8 SCO MTU: 48:10
> Inquiry mode: Inquiry with RSSI
> 
> But when I use the sample code from from Scott W
> Gifford(http://sourceforge.net/mailarchive/message.php?msg_id=10195457) which is claimed to inquiry with RSSI, the output shows that the inquiry result without RSSI value. and the hcidump(-X -V) show the event type is EVT_INQUIRY_RESULT.
> 
> mylinux:/home/lucharse/testcase# ./a.out
> activate_rssi: err=0
> begin_inquiry: starting
> Polling...
> Got event! Type is 2
> inquiry_result: num 1
> 00:0F:B3:9B:04:D3: ?
> Polling...
> Got event! Type is 2
> inquiry_result: num 1
> 00:14:A4:D7:52:48: ?
> Polling...
> Got event! Type is 2
> inquiry_result: num 1
> 00:14:A4:D7:52:91: ?
> Polling...
> Got event! Type is 2
> inquiry_result: num 1
> 00:20:E0:7A:F4:E6: ?
> Polling...
> Polling...
> Program finished.
> cancel_inquiry: err=0
> 
> while using hcidump -X -V:
> 
> mylinux:/home/lucharse/# hcidump -X -V
> HCI sniffer - Bluetooth packet analyzer ver 1.31
> device: hci0 snap_len: 1028 filter: 0xffffffff
> < HCI Command: Write Inquiry Mode (0x03|0x0045) plen 1
> mode 1
> > HCI Event: Command Complete (0x0e) plen 4
> Write Inquiry Mode (0x03|0x0045) ncmd 1
> status 0x00
> < HCI Command: Inquiry (0x01|0x0001) plen 5
> lap 0x9e8b33 len 48 num 0
> > HCI Event: Command Status (0x0f) plen 4
> Inquiry (0x01|0x0001) status 0x00 ncmd 1
> > HCI Event: Inquiry Result (0x02) plen 16
> bdaddr 00:0F:B3:9B:04:D3 mode 1 clkoffset 0x10e4 class 0x020104
> > HCI Event: Inquiry Result (0x02) plen 16
> bdaddr 00:14:A4:D7:52:48 mode 1 clkoffset 0x7c5a class 0x72010c
> > HCI Event: Inquiry Result (0x02) plen 16
> bdaddr 00:14:A4:D7:52:91 mode 1 clkoffset 0x4c9b class 0x72010c
> > HCI Event: Inquiry Result (0x02) plen 16
> bdaddr 00:20:E0:7A:F4:E6 mode 1 clkoffset 0x6ec5 class 0x00010c
> < HCI Command: Inquiry Cancel (0x01|0x0002) plen 0
> > HCI Event: Command Complete (0x0e) plen 4
> Inquiry Cancel (0x01|0x0002) ncmd 1
> status 0x00
> 
> in your last mail, you ask me to to use hcidump(-X -V), but I can't
> see the RSSI value. 
> 
> The sample code I used uses the HCI raw socket, and I review the DBus
> API(bluez-utils-3.1), I don't know which API can give me the RSSI
> wheng inquirying.
> 
> How do you think about it?

this is strange. If "hciconfig hci0 inqmode" tells you that you use
Inquiry with RSSI then you should get the Inquiry with RSSI Results.
What hardware is this (hciconfig hci0 version).

Regards

Marcel

> 



_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel



With respects,
        Mingfan.Lu 

 __________________________________________________
∏œøÏ◊¢≤·—≈ª¢≥¨¥Û»›¡ø√‚∑—” œ‰?
http://cn.mail.yahoo.com
--0-1648018744-1150877378=:18445
Content-Type: text/html; charset=gb2312
Content-Transfer-Encoding: 8bit

mylinux:/home/lucharse/ContentPushing # hciconfig hci0 version<BR>hci0:&nbsp;&nbsp; Type: USB<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BD Address: 00:11:67:19:3D:EC ACL MTU: 678:8 SCO MTU: 48:10<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; HCI Ver: 1.2 (0x2) HCI Rev: 0x1f4 LMP Ver: 1.2 (0x2) LMP Subver: 0x1f4<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Manufacturer: Integrated System Solution Corp. (57)<BR><BR><BR><B><I>Marcel Holtmann &lt;marcel@holtmann.org&gt;</I></B> –¥µ¿£∫  <BLOCKQUOTE class=replbq style="PADDING-LEFT: 5px; MARGIN-LEFT: 5px; BORDER-LEFT: #1010ff 2px solid">Hi,<BR><BR>&gt; I want to get RSSI value when inquiring, and my dongole support the<BR>&gt; feature:<BR>&gt; mylinux:/home/lucharse# hciconfig hci0 features<BR>&gt; hci0: Type: USB<BR>&gt; BD Address: 00:11:67:19:3D:EC ACL MTU: 678:8 SCO MTU: 48:10<BR>&gt; Features: 0xbf 0xfe 0x8d 0x78 0x08 0x18 0x00 0x00<BR>&gt; &lt;3-slot packets&gt; &lt;5-slot packets&gt; <ENCRYPTION><SLOT<BR>&gt;
 offset&gt;<BR>&gt; <TIMING accuracy><ROLE switch><SNIFF mode><RSSI><BR>&gt; <CHANNEL quality><SCO link><HV2 packets><HV3<BR>&gt; packets&gt;<BR>&gt; <U-LAW log><A-LAW log><CVSD><POWER control><BR>&gt; <TRANSPARENT SCO><BROADCAST encrypt><ENHANCED iscan><BR>&gt; <INTERLACED iscan><INTERLACED pscan><INQUIRY with<br>&gt; RSSI&gt;<BR>&gt; <AFH slave cap.><AFH cap. master><AFH master class.><BR>&gt; <BR>&gt; I set the inquiry mode to 1 which is inquiry with RSSI:<BR>&gt; <BR>&gt; mylinux:/home/lucharse# hciconfig hci0 inqmode 1<BR>&gt; mylinux:/home/lucharse# hciconfig hci0 inqmode<BR>&gt; hci0: Type: USB<BR>&gt; BD Address: 00:11:67:19:3D:EC ACL MTU: 678:8 SCO MTU: 48:10<BR>&gt; Inquiry mode: Inquiry with RSSI<BR>&gt; <BR>&gt; But when I use the sample code from from Scott W<BR>&gt; Gifford(http://sourceforge.net/mailarchive/message.php?msg_id=10195457) which is claimed to inquiry with RSSI, the output shows that the inquiry result without RSSI value. and the hcidump(-X -V)
 show the event type is EVT_INQUIRY_RESULT.<BR>&gt; <BR>&gt; mylinux:/home/lucharse/testcase# ./a.out<BR>&gt; activate_rssi: err=0<BR>&gt; begin_inquiry: starting<BR>&gt; Polling...<BR>&gt; Got event! Type is 2<BR>&gt; inquiry_result: num 1<BR>&gt; 00:0F:B3:9B:04:D3: ?<BR>&gt; Polling...<BR>&gt; Got event! Type is 2<BR>&gt; inquiry_result: num 1<BR>&gt; 00:14:A4:D7:52:48: ?<BR>&gt; Polling...<BR>&gt; Got event! Type is 2<BR>&gt; inquiry_result: num 1<BR>&gt; 00:14:A4:D7:52:91: ?<BR>&gt; Polling...<BR>&gt; Got event! Type is 2<BR>&gt; inquiry_result: num 1<BR>&gt; 00:20:E0:7A:F4:E6: ?<BR>&gt; Polling...<BR>&gt; Polling...<BR>&gt; Program finished.<BR>&gt; cancel_inquiry: err=0<BR>&gt; <BR>&gt; while using hcidump -X -V:<BR>&gt; <BR>&gt; mylinux:/home/lucharse/# hcidump -X -V<BR>&gt; HCI sniffer - Bluetooth packet analyzer ver 1.31<BR>&gt; device: hci0 snap_len: 1028 filter: 0xffffffff<BR>&gt; &lt; HCI Command: Write Inquiry Mode (0x03|0x0045) plen 1<BR>&gt; mode 1<BR>&gt;
 &gt; HCI Event: Command Complete (0x0e) plen 4<BR>&gt; Write Inquiry Mode (0x03|0x0045) ncmd 1<BR>&gt; status 0x00<BR>&gt; &lt; HCI Command: Inquiry (0x01|0x0001) plen 5<BR>&gt; lap 0x9e8b33 len 48 num 0<BR>&gt; &gt; HCI Event: Command Status (0x0f) plen 4<BR>&gt; Inquiry (0x01|0x0001) status 0x00 ncmd 1<BR>&gt; &gt; HCI Event: Inquiry Result (0x02) plen 16<BR>&gt; bdaddr 00:0F:B3:9B:04:D3 mode 1 clkoffset 0x10e4 class 0x020104<BR>&gt; &gt; HCI Event: Inquiry Result (0x02) plen 16<BR>&gt; bdaddr 00:14:A4:D7:52:48 mode 1 clkoffset 0x7c5a class 0x72010c<BR>&gt; &gt; HCI Event: Inquiry Result (0x02) plen 16<BR>&gt; bdaddr 00:14:A4:D7:52:91 mode 1 clkoffset 0x4c9b class 0x72010c<BR>&gt; &gt; HCI Event: Inquiry Result (0x02) plen 16<BR>&gt; bdaddr 00:20:E0:7A:F4:E6 mode 1 clkoffset 0x6ec5 class 0x00010c<BR>&gt; &lt; HCI Command: Inquiry Cancel (0x01|0x0002) plen 0<BR>&gt; &gt; HCI Event: Command Complete (0x0e) plen 4<BR>&gt; Inquiry Cancel (0x01|0x0002) ncmd 1<BR>&gt; status
 0x00<BR>&gt; <BR>&gt; in your last mail, you ask me to to use hcidump(-X -V), but I can't<BR>&gt; see the RSSI value. <BR>&gt; <BR>&gt; The sample code I used uses the HCI raw socket, and I review the DBus<BR>&gt; API(bluez-utils-3.1), I don't know which API can give me the RSSI<BR>&gt; wheng inquirying.<BR>&gt; <BR>&gt; How do you think about it?<BR><BR>this is strange. If "hciconfig hci0 inqmode" tells you that you use<BR>Inquiry with RSSI then you should get the Inquiry with RSSI Results.<BR>What hardware is this (hciconfig hci0 version).<BR><BR>Regards<BR><BR>Marcel<BR><BR>&gt; <BR><BR><BR><BR>_______________________________________________<BR>Bluez-devel mailing list<BR>Bluez-devel@lists.sourceforge.net<BR>https://lists.sourceforge.net/lists/listinfo/bluez-devel<BR></BLOCKQUOTE><BR><BR><BR><DIV id=RTEContent><FONT face="comic sans ms" color=#bc6e6e size=5>With respects,</FONT></DIV>  <DIV>&nbsp;<FONT size=4>&nbsp;&nbsp;&nbsp;&nbsp;<FONT color=#ff0000>&nbsp;<FONT
 face="comic sans ms">Mingfan.Lu</FONT></FONT></FONT> <IMG src="http://us.i1.yimg.com/us.yimg.com/i/mesg/tsmileys2/01.gif"></DIV><p>&#32;__________________________________________________<br>∏œøÏ◊¢≤·—≈ª¢≥¨¥Û»›¡ø√‚∑—” œ‰?<br>http://cn.mail.yahoo.com
--0-1648018744-1150877378=:18445--
