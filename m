Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <BAY114-W76B9011FBF114054A59F1D7130@phx.gbl>
From: Mikael Bengtsson <micke_b.b@hotmail.com>
To: <bluez-devel@lists.sourceforge.net>
Date: Mon, 18 Jun 2007 11:54:00 +0200
MIME-Version: 1.0
Subject: [Bluez-devel] How to detect disconnected slaves?
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1501443528=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============1501443528==
Content-Type: multipart/alternative;
	boundary="_ae02be04-da5b-4c76-bfcf-a516a339d02a_"

--_ae02be04-da5b-4c76-bfcf-a516a339d02a_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


Hello!
=20
I'm developing an application in which there will be two SCO channels and t=
hree RFCOMM channels. There are sockets connected to every channel and send=
ing and receiving on the sockets are done with "read" and "write" on the so=
cket descriptors.=20
=20
If one or more several of these channels are lost, the application shall tr=
y to restart them.
=20
What is the easiest way to detect that a channel is lost?=20
=20
For an RFCOMM channel i have tried to check if the number of received bytes=
 equals 0 to determine if the channel is lost according to TCP/IP programmi=
ng, but the condition is never fulfilled. I think that I can solve the prob=
lem if the application first sends a command to the slave and then waits fo=
r an answer. If the slave doesn't answer within, say 1 second, then the con=
nection is considered lost. With one-way sending, I don't know how to check=
 if the connection is lost. Maybe som sort of "heartbeat" manner must be us=
ed?
=20
For SCO I don't have a clue.
=20
Are there any low-level functions that may be used?
=20
-Mikael=20
_________________________________________________________________
S=F6k p=E5 vilken webbsida som helst med h=F6g s=E4kerhet. Skaffa Windows L=
ive Toolbar i dag -- helt gratis!
http://toolbar.live.com=

--_ae02be04-da5b-4c76-bfcf-a516a339d02a_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<style>
P
{
margin:0px;
padding:0px
}
body
{
FONT-SIZE: 10pt;
FONT-FAMILY:Tahoma
}
</style>
</head>
<body>
Hello!<BR>
&nbsp;<BR>
I'm developing an application in which there will be two SCO channels and t=
hree RFCOMM channels. There are sockets connected to every channel and send=
ing and receiving on the sockets are done with "read" and "write" on the so=
cket descriptors. <BR>
&nbsp;<BR>
If one or more several of these channels are lost, the application shall tr=
y to restart them.<BR>
&nbsp;<BR>
What is the easiest way to detect that a channel is lost? <BR>
&nbsp;<BR>
For an RFCOMM channel i have tried to check if the number of received bytes=
 equals 0 to determine if the channel is lost according to TCP/IP programmi=
ng, but the condition is never fulfilled. I think that I can solve the prob=
lem if the application first sends a command to the slave and then waits fo=
r an answer. If the slave doesn't answer within, say 1 second, then the con=
nection is considered lost. With one-way sending, I don't know how to check=
 if the connection is lost. Maybe&nbsp;som sort of&nbsp;"heartbeat" manner =
must be used?<BR>
&nbsp;<BR>
For SCO I don't have a clue.<BR>
&nbsp;<BR>
Are there any low-level functions that may be&nbsp;used?<BR>
&nbsp;<BR>
-Mikael&nbsp;<BR><br /><hr />S=F6k p=E5 vilken webbsida som helst med h=F6g=
 s=E4kerhet. Skaffa Windows Live Toolbar i dag -- helt gratis! <a href=3D'h=
ttp://toolbar.live.com' target=3D'_new'>Testa nu!</a></body>
</html>=

--_ae02be04-da5b-4c76-bfcf-a516a339d02a_--


--===============1501443528==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--===============1501443528==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============1501443528==--
