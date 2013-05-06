Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [RFC BlueZ v0 11/13] dbus: Deprecate old profile-connecting API
Date: Mon,  6 May 2013 10:43:28 +0200
Message-Id: <1367829810-8262-12-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1367829810-8262-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1367829810-8262-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

The new org.bluez.Service1 interface deprecates the old UUID-specific
connect/disconnect methods in org.bluez.Device1.
---
 doc/device-api.txt | 4 ++--
 src/device.c       | 6 ++++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/doc/device-api.txt b/doc/device-api.txt
index 187f2bf..1e294ad 100644
--- a/doc/device-api.txt
+++ b/doc/device-api.txt
@@ -40,7 +40,7 @@ Methods		void Connect()
 
 			Possible errors: org.bluez.Error.NotConnected
 
-		void ConnectProfile(string uuid)
+		void ConnectProfile(string uuid) [Deprecated]
 
 			This method connects a specific profile of this
 			device. The UUID provided is the remote service
@@ -50,7 +50,7 @@ Methods		void Connect()
 					 org.bluez.Error.AlreadyConnected
 					 org.bluez.Error.ConnectFailed
 
-		void DisconnectProfile(string uuid)
+		void DisconnectProfile(string uuid) [Deprecated]
 
 			This method disconnects a specific profile of
 			this device. The profile needs to be registered
diff --git a/src/device.c b/src/device.c
index 41e0e15..720a476 100644
--- a/src/device.c
+++ b/src/device.c
@@ -1667,9 +1667,11 @@ static DBusMessage *cancel_pairing(DBusConnection *conn, DBusMessage *msg,
 static const GDBusMethodTable device_methods[] = {
 	{ GDBUS_ASYNC_METHOD("Disconnect", NULL, NULL, disconnect) },
 	{ GDBUS_ASYNC_METHOD("Connect", NULL, NULL, dev_connect) },
-	{ GDBUS_ASYNC_METHOD("ConnectProfile", GDBUS_ARGS({ "UUID", "s" }),
+	{ GDBUS_DEPRECATED_ASYNC_METHOD("ConnectProfile",
+						GDBUS_ARGS({ "UUID", "s" }),
 						NULL, connect_profile) },
-	{ GDBUS_ASYNC_METHOD("DisconnectProfile", GDBUS_ARGS({ "UUID", "s" }),
+	{ GDBUS_DEPRECATED_ASYNC_METHOD("DisconnectProfile",
+						GDBUS_ARGS({ "UUID", "s" }),
 						NULL, disconnect_profile) },
 	{ GDBUS_ASYNC_METHOD("Pair", NULL, NULL, pair_device) },
 	{ GDBUS_METHOD("CancelPairing", NULL, NULL, cancel_pairing) },
-- 
1.8.1.4

