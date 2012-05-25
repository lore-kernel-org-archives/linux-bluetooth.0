Return-Path: <cyrus@holtmann.org>
Date: Thu, 24 May 2012 22:44:25 -0700
From: Steve Langasek <steve.langasek@canonical.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/1] Update tests to be compatible with gi and python3
Message-ID: <20120525054425.GA10062@virgil.dodds.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="+QahgC5+KEYLbs62"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--+QahgC5+KEYLbs62
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

=46rom: Steve Langasek <steve.langasek@canonical.com>

This patch makes the python tests source-compatible with python 3, while
leaving the interpreter at python 2 for now.

The tradeoff is that this source is no longer compatible with python
versions < 2.6, and requires gobject-introspection for the glib-based tests.

Signed-off-by: Steve Langasek <steve.langasek@canonical.com>
---
 test/list-devices      |   30 ++++++++++---------
 test/monitor-bluetooth |    6 ++--
 test/simple-agent      |   41 +++++++++++++------------
 test/simple-endpoint   |   12 ++++----
 test/simple-service    |    8 +++--
 test/test-adapter      |   52 ++++++++++++++++----------------
 test/test-attrib       |   52 ++++++++++++++++----------------
 test/test-audio        |    8 +++--
 test/test-device       |   78 +++++++++++++++++++++++++-------------------=
----
 test/test-discovery    |   16 +++++-----
 test/test-health       |   62 +++++++++++++++++++-------------------
 test/test-health-sink  |   24 ++++++++-------
 test/test-input        |    8 +++--
 test/test-manager      |   12 ++++----
 test/test-nap          |    8 +++--
 test/test-network      |   10 ++++---
 test/test-oob          |   34 +++++++++++----------
 test/test-proximity    |   14 +++++----
 test/test-sap-server   |   64 ++++++++++++++++++++-------------------
 test/test-serial       |   10 ++++---
 test/test-serial-proxy |    6 ++--
 test/test-service      |   14 +++++----
 test/test-telephony    |   38 ++++++++++++-----------
 test/test-thermometer  |   28 +++++++++--------
 24 files changed, 342 insertions(+), 293 deletions(-)

diff --git a/test/list-devices b/test/list-devices
index cb564be..e2a5833 100755
--- a/test/list-devices
+++ b/test/list-devices
@@ -1,5 +1,7 @@
 #!/usr/bin/python
=20
+from __future__ import absolute_import, print_function, unicode_literals
+
 import dbus
=20
 bus =3D dbus.SystemBus()
@@ -32,19 +34,19 @@ adapter_list =3D manager.ListAdapters()
 for i in adapter_list:
 	adapter =3D dbus.Interface(bus.get_object("org.bluez", i),
 							"org.bluez.Adapter")
-	print "[ " + i + " ]"
+	print("[ " + i + " ]")
=20
 	properties  =3D adapter.GetProperties()
 	for key in properties.keys():
 		value =3D properties[key]
 		if (key =3D=3D "Devices"):
 			list =3D extract_objects(value)
-			print "    %s =3D %s" % (key, list)
+			print("    %s =3D %s" % (key, list))
 		elif (key =3D=3D "UUIDs"):
 			list =3D extract_uuids(value)
-			print "    %s =3D %s" % (key, list)
+			print("    %s =3D %s" % (key, list))
 		else:
-			print "    %s =3D %s" % (key, value)
+			print("    %s =3D %s" % (key, value))
=20
 	try:
 		device_list =3D properties["Devices"]
@@ -54,27 +56,27 @@ for i in adapter_list:
 	for n in device_list:
 		device =3D dbus.Interface(bus.get_object("org.bluez", n),
 							"org.bluez.Device")
-		print "    [ " + n + " ]"
+		print("    [ " + n + " ]")
=20
 		properties =3D device.GetProperties()
 		for key in properties.keys():
 			value =3D properties[key]
 			if (key =3D=3D "Nodes"):
 				list =3D extract_objects(value)
-				print "        %s =3D %s" % (key, list)
+				print("        %s =3D %s" % (key, list))
 			elif (key =3D=3D "UUIDs"):
 				list =3D extract_uuids(value)
-				print "        %s =3D %s" % (key, list)
+				print("        %s =3D %s" % (key, list))
 			elif (key =3D=3D "Class"):
-				print "        %s =3D 0x%06x" % (key, value)
+				print("        %s =3D 0x%06x" % (key, value))
 			elif (key =3D=3D "Vendor"):
-				print "        %s =3D 0x%04x" % (key, value)
+				print("        %s =3D 0x%04x" % (key, value))
 			elif (key =3D=3D "Product"):
-				print "        %s =3D 0x%04x" % (key, value)
+				print("        %s =3D 0x%04x" % (key, value))
 			elif (key =3D=3D "Version"):
-				print "        %s =3D 0x%04x" % (key, value)
+				print("        %s =3D 0x%04x" % (key, value))
 			else:
-				print "        %s =3D %s" % (key, value)
+				print("        %s =3D %s" % (key, value))
=20
 		try:
 			node_list =3D properties["Nodes"]
@@ -84,10 +86,10 @@ for i in adapter_list:
 		for x in node_list:
 			node =3D dbus.Interface(bus.get_object("org.bluez", x),
 							"org.bluez.Node")
-			print "        [ " + x + " ]"
+			print("        [ " + x + " ]")
=20
 			properties =3D node.GetProperties()
 			for key in properties.keys():
-				print "            %s =3D %s" % (key, properties[key])
+				print("            %s =3D %s" % (key, properties[key]))
=20
 	print
diff --git a/test/monitor-bluetooth b/test/monitor-bluetooth
index a5e5300..4a598e1 100755
--- a/test/monitor-bluetooth
+++ b/test/monitor-bluetooth
@@ -1,5 +1,7 @@
 #!/usr/bin/python
=20
+from __future__ import absolute_import, print_function, unicode_literals
+
 import gobject
=20
 import dbus
@@ -8,12 +10,12 @@ import dbus.mainloop.glib
 def property_changed(name, value, path, interface):
 	iface =3D interface[interface.rfind(".") + 1:]
 	val =3D str(value)
-	print "{%s.PropertyChanged} [%s] %s =3D %s" % (iface, path, name, val)
+	print("{%s.PropertyChanged} [%s] %s =3D %s" % (iface, path, name, val))
=20
 def object_signal(value, path, interface, member):
 	iface =3D interface[interface.rfind(".") + 1:]
 	val =3D str(value)
-	print "{%s.%s} [%s] Path =3D %s" % (iface, member, path, val)
+	print("{%s.%s} [%s] Path =3D %s" % (iface, member, path, val))
=20
 if __name__ =3D=3D '__main__':
 	dbus.mainloop.glib.DBusGMainLoop(set_as_default=3DTrue)
diff --git a/test/simple-agent b/test/simple-agent
index 38d0235..5fe5da5 100755
--- a/test/simple-agent
+++ b/test/simple-agent
@@ -1,6 +1,8 @@
 #!/usr/bin/python
=20
-import gobject
+from __future__ import absolute_import, print_function, unicode_literals
+
+from gi.repository import GObject
=20
 import sys
 import dbus
@@ -20,15 +22,15 @@ class Agent(dbus.service.Object):
 	@dbus.service.method("org.bluez.Agent",
 					in_signature=3D"", out_signature=3D"")
 	def Release(self):
-		print "Release"
+		print("Release")
 		if self.exit_on_release:
 			mainloop.quit()
=20
 	@dbus.service.method("org.bluez.Agent",
 					in_signature=3D"os", out_signature=3D"")
 	def Authorize(self, device, uuid):
-		print "Authorize (%s, %s)" % (device, uuid)
-		authorize =3D raw_input("Authorize connection (yes/no): ")
+		print("Authorize (%s, %s)" % (device, uuid))
+		authorize =3D input("Authorize connection (yes/no): ")
 		if (authorize =3D=3D "yes"):
 			return
 		raise Rejected("Connection rejected by user")
@@ -36,20 +38,20 @@ class Agent(dbus.service.Object):
 	@dbus.service.method("org.bluez.Agent",
 					in_signature=3D"o", out_signature=3D"s")
 	def RequestPinCode(self, device):
-		print "RequestPinCode (%s)" % (device)
-		return raw_input("Enter PIN Code: ")
+		print("RequestPinCode (%s)" % (device))
+		return input("Enter PIN Code: ")
=20
 	@dbus.service.method("org.bluez.Agent",
 					in_signature=3D"o", out_signature=3D"u")
 	def RequestPasskey(self, device):
-		print "RequestPasskey (%s)" % (device)
-		passkey =3D raw_input("Enter passkey: ")
+		print("RequestPasskey (%s)" % (device))
+		passkey =3D input("Enter passkey: ")
 		return dbus.UInt32(passkey)
