Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <003501c3f672$d6e45a20$c4648dd4@tullio>
From: "Tullio" <julianino@inwind.it>
To: "Bluez List" <bluez-users@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0032_01C3F67B.362C7780"
Subject: [Bluez-users] pppd problem
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Wed, 18 Feb 2004 23:59:14 +0100

Messaggio in formato MIME composto da più parti.

------=_NextPart_000_0032_01C3F67B.362C7780
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: Quoted-Printable

Hi to all,

I want to use a Nokia 3650 as a modem. I have written the pppd peers =
file and the chat script, but when I try the connection using pppd call =
gprs there isn't any result.

These are my pppd peers file (/etc/ppp/gprs):=20
/dev/rfcomm0 57600=20
connect '/usr/sbin/chat -v -f /etc/ppp/chat-gprs'
noauth
defaultroute
debug

and here's my chat script (/etc/ppp/chat-gprs): TIMEOUT         5
ECHO            ON
ABORT           '\nBUSY\r'
ABORT           '\nERROR\r'
ABORT           '\nNO ANSWER\r'
ABORT           '\nNO CARRIER\r'
ABORT           '\nNO DIALTONE\r'
ABORT           '\nRINGING\r\n\r\nRINGING\r'
''              \rAT
TIMEOUT         12
OK              ATE1
OK              'AT+cgdcont=3D1,"IP","internet.wind"'
OK              ATD*99***1#
How can I solve this problem? Thanks Julianino


------=_NextPart_000_0032_01C3F67B.362C7780
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: Quoted-Printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Diso-8859-1">
<META content=3D"MSHTML 5.50.4134.100" name=3DGENERATOR>
<STYLE></STYLE>
</HEAD>
<BODY bgColor=3D#ffffff>
<DIV><FONT face=3DArial size=3D2>
<DIV><FONT face=3DArial size=3D2>Hi to all,</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>I want to use a Nokia 3650 as a modem. =
I have=20
written the pppd peers file and the chat script, but when&nbsp;I try the =

connection using pppd call gprs there isn't any result.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>These are my pppd peers file =
(/etc/ppp/gprs):=20
</FONT></DIV>
<DIV><PRE><FONT face=3DArial size=3D2>/dev/rfcomm0 57600=20
connect '/usr/sbin/chat -v -f /etc/ppp/chat-gprs'
noauth
defaultroute
debug
</FONT></PRE><PRE><FONT face=3DArial size=3D2>and here's my chat script =
(/etc/ppp/chat-gprs): </FONT><PRE><FONT face=3DArial size=3D2>TIMEOUT    =
     5
ECHO            ON
ABORT           '\nBUSY\r'
ABORT           '\nERROR\r'
ABORT           '\nNO ANSWER\r'
ABORT           '\nNO CARRIER\r'
ABORT           '\nNO DIALTONE\r'
ABORT           '\nRINGING\r\n\r\nRINGING\r'
''              \rAT
TIMEOUT         12
OK              ATE1
OK              'AT+cgdcont=3D1,"IP","internet.wind"'
OK              ATD*99***1#
</FONT></PRE><PRE><FONT face=3DArial size=3D2>How can I solve this =
problem?</FONT></PRE><PRE><FONT face=3DArial =
size=3D2></FONT>&nbsp;</PRE><PRE><FONT face=3DArial =
size=3D2>Thanks</FONT></PRE><PRE><FONT face=3DArial =
size=3D2></FONT>&nbsp;</PRE><PRE><FONT face=3DArial =
size=3D2>Julianino</FONT></PRE></PRE></DIV></FONT></DIV></BODY></HTML>

------=_NextPart_000_0032_01C3F67B.362C7780--




-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
