Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Podologie Achilles <Podologie.achilles@planet.nl>
To: bluez-devel@lists.sourceforge.net
Message-id: <42942431.5040303@planet.nl>
MIME-version: 1.0
Content-type: text/html; charset=ISO-8859-1
Subject: [Bluez-devel] No sound with Canyon CN-BTH1 and CN-BTU1
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
Date: Wed, 25 May 2005 09:07:29 +0200

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
  <title></title>
</head>
<body bgcolor="#ffffff" text="#000000">
<font face="Adobe Helvetica">Hi , i've a small problem with my headset
en usb stick from canyon.<br>
<br>
I have no sound with my canyon CN-BTH1<br>
<br>
I compiled kernel 2.6.11.9 with build in alsa<br>
usb bluetooth : Canyon CN-BTU1<br>
headset : canyon CN-BTH1<br>
distro : SuSE 9.2<br>
<br>
when i changes the sound volume the headset response perfecty with
noise, but thats it.<br>
I tried with another usb-stick BT180 from trust (also silicone wave
chip inside) but there is no difference.<br>
Who can help me ?<br>
<br>
Thanx anyway !<br>
<br>
<br>
Loopback from kmix don't do anything, but i haven't test this before..<br>
<br>
<u>starting :</u><br>
<br>
<font color="#ff0000">modprobe snd_bt_sco (start as root)<br>
kmix <font color="#000000">(starting as user)</font><br>
</font><br>
at this time kmix found&nbsp; BT headset<br>
<br>
starting btsco (as user) <br>
<br>
<font color="#ff0000">achilles@office:~&gt; btsco -v 00:0a:94:8e:3B:b8</font><br>
<br>
<font color="#3366ff">btsco v0.4b<br>
Device is 1:0<br>
Voice setting: 0x0060<br>
RFCOMM channel 1 connected<br>
</font><br>
when changing volume from mic of speaker in kmix it changed in my
headset and i see it changing on screen (btsco).<br>
<br>
office:/home/achilles # <font color="#ff0000">hciconfig -a</font><br>
<font color="#3366ff">hci0:&nbsp;&nbsp; Type: USB<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BD Address: 00:0A:94:11:4F:8E ACL MTU: 120:20&nbsp; SCO MTU: 64:0<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UP RUNNING PSCAN ISCAN<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RX bytes:763 acl:23 sco:0 events:45 errors:0<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TX bytes:678 acl:16 sco:0 commands:23 errors:0<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Features: 0xff 0xff 0x05 0x00 0x00 0x00 0x00 0x00<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Link policy: RSWITCH HOLD SNIFF PARK<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Link mode: SLAVE ACCEPT<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Name: 'BlueZ office (0)'<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Class: 0x100100<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Service Classes:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Device Class: Computer, Uncategorized<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; HCI Ver: 1.1 (0x1) HCI Rev: 0x0 LMP Ver: 1.1 (0x1) LMP Subver:
0x757<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Manufacturer: Silicon Wave (11)<br>
</font><br>
office:/home/achilles # <font color="#ff0000">hciconfig hci0 revision</font><br>
<font color="#3366ff">hci0:&nbsp;&nbsp; Type: USB<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BD Address: 00:0A:94:11:4F:8E ACL MTU: 120:20&nbsp; SCO MTU: 64:0<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Unsupported manufacturer<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;<br>
office:/home/achilles # hcitool info 00:0a:94:8e:3b:b8<br>
Requesting information ...<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BD Address:&nbsp; 00:0a:94:8e:3b:b8<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Device Name: BT Headset-F<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; LMP Version: 1.1 (0x1) LMP Subversion: 0x434<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Manufacturer: Cambridge Silicon Radio (10)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Features: 0xfc 0xff 0x0f 0x00 0x00 0x00 0x00 0x00<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt;encryption&gt; &lt;slot offset&gt; &lt;timing
accuracy&gt; &lt;role switch&gt;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt;hold mode&gt; &lt;sniff mode&gt; &lt;park state&gt;
&lt;RSSI&gt; &lt;channel quality&gt;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt;SCO link&gt; &lt;HV2 packets&gt; &lt;HV3
packets&gt; &lt;u-law log&gt; &lt;A-law log&gt;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt;CVSD&gt; &lt;paging scheme&gt; &lt;power
control&gt; &lt;transparent SCO&gt;<br>
</font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;<br>
office:/home/achilles # <font color="#ff0000">hcidump -X</font><br>
<font color="#3366ff">HCIDump - HCI packet analyzer ver 1.11<br>
device: hci0 snap_len: 1028 filter: 0xffffffff<br>
</font><br>
(from another shell : )<br>
achilles@office:~&gt; <font color="#ff0000">aplay -B 100000 -D
plughw:Headset /opt/kde3/share/sounds/KDE_Startup_new.wav</font><br>
<font color="#3366ff">Playing WAVE
'/opt/kde3/share/sounds/KDE_Startup_new.wav' : Signed 16 bit Little
Endian, Rate 22050 Hz, Stereo</font><br>
<br>
hangs .... but info from btsco -V :<br>
<br>
<font color="#3366ff">speaker volume: 0 mic volume: 0<br>
i/o needed: connecting sco...<br>
connected SCO channel<br>
Done setting sco fd<br>
recieved AT+VGS=15<br>
Sending up speaker change 15<br>
recieved AT+VGS=15<br>
Sending up speaker change 15<br>
recieved AT+VGS=15<br>
Sending up speaker change 15<br>
recieved AT+VGS=15<br>
Sending up speaker change 15<br>
recieved AT+VGS=15<br>
Sending up speaker change 15<br>
recieved AT+VGS=15<br>
Sending up speaker change 15<br>
speaker volume: 15 mic volume: 1<br>
driver is not in use<br>
disconnected SCO channel<br>
</font><br>
<br>
lot of output to hcidump :<br>
<br>
<font color="#3366ff">&gt; SCO data: handle 0x0100 dlen 48<br>
&nbsp;&nbsp;&nbsp; 0000: 84 ff a6 ff dd ff b4 ff 90 ff 99 ff 76 ff 89 ff&nbsp;&nbsp;
............v...<br>
&nbsp;&nbsp;&nbsp; 0010: 7b ff 53 ff 64 ff 44 ff 4b ff 6b ff 66 ff 8c ff&nbsp;&nbsp;
{.S.d.D.K.k.f...<br>
&nbsp;&nbsp;&nbsp; 0020: 7c ff 7c ff 94 ff 6d ff 80 ff 81 ff 81 ff a6 ff&nbsp;&nbsp;
|.|...m.........<br>
&gt; SCO data: handle 0x0100 dlen 48<br>
&nbsp;&nbsp;&nbsp; 0000: 6a ff 4d ff 66 ff 7f ff 9a ff 7e ff 81 ff a7 ff&nbsp;&nbsp;
j.M.f.....~.....<br>
&nbsp;&nbsp;&nbsp; 0010: b7 ff b3 ff 97 ff 92 ff 98 ff aa ff 9c ff 7a ff&nbsp;&nbsp;
..............z.<br>
&nbsp;&nbsp;&nbsp; 0020: 9a ff 9e ff 84 ff 85 ff 84 ff 88 ff 8d ff 8c ff&nbsp;&nbsp;
................<br>
&gt; SCO data: handle 0x0100 dlen 48<br>
&nbsp;&nbsp;&nbsp; 0000: 81 ff 84 ff 8e ff 95 ff 9b ff 8c ff 90 ff 96 ff&nbsp;&nbsp;
................<br>
&nbsp;&nbsp;&nbsp; 0010: 98 ff 9b ff 97 ff ad ff ac ff b5 ff d1 ff bc ff&nbsp;&nbsp;
................<br>
&nbsp;&nbsp;&nbsp; 0020: af ff 9a ff 70 ff 91 ff 92 ff 6d ff a7 ff 93 ff&nbsp;&nbsp;
....p.....m.....<br>
&gt; SCO data: handle 0x0100 dlen 48<br>
&nbsp;&nbsp;&nbsp; 0000: 75 ff 8a ff 49 ff 55 ff 59 ff 44 ff 7a ff 81 ff&nbsp;&nbsp;
u...I.U.Y.D.z...<br>
&nbsp;&nbsp;&nbsp; 0010: 7a ff 76 ff 8d ff ad ff 86 ff 7a ff 86 ff 8b ff&nbsp;&nbsp;
z.v.......z.....<br>
&nbsp;&nbsp;&nbsp; 0020: 9e ff 98 ff a1 ff d0 ff e0 ff be ff 97 ff 93 ff&nbsp;&nbsp;
................<br>
&gt; SCO data: handle 0x0100 dlen 48<br>
&nbsp;&nbsp;&nbsp; 0000: 9c ff 9d ff 82 ff 73 ff a2 ff 8b ff 6d ff 8e ff&nbsp;&nbsp;
......s.....m...<br>
&nbsp;&nbsp;&nbsp; 0010: 7c ff 7d ff 73 ff 74 ff b0 ff 9b ff 8c ff b5 ff&nbsp;&nbsp;
|.}.s.t.........<br>
&nbsp;&nbsp;&nbsp; 0020: ad ff ae ff ae ff 9a ff af ff c1 ff bf ff b8 ff&nbsp;&nbsp;
................<br>
</font>and a lot more (pages)<br>
<br>
<br>
finaly when i push a button on my headset (with disconnected SCO
channel)<br>
output from btsco :<br>
<font color="#3366ff">recieved AT+CKPD=200</font><br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>
<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;<br>
<br>
<br>
<br>
<br>
<br>
</font>
</body>
</html>


-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
