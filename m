Return-Path: <cyrus@holtmann.org>
From: Gustavo Padovan <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Cc: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Subject: [PATCH] Remove documentation about Node API
Date: Wed, 18 Jul 2012 16:36:35 -0300
Message-Id: <1342640195-13087-1-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Gustavo Padovan <gustavo.padovan@collabora.co.uk>

Node API was never implemented.
---
 doc/device-api.txt |   38 --------------------------------------
 doc/node-api.txt   |   28 ----------------------------
 test/list-devices  |   19 +------------------
 3 files changed, 1 insertion(+), 84 deletions(-)
 delete mode 100644 doc/node-api.txt

diff --git a/doc/device-api.txt b/doc/device-api.txt
index 0f34210..3b84033 100644
--- a/doc/device-api.txt
+++ b/doc/device-api.txt
@@ -71,32 +71,6 @@ Methods		dict GetProperties()
 
 			Possible errors: org.bluez.Error.NotConnected
 
-		array{object} ListNodes()
-
-			Returns list of device node object paths.
-
-			Possible errors: org.bluez.Error.InvalidArguments
-					 org.bluez.Error.Failed
-					 org.bluez.Error.OutOfMemory
-
-		object CreateNode(string uuid)
-
-			Creates a persistent device node binding with a
-			remote device. The actual support for the specified
-			UUID depends if the device driver has support for
-			persistent binding. At the moment only RFCOMM TTY
-			nodes are supported.
-
-			Possible errors: org.bluez.Error.InvalidArguments
-					 org.bluez.Error.NotSupported
-
-		void RemoveNode(object node)
-
-			Removes a persistent device node binding.
-
-			Possible errors: org.bluez.Error.InvalidArguments
-					 org.bluez.Error.DoesNotExist
-
 Signals		PropertyChanged(string name, variant value)
 
 			This signal indicates a changed value of the given
@@ -108,14 +82,6 @@ Signals		PropertyChanged(string name, variant value)
 			disconnection to a remote device has been requested.
 			The actual disconnection will happen 2 seconds later.
 
-		NodeCreated(object node)
-
-			Parameter is object path of created device node.
-
-		NodeRemoved(object node)
-
-			Parameter is object path of removed device node.
-
 Properties	string Address [readonly]
 
 			The Bluetooth device address of the remote device.
@@ -195,10 +161,6 @@ Properties	string Address [readonly]
 			emitted PropertyChanged signal will show the remote
 			name again.
 
-		array{object} Nodes [readonly]
-
-			List of device node object paths.
-
 		object Adapter [readonly]
 
 			The object path of the adapter the device belongs to.
diff --git a/doc/node-api.txt b/doc/node-api.txt
deleted file mode 100644
index 3ae4dee..0000000
--- a/doc/node-api.txt
+++ /dev/null
@@ -1,28 +0,0 @@
-BlueZ D-Bus Node API description
-********************************
-
-Copyright (C) 2004-2010  Marcel Holtmann <marcel@holtmann.org>
-
-
-Node hierarchy
-==============
-
-Service		org.bluez
-Interface	org.bluez.Node
-Object path	[variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX/{node0,...}
-
-Methods		dict GetProperties()
-
-			Returns all properties for the device node. See the
-			properties section for available properties.
-
-			Possible Errors: org.bluez.Error.DoesNotExist
-					 org.bluez.Error.InvalidArguments
-
-Properties	string Name [readonly]
-
-			The name of the node. For example "rfcomm0".
-
-		object Device [readonly]
-
-			The object path of the device this node belongs to.
diff --git a/test/list-devices b/test/list-devices
index 1683142..d4ed711 100755
--- a/test/list-devices
+++ b/test/list-devices
@@ -60,10 +60,7 @@ for i in adapter_list:
 		properties = device.GetProperties()
 		for key in properties.keys():
 			value = properties[key]
-			if (key == "Nodes"):
-				list = extract_objects(value)
-				print("        %s = %s" % (key, list))
-			elif (key == "UUIDs"):
+			if (key == "UUIDs"):
 				list = extract_uuids(value)
 				print("        %s = %s" % (key, list))
 			elif (key == "Class"):
@@ -77,18 +74,4 @@ for i in adapter_list:
 			else:
 				print("        %s = %s" % (key, value))
 
-		try:
-			node_list = properties["Nodes"]
-		except:
-			node_list = []
-
-		for x in node_list:
-			node = dbus.Interface(bus.get_object("org.bluez", x),
-							"org.bluez.Node")
-			print("        [ " + x + " ]")
-
-			properties = node.GetProperties()
-			for key in properties.keys():
-				print("            %s = %s" % (key, properties[key]))
-
 	print("")
-- 
1.7.10.4

