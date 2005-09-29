Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <e1effdeb050929122670827a96@mail.gmail.com>
From: Claudio Takahasi <cktakahasi@gmail.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] hcid D-Bus patch
In-Reply-To: <1128011132.30743.8.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_781_16321165.1128022007568"
References: <e1effdeb05091607426f824afa@mail.gmail.com>
	 <e1effdeb05092209516bbcb31a@mail.gmail.com>
	 <1127411650.12287.15.camel@blade>
	 <e1effdeb05092307283e73c546@mail.gmail.com>
	 <e1effdeb050923101567fd59d4@mail.gmail.com>
	 <1127644396.6362.6.camel@localhost.localdomain>
	 <e1effdeb05092604597481f1a9@mail.gmail.com>
	 <1127897100.5321.13.camel@localhost.localdomain>
	 <e1effdeb05092812196392e0ac@mail.gmail.com>
	 <1128011132.30743.8.camel@localhost.localdomain>
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
Date: Thu, 29 Sep 2005 16:26:47 -0300

------=_Part_781_16321165.1128022007568
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Marcel,

I don't want define a group domain for evey group of access. I think you
didn't understand my idea. I defined fixed interfaces (org.bluez.manager or
org.bluez.devices) and path names based on device identification.

In the security policy file we can define rules according with our need. We
can define rules based on paths, interfaces, users, group ... or a
combination of these parameters. At first phase of bluetoothd development w=
e
need only define clear interfaces and path to make possible define security
policy easily in the future. We don't need thinking on define a group domai=
n
or rules at this momment.

The interfaces name will be shared by method call, method reply, errors and
signals. Remember that one path, can have a lot of interfaces. Interfaces i=
s
just a way to group a set of methods(services). Therefore, if you apply one
rule for a path, this rule will be applied for all interfaces that belongs
to this path.

Regarding the device identification in the path name, I prefer use hci(for
default kernel device), hci1, hci2, ... It's easier use the device id of
"evt_si_device" event. You suggested use the bluetooth address, for this
approach we can define a the default device(000000000000), and use the
string representation of bdaddr_t for the others devices. eg:"A089BE880D00"=
,
"E4A500461300" The final decision is yours.

I checked the libhal code, a similar approach is implemented. See how the
messages are created. The first argument of the dbus_message_new_method_cal=
l
function is the service bus name, the second is the path, the third is the
interface and
the last one is the member name(service). "udi" means unique device
identification.

LIBHAL side(client):

message =3D dbus_message_new_method_call ("org.freedesktop.Hal", udi,
"org.freedesktop.Hal.Device",
"GetAllProperties");
message =3D dbus_message_new_method_call ("org.freedesktop.Hal",
"/org/freedesktop/Hal/Manager",
"org.freedesktop.Hal.Manager",
"GetAllDevices");
message =3D dbus_message_new_method_call ("org.freedesktop.Hal", udi,
"org.freedesktop.Hal.Device",
"GetPropertyType");
message =3D dbus_message_new_method_call ("org.freedesktop.Hal", udi,
"org.freedesktop.Hal.Device",
"GetPropertyStringList");
message =3D dbus_message_new_method_call ("org.freedesktop.Hal", udi,
"org.freedesktop.Hal.Device",
"GetPropertyInteger");
message =3D dbus_message_new_method_call ("org.freedesktop.Hal", udi,
"org.freedesktop.Hal.Device",
"GetPropertyInteger");
message =3D dbus_message_new_method_call ("org.freedesktop.Hal", udi,
"org.freedesktop.Hal.Device",
"GetPropertyDouble");
In the server side - hald(daemon)
DBusHandlerResult
device_get_property (DBusConnection * connection, DBusMessage * message){
...
udi =3D dbus_message_get_path (message);
..
}

Basically, HAL has two interfaces, one for devices and another for the
manager. Each device has path registered in the system Bus, where the devic=
e
identification belongs to the path.

After this analysis I think we are following the right path.

Regards,
Claudio.

