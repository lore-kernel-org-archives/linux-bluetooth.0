Return-Path: <cyrus@holtmann.org>
Message-ID: <359782e70801140751n22316957l190577193949d5d5@mail.gmail.com>
Date: Mon, 14 Jan 2008 23:51:56 +0800
From: "bsd user" <oldmoonster@gmail.com>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <359782e70801120831o33e6fb4cyab9801906925480d@mail.gmail.com>
MIME-Version: 1.0
References: <d89ddf300801021040o28e16943t2c51ac0190bd4e91@mail.gmail.com>
	<E21A90CDB9591542899EFC7FB4ED5CC90776A695@tfmail02.TFMAIL.COM>
	<359782e70801030510p5abedbe4m6d7e129d8a5b0692@mail.gmail.com>
	<477CF705.1090006@kameleon-media.com>
	<359782e70801120831o33e6fb4cyab9801906925480d@mail.gmail.com>
Subject: [Bluez-devel] Fwd: [Bluez-users] slave - slave talk in a piconet
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0957833286=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============0957833286==
Content-Type: multipart/alternative;
	boundary="----=_Part_8347_28693823.1200325916090"

------=_Part_8347_28693823.1200325916090
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Somehow, I did not get any response for below question, can anybody in here
give me some feedback?

Thanks very much!

---------- Forwarded message ----------
From: bsd user <oldmoonster@gmail.com>
Date: Jan 13, 2008 12:31 AM
Subject: Re: [Bluez-users] slave - slave talk in a piconet
To: BlueZ users <bluez-users@lists.sourceforge.net>


I learned PAN Profile 1.0 from SIG. I am interested in the PANU service.
According to the profile, device has PANU service can establish a connectio=
n
with another device's PANU service DIRECTLY, no need message forwarding by
NAP or GN node! but this feature hasn't been mentioned in "HOWTO-PAN"...

I want to setup a real p2p ad-hoc network with 4 bluetooth enabled computer=
s
without message forwarding from 3rd node when message need to be exchanged
between any two nodes, see below picture::

             +------+     +------+
             | PANU1|<--->| PANU2|
             +------+     +------+
               /|\    \ /    /|\
                |      X      |
               \|/    / \    \|/
              +------+    +------+
              | PANU3|<-->| PANU4|
              +------+    +------+

in above scenario,
    PANU1 is master of PANU2, PANUS3 and PANU4
    PANU2 is master of PANU4,
    PANU4 is master of PANU3,
    PANU3 is master of PANU2,

So, PANU3 need to work in 2 piconet. Is this scenario valid?

Thanks a lot!



On Jan 3, 2008 10:53 PM, Laurent BARBIER < lbarbier@kameleon-media.com>
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
> >     <mailto: Bluez-users@lists.sourceforge.net>
> >     https://lists.sourceforge.net/lists/listinfo/bluez-users
> >     <https://lists.sourceforge.net/lists/listinfo/bluez-users>
> >
> >
> > -----------------------------------------------------------------------=
-
>
> >
> >
> -------------------------------------------------------------------------
> > This SF.net email is sponsored by: Microsoft
> > Defy all challenges. Microsoft(R) Visual Studio 2005.
> > http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
> > -----------------------------------------------------------------------=
-
>
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

------=_Part_8347_28693823.1200325916090
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Somehow, I did not get any response for below question, can anybody in here=
 give me some feedback?<br><br>Thanks very much!<br><br><div class=3D"gmail=
_quote">---------- Forwarded message ----------<br>From: <b class=3D"gmail_=
sendername">
bsd user</b> &lt;<a href=3D"mailto:oldmoonster@gmail.com">oldmoonster@gmail=
.com</a>&gt;<br>Date: Jan 13, 2008 12:31 AM<br>Subject: Re: [Bluez-users] s=
lave - slave talk in a piconet<br>To: BlueZ users &lt;<a href=3D"mailto:blu=
ez-users@lists.sourceforge.net">
bluez-users@lists.sourceforge.net</a>&gt;<br><br><br>I learned PAN Profile =
1.0 from SIG. I am interested in the PANU service. According to the profile=
, device has PANU service can establish a connection with another device&#3=
9;s PANU service DIRECTLY, no need message forwarding by NAP or GN node! bu=
t this feature hasn&#39;t been mentioned in &quot;HOWTO-PAN&quot;...
<br><br>I want to setup a real p2p ad-hoc network with 4 bluetooth enabled =
computers without message forwarding from 3rd node when message need to be =
exchanged between any two nodes, see below picture::<br><pre>             +=
------+     +------+
<br>             | PANU1|&lt;---&gt;| PANU2|<br>             +------+     +=
------+<br>              &nbsp;/|\    \ /    /|\<br>                |      =
X      |<br>               \|/    / \    \|/<br>              +------+    +=
------+
<br>              | PANU3|&lt;--&gt;| PANU4|<br>              +------+    +=
------+<br><br>in above scenario, <br>    PANU1 is master of PANU2, PANUS3 =
and PANU4 <br>    PANU2 is master of PANU4,<br>    PANU4 is master of PANU3=
,
<br>    PANU3 is master of PANU2,<br><br>So, PANU3 need to work in 2 picone=
t. Is this scenario valid?<br><br>Thanks a lot!<br></pre><br><br><div class=
=3D"gmail_quote"><div class=3D"Ih2E3d">On Jan 3, 2008 10:53 PM, Laurent BAR=
BIER &lt;
<a href=3D"mailto:lbarbier@kameleon-media.com" target=3D"_blank">
lbarbier@kameleon-media.com</a>&gt; wrote:<br></div><div><div></div><div cl=
ass=3D"Wj3C7c"><blockquote class=3D"gmail_quote" style=3D"border-left: 1px =
solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">Wh=
en you wan&#39;t to make B talk to C all need to be forward from and to A.
<br>Something like brctl do the job quite sufficiently.<br>Have a look ther=
e : <a href=3D"http://bluez.sourceforge.net/contrib/HOWTO-PAN" target=3D"_b=
lank">http://bluez.sourceforge.net/contrib/HOWTO-PAN</a><br>section &quot;E=
thernet Bridging&quot;
<br><br>Laurent<br><br>bsd user a =E9crit :<br><div>&gt; So, B or C has no =
knowledge about each other when they are slaves of<br>&gt; master A, right?=
 Then, can I say if B want to talk with C, they need<br>&gt; higher level p=
