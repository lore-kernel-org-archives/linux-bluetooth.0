Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <e1effdeb05091507045d13ca3f@mail.gmail.com>
From: Claudio Takahasi <cktakahasi@gmail.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] hcid and bluetoothd
In-Reply-To: <1126775298.28510.40.camel@station6.example.com>
Mime-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_8855_14909712.1126793077956"
References: <e1effdeb050914064849913a76@mail.gmail.com>
	 <1126775298.28510.40.camel@station6.example.com>
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
Date: Thu, 15 Sep 2005 11:04:37 -0300

------=_Part_8855_14909712.1126793077956
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

[Claudio Takahasi]
Hi Marcel,

On 9/15/05, Marcel Holtmann <marcel@holtmann.org> wrote:
>=20
> Hi Claudio,
>=20
> > You said in an old e-mail that hcid is your playground for D-Bus
> > services. Probably, hcid D-Bus should be the starting point for
> > bluetoothd.
>=20
> since it is there and used, I think it is a good idea. At the moment it
> is optional and so we can test it. At some point I will make bluez-utils
> depend on D-Bus.
>=20
> > I would like to align your ideas to avoid future reworks.
> >
> > D-Bus provides 4 types of messages:
> > 1. Method call
> > 2. Method reply
> > 3. Signals
> > 4. Error
> > Currently, only signals are sent. The following signals are sent as
> > result of the hci commands:
> > - InquiryStart
> > - InquiryResult
> > - InquiryComplete
> > - RemoteName
> > path: /org/bluez/DevAgent
> > interface: org.bluez.DevAgent
> >
> > The topics that I want discuss are:
> > 1. hcid signals
> > In my opinion it is not necessary send signals to notity inquiry
> > start/complete. Only signals for news devices are enough.
>=20
> The idea behind also sending the InquiryStart and InquiryComplete events
> is that applications can show some graphical indications that the local
> device is now scanning for new devices in range. Since people can still
> call "hcitool scan" it is need for applications to know when someone
> else starts an inquiry.

> Another aspect is, inquiry result can contain repeated devices. This

> > approach could cause D-Bus app client overhead(inconsistency), by
> > other hand if periodic inquiry is active repeated signals must be sent
> > because more than one client can be filtering these signals and they
> > can start at different time. :)
>=20
> And the RSSI values may changes in the repeated reponses. The clients
> must do the filtering. There is no other way.


[Claudio Takahasi]
Remember that we need cover normal inquiry and periodic inquiry. For=20
periodic inquiry
I agree with this approach of send signals every time. We can implement a=
=20
cache=20
to make the inquiry fast/powerful. Two or more clients can request inquiry=
=20
at same=20
time, this is a normal scenario, but it can happen. For normal inquiry, we=
=20
can't
use hci_inquiry because it a blocking operation. The inquiry must be=20
integrated
in the main loop of the bluetoothd, using a HCI raw socket or the new=20
interface that=20
your are defining.

> 2. hcid and bluetoothd object path
> > What is the object path that you want use?
> > I suggested in an old email use a hierarchical paths. bluetoothd can
> > be the main object path provided at /org/bluez/bluetoothd, hci D-Bus
> > services could be provided at /org/bluez/bluetoothd/hci
>=20
> The general idea is to abstract from any daemon names or Bluetooth
> specification details. This makes it possible to reuse this interface
> with FreeBSD in the future.

[Claudio Takahasi]
I suggested previously use the bus name "org.bluez.bluetoothd", but do you=
=20
think=20
relevant participate on freedesktop project?

The bus name could be "org.freedesktop.Bluez"

I don't know what are the advantages and which rules we need respect.

> 3. D-Bus services
> > hci D-BUS services is the next step, I am going to starting coding
> > ASAP. Regarding inquiry requests, what kind of implementation do you
> > prefer, send method reply message or send only signals(like the
> > current)?
>=20
> We can do both, but I think signals should be preferred. This allows
> graphical applications to dynamically update their lists.


[Claudio Takahasi]=20
I agree. We need define exactly which signals are necessary. I am going=20
to update the specification document that I am writing and I will send you=
=20
soon.

> If you use signals, all D-Bus client capturing D-Bus hci signals are
> > able to see the new devices found. Using a method reply only the peer
> > (requestor) will receive. Using a method reply approach, we can
> > implement device class filters and avoid repeated devices. We have the
> > same problem for remote name, disconnect, authentication/security,
> > info, role switch and display connections.
>=20
> We should keep an eye on security, but the idea is to send stuff to
> everybody that is interested in it.
>=20
> > 4. bluetoothd
> > There are shared codes like(pand/bnep.c, pand/sdp.c, hidd/sdp.c, ...)
> > that we need be aware.
> > It is NOT clear for me how hcid and bluetoothd should work. hcid must
> > be running all the time, but the hci D-Bus service will be running
> > only if the system has a D-Bus system daemon running. Therefore, who
> > should register the hci object path? IMHO, bluetoothd should
> > centralize all D-Bus services. It will not be easy separate the
> > "normal" code from the "D-Bus code". Maybe your "new interface" that
> > your are defining can solve this problem.
>=20
> Once bluetoothd is in place hcid would no longer be needed.


