Return-Path: <cyrus@holtmann.org>
Message-ID: <4991878E.4010100@powercraft.nl>
Date: Tue, 10 Feb 2009 14:56:30 +0100
From: Jelle de Jong <jelledejong@powercraft.nl>
MIME-Version: 1.0
To: BlueZ development <linux-bluetooth@vger.kernel.org>
Subject: Bluetooth Optical Mouse BM083 and BM013
Content-Type: multipart/mixed;
 boundary="------------080208000704020202030909"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is a multi-part message in MIME format.
--------------080208000704020202030909
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

This message contains the following attachment(s):
Bluetooth Optical Mouse BM083 and BM013.tar.gz

Hello everybody,

I bought two new bluetooth mouses for testing and both do not work
with the simple-agent.py script. Would somebody be willing to fix the
command line tool to connect mouses? I got the logs and device
information attached in this mail.

Thanks in advance,

Best regards,

Jelle

--------------080208000704020202030909
Content-Type: application/gzip;
 name="Bluetooth Optical Mouse BM083 and BM013.tar.gz"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="Bluetooth Optical Mouse BM083 and BM013.tar.gz"

H4sIAPSGkUkAA+1XW2/iOBTuM7/iPMxD+1CwnSvWCCnQdqfSwCAuo90nlAZTIoU4m4S27K/f
40C5Q9tZtq00/hQ5yfE5h3OxnY96NBW5lPkYfiR5GPgRNOU0E1BvEmpUzk4CgnAIUXfqWHRx
Z4V8gTNKqWkaxGCWc0aopURgnebnj2Oa5X4KgHeRHtPLAj8dvkdA74v60f4XYzl/yv/Tb6gG
24f7b1jWWv+Zhf23mW2cATlRjkfxm/c/mw4ljIMwkPEovC89v+KSiABlm4LLUD2SQxP08ARW
bzGTzPKxjKGchZMkEpf+vYjzcjKbO64TTg1OXHXhg+VsegvjkXxJR4VQujwRSl9gq0AqTA4A
vVkiOPS79RK+QP0KvOEwFVnGgRBOqvzqiluEGyZ3GHiN79Ds9TkYFGMn0G38mL/bJncL+34b
Ov1W67b1B7S7Da9VCDt/wt0sFxlnxLXBDyKu6ig5AfGARcu444JIU5lmnBQGvWcDi5gb+oGc
TPx4mHHTWFmoVOiLqVCLezf8xuTXVX5NVqlQwih3N1Khr0iFGsyhzC2ic2mVOZsZUZs4B3Iy
bGIUZoxsZ2Vba1mtOrZcDg0ZxyLIQxlnvHBaK/JQjXK4jWl4nHrc82CM7iIBlAEeCjk+QDSB
ptftXXfA6/e+wXWr0fmr3VtzQilfXQ6vWksndNfJTnTrG2ojyv2KdH86X5/ToYx7lBO8sBv2
MhJzTySfsAyLU6KLQxzG91Aul+crcnvDK9nys1V8rpYej5wudM/J0RF/T0WWt8O4IYcCzisy
va/coe9/Koy6tKLMKkPxMKiTATUGxFUXPljORek6zkUK7dsWKFu1WQhBh5HwMZ6WeAS0C4M3
Ot2uzIETbxG3qpLSSCe+Wg6riq3t4T3WSuVqHlzLn2Do29VUCt+bbfgp0gz94m4vMzgnT+yi
EHendw/PMyhk1cKg6cfTkR/k01Sk6DKV/hB3KBYnTWQ6j++cWheF7o3wlZ46Yp7uAhwIU4OJ
g+Gqp2Igq6GwKta6iIN0lih3NfiaRTIHORplIse3PJyoivhBME39YIaSVOISzB7DPBjXVi6y
OByNYIJdQ5VOt3uLt0Q+Yjdxe+VoU1M/gws4EEMI1aJcMw5V2yN/NbUhShYi7+YbBH5Shizy
H0StVPro7/whHOF/7ofwf8eY839L8//3wPH+F+P/zv9Ne9l/HI2C/zu25v/vgc/F/3c4zB7+
/4KO5v+a//9m/P+TpXOIx+/+QflFHr97AryaxxOk3Gzg0QHByxxQ+xQ8fo/T/UT+YOCvIvK7
1m8n8qxMFJE3NJH/RSL/0d9rDQ0NDQ0NDQ0NDQ0NDQ0NjbfiX42Gk7oAKAAA
--------------080208000704020202030909
Content-Type: text/x-python;
 name=".simple-agent.py"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename=".simple-agent.py"

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
		return raw_input("Enter PIN Code: ")

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

--------------080208000704020202030909--
