Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <20060621050238.39581.qmail@web15809.mail.cnb.yahoo.com>
Date: Wed, 21 Jun 2006 13:02:38 +0800 (CST)
From: Mingfan lu <lucharse@yahoo.com.cn>
To: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1150787688.18381.0.camel@localhost>
MIME-Version: 1.0
Cc: bluez-devel@lists.sourceforge.net
Subject: [Bluez-devel]
 =?gb2312?q?RE:=20RE=A3=BA=20RE:=20FWD=A3=BA=20Re:=20Re:Request=20with=20R?=
 =?gb2312?q?SSI?=
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0769833229=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============0769833229==
Content-Type: multipart/alternative; boundary="0-950324891-1150866158=:27770"
Content-Transfer-Encoding: 8bit

--0-950324891-1150866158=:27770
Content-Type: text/plain; charset=gb2312
Content-Transfer-Encoding: 8bit

Marcel,
   I want to get RSSI value when inquiring, and my dongole support the feature:
  mylinux:/home/lucharse# hciconfig hci0 features
hci0:   Type: USB
        BD Address: 00:11:67:19:3D:EC ACL MTU: 678:8 SCO MTU: 48:10
        Features: 0xbf 0xfe 0x8d 0x78 0x08 0x18 0x00 0x00
                <3-slot packets> <5-slot packets> <encryption> <slot offset>
                <timing accuracy> <role switch> <sniff mode> <RSSI>
                <channel quality> <SCO link> <HV2 packets> <HV3 packets>
                <u-law log> <A-law log> <CVSD> <power control>
                <transparent SCO> <broadcast encrypt> <enhanced iscan>
                <interlaced iscan> <interlaced pscan> <inquiry with RSSI>
                <AFH cap. slave> <AFH cap. master> <AFH class. master>
   
  I set the inquiry mode to 1 which is inquiry with RSSI:
   
  mylinux:/home/lucharse# hciconfig hci0 inqmode 1
mylinux:/home/lucharse# hciconfig hci0 inqmode
hci0:   Type: USB
        BD Address: 00:11:67:19:3D:EC ACL MTU: 678:8 SCO MTU: 48:10
        Inquiry mode: Inquiry with RSSI
  
