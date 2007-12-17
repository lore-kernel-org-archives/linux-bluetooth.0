Return-Path: <cyrus@holtmann.org>
From: Sumeet VERMA <sumeet.verma@st.com>
To: "'BlueZ users'" <bluez-users@lists.sourceforge.net>
Date: Mon, 17 Dec 2007 14:40:02 +0530
Message-ID: <02ac01c8408c$9c33d1e0$832fc70a@dlh.st.com>
MIME-Version: 1.0
In-Reply-To: <2e9fc96f0701252145x71b8810tfa22948c5a9e63d8@mail.gmail.com>
Subject: Re: [Bluez-users] pin code
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1342106748=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

This is a multi-part message in MIME format.

--===============1342106748==
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_02AD_01C840BA.B5EC0DE0"

This is a multi-part message in MIME format.

------=_NextPart_000_02AD_01C840BA.B5EC0DE0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Prabhu
I have a question. I have cross compiled dbus-0.93 and flashed the image =
in my hardware platform. Now when i run dbus-daemon --system it gives me =
an error
Failed to open connection to system message bus: Failed to connect to =
socket /usr/local/var/run/dbus/system_bus_socket: No such file or =
directory

I am a bit confused here because you write that system_bus_socket is =
created when dbus-daemon is started. However in my case it is expecting =
the socket file to be present when I start dbus-daemon.

Can you please clarify how do i solve this problem?
=20

Regards,
Sumeet=20

=20

  _____ =20

From: bluez-users-bounces@lists.sourceforge.net =
[mailto:bluez-users-bounces@lists.sourceforge.net] On Behalf Of Prabhu =
nath
Sent: Friday, January 26, 2007 11:15 AM
To: BlueZ users
Subject: Re: [Bluez-users] pin code


You have to cross-compile dbus-1.0, and start dbus-daemon before =
executing hcid.=20
dbus-daemon --system
=20
While cross-compiling dbus-1.0 and bluez-utils, pass the following =
parameters for the configure script.
--localstatedir=3D/var --sysconfdir=3D/etc
=20
Once you do this, by default hcid will look for hcid.conf in =
/etc/bluetooth directory.=20
=20
=20
Warning. Take a backup of /etc/dbus-1 and /etc/bluetooth, because this =
will overwrite the previous config, which was already present in ur =
system.
=20
Run make install for dbus, and u need not run make install for =
bluez-utils. U can directly copy the hcid.conf and blue-hcid.conf to =
/etc/bluetooth and /etc/dbus-1/system.d directory respectively.
=20
Now, when u start dbus-daemon --system, it will create a =
system_bus_socket in /var/run/dbus and it will create a message.pid in =
/var/run/.=20
=20
next, when u start hcid, u should not get problem.
=20
-Prabhu
=20


=20
On 1/23/07, KS H <kspam1234@yahoo.com.hk> wrote:=20

Dear

I cross compile the bluez3.8 and try to setup the bluetooth in arm. I =
connect the arm with CSR BC03 with BCSP configuration. I am able to make =
the Bluez discoverable and try to pair bluez. however i found that there =
is no pin respond from Bluez. So i try to configure bluez using hcid.=20

> hcid -n -f /etc/bluetooth/hcid.conf

it return

hcid[481]: Can't connect to system message bus: Failed to connect to =
socket /usr/local/var/run/dbus/system_bus_socket:  No such file or =
directory=20
hcid[481]: Unable to get on D-Bus

My question
1. where can I found the missing file and what is that used for?
2. Is there any method to repsond the pin request other than using hcid

Regards
SH


_______________________________________
YM - =E9=9B=A2=E7=B7=9A=E8=A8=8A=E6=81=AF
=E5=B0=B1=E7=AE=97=E4=BD=A0=E6=B2=92=E6=9C=89=E4=B8=8A=E7=B6=B2=EF=BC=8C=E4=
=BD=A0=E7=9A=84=E6=9C=8B=E5=8F=8B=E4=BB=8D=E5=8F=AF=E4=BB=A5=E7=95=99=E4=B8=
=8B=E8=A8=8A=E6=81=AF=E7=B5=A6=E4=BD=A0=EF=BC=8C=E7=95=B6=E4=BD=A0=E4=B8=8A=
=E7=B6=B2=E6=99=82=E5=B0=B1=E8=83=BD=E7=AB=8B=E5=8D=B3=E7=9C=8B=E5=88=B0=EF=
=BC=8C=E4=BB=BB=E4=BD=95=E8=AA=AA=E8=A9=B1=E9=83=BD=E5=86=87=E8=B5=B0=E5=A4=
=B1=E3=80=82
http://messenger.yahoo.com.hk  <http://messenger.yahoo.com.hk/>=20


