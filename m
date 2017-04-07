Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
From: Barry Byford <31baz66@gmail.com>
Date: Fri, 7 Apr 2017 14:47:12 +0100
Message-ID: <CAAu3APbw0JyPfKUi6PZ4Nr2Uh5WXtDprDVFBTj3xr+801b9L6w@mail.gmail.com>
Subject: Serial Port connection with DBus API
To: Bluez mailing list <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,

I am trying to create a serial port server that can be connected to by
an already existing Android app.

The app is trying connect on channel 1. I am taking the
test/test-profile example as my starting point.
https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/test/test-profile?h=5.43

My code is far from finished but I thought it would be enough to
accept the connection (or at least print that a new connection attempt
had happened.) However I am getting an access denied error and I'm
concerned that I'm going down the wrong route on this and it might be
simpler than I am making it.

Error message
$ python3 BTspp.py
Traceback (most recent call last):
  File "BTclassic.py", line 54, in <module>
    dbus.publish('org.bluez.Profile1', Profile('x', 'y'))
  File "/usr/local/lib/python3.5/dist-packages/pydbus/publication.py",
line 42, in publish
    return Publication(self, bus_name, *objects)
  File "/usr/local/lib/python3.5/dist-packages/pydbus/publication.py",
line 35, in __init__
    self._at_exit(bus.request_name(bus_name,
allow_replacement=allow_replacement, replace=replace).__exit__)
  File "/usr/local/lib/python3.5/dist-packages/pydbus/request_name.py",
line 29, in request_name
    return NameOwner(self, name, allow_replacement, replace)
  File "/usr/local/lib/python3.5/dist-packages/pydbus/request_name.py",
line 8, in __init__
    res = bus.dbus.RequestName(name, flags)
  File "/usr/local/lib/python3.5/dist-packages/pydbus/proxy_method.py",
line 75, in __call__
    0, timeout_to_glib(timeout), None).unpack()
GLib.Error: g-dbus-error-quark:
GDBus.Error:org.freedesktop.DBus.Error.AccessDenied: Connection
":1.47" is not allowed to own the service "org.bluez.Profile1" due to
security policies in the configuration file (9

Python code so far:

from pydbus import SystemBus
from gi.repository import GLib

loop = GLib.MainLoop()

dbus = SystemBus()


class Profile(object):
    """
      <node>
        <interface name='org.bluez.Profile1'>
          <method name='Release'>
          </method>
          <method name='Cancel'>
          </method>
          <method name='NewConnection'>
            <arg type='o' name='path' direction='in'/>
            <arg type='h' name='fd' direction='in'/>
            <arg type='a{sv}' name='properties' direction='in'/>
          </method>
          <method name='RequestDisconnection'>
            <arg type='o' name='path' direction='in'/>
          </method>
        </interface>
      </node>
    """
    def __init__(self, x, y):
        pass

    def Release(self):
        pass

    def Cancel(self):
        pass

    def NewConnection(self, path, fd, properties):
        print('New connection', path, fd, properties)

    def RequestDisconnection(self, path):
        pass

if __name__ == '__main__':
    profile_mngr = dbus.get('org.bluez', '/org/bluez')
    uuid = "00001101-0000-1000-8000-00805f9b34fb"
    opts = {
            "AutoConnect": GLib.Variant('b', True),
            'Channel': GLib.Variant('i', 1),
            'Service': GLib.Variant('s', uuid),
            'Name': GLib.Variant('s', 'Serial Port')
        }

    # my_profile = Profile(dbus, '/org/bluez/example')
    dbus.publish('org.bluez.Profile1', Profile('x', 'y'))
    profile_mngr.RegisterProfile('/foo/bar/profile', uuid, opts)

    loop.run()


Is there a simpler way of doing this?

Thanks,
Barry
