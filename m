Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <e1effdeb050930075263b62ffb@mail.gmail.com>
From: Claudio Takahasi <cktakahasi@gmail.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] hcid D-Bus patch
In-Reply-To: <1128069460.4955.25.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_5451_23632457.1128091938444"
References: <e1effdeb05091607426f824afa@mail.gmail.com>
	 <e1effdeb05092307283e73c546@mail.gmail.com>
	 <e1effdeb050923101567fd59d4@mail.gmail.com>
	 <1127644396.6362.6.camel@localhost.localdomain>
	 <e1effdeb05092604597481f1a9@mail.gmail.com>
	 <1127897100.5321.13.camel@localhost.localdomain>
	 <e1effdeb05092812196392e0ac@mail.gmail.com>
	 <1128011132.30743.8.camel@localhost.localdomain>
	 <e1effdeb050929122670827a96@mail.gmail.com>
	 <1128069460.4955.25.camel@localhost.localdomain>
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
Date: Fri, 30 Sep 2005 11:52:18 -0300

------=_Part_5451_23632457.1128091938444
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Marcel,

We CAN'T use the full string representation of the bluetooth address.
According with D-Bus specification the path name is restricted to
"[A-Z][a-z][0-9]_". The character ":" is not allowed. See the rules:
"* The path may be of any length.
* The path must begin with an ASCII '/' (integer 47) character, and must
consist of elements separated by slash characters.
* Each element must only contain the ASCII characters "[A-Z][a-z][0-9]_"
* No element may be the empty string.
* Multiple '/' characters cannot occur in sequence.
* A trailing '/' character is not allowed unless the path is the root path
(a single '/' character)."


Which approach do you want now ? :)




More inforamtion how D-Bus paths works:
This is just to explain to you how DBus paths works and try pass an useful
information. If we analize HAL API deeply you will notice a small
difference, HAL provide a Manager interface used to recover the
devices(including paths) information. The Device interface is used by
clients that want change/get ONE DEVICE property.

Interfaces:
org.freedesktop.Hal.Manager
org.freedesktop.Hal.Device

Manager interface services:
- GetAllDevices
- DeviceExists
- FindDeviceByCapability
....

Device interface services:
- GetProperty
- SetProperty
- Lock
- Unlock
...

Path example:
/org/freedesktop/Hal/devices/usb_device_a12_1_noserial_if0 (iface
org.freedesktop.Hal.Device)

One path represents a unique identification to where a message is sent. In
the code that I am developing there is only one D-Bus message handler, the
path will be the primary element to know which local adapter use. Remember
that each path will provide a set of services, and each path can has more
than one interface.

We are using the path "/org/bluez/Manager" to provide to userspace
application services to list ACTIVE devices and enable/disable services. Th=
e
path "/org/bluez/Devices" will be restricted to device setup. Therefore, th=
e
message format used in "/org/bluez/Devices" path should contains one
arguments to indicate the device identification, like hciconfig uses. For
the messages send under the path "/org/bluez/Manager/BDADDR/..." is not
necessary send this argument because the path already contains the device
identification.

The prefix "/org/bluez/Manager" used before device based path is not realy
necessary. It is used only to make easier find services under this
hierarchy.

HAL DOESN'T provide an extra path as we are doing for device setup
"/org/bluez/Devices" all paths are device based. If you want copy exactly
HAL paths principle, we should have:
/org/bluez/Manager
/org/bluez/Devices/BDADDR/Hciconfig (always active)
/org/bluez/Devices/BDADDR/Hciconfig (always active)
/org/bluez/Devices/BDADDR/Controller (if dev is UP)
/org/bluez/Devices/default/Controller (if dev is UP)
/org/bluez/Devices/BDADDR/Net (if dev is UP)
/org/bluez/Devices/default/Net (if dev is UP)

And use two interfaces:
org.bluez.Manager
org.bluez.Devices



I will send a new patch in the next email.