=20
 	@dbus.service.method("org.bluez.Agent",
 					in_signature=3D"ou", out_signature=3D"")
 	def DisplayPasskey(self, device, passkey):
-		print "DisplayPasskey (%s, %06d)" % (device, passkey)
+		print("DisplayPasskey (%s, %06d)" % (device, passkey))
=20
 	@dbus.service.method("org.bluez.Agent",
 					in_signature=3D"os", out_signature=3D"")
@@ -59,8 +61,8 @@ class Agent(dbus.service.Object):
 	@dbus.service.method("org.bluez.Agent",
 					in_signature=3D"ou", out_signature=3D"")
 	def RequestConfirmation(self, device, passkey):
-		print "RequestConfirmation (%s, %06d)" % (device, passkey)
-		confirm =3D raw_input("Confirm passkey (yes/no): ")
+		print("RequestConfirmation (%s, %06d)" % (device, passkey))
+		confirm =3D input("Confirm passkey (yes/no): ")
 		if (confirm =3D=3D "yes"):
 			return
 		raise Rejected("Passkey doesn't match")
@@ -68,8 +70,8 @@ class Agent(dbus.service.Object):
 	@dbus.service.method("org.bluez.Agent",
 					in_signature=3D"s", out_signature=3D"")
 	def ConfirmModeChange(self, mode):
-		print "ConfirmModeChange (%s)" % (mode)
-		authorize =3D raw_input("Authorize mode change (yes/no): ")
+		print("ConfirmModeChange (%s)" % (mode))
+		authorize =3D input("Authorize mode change (yes/no): ")
 		if (authorize =3D=3D "yes"):
 			return
 		raise Rejected("Mode change by user")
@@ -77,14 +79,14 @@ class Agent(dbus.service.Object):
 	@dbus.service.method("org.bluez.Agent",
 					in_signature=3D"", out_signature=3D"")
 	def Cancel(self):
-		print "Cancel"
+		print("Cancel")
=20
 def create_device_reply(device):
-	print "New device (%s)" % (device)
+	print("New device (%s)" % (device))
 	mainloop.quit()
=20
 def create_device_error(error):
-	print "Creating device failed: %s" % (error)
+	print("Creating device failed: %s" % (error))
 	mainloop.quit()
=20
 if __name__ =3D=3D '__main__':
@@ -114,7 +116,7 @@ if __name__ =3D=3D '__main__':
 	path =3D "/test/agent"
 	agent =3D Agent(bus, path)
=20
-	mainloop =3D gobject.MainLoop()
+	mainloop =3D GObject.MainLoop()
=20
 	if len(args) > 1:
 		if len(args) > 2:
@@ -127,9 +129,10 @@ if __name__ =3D=3D '__main__':
 					error_handler=3Dcreate_device_error)
 	else:
 		adapter.RegisterAgent(path, capability)
-		print "Agent registered"
+		print("Agent registered")
=20
 	mainloop.run()
=20
 	#adapter.UnregisterAgent(path)
-	#print "Agent unregistered"
+	#print("Agent unregistered")
+
diff --git a/test/simple-endpoint b/test/simple-endpoint
index e09a528..20c8159 100755
--- a/test/simple-endpoint
+++ b/test/simple-endpoint
@@ -1,5 +1,7 @@
 #!/usr/bin/python
=20
+from __future__ import absolute_import, print_function, unicode_literals
+
 import sys
 import dbus
 import dbus.service
@@ -52,25 +54,25 @@ class Endpoint(dbus.service.Object):
 	@dbus.service.method("org.bluez.MediaEndpoint",
 					in_signature=3D"", out_signature=3D"")
 	def Release(self):
-		print "Release"
+		print("Release")
 		if self.exit_on_release:
 			mainloop.quit()
=20
 	@dbus.service.method("org.bluez.MediaEndpoint",
 					in_signature=3D"", out_signature=3D"")
 	def ClearConfiguration(self):
-		print "ClearConfiguration"
+		print("ClearConfiguration")
=20
 	@dbus.service.method("org.bluez.MediaEndpoint",
 					in_signature=3D"oay", out_signature=3D"")
 	def SetConfiguration(self, transport, config):
-		print "SetConfiguration (%s, %s)" % (transport, config)
+		print("SetConfiguration (%s, %s)" % (transport, config))
 		return
=20
 	@dbus.service.method("org.bluez.MediaEndpoint",
 					in_signature=3D"ay", out_signature=3D"ay")
 	def SelectConfiguration(self, caps):
-		print "SelectConfiguration (%s)" % (caps)
+		print("SelectConfiguration (%s)" % (caps))
 		return self.configuration
=20
 if __name__ =3D=3D '__main__':
@@ -119,7 +121,7 @@ if __name__ =3D=3D '__main__':
 							"Capabilities" :  PCM_CONFIGURATION })
 			endpoint.default_configuration(dbus.Array([]))
=20
-	print properties
+	print(properties)
=20
 	media.RegisterEndpoint(path, properties)
=20
diff --git a/test/simple-service b/test/simple-service
index d03ec3d..ed27d0c 100755
--- a/test/simple-service
+++ b/test/simple-service
@@ -1,5 +1,7 @@
 #!/usr/bin/python
=20
+from __future__ import absolute_import, print_function, unicode_literals
+
 import sys
 import time
 import dbus
