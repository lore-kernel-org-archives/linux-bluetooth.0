Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <000c01c65ccf$d8af7180$0300a8c0@akira>
From: "Sir Graham (Terra)" <sir__graham@terra.es>
To: <bluez-devel@lists.sourceforge.net>
References: <049f01c65cb0$0d478bf0$0300a8c0@akira> <ef9938ec0604101037w5114ce37rf783fc009f75fc04@mail.gmail.com>
Subject: Re: [Bluez-devel] Selection of Local module....
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0009_01C65CE0.92412390"
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
Date: Mon, 10 Apr 2006 20:51:42 +0200

This is a multi-part message in MIME format.

------=_NextPart_000_0009_01C65CE0.92412390
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi,

Thanks for you answer....

This works when you make a server conexion.... but... When you create a =
client function works also the bind function?=20

you see the function attachment to my first message. If I put a bind =
call in this function (client connect funcion) can i select the local =
bluetooth device?=20

Regards,
Sir Graham.


  ----- Original Message -----=20
  From: Albert Huang=20
  To: bluez-devel@lists.sourceforge.net=20
  Sent: Monday, April 10, 2006 7:37 PM
  Subject: Re: [Bluez-devel] Selection of Local module....


  bind() to the address and channel of the local adapter you want to use =
before the call to connect()

  -albert


  On 4/10/06, Sir Graham (Terra) < sir__graham@terra.es> wrote:
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

    Where can I select (in the example) what local module use?  =
=BF=BF=BF???

    Regards,
    Sir Graham.







------=_NextPart_000_0009_01C65CE0.92412390
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
<DIV><FONT face=3DArial size=3D2>Hi,</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Thanks for you answer....</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>This works when you make a server =
conexion....=20
but... When you create&nbsp;a</FONT><FONT face=3DArial size=3D2> client =
function=20
works also the bind function? </FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>you see the function attachment to my =
first=20
message. If I&nbsp;put a&nbsp;bind call&nbsp;in this function (client =
connect=20
funcion)&nbsp;can i select the local bluetooth =
device?&nbsp;</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Regards,</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>Sir Graham.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<BLOCKQUOTE=20
style=3D"PADDING-RIGHT: 0px; PADDING-LEFT: 5px; MARGIN-LEFT: 5px; =
BORDER-LEFT: #000000 2px solid; MARGIN-RIGHT: 0px">
  <DIV style=3D"FONT: 10pt arial">----- Original Message ----- </DIV>
  <DIV=20
  style=3D"BACKGROUND: #e4e4e4; FONT: 10pt arial; font-color: =
black"><B>From:</B>=20
  <A title=3Dashuang@gmail.com href=3D"mailto:ashuang@gmail.com">Albert =
Huang</A>=20
  </DIV>
  <DIV style=3D"FONT: 10pt arial"><B>To:</B> <A=20
  title=3Dbluez-devel@lists.sourceforge.net=20
  =
href=3D"mailto:bluez-devel@lists.sourceforge.net">bluez-devel@lists.sourc=
eforge.net</A>=20
  </DIV>
  <DIV style=3D"FONT: 10pt arial"><B>Sent:</B> Monday, April 10, 2006 =
7:37=20
PM</DIV>
  <DIV style=3D"FONT: 10pt arial"><B>Subject:</B> Re: [Bluez-devel] =
Selection of=20
  Local module....</DIV>
  <DIV><BR></DIV>bind() to the address and channel of the local adapter =
you want=20
  to use before the call to connect()<BR><BR>-albert<BR><BR>
  <DIV><SPAN class=3Dgmail_quote>On 4/10/06, <B =
class=3Dgmail_sendername>Sir Graham=20
  (Terra)</B> &lt;<A href=3D"mailto:sir__graham@terra.es">=20
  sir__graham@terra.es</A>&gt; wrote:</SPAN>
  <BLOCKQUOTE class=3Dgmail_quote=20
  style=3D"PADDING-LEFT: 1ex; MARGIN: 0pt 0pt 0pt 0.8ex; BORDER-LEFT: =
rgb(204,204,204) 1px solid">
    <DIV style=3D"DIRECTION: ltr">
    <DIV><FONT face=3DArial size=3D2><STRONG>Hi,</STRONG></FONT></DIV>
    <DIV><FONT face=3DArial =
size=3D2><STRONG></STRONG></FONT>&nbsp;</DIV>
    <DIV><FONT face=3DArial size=3D2><STRONG>I need to use two bluetooth =
