Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <3f5a9ba20610090238w6b3686ffw1a851a4c711bdc3e@mail.gmail.com>
Date: Mon, 9 Oct 2006 17:38:05 +0800
From: "Mingfan.Lu" <lucharse@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <20061009090450.GI28087@suse.de>
MIME-Version: 1.0
References: <3f5a9ba20609291930r5b4e4c97g8b33901666fef491@mail.gmail.com>
	<3f5a9ba20610020946v10c99300pee5cc04f3f2597e6@mail.gmail.com>
	<1159972670.1601.25.camel@localhost>
	<3f5a9ba20610072313w41cb4aa1qf0b5a21a7199f737@mail.gmail.com>
	<1160314144.4258.8.camel@aeonflux.holtmann.net>
	<3f5a9ba20610081957id1408a8m6f1648b8fae14e79@mail.gmail.com>
	<20061009090450.GI28087@suse.de>
Subject: Re: [Bluez-devel] About the kernel 2.6.18
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0302512463=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============0302512463==
Content-Type: multipart/alternative;
	boundary="----=_Part_170595_32770185.1160386685930"

------=_Part_170595_32770185.1160386685930
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Because Vmware I used, so I don't think it will make effect to the result.

2006/10/9, Stefan Seyfried <seife@suse.de>:
>
> On Mon, Oct 09, 2006 at 10:57:53AM +0800, Mingfan.Lu wrote:
> > Hi,
> > I am just use the Bluetooth OBEX Object Push client (0.99 beta1).
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > Host:
> > Vmware 5.5
> > OS: Suse 10.1
> > bluetooth dongle: 1.2
> > File pushed: testpkg whose size is 137956B
> >
> > Target:
> >  Nokia E61
> >
> >  kernel version: 2.6.16.13-4 (built from Suse 10.1) about 11-12s
> kernel
> > version: 2.6.16.13-4 (rebuilt from above) about 11-12s
> >  kernel version: 2.6.17 (built from kernel.org)  about 11-12s
> >  kernel version: 2.6.18: about  145s
> >  kernel version: 2.6.18 with mh4 (built with the patch from bluez):
> 143s
> > 146s
>
> This means that ~1000bytes/second are transferred. I am using 2.6.18 with
> ppp-via-rfcomm and it does get me at least 45kB/second (3G/UMTS speed),
> with
> a sony-ericsson k600i as target, so there are configurations where it
> still
> works fine.
>
> > Too terrible!!!
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > using other RFCOMM applications, 2.6.18 is slower too.
>
> Well, apparentely not everywhere and not for everybody.
> --
> Stefan Seyfried                     | "Please, just tell people
> QA / R&D Team Mobile Devices        |               to use KDE."
> SUSE LINUX Products GmbH, N=FCrnberg  |          -- Linus Torvalds
>
> -------------------------------------------------------------------------
> Take Surveys. Earn Cash. Influence the Future of IT
> Join SourceForge.net's Techsay panel and you'll get the chance to share
> your
> opinions on IT & business topics through brief surveys -- and earn cash
> http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=3D=
DEVDEV
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>



--=20
With respects,
   Mingfan.Lu

------=_Part_170595_32770185.1160386685930
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<div>Because Vmware I used, so I don't think it will make effect to the res=
ult.</div>
<div>&nbsp;</div>
<div><span class=3D"gmail_quote">2006/10/9, Stefan Seyfried &lt;<a href=3D"=
mailto:seife@suse.de">seife@suse.de</a>&gt;:</span>
<blockquote class=3D"gmail_quote" style=3D"PADDING-LEFT: 1ex; MARGIN: 0px 0=
px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">On Mon, Oct 09, 2006 at 10:57:53=
AM +0800, Mingfan.Lu wrote:<br>&gt; Hi,<br>&gt; I am just use the Bluetooth=
 OBEX Object Push client (
0.99 beta1).<br>&gt; =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>&gt; Host:<br>&gt=
; Vmware 5.5<br>&gt; OS: Suse 10.1<br>&gt; bluetooth dongle: 1.2<br>&gt; Fi=
le pushed: testpkg whose size is 137956B<br>&gt;<br>&gt; Target:<br>
&gt;&nbsp;&nbsp;Nokia E61<br>&gt;<br>&gt;&nbsp;&nbsp;kernel version: 2.6.16=
.13-4 (built from Suse 10.1) about 11-12s&nbsp;&nbsp; kernel<br>&gt; versio=
n: 2.6.16.13-4 (rebuilt from above) about 11-12s<br>&gt;&nbsp;&nbsp;kernel =
version: 2.6.17 (built from <a href=3D"http://kernel.org">
kernel.org</a>)&nbsp;&nbsp;about 11-12s<br>&gt;&nbsp;&nbsp;kernel version: =
2.6.18: about&nbsp;&nbsp;145s<br>&gt;&nbsp;&nbsp;kernel version: 2.6.18 wit=
h mh4 (built with the patch from bluez):&nbsp;&nbsp; 143s<br>&gt; 146s<br><=
br>This means that ~1000bytes/second are transferred. I am using=20
2.6.18 with<br>ppp-via-rfcomm and it does get me at least 45kB/second (3G/U=
MTS speed), with<br>a sony-ericsson k600i as target, so there are configura=
tions where it still<br>works fine.<br><br>&gt; Too terrible!!!<br>&gt; =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
<br>&gt;<br>&gt; using other RFCOMM applications, 2.6.18 is slower too.<br>=
<br>Well, apparentely not everywhere and not for everybody.<br>--<br>Stefan=
 Seyfried&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | &quot;Please, just=
 tell people<br>QA / R&amp;D Team Mobile Devices&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; to use KDE.&quot;
<br>SUSE LINUX Products GmbH, N=FCrnberg&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;-- Linus Torvalds<br><br>------------=
-------------------------------------------------------------<br>Take Surve=
ys. Earn Cash. Influence the Future of IT<br>Join SourceForge.net
's Techsay panel and you'll get the chance to share your<br>opinions on IT =
&amp; business topics through brief surveys -- and earn cash<br><a href=3D"=
http://www.techsay.com/default.php?page=3Djoin.php&amp;p=3Dsourceforge&amp;=
CID=3DDEVDEV">
http://www.techsay.com/default.php?page=3Djoin.php&amp;p=3Dsourceforge&amp;=
CID=3DDEVDEV</a><br>_______________________________________________<br>Blue=
z-devel mailing list<br><a href=3D"mailto:Bluez-devel@lists.sourceforge.net=
">Bluez-devel@lists.sourceforge.net
</a><br><a href=3D"https://lists.sourceforge.net/lists/listinfo/bluez-devel=
">https://lists.sourceforge.net/lists/listinfo/bluez-devel</a><br></blockqu=
ote></div><br><br clear=3D"all"><br>-- <br>With respects,<br>&nbsp;&nbsp; M=
ingfan.Lu=20

------=_Part_170595_32770185.1160386685930--


--===============0302512463==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============0302512463==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============0302512463==--