On 9/29/05, Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Claudio,
>
> > Regarding the DeviceList permission, It possible define rules for
> > allow/deny services based on interface name, path, user, groups,
> > message type, service name(member name), ...
> >
> > Therefore, provide just one interface or path is not a good idea
> > because we will not be able to create permission rules and a clean
> > API.
>
> my hope is to make the permission of the BlueZ D-Bus API more flexible
> and thus having a separate group "domain" for every group of access
> sounds totally stupid to me. The permissions shouldn't have to do
> anything with the logical structure of the API.
>
> People with more D-Bus experience than me please comment on it.
>
> > In my opinion, only a "bluez_admin" group should be able to use the
> > service under the "/org/bluez/Devices" path. These services are
> > related to device configuration(hciconfig). Application that don't
> > have enough
> > privileges will receive the error message:
> > org.freedesktop.DBus.Error.AccessDenied
> >
> > The other ordinary services under "org/bluez/Manager..." can be
> > available for everyone.
> >
> > Currently we are not providing any kind of session control. All
> > userspace applications will be able to control connections and
> > interfere in a connection used by other application.
>
> Maybe we should restrict this somehow, but I have no clue on how to do
> it at the moment. I am fully open to proposals.
>
> > Another subject is the logical function names. If you want support
> > multiple adapters, it's necessary export one new path for each
> > adapter. An adapter identification must belongs to the object path. My
> > suggestion is use hci(default kernel device), hci0, hci1, ... We can
> > suggest a more suitable message member name, like you suggested for
> > DeviceList, but for the object path I don't see an easiest way.
>
> We can always use the BD_ADDR instead and maybe also an alias that can
> be set by bluetoothd/hcid.
>
> > See below how I have want organize the service after your suggestions.
> >
> > >>> Device PATH
> > permission: only bluez_admin group
> > path: /org/bluez/device
> > interface: org.bluez.device
> >
> > >>> Manager PATH
> > permission: everyone
> > path: /org/bluez/Manager
> > interface: org.bluez.manager
>
> I think these are clear and they look good, but we should look at other
> D-Bus services how they design their API.
>
> > * Device Independent Service
> > path: "/org/bluez/manager"
> > interface: "org.bluez.manager" (signals and request)
> > comment: Always active
> > 1. Init (version check)
> > 2. DeviceList
> > 3. ListServices (list available services)
> > 4. Enable (Enable an service. eg: all pan related services)
> > 5. Disable
> >
> > * Device dependent Service
> > path: "/org/bluez/manager/hci/controller" (default HCI services)
> > path: "/org/bluez/manager/hci0/controller" (HCI services)
> > path: "/org/bluez/manager/hci1/controller" (HCI services)
> > path: "/org/bluez/manager/hci/pan" (default PAN services)
> > path: "/org/bluez/manager/hci0/pan" (PAN services)
> > path: "/org/bluez/manager/hci1/pan" (PAN services)
> > path: "/org/bluez/manager/hci/serial" (default RFCOMM services)
> > path: "/org/bluez/manager/hci0/serial" (RFCOMM services)
> > path: "/org/bluez/manager/hci1/serial" (RFCOMM services)
> > path: "/org/bluez/manager/hci/services" (default SDP publish/search)
> > path: "/org/bluez/manager/hci0/services" (services SDP
> > publish/search)
> > path: "/org/bluez/manager/hci1/services" (services SDP
> > publish/search)
>
> I like to use the word "default" to select the default device/service
> and "network" instead of "pan", because PAN is the way to go. The
> fallback to LAP is optional.
>
> > interface: "org.bluez.manager" (signals and request) can be shared
> > for all
> > manager services and signals.
> > comment: Available only when there is a device UP. The daemon must
> > monitor DEV_UP/DEV_DOWN events and register/unregister the path
> > dynamically. Each service will be accessible through the default path
> > and the device dependent path.
>
> Please check how HAL is handling the device register and unregister. I
> think their current interface is quite good.
>
> Regards
>
> Marcel
>
>
>
>
> -------------------------------------------------------
> This SF.Net email is sponsored by:
> Power Architecture Resource Center: Free content, downloads, discussions,
> and more. http://solutions.newsforge.com/ibmarch.tmpl
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>



