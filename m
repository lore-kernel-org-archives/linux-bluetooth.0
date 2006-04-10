Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <ef9938ec0604101037w5114ce37rf783fc009f75fc04@mail.gmail.com>
From: "Albert Huang" <ashuang@gmail.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Selection of Local module....
In-Reply-To: <049f01c65cb0$0d478bf0$0300a8c0@akira>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_3380_11677985.1144690677709"
References: <049f01c65cb0$0d478bf0$0300a8c0@akira>
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
Date: Mon, 10 Apr 2006 13:37:57 -0400

------=_Part_3380_11677985.1144690677709
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

bind() to the address and channel of the local adapter you want to use
before the call to connect()

-albert

On 4/10/06, Sir Graham (Terra) <sir__graham@terra.es> wrote:
>
> *Hi,*
> **
> *I need to use two bluetooth devices in the same computer with BlueZ.*
> **
> *How  can I select (with socket) the device local that I like make a
> conexion?*
>
>
> *If I make a simple conexion... Can I select what of my local modules
> (HCI0 or HCI1) makes this conexion?*
>
>
> #include <stdio.h>
> #include <unistd.h>
> #include <sys/socket.h>
> #include <bluetooth/bluetooth.h>
> #include <bluetooth/rfcomm.h>
>
> int main(int argc, char **argv)
> {
>     struct sockaddr_rc addr =3D { 0 };
>     int s, status;
>     char dest[18] =3D "01:23:45:67:89:AB";
>
>     // allocate a socket
>     s =3D socket(AF_BLUETOOTH, SOCK_STREAM, BTPROTO_RFCOMM);
>
>     // set the connection parameters (who to connect to)
>     addr.rc_family =3D AF_BLUETOOTH;
>     addr.rc_channel =3D (uint8_t) 1;
>     str2ba( dest, &addr.rc_bdaddr );
>
>     // connect to server
>     status =3D connect(s, (struct sockaddr *)&addr, sizeof(addr));
>
>     // send a message
>     if( status =3D=3D 0 ) {
>         status =3D write(s, "hello!", 6);
>     }
>
>     if( status < 0 ) perror("uh oh");
>
>     close(s);
>     return 0;
> }
>
> *Can I select what of my local modules (HCI0 or HCI1) makes this
> conexion?  *
>
> *Where can I select (in the example) what local module use?  =BF=BF=BF???=
*
> **
> *Regards,*
> *Sir Graham.*
> **
>
>
>
>

------=_Part_3380_11677985.1144690677709
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

bind() to the address and channel of the local adapter you want to use befo=
re the call to connect()<br><br>-albert<br><br><div><span class=3D"gmail_qu=
ote">On 4/10/06, <b class=3D"gmail_sendername">Sir Graham (Terra)</b> &lt;<=
a href=3D"mailto:sir__graham@terra.es">
sir__graham@terra.es</a>&gt; wrote:</span><blockquote class=3D"gmail_quote"=
 style=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.=
8ex; padding-left: 1ex;"><div style=3D"direction: ltr;">






<div><font face=3D"Arial" size=3D"2"><strong>Hi,</strong></font></div>
<div><font face=3D"Arial" size=3D"2"><strong></strong></font>&nbsp;</div>
<div><font face=3D"Arial" size=3D"2"><strong>I need to use two bluetooth de=
vices in the=20
same computer with BlueZ.</strong></font></div>
<div><font face=3D"Arial" size=3D"2"><strong></strong></font>&nbsp;</div>
<div><font face=3D"Arial" size=3D"2"><strong>How&nbsp; can I select (with s=
ocket) the=20
device local&nbsp;that I like make a conexion?</strong></font></div>
<div><font face=3D"Arial" size=3D"2"></font>&nbsp;</div>
<div><font face=3D"Arial" size=3D"2"></font>&nbsp;</div>
<div><font face=3D"Arial" size=3D"2"><strong>If I make a simple conexion...=
 Can I select=20
