Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ 2/3] core: device: Fix device_browse_gatt
Date: Wed, 14 Jan 2015 19:52:14 -0800
Message-Id: <1421293935-24092-2-git-send-email-armansito@chromium.org>
In-Reply-To: <1421293935-24092-1-git-send-email-armansito@chromium.org>
References: <1421293935-24092-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch fixes an issue that occurs in device.c:device_browse_gatt
when an ATT data connection already exists. This patch solves the
following problems:

  1. In the case when services are already discovered, the old code
     re-probed all profiles which caused crashes.
  2. In the case when services are already discovered, the old code
     never actually resolved the browse request when initiated from
     an outgoing bonding request. This caused, for example, a D-Bus
     call to Pair to receive no response.
---
 src/device.c | 39 ++++++++++++++++-----------------------
 1 file changed, 16 insertions(+), 23 deletions(-)

diff --git a/src/device.c b/src/device.c
index b5c19dd..f73a082 100644
--- a/src/device.c
+++ b/src/device.c
@@ -4232,29 +4232,9 @@ static void att_browse_error_cb(const GError *gerr, gpointer user_data)
 	browse_request_free(req);
 }
 
-static void browse_gatt_client(struct browse_req *req)
-{
-	struct btd_device *device = req->device;
-
-	if (!device->client) {
-		DBG("No instance currently attached");
-		return;
-	}
-
-	/*
-	 * If gatt-client is ready, then register all services. Otherwise, this
-	 * will be deferred until client becomes ready.
-	 */
-	if (bt_gatt_client_is_ready(device->client))
-		register_gatt_services(req);
-}
-
 static void att_browse_cb(gpointer user_data)
 {
-	struct att_callbacks *attcb = user_data;
-	struct btd_device *device = attcb->user_data;
-
-	browse_gatt_client(device->browse);
+	DBG("ATT connection successful");
 }
 
 static int device_browse_gatt(struct btd_device *device, DBusMessage *msg)
@@ -4272,8 +4252,21 @@ static int device_browse_gatt(struct btd_device *device, DBusMessage *msg)
 	device->browse = req;
 
 	if (device->attrib) {
-		browse_gatt_client(device->browse);
-		goto done;
+		/*
+		 * If discovery has not yet completed, then wait for gatt-client
+		 * to become ready.
+		 */
+		if (!device->le_state.svc_resolved)
+			goto done;
+
+		/*
+		 * Services have already been discovered, so signal this browse
+		 * request as resolved.
+		 */
+		device_svc_resolved(device, device->bdaddr_type, 0);
+		device->browse = NULL;
+		browse_request_free(req);
+		return 0;
 	}
 
 	attcb = g_new0(struct att_callbacks, 1);
-- 
2.2.0.rc0.207.ga3a616c