--
---------------------------------------------------------
Claudio Takahasi
Nokia's Institute of Technology - INdT
claudio.takahasi@indt.org.br

------=_Part_781_16321165.1128022007568
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Marcel,<br>
<br>
I don't want define a group domain for evey group of access. I think
you didn't understand my idea. I defined fixed interfaces
(org.bluez.manager or org.bluez.devices) and path names based on device
identification. <br>
<br>
In the security policy file we can define rules according with our
need.&nbsp; We can define rules based on paths, interfaces, users,
group ... or a combination of these parameters. At first phase of
bluetoothd development we need only define clear interfaces and path to
make possible define security policy easily in the future. We don't
need thinking on define a group domain or rules at this momment.<br>
<br>
The interfaces name will be shared by method call, method reply, errors
and signals. Remember that one path, can have a lot of
interfaces.&nbsp; Interfaces is just a way to group a set of
methods(services). Therefore, if you apply one rule for a path, this
rule will be applied for all interfaces that belongs to this path.<br>
<br>
Regarding the device identification in the path name, I prefer use
hci(for default kernel device), hci1, hci2, ... It's easier use the
device id of &quot;evt_si_device&quot; event. You suggested use the bluetoo=
th
address, for this approach we can define a the default
device(000000000000), and use the string&nbsp; representation of
bdaddr_t for the others devices. eg:&quot;A089BE880D00&quot;, &quot;E4A5004=
61300&quot; The
final decision is yours.<br>
<br>
I checked the libhal code, a similar approach is implemented. See how
the messages are created. The first argument of the
dbus_message_new_method_call function is the service bus name, the
second is the path, the third is the interface and <br>
the last one is the member name(service). &quot;udi&quot; means unique devi=
ce identification.<br>
<br>
LIBHAL side(client):<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; message =3D dbus_message_new_met=
hod_call (&quot;org.freedesktop.Hal&quot;, udi,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&quot;org.freedesktop.Hal.Device&quot;,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&quot;GetAllProperties&quot;);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; message =3D dbus_message_new_met=
hod_call (&quot;org.freedesktop.Hal&quot;,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&quot;/org/freedesktop/Hal/Manager&quot;,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&quot;org.freedesktop.Hal.Manager&quot;,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&quot;GetAllDevices&quot;);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; message =3D dbus_message_new_met=
hod_call (&quot;org.freedesktop.Hal&quot;, udi,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&quot;org.freedesktop.Hal.Device&quot;,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&quot;GetPropertyType&quot;);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; message =3D dbus_message_new_met=
hod_call (&quot;org.freedesktop.Hal&quot;, udi,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&quot;org.freedesktop.Hal.Device&quot;,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&quot;GetPropertyStringList&quot;);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; message =3D dbus_message_new_met=
hod_call (&quot;org.freedesktop.Hal&quot;, udi,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&quot;org.freedesktop.Hal.Device&quot;,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&quot;GetPropertyInteger&quot;);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; message =3D dbus_message_new_met=
hod_call (&quot;org.freedesktop.Hal&quot;, udi,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&quot;org.freedesktop.Hal.Device&quot;,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&quot;GetPropertyInteger&quot;);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; message =3D dbus_message_new_met=
hod_call (&quot;org.freedesktop.Hal&quot;, udi,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&quot;org.freedesktop.Hal.Device&quot;,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&quot;GetPropertyDouble&quot;);<br>
In the server side - hald(daemon)<br>
DBusHandlerResult<br>
device_get_property (DBusConnection * connection, DBusMessage * message){<b=
r>
...<br>
udi =3D dbus_message_get_path (message);<br>
..<br>
}<br>
<br>
Basically, HAL has two interfaces, one for devices and another for the
manager. Each device has path registered in the system Bus, where the
device identification belongs to the path.<br>
<br>
After this analysis I think we are following the right path.<br>
<br>
Regards,<br>
Claudio.<br><br><div><span class=3D"gmail_quote">On 9/29/05, <b class=3D"gm=
ail_sendername">Marcel Holtmann</b> &lt;<a href=3D"mailto:marcel@holtmann.o=
rg">marcel@holtmann.org</a>&gt; wrote:</span><blockquote class=3D"gmail_quo=
te" style=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt=
 0.8ex; padding-left: 1ex;">
