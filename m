Return-Path: <bluez-users-bounces@lists.sourceforge.net>
MIME-Version: 1.0
Date: Thu, 22 Feb 2007 09:01:36 +0100
Message-ID: <7FEBB30F0CE41B419B38295024A58EE3A10D44@oxygen.mail.telnet.tunis>
From: "Asma Tebessi" <asma.tebessi@telnet.com.tn>
To: <bluez-users@lists.sourceforge.net>
Subject: [Bluez-users] modprobe snd-bt-sco
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1715252353=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

This is a multi-part message in MIME format.

--===============1715252353==
Content-class: urn:content-classes:message
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C75657.ACCE368C"

This is a multi-part message in MIME format.

------_=_NextPart_001_01C75657.ACCE368C
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi all,

I've installed the latest versions of bluez 'bluez-utils-3.9, =
bluez-libs-3.9, bluez-hcidump-1.33 and bluez-firmware-1.2' under =
Mandriva 2006 and I can establish a connection between my pc and my =
nokia N70. I want to have the handsfree option available so I add it =
with : sdptool add --channel=3D2 HF (the channel for handsfree on N70 is =
the number 1) and the test seems to work since I had an icon on my nokia =
when I launch :
 rfcomm connect /dev/rfcomm0 00:16:4E:D9:20:98 2
The connection lasts only few secondes then terminate. So I make : =
rfcomm listen /dev/rfcomm0  2 and try to call the nokia N70 from another =
phone. The N7O contact the pc via bluetooth and I enter the PIN in both =
sides and the connection is done but when I hangup the sound doesn't =
came from the pc's headspeaker but from N70's one.
I thought I need to install the bluetooth-alsa to make it work. So I do, =
I installed btsco-0.5, plugz and sbc and I've got no errors. I followed =
the instructions within this document =
"http://www.linux.ie/articles/bluetoothheadset.php" but when I made =
modprobe snd-bt-sco I got :

[root@localhost confhandsfree]# modprobe snd-bt-sco
FATAL: Module snd-bt-sco not found.

I dont understand how to make it work since I got no errors while =
compiling the btsco and processing the
"cd kernel - make - make install - depmod -e - make clean"

Otherwise, I tried to connect my bluetooth dongle 'belkin' and I got :

[root@localhost confhandsfree]# btsco 00:0A:3A:50:27:84   2
Error: hwdep next device (hw:0): Operation not permitted
Error: control open (hw:1): No such device
Error: Can't find device. Bail

I hope that you'll help me I need to make this work as soon as possible =
and I'm lost :(

Thanks a lot.

------_=_NextPart_001_01C75657.ACCE368C
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Diso-8859-1">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.7226.0">
<TITLE>modprobe snd-bt-sco</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/plain format -->

<P><FONT SIZE=3D2>Hi all,<BR>
<BR>
I've installed the latest versions of bluez 'bluez-utils-3.9, =
bluez-libs-3.9, bluez-hcidump-1.33 and bluez-firmware-1.2' under =
Mandriva 2006 and I can establish a connection between my pc and my =
nokia N70. I want to have the handsfree option available so I add it =
with : sdptool add --channel=3D2 HF (the channel for handsfree on N70 is =
the number 1) and the test seems to work since I had an icon on my nokia =
when I launch :<BR>
&nbsp;rfcomm connect /dev/rfcomm0 00:16:4E:D9:20:98 2<BR>
The connection lasts only few secondes then terminate. So I make : =
rfcomm listen /dev/rfcomm0&nbsp; 2 and try to call the nokia N70 from =
another phone. The N7O contact the pc via bluetooth and I enter the PIN =
in both sides and the connection is done but when I hangup the sound =
doesn't came from the pc's headspeaker but from N70's one.<BR>
I thought I need to install the bluetooth-alsa to make it work. So I do, =
I installed btsco-0.5, plugz and sbc and I've got no errors. I followed =
the instructions within this document &quot;<A =
HREF=3D"http://www.linux.ie/articles/bluetoothheadset.php">http://www.lin=
ux.ie/articles/bluetoothheadset.php</A>&quot; but when I made modprobe =
snd-bt-sco I got :<BR>
<BR>
[root@localhost confhandsfree]# modprobe snd-bt-sco<BR>
FATAL: Module snd-bt-sco not found.<BR>
<BR>
I dont understand how to make it work since I got no errors while =
compiling the btsco and processing the<BR>
&quot;cd kernel - make - make install - depmod -e - make clean&quot;<BR>
<BR>
Otherwise, I tried to connect my bluetooth dongle 'belkin' and I got =
:<BR>
<BR>
[root@localhost confhandsfree]# btsco 00:0A:3A:50:27:84&nbsp;&nbsp; =
2<BR>
Error: hwdep next device (hw:0): Operation not permitted<BR>
Error: control open (hw:1): No such device<BR>
Error: Can't find device. Bail<BR>
<BR>
I hope that you'll help me I need to make this work as soon as possible =
and I'm lost :(<BR>
<BR>
Thanks a lot.</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C75657.ACCE368C--


--===============1715252353==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============1715252353==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============1715252353==--
