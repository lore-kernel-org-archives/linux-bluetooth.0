Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: Query BLE connected status?
From: Travis Griggs <travisgriggs@gmail.com>
In-Reply-To: <CAAu3APaLf-fEj61fA4UD1JDLipbgC72K2WWtUzLKypT2LJAErw@mail.gmail.com>
Date: Mon, 12 Sep 2016 08:52:05 -0700
Message-Id: <A4055AB1-FBEC-48D9-81BB-54FAFDB73744@gmail.com>
References: <04AC5786-517A-4834-AFD7-B0C6AC29B869@gmail.com> <CADwkJjLm5RF54MHANHYUX3cmh52V4EgHB57hrMu4oXeOA6bR3Q@mail.gmail.com> <0176A088-7DFB-415E-9461-CB8BA391E087@gmail.com> <CADwkJj+6n=7AAXmbEZ6me32_m-2fyErYOnKDcg4E8Kj7ibn1WA@mail.gmail.com> <AFC130A9-CBDF-4DC3-BACD-69CF3ADBA1C6@gmail.com> <CAAu3APaLf-fEj61fA4UD1JDLipbgC72K2WWtUzLKypT2LJAErw@mail.gmail.com>
To: Bluez mailing list <linux-bluetooth@vger.kernel.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


> On Sep 7, 2016, at 3:19 PM, Barry Byford <31baz66@gmail.com> wrote:
>=20
> Hi Travis,
>=20
> On 7 September 2016 at 22:14, Travis Griggs <travisgriggs@gmail.com> =
wrote:
> <snip>
>> What is the difference between and adapter and device in the lingo =
here?
> As you correctly identify the adapter is the bluetooth dongle on your =
Linux SBC
> The device is the remote Bluetooth device that you are connecting to.

Aha! Lightbulb moment there for me. Thank you so much!

>=20
>> <reboot linux device>
>> # ./connected
>> (no output)
>> <ble connect from iphone>
>> # ./connected
>> /org/bluez/hci0/dev_49_7C_73_51_21_1E Connected: 1
>> <terminate iOS app, should disconnect>
>> # ./connected
>> /org/bluez/hci0/dev_49_7C_73_51_21_1E Connected: 0
>> <wait a minute or so>
>> # ./connected
>> /org/bluez/hci0/dev_49_7C_73_51_21_1E Connected: 0
>> <reconnect iOs app>
>> ./connected
>> /org/bluez/hci0/dev_49_7C_73_51_21_1E Connected: 0
>> /org/bluez/hci0/dev_41_7B_77_4F_E4_AA Connected: 1
>> <disconnect>
>=20
> If looks like your iOS app is creating a different device address each
> time it is started. I see this on a few of the Android apps that I use
> that emulate things like heart rate monitors or battery services.
>=20
>=20
>> Is there a way to register something more event based so I could be =
notified when it changes?
>=20
> Yes there is. You can connect to the 'PropertiesChanged' signal on the
> 'org.bluez.Device1' interface.
> I've done a piece of code that demonstrates this. I've used an Android
> app to test it. To get around the issue of it having a different
> address each time I switch the app on, I've left the app running and
> then in a separate window on my SBC I use Bluetoothctl to do the
> connect/disconnect commands.
>=20
> Hopefully the email tool will not mangle the formatting of this code =
too much:
>=20
> #!/usr/bin/env python3
> import dbus
> import dbus.mainloop.glib
> from gi.repository import GLib
>=20
> dbus.mainloop.glib.DBusGMainLoop(set_as_default=3DTrue)
> mainloop =3D GLib.MainLoop()
>=20
>=20
> def get_iface_prop(iface, prop):
>    response =3D {}
>    bus =3D dbus.SystemBus()
>    mng =3D  dbus.Interface(bus.get_object('org.bluez', '/'),
>                          'org.freedesktop.DBus.ObjectManager')
>    for path, ifaces in mng.GetManagedObjects().items():
>        if iface in ifaces:
>            response[path] =3D ifaces[iface][prop]
>    return response
>=20
> class Device:
>    def __init__(self, device_path):
>        self.bus =3D dbus.SystemBus()
>        self.device_path =3D device_path
>        self.device_obj =3D self.bus.get_object('org.bluez', =
device_path)
>        device_props =3D dbus.Interface(self.device_obj, =
dbus.PROPERTIES_IFACE)
>        device_props.connect_to_signal('PropertiesChanged',
> self.on_prop_changed)
>=20
>    def on_prop_changed(self, iface, changed_props, invalidated_props):
>        if 'org.bluez.Device1' in iface:
>            if 'Connected' in changed_props:
>                print('{0} is now {1}'.format(self.device_path,
> changed_props['Connected']))
>=20
>=20
> if __name__ =3D=3D '__main__':
>    for k, v in get_iface_prop('org.bluez.Device1', =
'Connected').items():
>        print('{0} is {1}'.format(k, v))
>        Device(k)
>=20
>    mainloop.run()
>=20
> My test output looked like this:
>=20
> ./connected_devices.py
> /org/bluez/hci0/dev_E8_A9_41_CE_31_5A is 0
> /org/bluez/hci0/dev_5E_4B_97_7B_22_C3 is 1
> /org/bluez/hci0/dev_B0_B4_48_BE_5D_83 is 0
> /org/bluez/hci0/dev_F7_17_E4_09_C0_C6 is 0
> /org/bluez/hci0/dev_8C_2D_AA_44_0E_3A is 0
> /org/bluez/hci0/dev_5E_4B_97_7B_22_C3 is now 0
> /org/bluez/hci0/dev_5E_4B_97_7B_22_C3 is now 1
> /org/bluez/hci0/dev_5E_4B_97_7B_22_C3 is now 0
>=20
> This was all done using BlueZ 5.40 with the experimental flag switched
> on. I hope that helps move things forward for you.

Your code worked. But it seems that it only has a one a time pass to =
determine which remote devices to register the property change. So for a =
given snapshot of current devices, it can notify their state changes. =
But it won=E2=80=99t notice if a new object path shows up.

It seems to me though, that maybe I=E2=80=99m going about this wrong. I =
don=E2=80=99t care about the device identity, or which devices are =
connected or not. What I really care about is if any device is connected =
to my app. And maybe I have this (kind of indirectly). My characteristic =
will get a StartNotify/StopNotify event on connect/disconnect edges. I =
can just use those to keep track of when I=E2=80=99m active or not.=20


