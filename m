Return-Path: <cyrus@holtmann.org>
Message-ID: <359782e70801030757p3d63598en5c577e9134dd7476@mail.gmail.com>
Date: Thu, 3 Jan 2008 23:57:57 +0800
From: "bsd user" <oldmoonster@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <477CF705.1090006@kameleon-media.com>
MIME-Version: 1.0
References: <d89ddf300801021040o28e16943t2c51ac0190bd4e91@mail.gmail.com>
	<E21A90CDB9591542899EFC7FB4ED5CC90776A695@tfmail02.TFMAIL.COM>
	<359782e70801030510p5abedbe4m6d7e129d8a5b0692@mail.gmail.com>
	<477CF705.1090006@kameleon-media.com>
Subject: Re: [Bluez-users] slave - slave talk in a piconet
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1418059683=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============1418059683==
Content-Type: multipart/alternative;
	boundary="----=_Part_25681_21807848.1199375877879"

------=_Part_25681_21807848.1199375877879
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Thanks for your explanation, I know there are many profiles in bluetooth,
but, is PAN the only profile that provide ad-hoc connection in a piconet?

Thanks.

On Jan 3, 2008 10:53 PM, Laurent BARBIER <lbarbier@kameleon-media.com>
wrote:

> When you wan't to make B talk to C all need to be forward from and to A.
> Something like brctl do the job quite sufficiently.
> Have a look there : http://bluez.sourceforge.net/contrib/HOWTO-PAN
> section "Ethernet Bridging"
>
> Laurent
>
> bsd user a =E9crit :
> > So, B or C has no knowledge about each other when they are slaves of
> > master A, right? Then, can I say if B want to talk with C, they need
> > higher level protocol support, such as telnet, ftp. And, all data
> > exchange will be forwarded by Master A. right?
> >
> > Thanks!
> >
> > On Jan 3, 2008 9:07 AM, guoyun <guoyun@techfaith.cn
> > <mailto:guoyun@techfaith.cn>> wrote:
> >
> >     Hi, Brad
> >
> >     > hey
> >     >
> >     > > If there is a piconet that has 2 slave B,C, the master is A.
> >     Does B
> >     > > know the existence of C? can B talk to C directly without
> >     > A(master)'s intervention?
> >     >
> >     > if they did talk to each other directly, one would have to be
> >     > master and you'd have a scatternet.
> >
> >     one bluetooth could be in two or more piconet, but it just can
> >     play as slave _not_ master for the bluetooth clock.
> >
> >     Please refer to Core SPEC. chapter 4.1. Piconet topology.
> >
> >     BRs
> >     Yun
> >
> >
> >
> -------------------------------------------------------------------------
> >     This SF.net email is sponsored by: Microsoft
> >     Defy all challenges. Microsoft(R) Visual Studio 2005.
> >     http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
> >     _______________________________________________
> >     Bluez-users mailing list
> >     Bluez-users@lists.sourceforge.net
> >     <mailto:Bluez-users@lists.sourceforge.net>
> >     https://lists.sourceforge.net/lists/listinfo/bluez-users
> >     <https://lists.sourceforge.net/lists/listinfo/bluez-users>
> >
> >
> > -----------------------------------------------------------------------=
-
> >
> >
> -------------------------------------------------------------------------
> > This SF.net email is sponsored by: Microsoft
> > Defy all challenges. Microsoft(R) Visual Studio 2005.
> > http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
> > -----------------------------------------------------------------------=
-
> >
> > _______________________________________________
> > Bluez-users mailing list
> > Bluez-users@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/bluez-users
> >
>
> -------------------------------------------------------------------------
> This SF.net email is sponsored by: Microsoft
> Defy all challenges. Microsoft(R) Visual Studio 2005.
> http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
>

------=_Part_25681_21807848.1199375877879
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Thanks for your explanation, I know there are many profiles in bluetooth, b=
ut, is PAN the only profile that provide ad-hoc connection in a piconet?<br=
><br>Thanks.<br><br><div class=3D"gmail_quote">On Jan 3, 2008 10:53 PM, Lau=
rent BARBIER &lt;
<a href=3D"mailto:lbarbier@kameleon-media.com">lbarbier@kameleon-media.com<=
/a>&gt; wrote:<br><blockquote class=3D"gmail_quote" style=3D"border-left: 1=
px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"=
>When you wan&#39;t to make B talk to C all need to be forward from and to =
A.
<br>Something like brctl do the job quite sufficiently.<br>Have a look ther=
e : <a href=3D"http://bluez.sourceforge.net/contrib/HOWTO-PAN" target=3D"_b=
lank">http://bluez.sourceforge.net/contrib/HOWTO-PAN</a><br>section &quot;E=
thernet Bridging&quot;
<br><br>Laurent<br><br>bsd user a =E9crit :<br><div class=3D"Ih2E3d">&gt; S=
o, B or C has no knowledge about each other when they are slaves of<br>&gt;=
 master A, right? Then, can I say if B want to talk with C, they need<br>&g=
