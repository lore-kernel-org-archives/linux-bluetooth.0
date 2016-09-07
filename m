Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <AFC130A9-CBDF-4DC3-BACD-69CF3ADBA1C6@gmail.com>
References: <04AC5786-517A-4834-AFD7-B0C6AC29B869@gmail.com>
 <CADwkJjLm5RF54MHANHYUX3cmh52V4EgHB57hrMu4oXeOA6bR3Q@mail.gmail.com>
 <0176A088-7DFB-415E-9461-CB8BA391E087@gmail.com> <CADwkJj+6n=7AAXmbEZ6me32_m-2fyErYOnKDcg4E8Kj7ibn1WA@mail.gmail.com>
 <AFC130A9-CBDF-4DC3-BACD-69CF3ADBA1C6@gmail.com>
From: Barry Byford <31baz66@gmail.com>
Date: Wed, 7 Sep 2016 23:19:45 +0100
Message-ID: <CAAu3APaLf-fEj61fA4UD1JDLipbgC72K2WWtUzLKypT2LJAErw@mail.gmail.com>
Subject: Re: Query BLE connected status?
To: Travis Griggs <travisgriggs@gmail.com>
Cc: Bluez mailing list <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Travis,

On 7 September 2016 at 22:14, Travis Griggs <travisgriggs@gmail.com> wrote:
<snip>
> What is the difference between and adapter and device in the lingo here?
As you correctly identify the adapter is the bluetooth dongle on your Linux SBC
The device is the remote Bluetooth device that you are connecting to.

> <reboot linux device>
> # ./connected
> (no output)
> <ble connect from iphone>
> # ./connected
> /org/bluez/hci0/dev_49_7C_73_51_21_1E Connected: 1
> <terminate iOS app, should disconnect>
> # ./connected
> /org/bluez/hci0/dev_49_7C_73_51_21_1E Connected: 0
> <wait a minute or so>
> # ./connected
> /org/bluez/hci0/dev_49_7C_73_51_21_1E Connected: 0
> <reconnect iOs app>
> ./connected
> /org/bluez/hci0/dev_49_7C_73_51_21_1E Connected: 0
> /org/bluez/hci0/dev_41_7B_77_4F_E4_AA Connected: 1
> <disconnect>

If looks like your iOS app is creating a different device address each
time it is started. I see this on a few of the Android apps that I use
that emulate things like heart rate monitors or battery services.


> Is there a way to register something more event based so I could be notified when it changes?

Yes there is. You can connect to the 'PropertiesChanged' signal on the
'org.bluez.Device1' interface.
I've done a piece of code that demonstrates this. I've used an Android
app to test it. To get around the issue of it having a different
address each time I switch the app on, I've left the app running and
then in a separate window on my SBC I use Bluetoothctl to do the
connect/disconnect commands.

Hopefully the email tool will not mangle the formatting of this code too much:

#!/usr/bin/env python3
import dbus
import dbus.mainloop.glib
from gi.repository import GLib

dbus.mainloop.glib.DBusGMainLoop(set_as_default=True)
mainloop = GLib.MainLoop()


def get_iface_prop(iface, prop):
    response = {}
    bus = dbus.SystemBus()
    mng =  dbus.Interface(bus.get_object('org.bluez', '/'),
                          'org.freedesktop.DBus.ObjectManager')
    for path, ifaces in mng.GetManagedObjects().items():
        if iface in ifaces:
            response[path] = ifaces[iface][prop]
    return response

class Device:
    def __init__(self, device_path):
        self.bus = dbus.SystemBus()
        self.device_path = device_path
        self.device_obj = self.bus.get_object('org.bluez', device_path)
        device_props = dbus.Interface(self.device_obj, dbus.PROPERTIES_IFACE)
        device_props.connect_to_signal('PropertiesChanged',
self.on_prop_changed)

    def on_prop_changed(self, iface, changed_props, invalidated_props):
        if 'org.bluez.Device1' in iface:
            if 'Connected' in changed_props:
                print('{0} is now {1}'.format(self.device_path,
changed_props['Connected']))


if __name__ == '__main__':
    for k, v in get_iface_prop('org.bluez.Device1', 'Connected').items():
        print('{0} is {1}'.format(k, v))
        Device(k)

    mainloop.run()

My test output looked like this:

./connected_devices.py
/org/bluez/hci0/dev_E8_A9_41_CE_31_5A is 0
/org/bluez/hci0/dev_5E_4B_97_7B_22_C3 is 1
/org/bluez/hci0/dev_B0_B4_48_BE_5D_83 is 0
/org/bluez/hci0/dev_F7_17_E4_09_C0_C6 is 0
/org/bluez/hci0/dev_8C_2D_AA_44_0E_3A is 0
/org/bluez/hci0/dev_5E_4B_97_7B_22_C3 is now 0
/org/bluez/hci0/dev_5E_4B_97_7B_22_C3 is now 1
/org/bluez/hci0/dev_5E_4B_97_7B_22_C3 is now 0

This was all done using BlueZ 5.40 with the experimental flag switched
on. I hope that helps move things forward for you.

Cheers,
Barry