rotocol support, such as telnet, ftp. And, all data
<br>&gt; exchange will be forwarded by Master A. right?<br>&gt;<br>&gt; Tha=
nks!<br>&gt;<br>&gt; On Jan 3, 2008 9:07 AM, guoyun &lt;<a href=3D"mailto:g=
uoyun@techfaith.cn" target=3D"_blank">guoyun@techfaith.cn</a><br></div><div=
>

&gt; &lt;mailto:<a href=3D"mailto:guoyun@techfaith.cn" target=3D"_blank">gu=
oyun@techfaith.cn</a>&gt;&gt; wrote:<br>&gt;<br>&gt; &nbsp; &nbsp; Hi, Brad=
<br>&gt;<br>&gt; &nbsp; &nbsp; &gt; hey<br>&gt; &nbsp; &nbsp; &gt;<br>&gt; =
&nbsp; &nbsp; &gt; &gt; If there is a piconet that has 2 slave B,C, the mas=
ter is A.
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
0mrt/direct/01/</a>
<br>
&gt; &nbsp; &nbsp; _______________________________________________<br>&gt; =
&nbsp; &nbsp; Bluez-users mailing list<br>&gt; &nbsp; &nbsp; <a href=3D"mai=
lto:Bluez-users@lists.sourceforge.net" target=3D"_blank">Bluez-users@lists.=
sourceforge.net</a><br></div>
&gt; &nbsp; &nbsp; &lt;mailto:
<a href=3D"mailto:Bluez-users@lists.sourceforge.net" target=3D"_blank">Blue=
z-users@lists.sourceforge.net</a>&gt;<br><div>&gt; &nbsp; &nbsp; <a href=3D=
"https://lists.sourceforge.net/lists/listinfo/bluez-users" target=3D"_blank=
">https://lists.sourceforge.net/lists/listinfo/bluez-users
</a><br>&gt; &nbsp; &nbsp; &lt;<a href=3D"https://lists.sourceforge.net/lis=
ts/listinfo/bluez-users" target=3D"_blank">https://lists.sourceforge.net/li=
sts/listinfo/bluez-users</a>&gt;<br>&gt;<br>&gt;<br></div>&gt; ------------=
------------------------------------------------------------
<br><div><div></div><div>&gt;<br>&gt; -------------------------------------=
------------------------------------<br>&gt; This SF.net email is sponsored=
 by: Microsoft<br>&gt; Defy all challenges. Microsoft(R) Visual Studio 2005=
.
<br>&gt; <a href=3D"http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/=
" target=3D"_blank">http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/=
</a><br>&gt; --------------------------------------------------------------=
----------
<br>&gt;<br>&gt; _______________________________________________<br>&gt; Bl=
uez-users mailing list<br>&gt; <a href=3D"mailto:Bluez-users@lists.sourcefo=
rge.net" target=3D"_blank">Bluez-users@lists.sourceforge.net</a><br>&gt; <a=
 href=3D"https://lists.sourceforge.net/lists/listinfo/bluez-users" target=
=3D"_blank">

https://lists.sourceforge.net/lists/listinfo/bluez-users</a><br>&gt;<br><br=
>-------------------------------------------------------------------------<=
br>This SF.net email is sponsored by: Microsoft<br>Defy all challenges. Mic=
rosoft(R) Visual Studio 2005.
<br><a href=3D"http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/" tar=
get=3D"_blank">http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/</a><=
br>_______________________________________________<br>Bluez-users mailing l=
ist
<br><a href=3D"mailto:Bluez-users@lists.sourceforge.net" target=3D"_blank">=
Bluez-users@lists.sourceforge.net</a><br><a href=3D"https://lists.sourcefor=
ge.net/lists/listinfo/bluez-users" target=3D"_blank">https://lists.sourcefo=
rge.net/lists/listinfo/bluez-users
</a><br></div></div></blockquote></div></div></div><br>
</div><br>

------=_Part_8347_28693823.1200325916090--


--===============0957833286==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
--===============0957833286==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============0957833286==--
