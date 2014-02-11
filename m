Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ 1/7] android: Use 16-bit UUID for SDP search
Date: Tue, 11 Feb 2014 14:32:26 -0400
Message-Id: <1392143552-11395-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

These UUIDs are assigned by BT-SIG and therefore there is no need to
use full 128-bit UUIDs. This also avoids unnecessary conversion from
string representation.
---
 android/handsfree.c |    3 +--
 android/hidhost.c   |    7 +++----
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/android/handsfree.c b/android/handsfree.c
index 9482b2e..a869d58 100644
--- a/android/handsfree.c
+++ b/android/handsfree.c
@@ -34,7 +34,6 @@
 #include "lib/bluetooth.h"
 #include "lib/sdp.h"
 #include "lib/sdp_lib.h"
-#include "lib/uuid.h"
 #include "src/sdp-client.h"
 #include "src/uuid-helper.h"
 #include "src/shared/hfp.h"
@@ -294,7 +293,7 @@ static void handle_connect(const void *buf, uint16_t len)
 
 	device_init(&bdaddr);
 
-	bt_string2uuid(&uuid, HFP_HS_UUID);
+	sdp_uuid16_create(&uuid, HANDSFREE_SVCLASS_ID);
 	if (bt_search_service(&adapter_addr, &device.bdaddr, &uuid,
 					sdp_search_cb, NULL, NULL, 0) < 0) {
 		error("handsfree: SDP search failed");
diff --git a/android/hidhost.c b/android/hidhost.c
index 8bd3455..45fe14f 100644
--- a/android/hidhost.c
+++ b/android/hidhost.c
@@ -37,7 +37,6 @@
 #include "lib/bluetooth.h"
 #include "lib/sdp.h"
 #include "lib/sdp_lib.h"
-#include "lib/uuid.h"
 #include "src/shared/mgmt.h"
 #include "src/sdp-client.h"
 #include "src/uuid-helper.h"
@@ -751,7 +750,7 @@ static void hid_sdp_did_search_cb(sdp_list_t *recs, int err, gpointer data)
 			dev->version = data->val.uint16;
 	}
 
-	bt_string2uuid(&uuid, HID_UUID);
+	sdp_uuid16_create(&uuid, HID_SVCLASS_ID);
 	if (bt_search_service(&adapter_addr, &dev->dst, &uuid,
 				hid_sdp_search_cb, dev, NULL, 0) < 0) {
 		error("failed to search sdp details");
@@ -792,7 +791,7 @@ static void bt_hid_connect(const void *buf, uint16_t len)
 	ba2str(&dev->dst, addr);
 	DBG("connecting to %s", addr);
 
-	bt_string2uuid(&uuid, PNP_UUID);
+	sdp_uuid16_create(&uuid, PNP_INFO_SVCLASS_ID);
 	if (bt_search_service(&adapter_addr, &dev->dst, &uuid,
 					hid_sdp_did_search_cb, dev, NULL, 0) < 0) {
 		error("Failed to search DeviceID SDP details");
@@ -1293,7 +1292,7 @@ static void connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
 		dev->ctrl_io = g_io_channel_ref(chan);
 		dev->uhid_fd = -1;
 
-		bt_string2uuid(&uuid, PNP_UUID);
+		sdp_uuid16_create(&uuid, PNP_INFO_SVCLASS_ID);
 		if (bt_search_service(&src, &dev->dst, &uuid,
 					hid_sdp_did_search_cb, dev, NULL, 0) < 0) {
 			error("failed to search did sdp details");
-- 
1.7.9.5

