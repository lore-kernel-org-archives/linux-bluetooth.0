Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Mon, 1 Aug 2016 14:34:23 +0200 (CEST)
From: Serge van den Boom <serge@vdboom.org>
To: linux-bluetooth@vger.kernel.org
Subject: Registering profile or making discoverable resets adapter class
Message-ID: <alpine.BSF.2.00.1608011427420.69212@toad.stack.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

When a new profile is registered, or an adapter is make discoverable,
the device class of the adapter is reset to the value set in
/etc/bluetooth/main.conf.

The test case below (to be run as root) demonstrates the issue. For this
demonstration, there should be no 'Class = ...' setting in
/etc/bluetooth/main.conf.


Regards,

Serge van den Boom


Output:
============================================================================
Registering signal receiver for property changes.
Starting main loop.
Making adapter '/org/bluez/hci0' non-discoverable.
Setting the Bluetooth device class to 0x000540 through hciconfig.
Class changed to 0x000540.
Registering profile.
Class changed to 0x100000.
Setting the Bluetooth device class to 0x000540 through hciconfig.
Class changed to 0x000540.
Making adapter '/org/bluez/hci0' discoverable.
Class changed to 0x100000.
Exiting.
============================================================================


The test case:
============================================================================
#!/usr/bin/env python3
import dbus.mainloop.glib
import logging
import subprocess
import time
from gi.repository import GLib
	
logging.basicConfig(format="%(message)s", level=logging.INFO)

DEVICE_CLASS = 0x000540
IFACE = "hci0"
ADAPTER = "/org/bluez/hci0"

def classChanged(interface, changed, invalidated):
	if 'Class' in changed:
		logging.info("Class changed to 0x{:06x}.".format(changed['Class']))

def step():
	logging.info("Making adapter '{}' non-discoverable.".format(ADAPTER))
	adapterProps = dbus.Interface(
			bus.get_object('org.bluez', ADAPTER), dbus.PROPERTIES_IFACE)
	adapterProps.Set('org.bluez.Adapter1', 'Discoverable', False)
	yield True

	logging.info("Setting the Bluetooth device class to 0x{:06x} through "
			"hciconfig.".format(DEVICE_CLASS))
	subprocess.call(["hciconfig", IFACE, "class", "0x{:06x}".format(DEVICE_CLASS)])
	yield True

	logging.info("Registering profile.".format(ADAPTER))
	profileManager = dbus.Interface(bus.get_object("org.bluez", "/org/bluez"),
			"org.bluez.ProfileManager1")
	profileManager.RegisterProfile("/org/example/test/profile",
			"00001124-0000-1000-8000-00805f9b34fb", {})
	yield True

	logging.info("Setting the Bluetooth device class to 0x{:06x} through "
			"hciconfig.".format(DEVICE_CLASS))
	subprocess.call(["hciconfig", IFACE, "class", "0x{:06x}".format(DEVICE_CLASS)])
	yield True

	logging.info("Making adapter '{}' discoverable.".format(ADAPTER))
	adapterProps = dbus.Interface(
			bus.get_object('org.bluez', ADAPTER), dbus.PROPERTIES_IFACE)
	adapterProps.Set('org.bluez.Adapter1', 'Discoverable', True)
	yield True

	logging.info("Exiting.")
	gMainLoop.quit()
	yield False

# Prepare the main loop for D-Bus.
dbus.mainloop.glib.DBusGMainLoop(set_as_default=True)
bus = dbus.SystemBus()

# Listen for changes to the adapter class.
logging.info("Registering signal receiver for property changes.")
bus.add_signal_receiver(classChanged, bus_name="org.bluez",
		dbus_interface="org.freedesktop.DBus.Properties", path=ADAPTER,
		signal_name="PropertiesChanged")

# Schedule a step every second.
stepGenerator = step()
GLib.timeout_add(1000, lambda: next(stepGenerator))

# Go!
logging.info("Starting main loop.".format(ADAPTER))
gMainLoop = GLib.MainLoop()
gMainLoop.run()
============================================================================

