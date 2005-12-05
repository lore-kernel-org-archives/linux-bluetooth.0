Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <000801c5f9a8$c9c6fb50$44cfd29b@MONFLORITE>
From: =?iso-8859-1?Q?Israel_Gu=EDo_Mu=F1oz?= <israzar@gmail.com>
To: <bluez-devel@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0005_01C5F9B1.29A3DEA0"
Subject: [Bluez-devel] Power Transmit Level
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
Date: Mon, 5 Dec 2005 15:32:55 +0100

This is a multi-part message in MIME format.

------=_NextPart_000_0005_01C5F9B1.29A3DEA0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi all,

I am using bluez-libs and utils 2.22 to measure the current transmit =
power level in my application. I get good results when the power level =
is over zero, but when a negative value should be returned, I get =
extremly high values instead; for example, 250.=20
My opinion is that this value is treated as unsigned integer when it is =
a signed integer. I am running on Debian, in case it matters.
If somebody has observed the same, please tell me so. I don't know =
whether the problem is in my computer or in the stack.

Thanks. 
------=_NextPart_000_0005_01C5F9B1.29A3DEA0
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Diso-8859-1">
<META content=3D"MSHTML 6.00.2800.1522" name=3DGENERATOR>
<STYLE></STYLE>
</HEAD>
<BODY bgColor=3D#ffffff>
<DIV><FONT face=3DArial size=3D2>Hi all,</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>I am using bluez-libs and utils 2.22 to =
measure the=20
current transmit power level in my application. I get good results when =
the=20
power level is over zero, but when a negative value should be returned, =
I get=20
extremly high values instead; for example, 250.&nbsp;</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>My opinion is that this value is =
treated as=20
unsigned integer when it is a signed integer. I am running on Debian, in =
case it=20
matters.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>If somebody has observed the same, =
please tell me=20
so. I don't know&nbsp;whether the problem is in my computer or in the=20
stack.</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial =
size=3D2>Thanks.</FONT>&nbsp;</DIV></BODY></HTML>

------=_NextPart_000_0005_01C5F9B1.29A3DEA0--



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