But when I use the sample code from from Scott W Gifford(http://sourceforge.net/mailarchive/message.php?msg_id=10195457) which is claimed to inquiry with RSSI, the output shows that the inquiry result without RSSI value. and the hcidump(-X -V) show the event type is EVT_INQUIRY_RESULT.
   
  mylinux:/home/lucharse/testcase# ./a.out
activate_rssi: err=0
begin_inquiry: starting
Polling...
Got event!  Type is 2
inquiry_result: num 1
 00:0F:B3:9B:04:D3:    ?
Polling...
Got event!  Type is 2
inquiry_result: num 1
 00:14:A4:D7:52:48:    ?
Polling...
Got event!  Type is 2
inquiry_result: num 1
 00:14:A4:D7:52:91:    ?
Polling...
Got event!  Type is 2
inquiry_result: num 1
 00:20:E0:7A:F4:E6:    ?
Polling...
Polling...
Program finished.
cancel_inquiry: err=0

  while using hcidump -X -V:
   
  mylinux:/home/lucharse/# hcidump -X -V
HCI sniffer - Bluetooth packet analyzer ver 1.31
device: hci0 snap_len: 1028 filter: 0xffffffff
< HCI Command: Write Inquiry Mode (0x03|0x0045) plen 1
    mode 1
> HCI Event: Command Complete (0x0e) plen 4
    Write Inquiry Mode (0x03|0x0045) ncmd 1
    status 0x00
< HCI Command: Inquiry (0x01|0x0001) plen 5
    lap 0x9e8b33 len 48 num 0
> HCI Event: Command Status (0x0f) plen 4
    Inquiry (0x01|0x0001) status 0x00 ncmd 1
> HCI Event: Inquiry Result (0x02) plen 16
    bdaddr 00:0F:B3:9B:04:D3 mode 1 clkoffset 0x10e4 class 0x020104
> HCI Event: Inquiry Result (0x02) plen 16
    bdaddr 00:14:A4:D7:52:48 mode 1 clkoffset 0x7c5a class 0x72010c
> HCI Event: Inquiry Result (0x02) plen 16
    bdaddr 00:14:A4:D7:52:91 mode 1 clkoffset 0x4c9b class 0x72010c
> HCI Event: Inquiry Result (0x02) plen 16
    bdaddr 00:20:E0:7A:F4:E6 mode 1 clkoffset 0x6ec5 class 0x00010c
< HCI Command: Inquiry Cancel (0x01|0x0002) plen 0
> HCI Event: Command Complete (0x0e) plen 4
    Inquiry Cancel (0x01|0x0002) ncmd 1
    status 0x00

  in your last mail, you ask me to to use hcidump(-X -V), but I can't see the RSSI value. 
   
  The sample code I used uses the HCI raw socket, and I review the DBus API(bluez-utils-3.1), I don't know which API can give me the RSSI wheng inquirying.
   
  How do you think about it?
   
  Hi,

>   I have the same problem, I have called "hciconfig hci0 inqmode 1"
> first to switch the feature, but I still have the the problem I only
> can get the inquiry result  without RSSI value.
> I am sure that my dongle supports the feature. 

if you run "hcidump -X -V" and then start an inquiry you should see the
new inquiry result with RSSI event. However the inquiry() API call of
the Bluetooth library can't handle the RSSI value. Even if the kernel
sees it. There is no way to get it back to the application. So you
either gonna use the HCI raw socket or the new BlueZ D-Bus API to
actually get the RSSI value.

Regards

Marcel

   
  

Marcel Holtmann <marcel@holtmann.org> Ð´µÀ£º
  Hi,

> In fact, the code I used to inquiry with rssi from Scott W Gifford
> (http://sourceforge.net/mailarchive/message.php?msg_id=10195457) uses
> the raw socket, but I can only get EVT_INQUIRY_RESULT event type. So,
> raw socket can't give me the rssi value. How do you think about it?

please summarize your problem and repost to the BlueZ developer mailing
list address. You used the wrong address and I didn't see it last time.

Regards

Marcel





With respects,
        Mingfan.Lu 

 		
---------------------------------
ÇÀ×¢ÑÅ»¢Ãâ·ÑÓÊÏä-3.5GÈÝÁ¿£¬20M¸½¼þ£¡ 
--0-950324891-1150866158=:27770
Content-Type: text/html; charset=gb2312
Content-Transfer-Encoding: 8bit

<div>Marcel,</div>  <div>&nbsp;I want to get RSSI value when inquiring, and my dongole support the feature<EM>:</EM></div>  <div><EM>mylinux:/home/lucharse# hciconfig hci0 features<BR>hci0:&nbsp;&nbsp; Type: USB<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BD Address: 00:11:67:19:3D:EC ACL MTU: 678:8 SCO MTU: 48:10<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Features: 0xbf 0xfe 0x8d 0x78 0x08 0x18 0x00 0x00<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt;3-slot packets&gt; &lt;5-slot packets&gt; &lt;encryption&gt; &lt;slot offset&gt;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt;timing accuracy&gt; &lt;role switch&gt; &lt;sniff mode&gt; &lt;RSSI&gt;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt;channel quality&gt; &lt;SCO link&gt; &lt;HV2 packets&gt; &lt;HV3
 packets&gt;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt;u-law log&gt; &lt;A-law log&gt; &lt;CVSD&gt; &lt;power control&gt;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt;transparent SCO&gt; &lt;broadcast encrypt&gt; &lt;enhanced iscan&gt;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt;interlaced iscan&gt; &lt;interlaced pscan&gt; <FONT style="BACKGROUND-COLOR: #d8a3a4">&lt;inquiry with RSSI&gt;<BR></FONT>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt;AFH cap. slave&gt; &lt;AFH cap. master&gt; &lt;AFH class. master&gt;</EM></div>  <div><EM></EM>&nbsp;</div>  <div>I set the inquiry mode to 1 which is inquiry with RSSI:</div>  <div><EM></EM>&nbsp;</div>  <div><EM>mylinux:/home/lucharse# hciconfig hci0 inqmode 1<BR>mylinux:/home/lucharse# hciconfig hci0
 inqmode<BR>hci0:&nbsp;&nbsp; Type: USB<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BD Address: 00:11:67:19:3D:EC ACL MTU: 678:8 SCO MTU: 48:10<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<FONT style="BACKGROUND-COLOR: #ffff00">&nbsp; Inquiry mode: Inquiry with RSSI</FONT></EM></div>  <div><EM><BR></EM>But when I use the sample code from from Scott W Gifford(<A href="http://sourceforge.net/mailarchive/message.php?msg_id=10195457">http://sourceforge.net/mailarchive/message.php?msg_id=10195457</A>) which is claimed to inquiry with RSSI, the output shows that the inquiry result without RSSI value. and the hcidump(-X -V) show the event type is EVT_INQUIRY_RESULT.</div>  <div><EM></EM>&nbsp;</div>  <div><EM>mylinux:/home/lucharse</EM>/testcase# ./a.out<BR>activate_rssi: err=0<BR>begin_inquiry: starting<BR>Polling...<BR>Got event!&nbsp; Type is 2<BR>inquiry_result: num 1<BR>&nbsp;00:0F:B3:9B:04:D3:&nbsp;&nbsp;&nbsp; ?<BR>Polling...<BR>Got event!&nbsp; Type is 2<BR>inquiry_result:
 num 1<BR>&nbsp;00:14:A4:D7:52:48:&nbsp;&nbsp;&nbsp; ?<BR>Polling...<BR>Got event!&nbsp; Type is 2<BR>inquiry_result: num 1<BR>&nbsp;00:14:A4:D7:52:91:&nbsp;&nbsp;&nbsp; ?<BR>Polling...<BR>Got event!&nbsp; Type is 2<BR>inquiry_result: num 1<BR>&nbsp;00:20:E0:7A:F4:E6:&nbsp;&nbsp;&nbsp; ?<BR>Polling...<BR>Polling...<BR>Program finished.<BR>cancel_inquiry: err=0<BR></div>  <div>while using hcidump -X -V:</div>  <div>&nbsp;</div>  <div><EM>mylinux:/home/lucharse</EM>/# hcidump -X -V<BR>HCI sniffer - Bluetooth packet analyzer ver 1.31<BR>device: hci0 snap_len: 1028 filter: 0xffffffff<BR>&lt; HCI Command: Write Inquiry Mode (0x03|0x0045) plen 1<BR>&nbsp;&nbsp;&nbsp; mode 1<BR>&gt; HCI Event: Command Complete (0x0e) plen 4<BR>&nbsp;&nbsp;&nbsp; Write Inquiry Mode (0x03|0x0045) ncmd 1<BR>&nbsp;&nbsp;&nbsp; status 0x00<BR>&lt; HCI Command: Inquiry (0x01|0x0001) plen 5<BR>&nbsp;&nbsp;&nbsp; lap 0x9e8b33 len 48 num 0<BR>&gt; HCI Event: Command Status (0x0f) plen
 4<BR>&nbsp;&nbsp;&nbsp; Inquiry (0x01|0x0001) status 0x00 ncmd 1<BR>&gt; HCI Event: Inquiry Result (0x02) plen 16<BR>&nbsp;&nbsp;&nbsp; bdaddr 00:0F:B3:9B:04:D3 mode 1 clkoffset 0x10e4 class 0x020104<BR>&gt; HCI Event: Inquiry Result (0x02) plen 16<BR>&nbsp;&nbsp;&nbsp; bdaddr 00:14:A4:D7:52:48 mode 1 clkoffset 0x7c5a class 0x72010c<BR>&gt; HCI Event: Inquiry Result (0x02) plen 16<BR>&nbsp;&nbsp;&nbsp; bdaddr 00:14:A4:D7:52:91 mode 1 clkoffset 0x4c9b class 0x72010c<BR>&gt; HCI Event: Inquiry Result (0x02) plen 16<BR>&nbsp;&nbsp;&nbsp; bdaddr 00:20:E0:7A:F4:E6 mode 1 clkoffset 0x6ec5 class 0x00010c<BR>&lt; HCI Command: Inquiry Cancel (0x01|0x0002) plen 0<BR>&gt; HCI Event: Command Complete (0x0e) plen 4<BR>&nbsp;&nbsp;&nbsp; Inquiry Cancel (0x01|0x0002) ncmd 1<BR>&nbsp;&nbsp;&nbsp; status 0x00<BR></div>  <div>in your last mail, you ask me to to use hcidump(-X -V), but I can't see the RSSI value. </div>  <div>&nbsp;</div>  <div>The sample code I used uses the HCI raw socket,
 and I&nbsp;review the DBus API(bluez-utils-3.1), I don't know which API can give me the RSSI wheng inquirying.</div>  <div>&nbsp;</div>  <div>How do you think about it?</div>  <div>&nbsp;</div>  <div><FONT style="BACKGROUND-COLOR: #d0d0d0">Hi,<BR><BR>&gt;&nbsp;&nbsp; I have the same problem, I have called "hciconfig hci0 inqmode 1"<BR>&gt; first to switch the feature, but I still have the the problem I only<BR>&gt; can get the inquiry result&nbsp; without RSSI value.<BR>&gt; I am sure that my dongle supports the feature. <BR><BR>if you run "hcidump -X -V" and then start an inquiry you should see the<BR>new inquiry result with RSSI event. However the inquiry() API call of<BR>the Bluetooth library can't handle the RSSI value. Even if the kernel<BR>sees it. There is no way to get it back to the application. So you<BR>either gonna use the HCI raw socket or the new BlueZ D-Bus API to<BR>actually get the RSSI value.<BR><BR>Regards<BR><BR>Marcel<BR></FONT></div> 
 <div>&nbsp;</div>  <div><BR><BR><B><I>Marcel Holtmann &lt;marcel@holtmann.org&gt;</I></B> Ð´µÀ£º</div>  <BLOCKQUOTE class=replbq style="PADDING-LEFT: 5px; MARGIN-LEFT: 5px; BORDER-LEFT: #1010ff 2px solid">Hi,<BR><BR>&gt; In fact, the code I used to inquiry with rssi from Scott W Gifford<BR>&gt; (http://sourceforge.net/mailarchive/message.php?msg_id=10195457) uses<BR>&gt; the raw socket, but I can only get EVT_INQUIRY_RESULT event type. So,<BR>&gt; raw socket can't give me the rssi value. How do you think about it?<BR><BR>please summarize your problem and repost to the BlueZ developer mailing<BR>list address. You used the wrong address and I didn't see it last time.<BR><BR>Regards<BR><BR>Marcel<BR><BR><BR></BLOCKQUOTE><BR><BR><BR><DIV id=RTEContent><FONT face="comic sans ms" color=#bc6e6e size=5>With respects,</FONT></DIV>  <DIV>&nbsp;<FONT size=4>&nbsp;&nbsp;&nbsp;&nbsp;<FONT color=#ff0000>&nbsp;<FONT face="comic sans ms">Mingfan.Lu</FONT></FONT></FONT> <IMG
 src="http://us.i1.yimg.com/us.yimg.com/i/mesg/tsmileys2/01.gif"></DIV><p>&#32;
		<hr size=1><a href="http://cn.mail.yahoo.com" target=blank>ÇÀ×¢ÑÅ»¢Ãâ·ÑÓÊÏä-3.5GÈÝÁ¿£¬20M¸½¼þ£¡</a> 
--0-950324891-1150866158=:27770--


--===============0769833229==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0769833229==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============0769833229==--
