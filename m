Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <002f01c4fd75$e647c280$19cb13ac@stu.nus.edu.sg>
From: "Khoo Teck Ping" <eng10166@nus.edu.sg>
To: <bluez-devel@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_002A_01C4FDB8.F058FCB0"
Subject: [Bluez-devel] Project about Bluetooth Security: Request for assistance
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
Date: Tue, 18 Jan 2005 23:53:42 +0800

This is a multi-part message in MIME format.

------=_NextPart_000_002A_01C4FDB8.F058FCB0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Dear All

I am a newbie, please assist me if possible.=20

I have some questions about bluetooth security.=20

I am currently doing a project on bluetooth security and am required to =
develop some software (with bluetooth hardware) which can demonstrate =
bluetooth security weaknesses.=20

Following are my ideas, please comment

1. I have a silicon wave Bluetooth USB dongle and a V3 headset, and a =
Nokia 6600 smartphone. I desire to capture packets sent between the =
phone and the headset, without a bluetooth protocol analyser (eg from =
mobiwave), so that I can demostrate that a hacker can listen in to =
unencrypted voice traffic. Is this possible at all?

hcidump is similar to a protocol analyser, but it can capture only high =
level traffic. My guess is that I can use hcitool scan to get the =
bluetooth address of the phone and the headset first, and then based on =
the addresses attempt to calculate the pseudo random frequency hopping =
sequence, so that I can stay in the same frequency as the phone and the =
headset. Problem is i don't understand the output of hcidump. Can =
hcidump capture traffic which does not belong to the host device?=20

2. May I know the steps required to reproduce the work done by Adam =
Laurie (bluesnarfing) or the Flexilis team(bluesniper)? Will the test =
programs provided by the install of BlueZ be good as starting points? If =
so, which test program should I focus on? Please provide details if =
possible. This is purely for academic purposes.=20

3. For the program l2ping.c, what is the end result of the victim phone =
of running the program? Does it cause the phone to malfunction?=20

I ran it and pinged my Sony Ericsson T630. Later my phone could not =
initiate a bluetooth connection with my headset. Otherwise everything =
else is fine.=20

I shall be grateful for any assistance.=20

BlueZ is great software. Keep up the good work.=20

Teck Ping
------=_NextPart_000_002A_01C4FDB8.F058FCB0
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Diso-8859-1">
<META content=3D"MSHTML 6.00.2900.2523" name=3DGENERATOR>
<STYLE></STYLE>
</HEAD>
<BODY bgColor=3D#ffffff>
<DIV><FONT face=3DArial size=3D2>Dear All</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>I am a newbie, please assist me if =
possible.=20
</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>I have some questions about bluetooth =
security.=20
</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>I am currently doing a project on =
bluetooth=20
security and am required to develop some software (with bluetooth =
hardware)=20
which can demonstrate bluetooth security weaknesses. </FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Following are my ideas, please =
comment</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>1. I have a silicon wave Bluetooth USB =
dongle and a=20
V3 headset, and a Nokia 6600 smartphone. I desire to capture packets =
sent=20
between the phone and the headset, without a bluetooth protocol analyser =
(eg=20
from mobiwave), so that I can demostrate that a hacker can listen in to=20
unencrypted voice traffic. Is this possible at all?</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>hcidump is similar to a protocol =
analyser, but it=20
can capture only high level traffic. My guess is that I can use hcitool =
scan to=20
get the bluetooth address of the phone and the headset first, and then =
based on=20
the addresses attempt to calculate the pseudo random frequency hopping =
sequence,=20
so that I can stay in the same frequency as the phone and the headset. =
Problem=20
is i don't understand the output of hcidump. Can hcidump capture traffic =
which=20
does not belong to the host device? </FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>2. May I know the steps required to =
reproduce the=20
work done by Adam Laurie (bluesnarfing) or the Flexilis =
team(bluesniper)? Will=20
the test programs provided by the install of BlueZ be good as starting =
points?=20
If so, which test program should I focus on? Please provide details if =
possible.=20
This is purely for academic purposes. </FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>3. For the program l2ping.c, what is =
the end result=20
of the victim phone of running the program? Does it cause the phone to=20
malfunction?&nbsp;</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>I ran it and pinged my Sony Ericsson =
T630. Later my=20
phone could not initiate a bluetooth connection with my headset. =
Otherwise=20
everything else is fine. </FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>I shall be grateful for any assistance. =

</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>BlueZ is great software. Keep up the =
good work.=20
</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Teck Ping</FONT></DIV></BODY></HTML>

------=_NextPart_000_002A_01C4FDB8.F058FCB0--



-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