Regards,
Claudio.


On 9/30/05, Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Claudio,
>
> > I don't want define a group domain for evey group of access. I think
> > you didn't understand my idea. I defined fixed interfaces
> > (org.bluez.manager or org.bluez.devices) and path names based on
> > device identification.
>
> this might be true, because I am a total newbie when it comes to D-Bus
> security. I have to rely on other peoples investigation here.
>
> > In the security policy file we can define rules according with our
> > need. We can define rules based on paths, interfaces, users,
> > group ... or a combination of these parameters. At first phase of
> > bluetoothd development we need only define clear interfaces and path
> > to make possible define security policy easily in the future. We don't
> > need thinking on define a group domain or rules at this momment.
> >
> > The interfaces name will be shared by method call, method reply,
> > errors and signals. Remember that one path, can have a lot of
> > interfaces. Interfaces is just a way to group a set of
> > methods(services). Therefore, if you apply one rule for a path, this
> > rule will be applied for all interfaces that belongs to this path.
>
> This means we will have a generell restricted policy and we create some
> holes to make specific calls available for normal users.
>
> > Regarding the device identification in the path name, I prefer use
> > hci(for default kernel device), hci1, hci2, ... It's easier use the
> > device id of "evt_si_device" event. You suggested use the bluetooth
> > address, for this approach we can define a the default
> > device(000000000000), and use the string representation of bdaddr_t
> > for the others devices. eg:"A089BE880D00", "E4A500461300" The final
> > decision is yours.
>
> I will go with "default", because at some point I might make the HCI
> device identifier strings changeable, like we can do for Ethernet. The
> BDADDR_ANY is not needed, but we can do this. However this means that I
> have to implement a possibility to define a default device inside the
> kernel. Otherwise BDADDR_ANY in D-Bus and inside the kernel might end up
> in two different devices. For the address representation I will use the
> string representation "00:11:22:33:44:55", because this is how normal
> users will see the address and there is no need to obfuscate the address
> for it.
>
> > I checked the libhal code, a similar approach is implemented. See how
> > the messages are created. The first argument of the
> > dbus_message_new_method_call function is the service bus name, the
> > second is the path, the third is the interface and
> > the last one is the member name(service). "udi" means unique device
> > identification.
> >
> > LIBHAL side(client):
> >
> > message =3D dbus_message_new_method_call ("org.freedesktop.Hal",
> > udi,
> >
> > "org.freedesktop.Hal.Device",
> > "GetAllProperties");
> > message =3D dbus_message_new_method_call ("org.freedesktop.Hal",
> >
> > "/org/freedesktop/Hal/Manager",
> >
> > "org.freedesktop.Hal.Manager",
> > "GetAllDevices");
> > message =3D dbus_message_new_method_call ("org.freedesktop.Hal",
> > udi,
> >
> > "org.freedesktop.Hal.Device",
> > "GetPropertyType");
> > message =3D dbus_message_new_method_call ("org.freedesktop.Hal",
> > udi,
> >
> > "org.freedesktop.Hal.Device",
> >
> > "GetPropertyStringList");
> > message =3D dbus_message_new_method_call ("org.freedesktop.Hal",
> > udi,
> >
> > "org.freedesktop.Hal.Device",
> > "GetPropertyInteger");
> > message =3D dbus_message_new_method_call ("org.freedesktop.Hal",
> > udi,
> >
> > "org.freedesktop.Hal.Device",
> > "GetPropertyInteger");
> > message =3D dbus_message_new_method_call ("org.freedesktop.Hal",
> > udi,
> >
> > "org.freedesktop.Hal.Device",
> > "GetPropertyDouble");
> > In the server side - hald(daemon)
> > DBusHandlerResult
> > device_get_property (DBusConnection * connection, DBusMessage *
> > message){
> > ...
> > udi =3D dbus_message_get_path (message);
> > ..
> > }
> >
> > Basically, HAL has two interfaces, one for devices and another for the
> > manager. Each device has path registered in the system Bus, where the
> > device identification belongs to the path.
> >
> > After this analysis I think we are following the right path.
>
> I think so, too. Please send in a new patch. We need something to get
> started and as you, I like it step by step.
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

