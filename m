Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 4/4] android/hid: Add handling of HAL_EV_HID_INFO
Date: Fri,  1 Nov 2013 15:08:41 +0200
Message-Id: <1383311321-28429-4-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1383311321-28429-1-git-send-email-luiz.dentz@gmail.com>
References: <1383311321-28429-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 android/hid.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/android/hid.c b/android/hid.c
index 57ad5e4..6e6f606 100644
--- a/android/hid.c
+++ b/android/hid.c
@@ -58,6 +58,7 @@ static GSList *devices = NULL;
 struct hid_device {
 	bdaddr_t	dst;
 	uint8_t		state;
+	uint8_t		subclass;
 	uint16_t	vendor;
 	uint16_t	product;
 	uint16_t	version;
@@ -260,6 +261,28 @@ static gboolean ctrl_watch_cb(GIOChannel *chan, GIOCondition cond,
 	return FALSE;
 }
 
+static void bt_hid_set_info(struct hid_device *dev)
+{
+	struct hal_ev_hid_info ev;
+
+	DBG("");
+
+	bdaddr2android(&dev->dst, ev.bdaddr);
+	ev.attr = 0; /* TODO: Check what is this field */
+	ev.subclass = dev->subclass;
+	ev.app_id = 0; /* TODO: Check what is this field */
+	ev.vendor = dev->vendor;
+	ev.product = dev->product;
+	ev.version = dev->version;
+	ev.country = dev->country;
+	ev.descr_len = dev->rd_size;
+	memset(ev.descr, 0, sizeof(ev.descr));
+	memcpy(ev.descr, dev->rd_data, ev.descr_len);
+
+	ipc_send(notification_io, HAL_SERVICE_ID_HIDHOST, HAL_EV_HID_INFO,
+							sizeof(ev), &ev, -1);
+}
+
 static int uhid_create(struct hid_device *dev)
 {
 	GIOCondition cond = G_IO_IN | G_IO_ERR | G_IO_NVAL;
@@ -295,6 +318,8 @@ static int uhid_create(struct hid_device *dev)
 	dev->uhid_watch_id = g_io_add_watch(io, cond, uhid_event_cb, dev);
 	g_io_channel_unref(io);
 
+	bt_hid_set_info(dev);
+
 	return 0;
 }
 
@@ -412,6 +437,10 @@ static void hid_sdp_search_cb(sdp_list_t *recs, int err, gpointer data)
 		if (data)
 			dev->country = data->val.uint8;
 
+		data = sdp_data_get(rec, SDP_ATTR_HID_DEVICE_SUBCLASS);
+		if (data)
+			dev->subclass = data->val.uint8;
+
 		data = sdp_data_get(rec, SDP_ATTR_HID_DESCRIPTOR_LIST);
 		if (data) {
 			if (!SDP_IS_SEQ(data->dtd))
-- 
1.8.3.1

