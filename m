Return-Path: <cyrus@holtmann.org>
Date: Mon, 25 Mar 2013 18:23:09 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Brendan West <extremeskateboarding@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: Problem Running Bluez Tests
Message-ID: <20130325162309.GA25769@x220.P-661HNU-F1>
References: <CAB8sVA-XJeACK9YHEB0V3vLHbskPaVe6A+C9_oM6t2jP-UV+pQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAB8sVA-XJeACK9YHEB0V3vLHbskPaVe6A+C9_oM6t2jP-UV+pQ@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Brendan,

On Mon, Mar 25, 2013, Brendan West wrote:
 ./test-heartrate -i hci1 -b FC:4E:09:DC:68:44
> Traceback (most recent call last):
> File "./test-heartrate", line 62, in <module>
> managed_objects = bluezutils.get_managed_objects()
> File "/home/user/Downloads/bluez-5.2/test/bluezutils.py", line 11, in
> get_managed_objects
> return manager.GetManagedObjects()
> File "/usr/lib/python2.7/dist-packages/dbus/proxies.py", line 70, in __call__
> return self._proxy_method(*args, **keywords)
> File "/usr/lib/python2.7/dist-packages/dbus/proxies.py", line 145, in __call__
> **keywords)
> File "/usr/lib/python2.7/dist-packages/dbus/connection.py", line 651,
> in call_blocking
> message, timeout)
> dbus.exceptions.DBusException:
> org.freedesktop.DBus.Error.UnknownMethod: Method "GetManagedObjects"
> with signature "" on interface "org.freedesktop.DBus.ObjectManager"
> doesn't exist

This sounds like you still have an old (4.x) bluetoothd running. You'll
need to stop it and start the one you compiled from the 5.x tree. Also
be sure to install a new D-Bus policy (src/bluetooth.conf to
/etc/dbus-1.system.d/) since a lot of interface names have changed since
4.x.

Johan