[Claudio Takahasi]=20
hcid already contains the structure(main loop) required to register=20
D-Bus services, it will be easy implement the D-Bus services.

Regarding sdpd, currently an application have to connect(sdp_connect)=20
and stablish a session to register/update a service.=20
sdp D-Bus service shall be provided in the future, how do you=20
think it should work in this new scenario?

> 5. new interface
> > You said that a new interface for kernel and the userspace
> > communication is being defined. What is the current status?
>=20
> I am working on it.


[Claudio Takahasi]=20
Where is the CVS branch? If possible, send me the address.

Regards
>=20
> Marcel
>=20
>=20
>=20
>=20
> -------------------------------------------------------
> SF.Net email is sponsored by:
> Tame your development challenges with Apache's Geronimo App Server.
> Download it for free - -and be entered to win a 42" plasma tv or your ver=
y
> own Sony(tm)PSP. Click here to play: http://sourceforge.net/geronimo.php
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>

------=_Part_8855_14909712.1126793077956
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

[Claudio Takahasi]<br>
Hi Marcel,<br><br><div><span class=3D"gmail_quote">On 9/15/05, <b class=3D"=
gmail_sendername">Marcel Holtmann</b> &lt;<a href=3D"mailto:marcel@holtmann=
.org">marcel@holtmann.org</a>&gt; wrote:</span><blockquote class=3D"gmail_q=
uote" style=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0=
pt 0.8ex; padding-left: 1ex;">
Hi Claudio,<br><br>&gt; You said in an old e-mail that hcid is your playgro=
und for D-Bus<br>&gt; services. Probably, hcid D-Bus should be the starting=
 point for<br>&gt; bluetoothd.<br><br>since it is there and used, I think i=
t is a good idea. At the moment it
<br>is optional and so we can test it. At some point I will make bluez-util=
s<br>depend on D-Bus.<br><br>&gt; I would like to align your ideas to avoid=
 future reworks.<br>&gt;<br>&gt; D-Bus provides 4 types of messages:<br>
&gt; 1. Method call<br>&gt; 2. Method reply<br>&gt; 3. Signals<br>&gt; 4. E=
rror<br>&gt; Currently, only signals are sent. The following signals are se=
nt as<br>&gt; result of the hci commands:<br>&gt; - InquiryStart<br>&gt; - =
InquiryResult
<br>&gt; - InquiryComplete<br>&gt; - RemoteName<br>&gt; path: /org/bluez/De=
vAgent<br>&gt; interface: org.bluez.DevAgent<br>&gt;<br>&gt; The topics tha=
t I want discuss are:<br>&gt; 1. hcid signals<br>&gt; In my opinion it is n=
ot necessary send signals to notity inquiry
<br>&gt; start/complete. Only signals for news devices are enough.<br><br>T=
he idea behind also sending the InquiryStart and InquiryComplete events<br>=
is that applications can show some graphical indications that the local
<br>device is now scanning for new devices in range. Since people can still=
<br>call &quot;hcitool scan&quot; it is need for applications to know when =
someone<br>else starts an inquiry.</blockquote>&gt; Another aspect is, inqu=
iry result can contain repeated devices. This
<br>
<blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, =
204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">&gt; approach cou=
ld cause D-Bus app client overhead(inconsistency), by<br>&gt; other hand if=
 periodic inquiry is active repeated signals must be sent
<br>&gt; because more than one client can be filtering these signals and th=
ey<br>&gt; can start at different time. :)<br><br>And the RSSI values may c=
hanges in the repeated reponses. The clients<br>must do the filtering. Ther=
e is no other way.
</blockquote><div><br>
[Claudio Takahasi]<br>

Remember that we need cover&nbsp; normal inquiry and periodic inquiry. For =
periodic inquiry<br>

I agree with this approach of send signals every time. We can implement a c=
ache <br>
to make the inquiry fast/powerful. Two or more clients can request inquiry =
at same <br>
time, this is a normal scenario, but it can happen. For normal inquiry, we =
can't<br>
use hci_inquiry because it a blocking operation. The inquiry must be integr=
ated<br>
in the main loop of the bluetoothd, using a HCI raw socket or the new inter=
face that <br>
your are defining.<br>

&nbsp;</div><br><blockquote class=3D"gmail_quote" style=3D"border-left: 1px=
 solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">&=
gt; 2. hcid and bluetoothd object path<br>&gt; What is the object path that=
 you want use?
