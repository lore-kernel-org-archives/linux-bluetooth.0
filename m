Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ] core: Remove unused code from device_browse_sdp()
Date: Mon,  4 Feb 2013 20:32:36 -0400
Message-Id: <1360024356-6838-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The "search" parameter was always NULL, and therefore code depending on
it being non-NULL will never be reached.
---
 src/device.c |   23 ++++++++---------------
 1 file changed, 8 insertions(+), 15 deletions(-)

diff --git a/src/device.c b/src/device.c
index 49f8957..dbf0744 100644
--- a/src/device.c
+++ b/src/device.c
@@ -215,7 +215,7 @@ static const uint16_t uuid_list[] = {
 static int device_browse_primary(struct btd_device *device, DBusMessage *msg,
 							gboolean secure);
 static int device_browse_sdp(struct btd_device *device, DBusMessage *msg,
-					uuid_t *search, gboolean reverse);
+							gboolean reverse);
 
 static gboolean store_device_info_cb(gpointer user_data)
 {
@@ -1143,7 +1143,7 @@ void device_add_eir_uuids(struct btd_device *dev, GSList *uuids)
 static int device_resolve_svc(struct btd_device *dev, DBusMessage *msg)
 {
 	if (device_is_bredr(dev))
-		return device_browse_sdp(dev, msg, NULL, FALSE);
+		return device_browse_sdp(dev, msg, FALSE);
 	else
 		return device_browse_primary(dev, msg, FALSE);
 }
@@ -3374,11 +3374,10 @@ done:
 }
 
 static int device_browse_sdp(struct btd_device *device, DBusMessage *msg,
-					uuid_t *search, gboolean reverse)
+							gboolean reverse)
 {
 	struct btd_adapter *adapter = device->adapter;
 	struct browse_req *req;
-	bt_callback_t cb;
 	uuid_t uuid;
 	int err;
 
@@ -3387,17 +3386,11 @@ static int device_browse_sdp(struct btd_device *device, DBusMessage *msg,
 
 	req = g_new0(struct browse_req, 1);
 	req->device = btd_device_ref(device);
-	if (search) {
-		memcpy(&uuid, search, sizeof(uuid_t));
-		cb = search_cb;
-	} else {
-		sdp_uuid16_create(&uuid, uuid_list[req->search_uuid++]);
-		init_browse(req, reverse);
-		cb = browse_cb;
-	}
+	sdp_uuid16_create(&uuid, uuid_list[req->search_uuid++]);
+	init_browse(req, reverse);
 
 	err = bt_search_service(adapter_get_address(adapter), &device->bdaddr,
-							&uuid, cb, req, NULL);
+						&uuid, browse_cb, req, NULL);
 	if (err < 0) {
 		browse_request_free(req);
 		return err;
@@ -3554,7 +3547,7 @@ static gboolean start_discovery(gpointer user_data)
 	struct btd_device *device = user_data;
 
 	if (device_is_bredr(device))
-		device_browse_sdp(device, NULL, NULL, TRUE);
+		device_browse_sdp(device, NULL, TRUE);
 	else
 		device_browse_primary(device, NULL, FALSE);
 
@@ -3624,7 +3617,7 @@ void device_bonding_complete(struct btd_device *device, uint8_t status)
 		}
 
 		if (device_is_bredr(device))
-			device_browse_sdp(device, bonding->msg, NULL, FALSE);
+			device_browse_sdp(device, bonding->msg, FALSE);
 		else
 			device_browse_primary(device, bonding->msg, FALSE);
 
-- 
1.7.9.5