@@ -114,13 +116,13 @@ service =3D dbus.Interface(bus.get_object("org.bluez"=
, path),
=20
 handle =3D service.AddRecord(xml)
=20
-print "Service record with handle 0x%04x added" % (handle)
+print("Service record with handle 0x%04x added" % (handle))
=20
-print "Press CTRL-C to remove service record"
+print("Press CTRL-C to remove service record")
=20
 try:
 	time.sleep(1000)
-	print "Terminating session"
+	print("Terminating session")
 except:
 	pass
=20
diff --git a/test/test-adapter b/test/test-adapter
index 762ef98..4e2f029 100755
--- a/test/test-adapter
+++ b/test/test-adapter
@@ -1,5 +1,7 @@
 #!/usr/bin/python
=20
+from __future__ import absolute_import, print_function, unicode_literals
+
 import sys
 import dbus
 import time
@@ -26,28 +28,28 @@ adapter =3D dbus.Interface(bus.get_object("org.bluez", =
adapter_path),
 							"org.bluez.Adapter")
=20
 if (len(args) < 1):
-	print "Usage: %s <command>" % (sys.argv[0])
-	print ""
-	print "  address"
-	print "  list"
-	print "  name [name]"
-	print "  powered [on/off]"
-	print "  pairable [on/off]"
-	print "  pairabletimeout [timeout]"
-	print "  discoverable [on/off]"
-	print "  discoverabletimeout [timeout]"
-	print "  discovering"
+	print("Usage: %s <command>" % (sys.argv[0]))
+	print("")
+	print("  address")
+	print("  list")
+	print("  name [name]")
+	print("  powered [on/off]")
+	print("  pairable [on/off]")
+	print("  pairabletimeout [timeout]")
+	print("  discoverable [on/off]")
+	print("  discoverabletimeout [timeout]")
+	print("  discovering")
 	sys.exit(1)
=20
 if (args[0] =3D=3D "address"):
 	properties =3D adapter.GetProperties()
-	print properties["Address"]
+	print(properties["Address"])
 	sys.exit(0)
=20
 if (args[0] =3D=3D "name"):
 	if (len(args) < 2):
 		properties =3D adapter.GetProperties()
-		print properties["Name"]
+		print(properties["Name"])
 	else:
 		adapter.SetProperty("Name", args[1])
 	sys.exit(0)
@@ -59,19 +61,19 @@ if (args[0] =3D=3D "list"):
 			adapter =3D dbus.Interface(bus.get_object("org.bluez", adapter_path),
 								"org.bluez.Adapter")
 			prop =3D adapter.GetProperties()
-			print " [ %s ]" % (adapter_path)
-			for (key, value) in prop.iteritems():
+			print(" [ %s ]" % (adapter_path))
+			for (key, value) in prop.items():
 				if (key =3D=3D "Class"):
-					print "    %s =3D 0x%06x" % (key, value)
+					print("    %s =3D 0x%06x" % (key, value))
 				else:
-					print "    %s =3D %s" % (key, value)
-			print
+					print("    %s =3D %s" % (key, value))
+			print()
 	sys.exit(0)
=20
 if (args[0] =3D=3D "powered"):
 	if (len(args) < 2):
 		properties =3D adapter.GetProperties()
-		print properties["Powered"]
+		print(properties["Powered"])
 	else:
 		if (args[1] =3D=3D "on"):
 			value =3D dbus.Boolean(1)
@@ -85,7 +87,7 @@ if (args[0] =3D=3D "powered"):
 if (args[0] =3D=3D "pairable"):
 	if (len(args) < 2):
 		properties =3D adapter.GetProperties()
-		print properties["Pairable"]
+		print(properties["Pairable"])
 	else:
 		if (args[1] =3D=3D "on"):
 			value =3D dbus.Boolean(1)
@@ -99,7 +101,7 @@ if (args[0] =3D=3D "pairable"):
 if (args[0] =3D=3D "pairabletimeout"):
 	if (len(args) < 2):
 		properties =3D adapter.GetProperties()
-		print properties["PairableTimeout"]
+		print(properties["PairableTimeout"])
 	else:
 		timeout =3D dbus.UInt32(args[1])
 		adapter.SetProperty("PairableTimeout", timeout)
@@ -108,7 +110,7 @@ if (args[0] =3D=3D "pairabletimeout"):
 if (args[0] =3D=3D "discoverable"):
 	if (len(args) < 2):
 		properties =3D adapter.GetProperties()
-		print properties["Discoverable"]
+		print(properties["Discoverable"])
 	else:
 		if (args[1] =3D=3D "on"):
 			value =3D dbus.Boolean(1)
@@ -122,7 +124,7 @@ if (args[0] =3D=3D "discoverable"):
 if (args[0] =3D=3D "discoverabletimeout"):
 	if (len(args) < 2):
 		properties =3D adapter.GetProperties()
-		print properties["DiscoverableTimeout"]
+		print(properties["DiscoverableTimeout"])
 	else:
 		timeout =3D dbus.UInt32(args[1])
 		adapter.SetProperty("DiscoverableTimeout", timeout)
@@ -130,8 +132,8 @@ if (args[0] =3D=3D "discoverabletimeout"):
=20
 if (args[0] =3D=3D "discovering"):
 	properties =3D adapter.GetProperties()
-	print properties["Discovering"]
+	print(properties["Discovering"])
 	sys.exit(0)
=20
-print "Unknown command"
+print("Unknown command")
 sys.exit(1)
diff --git a/test/test-attrib b/test/test-attrib
index b9e83c5..52b399c 100755
--- a/test/test-attrib
+++ b/test/test-attrib
@@ -1,4 +1,6 @@
 #!/usr/bin/python
+
+from __future__ import absolute_import, print_function, unicode_literals
 # Script for testing the Attribute D-Bus API
=20
 import sys
@@ -35,12 +37,12 @@ adapter =3D dbus.Interface(bus.get_object("org.bluez", =
adapter_path),
 							"org.bluez.Adapter")
=20
 if (len(args) < 1):
-	print "Usage: %s <command>" % (sys.argv[0])
-	print ""
-	print "	 list"
-	print "	 services <address>"
-	print "	 discover <service path>"
-	print "	 chars <service path>"
+	print("Usage: %s <command>" % (sys.argv[0]))
+	print("")
+	print("	 list")
+	print("	 services <address>")
+	print("	 discover <service path>")
+	print("	 chars <service path>")
 	sys.exit(1)
=20
 if (args[0] =3D=3D "list"):
@@ -48,61 +50,61 @@ if (args[0] =3D=3D "list"):
 		device =3D dbus.Interface(bus.get_object("org.bluez", path),
 							"org.bluez.Device")
 		devprop =3D device.GetProperties()
-		print "[ %s ]" % devprop["Address"]
+		print("[ %s ]" % devprop["Address"])
 		for path in devprop["Services"]:
=20
 			service =3D dbus.Interface(bus.get_object("org.bluez", path),
 									 "org.bluez.Characteristic")
 			srvprop =3D service.GetProperties()
-			print " * %s" % (path)
-			print "	UUID: %s" % srvprop["UUID"]
-			print "	Chars: ",
+			print(" * %s" % (path))
+			print("	UUID: %s" % srvprop["UUID"])
+			print("	Chars: ",)
 			for char in srvprop["Characteristics"]:
-				print "%s " % char,
-			print
-			print
-		print
+				print("%s " % char,)
+			print()
+			print()
+		print()
 	sys.exit(0)
=20
 if (args[0] =3D=3D "services"):
 	if (len(args) < 2):
-		print "Need address parameter"
+		print("Need address parameter")
 	else:
 		path =3D adapter.FindDevice(args[1])
 		device =3D dbus.Interface(bus.get_object("org.bluez", path),
 							"org.bluez.Device")
 		properties =3D device.GetProperties()
 		for path in properties["Services"]:
-			print path
+			print(path)
 	sys.exit(0)
=20
 if (args[0] =3D=3D "discover"):
 	if (len(args) < 2):
-		print "Need service path parameter"
+		print("Need service path parameter")
 	else:
 		service =3D dbus.Interface(bus.get_object("org.bluez", args[1]),
 							"org.bluez.Characteristic")
 		for path in service.DiscoverCharacteristics():
-			print path
+			print(path)
 	sys.exit(0)
=20
 if (args[0] =3D=3D "chars"):
 	if (len(args) < 2):
-		print "Need service path parameter"
+		print("Need service path parameter")
 	else:
 		service =3D dbus.Interface(bus.get_object("org.bluez", args[1]),
 								 "org.bluez.Characteristic")
 		srvprop =3D service.GetProperties()
 		for path in srvprop["Characteristics"]:
-			print "[ %s ]" % (path)
+			print("[ %s ]" % (path))
 			char =3D dbus.Interface(bus.get_object("org.bluez", path),
 								 "org.bluez.Characteristic")
 			charprop =3D char.GetProperties()
-			print "	Name: %s" % charprop["Name"]
-			print "	UUID: %s" % charprop["UUID"]
-			print
-		print
+			print("	Name: %s" % charprop["Name"])
+			print("	UUID: %s" % charprop["UUID"])
+			print()
+		print()
 	sys.exit(0)
=20
-print "Unknown command"
+print("Unknown command")
 sys.exit(1)
diff --git a/test/test-audio b/test/test-audio
index 8b7a62d..1ba2042 100755
--- a/test/test-audio
+++ b/test/test-audio
@@ -1,5 +1,7 @@
 #!/usr/bin/python
=20
+from __future__ import absolute_import, print_function, unicode_literals
+
 import sys
 import dbus
 from optparse import OptionParser, make_option
@@ -25,11 +27,11 @@ adapter =3D dbus.Interface(bus.get_object("org.bluez", =
adapter_path),
 							"org.bluez.Adapter")
=20
 if len(args) < 2:
-	print """Usage: %s <command>
+	print("""Usage: %s <command>
=20
 	connect <bdaddr>
 	disconnect <bdaddr>
-	""" % sys.argv[0]
+	""" % sys.argv[0])
 	sys.exit(1)
=20
 device =3D adapter.FindDevice(args[1])
@@ -41,5 +43,5 @@ if args[0] =3D=3D "connect":
 elif args[0] =3D=3D "disconnect":
 	audio.Disconnect()
 else:
-	print "Unknown command"
+	print("Unknown command")
 	sys.exit(1)
diff --git a/test/test-device b/test/test-device
index 154af19..81a44f8 100755
--- a/test/test-device
+++ b/test/test-device
@@ -1,6 +1,8 @@
 #!/usr/bin/python
=20
-import gobject
+from __future__ import absolute_import, print_function, unicode_literals
+
+from gi.repository import GObject
=20
 import sys
 import dbus
@@ -10,7 +12,7 @@ from optparse import OptionParser, make_option
=20
 dbus.mainloop.glib.DBusGMainLoop(set_as_default=3DTrue)
 bus =3D dbus.SystemBus()
