Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2] doc/gatt-api: Introduce GattProfile1 concept
Date: Tue, 17 Feb 2015 11:26:21 +0200
Message-Id: <1424165181-22895-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

Until now the GATT D-Bus API doesn't provide any way to register client
role profiles so that bluetoothd would be able to add matching devices
to its auto-connect list (managed by the kernel from 3.17 onward). To
keep the GATT D-Bus interface as capable as the internal plugin API this
patch adds a new concept of a GattProfile1 D-Bus object. By registering
such an object and providing a set of mandatory service UUIDs bluetoothd
will start performing matching against remote devices and add them to
the auto-connect list.
---
 doc/gatt-api.txt | 43 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/doc/gatt-api.txt b/doc/gatt-api.txt
index de7f2d9ae6b3..391d7d900b87 100644
--- a/doc/gatt-api.txt
+++ b/doc/gatt-api.txt
@@ -205,6 +205,26 @@ Properties	string UUID [read-only]
 			which a PropertiesChanged signal will be emitted.
 
 
+Profile hierarcy
+================
+
+Local profile (GATT client) instance. By registering this type of object
+an application effectively indicates support for a specific GATT profile
+and requests automatic connections to be established to devices
+supporting it.
+
+Service		<application dependent>
+Interface	org.bluez.GattProfile1 [Experimental]
+Object path	<application dependent>
+
+Methods		void Release()
+
+			This method gets called when the service daemon
+			unregisters the profile. The profile can use it to
+			do cleanup tasks. There is no need to unregister the
+			profile, because when this method gets called it has
+			already been unregistered.
+
 
 GATT Manager hierarchy
 ======================
@@ -244,3 +264,26 @@ Methods		void RegisterService(object service, dict options)
 
 			Possible errors: org.bluez.Error.InvalidArguments
 					 org.bluez.Error.DoesNotExist
+
+		void RegisterProfile(object profile, array{string} UUIDs)
+
+			Registers a GATT (client role) profile exported
+			under interface GattProfile1. The array of UUIDs
+			specifies the mandatory set of remote service
+			UUIDs that should all be available for the
+			remote device to match this profile. Matching
+			devices will be added to the auto-connection
+			list and connected whenever available.
+
+			Possible errors: org.bluez.Error.InvalidArguments
+					 org.bluez.Error.AlreadyExists
+
+		void UnregisterProfile(object profile)
+
+			This unregisters the profile that has been
+			previously registered. The object path parameter
+			must match the same value that has been used
+			on registration.
+
+			Possible errors: org.bluez.Error.InvalidArguments
+					 org.bluez.Error.DoesNotExist
-- 
2.1.0