t; higher level protocol support, such as telnet, ftp. And, all data
<br>&gt; exchange will be forwarded by Master A. right?<br>&gt;<br>&gt; Tha=
nks!<br>&gt;<br>&gt; On Jan 3, 2008 9:07 AM, guoyun &lt;<a href=3D"mailto:g=
uoyun@techfaith.cn">guoyun@techfaith.cn</a><br></div><div class=3D"Ih2E3d">
&gt; &lt;mailto:<a href=3D"mailto:guoyun@techfaith.cn">guoyun@techfaith.cn<=
/a>&gt;&gt; wrote:<br>&gt;<br>&gt; &nbsp; &nbsp; Hi, Brad<br>&gt;<br>&gt; &=
nbsp; &nbsp; &gt; hey<br>&gt; &nbsp; &nbsp; &gt;<br>&gt; &nbsp; &nbsp; &gt;=
 &gt; If there is a piconet that has 2 slave B,C, the master is A.
<br>&gt; &nbsp; &nbsp; Does B<br>&gt; &nbsp; &nbsp; &gt; &gt; know the exis=
tence of C? can B talk to C directly without<br>&gt; &nbsp; &nbsp; &gt; A(m=
aster)&#39;s intervention?<br>&gt; &nbsp; &nbsp; &gt;<br>&gt; &nbsp; &nbsp;=
 &gt; if they did talk to each other directly, one would have to be
<br>&gt; &nbsp; &nbsp; &gt; master and you&#39;d have a scatternet.<br>&gt;=
<br>&gt; &nbsp; &nbsp; one bluetooth could be in two or more piconet, but i=
t just can<br>&gt; &nbsp; &nbsp; play as slave _not_ master for the bluetoo=
th clock.<br>&gt;<br>&gt; &nbsp; &nbsp; Please refer to Core SPEC. chapter=
=20
4.1. Piconet topology.<br>&gt;<br>&gt; &nbsp; &nbsp; BRs<br>&gt; &nbsp; &nb=
sp; Yun<br>&gt;<br>&gt;<br>&gt; &nbsp; &nbsp; -----------------------------=
--------------------------------------------<br>&gt; &nbsp; &nbsp; This SF.=
net email is sponsored by: Microsoft
<br>&gt; &nbsp; &nbsp; Defy all challenges. Microsoft(R) Visual Studio 2005=
.<br>&gt; &nbsp; &nbsp; <a href=3D"http://clk.atdmt.com/MRT/go/vse012000007=
0mrt/direct/01/" target=3D"_blank">http://clk.atdmt.com/MRT/go/vse012000007=
0mrt/direct/01/</a><br>
&gt; &nbsp; &nbsp; _______________________________________________<br>&gt; =
&nbsp; &nbsp; Bluez-users mailing list<br>&gt; &nbsp; &nbsp; <a href=3D"mai=
lto:Bluez-users@lists.sourceforge.net">Bluez-users@lists.sourceforge.net</a=
><br></div>&gt; &nbsp; &nbsp; &lt;mailto:
<a href=3D"mailto:Bluez-users@lists.sourceforge.net">Bluez-users@lists.sour=
ceforge.net</a>&gt;<br><div class=3D"Ih2E3d">&gt; &nbsp; &nbsp; <a href=3D"=
https://lists.sourceforge.net/lists/listinfo/bluez-users" target=3D"_blank"=
>https://lists.sourceforge.net/lists/listinfo/bluez-users
</a><br>&gt; &nbsp; &nbsp; &lt;<a href=3D"https://lists.sourceforge.net/lis=
ts/listinfo/bluez-users" target=3D"_blank">https://lists.sourceforge.net/li=
sts/listinfo/bluez-users</a>&gt;<br>&gt;<br>&gt;<br></div>&gt; ------------=
------------------------------------------------------------
<br><div><div></div><div class=3D"Wj3C7c">&gt;<br>&gt; --------------------=
-----------------------------------------------------<br>&gt; This SF.net e=
mail is sponsored by: Microsoft<br>&gt; Defy all challenges. Microsoft(R) V=
isual Studio 2005.
<br>&gt; <a href=3D"http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/=
" target=3D"_blank">http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/=
</a><br>&gt; --------------------------------------------------------------=
----------
<br>&gt;<br>&gt; _______________________________________________<br>&gt; Bl=
uez-users mailing list<br>&gt; <a href=3D"mailto:Bluez-users@lists.sourcefo=
rge.net">Bluez-users@lists.sourceforge.net</a><br>&gt; <a href=3D"https://l=
ists.sourceforge.net/lists/listinfo/bluez-users" target=3D"_blank">
https://lists.sourceforge.net/lists/listinfo/bluez-users</a><br>&gt;<br><br=
>-------------------------------------------------------------------------<=
br>This SF.net email is sponsored by: Microsoft<br>Defy all challenges. Mic=
rosoft(R) Visual Studio 2005.
<br><a href=3D"http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/" tar=
get=3D"_blank">http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/</a><=
br>_______________________________________________<br>Bluez-users mailing l=
ist
<br><a href=3D"mailto:Bluez-users@lists.sourceforge.net">Bluez-users@lists.=
sourceforge.net</a><br><a href=3D"https://lists.sourceforge.net/lists/listi=
nfo/bluez-users" target=3D"_blank">https://lists.sourceforge.net/lists/list=
info/bluez-users
</a><br></div></div></blockquote></div><br>

------=_Part_25681_21807848.1199375877879--


--===============1418059683==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--===============1418059683==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============1418059683==--