------=_Part_5451_23632457.1128091938444
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Marcel,<br>
<br>
We CAN'T use the full string representation of the bluetooth address.
According with D-Bus specification the path name is restricted to
&quot;[A-Z][a-z][0-9]_&quot;.&nbsp; The character &quot;:&quot; is not allo=
wed. See the
rules:<br>
&nbsp;&nbsp;&nbsp; &quot;* The path may be of any length.<br>
&nbsp;&nbsp;&nbsp; * The path must begin with an ASCII '/' (integer 47)
character, and must consist of elements separated by slash characters.<br>
&nbsp;&nbsp;&nbsp; * Each element must only contain the ASCII characters &q=
uot;[A-Z][a-z][0-9]_&quot;<br>
&nbsp;&nbsp;&nbsp; * No element may be the empty string.<br>
&nbsp;&nbsp;&nbsp; * Multiple '/' characters cannot occur in sequence.<br>
&nbsp;&nbsp;&nbsp; * A trailing '/' character is not allowed unless the pat=
h is the root path (a single '/' character).&quot;<br>
<br>
<br>
Which approach do you want now ? :)<br>
<br>
<br>
<br>
<br>
More inforamtion how D-Bus paths works:<br>
This is just to explain to you how DBus paths works and try pass an
useful information. If we analize HAL API deeply you will notice a
small difference, HAL provide a Manager interface used to recover the
devices(including paths) information. The Device interface is used by
clients that want change/get ONE DEVICE property.<br>
<br>
Interfaces:<br>
org.freedesktop.Hal.Manager<br>
org.freedesktop.Hal.Device<br>
<br>
Manager interface services:<br>
- GetAllDevices<br>
- DeviceExists<br>
- FindDeviceByCapability<br>
....<br>
<br>
Device interface services:<br>
- GetProperty<br>
- SetProperty<br>
- Lock<br>
- Unlock<br>
...<br>
<br>
Path example:<br>
/org/freedesktop/Hal/devices/usb_device_a12_1_noserial_if0 (iface org.freed=
esktop.Hal.Device)<br>
<br>
One path represents a unique identification to where a message is sent.
In the code that I am developing there is only one D-Bus message
handler, the path will be the primary element to know which local
adapter use. Remember that each path will provide a set of services,
and each path can has more than one interface. <br>
<br>
We are using the path &quot;/org/bluez/Manager&quot; to provide to userspac=
e
application services to list ACTIVE devices and enable/disable
services. The path &quot;/org/bluez/Devices&quot; will be restricted to dev=
ice
setup. Therefore, the message format used in &quot;/org/bluez/Devices&quot;=
 path
