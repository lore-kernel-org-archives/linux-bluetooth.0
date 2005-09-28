Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <3013cac80509281253332728c3@mail.gmail.com>
From: Eduardo Rocha <folhabranca@gmail.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] hcid D-Bus patch
In-Reply-To: <e1effdeb05092812196392e0ac@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_1059_4109889.1127937188380"
References: <e1effdeb05091607426f824afa@mail.gmail.com>
	 <1127398647.5344.24.camel@blade>
	 <e1effdeb05092209516bbcb31a@mail.gmail.com>
	 <1127411650.12287.15.camel@blade>
	 <e1effdeb05092307283e73c546@mail.gmail.com>
	 <e1effdeb050923101567fd59d4@mail.gmail.com>
	 <1127644396.6362.6.camel@localhost.localdomain>
	 <e1effdeb05092604597481f1a9@mail.gmail.com>
	 <1127897100.5321.13.camel@localhost.localdomain>
	 <e1effdeb05092812196392e0ac@mail.gmail.com>
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
Date: Wed, 28 Sep 2005 16:53:08 -0300

------=_Part_1059_4109889.1127937188380
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Claudio,

I'm new to the bluez world, but I'd like to make some questions. I've seen
in your last email that you are suggesting that "everyone" will be able to
call methods from Manager interface. Are you planning to make the Manager
interface provide only query style methods or will every one able to change
configurations (e.g pan configuration).

Br,
Eduardo.


