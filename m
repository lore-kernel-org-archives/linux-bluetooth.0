Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <A4055AB1-FBEC-48D9-81BB-54FAFDB73744@gmail.com>
References: <04AC5786-517A-4834-AFD7-B0C6AC29B869@gmail.com>
 <CADwkJjLm5RF54MHANHYUX3cmh52V4EgHB57hrMu4oXeOA6bR3Q@mail.gmail.com>
 <0176A088-7DFB-415E-9461-CB8BA391E087@gmail.com> <CADwkJj+6n=7AAXmbEZ6me32_m-2fyErYOnKDcg4E8Kj7ibn1WA@mail.gmail.com>
 <AFC130A9-CBDF-4DC3-BACD-69CF3ADBA1C6@gmail.com> <CAAu3APaLf-fEj61fA4UD1JDLipbgC72K2WWtUzLKypT2LJAErw@mail.gmail.com>
 <A4055AB1-FBEC-48D9-81BB-54FAFDB73744@gmail.com>
From: Barry Byford <31baz66@gmail.com>
Date: Mon, 12 Sep 2016 20:37:59 +0100
Message-ID: <CAAu3APbSu5Tm4ok6hw2qMVW_dZMCtujdXq3b1c0DZxFqmjuupw@mail.gmail.com>
Subject: Re: Query BLE connected status?
To: Travis Griggs <travisgriggs@gmail.com>
Cc: Bluez mailing list <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello Travis,

On 12 September 2016 at 16:52, Travis Griggs <travisgriggs@gmail.com> wrote=
:
>
>> On Sep 7, 2016, at 3:19 PM, Barry Byford <31baz66@gmail.com> wrote:
>>
>> Hi Travis,
>>
>> On 7 September 2016 at 22:14, Travis Griggs <travisgriggs@gmail.com> wro=
te:
>> <snip>
>>> What is the difference between and adapter and device in the lingo here=
?
>> As you correctly identify the adapter is the bluetooth dongle on your Li=
nux SBC
>> The device is the remote Bluetooth device that you are connecting to.
>
> Aha! Lightbulb moment there for me. Thank you so much!
Excellent news! Glad it helped


>>> <reboot linux device>
>>> # ./connected
>>> (no output)
>>> <ble connect from iphone>
>>> # ./connected
>>> /org/bluez/hci0/dev_49_7C_73_51_21_1E Connected: 1
>>> <terminate iOS app, should disconnect>
>>> # ./connected
>>> /org/bluez/hci0/dev_49_7C_73_51_21_1E Connected: 0
>>> <wait a minute or so>
>>> # ./connected
>>> /org/bluez/hci0/dev_49_7C_73_51_21_1E Connected: 0
>>> <reconnect iOs app>
>>> ./connected
>>> /org/bluez/hci0/dev_49_7C_73_51_21_1E Connected: 0
>>> /org/bluez/hci0/dev_41_7B_77_4F_E4_AA Connected: 1
>>> <disconnect>
>>
>> If looks like your iOS app is creating a different device address each
>> time it is started. I see this on a few of the Android apps that I use
>> that emulate things like heart rate monitors or battery services.
>>
>>
>>> Is there a way to register something more event based so I could be not=
ified when it changes?
>>
>> Yes there is. You can connect to the 'PropertiesChanged' signal on the
>> 'org.bluez.Device1' interface.
>> I've done a piece of code that demonstrates this. I've used an Android
>> app to test it. To get around the issue of it having a different
>> address each time I switch the app on, I've left the app running and
>> then in a separate window on my SBC I use Bluetoothctl to do the
>> connect/disconnect commands.
>>
>> Hopefully the email tool will not mangle the formatting of this code too=
 much:
>>
>> #!/usr/bin/env python3
>> import dbus
>> import dbus.mainloop.glib
>> from gi.repository import GLib
>>
>> dbus.mainloop.glib.DBusGMainLoop(set_as_default=3DTrue)
>> mainloop =3D GLib.MainLoop()
>>
>>
>> def get_iface_prop(iface, prop):
>>    response =3D {}
>>    bus =3D dbus.SystemBus()
>>    mng =3D  dbus.Interface(bus.get_object('org.bluez', '/'),
>>                          'org.freedesktop.DBus.ObjectManager')
>>    for path, ifaces in mng.GetManagedObjects().items():
>>        if iface in ifaces:
>>            response[path] =3D ifaces[iface][prop]
>>    return response
>>
>> class Device:
>>    def __init__(self, device_path):
>>        self.bus =3D dbus.SystemBus()
>>        self.device_path =3D device_path
>>        self.device_obj =3D self.bus.get_object('org.bluez', device_path)
>>        device_props =3D dbus.Interface(self.device_obj, dbus.PROPERTIES_=
IFACE)
>>        device_props.connect_to_signal('PropertiesChanged',
>> self.on_prop_changed)
>>
>>    def on_prop_changed(self, iface, changed_props, invalidated_props):
>>        if 'org.bluez.Device1' in iface:
>>            if 'Connected' in changed_props:
>>                print('{0} is now {1}'.format(self.device_path,
>> changed_props['Connected']))
>>
>>
>> if __name__ =3D=3D '__main__':
>>    for k, v in get_iface_prop('org.bluez.Device1', 'Connected').items():
>>        print('{0} is {1}'.format(k, v))
>>        Device(k)
>>
>>    mainloop.run()
>>
>> My test output looked like this:
>>
>> ./connected_devices.py
>> /org/bluez/hci0/dev_E8_A9_41_CE_31_5A is 0
>> /org/bluez/hci0/dev_5E_4B_97_7B_22_C3 is 1
>> /org/bluez/hci0/dev_B0_B4_48_BE_5D_83 is 0
>> /org/bluez/hci0/dev_F7_17_E4_09_C0_C6 is 0
>> /org/bluez/hci0/dev_8C_2D_AA_44_0E_3A is 0
>> /org/bluez/hci0/dev_5E_4B_97_7B_22_C3 is now 0
>> /org/bluez/hci0/dev_5E_4B_97_7B_22_C3 is now 1
>> /org/bluez/hci0/dev_5E_4B_97_7B_22_C3 is now 0
>>
>> This was all done using BlueZ 5.40 with the experimental flag switched
>> on. I hope that helps move things forward for you.
>
> Your code worked.
Also good news!

