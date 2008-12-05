Return-Path: <cyrus@holtmann.org>
Message-ID: <BAY127-W1206CF6F607105AA558C2DA8FE0@phx.gbl>
From: Evgenios Metaxas <eumetaxas@hotmail.com>
To: <bluez-devel@lists.sourceforge.net>
Date: Fri, 5 Dec 2008 17:10:24 +0000
In-Reply-To: <e343e5940812050154i52fb8eb3x46cf6e73e5a0c8f9@mail.gmail.com>
References: <COL102-W12443FB0254944C58D2F2FA8020@phx.gbl>
	<e343e5940812050154i52fb8eb3x46cf6e73e5a0c8f9@mail.gmail.com>
MIME-Version: 1.0
Subject: Re: [Bluez-devel] MA-720 does not work
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============4635183682805801930=="
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============4635183682805801930==
Content-Type: multipart/alternative;
	boundary="_0bee9784-f912-407c-b74e-6474f766012b_"

--_0bee9784-f912-407c-b74e-6474f766012b_
Content-Type: text/plain; charset="koi8-r"
Content-Transfer-Encoding: quoted-printable


Thank you for your answer=2C

modprobe hci_usb gives no error=2C but=20

modprobe  vendor=3D0df7 or modprobe product=3D0722
gives=20

FATAL: Module vendor=3D0df7 not found

Regards
 Eugenios

Date: Fri=2C 5 Dec 2008 12:54:35 +0300
From: vikulov@jami.ru
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] MA-720 does not work

Hello=2C

try this

 modprobe hci_usb vendor=3D0df7 product=3D0722

or something like that


2008/12/4 Evgenios Metaxas <eumetaxas@hotmail.com>






Hello=2C

I have a MA720 mobile action bluetooth usb tongle that does not work under =
ubuntu 7.04-8.10 and OpenSuse.
I have tried different how-to but none worked.
Googling around found that many had problems with that dongle. MA700 is sup=
ported but not MA720.

I also found that post=20
http://thread.gmane.org/gmane.linux.bluez.devel/13515

my lsusb is=20
Bus 002 Device 004: ID 0df7:0722 Mobile Action Technology=2C Inc.=20


dmesg=20

[ 4634.001887] usb 2-2: new low speed USB device using uhci_hcd and address=
 4
[ 4634.184129] usb 2-2: configuration #1 chosen from 1 choice

and=20

/proc/bus/usb/devices
bash: /proc/bus/usb/devices: No such file or directory


Currently i am in Ubuntu 8.04=2C all updates done=2C compaq nx9010 laptop.
Other usb tongles that i have tested worked=20

Thanx

Metaxas Eugenios



Connect to the next generation of MSN Messenger   Get it now!=20


-------------------------------------------------------------------------

This SF.Net email is sponsored by the Moblin Your Move Developer's challeng=
e

Build the coolest Linux based applications with Moblin SDK & win great priz=
es

Grand prize is a trip for two to an Open Source event anywhere in the world

http://moblin-contest.org/redirect.php?banner_id=3D100&url=3D/
_______________________________________________

Bluez-devel mailing list

Bluez-devel@lists.sourceforge.net

https://lists.sourceforge.net/lists/listinfo/bluez-devel




--=20
              =F3 =D5=D7=C1=D6=C5=CE=C9=C5=CD=2C

             =E0=D2=C9=CA =F7=C9=CB=D5=CC=CF=D7

      =F7=C5=C4=D5=DD=C9=CA =D0=D2=CF=C7=D2=C1=CD=CD=C9=D3=D4

  =F7=CB=D5=D3=CE=D9=C5 =CD=CF=C2=C9=CC=D8=CE=D9=C5 =D3=C5=D2=D7=C9=D3=D9

=EF=C6=C9=D3:                 +7 (495) 780-9238


=ED=CF=C2=C9=CC=D8=CE=D9=CA:        +7 (916) 194 2711

 vikulov@jami.ru    |    www.jami.ru

               logo-jami-small

_________________________________________________________________
News=2C entertainment and everything you care about at Live.com. Get it now=
!
http://www.live.com/getstarted.aspx=

--_0bee9784-f912-407c-b74e-6474f766012b_
Content-Type: text/html; charset="koi8-r"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<style>
.hmmessage P
{
margin:0px=3B
padding:0px
}
body.hmmessage
{
font-size: 10pt=3B
font-family:Verdana
}
</style>
</head>
<body class=3D'hmmessage'>
Thank you for your answer=2C<br><em><br>modprobe</em> hci_usb gives no erro=
r=2C but <br><br><em>modprobe</em>&nbsp=3B <em>vendor</em>=3D0df7 or <em>mo=
dprobe </em>product=3D0722<br>gives <br><br>FATAL: Module vendor=3D0df7 not=
 found<br><br>Regards<br>&nbsp=3BEugenios<br><br>Date: Fri=2C 5 Dec 2008 12=
