Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <e1effdeb05091214141c75fe0@mail.gmail.com>
From: Claudio Takahasi <cktakahasi@gmail.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] HCID D-Bus (Seg Fault)
In-Reply-To: <e1effdeb050912140719fc9d3b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_16182_25464806.1126559649302"
References: <e1effdeb050908125079935830@mail.gmail.com>
	 <1126220839.5286.57.camel@blade>
	 <5256d0b050909012577fcb19c@mail.gmail.com>
	 <1126258645.5227.16.camel@blade>
	 <20050909132940.GE17543@spring.luon.net>
	 <1126273252.5227.119.camel@blade>
	 <e1effdeb050912140719fc9d3b@mail.gmail.com>
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
Date: Mon, 12 Sep 2005 18:14:09 -0300

------=_Part_16182_25464806.1126559649302
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Sorry,

segmentation fault :)

This problem happens because the pin will contains the long error message=
=20
string instead of a short pin number.


On 9/12/05, Claudio Takahasi <cktakahasi@gmail.com> wrote:
>=20
> Hi Marcel,
>=20
> I am sending a new patch that contains the following enhancements:
> 1. Support multiple D-Bus versions(0.23, 0.30...)=20
> 2. Fixed error handling ServiceDoesNotExist, NoReply, UnknownService, ...
> This condition is causing sig fault due the wrong pin value. Scenario:=20
> D-Bus pin helper enabled=20
> and an error different than wrong argument triggered.
>=20
>=20
> Regards,
> Claudio.
>=20
> On 9/9/05, Marcel Holtmann <marcel@holtmann.org> wrote:
> >=20
> > Hi Sjoerd,
> >=20
> > > > having 0.33 is better than 0.23 and this is what Debian unstable=20
> > still
> > > > uses. However lets make a list of the distributions:
> > > >
> > > > SuSE Linux 10.0 D-Bus 0.35
> > > > Fedora Core 4 D-Bus 0.33
> > > > Ubuntu Breezy D-Bus 0.36
> > > > Debian unstable D-Bus 0.23
> > > Debian experimental D-Bus 0.50
> >=20
> > this is good.=20
> >=20
> > > > The only bad guy is Debian unstable and I don't care anymore. They=
=20
> > use
> > > > Xorg finally and have GCC 4.0 etc., but they can't move over to the=
=20
> > next
> > > > D-Bus generation. I think that is their problem now and the release=
=20
> > of=20
> > > > bluez-utils-0.22 will definitely drop the support for the old D-Bus=
=20
> > 0.23
> > > > version.
> > >
> > > D-bus >=3D 0.3x has been in debian experimental for quite some time.=
=20
> > There are
> > > various transitions going on in debian unstable currently which makes=
=20
> > it=20
> > > inappropriate to do a dbus transition now too.
> >=20
> > Last time I looked at it, the complete KDE part was broken and full of
> > wrong dependencies. So breaking D-Bus wouldn't even be notified ;)
> >=20
> > > > I like to base everything around the current D-Bus 0.50 release,=20
> > because
> > > > the C API should be quite stable now. I will accept small=20
> > workarounds to
> > > > make D-Bus 0.3x work, but as soon as the distributions update their
> > > > D-Bus libraries I will drop them.=20
> > > >
> > > > This is not a nice thing to do, I know, but a wrong usage of D-Bus=
=20
> > lets
> > > > hcid segfault and this is not what I want.
> > >
> > > As one of debian's dbus maintainers i would advise to indeed base=20
> > everything on=20
> > > dbus >=3D 0.50. Hopefully it won't take too long before we can move t=
he=20
> > new dbus
> > > from experimental to unstable, so the workarounds for old dbus releas=
e=20
> > are just
> > > not worth it.
> >=20
> > This means I will release bluez-utils-2.21 on the weekend, because of
> > some memory leak fixes and then I will drop D-Bus 0.23 support. So if
> > any patches need to go in before, please send them now.
> >=20
> > Regards
> >=20
> > Marcel
> >=20
> >=20
> >=20
> >=20
> > -------------------------------------------------------
> > SF.Net email is Sponsored by the Better Software Conference & EXPO
> > September 19-22, 2005 * San Francisco, CA * Development Lifecycle=20
> > Practices
> > Agile & Plan-Driven Development * Managing Projects & Teams * Testing &=
=20
> > QA=20
> > Security * Process Improvement & Measurement *=20
> > http://www.sqe.com/bsce5sf
> > _______________________________________________
> > Bluez-devel mailing list
> > Bluez-devel@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/bluez-devel
> >=20
>=20
>=20
>

