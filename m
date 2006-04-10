Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <049f01c65cb0$0d478bf0$0300a8c0@akira>
From: "Sir Graham (Terra)" <sir__graham@terra.es>
To: <bluez-devel@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0490_01C65CC0.A0E81B80"
Subject: [Bluez-devel] Selection of Local module....
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
Date: Mon, 10 Apr 2006 17:03:02 +0200

This is a multi-part message in MIME format.

------=_NextPart_000_0490_01C65CC0.A0E81B80
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi,

I need to use two bluetooth devices in the same computer with BlueZ.

How  can I select (with socket) the device local that I like make a =
conexion?


If I make a simple conexion... Can I select what of my local modules =
(HCI0 or HCI1) makes this conexion?


#include <stdio.h>
#include <unistd.h>
#include <sys/socket.h>
#include <bluetooth/bluetooth.h>
#include <bluetooth/rfcomm.h>

int main(int argc, char **argv)
{
    struct sockaddr_rc addr =3D { 0 };
    int s, status;
    char dest[18] =3D "01:23:45:67:89:AB";

    // allocate a socket
    s =3D socket(AF_BLUETOOTH, SOCK_STREAM, BTPROTO_RFCOMM);

    // set the connection parameters (who to connect to)
    addr.rc_family =3D AF_BLUETOOTH;
    addr.rc_channel =3D (uint8_t) 1;
    str2ba( dest, &addr.rc_bdaddr );

    // connect to server
    status =3D connect(s, (struct sockaddr *)&addr, sizeof(addr));

    // send a message
    if( status =3D=3D 0 ) {
        status =3D write(s, "hello!", 6);
    }

    if( status < 0 ) perror("uh oh");

    close(s);
    return 0;
}

Can I select what of my local modules (HCI0 or HCI1) makes this =
conexion? =20

Where can I select (in the example) what local module use?  =BF=BF=BF???

Regards,
Sir Graham.





------=_NextPart_000_0490_01C65CC0.A0E81B80
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Diso-8859-1">
<META content=3D"MSHTML 6.00.2900.2802" name=3DGENERATOR>
<STYLE></STYLE>
</HEAD>
<BODY bgColor=3D#ffffff>
<DIV><FONT face=3DArial size=3D2><STRONG>Hi,</STRONG></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><STRONG></STRONG></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><STRONG>I need to use two bluetooth =
devices in the=20
same computer with BlueZ.</STRONG></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><STRONG></STRONG></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><STRONG>How&nbsp; can I select (with =
socket) the=20
device local&nbsp;that I like make a conexion?</STRONG></FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><STRONG>If I make a simple conexion... =
Can I select=20
what of my local modules (HCI0 or HCI1) makes this=20
conexion?</STRONG></FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3D"Courier New" size=3D2>#include =
&lt;stdio.h&gt;<BR>#include=20
&lt;unistd.h&gt;<BR>#include &lt;sys/socket.h&gt;<BR>#include=20
&lt;bluetooth/bluetooth.h&gt;<BR>#include =
&lt;bluetooth/rfcomm.h&gt;<BR><BR>int=20
main(int argc, char **argv)<BR>{<BR>&nbsp;&nbsp;&nbsp; struct =
sockaddr_rc addr =3D=20
{ 0 };<BR>&nbsp;&nbsp;&nbsp; int s, status;<BR>&nbsp;&nbsp;&nbsp; char =
dest[18]=20
=3D "01:23:45:67:89:AB";<BR><BR>&nbsp;&nbsp;&nbsp; // allocate a=20
socket<BR>&nbsp;&nbsp;&nbsp; s =3D socket(AF_BLUETOOTH, SOCK_STREAM,=20
BTPROTO_RFCOMM);<BR><BR>&nbsp;&nbsp;&nbsp; // set the connection =
parameters (who=20
to connect to)<BR>&nbsp;&nbsp;&nbsp; addr.rc_family =3D=20
AF_BLUETOOTH;<BR>&nbsp;&nbsp;&nbsp; addr.rc_channel =3D (uint8_t)=20
1;<BR>&nbsp;&nbsp;&nbsp; str2ba( dest, &amp;addr.rc_bdaddr=20
);<BR><BR>&nbsp;&nbsp;&nbsp; // connect to server<BR>&nbsp;&nbsp;&nbsp; =
status =3D=20
connect(s, (struct sockaddr *)&amp;addr,=20
sizeof(addr));<BR><BR>&nbsp;&nbsp;&nbsp; // send a =
message<BR>&nbsp;&nbsp;&nbsp;=20
if( status =3D=3D 0 ) {<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
status =3D=20
write(s, "hello!", 6);<BR>&nbsp;&nbsp;&nbsp; }<BR><BR>&nbsp;&nbsp;&nbsp; =
if(=20
status &lt; 0 ) perror("uh oh");<BR><BR>&nbsp;&nbsp;&nbsp;=20
close(s);<BR>&nbsp;&nbsp;&nbsp; return 0;<BR>}</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><STRONG><FONT face=3DArial size=3D2>Can I select what of my local =
modules (HCI0=20
or HCI1) makes this conexion?&nbsp; </FONT></STRONG></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial><FONT size=3D2><STRONG>Where can I select (in =
the example)=20
what local module use?&nbsp; =BF=BF=BF???</STRONG></FONT></FONT></DIV>
<DIV><FONT face=3DArial><FONT =
size=3D2><STRONG></STRONG></FONT></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial><FONT =
size=3D2><STRONG>Regards,</STRONG></FONT></FONT></DIV>
<DIV><FONT face=3DArial><FONT size=3D2><STRONG>Sir=20
Graham.</STRONG></FONT></FONT></DIV>
<DIV><FONT face=3DArial><FONT =
size=3D2><STRONG></STRONG></FONT>&nbsp;</DIV>
<DIV><FONT size=3D2></FONT><FONT size=3D2></FONT><BR></DIV></FONT>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV></BODY></HTML>

------=_NextPart_000_0490_01C65CC0.A0E81B80--



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