what of my local modules (HCI0 or HCI1) makes this=20
conexion?</strong></font></div>
<div><font face=3D"Arial" size=3D"2"></font>&nbsp;</div>
<div><font face=3D"Arial" size=3D"2"></font>&nbsp;</div>
<div><font face=3D"Courier New" size=3D"2">#include &lt;stdio.h&gt;<br>#inc=
lude=20
&lt;unistd.h&gt;<br>#include &lt;sys/socket.h&gt;<br>#include=20
&lt;bluetooth/bluetooth.h&gt;<br>#include &lt;bluetooth/rfcomm.h&gt;<br><br=
>int=20
main(int argc, char **argv)<br>{<br>&nbsp;&nbsp;&nbsp; struct sockaddr_rc a=
ddr =3D=20
{ 0 };<br>&nbsp;&nbsp;&nbsp; int s, status;<br>&nbsp;&nbsp;&nbsp; char dest=
[18]=20
=3D &quot;01:23:45:67:89:AB&quot;;<br><br>&nbsp;&nbsp;&nbsp; // allocate a=
=20
socket<br>&nbsp;&nbsp;&nbsp; s =3D socket(AF_BLUETOOTH, SOCK_STREAM,=20
BTPROTO_RFCOMM);<br><br>&nbsp;&nbsp;&nbsp; // set the connection parameters=
 (who=20
to connect to)<br>&nbsp;&nbsp;&nbsp; addr.rc_family =3D=20
AF_BLUETOOTH;<br>&nbsp;&nbsp;&nbsp; addr.rc_channel =3D (uint8_t)=20
1;<br>&nbsp;&nbsp;&nbsp; str2ba( dest, &amp;addr.rc_bdaddr=20
);<br><br>&nbsp;&nbsp;&nbsp; // connect to server<br>&nbsp;&nbsp;&nbsp; sta=
tus =3D=20
connect(s, (struct sockaddr *)&amp;addr,=20
sizeof(addr));<br><br>&nbsp;&nbsp;&nbsp; // send a message<br>&nbsp;&nbsp;&=
nbsp;=20
if( status =3D=3D 0 ) {<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; statu=
s =3D=20
write(s, &quot;hello!&quot;, 6);<br>&nbsp;&nbsp;&nbsp; }<br><br>&nbsp;&nbsp=
;&nbsp; if(=20
status &lt; 0 ) perror(&quot;uh oh&quot;);<br><br>&nbsp;&nbsp;&nbsp;=20
close(s);<br>&nbsp;&nbsp;&nbsp; return 0;<br>}</font></div>
<div><font face=3D"Arial" size=3D"2"></font>&nbsp;</div>
<div><strong><font face=3D"Arial" size=3D"2">Can I select what of my local =
modules (HCI0=20
or HCI1) makes this conexion?&nbsp; </font></strong></div>
<div><font face=3D"Arial" size=3D"2"></font>&nbsp;</div>
<div><font face=3D"Arial"><font size=3D"2"><strong>Where can I select (in t=
he example)=20
what local module use?&nbsp; =BF=BF=BF???</strong></font></font></div>
<div><font face=3D"Arial"><font size=3D"2"><strong></strong></font></font>&=
nbsp;</div>
<div><font face=3D"Arial"><font size=3D"2"><strong>Regards,</strong></font>=
</font></div></div><div style=3D"direction: ltr;"><span class=3D"sg">
<div><font face=3D"Arial"><font size=3D"2"><strong>Sir=20
Graham.</strong></font></font></div>
<div><font face=3D"Arial"><font size=3D"2"><strong></strong></font>&nbsp;</=
font></div>
<div><font size=3D"2"></font><font size=3D"2"></font><br></div>
<div><font face=3D"Arial" size=3D"2"></font>&nbsp;</div>
<div><font face=3D"Arial" size=3D"2"></font>&nbsp;</div>

</span></div></blockquote></div><br>

------=_Part_3380_11677985.1144690677709--


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
