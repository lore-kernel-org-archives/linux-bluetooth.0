Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <e1effdeb050830111665325706@mail.gmail.com>
From: Claudio Takahasi <cktakahasi@gmail.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] bluetoothd D-Bus interface proposals(draft 00.05)
In-Reply-To: <e1effdeb050830061474e1e560@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_4844_31224945.1125425811651"
References: <e1effdeb05081614151ee4f4bd@mail.gmail.com>
	 <e1effdeb05082205517cac906c@mail.gmail.com>
	 <9307f5f2050822072659387e3b@mail.gmail.com>
	 <1124721252.23599.53.camel@pegasus>
	 <e1effdeb05082210394bed468@mail.gmail.com>
	 <1124733046.23599.81.camel@pegasus>
	 <e1effdeb050822124710aa8798@mail.gmail.com>
	 <e1effdeb0508291413753e3b2e@mail.gmail.com>
	 <1125351995.17698.37.camel@pegasus>
	 <e1effdeb050830061474e1e560@mail.gmail.com>
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
Date: Tue, 30 Aug 2005 15:16:51 -0300

------=_Part_4844_31224945.1125425811651
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Marcel,

Regarding the special HCI_DEV_NONE system socket with vendor packet type. D=
o=20
you=20
have a patch for it or it just ideas for BlueZ improvements? What are=20
exactly the events that=20
you want send in this socket?

BR,
Claudio.



