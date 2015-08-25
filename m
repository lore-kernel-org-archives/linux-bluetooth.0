Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Tue, 25 Aug 2015 15:52:15 +0200
Message-ID: <CAG=SMqacc8KAZbL-OqhTMuddDJ0x1XUHYLezn2byHdnYFYST6Q@mail.gmail.com>
Subject: Bluez 5.33 D-Bus error
From: Fabian Bergmark <fabian.bergmark@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Im writing a connection library in C++ for a Bluetooth low energy
device using the D-Bus interface. I'm able to connect and receive
messages from the device, but after some time (usually a few minutes)
the device disconnects and I find this in the syslog:

aug 25 15:14:30 arch.laptop gnome-session[706]:
ERROR:dbus.connection:Exception in handler for D-Bus signal:
aug 25 15:14:30 arch.laptop gnome-session[706]: Traceback (most recent
call last):
aug 25 15:14:30 arch.laptop gnome-session[706]: File
"/usr/lib/python3.4/site-packages/dbus/connection.py", line 230, in
maybe_handle_message
aug 25 15:14:30 arch.laptop gnome-session[706]: self._handler(*args, **kwargs)
aug 25 15:14:30 arch.laptop gnome-session[706]: File
"/usr/lib/python3.4/site-packages/blueman/bluez/PropertiesBlueZInterface.py",
line 55, in wrapper
aug 25 15:14:30 arch.laptop gnome-session[706]: handler(name, value, **kwargs)
aug 25 15:14:30 arch.laptop gnome-session[706]: File
"/usr/lib/python3.4/site-packages/blueman/plugins/applet/GameControllerWakelock.py",
line 34, in on_device_property_change
aug 25 15:14:30 arch.laptop gnome-session[706]: klass =
Device(path).get_properties()["Class"] & 0x1fff
aug 25 15:14:30 arch.laptop gnome-session[706]: KeyError: 'Class'

Looking in the documentation for bluez, Class should be an optional
property. Also, the location of the error indicates that the it
identifies the device as a game controller
(GameControllerWakelock.py), but it is not.

Any idea what could be wrong?
