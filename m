Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@gmail.com>
Subject: [PATCH 4/5] device: Add workaround for Sony Dualshock 4 broken SDP
Date: Mon, 20 Jan 2014 01:31:53 +0100
Message-Id: <1390177914-13529-4-git-send-email-szymon.janc@gmail.com>
In-Reply-To: <1390177914-13529-1-git-send-email-szymon.janc@gmail.com>
References: <1390177914-13529-1-git-send-email-szymon.janc@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Sony DualShock 4 is not respecting negotiated L2CAP IMTU. This might
results in SDP response being dropped by kernel. Workaround this by
forcing SDP code to use bigger IMTU while connecting.
---
 src/device.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/src/device.c b/src/device.c
index 1bd27a1..6ae14b2 100644
--- a/src/device.c
+++ b/src/device.c
@@ -118,6 +118,7 @@ struct browse_req {
 	int search_uuid;
 	int reconnect_attempt;
 	guint listener_id;
+	uint16_t sdp_flags;
 };
 
 struct included_search {
@@ -2971,7 +2972,8 @@ static void browse_cb(sdp_list_t *recs, int err, gpointer user_data)
 		sdp_uuid16_create(&uuid, uuid_list[req->search_uuid++]);
 		bt_search_service(btd_adapter_get_address(adapter),
 						&device->bdaddr, &uuid,
-						browse_cb, user_data, NULL, 0);
+						browse_cb, user_data, NULL,
+						req->sdp_flags);
 		return;
 	}
 
@@ -3498,6 +3500,22 @@ done:
 	return 0;
 }
 
+static uint16_t get_sdp_flags(struct btd_device *device)
+{
+	uint16_t vid, pid;
+
+	vid = btd_device_get_vendor(device);
+	pid = btd_device_get_product(device);
+
+	/* Sony DualShock 4 is not respecting negotiated L2CAP IMTU. This might
+	 * results in SDP response being dropped by kernel. Workaround this by
+	 * forcing SDP code to use bigger IMTU while connecting. */
+	if (vid == 0x054c && pid == 0x05c4)
+		return SDP_DOUBLE_IMTU;
+
+	return 0;
+}
+
 static int device_browse_sdp(struct btd_device *device, DBusMessage *msg)
 {
 	struct btd_adapter *adapter = device->adapter;
@@ -3512,9 +3530,11 @@ static int device_browse_sdp(struct btd_device *device, DBusMessage *msg)
 	req->device = device;
 	sdp_uuid16_create(&uuid, uuid_list[req->search_uuid++]);
 
+	req->sdp_flags = get_sdp_flags(device);
+
 	err = bt_search_service(btd_adapter_get_address(adapter),
 				&device->bdaddr, &uuid, browse_cb, req, NULL,
-				0);
+				req->sdp_flags);
 	if (err < 0) {
 		browse_request_free(req);
 		return err;
-- 
1.8.5.3