------=_Part_16182_25464806.1126559649302
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Sorry,<br>
<br>
segmentation fault :)<br>
<br>
This problem happens because the pin will contains the long error message <=
br>
string instead of a short pin number.<br>
<br><br><div><span class=3D"gmail_quote">On 9/12/05, <b class=3D"gmail_send=
ername">Claudio Takahasi</b> &lt;<a href=3D"mailto:cktakahasi@gmail.com">ck=
takahasi@gmail.com</a>&gt; wrote:</span><blockquote class=3D"gmail_quote" s=
tyle=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8e=
x; padding-left: 1ex;">
Hi Marcel,<br>
<br>
I am sending a new patch that contains the following enhancements:<br>
1. Support multiple D-Bus versions(0.23, 0.30...) <br>
2. Fixed error handling ServiceDoesNotExist, NoReply, UnknownService, ...<b=
r>
&nbsp;&nbsp; This condition is causing sig fault due the wrong pin value. S=
cenario: D-Bus pin helper enabled <br>
&nbsp;&nbsp; and an error different than wrong argument triggered.<br>
&nbsp;  <br>
<br>
Regards,<br>
Claudio.<br>
<br><div><span class=3D"gmail_quote">On 9/9/05, <b class=3D"gmail_sendernam=
e">Marcel Holtmann</b> &lt;<a href=3D"mailto:marcel@holtmann.org" target=3D=
"_blank" onclick=3D"return top.js.OpenExtLink(window,event,this)">marcel@ho=
ltmann.org
</a>&gt; wrote:</span><blockquote class=3D"gmail_quote" style=3D"border-lef=
t: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1=
ex;">
Hi Sjoerd,<br><br>&gt; &gt; having 0.33 is better than 0.23 and this is wha=
t Debian unstable still<br>&gt; &gt; uses. However lets make a list of the =
distributions:<br>&gt; &gt;<br>&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp; SuSE Linux=
 10.0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; D-Bus=20
0.35<br>&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp; Fedora Core 4&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; D-Bus 0.33<br>&gt; &gt;&nbsp;&nbsp=
;&nbsp;&nbsp; Ubuntu Breezy&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; D-Bus 0.36<br>&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp; Debian unstabl=
e&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; D-Bus 0.23<br>&gt;&nbsp;&=
nbsp;&nbsp;&nbsp; Debian experimental D-Bus 0.50<br><br>this is good.
<br><br>&gt; &gt; The only bad guy is Debian unstable and I don't care anym=
ore. They use<br>&gt; &gt; Xorg finally and have GCC 4.0 etc., but they can=
't move over to the next<br>&gt; &gt; D-Bus generation. I think that is the=
ir problem now and the release of
<br>&gt; &gt; bluez-utils-0.22 will definitely drop the support for the old=
 D-Bus 0.23<br>&gt; &gt; version.<br>&gt;<br>&gt; D-bus &gt;=3D 0.3x has be=
en in debian experimental for quite some time. There are<br>&gt; various tr=
ansitions going on in debian unstable currently which makes it
<br>&gt; inappropriate to do a dbus transition now too.<br><br>Last time I =
looked at it, the complete KDE part was broken and full of<br>wrong depende=
ncies. So breaking D-Bus wouldn't even be notified ;)<br><br>&gt; &gt; I li=
ke to base everything around the current D-Bus=20
0.50 release, because<br>&gt; &gt; the C API should be quite stable now. I =
will accept small workarounds to<br>&gt; &gt; make D-Bus 0.3x work, but as =
soon as the distributions update their<br>&gt; &gt; D-Bus libraries I will =
drop them.
<br>&gt; &gt;<br>&gt; &gt; This is not a nice thing to do, I know, but a wr=
ong usage of D-Bus lets<br>&gt; &gt; hcid segfault and this is not what I w=
ant.<br>&gt;<br>&gt; As one of debian's dbus maintainers i would advise to =
indeed base everything on
<br>&gt; dbus &gt;=3D 0.50. Hopefully it won't take too long before we can =
move the new dbus<br>&gt; from experimental to unstable, so the workarounds=
 for old dbus release are just<br>&gt; not worth it.<br><br>This means I wi=
ll release=20
bluez-utils-2.21 on the weekend, because of<br>some memory leak fixes and t=
hen I will drop D-Bus 0.23 support. So if<br>any patches need to go in befo=
re, please send them now.<br><br>Regards<br><br>Marcel<br><br><br><br>
<br>
-------------------------------------------------------<br>SF.Net email is =
Sponsored by the Better Software Conference &amp; EXPO<br>September 19-22, =
2005 * San Francisco, CA * Development Lifecycle Practices<br>Agile &amp; P=
lan-Driven Development * Managing Projects &amp; Teams * Testing &amp; QA
<br>Security * Process Improvement &amp; Measurement * <a href=3D"http://ww=
w.sqe.com/bsce5sf" target=3D"_blank" onclick=3D"return top.js.OpenExtLink(w=
indow,event,this)">http://www.sqe.com/bsce5sf</a><br>______________________=
_________________________
<br>Bluez-devel mailing list<br><a href=3D"mailto:Bluez-devel@lists.sourcef=
orge.net" target=3D"_blank" onclick=3D"return top.js.OpenExtLink(window,eve=
nt,this)">
Bluez-devel@lists.sourceforge.net</a><br><a href=3D"https://lists.sourcefor=
ge.net/lists/listinfo/bluez-devel" target=3D"_blank" onclick=3D"return top.=
js.OpenExtLink(window,event,this)">https://lists.sourceforge.net/lists/list=
info/bluez-devel
</a><br></blockquote></div><br>

<br clear=3D"all"></blockquote></div><br>

------=_Part_16182_25464806.1126559649302--


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
