Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: johan.hedberg@gmail.com,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v4 4/6] android/gatt: Refactor trigger connection function.
Date: Mon,  4 Aug 2014 12:34:17 +0200
Message-Id: <1407148459-20125-5-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1407148459-20125-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1407148459-20125-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Refactor code so it is clear what action we take in different connection
states.
---
 android/gatt.c | 39 +++++++++++++++++++++++++--------------
 1 file changed, 25 insertions(+), 14 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index 11d7a2c..448bcb8 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -1751,31 +1751,42 @@ static int connect_bredr(struct gatt_device *dev)
 
 static bool trigger_connection(struct app_connection *connection)
 {
+	bool ret;
+
 	switch (connection->device->state) {
 	case DEVICE_DISCONNECTED:
+		/*
+		 *  If device was last seen over BR/EDR connect over it.
+		 *  Note: Connection state is handled in connect_bredr() func
+		 */
+		if (bt_device_last_seen_bearer(&connection->device->bdaddr) ==
+								BDADDR_BREDR)
+			return connect_bredr(connection->device) == 0;
+
+		/* Trigger discovery if not already started */
+		if (!scanning) {
+			if (!bt_le_discovery_start()) {
+				error("gatt: Could not start scan");
+				ret = false;
+				break;
+			}
+		}
+		ret = true;
 		device_set_state(connection->device, DEVICE_CONNECT_INIT);
 		break;
 	case DEVICE_CONNECTED:
 		send_app_connect_notify(connection, GATT_SUCCESS);
+		ret = true;
 		break;
+	case DEVICE_CONNECT_READY:
+	case DEVICE_CONNECT_INIT:
 	default:
+		/* In those cases connection is already triggered. */
+		ret = true;
 		break;
 	}
 
-	/* If device was last seen over BR/EDR connect over it */
-	if (bt_device_last_seen_bearer(&connection->device->bdaddr) ==
-								BDADDR_BREDR)
-		return connect_bredr(connection->device) == 0;
-
-	/* after state change trigger discovering */
-	if (!scanning && (connection->device->state == DEVICE_CONNECT_INIT))
-		if (!bt_le_discovery_start()) {
-			error("gatt: Could not start scan");
-
-			return false;
-		}
-
-	return true;
+	return ret;
 }
 
 static uint8_t unregister_app(int client_if)
-- 
1.8.4

