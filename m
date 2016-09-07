Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: Query BLE connected status?
From: Travis Griggs <travisgriggs@gmail.com>
In-Reply-To: <CADwkJjLm5RF54MHANHYUX3cmh52V4EgHB57hrMu4oXeOA6bR3Q@mail.gmail.com>
Date: Tue, 6 Sep 2016 17:02:52 -0700
Message-Id: <0176A088-7DFB-415E-9461-CB8BA391E087@gmail.com>
References: <04AC5786-517A-4834-AFD7-B0C6AC29B869@gmail.com> <CADwkJjLm5RF54MHANHYUX3cmh52V4EgHB57hrMu4oXeOA6bR3Q@mail.gmail.com>
To: linux-bluetooth@vger.kernel.org
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


> On Sep 6, 2016, at 1:53 PM, Tobias Svehagen =
<tobias.svehagen@gmail.com> wrote:
>=20
> Travis,
>=20
> There is a Connected property on the org.bluez.Device1 interface (see
> =
http://git.kernel.org/cgit/bluetooth/bluez.git/tree/doc/device-api.txt).
> This will tell you if that specific device is connected or not. Would
> this solve your problem?

I think it would. If I could figure out how to read it. My python/dbus =
skills are very much monkey-see-monkey-do at this point. I was excited, =
because I already have a snippet that sets the =E2=80=98Alias=E2=80=99 =
of the same interface, so I thought I could just modify a little:

#!/usr/bin/env python3

import dbus
import dbus.mainloop.glib
import gi.repository.GLib as glib
import os
import sys

Adapter =3D '/org/bluez/hci0'

def main():
   dbus.mainloop.glib.DBusGMainLoop(set_as_default=3DTrue)
   bus =3D dbus.SystemBus()

   adapterProperties =3D dbus.Interface(bus.get_object('org.bluez', =
Adapter), 'org.freedesktop.DBus.Properties')
   value =3D adapterProperties.Get('org.bluez.Adapter1', 'Connected')
   print('connected', value)

   mainloop =3D glib.MainLoop()
   try:
       mainloop.run()
   except KeyboardInterrupt:
       mainloop.quit()


if __name__ =3D=3D '__main__':
   main()

Unfortunately, that doesn=E2=80=99t work. I got the following error:

root@nelson:/Pilot# ./connected=20
Traceback (most recent call last):
 File "./connected", line 28, in <module>
   main()
 File "./connected", line 17, in main
   value =3D adapterProperties.Get('org.bluez.Adapter1', 'Connected')
 File "/usr/lib/python3/dist-packages/dbus/proxies.py", line 70, in =
__call__
   return self._proxy_method(*args, **keywords)
 File "/usr/lib/python3/dist-packages/dbus/proxies.py", line 145, in =
__call__
   **keywords)
 File "/usr/lib/python3/dist-packages/dbus/connection.py", line 651, in =
call_blocking
   message, timeout)
dbus.exceptions.DBusException: org.freedesktop.DBus.Error.InvalidArgs: =
No such property =E2=80=98Connected'

My original code had a .Set() call, but maybe I was naive in assuming =
that a .Get() would be the converse? Do I even need to do the runloop =
thing in this case?=
