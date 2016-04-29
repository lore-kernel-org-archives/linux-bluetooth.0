Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC v2 BlueZ 2/3] doc/gatt-api: Merge RegisterProfile with RegisterApplication
Date: Fri, 29 Apr 2016 13:38:32 +0300
Message-Id: <1461926313-5629-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1461926313-5629-1-git-send-email-luiz.dentz@gmail.com>
References: <1461926313-5629-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Since RegisterApplication makes use of ObjectManager it is also possible
to verify the existance of GattProfile objects unifying the API for both
services (GATT server) and profiles (GATT client).
---
 doc/gatt-api.txt | 37 +++++++++----------------------------
 1 file changed, 9 insertions(+), 28 deletions(-)

diff --git a/doc/gatt-api.txt b/doc/gatt-api.txt
index 683b1b7..9404986 100644
--- a/doc/gatt-api.txt
+++ b/doc/gatt-api.txt
@@ -218,8 +218,8 @@ Properties	string UUID [read-only]
 				"encrypt-authenticated-read"
 				"encrypt-authenticated-write"
 
-Profile hierarcy
-================
+GATT Profile hierarcy
+=====================
 
 Local profile (GATT client) instance. By registering this type of object
 an application effectively indicates support for a specific GATT profile
@@ -238,6 +238,10 @@ Methods		void Release()
 			profile, because when this method gets called it has
 			already been unregistered.
 
+Properties	array{string} UUIDs [read-only]
+
+			128-bit GATT service UUIDs.
+
 
 GATT Manager hierarchy
 ======================
@@ -306,11 +310,12 @@ Object path	[variable prefix]/{hci0,hci1,...}
 Methods		void RegisterApplication(object application, dict options)
 
 			Registers a local GATT services hierarchy as described
-			above.
+			above (GATT Server) and/or GATT profiles (GATT Client).
 
 			The application object path together with the D-Bus
 			system bus connection ID define the identification of
-			the application registering a GATT based service.
+			the application registering a GATT based
+			service or profile.
 
 			Possible errors: org.bluez.Error.InvalidArguments
 					 org.bluez.Error.AlreadyExists
@@ -324,27 +329,3 @@ Methods		void RegisterApplication(object application, dict options)
 
 			Possible errors: org.bluez.Error.InvalidArguments
 					 org.bluez.Error.DoesNotExist
-
-		void RegisterProfile(object profile, array{string} UUIDs,
-				     dict options)
-
-			Registers a GATT (client role) profile exported
-			under interface GattProfile1. The array of UUIDs
-			specifies the mandatory set of remote service
-			UUIDs that should all be available for the
-			remote device to match this profile. Matching
-			devices will be added to the auto-connection
-			list and connected whenever available.
-
-			Possible errors: org.bluez.Error.InvalidArguments
-					 org.bluez.Error.AlreadyExists
-
-		void UnregisterProfile(object profile)
-
-			This unregisters the profile that has been
-			previously registered. The object path parameter
-			must match the same value that has been used
-			on registration.
-
-			Possible errors: org.bluez.Error.InvalidArguments
-					 org.bluez.Error.DoesNotExist
-- 
2.5.5

