Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCHv3 2/2] android/hid: Force encryption for keyboards
Date: Mon, 25 Aug 2014 14:54:19 +0200
Message-Id: <1408971259-21929-3-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1408971259-21929-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1408971259-21929-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Encryption is mandatory for keyboards. Instead of using hardcoded security
level it's now set per device (with LOW as default) and raised for
keyboards (after the SDP query is done). This level is then used to
establish outgoing connections and raising the security level of the
incomming ones.
---
 android/hidhost.c | 26 +++++++++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

diff --git a/android/hidhost.c b/android/hidhost.c
index bb725c1..5b31c95 100644
--- a/android/hidhost.c
+++ b/android/hidhost.c
@@ -110,6 +110,7 @@ struct hid_device {
 	uint8_t		last_hid_msg;
 	struct bt_hog	*hog;
 	guint		reconnect_id;
+	int sec_level;
 };
 
 static int device_cmp(gconstpointer s, gconstpointer user_data)
@@ -162,6 +163,8 @@ static struct hid_device *hid_device_new(const bdaddr_t *addr)
 	dev = g_new0(struct hid_device, 1);
 	bacpy(&dev->dst, addr);
 	dev->state = HAL_HIDHOST_STATE_DISCONNECTED;
+	dev->sec_level = BT_IO_SEC_LOW;
+
 	devices = g_slist_append(devices, dev);
 
 	return dev;
@@ -594,7 +597,7 @@ static void control_connect_cb(GIOChannel *chan, GError *conn_err,
 					BT_IO_OPT_SOURCE_BDADDR, &adapter_addr,
 					BT_IO_OPT_DEST_BDADDR, &dev->dst,
 					BT_IO_OPT_PSM, L2CAP_PSM_HIDP_INTR,
-					BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_LOW,
+					BT_IO_OPT_SEC_LEVEL, dev->sec_level,
 					BT_IO_OPT_INVALID);
 	if (!dev->intr_io) {
 		error("hidhost: Failed to connect interrupt channel (%s)",
@@ -640,9 +643,14 @@ static void hid_sdp_search_cb(sdp_list_t *recs, int err, gpointer data)
 			dev->country = data->val.uint8;
 
 		data = sdp_data_get(rec, SDP_ATTR_HID_DEVICE_SUBCLASS);
-		if (data)
+		if (data) {
 			dev->subclass = data->val.uint8;
 
+			/* Encryption is mandatory for keyboards */
+			if (dev->subclass & 0x40)
+				dev->sec_level = BT_IO_SEC_MEDIUM;
+		}
+
 		data = sdp_data_get(rec, SDP_ATTR_HID_BOOT_DEVICE);
 		if (data)
 			dev->boot_dev = data->val.uint8;
@@ -673,6 +681,18 @@ static void hid_sdp_search_cb(sdp_list_t *recs, int err, gpointer data)
 	}
 
 	if (dev->ctrl_io) {
+		/* Raise the security level for this device if needed. */
+		if ((dev->sec_level > BT_IO_SEC_LOW) &&
+			!bt_io_set(dev->ctrl_io, &gerr,
+					BT_IO_OPT_SEC_LEVEL, dev->sec_level,
+					BT_IO_OPT_INVALID)) {
+			error("hidhost: Cannot raise security level: %s",
+								gerr->message);
+			g_error_free(gerr);
+
+			goto fail;
+		}
+
 		if (uhid_create(dev) < 0)
 			goto fail;
 		return;
@@ -682,7 +702,7 @@ static void hid_sdp_search_cb(sdp_list_t *recs, int err, gpointer data)
 					BT_IO_OPT_SOURCE_BDADDR, &adapter_addr,
 					BT_IO_OPT_DEST_BDADDR, &dev->dst,
 					BT_IO_OPT_PSM, L2CAP_PSM_HIDP_CTRL,
-					BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_LOW,
+					BT_IO_OPT_SEC_LEVEL, dev->sec_level,
 					BT_IO_OPT_INVALID);
 	if (gerr) {
 		error("hidhost: Failed to connect control channel (%s)",
-- 
1.9.1