On 8/30/05, Claudio Takahasi <cktakahasi@gmail.com> wrote:
>=20
>=20
>=20
> On 8/29/05, Marcel Holtmann <marcel@holtmann.org> wrote:
> >=20
> > Hi Claudio,
> >=20
> > > Sorry annoy you again, but would like received more suggestions and
> > > close this discussion.
> > >
> > > Marcel, I remember you comment something about improve the sdpd, coul=
d
> > > you be more clear?=20
> > >
> > > The core implementation (bluetoothd) and some hci functions are ready=
.
> > > I am just waiting finish the specification.
> >=20
> > sorry, I am totally behind my schedule and as you saw, I had to deal
> > with some weird D-Bus things in the current hcid in the last week. Ther=
e=20
> >=20
> > is other stuff that needs my attention, before I can start looking at
> > bluetoothd again.
>=20
>=20
> [Claudio Takahasi]=20
> I understand your problem, Don't worry. Considering that D-Bus is
> under development, bugs are common :)
>=20
> However the basic idea is that bluetoothd should combine hcid and sdpd
> > and present an easier interface over D-Bus. This interface should no=20
> > longer be HCI or SDP protocol specific. It should be more profile
> > specific and define standard task. In conjunction with the new extended
> > inquiry response the bluetoothd must also take care to assemble the
> > correct data from the running services and the device name to fully=20
> > fulfil the requirements of extended inquiry response. If the complete
> > SDP handling is inside bluetoothd we can do full and easy caching of
> > service information of remote devices.
>=20
>=20
> [Claudio Takahasi]=20
> I didn't see the new extended inquiry response yet. I will try understand=
=20
> how it works.
> Do you have material about it? Is it related with interlaced inquiry?
> Regarding SDP, do you mean put everything inside bluetoothd? I am not=20
> understanding how=20
> it should work. As I could undertand you intend provide a complete SDP=20
> handling inside bluetoothd
> without interact with sdpd.
> Currently, applications(daemon) that want publish a service, they have to=
=20
> connect
> with the sdpd(sdp_connect) and register the services. If we move=20
> everything to bluetoothd we will lost=20
> the backward compatibility. Another approach is provide a D-Bus interface=
=20
> for sdp in the bluetoothd, but in=20
> this case the bluetoothd will continue connecting to sdpd to register=20
> services. The last approach is dupplicate=20
> the functionalities, sdpd and bluetoothd will do the same thing, but the=
=20
> last one will available for D-Bus enable=20
> systems only.
>=20
> Another comment about bluetoothd IMHO blutoothd should be modular enough=
=20
> to make possible=20
> develop/provide another profiles(pan,rfcomm, dun, hid, hsp, ...)=20
> Therefore, it should be more than
> a daemon to provide hci and sdp services. This is the reason that I=20
> comment about hierarchical
> paths.
> /org/bluez/bluetoothd
> /org/bluez/bluetoothd/sdp
> /org/bluez/bluetoothd/hci
> /org/bluez/bluetoothd/pan
>=20
> Using this approach is easier control permissions in the D-Bus=20
> configuration file and register/unregister
> D-Bus paths.
>=20
>=20
> On the other side we have that D-Bus API problem and if anyone can
> > convince the Debian guys to finally move to latest D-Bus release for th=
e=20
> >=20
> > unstable distribution I would be really thankful. I simple wanna drop
> > these crappy workaround, because they make my testing before I can
> > release a new version a mess. I saw that Ubuntu even uses D-Bus 0.35 an=
d
> > so there is no other distribution with such an old version.
>=20
>=20
> [Claudio Takahasi]
> I think you don't need worry about it. After 0.30 D-Bus is more stable an=
d=20
> probably
> it will not change drastically. I didn't see functions name/signatures=20
> changes.=20
> The only think that we have to pay attention is the functions to=20
> extract/append arguments
> in the message with number of elements variable. I was informed that they=
=20
> should be avoided=20
> and they will be depreciated.
>=20
> The next thing is the kernel interface for bluetoothd. I basically don't
> > wanna have another daemon listening on the HCI socket and have to deal=
=20
> > with plug/unplug of devices. These task are already done inside the
> > kernel and so it should simply inform the userspace of such events. The
> > same applies to connection tracking etc. The kernel needs to know
> > everything and I must work on the new interface to tell the userspace=
=20
> > what is currently going on. For that I will use the special HCI_DEV_NON=
E
> > system socket and the vendor packets type 0xff. So we don't pollute the
> > HCI namespace with "stack internal" commands and events and still have=
=20
> > an easy interface. The other possibility would be to use netlink, but w=
e
> > already have most parts of the infrastructure in place and so I don't
> > see and need to deal with netlink. And one of the first things that
> > bluetoothd must be capable of is to support the kernel internal securit=
y
> > manager. This means dealing with special events to handle pin code and
> > link key requests.
>=20
>=20
> [Claudio Takahasi]=20
> O my God, it will be fun! A lot of chalenges :)=20
> Could you provide more details about this section. Currenlty hcid is=20
> responsible for
> handle this events(security and devices). How should be the=20
> interaction/relation
> between hcid and bluetoothd? hcid is already listening for=20
> HCI_DEV_UP/DOWN/REG/UNREG ...
>=20
> I agree with provide security services, they are essential.
>=20
>=20
> As maybe some people saw, I already used hcid as a playground for some
> > more D-Bus signals. I still need to learn and understand the D-Bus much=
=20
> > better. So any patches from your specification to bring some of these
> > features to hcid would be happily accepted.
>=20
> [Claudio Takahasi]
> I saw a lot hcid D-Bus signals, but currently only signals are sent.=20
> Services requests are
> not being handled, they can be a good starting point. I will analyse=20
> better and send
> patches if possible.
>=20
> Regards
> >=20
> > Marcel
> >=20
> >=20
> >=20
> >=20
> > -------------------------------------------------------=20
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
>