should contains one arguments to indicate the device identification,
like hciconfig uses. For the messages send under the path
&quot;/org/bluez/Manager/BDADDR/...&quot; is not necessary send this argume=
nt
because the path already contains the device identification. <br>
<br>
The prefix &quot;/org/bluez/Manager&quot; used before device based path is =
not
realy necessary. It is used only to make easier find services under
this hierarchy.<br>
<br>
HAL DOESN'T provide an extra path as we are doing for device setup
&quot;/org/bluez/Devices&quot; all paths are device based. If you want copy
exactly HAL paths principle, we should have:<br>
/org/bluez/Manager<br>
/org/bluez/Devices/BDADDR/Hciconfig (always active)<br>
/org/bluez/Devices/BDADDR/Hciconfig (always active)<br>
/org/bluez/Devices/BDADDR/Controller (if dev is UP)<br>
/org/bluez/Devices/default/Controller (if dev is UP)<br>
/org/bluez/Devices/BDADDR/Net (if dev is UP)<br>
/org/bluez/Devices/default/Net (if dev is UP)<br>
<br>
And use two interfaces:<br>
org.bluez.Manager<br>
org.bluez.Devices<br>
<br>
<br>
<br>
I will send a new patch in the next email.<br>
<br>
Regards,<br>
Claudio.<br>
<br><br><div><span class=3D"gmail_quote">On 9/30/05, <b class=3D"gmail_send=
ername">Marcel Holtmann</b> &lt;<a href=3D"mailto:marcel@holtmann.org">marc=
el@holtmann.org</a>&gt; wrote:</span><blockquote class=3D"gmail_quote" styl=
e=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; =
padding-left: 1ex;">
Hi Claudio,<br><br>&gt; I don't want define a group domain for evey group o=
f access. I think<br>&gt; you didn't understand my idea. I defined fixed in=
terfaces<br>&gt; (org.bluez.manager or org.bluez.devices) and path names ba=
sed on
<br>&gt; device identification.<br><br>this might be true, because I am a t=
otal newbie when it comes to D-Bus<br>security. I have to rely on other peo=
ples investigation here.<br><br>&gt; In the security policy file we can def=
ine rules according with our
<br>&gt; need.&nbsp;&nbsp;We can define rules based on paths, interfaces, u=
sers,<br>&gt; group ... or a combination of these parameters. At first phas=
e of<br>&gt; bluetoothd development we need only define clear interfaces an=
d path
<br>&gt; to make possible define security policy easily in the future. We d=
on't<br>&gt; need thinking on define a group domain or rules at this mommen=
t.<br>&gt;<br>&gt; The interfaces name will be shared by method call, metho=
d reply,
<br>&gt; errors and signals. Remember that one path, can have a lot of<br>&=
gt; interfaces.&nbsp;&nbsp;Interfaces is just a way to group a set of<br>&g=
t; methods(services). Therefore, if you apply one rule for a path, this<br>=
&gt; rule will be applied for all interfaces that belongs to this path.
<br><br>This means we will have a generell restricted policy and we create =
some<br>holes to make specific calls available for normal users.<br><br>&gt=
; Regarding the device identification in the path name, I prefer use<br>
&gt; hci(for default kernel device), hci1, hci2, ... It's easier use the<br=
>&gt; device id of &quot;evt_si_device&quot; event. You suggested use the b=
luetooth<br>&gt; address, for this approach we can define a the default
<br>&gt; device(000000000000), and use the string&nbsp;&nbsp;representation=
 of bdaddr_t<br>&gt; for the others devices. eg:&quot;A089BE880D00&quot;, &=
quot;E4A500461300&quot; The final<br>&gt; decision is yours.<br><br>I will =
go with &quot;default&quot;, because at some point I might make the HCI
<br>device identifier strings changeable, like we can do for Ethernet. The<=
br>BDADDR_ANY is not needed, but we can do this. However this means that I<=
br>have to implement a possibility to define a default device inside the
<br>kernel. Otherwise BDADDR_ANY in D-Bus and inside the kernel might end u=
p<br>in two different devices. For the address representation I will use th=
e<br>string representation &quot;00:11:22:33:44:55&quot;, because this is h=
ow normal
<br>users will see the address and there is no need to obfuscate the addres=
s<br>for it.<br><br>&gt; I checked the libhal code, a similar approach is i=
mplemented. See how<br>&gt; the messages are created. The first argument of=
 the
