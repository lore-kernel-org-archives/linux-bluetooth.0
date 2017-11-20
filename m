Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/2] device: Don't disable auto-connect for trusted devices
Date: Mon, 20 Nov 2017 15:42:44 +0200
Message-Id: <20171120134244.24548-2-luiz.dentz@gmail.com>
In-Reply-To: <20171120134244.24548-1-luiz.dentz@gmail.com>
References: <20171120134244.24548-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Trusted shall indicate if the device is allowed connect in any
circumstance, even if the user has called device.Disconnect.
---
 doc/device-api.txt | 6 +++---
 src/device.c       | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/doc/device-api.txt b/doc/device-api.txt
index ac5604f9c..8b69c2ef3 100644
--- a/doc/device-api.txt
+++ b/doc/device-api.txt
@@ -52,9 +52,9 @@ Methods		void Connect()
 			This method can be also used to cancel a preceding
 			Connect call before a reply to it has been received.
 
-			When connected over LE bearer calling this method will
-			prevent incoming connections until Connect method is
-			called again.
+			For non-trusted devices connected over LE bearer calling
+			this method will disable incoming connections until
+			Connect method is called again.
 
 			Possible errors: org.bluez.Error.NotConnected
 
diff --git a/src/device.c b/src/device.c
index e8118112e..a753d2140 100644
--- a/src/device.c
+++ b/src/device.c
@@ -1483,10 +1483,10 @@ static DBusMessage *dev_disconnect(DBusConnection *conn, DBusMessage *msg,
 	struct btd_device *device = user_data;
 
 	/*
-	 * Disable connections through passive scanning until
-	 * Device1.Connect is called
+	 * If device is not trusted disable connections through passive
+	 * scanning until Device1.Connect is called
 	 */
-	if (device->auto_connect) {
+	if (device->auto_connect && !device->trusted) {
 		device->disable_auto_connect = TRUE;
 		device_set_auto_connect(device, FALSE);
 	}
-- 
2.13.6