Hi Claudio,<br><br>&gt; Regarding the DeviceList permission, It possible de=
fine rules for<br>&gt; allow/deny services based on interface name, path, u=
ser, groups,<br>&gt; message type, service name(member name), ...<br>&gt;
<br>&gt; Therefore, provide just one interface or path is not a good idea<b=
r>&gt; because we will not be able to create permission rules and a clean<b=
r>&gt; API.<br><br>my hope is to make the permission of the BlueZ D-Bus API=
 more flexible
<br>and thus having a separate group &quot;domain&quot; for every group of =
access<br>sounds totally stupid to me. The permissions shouldn't have to do=
<br>anything with the logical structure of the API.<br><br>People with more=
 D-Bus experience than me please comment on it.
<br><br>&gt; In my opinion, only a &quot;bluez_admin&quot; group should be =
able to use the<br>&gt; service under the &quot;/org/bluez/Devices&quot; pa=
th. These services are<br>&gt; related to device configuration(hciconfig). =
Application that don't
<br>&gt; have enough<br>&gt; privileges will receive the error message:<br>=
&gt; org.freedesktop.DBus.Error.AccessDenied<br>&gt;<br>&gt; The other ordi=
nary services under &quot;org/bluez/Manager...&quot; can be<br>&gt; availab=
le for everyone.
<br>&gt;<br>&gt; Currently we are not providing any kind of session control=
. All<br>&gt; userspace applications will be able to control connections an=
d<br>&gt; interfere in a connection used by other application.<br><br>Maybe=
 we should restrict this somehow, but I have no clue on how to do
<br>it at the moment. I am fully open to proposals.<br><br>&gt; Another sub=
ject is the logical function names. If you want support<br>&gt; multiple ad=
apters, it's necessary export one new path for each<br>&gt; adapter. An ada=
pter identification must belongs to the object path. My
<br>&gt; suggestion is use hci(default kernel device), hci0, hci1, ... We c=
an<br>&gt; suggest a more suitable message member name, like you suggested =
for<br>&gt; DeviceList, but for the object path I don't see an easiest way.
<br><br>We can always use the BD_ADDR instead and maybe also an alias that =
can<br>be set by bluetoothd/hcid.<br><br>&gt; See below how I have want org=
anize the service after your suggestions.<br>&gt;<br>&gt; &gt;&gt;&gt; Devi=
ce PATH
<br>&gt; permission: only bluez_admin group<br>&gt; path: /org/bluez/device=
<br>&gt; interface: org.bluez.device<br>&gt;<br>&gt; &gt;&gt;&gt; Manager P=
ATH<br>&gt; permission: everyone<br>&gt; path: /org/bluez/Manager<br>&gt; i=
nterface:=20
org.bluez.manager<br><br>I think these are clear and they look good, but we=
 should look at other<br>D-Bus services how they design their API.<br><br>&=