:54:35 +0300<br>From: vikulov@jami.ru<br>To: bluez-devel@lists.sourceforge.=
net<br>Subject: Re: [Bluez-devel] MA-720 does not work<br><br>Hello=2C<br><=
br>try this<br><br> <em>modprobe</em> hci_usb <em>vendor</em>=3D0df7 produc=
t=3D0722<br><br>or something like that<br><br><br><div class=3D"EC_gmail_qu=
ote">2008/12/4 Evgenios Metaxas <span dir=3D"ltr">&lt=3B<a href=3D"mailto:e=
umetaxas@hotmail.com">eumetaxas@hotmail.com</a>&gt=3B</span><br>
<blockquote class=3D"EC_gmail_quote" style=3D"padding-left: 1ex=3B">



<div>
Hello=2C<br><br>I have a MA720 mobile action bluetooth usb tongle that does=
 not work under ubuntu 7.04-8.10 and OpenSuse.<br>I have tried different ho=
w-to but none worked.<br>Googling around found that many had problems with =
that dongle. MA700 is supported but not MA720.<br>
I also found that post <br><a href=3D"http://thread.gmane.org/gmane.linux.b=
luez.devel/13515">http://thread.gmane.org/gmane.linux.bluez.devel/13515</a>=
<br><br>my lsusb is <br>Bus 002 Device 004: ID 0df7:0722 Mobile Action Tech=
nology=2C Inc. <br>
<br>dmesg <br><br>[ 4634.001887] usb 2-2: new low speed USB device using uh=
ci_hcd and address 4<br>[ 4634.184129] usb 2-2: configuration #1 chosen fro=
m 1 choice<br><br>and <br><br>/proc/bus/usb/devices<br>bash: /proc/bus/usb/=
devices: No such file or directory<br>
<br>Currently i am in Ubuntu 8.04=2C all updates done=2C compaq nx9010 lapt=
op.<br>Other usb tongles that i have tested worked <br><br>Thanx<br><br>Met=
axas Eugenios<br><div class=3D"EC_WgoR0d"><br><br><br><hr>Connect to the ne=
xt generation of MSN Messenger&nbsp=3B  <a href=3D"http://imagine-msn.com/m=
essenger/launch80/default.aspx?locale=3Den-us&amp=3Bsource=3Dwlmailtagline"=
>Get it now! </a></div>
</div>
<br>-----------------------------------------------------------------------=
--<br>
This SF.Net email is sponsored by the Moblin Your Move Developer's challeng=
e<br>
Build the coolest Linux based applications with Moblin SDK &amp=3B win grea=
t prizes<br>
Grand prize is a trip for two to an Open Source event anywhere in the world=
<br>
<a href=3D"http://moblin-contest.org/redirect.php?banner_id=3D100&amp=3Burl=
=3D/">http://moblin-contest.org/redirect.php?banner_id=3D100&amp=3Burl=3D/<=
/a><br>_______________________________________________<br>
Bluez-devel mailing list<br>
<a href=3D"mailto:Bluez-devel@lists.sourceforge.net">Bluez-devel@lists.sour=
ceforge.net</a><br>
<a href=3D"https://lists.sourceforge.net/lists/listinfo/bluez-devel">https:=
//lists.sourceforge.net/lists/listinfo/bluez-devel</a><br>
<br></blockquote></div><br><br clear=3D"all"><br>-- <br> &nbsp=3B &nbsp=3B =
&nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B=F3 =D5=D7=C1=D6=C5=CE=C9=C5=CD=
=2C<br><br> &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B =E0=D2=C9=
=CA =F7=C9=CB=D5=CC=CF=D7<br><br> &nbsp=3B &nbsp=3B &nbsp=3B=F7=C5=C4=D5=DD=
=C9=CA =D0=D2=CF=C7=D2=C1=CD=CD=C9=D3=D4<br><br> &nbsp=3B=F7=CB=D5=D3=CE=D9=
=C5 =CD=CF=C2=C9=CC=D8=CE=D9=C5 =D3=C5=D2=D7=C9=D3=D9<br><br>=EF=C6=C9=D3: =
&nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B +7 =
(495) 780-9238<br>
<br>=ED=CF=C2=C9=CC=D8=CE=D9=CA: &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B+7 (916=
) 194 2711<br><br> <a href=3D"mailto:vikulov@jami.ru">vikulov@jami.ru</a> &=
nbsp=3B &nbsp=3B| &nbsp=3B &nbsp=3B<a href=3D"http://www.jami.ru">www.jami.=
ru</a><br><br> &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=
=3B logo-jami-small<br><br /><hr />Get news=2C entertainment and everything=
 you care about at Live.com. <a href=3D'http://www.live.com/getstarted.aspx=
 ' target=3D'_new'>Check it out!</a></body>
</html>=

--_0bee9784-f912-407c-b74e-6474f766012b_--


--===============4635183682805801930==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
SF.Net email is Sponsored by MIX09, March 18-20, 2009 in Las Vegas, Nevada.
The future of the web can't happen without you.  Join us at MIX09 to help
pave the way to the Next Web now. Learn more and register at
http://ad.doubleclick.net/clk;208669438;13503038;i?http://2009.visitmix.com/
--===============4635183682805801930==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============4635183682805801930==--