------=_Part_4844_31224945.1125425811651
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Marcel,<br>
<br>
Regarding the special HCI_DEV_NONE system socket with vendor packet type. D=
o you <br>
have a patch for it or it just ideas for BlueZ improvements? What are exact=
ly the events that <br>
you want send in this socket?<br>
<br>
BR,<br>
Claudio.<br>
<br>
<br><br><div><span class=3D"gmail_quote">On 8/30/05, <b class=3D"gmail_send=
ername">Claudio Takahasi</b> &lt;<a href=3D"mailto:cktakahasi@gmail.com">ck=
takahasi@gmail.com</a>&gt; wrote:</span><blockquote class=3D"gmail_quote" s=
tyle=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8e=
x; padding-left: 1ex;">
<br><br><div><span class=3D"q"><span class=3D"gmail_quote">On 8/29/05, <b c=
lass=3D"gmail_sendername">Marcel Holtmann</b> &lt;<a href=3D"mailto:marcel@=
holtmann.org" target=3D"_blank" onclick=3D"return top.js.OpenExtLink(window=
,event,this)">
marcel@holtmann.org</a>&gt; wrote:</span><blockquote class=3D"gmail_quote" =
style=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8=
ex; padding-left: 1ex;">
Hi Claudio,<br><br>&gt; Sorry annoy you again, but would like received more=
 suggestions and<br>&gt; close this discussion.<br>&gt;<br>&gt; Marcel, I r=
emember you comment something about improve the sdpd, could<br>&gt; you be =
more clear?
<br>&gt;<br>&gt; The core implementation (bluetoothd) and some hci function=
s are ready.<br>&gt; I am just waiting finish the specification.<br><br>sor=
ry, I am totally behind my schedule and as you saw, I had to deal<br>with s=
ome weird D-Bus things in the current hcid in the last week. There
<br>is other stuff that needs my attention, before I can start looking at<b=
r>bluetoothd again.</blockquote></span><div><br>
[Claudio Takahasi] <br>
I understand your&nbsp; problem, Don't worry. Considering that D-Bus is<br>
under development, bugs are common :)<br>
&nbsp;</div><span class=3D"q"><br><blockquote class=3D"gmail_quote" style=
=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; p=
adding-left: 1ex;">However the basic idea is that bluetoothd should combine=
 hcid and sdpd
<br>and present an easier interface over D-Bus. This interface should no
<br>longer be HCI or SDP protocol specific. It should be more profile<br>sp=
ecific and define standard task. In conjunction with the new extended<br>in=
quiry response the bluetoothd must also take care to assemble the<br>correc=
t data from the running services and the device name to fully
<br>fulfil the requirements of extended inquiry response. If the complete<b=
r>SDP handling is inside bluetoothd we can do full and easy caching of<br>s=
ervice information of remote devices.</blockquote></span><div><br>
[Claudio Takahasi] <br>
I didn't see the new extended inquiry response yet. I will try understand h=
ow it works.<br>
Do you have material about it?&nbsp; Is it related with interlaced inquiry?=
<br>
Regarding SDP, do you mean put everything inside bluetoothd? I am not under=
standing how <br>
it should work. As I could undertand you intend provide a complete SDP hand=
ling inside bluetoothd<br>
without interact with sdpd.<br>
Currently, applications(daemon) that want publish a service, they have to c=
onnect<br>
with the sdpd(sdp_connect) and register the services. If we move everything=
 to bluetoothd we will lost <br>
the backward compatibility. Another approach is&nbsp; provide a D-Bus inter=
face for sdp in the bluetoothd, but in <br>
this case the bluetoothd will continue connecting to sdpd to register servi=
ces. The last approach is dupplicate <br>
the functionalities, sdpd and bluetoothd will do the same thing, but the la=
st one will available for D-Bus enable <br>
systems only.<br>
<br>
Another comment about bluetoothd <font size=3D"2">IMHO blutoothd should be =
modular enough to make possible <br>
develop/provide another profiles(pan,rfcomm, dun, hid, hsp, ...) Therefore,=
 it should be more than<br>
a daemon to provide hci and sdp services. This is the reason that I comment=
 about hierarchical<br>