> But it seems that it only has a one a time pass to determine which remote=
 devices to register the property change. So for a given snapshot of curren=
t devices, it can notify their state changes. But it won=E2=80=99t notice i=
f a new object path shows up.

True the code I gave as an example did not update if a device was
added after initial invocation.
You will need to look at the 'InterfacesAdded' signal to see when a
device gets added.

An example of how to do that would be:
    bus.add_signal_receiver(interfaces_added,
                            dbus_interface=3D'org.freedesktop.DBus.ObjectMa=
nager',
                            signal_name=3D'InterfacesAdded')

The interfaces_added function could then use the Device class we
created previously to connect to the PropertiesChanged signal on that
device to listen if it was connected or not.


>
> It seems to me though, that maybe I=E2=80=99m going about this wrong. I d=
on=E2=80=99t care about the device identity, or which devices are connected=
 or not. What I really care about is if any device is connected to my app. =
And maybe I have this (kind of indirectly). My characteristic will get a St=
artNotify/StopNotify event on connect/disconnect edges. I can just use thos=
e to keep track of when I=E2=80=99m active or not.

Not sure the StopNotify is a reliable way to detect that there has
been a disconnect.


The full code that I used to test what I had written above was:

#!/usr/bin/env python3
import dbus
import dbus.mainloop.glib
from gi.repository import GLib

dbus.mainloop.glib.DBusGMainLoop(set_as_default=3DTrue)
mainloop =3D GLib.MainLoop()


def interfaces_added(path, interfaces):
    if 'org.bluez.Device1' in interfaces:
        print('Device added at {}'.format(path))
        Device(path)

def get_iface_prop(iface, prop):
    response =3D {}
    bus =3D dbus.SystemBus()
    mng =3D  dbus.Interface(bus.get_object('org.bluez', '/'),
                          'org.freedesktop.DBus.ObjectManager')
    bus.add_signal_receiver(interfaces_added,
                            dbus_interface=3D'org.freedesktop.DBus.ObjectMa=
nager',
                            signal_name=3D'InterfacesAdded')

    for path, ifaces in mng.GetManagedObjects().items():
        if iface in ifaces:
            response[path] =3D ifaces[iface][prop]
    return response

class Device:
    def __init__(self, device_path):
        self.bus =3D dbus.SystemBus()
        self.device_path =3D device_path
        self.device_obj =3D self.bus.get_object('org.bluez', device_path)
        device_props =3D dbus.Interface(self.device_obj, dbus.PROPERTIES_IF=
ACE)
        device_props.connect_to_signal('PropertiesChanged',
self.on_prop_changed)

    def on_prop_changed(self, iface, changed_props, invalidated_props):
        if 'org.bluez.Device1' in iface:
            if 'Connected' in changed_props:
                print('{0} is now {1}'.format(self.device_path,
changed_props['Connected']))


if __name__ =3D=3D '__main__':
    for k, v in get_iface_prop('org.bluez.Device1', 'Connected').items():
        print('{0} is {1}'.format(k, v))
        Device(k)

    mainloop.run()


I removed all the devices before I started running the script so no
devices were reported at invocation. Again, I had a separate window
doing the scanning and connecting which resulted in the following
output:

$ ./connect_devices.py
Device added at /org/bluez/hci0/dev_48_C0_7B_35_98_A5
/org/bluez/hci0/dev_48_C0_7B_35_98_A5 is now 1
/org/bluez/hci0/dev_48_C0_7B_35_98_A5 is now 0
Device added at /org/bluez/hci0/dev_60_06_57_DD_4C_2F
Device added at /org/bluez/hci0/dev_54_1F_46_F1_AA_32
/org/bluez/hci0/dev_54_1F_46_F1_AA_32 is now 1
/org/bluez/hci0/dev_54_1F_46_F1_AA_32 is now 0