-------------------------------------------------------------------------=

Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share =
your=20
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=3Djoin.php =
<http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=3D=
DEVDEV> &p=3Dsourceforge&CID=3DDEVDEV

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users  =
<https://lists.sourceforge.net/lists/listinfo/bluez-users>=20






------=_NextPart_000_02AD_01C840BA.B5EC0DE0
Content-Type: text/html;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable

=EF=BB=BF<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; charset=3Dutf-8">
<META content=3D"MSHTML 6.00.2900.3199" name=3DGENERATOR></HEAD>
<BODY>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D033360409-17122007><FONT =
face=3DArial>Hi=20
Prabhu</FONT></SPAN></DIV>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D033360409-17122007><FONT =
face=3DArial>I have a=20
question. I have cross compiled dbus-0.93 and flashed the image in my =
hardware=20
platform. Now when i run dbus-daemon --system it gives me an=20
error</FONT></SPAN></DIV>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D033360409-17122007><FONT =
face=3DArial>Failed=20
to open connection to system message bus: Failed to connect to socket=20
/usr/local/var/run/dbus/system_bus_socket: No such file or=20
directory<BR></FONT></SPAN></DIV>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D033360409-17122007><FONT =
face=3DArial>I am a=20
bit confused here because you write that system_bus_socket is created =
when=20
dbus-daemon is started. However in my case it is expecting the socket =
file to be=20
present when&nbsp;I start dbus-daemon.</FONT></SPAN></DIV>
<DIV dir=3Dltr align=3Dleft><SPAN class=3D033360409-17122007><FONT =
face=3DArial><FONT=20
color=3D#0000ff size=3D2></FONT><BR>Can you please clarify how do i =
solve this=20
problem?</DIV></FONT></SPAN>
<DIV><FONT face=3DArial color=3D#0000ff size=3D2></FONT>&nbsp;</DIV><!-- =
Converted from text/plain format -->
<P><FONT size=3D2>Regards,<BR>Sumeet </FONT></P>
<DIV>&nbsp;</DIV><BR>
<DIV class=3DOutlookMessageHeader lang=3Den-us dir=3Dltr align=3Dleft>
<HR tabIndex=3D-1>
<FONT face=3DTahoma size=3D2><B>From:</B> =
bluez-users-bounces@lists.sourceforge.net=20
[mailto:bluez-users-bounces@lists.sourceforge.net] <B>On Behalf Of =
</B>Prabhu=20
nath<BR><B>Sent:</B> Friday, January 26, 2007 11:15 AM<BR><B>To:</B> =
BlueZ=20
users<BR><B>Subject:</B> Re: [Bluez-users] pin code<BR></FONT><BR></DIV>
<DIV></DIV>
<DIV>You have to cross-compile dbus-1.0, and start dbus-daemon before =
executing=20
hcid. </DIV>
<DIV>dbus-daemon --system</DIV>
<DIV>&nbsp;</DIV>
<DIV>While cross-compiling dbus-1.0 and bluez-utils, pass the following=20
parameters for the configure script.</DIV>
<DIV>--localstatedir=3D/var --sysconfdir=3D/etc</DIV>
<DIV>&nbsp;</DIV>
<DIV>Once you do this, by default hcid will look for hcid.conf in =
/etc/bluetooth=20
directory. </DIV>
<DIV>&nbsp;</DIV>
<DIV>&nbsp;</DIV>
<DIV><STRONG>Warning</STRONG>. Take a backup of /etc/dbus-1 and =
/etc/bluetooth,=20
because this will overwrite the previous config, which&nbsp;was already =
present=20
in ur system.</DIV>
<DIV>&nbsp;</DIV>
<DIV>Run make install for dbus, and u need not run make install for =
bluez-utils.=20
U can directly copy the hcid.conf and blue-hcid.conf to /etc/bluetooth =
and=20
/etc/dbus-1/system.d directory respectively.</DIV>
<DIV>&nbsp;</DIV>
<DIV>Now, when u start dbus-daemon --system, it will create a =
system_bus_socket=20
in /var/run/dbus and it will create a message.pid in /var/run/. </DIV>
<DIV>&nbsp;</DIV>
<DIV>next, when u start hcid, u should not get problem.</DIV>
<DIV>&nbsp;</DIV>
<DIV>-Prabhu</DIV>
<DIV>&nbsp;</DIV>
<DIV><BR><BR>&nbsp;</DIV>
<DIV><SPAN class=3Dgmail_quote>On 1/23/07, <B =
class=3Dgmail_sendername>KS H</B>=20
&lt;<A =
href=3D"mailto:kspam1234@yahoo.com.hk">kspam1234@yahoo.com.hk</A>&gt;=20
wrote:</SPAN>=20
<BLOCKQUOTE class=3Dgmail_quote=20
style=3D"PADDING-LEFT: 1ex; MARGIN: 0px 0px 0px 0.8ex; BORDER-LEFT: #ccc =
1px solid">Dear<BR><BR>I=20
  cross compile the bluez3.8 and try to setup the bluetooth in arm. I =