paths.<br>
/org/bluez/bluetoothd<br>
</font><font size=3D"2">/org/bluez/bluetoothd/sdp<br>
</font><font size=3D"2">/org/bluez/bluetoothd/hci<br>
</font><font size=3D"2">/org/bluez/bluetoothd/pan</font><br>
<font size=3D"2"><br>
Using this approach is easier control permissions in the D-Bus configuratio=
n file and register/unregister<br>
D-Bus paths.<br>
<br>
</font></div><span class=3D"q"><br><blockquote class=3D"gmail_quote" style=
=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; p=
adding-left: 1ex;">On the other side we have that D-Bus API problem and if =
anyone can
<br>convince the Debian guys to finally move to latest D-Bus release for th=
e
<br>unstable distribution I would be really thankful. I simple wanna drop<b=
r>these crappy workaround, because they make my testing before I can<br>rel=
ease a new version a mess. I saw that Ubuntu even uses D-Bus 0.35 and<br>

so there is no other distribution with such an old version.</blockquote></s=
pan><div><br>
&nbsp;[Claudio Takahasi]<br>
I think you don't need worry about it. After 0.30 D-Bus is more stable and =
probably<br>
it will not change drastically. I didn't see functions name/signatures chan=
ges. <br>
The only think that we have to pay attention is the functions to extract/ap=
pend arguments<br>
in the message with number of elements variable. I was informed that they s=
hould be avoided <br>
and they will be depreciated.<br>
</div><span class=3D"q"><br><blockquote class=3D"gmail_quote" style=3D"bord=
er-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-l=
eft: 1ex;">The next thing is the kernel interface for bluetoothd. I basical=
ly don't
<br>wanna have another daemon listening on the HCI socket and have to deal
<br>with plug/unplug of devices. These task are already done inside the<br>=
kernel and so it should simply inform the userspace of such events. The<br>=
same applies to connection tracking etc. The kernel needs to know<br>everyt=
hing and I must work on the new interface to tell the userspace
<br>what is currently going on. For that I will use the special HCI_DEV_NON=
E<br>system socket and the vendor packets type 0xff. So we don't pollute th=
e<br>HCI namespace with &quot;stack internal&quot; commands and events and =
still have
<br>an easy interface. The other possibility would be to use netlink, but w=
e<br>already have most parts of the infrastructure in place and so I don't<=
br>see and need to deal with netlink. And one of the first things that
<br>
bluetoothd must be capable of is to support the kernel internal security<br=
>manager. This means dealing with special events to handle pin code and<br>=
link key requests.</blockquote></span><div><br>
[Claudio Takahasi]&nbsp; <br>
O my God, it will be fun! A lot of chalenges :) <br>
Could you provide more details about this section. Currenlty hcid is respon=
sible for<br>
handle this events(security and devices). How should be the interaction/rel=
ation<br>
between hcid and bluetoothd? hcid is already listening for HCI_DEV_UP/DOWN/=
REG/UNREG ...<br>
<br>
</div>I agree with provide security services, they are essential.<span clas=
s=3D"q"><br>
<br>
<br><blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(2=
04, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">As maybe some=
 people saw, I already used hcid as a playground for some<br>more D-Bus sig=
nals. I still need to learn and understand the D-Bus much
<br>better. So any patches from your specification to bring some of these<b=
r>features to hcid would be happily accepted.</blockquote></span><span clas=
s=3D"sg"><div>[Claudio Takahasi]<br>
I&nbsp; saw a lot hcid D-Bus signals, but currently only signals are sent. =
Services requests are<br>
not being handled, they can be a good starting point. I will analyse better=
 and send<br>
patches if possible.<br>
</div></span><span class=3D"q"><br><blockquote class=3D"gmail_quote" style=
=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; p=
adding-left: 1ex;">Regards<br><br>Marcel<br><br><br><br><br>---------------=
----------------------------------------
<br>SF.Net email is Sponsored by the Better Software Conference &amp; EXPO<=
br>September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practi=
ces<br>Agile &amp; Plan-Driven Development * Managing Projects &amp; Teams =
* Testing &amp; QA
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
</a><br></blockquote></span></div><br>

</blockquote></div><br>

------=_Part_4844_31224945.1125425811651--


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
