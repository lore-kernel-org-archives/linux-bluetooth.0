Return-Path: <cyrus@holtmann.org>
Message-ID: <d89ddf300812212120n31776bc9m9fc26790287f4d99@mail.gmail.com>
Date: Sun, 21 Dec 2008 22:20:02 -0700
From: "Brad Midgley" <bmidgley@gmail.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: python examples for keyboard connection
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hey

I'm working on gumstix overo/oe so the regular gnome stuff is not
available. This system is running bluez 3.36. I can work on updating
to 4.x if it helps.

I was able to use this simple script to connect a mouse by specifying
its bdaddr on the command line. (Device-initiated reconnect does not
seem to work, but this succeeded on the first attempt anyway)

==================================
#!/usr/bin/python

import sys
import dbus

devices = sys.argv
del devices[0]

bus = dbus.SystemBus()
bmgr = dbus.Interface(bus.get_object('org.bluez', '/org/bluez'),
'org.bluez.Manager')
bus_id = bmgr.ActivateService('input')
imgr = dbus.Interface(bus.get_object(bus_id, '/org/bluez/input'),
'org.bluez.input.Manager')

for device in devices:
        path = imgr.CreateDevice(device)
        idev = dbus.Interface (bus.get_object(bus_id, path),
'org.bluez.input.Device')
        idev.Connect()
==================================

but it doesn't work for connecting a think outside keyboard:

root@overo:~# ./pairconnect.py 00:03:51:C9:EA:53
Traceback (most recent call last):
  File "./pairconnect.py", line 19, in <module>
    idev.Connect()
  File "/usr/lib/python2.5/site-packages/dbus/proxies.py", line 68, in __call__
    return self._proxy_method(*args, **keywords)
  File "/usr/lib/python2.5/site-packages/dbus/proxies.py", line 140, in __call__
    **keywords)
  File "/usr/lib/python2.5/site-packages/dbus/connection.py", line
622, in call_blocking
    message, timeout)
dbus.exceptions.DBusException:
org.bluez.Error.ConnectionAttemptFailed: Required key not available

also, what should I do to look up a device first so I don't get this
on subsequent attempts:

dbus.exceptions.DBusException: org.bluez.Error.AlreadyExists: Input
Already exists

I'll document whatever works out on the wiki.

-- 
Brad Midgley
