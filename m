Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@gmail.com>
Subject: [PATCH v2 4/5] device: Add workaround for Sony Dualshock 4 broken SDP
Date: Mon, 20 Jan 2014 12:08:35 +0100
Message-Id: <1390216116-23670-4-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1390216116-23670-1-git-send-email-szymon.janc@tieto.com>
References: <1390216116-23670-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Szymon Janc <szymon.janc@gmail.com>

Sony DualShock 4 is not respecting negotiated L2CAP MTU. This might
results in SDP response being dropped by kernel. Workaround this by
forcing SDP code to use bigger MTU while connecting.
---
 src/device.c | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/src/device.c b/src/device.c
index 1bd27a1..76b876e 100644
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
 
@@ -3498,6 +3500,23 @@ done:
 	return 0;
 }
 
+static uint16_t get_sdp_flags(struct btd_device *device)
+{
+	uint16_t vid, pid;
+
+	vid = btd_device_get_vendor(device);
+	pid = btd_device_get_product(device);
+
+	/* Sony DualShock 4 is not respecting negotiated L2CAP MTU. This might
+	 * results in SDP response being dropped by kernel. Workaround this by
+	 * forcing SDP code to use bigger MTU while connecting.
+	 */
+	if (vid == 0x054c && pid == 0x05c4)
+		return SDP_LARGE_MTU;
+
+	return 0;
+}
+
 static int device_browse_sdp(struct btd_device *device, DBusMessage *msg)
 {
 	struct btd_adapter *adapter = device->adapter;
@@ -3512,9 +3531,11 @@ static int device_browse_sdp(struct btd_device *device, DBusMessage *msg)
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
1.8.3.2