-mainloop =3D gobject.MainLoop()
+mainloop =3D GObject.MainLoop()
=20
 manager =3D dbus.Interface(bus.get_object("org.bluez", "/"), "org.bluez.Ma=
nager")
=20
@@ -31,19 +33,19 @@ adapter =3D dbus.Interface(bus.get_object("org.bluez", =
adapter_path),
 							"org.bluez.Adapter")
=20
 if (len(args) < 1):
-	print "Usage: %s <command>" % (sys.argv[0])
-	print ""
-	print "  list"
-	print "  services <address>"
-	print "  create <address>"
-	print "  remove <address|path>"
-	print "  disconnect <address>"
-	print "  discover <address> [pattern]"
-	print "  class <address>"
-	print "  name <address>"
-	print "  alias <address> [alias]"
-	print "  trusted <address> [yes/no]"
-	print "  blocked <address> [yes/no]"
+	print("Usage: %s <command>" % (sys.argv[0]))
+	print("")
+	print("  list")
+	print("  services <address>")
+	print("  create <address>")
+	print("  remove <address|path>")
+	print("  disconnect <address>")
+	print("  discover <address> [pattern]")
+	print("  class <address>")
+	print("  name <address>")
+	print("  alias <address> [alias]")
+	print("  trusted <address> [yes/no]")
+	print("  blocked <address> [yes/no]")
 	sys.exit(1)
=20
 if (args[0] =3D=3D "list"):
@@ -51,23 +53,23 @@ if (args[0] =3D=3D "list"):
 		device =3D dbus.Interface(bus.get_object("org.bluez", path),
 							"org.bluez.Device")
 		properties =3D device.GetProperties()
-		print "%s %s" % (properties["Address"], properties["Alias"])
+		print("%s %s" % (properties["Address"], properties["Alias"]))
=20
 	sys.exit(0)
=20
 def create_device_reply(device):
-	print "New device (%s)" % device
+	print("New device (%s)" % device)
 	mainloop.quit()
 	sys.exit(0)
=20
 def create_device_error(error):
-	print "Creating device failed: %s" % error
+	print("Creating device failed: %s" % error)
 	mainloop.quit()
 	sys.exit(1)
=20
 if (args[0] =3D=3D "create"):
 	if (len(args) < 2):
-		print "Need address parameter"
+		print("Need address parameter")
 	else:
 		adapter.CreateDevice(args[1],
 				reply_handler=3Dcreate_device_reply,
@@ -76,7 +78,7 @@ if (args[0] =3D=3D "create"):
=20
 if (args[0] =3D=3D "remove"):
 	if (len(args) < 2):
-		print "Need address or object path parameter"
+		print("Need address or object path parameter")
 	else:
 		try:
 			path =3D adapter.FindDevice(args[1])
@@ -87,7 +89,7 @@ if (args[0] =3D=3D "remove"):
=20
 if (args[0] =3D=3D "disconnect"):
 	if (len(args) < 2):
-		print "Need address parameter"
+		print("Need address parameter")
 	else:
 		path =3D adapter.FindDevice(args[1])
 		device =3D dbus.Interface(bus.get_object("org.bluez", path),
@@ -97,7 +99,7 @@ if (args[0] =3D=3D "disconnect"):
=20
 if (args[0] =3D=3D "discover"):
 	if (len(args) < 2):
-		print "Need address parameter"
+		print("Need address parameter")
 	else:
 		path =3D adapter.FindDevice(args[1])
 		device =3D dbus.Interface(bus.get_object("org.bluez", path),
@@ -110,57 +112,57 @@ if (args[0] =3D=3D "discover"):
 		for key in services.keys():
 			p =3D re.compile(">.*?<")
 			xml =3D p.sub("><", services[key].replace("\n", ""))
-			print "[ 0x%5x ]" % (key)
-			print xml
-			print
+			print("[ 0x%5x ]" % (key))
+			print(xml)
+			print()
 	sys.exit(0)
=20
 if (args[0] =3D=3D "class"):
 	if (len(args) < 2):
-		print "Need address parameter"
+		print("Need address parameter")
 	else:
 		path =3D adapter.FindDevice(args[1])
 		device =3D dbus.Interface(bus.get_object("org.bluez", path),
 							"org.bluez.Device")
 		properties =3D device.GetProperties()
-		print "0x%06x" % (properties["Class"])
+		print("0x%06x" % (properties["Class"]))
 	sys.exit(0)
=20
 if (args[0] =3D=3D "name"):
 	if (len(args) < 2):
-		print "Need address parameter"
+		print("Need address parameter")
 	else:
 		path =3D adapter.FindDevice(args[1])
 		device =3D dbus.Interface(bus.get_object("org.bluez", path),
 							"org.bluez.Device")
 		properties =3D device.GetProperties()
-		print properties["Name"]
+		print(properties["Name"])
 	sys.exit(0)
=20
 if (args[0] =3D=3D "alias"):
 	if (len(args) < 2):
-		print "Need address parameter"
+		print("Need address parameter")
 	else:
 		path =3D adapter.FindDevice(args[1])
 		device =3D dbus.Interface(bus.get_object("org.bluez", path),
 							"org.bluez.Device")
 		if (len(args) < 3):
 			properties =3D device.GetProperties()
-			print properties["Alias"]
+			print(properties["Alias"])
 		else:
 			device.SetProperty("Alias", args[2])
 	sys.exit(0)
=20
 if (args[0] =3D=3D "trusted"):
 	if (len(args) < 2):
-		print "Need address parameter"
+		print("Need address parameter")
 	else:
 		path =3D adapter.FindDevice(args[1])
 		device =3D dbus.Interface(bus.get_object("org.bluez", path),
 							"org.bluez.Device")
 		if (len(args) < 3):
 			properties =3D device.GetProperties()
-			print properties["Trusted"]
+			print(properties["Trusted"])
 		else:
 			if (args[2] =3D=3D "yes"):
 				value =3D dbus.Boolean(1)
@@ -173,14 +175,14 @@ if (args[0] =3D=3D "trusted"):
=20
 if (args[0] =3D=3D "blocked"):
 	if (len(args) < 2):
-		print "Need address parameter"
+		print("Need address parameter")
 	else:
 		path =3D adapter.FindDevice(args[1])
 		device =3D dbus.Interface(bus.get_object("org.bluez", path),
 							"org.bluez.Device")
 		if (len(args) < 3):
 			properties =3D device.GetProperties()
-			print properties["Blocked"]
+			print(properties["Blocked"])
 		else:
 			if (args[2] =3D=3D "yes"):
 				value =3D dbus.Boolean(1)
@@ -193,15 +195,15 @@ if (args[0] =3D=3D "blocked"):
=20
 if (args[0] =3D=3D "services"):
 	if (len(args) < 2):
-		print "Need address parameter"
+		print("Need address parameter")
 	else:
 		path =3D adapter.FindDevice(args[1])
 		device =3D dbus.Interface(bus.get_object("org.bluez", path),
 							"org.bluez.Device")
 		properties =3D device.GetProperties()
 		for path in properties["Services"]:
-			print path
+			print(path)
 	sys.exit(0)
=20
-print "Unknown command"
+print("Unknown command")
 sys.exit(1)
diff --git a/test/test-discovery b/test/test-discovery
index 20312f7..880d231 100755
--- a/test/test-discovery
+++ b/test/test-discovery
@@ -1,24 +1,26 @@
 #!/usr/bin/python
=20
-import gobject
-
+from __future__ import absolute_import, print_function, unicode_literals
+=20
+from gi.repository import GObject
+=20
 import dbus
 import dbus.mainloop.glib
 from optparse import OptionParser, make_option
=20
 def device_found(address, properties):
-	print "[ " + address + " ]"
+	print("[ " + address + " ]")
=20
 	for key in properties.keys():
 		value =3D properties[key]
 		if type(value) is dbus.String:
 			value =3D unicode(value).encode('ascii', 'replace')
 		if (key =3D=3D "Class"):
-			print "    %s =3D 0x%06x" % (key, value)
+			print("    %s =3D 0x%06x" % (key, value))
 		else:
-			print "    %s =3D %s" % (key, value)
+			print("    %s =3D %s" % (key, value))
=20
-	print
+	print()
=20
 def property_changed(name, value):
 	if (name =3D=3D "Discovering" and not value):
@@ -57,5 +59,5 @@ if __name__ =3D=3D '__main__':
=20
 	adapter.StartDiscovery()
=20
-	mainloop =3D gobject.MainLoop()
+	mainloop =3D GObject.MainLoop()
 	mainloop.run()
diff --git a/test/test-health b/test/test-health
index 16a5a2b..f7d4241 100755
--- a/test/test-health
+++ b/test/test-health
@@ -1,4 +1,6 @@
 #!/usr/bin/python
+
+from __future__ import absolute_import, print_function, unicode_literals
 # -*- coding: utf-8 -*-
=20
 import dbus
@@ -19,15 +21,15 @@ def sig_received(*args, **kwargs):
 		return;
 	sig_name =3D kwargs["member"]
 	path =3D kwargs["path"]
-	print sig_name
-	print path
+	print(sig_name)
+	print(path)
 	if sig_name =3D=3D "PropertyChanged":
 		k, v =3D args
-		print k
-		print v
+		print(k)
+		print(v)
 	else:
 		ob =3D args[0]
-		print ob
+		print(ob)
=20
=20
 def enter_mainloop():
@@ -38,21 +40,21 @@ def enter_mainloop():
 				interface_keyword=3D"interface")
=20
 	try:
-		print "Entering main lopp, push Ctrl+C for finish"
+		print("Entering main lopp, push Ctrl+C for finish")
=20
 		mainloop =3D gobject.MainLoop()
 		mainloop.run()
 	except KeyboardInterrupt:
 		pass
 	finally:
-		print "Exiting, bye"
+		print("Exiting, bye")
=20
 hdp_manager =3D dbus.Interface(bus.get_object("org.bluez", "/org/bluez"),
 						"org.bluez.HealthManager")
=20
 role =3D None
 while role =3D=3D None:
-	print "Select 1. source or 2. sink: ",
+	print("Select 1. source or 2. sink: ",)
 	try:
 		sel =3D int(sys.stdin.readline())
 		if sel =3D=3D 1:
@@ -62,20 +64,20 @@ while role =3D=3D None:
 		else:
 			raise ValueError
 	except (TypeError, ValueError):
-		print "Wrong selection, try again: ",
+		print("Wrong selection, try again: ",)
 	except KeyboardInterrupt:
 		sys.exit()
=20
 dtype =3D None
 while dtype =3D=3D None:
-	print "Select a data type: ",
+	print("Select a data type: ",)
 	try:
 		sel =3D int(sys.stdin.readline())
 		if (sel < 0) or (sel > 65535):
 			raise ValueError
 		dtype =3D sel;
 	except (TypeError, ValueError):
-		print "Wrong selection, try again: ",
+		print("Wrong selection, try again: ",)
 	except KeyboardInterrupt:
 		sys.exit()
=20
@@ -83,8 +85,8 @@ pref =3D None
 if role =3D=3D "Source":
 	while pref =3D=3D None:
 		try:
-			print "Select a preferred data channel type 1.",
-			print "reliable 2. streaming: ",
+			print("Select a preferred data channel type 1.",)
+			print("reliable 2. streaming: ",)
 			sel =3D int(sys.stdin.readline())
 			if sel =3D=3D 1:
 				pref =3D "Reliable"
@@ -94,7 +96,7 @@ if role =3D=3D "Source":
 				raise ValueError
=20
 		except (TypeError, ValueError):
-			print "Wrong selection, try again"
+			print("Wrong selection, try again")
 		except KeyboardInterrupt:
 			sys.exit()
=20
@@ -109,19 +111,19 @@ else:
 					"Description": "Test sink",
 					"Role": role})
=20
-print "New application created:", app_path
+print("New application created:", app_path)
=20
 con =3D None
 while con =3D=3D None:
 	try:
-		print "Connect to a remote device (y/n)? ",
+		print("Connect to a remote device (y/n)? ",)
 		sel =3D sys.stdin.readline()
 		if sel in ("y\n", "yes\n", "Y\n", "YES\n"):
 			con =3D True
 		elif sel in ("n\n", "no\n", "N\n", "NO\n"):
 			con =3D False
 		else:
-			print "Wrong selection, try again."
+			print("Wrong selection, try again.")
 	except KeyboardInterrupt:
 		sys.exit()
=20
@@ -136,10 +138,10 @@ adapters =3D manager.ListAdapters()
=20
 i =3D 1
 for ad in adapters:
-	print "%d. %s" % (i, ad)
+	print("%d. %s" % (i, ad))
 	i =3D i + 1
=20
-print "Select an adapter: ",
+print("Select an adapter: ",)
 select =3D None
 while select =3D=3D None:
 	try:
@@ -148,7 +150,7 @@ while select =3D=3D None:
 			raise TypeError
 		select =3D adapters[pos]
 	except (TypeError, IndexError, ValueError):
-		print "Wrong selection, try again: ",
+		print("Wrong selection, try again: ",)
 	except KeyboardInterrupt:
 		sys.exit()
=20
@@ -158,15 +160,15 @@ adapter =3D  dbus.Interface(bus.get_object("org.bluez=
", select),
 devices =3D adapter.ListDevices()
=20
 if len(devices) =3D=3D 0:
-	print "No devices available"
+	print("No devices available")
 	sys.exit()
=20
 i =3D 1
 for dev in devices:
-	print "%d. %s" % (i, dev)
+	print("%d. %s" % (i, dev))
 	i =3D i + 1
=20
-print "Select a device: ",
+print("Select a device: ",)
 select =3D None
 while select =3D=3D None:
 	try:
@@ -175,7 +177,7 @@ while select =3D=3D None:
 			raise TypeError
 		select =3D devices[pos]
 	except (TypeError, IndexError, ValueError):
-		print "Wrong selection, try again: ",
+		print("Wrong selection, try again: ",)
 	except KeyboardInterrupt:
 		sys.exit()
=20
@@ -185,32 +187,32 @@ device =3D dbus.Interface(bus.get_object("org.bluez",=
 select),
 echo =3D None
 while echo =3D=3D None:
 	try:
-		print "Perform an echo (y/n)? ",
+		print("Perform an echo (y/n)? ",)
 		sel =3D sys.stdin.readline()
 		if sel in ("y\n", "yes\n", "Y\n", "YES\n"):
 			echo =3D True
 		elif sel in ("n\n", "no\n", "N\n", "NO\n"):
 			echo =3D False
 		else:
-			print "Wrong selection, try again."
+			print("Wrong selection, try again.")
 	except KeyboardInterrupt:
 		sys.exit()
=20
 if echo:
 	if device.Echo():
-		print "Echo was ok"
+		print("Echo was ok")
 	else:
-		print "Echo war wrong, exiting"
+		print("Echo war wrong, exiting")
 		sys.exit()
=20
-print "Connecting to device %s" % (select)
+print("Connecting to device %s" % (select))
=20
 if role =3D=3D "Source":
 	chan =3D device.CreateChannel(app_path, "Reliable")
 else:
 	chan =3D device.CreateChannel(app_path, "Any")
=20
-print chan
+print(chan)
=20
 enter_mainloop()
=20
diff --git a/test/test-health-sink b/test/test-health-sink
index cb9d434..ce7337a 100755
--- a/test/test-health-sink
+++ b/test/test-health-sink
@@ -1,4 +1,6 @@
 #!/usr/bin/python
+
+from __future__ import absolute_import, print_function, unicode_literals
 # -*- coding: utf-8 -*-
=20
 import dbus
@@ -17,7 +19,7 @@ hdp_manager =3D dbus.Interface(bus.get_object("org.bluez"=
, "/org/bluez"),
 app_path =3D hdp_manager.CreateApplication({"DataType": dbus.types.UInt16(=
4103),
 					"Role": "sink"})
=20
-print app_path
+print(app_path)
=20
 manager =3D dbus.Interface(bus.get_object("org.bluez", "/"),
 						"org.bluez.Manager")
@@ -26,10 +28,10 @@ adapters =3D manager.ListAdapters()
=20
 i =3D 1
 for ad in adapters:
-	print "%d. %s" % (i, ad)
+	print("%d. %s" % (i, ad))
 	i =3D i + 1
=20
-print "Select an adapter: ",
+print("Select an adapter: ",)
 select =3D None
 while select =3D=3D None:
 	try:
@@ -38,7 +40,7 @@ while select =3D=3D None:
 			raise TypeError
 		select =3D adapters[pos]
 	except (TypeError, IndexError, ValueError):
-		print "Wrong selection, try again: ",
+		print("Wrong selection, try again: ",)
 	except KeyboardInterrupt:
 		sys.exit()
=20
@@ -48,15 +50,15 @@ adapter =3D  dbus.Interface(bus.get_object("org.bluez",=
 select),
 devices =3D adapter.ListDevices()
=20
 if len(devices) =3D=3D 0:
-	print "No devices available"
+	print("No devices available")
 	sys.exit()
=20
 i =3D 1
 for dev in devices:
-	print "%d. %s" % (i, dev)
+	print("%d. %s" % (i, dev))
 	i =3D i + 1
=20
-print "Select a device: ",
+print("Select a device: ",)
 select =3D None
 while select =3D=3D None:
 	try:
@@ -65,19 +67,19 @@ while select =3D=3D None:
 			raise TypeError
 		select =3D devices[pos]
 	except (TypeError, IndexError, ValueError):
-		print "Wrong selection, try again: ",
+		print("Wrong selection, try again: ",)
 	except KeyboardInterrupt:
 		sys.exit()
=20
-print "Connecting to %s" % (select)
+print("Connecting to %s" % (select))
 device =3D dbus.Interface(bus.get_object("org.bluez", select),
 					"org.bluez.HealthDevice")
=20
 chan =3D device.CreateChannel(app_path, "Any")
=20
-print chan
+print(chan)
=20
-print "Push Enter for finishing"
+print("Push Enter for finishing")
 sys.stdin.readline()
=20
 hdp_manager.DestroyApplication(app_path)
diff --git a/test/test-input b/test/test-input
index 405bb59..110cbef 100755
--- a/test/test-input
+++ b/test/test-input
@@ -1,5 +1,7 @@
 #!/usr/bin/python
=20
+from __future__ import absolute_import, print_function, unicode_literals
+
 import sys
 import dbus
 from optparse import OptionParser, make_option
@@ -25,11 +27,11 @@ adapter =3D dbus.Interface(bus.get_object("org.bluez", =
adapter_path),
 							"org.bluez.Adapter")
=20
 if len(args) < 2:
-	print """Usage: %s <command>
+	print("""Usage: %s <command>
=20
 	connect <bdaddr>
 	disconnect <bdaddr>
-	""" % sys.argv[0]
+	""" % sys.argv[0])
 	sys.exit(1)
=20
 device =3D adapter.FindDevice(args[1])
@@ -41,5 +43,5 @@ if args[0] =3D=3D "connect":
 elif args[0] =3D=3D "disconnect":
 	input.Disconnect()
 else:
-	print "Unknown command"
+	print("Unknown command")
 	sys.exit(1)
diff --git a/test/test-manager b/test/test-manager
index c6cf560..8a7e2f6 100755
--- a/test/test-manager
+++ b/test/test-manager
@@ -1,18 +1,20 @@
 #!/usr/bin/python
=20
-import gobject
+from __future__ import absolute_import, print_function, unicode_literals
+
+from gi.repository import GObject
=20
 import dbus
 import dbus.mainloop.glib
=20
 def adapter_added(path):
-	print "Adapter with path %s added" % (path)
+	print("Adapter with path %s added" % (path))
=20
 def adapter_removed(path):
-	print "Adapter with path %s removed" % (path)
+	print("Adapter with path %s removed" % (path))
=20
 def default_changed(path):
-	print "Default adapter is now at path %s" % (path)
+	print("Default adapter is now at path %s" % (path))
=20
 if __name__ =3D=3D "__main__":
 	dbus.mainloop.glib.DBusGMainLoop(set_as_default=3DTrue)
@@ -34,5 +36,5 @@ if __name__ =3D=3D "__main__":
 	except:
 		pass
=20
-	mainloop =3D gobject.MainLoop()
+	mainloop =3D GObject.MainLoop()
 	mainloop.run()
diff --git a/test/test-nap b/test/test-nap
index c83d928..dc779ad 100755
--- a/test/test-nap
+++ b/test/test-nap
@@ -1,5 +1,7 @@
 #!/usr/bin/python
=20
+from __future__ import absolute_import, print_function, unicode_literals
+
 import sys
 import time
 import dbus
@@ -35,13 +37,13 @@ else:
=20
 server.Register(service, bridge)
=20
-print "Server for %s registered for %s" % (service, bridge)
+print("Server for %s registered for %s" % (service, bridge))
=20
-print "Press CTRL-C to disconnect"
+print("Press CTRL-C to disconnect")
=20
 try:
 	time.sleep(1000)
-	print "Terminating connection"
+	print("Terminating connection")
 except:
 	pass
=20
diff --git a/test/test-network b/test/test-network
index 676fb30..2ade584 100755
--- a/test/test-network
+++ b/test/test-network
@@ -1,5 +1,7 @@
 #!/usr/bin/python
=20
+from __future__ import absolute_import, print_function, unicode_literals
+
 import sys
 import time
 import dbus
@@ -27,7 +29,7 @@ adapter =3D dbus.Interface(bus.get_object("org.bluez", ad=
apter_path),
 							"org.bluez.Adapter")
=20
 if (len(args) < 1):
-	print "Usage: %s <address> [service]" % (sys.argv[0])
+	print("Usage: %s <address> [service]" % (sys.argv[0]))
 	sys.exit(1)
=20
 address =3D args[0]
@@ -44,13 +46,13 @@ network =3D dbus.Interface(bus.get_object("org.bluez", =
device),
=20
 iface =3D network.Connect(service)
=20
-print "Connected %s to %s" % (device, address)
+print("Connected %s to %s" % (device, address))
=20
-print "Press CTRL-C to disconnect"
+print("Press CTRL-C to disconnect")
=20
 try:
 	time.sleep(1000)
-	print "Terminating connection"
+	print("Terminating connection")
 except:
 	pass
=20
diff --git a/test/test-oob b/test/test-oob
index 3340c00..bec9de5 100755
--- a/test/test-oob
+++ b/test/test-oob
@@ -1,15 +1,17 @@
 #!/usr/bin/python
=20
+from __future__ import absolute_import, print_function, unicode_literals
+
 import gobject
=20
 import dbus.mainloop.glib
=20
 def create_device_reply(device):
-	print "Pairing succeed!"
+	print("Pairing succeed!")
 	mainloop.quit()
=20
 def create_device_error(error):
-	print "Pairing failed."
+	print("Pairing failed.")
 	mainloop.quit()
=20
 if __name__ =3D=3D '__main__':
@@ -31,12 +33,12 @@ if __name__ =3D=3D '__main__':
=20
 	adapter0_address =3D adapter0.GetProperties()["Address"]
 	adapter1_address =3D adapter1.GetProperties()["Address"]
-	print "Adapters:"
-	print "    hci0: " + adapter0_address
-	print "    hci1: " + adapter1_address
-	print
+	print("Adapters:")
+	print("    hci0: " + adapter0_address)
+	print("    hci1: " + adapter1_address)
+	print()
=20
-	print "Removing any existing bond..."
+	print("Removing any existing bond...")
=20
 	try:
 		device =3D adapter0.FindDevice(adapter1_address)
@@ -50,9 +52,9 @@ if __name__ =3D=3D '__main__':
 	except:
 		pass
=20
-	print "Done."
-	print
-	print "Reading local Out of Band data..."
+	print("Done.")
+	print()
+	print("Reading local Out of Band data...")
=20
 	oob_adapter0 =3D dbus.Interface(bus.get_object("org.bluez",
 					adapter0_path), "org.bluez.OutOfBand")
@@ -62,16 +64,16 @@ if __name__ =3D=3D '__main__':
 	oob0 =3D oob_adapter0.ReadLocalData()
 	oob1 =3D oob_adapter1.ReadLocalData()
=20
-	print "Done."
-	print
-	print "Exchanging Out of Band data..."
+	print("Done.")
+	print()
+	print("Exchanging Out of Band data...")
=20
 	oob_adapter0.AddRemoteData(adapter1_address, oob1[0], oob1[1])
 	oob_adapter1.AddRemoteData(adapter0_address, oob0[0], oob0[1])
=20
-	print "Done."
-	print
-	print "Starting to pair."
+	print("Done.")
+	print()
+	print("Starting to pair.")
 	adapter1.CreatePairedDevice(adapter0_address, "/test/agent_oob",
 					"DisplayYesNo",
 					reply_handler=3Dcreate_device_reply,
diff --git a/test/test-proximity b/test/test-proximity
index 130590c..b08a62a 100755
--- a/test/test-proximity
+++ b/test/test-proximity
@@ -1,5 +1,7 @@
 #!/usr/bin/python
=20
+from __future__ import absolute_import, print_function, unicode_literals
+
 '''
 Proximity Monitor test script
 '''
@@ -13,7 +15,7 @@ from optparse import OptionParser, make_option
=20
 def property_changed(name, value):
=20
-	print "PropertyChanged('%s', '%s')" % (name, value)
+	print("PropertyChanged('%s', '%s')" % (name, value))
 	mainloop.quit()
=20
 if __name__ =3D=3D "__main__":
@@ -44,10 +46,10 @@ if __name__ =3D=3D "__main__":
 							"org.bluez.Adapter")
=20
 	if (len(args) < 1):
-		print "Usage: %s <command>" % (sys.argv[0])
-		print ""
-		print "  -b MAC LinkLossAlertLevel <none|mild|high>"
-		print "  -b MAC ImmediateAlertLevel <none|mild|high>"
+		print("Usage: %s <command>" % (sys.argv[0]))
+		print("")
+		print("  -b MAC LinkLossAlertLevel <none|mild|high>")
+		print("  -b MAC ImmediateAlertLevel <none|mild|high>")
 		sys.exit(1)
=20
 	device_path =3D adapter.FindDevice(options.address)
@@ -59,7 +61,7 @@ if __name__ =3D=3D "__main__":
 	proximity =3D dbus.Interface(bus.get_object("org.bluez",
 					device_path), "org.bluez.ProximityMonitor")
=20
-	print "Proximity SetProperty('%s', '%s')" % (args[0], args[1])
+	print("Proximity SetProperty('%s', '%s')" % (args[0], args[1]))
 	proximity.SetProperty(args[0], args[1])
=20
 	mainloop =3D gobject.MainLoop()
diff --git a/test/test-sap-server b/test/test-sap-server
index bea6ca9..df838f6 100755
--- a/test/test-sap-server
+++ b/test/test-sap-server
@@ -1,11 +1,13 @@
 #!/usr/bin/python
=20
+from __future__ import absolute_import, print_function, unicode_literals
+
 from sap import *
 import time
=20
 def connect_disconnect_by_client(sap):
=20
-    print "[Test] Connect - Disconnect by client \n"
+    print("[Test] Connect - Disconnect by client \n")
=20
     try:
         if not sap.isConnected():
@@ -13,19 +15,19 @@ def connect_disconnect_by_client(sap):
=20
         if sap.proc_connect():
             if sap.proc_disconnectByClient():
-                print "OK"
+                print("OK")
                 return 0
=20
-        print "NOT OK"
+        print("NOT OK")
         return 1
=20
-    except BluetoothError , e:
-        print "Error " + str(e)
+    except BluetoothError as e:
+        print("Error " + str(e))
=20
=20
 def connect_disconnect_by_server_gracefully(sap, timeout=3D0):
=20
-    print "[Test] Connect - Disconnect by server with timer \n"
+    print("[Test] Connect - Disconnect by server with timer \n")
=20
     try:
         if not sap.isConnected():
@@ -33,19 +35,19 @@ def connect_disconnect_by_server_gracefully(sap, timeou=
t=3D0):
=20
         if sap.proc_connect():
             if sap.proc_disconnectByServer(timeout):
-                print "OK"
+                print("OK")
                 return 0
=20
-        print "NOT OK"
+        print("NOT OK")
         return 1
=20
-    except BluetoothError , e:
-        print "Error " + str(e)
+    except BluetoothError as e:
+        print("Error " + str(e))
=20
=20
 def connect_txAPDU_disconnect_by_client(sap):
=20
-    print "[Test] Connect - TX APDU - Disconnect by client \n"
+    print("[Test] Connect - TX APDU - Disconnect by client \n")
=20
     try:
         if not sap.isConnected():
@@ -53,44 +55,44 @@ def connect_txAPDU_disconnect_by_client(sap):
=20
         if sap.proc_connect():
             if not sap.proc_transferAPDU():
-                print "NOT OK 1"
+                print("NOT OK 1")
                 return 1
=20
             if not sap.proc_transferAPDU():
-                print "NOT OK 2"
+                print("NOT OK 2")
                 return 1
=20
             if not sap.proc_transferAPDU():
-                print "NOT OK 3"
+                print("NOT OK 3")
                 return 1
=20
             if not sap.proc_transferAPDU():
-                print "NOT OK 4"
+                print("NOT OK 4")
                 return 1
=20
             if sap.proc_disconnectByClient():
-                print "OK"
+                print("OK")
                 return 0
=20
-        print "NOT OK"
+        print("NOT OK")
         return 1
=20
-    except BluetoothError , e:
-        print "Error " + str(e)
+    except BluetoothError as e:
+        print("Error " + str(e))
=20
 def connect_rfcomm_only_and_wait_for_close_by_server(sap):
=20
-    print "[Test] Connect rfcomm only  - Disconnect by server timeout \n"
+    print("[Test] Connect rfcomm only  - Disconnect by server timeout \n")
=20
     if not sap.isConnected():
        sap.connect()
=20
     time.sleep(40)
-    print "OK"
+    print("OK")
=20
 def power_sim_off_on(sap):
=20
-    print "[Test] Powe sim off \n"
+    print("[Test] Powe sim off \n")
=20
     try:
         if not sap.isConnected():
@@ -98,26 +100,26 @@ def power_sim_off_on(sap):
=20
         if sap.proc_connect():
             if not sap.proc_resetSim():
-                print "NOT OK"
+                print("NOT OK")
                 return 1
=20
             if not sap.proc_powerSimOff():
-                print "NOT OK"
+                print("NOT OK")
                 return 1
=20
             if not sap.proc_powerSimOn():
-                print "NOT OK"
+                print("NOT OK")
                 return 1
=20
             if sap.proc_disconnectByClient():
-                print "OK"
+                print("OK")
                 return 0
=20
-        print "NOT OK"
+        print("NOT OK")
         return 1
=20
-    except BluetoothError , e:
-        print "Error " + str(e)
+    except BluetoothError as e:
+        print("Error " + str(e))
=20
=20
 if __name__ =3D=3D "__main__":
@@ -127,8 +129,8 @@ if __name__ =3D=3D "__main__":
=20
     try:
         s =3D SAPClient(host, port)
-    except BluetoothError , e:
-        print "Error " + str(e)
+    except BluetoothError as e:
+        print("Error " + str(e))
=20
     connect_disconnect_by_client(s)
     connect_disconnect_by_server_gracefully(s)
diff --git a/test/test-serial b/test/test-serial
index cc496df..8858dbd 100755
--- a/test/test-serial
+++ b/test/test-serial
@@ -1,5 +1,7 @@
 #!/usr/bin/python
=20
+from __future__ import absolute_import, print_function, unicode_literals
+
 import sys
 import time
 import dbus
@@ -26,7 +28,7 @@ adapter =3D dbus.Interface(bus.get_object("org.bluez", ad=
apter_path),
 							"org.bluez.Adapter")
=20
 if (len(args) < 1):
-	print "Usage: %s <address> [service]" % (sys.argv[0])
+	print("Usage: %s <address> [service]" % (sys.argv[0]))
 	sys.exit(1)
=20
 address =3D args[0]
@@ -43,13 +45,13 @@ serial =3D dbus.Interface(bus.get_object("org.bluez", p=
ath),
=20
 node =3D serial.Connect(service)
=20
-print "Connected %s to %s" % (node, address)
+print("Connected %s to %s" % (node, address))
=20
-print "Press CTRL-C to disconnect"
+print("Press CTRL-C to disconnect")
=20
 try:
 	time.sleep(1000)
-	print "Terminating connection"
+	print("Terminating connection")
 except:
 	pass
=20
diff --git a/test/test-serial-proxy b/test/test-serial-proxy
index f6dbd6c..7963f23 100755
--- a/test/test-serial-proxy
+++ b/test/test-serial-proxy
@@ -1,5 +1,7 @@
 #!/usr/bin/python
=20
+from __future__ import absolute_import, print_function, unicode_literals
+
 import sys
 import time
 import dbus
@@ -27,7 +29,7 @@ adapter =3D dbus.Interface(bus.get_object("org.bluez", ad=
apter_path),
 							"org.bluez.Adapter")
=20
 if (len(args) < 1):
-	print "Usage: %s <socket_name> [service]" % (sys.argv[0])
+	print("Usage: %s <socket_name> [service]" % (sys.argv[0]))
 	sys.exit(1)
=20
 socket_name =3D args[0]
@@ -51,7 +53,7 @@ proxy.Enable()
=20
 conn, addr =3D sk.accept()
=20
-print "Waiting for message"
+print("Waiting for message")
=20
 while 1:
 	data =3D conn.recv(1024)
diff --git a/test/test-service b/test/test-service
index 8958201..8eea9e2 100755
--- a/test/test-service
+++ b/test/test-service
@@ -1,5 +1,7 @@
 #!/usr/bin/python
=20
+from __future__ import absolute_import, print_function, unicode_literals
+
 import sys
 import dbus
 import time
@@ -26,22 +28,22 @@ service =3D dbus.Interface(bus.get_object("org.bluez", =
adapter_path),
 						"org.bluez.Service")
=20
 if (len(args) < 1):
-	print "Usage: %s <command>" % (sys.argv[0])
-	print ""
-	print "  addrecord <file>"
+	print("Usage: %s <command>" % (sys.argv[0]))
+	print("")
+	print("  addrecord <file>")
 	sys.exit(1)
=20
 if (args[0] =3D=3D "addrecord"):
 	if (len(args) < 2):
-		print "Need file parameter"
+		print("Need file parameter")
 	else:
 		f =3D open(args[1])
 		record =3D f.read()
 		f.close()
 		handle =3D service.AddRecord(record)
-		print "0x%x" % (handle)
+		print("0x%x" % (handle))
 		time.sleep(120)
 	sys.exit(0)
=20
-print "Unknown command"
+print("Unknown command")
 sys.exit(1)
diff --git a/test/test-telephony b/test/test-telephony
index 5ef0ac8..bd7d3b2 100755
--- a/test/test-telephony
+++ b/test/test-telephony
@@ -1,5 +1,7 @@
 #!/usr/bin/python
=20
+from __future__ import absolute_import, print_function, unicode_literals
+
 import sys
 import dbus
 from optparse import OptionParser, make_option
@@ -28,7 +30,7 @@ test =3D dbus.Interface(bus.get_object("org.bluez", "/org=
/bluez/test"),
 			"org.bluez.TelephonyTest")
=20
 if len(args) < 1:
-	print """Usage: %s <command>
+	print("""Usage: %s <command>
=20
 	connect <bdaddr>
 	disconnect <bdaddr>
@@ -44,12 +46,12 @@ if len(args) < 1:
 	microphonegain <bdaddr> [level]
 	play <bdaddr>
 	stop <bdaddr>
-	""" % sys.argv[0]
+	""" % sys.argv[0])
 	sys.exit(1)
=20
 if args[0] =3D=3D "connect":
 	if len(args) < 2:
-		print "Need device address parameter"
+		print("Need device address parameter")
 		sys.exit(1)
 	device =3D adapter.FindDevice(args[1])
 	headset =3D dbus.Interface(bus.get_object("org.bluez", device),
@@ -59,7 +61,7 @@ if args[0] =3D=3D "connect":
=20
 if args[0] =3D=3D "disconnect":
 	if len(args) < 2:
-		print "Need device address parameter"
+		print("Need device address parameter")
 		sys.exit(1)
 	device =3D adapter.FindDevice(args[1])
 	headset =3D dbus.Interface(bus.get_object("org.bluez", device),
@@ -69,7 +71,7 @@ if args[0] =3D=3D "disconnect":
=20
 if args[0] =3D=3D "speakergain":
 	if len(args) < 2:
-		print "Need device address parameter"
+		print("Need device address parameter")
 		sys.exit(1)
 	device =3D adapter.FindDevice(args[1])
 	headset =3D dbus.Interface(bus.get_object("org.bluez", device),
@@ -78,13 +80,13 @@ if args[0] =3D=3D "speakergain":
 		headset.SetProperty('SpeakerGain', dbus.UInt16(args[2]))
 	else:
 		props =3D headset.GetProperties()
-		print props['SpeakerGain']
+		print(props['SpeakerGain'])
=20
 	sys.exit(0)
=20
 if args[0] =3D=3D "microphonegain":
 	if len(args) < 2:
-		print "Need device address parameter"
+		print("Need device address parameter")
 		sys.exit(1)
 	device =3D adapter.FindDevice(args[1])
 	headset =3D dbus.Interface(bus.get_object("org.bluez", device),
@@ -93,13 +95,13 @@ if args[0] =3D=3D "microphonegain":
 		headset.SetProperty('MicrophoneGain', dbus.UInt16(args[2]))
 	else:
 		props =3D headset.GetProperties()
-		print props['MicrophoneGain']
+		print(props['MicrophoneGain'])
=20
 	sys.exit(0)
=20
 if args[0] =3D=3D "play":
 	if len(args) < 2:
-		print "Need device address parameter"
+		print("Need device address parameter")
 		sys.exit(1)
 	device =3D adapter.FindDevice(args[1])
 	headset =3D dbus.Interface(bus.get_object("org.bluez", device),
@@ -110,7 +112,7 @@ if args[0] =3D=3D "play":
=20
 if args[0] =3D=3D "stop":
 	if len(args) < 2:
-		print "Need device address parameter"
+		print("Need device address parameter")
 		sys.exit(1)
 	device =3D adapter.FindDevice(args[1])
 	headset =3D dbus.Interface(bus.get_object("org.bluez", device),
@@ -123,14 +125,14 @@ if args[0] =3D=3D "outgoing":
 	if len(args) > 1:
 		test.OutgoingCall(args[1])
 	else:
-		print "Need number parameter"
+		print("Need number parameter")
 	sys.exit(0)
=20
 if args[0] =3D=3D "incoming":
 	if len(args) > 1:
 		test.IncomingCall(args[1])
 	else:
-		print "Need number parameter"
+		print("Need number parameter")
 	sys.exit(0)
=20
 if args[0] =3D=3D "cancel":
@@ -141,36 +143,36 @@ if args[0] =3D=3D "signal":
 	if len(args) > 1:
 		test.SignalStrength(args[1])
 	else:
-		print "Need signal strength parameter"
+		print("Need signal strength parameter")
 	sys.exit(0)
=20
 if args[0] =3D=3D "battery":
 	if len(args) > 1:
 		test.BatteryLevel(args[1])
 	else:
-		print "Need battery level parameter"
+		print("Need battery level parameter")
 	sys.exit(0)
=20
 if args[0] =3D=3D "roaming":
 	if len(args) > 1:
 		test.RoamingStatus(args[1] =3D=3D "yes" or False)
 	else:
-		print "Need yes/no parameter"
+		print("Need yes/no parameter")
 	sys.exit(0)
=20
 if args[0] =3D=3D "registration":
 	if len(args) > 1:
 		test.RegistrationStatus(args[1] =3D=3D "yes" or False)
 	else:
-		print "Need yes/no parameter"
+		print("Need yes/no parameter")
 	sys.exit(0)
=20
 if args[0] =3D=3D "subscriber":
 	if len(args) > 1:
 		test.SetSubscriberNumber(args[1])
 	else:
-		print "Need number parameter"
+		print("Need number parameter")
 	sys.exit(0)
=20
-print "Unknown command"
+print("Unknown command")
 sys.exit(1)
diff --git a/test/test-thermometer b/test/test-thermometer
index bf3b83e..9216264 100755
--- a/test/test-thermometer
+++ b/test/test-thermometer
@@ -1,5 +1,7 @@
 #!/usr/bin/python
=20
+from __future__ import absolute_import, print_function, unicode_literals
+
 '''
 Thermometer test script
 '''
@@ -16,20 +18,20 @@ class Watcher(dbus.service.Object):
 	@dbus.service.method("org.bluez.ThermometerWatcher",
 					in_signature=3D"a{sv}", out_signature=3D"")
 	def MeasurementReceived(self, measure):
-		print measure["Measurement"], " measurement received"
-		print "Exponent: ", measure["Exponent"]
-		print "Mantissa: ", measure["Mantissa"]
-		print "Unit: ", measure["Unit"]
+		print(measure["Measurement"], " measurement received")
+		print("Exponent: ", measure["Exponent"])
+		print("Mantissa: ", measure["Mantissa"])
+		print("Unit: ", measure["Unit"])
=20
-		if measure.has_key("Time"):
-			print "Time: ", measure["Time"]
+		if "Time" in measure:
+			print("Time: ", measure["Time"])
=20
-		if measure.has_key("Type"):
-			print "Type: ", measure["Type"]
+		if "Type" in measure:
+			print("Type: ", measure["Type"])
=20
 def property_changed(name, value):
=20
-	print "PropertyChanged('%s', '%s')" % (name, value)
+	print("PropertyChanged('%s', '%s')" % (name, value))
=20
 if __name__ =3D=3D "__main__":
 	dbus.mainloop.glib.DBusGMainLoop(set_as_default=3DTrue)
@@ -51,9 +53,9 @@ if __name__ =3D=3D "__main__":
 	(options, args) =3D parser.parse_args()
=20
 	if not options.address:
-		print "Usage: %s [-i <adapter>] -b <bdaddr> [command]" % (sys.argv[0])
-		print "Possible commands:"
-		print "\tEnableIntermediateMeasurement"
+		print("Usage: %s [-i <adapter>] -b <bdaddr> [command]" % (sys.argv[0]))
+		print("Possible commands:")
+		print("\tEnableIntermediateMeasurement")
 		sys.exit(1)
=20
 	if options.adapter:
@@ -82,7 +84,7 @@ if __name__ =3D=3D "__main__":
 		if args[0] =3D=3D "EnableIntermediateMeasurement":
 			thermometer.EnableIntermediateMeasurement(path)
 		else:
-			print "unknown command"
+			print("unknown command")
 			sys.exit(1)
=20
 	mainloop =3D gobject.MainLoop()
--=20
1.7.9.5

--=20
Steve Langasek                   Give me a lever long enough and a Free OS
Debian Developer                   to set it on, and I can move the world.
Ubuntu Developer                                    http://www.debian.org/
slangasek@ubuntu.com                                     vorlon@debian.org

--+QahgC5+KEYLbs62
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBCAAGBQJPvxw3AAoJEFaNMPMhshM9V7oQAK9fHquoXJi6XCnFA5cippjA
WzMWoh0W4UPuh4laaR0g9bkRxM9dIXis5SfxzqgyfIlXXx+gbEzUmH3s02JXBXFF
aOZPcXLzmnWBOz3d2Yv2XJuRpqOWNbWKauq3Vyymu1P2wtF3aQPR5Pfx5rkxU1P/
0YNOL5BlQabRnQqYbpEJw3Hp8yCiiypxjnjOWerhQn32fZyq9nqQp3wYrvcRyamh
HIwC9CXfudyykksqaon6x5/PZm4KiInar1mkyw84J5v0j77HYkyfZzF/qdrPu5+5
F2X6pmdhdtjBJevi1tkjOYEjSfJfARGmRpezodgERwVs+ga1T8aROHoc5fiIHTVo
T9EknAtjNdkTV+9cC4i6FHakQRUwKDUZ1pcGlunMDNJWm7b0GQx7v/9CS8eALcYC
62P8sEbQM7Tm/wQY3zieYdWl4Ggk2UUIOrd8o6KJrsb+Pce4Ri5jbQdsii7CC4Tq
Y+FOqzr8kYOjx26yL1tXtwcDZlvQ3XTyReEizfdNuLzZTY/IJwCulnnydxpjj7UE
60Qub+CII8xJCfrT8cOn62+wKUJNNe3vvQi5G/nX+XsDZZlglS2PRnHZRvgs/5fv
KPVYhkahe2G9K8ZKNHbzf9XmNmhgnxUzJ6q0rH7TbbB2YPpvVtXfXqU5h8bf0uW1
R6E6bhYv+xg3V6Wy5xTt
=27Ey
-----END PGP SIGNATURE-----

--+QahgC5+KEYLbs62--
