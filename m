Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] device: Fix crash when connecting ATT with BR/EDR only device
Date: Wed,  9 Aug 2017 14:18:59 +0300
Message-Id: <20170809111859.10644-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The fix introduced in 006213cf4d231ce66de273e96619474bd516359b only
works for dual mode devices, if the device is BR/EDR the address type
would match the type on browsing_req so it still possible to crash.
---
 src/device.c | 38 +++++++++++++++++++++++---------------
 1 file changed, 23 insertions(+), 15 deletions(-)

diff --git a/src/device.c b/src/device.c
index 0ef95a62c..516958e0b 100644
--- a/src/device.c
+++ b/src/device.c
@@ -133,10 +133,15 @@ struct authentication_req {
 	gboolean secure;
 };
 
+enum {
+	BROWSE_SDP,
+	BROWSE_GATT
+};
+
 struct browse_req {
 	DBusMessage *msg;
 	struct btd_device *device;
-	uint8_t bdaddr_type;
+	uint8_t type;
 	GSList *match_uuids;
 	GSList *profiles_added;
 	sdp_list_t *records;
@@ -2203,13 +2208,13 @@ static void store_gatt_db(struct btd_device *device)
 }
 
 
-static void browse_request_complete(struct browse_req *req, uint8_t bdaddr_type,
-									int err)
+static void browse_request_complete(struct browse_req *req, uint8_t type,
+						uint8_t bdaddr_type, int err)
 {
 	struct btd_device *dev = req->device;
 	DBusMessage *reply = NULL;
 
-	if (req->bdaddr_type != bdaddr_type)
+	if (req->type != type)
 		return;
 
 	if (!req->msg)
@@ -2270,8 +2275,8 @@ static void device_set_svc_refreshed(struct btd_device *device, bool value)
 					DEVICE_INTERFACE, "ServicesResolved");
 }
 
-static void device_svc_resolved(struct btd_device *dev, uint8_t bdaddr_type,
-								int err)
+static void device_svc_resolved(struct btd_device *dev, uint8_t browse_type,
+						uint8_t bdaddr_type, int err)
 {
 	struct bearer_state *state = get_state(dev, bdaddr_type);
 	struct browse_req *req = dev->browse;
@@ -2318,7 +2323,7 @@ static void device_svc_resolved(struct btd_device *dev, uint8_t bdaddr_type,
 	if (!req)
 		return;
 
-	browse_request_complete(req, bdaddr_type, err);
+	browse_request_complete(req, browse_type, bdaddr_type, err);
 }
 
 static struct bonding_req *bonding_request_new(DBusMessage *msg,
@@ -4586,7 +4591,7 @@ static void search_cb(sdp_list_t *recs, int err, gpointer user_data)
 						DEVICE_INTERFACE, "UUIDs");
 
 send_reply:
-	device_svc_resolved(device, BDADDR_BREDR, err);
+	device_svc_resolved(device, BROWSE_SDP, BDADDR_BREDR, err);
 }
 
 static void browse_cb(sdp_list_t *recs, int err, gpointer user_data)
@@ -4711,7 +4716,8 @@ static void gatt_client_ready_cb(bool success, uint8_t att_ecode,
 	DBG("status: %s, error: %u", success ? "success" : "failed", att_ecode);
 
 	if (!success) {
-		device_svc_resolved(device, device->bdaddr_type, -EIO);
+		device_svc_resolved(device, BROWSE_GATT, device->bdaddr_type,
+									-EIO);
 		return;
 	}
 
@@ -4719,7 +4725,7 @@ static void gatt_client_ready_cb(bool success, uint8_t att_ecode,
 
 	btd_gatt_client_ready(device->client_dbus);
 
-	device_svc_resolved(device, device->bdaddr_type, 0);
+	device_svc_resolved(device, BROWSE_GATT, device->bdaddr_type, 0);
 
 	store_gatt_db(device);
 }
@@ -4925,6 +4931,7 @@ static void att_connect_cb(GIOChannel *io, GError *gerr, gpointer user_data)
 
 		if (device->browse)
 			browse_request_complete(device->browse,
+						BROWSE_GATT,
 						device->bdaddr_type,
 						-ECONNABORTED);
 
@@ -5027,7 +5034,7 @@ int device_connect_le(struct btd_device *dev)
 }
 
 static struct browse_req *browse_request_new(struct btd_device *device,
-							uint8_t bdaddr_type,
+							uint8_t type,
 							DBusMessage *msg)
 {
 	struct browse_req *req;
@@ -5037,7 +5044,7 @@ static struct browse_req *browse_request_new(struct btd_device *device,
 
 	req = g_new0(struct browse_req, 1);
 	req->device = device;
-	req->bdaddr_type = bdaddr_type;
+	req->type = type;
 
 	device->browse = req;
 
@@ -5063,7 +5070,7 @@ static int device_browse_gatt(struct btd_device *device, DBusMessage *msg)
 	struct btd_adapter *adapter = device->adapter;
 	struct browse_req *req;
 
-	req = browse_request_new(device, device->bdaddr_type, msg);
+	req = browse_request_new(device, BROWSE_GATT, msg);
 	if (!req)
 		return -EBUSY;
 
@@ -5079,7 +5086,8 @@ static int device_browse_gatt(struct btd_device *device, DBusMessage *msg)
 		 * Services have already been discovered, so signal this browse
 		 * request as resolved.
 		 */
-		device_svc_resolved(device, device->bdaddr_type, 0);
+		device_svc_resolved(device, BROWSE_GATT, device->bdaddr_type,
+									0);
 		return 0;
 	}
 
@@ -5135,7 +5143,7 @@ static int device_browse_sdp(struct btd_device *device, DBusMessage *msg)
 	uuid_t uuid;
 	int err;
 
-	req = browse_request_new(device, BDADDR_BREDR, msg);
+	req = browse_request_new(device, BROWSE_SDP, msg);
 	if (!req)
 		return -EBUSY;
 
-- 
2.13.3

