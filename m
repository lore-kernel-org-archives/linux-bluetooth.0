Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [RFC BlueZ v0 13/13] test: Add --uuid to test-service
Date: Mon,  6 May 2013 10:43:30 +0200
Message-Id: <1367829810-8262-14-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1367829810-8262-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1367829810-8262-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

Extend the test script with an optional filter to let the user operate
on services matching a given UUID.
---
 test/test-service | 34 ++++++++++++++++++++++++++--------
 1 file changed, 26 insertions(+), 8 deletions(-)

diff --git a/test/test-service b/test/test-service
index 7143891..2342d50 100755
--- a/test/test-service
+++ b/test/test-service
@@ -22,6 +22,8 @@ mainloop = GObject.MainLoop()
 option_list = [
 		make_option("-i", "--adapter", action="store",
 				type="string", dest="adap_id"),
+		make_option("-u", "--uuid", action="store",
+				type="string", dest="uuid"),
 		]
 
 description="Test script to operate on org.bluez.Service1 interfaces"
@@ -29,8 +31,8 @@ usage = "usage: %prog [options] <command> [<args>]"
 epilog="""
 Commands:
 	list [<address>]
-	connect <address> <service-path-suffix>
-	disconnect <address> <service-path-suffix>
+	connect [<address> [<service-path-suffix>]]
+	disconnect [<address> [<service-path-suffix>]]
 
 """
 
@@ -47,6 +49,10 @@ if len(args) < 1:
 	parser.print_help()
 	sys.exit(1)
 
+uuid = None
+if options.uuid:
+	uuid = bluezutils.parse_uuid(options.uuid)
+
 if args[0] == "list":
 	if len(args) > 2:
 		parser.print_help()
@@ -83,6 +89,10 @@ if args[0] == "list":
 
 			if properties["Device"] != path:
 				continue
+			elif uuid:
+				if properties["UUID"] != uuid:
+					continue
+				del(properties["UUID"])
 
 			print("    [ " + service_path + " ]")
 
@@ -102,23 +112,31 @@ if args[0] == "list":
 	sys.exit(0)
 
 def service_do(func):
-	if len(args) < 3:
-		parser.print_help()
+	if len(args) < 3 and not(uuid):
+		print("ERROR: Either service suffix or UUID must be specified")
 		sys.exit(1)
 
 	objects = bluezutils.get_managed_objects()
 	adapter = bluezutils.find_adapter_in_objects(objects, options.adap_id)
-	device = bluezutils.find_device_in_objects(objects, args[1],
+
+	device = None
+	if len(args) >= 2:
+		device = bluezutils.find_device_in_objects(objects, args[1],
 								options.adap_id)
-	path_suffix = args[2]
+	path_suffix = None
+	if len(args) >= 3:
+		path_suffix = args[2]
+
 	found = False
 	for path, ifaces in objects.iteritems():
 		service = ifaces.get(SERVICE_INTERFACE)
 		if service is None:
 			continue
-		if device.object_path != service["Device"]:
+		if device and device.object_path != service["Device"]:
+			continue
+		if uuid and uuid != service["UUID"]:
 			continue
-		if not(path.endswith(path_suffix)):
+		if path_suffix and not(path.endswith(path_suffix)):
 			continue
 		try:
 			found = True
-- 
1.8.1.4