<br>&gt; dbus_message_new_method_call function is the service bus name, the=
<br>&gt; second is the path, the third is the interface and<br>&gt; the las=
t one is the member name(service). &quot;udi&quot; means unique device<br>
&gt; identification.<br>&gt;<br>&gt; LIBHAL side(client):<br>&gt;<br>&gt;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; message =3D dbus_message_new=
_method_call (&quot;org.freedesktop.Hal&quot;,<br>&gt; udi,<br>&gt;<br>&gt;=
 &quot;org.freedesktop.Hal.Device&quot;,
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&quot;GetAllProperties&quot;);<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; message =3D dbus_message_new_method_call (&quot;org.freedesktop=
.Hal&quot;,<br>&gt;<br>&gt; &quot;/org/freedesktop/Hal/Manager&quot;,<br>&g=
t;<br>&gt; &quot;org.freedesktop.Hal.Manager
&quot;,<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;
&quot;GetAllDevices&quot;);<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; message =3D dbus_message_new_method_call (&quot;org.freedesktop.Ha=
l&quot;,<br>&gt; udi,<br>&gt;<br>&gt; &quot;org.freedesktop.Hal.Device&quot=
;,<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&quot;GetPropertyType&quot;);<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; message =3D dbus_message_new_method_call (&quot;org.freedesktop.=
Hal&quot;,<br>&gt; udi,<br>&gt;<br>&gt; &quot;org.freedesktop.Hal.Device&qu=
ot;,<br>&gt;<br>&gt; &quot;GetPropertyStringList&quot;);
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; message =3D dbus_m=
essage_new_method_call (&quot;org.freedesktop.Hal&quot;,<br>&gt; udi,<br>&g=
t;<br>&gt; &quot;org.freedesktop.Hal.Device&quot;,<br>&gt;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&quot;GetPropertyInteger&quot;);<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; message =3D dbus_message_new_method_call (&quot;org.freedeskt=
op.Hal&quot;,<br>&gt; udi,<br>&gt;<br>&gt; &quot;org.freedesktop.Hal.Device=
&quot;,<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;
&quot;GetPropertyInteger&quot;);<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; message =3D dbus_message_new_method_call (&quot;org.freedeskt=
op.Hal&quot;,<br>&gt; udi,<br>&gt;<br>&gt; &quot;org.freedesktop.Hal.Device=
&quot;,<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;
&quot;GetPropertyDouble&quot;);<br>&gt; In the server side - hald(daemon)<b=
r>&gt; DBusHandlerResult<br>&gt; device_get_property (DBusConnection * conn=
ection, DBusMessage *<br>&gt; message){<br>&gt; ...<br>&gt; udi =3D dbus_me=
ssage_get_path (message);
<br>&gt; ..<br>&gt; }<br>&gt;<br>&gt; Basically, HAL has two interfaces, on=
e for devices and another for the<br>&gt; manager. Each device has path reg=
istered in the system Bus, where the<br>&gt; device identification belongs =
to the path.
<br>&gt;<br>&gt; After this analysis I think we are following the right pat=
h.<br><br>I think so, too. Please send in a new patch. We need something to=
 get<br>started and as you, I like it step by step.<br><br>Regards<br><br>
Marcel<br><br><br><br><br>-------------------------------------------------=
------<br>This SF.Net email is sponsored by:<br>Power Architecture Resource=
 Center: Free content, downloads, discussions,<br>and more. <a href=3D"http=
://solutions.newsforge.com/ibmarch.tmpl">
http://solutions.newsforge.com/ibmarch.tmpl</a><br>________________________=
_______________________<br>Bluez-devel mailing list<br><a href=3D"mailto:Bl=
uez-devel@lists.sourceforge.net">Bluez-devel@lists.sourceforge.net</a><br>
<a href=3D"https://lists.sourceforge.net/lists/listinfo/bluez-devel">https:=
//lists.sourceforge.net/lists/listinfo/bluez-devel</a><br></blockquote></di=
v><br><br clear=3D"all"><br>-- <br>----------------------------------------=
-----------------
<br>Claudio Takahasi<br>Nokia's Institute of Technology - INdT<br><a href=
=3D"mailto:claudio.takahasi@indt.org.br">claudio.takahasi@indt.org.br</a><b=
r>

------=_Part_5451_23632457.1128091938444--


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
