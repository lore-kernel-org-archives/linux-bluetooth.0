Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CADwkJj+6n=7AAXmbEZ6me32_m-2fyErYOnKDcg4E8Kj7ibn1WA@mail.gmail.com>
References: <04AC5786-517A-4834-AFD7-B0C6AC29B869@gmail.com>
 <CADwkJjLm5RF54MHANHYUX3cmh52V4EgHB57hrMu4oXeOA6bR3Q@mail.gmail.com>
 <0176A088-7DFB-415E-9461-CB8BA391E087@gmail.com> <CADwkJj+6n=7AAXmbEZ6me32_m-2fyErYOnKDcg4E8Kj7ibn1WA@mail.gmail.com>
From: Barry Byford <31baz66@gmail.com>
Date: Wed, 7 Sep 2016 22:23:35 +0100
Message-ID: <CAAu3APZkoehtoQTbtdd3R1XRy0aVrUSVLAY0QhvB1FtVvpcjEw@mail.gmail.com>
Subject: Re: Query BLE connected status?
To: Tobias Svehagen <tobias.svehagen@gmail.com>
Cc: Travis Griggs <travisgriggs@gmail.com>,
        Bluez mailing list <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Travis,

On 7 September 2016 at 08:37, Tobias Svehagen <tobias.svehagen@gmail.com> wrote:
> The property is not on the Adapter1 interface but it is found on the
> Device1 interface. Also note that you have to check for every object
> under /org/bluez/hci0 if that one is connected. I don't think there is
> a way to see if an adapter is connected or not. Here is an example of
> getting the Connected property of all the devices.
>
> #!/usr/bin/env python3
>
> import dbus
> import os
> import sys
>
> def get_managed_objects():
>     bus = dbus.SystemBus()
>     manager = dbus.Interface(bus.get_object("org.bluez", "/"),
>
> "org.freedesktop.DBus.ObjectManager")
>     return manager.GetManagedObjects()
>
> def main():
>     bus = dbus.SystemBus()
>
>     objects = get_managed_objects()
>     for path, ifaces in iter(objects.items()):
>         dev = ifaces.get("org.bluez.Device1")
>         if dev is None:
>             continue
>
>         props = dbus.Interface(bus.get_object("org.bluez", path),
>                                "org.freedesktop.DBus.Properties")
>
>         print(path, "Connected:", props.Get("org.bluez.Device1", "Connected"))
>
> if __name__ == '__main__':
>     main()
>
> /Tobias
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

I know Tobias has answered this but I thought you might be interested
in seeing a couple of code alternatives:

#!/usr/bin/env python3
import dbus

def get_iface_prop(iface, prop):
    response = {}
    bus = dbus.SystemBus()
    mng =  dbus.Interface(bus.get_object('org.bluez', '/'),
                          'org.freedesktop.DBus.ObjectManager')
    for path, ifaces in mng.GetManagedObjects().items():
        if iface in ifaces:
            response[path] = ifaces[iface][prop]
    return response

if __name__ == '__main__':
    for k, v in get_iface_prop('org.bluez.Device1', 'Connected').items():
        print('{0} is {1}'.format(k, v))

Gives an output something like:

$ ./connected_devices.py
/org/bluez/hci0/dev_F7_17_E4_09_C0_C6 is 1
/org/bluez/hci0/dev_E8_A9_41_CE_31_5A is 0
/org/bluez/hci0/dev_B0_B4_48_BE_5D_83 is 0
/org/bluez/hci0/dev_8C_2D_AA_44_0E_3A is 0

Hope that helps.

Cheers,
Barry