gt; * Device Independent Service<br>&gt;&nbsp;&nbsp;path: &quot;/org/bluez/=
manager&quot;
<br>&gt;&nbsp;&nbsp;interface: &quot;org.bluez.manager&quot; (signals and r=
equest)<br>&gt;&nbsp;&nbsp;comment: Always active<br>&gt;&nbsp;&nbsp;&nbsp;=
&nbsp;1. Init (version check)<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;2. DeviceList<=
br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;3. ListServices (list available services)<br=
>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;4. Enable (Enable an service. eg: all pan relat=
ed services)<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;5. Disable<br>&gt;<br>&gt; * De=
vice dependent Service<br>&gt;&nbsp;&nbsp;path: &quot;/org/bluez/manager/hc=
i/controller&quot; (default HCI services)<br>&gt;&nbsp;&nbsp;path: &quot;/o=
rg/bluez/manager/hci0/controller&quot; (HCI services)
<br>&gt;&nbsp;&nbsp;path: &quot;/org/bluez/manager/hci1/controller&quot; (H=
CI services)<br>&gt;&nbsp;&nbsp;path: &quot;/org/bluez/manager/hci/pan&quot=
; (default PAN services)<br>&gt;&nbsp;&nbsp;path: &quot;/org/bluez/manager/=
hci0/pan&quot; (PAN services)
<br>&gt;&nbsp;&nbsp;path: &quot;/org/bluez/manager/hci1/pan&quot; (PAN serv=
ices)<br>&gt;&nbsp;&nbsp;path: &quot;/org/bluez/manager/hci/serial&quot; (d=
efault RFCOMM services)<br>&gt;&nbsp;&nbsp;path: &quot;/org/bluez/manager/h=
ci0/serial&quot; (RFCOMM services)
<br>&gt;&nbsp;&nbsp;path: &quot;/org/bluez/manager/hci1/serial&quot; (RFCOM=
M services)<br>&gt;&nbsp;&nbsp;path: &quot;/org/bluez/manager/hci/services&=
quot; (default SDP publish/search)<br>&gt;&nbsp;&nbsp;path: &quot;/org/blue=
z/manager/hci0/services&quot; (services SDP
<br>&gt; publish/search)<br>&gt;&nbsp;&nbsp;path: &quot;/org/bluez/manager/=
hci1/services&quot; (services SDP<br>&gt; publish/search)<br><br>I like to =
use the word &quot;default&quot; to select the default device/service<br>an=
d &quot;network&quot; instead of &quot;pan&quot;, because PAN is the way to=
 go. The
<br>fallback to LAP is optional.<br><br>&gt;&nbsp;&nbsp;interface: &quot;or=
g.bluez.manager&quot; (signals and request) can be shared<br>&gt; for all<b=
r>&gt;&nbsp;&nbsp;manager services and signals.<br>&gt;&nbsp;&nbsp;comment:=
 Available only when there is a device UP. The daemon must
<br>&gt; monitor&nbsp;&nbsp;DEV_UP/DEV_DOWN events and register/unregister =
the path<br>&gt; dynamically. Each&nbsp;&nbsp;service will be accessible th=
rough the default path<br>&gt; and the device&nbsp;&nbsp;dependent path.<br=
><br>Please check how HAL is handling the device register and unregister. I
<br>think their current interface is quite good.<br><br>Regards<br><br>Marc=
el<br><br><br><br><br>-----------------------------------------------------=
--<br>This SF.Net email is sponsored by:<br>Power Architecture Resource Cen=
ter: Free content, downloads, discussions,
<br>and more. <a href=3D"http://solutions.newsforge.com/ibmarch.tmpl">http:=
//solutions.newsforge.com/ibmarch.tmpl</a><br>_____________________________=
__________________<br>Bluez-devel mailing list<br><a href=3D"mailto:Bluez-d=
evel@lists.sourceforge.net">
Bluez-devel@lists.sourceforge.net</a><br><a href=3D"https://lists.sourcefor=
ge.net/lists/listinfo/bluez-devel">https://lists.sourceforge.net/lists/list=
info/bluez-devel</a><br></blockquote></div><br><br clear=3D"all"><br>-- <br=
>
---------------------------------------------------------<br>Claudio Takaha=
si<br>Nokia's Institute of Technology - INdT<br><a href=3D"mailto:claudio.t=
akahasi@indt.org.br">claudio.takahasi@indt.org.br</a><br>

------=_Part_781_16321165.1128022007568--


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
