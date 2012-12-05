Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH v3 08/15] test: Use ObjectManager instead of Devices property
Date: Wed,  5 Dec 2012 13:51:35 +0100
Message-Id: <1354711902-16390-9-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1354711902-16390-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1354711902-16390-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

Use the objects and interfaces reported by the ObjectManager in order
to list the available devices per adapter.
---
 test/list-devices | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/test/list-devices b/test/list-devices
index fcff3e7..e8f3f24 100755
--- a/test/list-devices
+++ b/test/list-devices
@@ -30,6 +30,10 @@ def extract_uuids(uuid_list):
 	return list
 
 objects = manager.GetManagedObjects()
+
+all_devices = (str(path) for path, interfaces in objects.iteritems() if
+					"org.bluez.Device" in interfaces.keys())
+
 for path, interfaces in objects.iteritems():
 	if "org.bluez.Adapter" not in interfaces.keys():
 		continue
@@ -39,19 +43,13 @@ for path, interfaces in objects.iteritems():
 	properties = interfaces["org.bluez.Adapter"]
 	for key in properties.keys():
 		value = properties[key]
-		if (key == "Devices"):
-			list = extract_objects(value)
-			print("    %s = %s" % (key, list))
-		elif (key == "UUIDs"):
+		if (key == "UUIDs"):
 			list = extract_uuids(value)
 			print("    %s = %s" % (key, list))
 		else:
 			print("    %s = %s" % (key, value))
 
-	try:
-		device_list = properties["Devices"]
-	except:
-		device_list = []
+	device_list = [d for d in all_devices if d.startswith(path + "/")]
 
 	for dev_path in device_list:
 		print("    [ " + dev_path + " ]")
-- 
1.7.11.7