<br>&gt; I suggested in an old email use a hierarchical paths. bluetoothd c=
an<br>&gt; be the main object path provided at /org/bluez/bluetoothd, hci D=
-Bus<br>&gt; services could be provided at /org/bluez/bluetoothd/hci<br>
<br>The general idea is to abstract from any daemon names or Bluetooth<br>s=
pecification details. This makes it possible to reuse this interface<br>wit=
h FreeBSD in the future.</blockquote><div>[Claudio Takahasi]<br>
I suggested&nbsp; previously use the bus name &quot;org.bluez.bluetoothd&qu=
ot;, but&nbsp; do you think <br>
relevant participate on freedesktop project?<br>
<br>
The bus name could be &quot;org.freedesktop.Bluez&quot;<br>
<br>
I don't know what are the advantages and which rules we need respect.<br>
&nbsp;<br>
</div><blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb=
(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">&gt; 3. D-B=
us services<br>&gt; hci D-BUS services is the next step, I am going to star=
ting coding
<br>&gt; ASAP. Regarding inquiry requests, what kind of implementation do y=
ou<br>&gt; prefer, send method reply message or send only signals(like the<=
br>&gt; current)?<br><br>We can do both, but I think signals should be pref=
erred. This allows
<br>graphical applications to dynamically update their lists.</blockquote><=
div><br>
[Claudio Takahasi]&nbsp;</div>I agree. We need define exactly which signals=
 are necessary. I am going <br>
to update the specification document that I am writing and I will send you =
soon.<br>
<br><blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(2=
04, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">&gt; If you u=
se signals, all D-Bus client capturing D-Bus hci signals are<br>&gt; able t=
o see the new devices found. Using a method reply only the peer
<br>&gt; (requestor) will receive. Using a method reply approach, we can<br=
>&gt; implement device class filters and avoid repeated devices. We have th=
e<br>&gt; same problem for remote name, disconnect, authentication/security=
,
<br>&gt; info, role switch and display connections.<br><br>We should keep a=
n eye on security, but the idea is to send stuff to<br>everybody that is in=
terested in it.<br><br>&gt; 4. bluetoothd<br>&gt; There are shared codes li=
ke(pand/bnep.c, pand/sdp.c, hidd/sdp.c, ...)
<br>&gt; that we need be aware.<br>&gt; It is NOT clear for me how hcid and=
 bluetoothd should work. hcid must<br>&gt; be running all the time, but the=
 hci D-Bus service will be running<br>&gt; only if the system has a D-Bus s=
ystem daemon running. Therefore, who
<br>&gt; should register the hci object path? IMHO, bluetoothd should<br>&g=
t; centralize all D-Bus services. It will not be easy separate the<br>&gt; =
&quot;normal&quot; code from the &quot;D-Bus code&quot;. Maybe your &quot;n=
ew interface&quot; that
<br>&gt; your are defining can solve this problem.<br><br>Once bluetoothd i=
s in place hcid would no longer be needed.</blockquote><div><br>
[Claudio Takahasi] <br>
hcid already contains the structure(main loop) required to register <br>
D-Bus services, it will be easy implement the D-Bus services.<br>
<br>
Regarding sdpd, currently an&nbsp; application have to connect(sdp_connect)=
 <br>
and stablish a session to register/update a service. <br>
sdp D-Bus service shall&nbsp; be provided in the future, how do you <br>
think it should work in this new scenario?<br>
<br>
</div><blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb=
(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">&gt; 5. new=
 interface<br>&gt; You said that a new interface for kernel and the userspa=
ce
<br>&gt; communication is being defined. What is the current status?<br><br=
>I am working on it.</blockquote><div><br>
[Claudio Takahasi] <br>
Where is the CVS branch? If possible, send me the address.<br>
</div><br><blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid=
 rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">Regards=
<br><br>Marcel<br><br><br><br><br>-----------------------------------------=
--------------
<br>SF.Net email is sponsored by:<br>Tame your development challenges with =
Apache's Geronimo App Server.<br>Download it for free - -and be entered to =
win a 42&quot; plasma tv or your very<br>own Sony(tm)PSP.&nbsp;&nbsp;Click =
here to play:=20
<a href=3D"http://sourceforge.net/geronimo.php">http://sourceforge.net/gero=
nimo.php</a><br>_______________________________________________<br>Bluez-de=
vel mailing list<br><a href=3D"mailto:Bluez-devel@lists.sourceforge.net">Bl=
uez-devel@lists.sourceforge.net
</a><br><a href=3D"https://lists.sourceforge.net/lists/listinfo/bluez-devel=
">https://lists.sourceforge.net/lists/listinfo/bluez-devel</a><br></blockqu=
ote></div><br>

------=_Part_8855_14909712.1126793077956--


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