On 9/28/05, Claudio Takahasi <cktakahasi@gmail.com> wrote:
>
> Hi Marcel,
>
> Regarding the DeviceList permission, It possible define rules for
> allow/deny services based on interface name, path, user, groups, message
> type, service name(member name), ...
>
> Therefore, provide just one interface or path is not a good idea because
> we will not be able to create permission rules and a clean API.
>
> In my opinion, only a "bluez_admin" group should be able to use the
> service under the "/org/bluez/Devices" path. These services are related t=
o
> device configuration(hciconfig). Application that don't have enough
> privileges will receive the error message:
> org.freedesktop.DBus.Error.AccessDenied
>
> The other ordinary services under "org/bluez/Manager..." can be available
> for everyone.
>
> Currently we are not providing any kind of session control. All userspace
> applications will be able to control connections and interfere in a
> connection used by other application.
>
> Another subject is the logical function names. If you want support
> multiple adapters, it's necessary export one new path for each adapter. A=
n
> adapter identification must belongs to the object path. My suggestion is =
use
> hci(default kernel device), hci0, hci1, ... We can suggest a more suitabl=
e
> message member name, like you suggested for DeviceList, but for the objec=
t
> path I don't see an easiest way.
>
> See below how I have want organize the service after your suggestions.
>
> >>> Device PATH
> permission: only bluez_admin group
> path: /org/bluez/device
> interface: org.bluez.device
>
> >>> Manager PATH
> permission: everyone
> path: /org/bluez/Manager
> interface: org.bluez.manager
>
> * Device Independent Service
> path: "/org/bluez/manager"
> interface: "org.bluez.manager" (signals and request)
> comment: Always active
> 1. Init (version check)
> 2. DeviceList
> 3. ListServices (list available services)
> 4. Enable (Enable an service. eg: all pan related services)
> 5. Disable
>
> * Device dependent Service
> path: "/org/bluez/manager/hci/controller" (default HCI services)
> path: "/org/bluez/manager/hci0/controller" (HCI services)
> path: "/org/bluez/manager/hci1/controller" (HCI services)
> path: "/org/bluez/manager/hci/pan" (default PAN services)
> path: "/org/bluez/manager/hci0/pan" (PAN services)
> path: "/org/bluez/manager/hci1/pan" (PAN services)
> path: "/org/bluez/manager/hci/serial" (default RFCOMM services)
> path: "/org/bluez/manager/hci0/serial" (RFCOMM services)
> path: "/org/bluez/manager/hci1/serial" (RFCOMM services)
> path: "/org/bluez/manager/hci/services" (default SDP publish/search)
> path: "/org/bluez/manager/hci0/services" (services SDP publish/search)
> path: "/org/bluez/manager/hci1/services" (services SDP publish/search)
>
> interface: "org.bluez.manager" (signals and request) can be shared for al=
l
>
> manager services and signals.
> comment: Available only when there is a device UP. The daemon must monito=
r
> DEV_UP/DEV_DOWN events and register/unregister the path dynamically. Each
> service will be accessible through the default path and the device depend=
ent
> path.
>
> Regards,
> Claudio.
>
>
> On 9/28/05, Marcel Holtmann <marcel@holtmann.org> wrote:
> >
> > Hi Claudio,
> >
> > > Define clear object paths and interfaces will make easier define rule=
s
> > > in the D-Bus configuration file. In this file it's possible specify
> > > the permissions for send and receive messages based on the interfaces=
,
> >
> > > paths and users/groups.
> > >
> > > Based on your comment I suggested the paths and interfaces. Defining
> > > this structure it's possible allow only the "root" or a "bluez
> > > manager" user/group change the adapter settings.
> > >
> > >
> > > SERVICE BUS NAME: org.bluez
> > >
> > > <=3D=3D=3D=3D=3D=3D=3D Device =3D=3D=3D=3D=3D=3D>
> > > description: device specific configuration services. eg: (#1)display
> > > local devices, inqmode, inqtype, up, down, reset, auth, noauth,
> > > encrypt, ...
> > >
> > > object path: /org/bluez/Device
> > > interface: /org/bluez/Device
> >
> > this looks good to me.
> >
> > > <=3D=3D=3D=3D=3D=3D=3D Manager =3D=3D=3D=3D=3D=3D>
> > > description: connection services. eg: inquiry, remote name, info,
> > > master/slave role switch, active connecions and profile specific
> > > tasks.
> > > Multiple local adapters scenario will be considered. The default
> > > object path and the adapter specific paths will provide the same
> > > services.
> > >
> > > /***** HCI ******/
> > > default object path:/org/bluez/Manager/hci (will use the default
> > > device in the kernel)
> > > object path: /org/bluez/Manager/hci0/hci
> > > object path: /org/bluez/Manager/hci1/hci
> > > interface: org.bluez.Manager.hci
> > >
> > > /***** SDP ******/
> > > default object path:/org/bluez/Manager/sdp
> > > object path: /org/bluez/Manager/hci0/sdp
> > > object path: /org/bluez/Manager/hci1/sdp
> > > interface: org.bluez.Manager.sdp
> > >
> > > /***** PAN ******/
> > > default object path:/org/bluez/Manager/pan
> > > object path: /org/bluez/Manager/hci0/pan
> > > object path: /org/bluez/Manager/hci1/pan
> > > interface: org.bluez.Manager.pan
> > >
> > > /***** RFCOMM ******/
> > > default object path:/org/bluez/Manager/rfcomm
> > > object path: /org/bluez/Manager/hci0/rfcomm
> > > object path: /org/bluez/Manager/hci1/rfcomm
> > > interface: org.bluez.Manager.rfcomm
> >
> > Actually my plan is to don't use names like hci, sdp, rfcomm etc. at
> > all. We should define logical function names. The user of the D-Bus API
> > shouldn't need any Bluetooth protocol knowledge at all. So the idea
> > would be call it discovery, network etc.
> >
> > > (#1) Probably the display local devices should be moved to other path
> > > due the permissions that I comment before. User applications should
> > > be able list the local adapters to use in the pan, rfcomm, sdp ...
> >
> > We maybe make Manager.DeviceList accessable by everybody. Are such
> > things possible?
> >
> > > For me, your suggestion or my last suggestion are fine, both can
> > > address the permissions. You have the decision in your hands! :)
> >
> > I like to have feedback and serious comments about, because I am still
> > in the process to open my mind for D-Bus.
> >
> > Regards
> >
> > Marcel
> >
> >
> >
> >
> > -------------------------------------------------------
> > This SF.Net email is sponsored by:
> > Power Architecture Resource Center: Free content, downloads,
> > discussions,
> > and more. http://solutions.newsforge.com/ibmarch.tmpl
> > _______________________________________________
> > Bluez-devel mailing list
> > Bluez-devel@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/bluez-devel
> >
>
>
>
> --
> ---------------------------------------------------------
> Claudio Takahasi
> Instituto Nokia de Tecnologia - INdT
> claudio.takahasi@indt.org.br
>

------=_Part_1059_4109889.1127937188380
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Claudio,<br>
<br>
I'm new to the bluez world, but I'd like to make&nbsp; some questions.
I've seen in your last email that you are suggesting&nbsp; that&nbsp;
&quot;everyone&quot; will be able to call methods from Manager interface. A=
re you
planning to make the Manager interface provide only query style methods
or will every one able to change configurations (e.g pan
configuration). <br>
<br>
Br,<br>
Eduardo.<br>
<br><br><div><span class=3D"gmail_quote">On 9/28/05, <b class=3D"gmail_send=
ername">Claudio Takahasi</b> &lt;<a href=3D"mailto:cktakahasi@gmail.com">ck=
takahasi@gmail.com</a>&gt; wrote:</span><blockquote class=3D"gmail_quote" s=
tyle=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8e=
x; padding-left: 1ex;">
Hi Marcel,<br>
<br>
Regarding the DeviceList permission, It possible define rules for
allow/deny services based on interface name, path, user, groups,
message type, service name(member name), ...<br>
<br>
Therefore, provide just one interface or path is not a good idea
because we will not be able to create permission rules and a clean API.<br>
<br>
In my opinion, only a &quot;bluez_admin&quot; group should be able to use t=
he
service under the &quot;/org/bluez/Devices&quot; path. These services are r=
elated
to device configuration(hciconfig). Application that don't have enough <br>
privileges will receive the error message: org.freedesktop.DBus.Error.Acces=
sDenied<br>
<br>
The other ordinary services under &quot;org/bluez/Manager...&quot; can be a=
vailable for everyone.<br>
<br>
Currently we are not providing any kind of session control. All
userspace applications will be able to control connections and
interfere in a connection used by other application.<br>
<br>
Another subject is the logical function names. If you want support
multiple adapters, it's necessary export one new path for each adapter.
An adapter identification must belongs to the object path. My
suggestion is use hci(default kernel device), hci0, hci1, ... We can
suggest a more suitable message member name, like you suggested for
DeviceList, but for the object path I don't see an easiest way.<br>
<br>
See below how I have want organize the service after your suggestions.<br>
<br>
&gt;&gt;&gt; Device PATH <br>
permission: only bluez_admin group<br>
path: /org/bluez/device<br>
interface: org.bluez.device<br>
<br>
&gt;&gt;&gt; Manager PATH<br>
permission: everyone<br>
path: /org/bluez/Manager<br>
interface: org.bluez.manager<br>
<br>
* Device Independent Service<br>
&nbsp;path: &quot;/org/bluez/manager&quot; <br>
&nbsp;interface: &quot;org.bluez.manager&quot; (signals and request)<br>
&nbsp;comment: Always active<br>
&nbsp;&nbsp; 1. Init (version check)<br>
&nbsp;&nbsp; 2. DeviceList<br>
&nbsp;&nbsp; 3. ListServices (list available services)<br>
&nbsp;&nbsp; 4. Enable (Enable an service. eg: all pan related services)<br=
>
&nbsp;&nbsp; 5. Disable <br>
<br>
* Device dependent Service<br>
&nbsp;path: &quot;/org/bluez/manager/hci/controller&quot; (default HCI serv=
ices)<br>
&nbsp;path: &quot;/org/bluez/manager/hci0/controller&quot; (HCI services)<b=
r>
&nbsp;path: &quot;/org/bluez/manager/hci1/controller&quot; (HCI services)<b=
r>
&nbsp;path: &quot;/org/bluez/manager/hci/pan&quot; (default PAN services)<b=
r>
&nbsp;path: &quot;/org/bluez/manager/hci0/pan&quot; (PAN services)<br>
&nbsp;path: &quot;/org/bluez/manager/hci1/pan&quot; (PAN services)<br>
&nbsp;path: &quot;/org/bluez/manager/hci/serial&quot; (default RFCOMM servi=
ces)<br>
&nbsp;path: &quot;/org/bluez/manager/hci0/serial&quot; (RFCOMM services)<br=
>
&nbsp;path: &quot;/org/bluez/manager/hci1/serial&quot; (RFCOMM services)<br=
>
&nbsp;path: &quot;/org/bluez/manager/hci/services&quot; (default SDP publis=
h/search)<br>
&nbsp;path: &quot;/org/bluez/manager/hci0/services&quot; (services SDP publ=
ish/search)<br>
&nbsp;path: &quot;/org/bluez/manager/hci1/services&quot; (services SDP publ=
ish/search)<br>
<br>
&nbsp;interface: &quot;org.bluez.manager&quot; (signals and request) can be=
 shared for all <br>
&nbsp;manager services and signals.<br>
&nbsp;comment: Available only when there is a device UP. The daemon
must monitor&nbsp; DEV_UP/DEV_DOWN events and register/unregister the
path dynamically. Each&nbsp; service will be accessible through the
default path and the device&nbsp; dependent path.<br>
<br>
Regards,<br>
Claudio.<div><span class=3D"e" id=3D"q_1069e2e92ed694f5_1"><br>
<br><br><div><span class=3D"gmail_quote">On 9/28/05, <b class=3D"gmail_send=
ername">Marcel Holtmann</b> &lt;<a href=3D"mailto:marcel@holtmann.org" targ=
et=3D"_blank" onclick=3D"return top.js.OpenExtLink(window,event,this)">marc=
el@holtmann.org
</a>&gt; wrote:</span><blockquote class=3D"gmail_quote" style=3D"border-lef=
t: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1=
ex;">
Hi Claudio,<br><br>&gt; Define clear object paths and interfaces will make =
easier define rules<br>&gt; in the D-Bus configuration file. In this file i=
t's possible specify<br>&gt; the permissions for send and receive messages =
based on the interfaces,
<br>&gt; paths and users/groups.<br>&gt;<br>&gt; Based on your comment I su=
ggested the paths and interfaces. Defining<br>&gt; this structure it's poss=
ible allow only the &quot;root&quot; or a &quot;bluez<br>&gt; manager&quot;=
 user/group change the adapter settings.
<br>&gt;<br>&gt;<br>&gt; SERVICE BUS NAME: org.bluez<br>&gt;<br>&gt; &lt;=
=3D=3D=3D=3D=3D=3D=3D Device =3D=3D=3D=3D=3D=3D&gt;<br>&gt; description: de=
vice specific configuration services. eg: (#1)display<br>&gt; local devices=
, inqmode, inqtype, up, down, reset, auth, noauth,
<br>&gt; encrypt, ...<br>&gt;<br>&gt; object path: /org/bluez/Device<br>&gt=
; interface: /org/bluez/Device<br><br>this looks good to me.<br><br>&gt; &l=
t;=3D=3D=3D=3D=3D=3D=3D Manager =3D=3D=3D=3D=3D=3D&gt;<br>&gt; description:=
 connection services. eg: inquiry, remote name, info,
<br>&gt; master/slave role switch, active connecions and profile specific<b=
r>&gt; tasks.<br>&gt; Multiple local adapters scenario will be considered. =
The default<br>&gt; object path and the adapter specific paths will provide=
 the same
<br>&gt; services.<br>&gt;<br>&gt; /***** HCI ******/<br>&gt; default objec=
t path:/org/bluez/Manager/hci (will use the default<br>&gt; device in the k=
ernel)<br>&gt; object path: /org/bluez/Manager/hci0/hci<br>&gt; object path=
: /org/bluez/Manager/hci1/hci
<br>&gt; interface: org.bluez.Manager.hci<br>&gt;<br>&gt; /***** SDP ******=
/<br>&gt; default object path:/org/bluez/Manager/sdp<br>&gt; object path: /=
org/bluez/Manager/hci0/sdp<br>&gt; object path: /org/bluez/Manager/hci1/sdp
<br>&gt; interface: org.bluez.Manager.sdp<br>&gt;<br>&gt; /***** PAN ******=
/<br>&gt; default object path:/org/bluez/Manager/pan<br>&gt; object path: /=
org/bluez/Manager/hci0/pan<br>&gt; object path: /org/bluez/Manager/hci1/pan
<br>&gt; interface: org.bluez.Manager.pan<br>&gt;<br>&gt; /***** RFCOMM ***=
***/<br>&gt; default object path:/org/bluez/Manager/rfcomm<br>&gt; object p=
ath: /org/bluez/Manager/hci0/rfcomm<br>&gt; object path: /org/bluez/Manager=
/hci1/rfcomm
<br>&gt; interface: org.bluez.Manager.rfcomm<br><br>Actually my plan is to =
don't use names like hci, sdp, rfcomm etc. at<br>all. We should define logi=
cal function names. The user of the D-Bus API<br>shouldn't need any Bluetoo=
th protocol knowledge at all. So the idea
<br>would be call it discovery, network etc.<br><br>&gt; (#1) Probably the =
display local devices should be moved to other path<br>&gt; due the permiss=
ions that I comment before. User&nbsp;&nbsp;applications should<br>&gt; be =
able list the local adapters to use in the pan, rfcomm, sdp ...
<br><br>We maybe make Manager.DeviceList accessable by everybody. Are such<=
br>things possible?<br><br>&gt; For me, your suggestion or my last suggesti=
on are fine, both can<br>&gt; address the permissions. You have the decisio=
n in your hands! :)
<br><br>I like to have feedback and serious comments about, because I am st=
ill<br>in the process to open my mind for D-Bus.<br><br>Regards<br><br>Marc=
el<br><br><br><br><br>-----------------------------------------------------=
--
<br>This SF.Net email is sponsored by:<br>Power Architecture Resource Cente=
r: Free content, downloads, discussions,<br>and more. <a href=3D"http://sol=
utions.newsforge.com/ibmarch.tmpl" target=3D"_blank" onclick=3D"return top.=
js.OpenExtLink(window,event,this)">
http://solutions.newsforge.com/ibmarch.tmpl
</a><br>_______________________________________________<br>Bluez-devel mail=
ing list<br><a href=3D"mailto:Bluez-devel@lists.sourceforge.net" target=3D"=
_blank" onclick=3D"return top.js.OpenExtLink(window,event,this)">Bluez-deve=
l@lists.sourceforge.net
</a><br><a href=3D"https://lists.sourceforge.net/lists/listinfo/bluez-devel=
" target=3D"_blank" onclick=3D"return top.js.OpenExtLink(window,event,this)=
">
https://lists.sourceforge.net/lists/listinfo/bluez-devel</a><br></blockquot=
e></div><br><br clear=3D"all"><br></span></div><span class=3D"sg">-- <br>--=
-------------------------------------------------------<br>Claudio Takahasi
<br>Instituto Nokia de Tecnologia - INdT
<br><a href=3D"mailto:claudio.takahasi@indt.org.br" target=3D"_blank" oncli=
ck=3D"return top.js.OpenExtLink(window,event,this)">claudio.takahasi@indt.o=
rg.br</a><br>

</span></blockquote></div><br>

------=_Part_1059_4109889.1127937188380--


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
