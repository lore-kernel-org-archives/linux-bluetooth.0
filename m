Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
From: Sujay Sarkhel <sujay.sarkhel@ncsu.edu>
Date: Mon, 20 Oct 2014 19:17:26 -0700
Message-ID: <CAE7yNv_iJc=mS+ksZeWwzgYJ6zpDFB+3hRnpwWMT_HjG4ZLTiA@mail.gmail.com>
Subject: BlueZ 5.24: Using the LE Heart Rate Profile
To: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

I'm pretty much new to using BlueZ 5 and I've been experimenting with
a Bluetooth LE heart rate watch on a Raspberry Pi. I would really
appreciate if someone can point me to the right direction.

When I run the "test-heartrate" test, I see the following error:

Traceback (most recent call last):
  File "./test-heartrate", line 88, in <module>
    properties = dev_prop.GetAll(HEARTRATE_INTERFACE)
  File "/usr/lib/python2.7/dist-packages/dbus/proxies.py", line 70, in __call__
    return self._proxy_method(*args, **keywords)
  File "/usr/lib/python2.7/dist-packages/dbus/proxies.py", line 145, in __call__
    **keywords)
  File "/usr/lib/python2.7/dist-packages/dbus/connection.py", line
651, in call_blocking
    message, timeout)
dbus.exceptions.DBusException: org.freedesktop.DBus.Error.InvalidArgs:
No such interface 'org.bluez.HeartRate1'

Not sure what I'm doing wrong. Here're some relevant information

BlueZ version installed: 5.24

For installation, I followed the steps listed in:
http://www.linuxfromscratch.org/blfs/view/svn/general/bluez.html (with
one addition: I added --enable-experimental during configuration)

It seems I'm facing the same issue as described at:
http://comments.gmane.org/gmane.linux.bluez.kernel/47931
I've followed the suggestion provided as well as tried passing -E to
bluetoothd while running it but to no avail.

I can successfully run:
test-discovery : To discover devices, including the heart-rate watch
test-device connect <bt_addr>: To connect to this device

But the one that is failing for me is test-heartrate

Even after connecting to the device, when I try to introspect (
dbus-send --system --dest=org.bluez --print-reply [obj_path]
org.freedesktop.DBus.Introspectable.Introspect), I don't see the
"org.bluez.HeartRate1" showing up, with its appropriate methods.

I can post the entire introspection data, along with the device
properties that I get, if that helps.

Would really appreciate any helpful pointer in this regard. Thanks!!
