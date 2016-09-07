Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <0176A088-7DFB-415E-9461-CB8BA391E087@gmail.com>
References: <04AC5786-517A-4834-AFD7-B0C6AC29B869@gmail.com>
 <CADwkJjLm5RF54MHANHYUX3cmh52V4EgHB57hrMu4oXeOA6bR3Q@mail.gmail.com> <0176A088-7DFB-415E-9461-CB8BA391E087@gmail.com>
From: Tobias Svehagen <tobias.svehagen@gmail.com>
Date: Wed, 7 Sep 2016 09:37:42 +0200
Message-ID: <CADwkJj+6n=7AAXmbEZ6me32_m-2fyErYOnKDcg4E8Kj7ibn1WA@mail.gmail.com>
Subject: Re: Query BLE connected status?
To: Travis Griggs <travisgriggs@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The property is not on the Adapter1 interface but it is found on the
Device1 interface. Also note that you have to check for every object
under /org/bluez/hci0 if that one is connected. I don't think there is
a way to see if an adapter is connected or not. Here is an example of
getting the Connected property of all the devices.

#!/usr/bin/env python3

import dbus
import os
import sys

def get_managed_objects():
    bus = dbus.SystemBus()
    manager = dbus.Interface(bus.get_object("org.bluez", "/"),

"org.freedesktop.DBus.ObjectManager")
    return manager.GetManagedObjects()

def main():
    bus = dbus.SystemBus()

    objects = get_managed_objects()
    for path, ifaces in iter(objects.items()):
        dev = ifaces.get("org.bluez.Device1")
        if dev is None:
            continue

        props = dbus.Interface(bus.get_object("org.bluez", path),
                               "org.freedesktop.DBus.Properties")

        print(path, "Connected:", props.Get("org.bluez.Device1", "Connected"))

if __name__ == '__main__':
    main()

/Tobias