connect=20
  the arm with CSR BC03 with BCSP configuration. I am able to make the =
Bluez=20
  discoverable and try to pair bluez. however i found that there is no =
pin=20
  respond from Bluez. So i try to configure bluez using hcid. =
<BR><BR>&gt; hcid=20
  -n -f /etc/bluetooth/hcid.conf<BR><BR>it return<BR><BR>hcid[481]: =
Can't=20
  connect to system message bus: Failed to connect to socket=20
  /usr/local/var/run/dbus/system_bus_socket:&nbsp; No such file or =
directory=20
  <BR>hcid[481]: Unable to get on D-Bus<BR><BR>My question<BR>1. where =
can I=20
  found the missing file and what is that used for?<BR>2. Is there any =
method to=20
  repsond the pin request other than using =
hcid<BR><BR>Regards<BR>SH<BR><SPAN=20
  class=3Dad>
  <P>_______________________________________<BR>YM -=20
  =
=E9=9B=A2=E7=B7=9A=E8=A8=8A=E6=81=AF<BR>=E5=B0=B1=E7=AE=97=E4=BD=A0=E6=B2=
=92=E6=9C=89=E4=B8=8A=E7=B6=B2=EF=BC=8C=E4=BD=A0=E7=9A=84=E6=9C=8B=E5=8F=8B=
=E4=BB=8D=E5=8F=AF=E4=BB=A5=E7=95=99=E4=B8=8B=E8=A8=8A=E6=81=AF=E7=B5=A6=E4=
=BD=A0=EF=BC=8C=E7=95=B6=E4=BD=A0=E4=B8=8A=E7=B6=B2=E6=99=82=E5=B0=B1=E8=83=
=BD=E7=AB=8B=E5=8D=B3=E7=9C=8B=E5=88=B0=EF=BC=8C=E4=BB=BB=E4=BD=95=E8=AA=AA=
=E8=A9=B1=E9=83=BD=E5=86=87=E8=B5=B0=E5=A4=B1=E3=80=82<BR><A=20
  onclick=3D"return top.js.OpenExtLink(window,event,this)"=20
  href=3D"http://messenger.yahoo.com.hk/"=20
  target=3D_blank>http://messenger.yahoo.com.hk=20
  =
</A></P></SPAN><BR>------------------------------------------------------=
-------------------<BR>Take=20
  Surveys. Earn Cash. Influence the Future of IT<BR>Join =
SourceForge.net's=20
  Techsay panel and you'll get the chance to share your <BR>opinions on =
IT &amp;=20
  business topics through brief surveys - and earn cash<BR><A=20
  onclick=3D"return top.js.OpenExtLink(window,event,this)"=20
  =
href=3D"http://www.techsay.com/default.php?page=3Djoin.php&amp;p=3Dsource=
forge&amp;CID=3DDEVDEV"=20
  =
target=3D_blank>http://www.techsay.com/default.php?page=3Djoin.php&amp;p=3D=
sourceforge&amp;CID=3DDEVDEV</A><BR><BR>_________________________________=
______________<BR>Bluez-users=20
  mailing list<BR><A onclick=3D"return =
top.js.OpenExtLink(window,event,this)"=20
  =
href=3D"mailto:Bluez-users@lists.sourceforge.net">Bluez-users@lists.sourc=
eforge.net</A><BR><A=20
  onclick=3D"return top.js.OpenExtLink(window,event,this)"=20
  href=3D"https://lists.sourceforge.net/lists/listinfo/bluez-users"=20
  =
target=3D_blank>https://lists.sourceforge.net/lists/listinfo/bluez-users =

  </A><BR><BR><BR></BLOCKQUOTE></DIV><BR></BODY></HTML>

------=_NextPart_000_02AD_01C840BA.B5EC0DE0--



--===============1342106748==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
SF.Net email is sponsored by:
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services
for just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
--===============1342106748==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============1342106748==--