devices in=20
    the same computer with BlueZ.</STRONG></FONT></DIV>
    <DIV><FONT face=3DArial =
size=3D2><STRONG></STRONG></FONT>&nbsp;</DIV>
    <DIV><FONT face=3DArial size=3D2><STRONG>How&nbsp; can I select =
(with socket)=20
    the device local&nbsp;that I like make a =
conexion?</STRONG></FONT></DIV>
    <DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
    <DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
    <DIV><FONT face=3DArial size=3D2><STRONG>If I make a simple =
conexion... Can I=20
    select what of my local modules (HCI0 or HCI1) makes this=20
    conexion?</STRONG></FONT></DIV>
    <DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
    <DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
    <DIV><FONT face=3D"Courier New" size=3D2>#include =
&lt;stdio.h&gt;<BR>#include=20
    &lt;unistd.h&gt;<BR>#include &lt;sys/socket.h&gt;<BR>#include=20
    &lt;bluetooth/bluetooth.h&gt;<BR>#include=20
    &lt;bluetooth/rfcomm.h&gt;<BR><BR>int main(int argc, char=20
    **argv)<BR>{<BR>&nbsp;&nbsp;&nbsp; struct sockaddr_rc addr =3D { 0=20
    };<BR>&nbsp;&nbsp;&nbsp; int s, status;<BR>&nbsp;&nbsp;&nbsp; char =
dest[18]=20
    =3D "01:23:45:67:89:AB";<BR><BR>&nbsp;&nbsp;&nbsp; // allocate a=20
    socket<BR>&nbsp;&nbsp;&nbsp; s =3D socket(AF_BLUETOOTH, SOCK_STREAM, =

    BTPROTO_RFCOMM);<BR><BR>&nbsp;&nbsp;&nbsp; // set the connection =
parameters=20
    (who to connect to)<BR>&nbsp;&nbsp;&nbsp; addr.rc_family =3D=20
    AF_BLUETOOTH;<BR>&nbsp;&nbsp;&nbsp; addr.rc_channel =3D (uint8_t)=20
    1;<BR>&nbsp;&nbsp;&nbsp; str2ba( dest, &amp;addr.rc_bdaddr=20
    );<BR><BR>&nbsp;&nbsp;&nbsp; // connect to =
server<BR>&nbsp;&nbsp;&nbsp;=20
    status =3D connect(s, (struct sockaddr *)&amp;addr,=20
    sizeof(addr));<BR><BR>&nbsp;&nbsp;&nbsp; // send a=20
    message<BR>&nbsp;&nbsp;&nbsp; if( status =3D=3D 0 )=20
    {<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; status =3D write(s, =
"hello!",=20
    6);<BR>&nbsp;&nbsp;&nbsp; }<BR><BR>&nbsp;&nbsp;&nbsp; if( status =
&lt; 0 )=20
    perror("uh oh");<BR><BR>&nbsp;&nbsp;&nbsp; =
close(s);<BR>&nbsp;&nbsp;&nbsp;=20
    return 0;<BR>}</FONT></DIV>
    <DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
    <DIV><STRONG><FONT face=3DArial size=3D2>Can I select what of my =
local modules=20
    (HCI0 or HCI1) makes this conexion?&nbsp; </FONT></STRONG></DIV>
    <DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
    <DIV><FONT face=3DArial><FONT size=3D2><STRONG>Where can I select =
(in the=20
    example) what local module use?&nbsp; =
=BF=BF=BF???</STRONG></FONT></FONT></DIV>
    <DIV><FONT face=3DArial><FONT=20
    size=3D2><STRONG></STRONG></FONT></FONT>&nbsp;</DIV>
    <DIV><FONT face=3DArial><FONT=20
    size=3D2><STRONG>Regards,</STRONG></FONT></FONT></DIV></DIV>
    <DIV style=3D"DIRECTION: ltr"><SPAN class=3Dsg>
    <DIV><FONT face=3DArial><FONT size=3D2><STRONG>Sir=20
    Graham.</STRONG></FONT></FONT></DIV>
    <DIV><FONT face=3DArial><FONT=20
    size=3D2><STRONG></STRONG></FONT></FONT>&nbsp;</DIV>
    <DIV><FONT size=3D2></FONT><FONT size=3D2></FONT><BR></DIV>
    <DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
    <DIV><FONT face=3DArial=20
  =
size=3D2></FONT>&nbsp;</DIV></SPAN></DIV></BLOCKQUOTE></DIV><BR></BLOCKQU=
OTE></BODY></HTML>

------=_NextPart_000_0009_01C65CE0.92412390--



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
