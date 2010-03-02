Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Tue, 2 Mar 2010 16:26:51 +0000
Message-ID: <aa6ee971003020826m7e6db9b2jd5b9456a1aa1d368@mail.gmail.com>
Subject: Bluetooth SPP on Nokia N900 (Maemo 5)
From: Henry Owens <owens.henry@googlemail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi All,

My first mail to this list. I am currently trying to get a bluetooth
SPP connection going on my Nokia N900, but I'm having some
difficulties using the examples on the HOWTO Wiki.

Specifically, I get an error related to the ActivateService call in
the example - I have seen reference to this being obselete in Bluez
4.x, is this the problem in the example code?

If so, how could the code be rewritten to allow a connection (I have
no prior experience with BT programming, but am comfortable in
Python).

The code at the moment is:

import dbus
import time
import sys
bus = dbus.SystemBus()
bmgr = dbus.Interface(bus.get_object('org.bluez', '/org/bluez'),
'org.bluez.Manager')
bus_id = bmgr.ActivateService('serial')
serial = dbus.Interface(bus.get_object(bus_id, '/org/bluez/serial'),
'org.bluez.serial.Manager')
# Service connection, read the serial API to check the available patterns
if (len(sys.argv) < 2):
        print "Usage: %s <address> [service]" % (sys.argv[0])
        sys.exit(1)
address = sys.argv[1]
if (len(sys.argv) < 3):
        service = "spp"
else:
        service = sys.argv[2]
# Bind to the default local adapter
device = serial.ConnectService(address, service)
print "Connected %s to %s" % (device, address)
print "Press CTRL-C to disconnect"
try:
        time.sleep(1000)
        print "Terminating connection"
except:
        pass
serial.DisconnectService(device)


Regards,
Henry.
