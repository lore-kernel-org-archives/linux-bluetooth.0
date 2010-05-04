Return-Path: <cyrus@holtmann.org>
From: =?iso-8859-1?q?Jos=E9_Antonio_Santos_Cadenas?=
	<jcaden@libresoft.es>
Reply-To: jcaden@libresoft.es
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Subject: Re: HDP proposed API
Date: Tue, 4 May 2010 12:54:37 +0200
Cc: "Santiago Carot-Nemesio" <scarot@libresoft.es>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <1272959741.2182.123.camel@mosquito> <m2u2d5a2c101005040304ke238595n54b8584dd78b8f37@mail.gmail.com>
In-Reply-To: <m2u2d5a2c101005040304ke238595n54b8584dd78b8f37@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201005041254.37990.jcaden@libresoft.es>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi all,

Next a simple example program in python using the api that we proposed in this thread.

We still use the name Device but maybe a better name can be used.

Regards.

----------
#!/usr/bin/python
# -*- coding: utf-8 -*-

import dbus
import dbus.service
from dbus.mainloop.glib import DBusGMainLoop
import gobject
import os

DBusGMainLoop(set_as_default=True)
loop = gobject.MainLoop()

obj_path = "/python/tester/hdp"

bus = dbus.SystemBus()

# This object receives the information from the daemon
class HDP(dbus.service.Object):
	def __init__(self, bus, obj_path):
		self.bus = bus
		dbus.service.Object.__init__(self, self.bus, obj_path)
	@dbus.service.method('org.bluez.HdpAgent',
			     in_signature='o', out_signature='',
			     sender_keyword='sender')
	def DeviceConnected(self, path, sender=None):
		print "Connected new device %s: (sender %s)" % (path, sender)
	@dbus.service.method('org.bluez.HdpAgent',
			     in_signature='o', out_signature='',
			     sender_keyword='sender')
	def DeviceDisconnected(self, path, sender=None):
		print "Device %s: disconnected (sender: %s)" % (path, sender)
	@dbus.service.method('org.bluez.HdpAgent',
			     in_signature='oq', out_signature='',
			     sender_keyword='sender')
	def DeletedDc(self, dev, mdlid, sender=None):
		print "Data channel: %d deleted on dev %s (sender %s)" % \
						(mdlid, dev, sender)
	@dbus.service.method('org.bluez.HdpAgent',
			     in_signature='oqh', out_signature='',
			     sender_keyword='sender')
	def CreatedDc(self, dev, mdlid, fd, sender=None):
		print "Data channel: %d created on dev %s: fd: %d " % \
					        (mdlid, dev, fd, sender)

hdp_obj = HDP(bus, obj_path);

manager = dbus.Interface(bus.get_object("org.bluez", "/"),
						"org.bluez.Manager")
hdp = dbus.Interface(bus.get_object("org.bluez", manager.DefaultAdapter()),
						"org.bluez.Hdp")

data_spec = 1
session_path = hdp.CreateSession(obj_path, data_spec)

session = dbus.Interface(bus.get_object("org.bluez", session_path),
						"org.bluez.HdpSession")

# Configuration of the session, adding suported features
source_role = 0 
mdep = session.AllocateMdep(source_role)
session.AddFeature(mdep, 4100, "Pulse oximeter")

sink_role = 1 # Sink role
mdep2 = session.AllocateMdep(sink_role)
session.AddFeature(mdep2, 4111, "Scale")
session.AddFeature(mdep2, 4100, "Pulse oximeter sink")

# Now start the session
# Starts a MCAP session and register in the SDP
session.Start()

# *****************************************************************************
# Now, if you start the main loop, the HDP events will be notified in HDP class
# *****************************************************************************

# Connect to a remote device
addr = "XX:XX:XX:XX:XX:XX"
dev_path = session.Connect(addr)
dev = dbus.Interface(bus.get_object("org.bluez", dev_path),
						"org.bluez.HDPDevice")

dcid = dev.OpenDc(rem_mdep, conf)
fd = dev.GetDcFd(dcid)

# You can use the fd for write or read data.
# If the read/write operation fails, reconnection will be performed getting
# the file descriptor again

while some_condition:
	try:
		os.write(fd, "some_data")
	except:
		fd = dev.GetDcFd(dcid) # Implicit reconeciton of dc

dev.DeleteDc(dcid) # Close data channel
dev.DeleteAllDc() # Close all data channels for this mcl (device+session)

if power_save:
	session.Disconnect(dev_path, False)
	# Close the connection with the remote devide for power save,
	# Reconnections will be possible
else:
	session.Disconnect(dev_path, True)
	# Close the connection with the remote devide forever and clean state
	# Reconnections will NOT be possible

hdp.DeleteSession(session_path)
# Close the session, all connections and data channels will be closed
