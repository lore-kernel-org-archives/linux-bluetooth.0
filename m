Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20090513154809.GK6984@titan.makhutov-it.de>
References: <20090513154809.GK6984@titan.makhutov-it.de>
Date: Wed, 13 May 2009 22:46:28 -0600
Message-ID: <d89ddf300905132146t31b860ddtb43e3371f094f79b@mail.gmail.com>
Subject: Re: Passkey-Agent for bluez 4.xx
From: Brad Midgley <bmidgley@gmail.com>
To: Artem Makhutov <artem@makhutov.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Artem,

It may not be the best way, but I modified simple-agent from tests
with a hardcoded pin, then I run it in the background at startup.
Replace 5555 with your pin.

#!/usr/bin/python

import gobject

import sys
import dbus
import dbus.service
import dbus.mainloop.glib

class Rejected(dbus.DBusException):
	_dbus_error_name = "org.bluez.Error.Rejected"

class Agent(dbus.service.Object):
	exit_on_release = True

	def set_exit_on_release(self, exit_on_release):
		self.exit_on_release = exit_on_release

	@dbus.service.method("org.bluez.Agent",
					in_signature="", out_signature="")
	def Release(self):
		print "Release"
		if self.exit_on_release:
			mainloop.quit()

	@dbus.service.method("org.bluez.Agent",
					in_signature="os", out_signature="")
	def Authorize(self, device, uuid):
		print "Authorize (%s, %s)" % (device, uuid)

	@dbus.service.method("org.bluez.Agent",
					in_signature="o", out_signature="s")
	def RequestPinCode(self, device):
		print "RequestPinCode (%s)" % (device)
		return "5555"

	@dbus.service.method("org.bluez.Agent",
					in_signature="o", out_signature="u")
	def RequestPasskey(self, device):
		print "RequestPasskey (%s)" % (device)
		passkey = raw_input("Enter passkey: ")
		return dbus.UInt32(passkey)

	@dbus.service.method("org.bluez.Agent",
					in_signature="ou", out_signature="")
	def DisplayPasskey(self, device, passkey):
		print "DisplayPasskey (%s, %d)" % (device, passkey)

	@dbus.service.method("org.bluez.Agent",
					in_signature="ou", out_signature="")
	def RequestConfirmation(self, device, passkey):
		print "RequestConfirmation (%s, %d)" % (device, passkey)
		confirm = raw_input("Confirm passkey (yes/no): ")
		if (confirm == "yes"):
			return
		raise Rejected("Passkey doesn't match")

	@dbus.service.method("org.bluez.Agent",
					in_signature="s", out_signature="")
	def ConfirmModeChange(self, mode):
		print "ConfirmModeChange (%s)" % (mode)

	@dbus.service.method("org.bluez.Agent",
					in_signature="", out_signature="")
	def Cancel(self):
		print "Cancel"

def create_device_reply(device):
	print "New device (%s)" % (device)
	mainloop.quit()

def create_device_error(error):
	print "Creating device failed: %s" % (error)
	mainloop.quit()

if __name__ == '__main__':
	dbus.mainloop.glib.DBusGMainLoop(set_as_default=True)

	bus = dbus.SystemBus()
	manager = dbus.Interface(bus.get_object("org.bluez", "/"),
							"org.bluez.Manager")

	if len(sys.argv) > 1:
		path = manager.FindAdapter(sys.argv[1])
	else:
		path = manager.DefaultAdapter()

	adapter = dbus.Interface(bus.get_object("org.bluez", path),
							"org.bluez.Adapter")

	path = "/test/agent"
	agent = Agent(bus, path)

	mainloop = gobject.MainLoop()

	if len(sys.argv) > 2:
		if len(sys.argv) > 3:
			device = adapter.FindDevice(sys.argv[2])
			adapter.RemoveDevice(device)

		agent.set_exit_on_release(False)
		adapter.CreatePairedDevice(sys.argv[2], path, "DisplayYesNo",
					reply_handler=create_device_reply,
					error_handler=create_device_error)
	else:
		adapter.RegisterAgent(path, "DisplayYesNo")
		print "Agent registered"

	mainloop.run()

	#adapter.UnregisterAgent(path)
	#print "Agent unregistered"


On Wed, May 13, 2009 at 9:48 AM, Artem Makhutov <artem@makhutov.org> wrote:
> Hello,
>
> I would like to use bluez 4.39.
>
> What I am missing is a passkey-agant for the console.
> Something like the old passkey-agent application in bluez 3.xx.
>
> Since I have 2 bluetooth dongles, I need a passkey-agent that registers
> it self as a default passkey-agent. And where I can enter a default pin,
> that is used for all authentications.
>
> The "passkey-agent" application from bluez 3.xx was pretty fine
> (passkey-agent --default 1234).
>
> How can I do the same with bluez 4.xx?
>
> Thanks, Artem
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>



-- 
Brad Midgley
