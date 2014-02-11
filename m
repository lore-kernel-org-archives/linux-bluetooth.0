Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ 3/7] android/hidhost: Trivial coding style fix
Date: Tue, 11 Feb 2014 14:32:28 -0400
Message-Id: <1392143552-11395-3-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1392143552-11395-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1392143552-11395-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Fix two lines over 80 columns.
---
 android/hidhost.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/android/hidhost.c b/android/hidhost.c
index 45fe14f..f54ca6d 100644
--- a/android/hidhost.c
+++ b/android/hidhost.c
@@ -793,7 +793,7 @@ static void bt_hid_connect(const void *buf, uint16_t len)
 
 	sdp_uuid16_create(&uuid, PNP_INFO_SVCLASS_ID);
 	if (bt_search_service(&adapter_addr, &dev->dst, &uuid,
-					hid_sdp_did_search_cb, dev, NULL, 0) < 0) {
+				hid_sdp_did_search_cb, dev, NULL, 0) < 0) {
 		error("Failed to search DeviceID SDP details");
 		hid_device_remove(dev);
 		status = HAL_STATUS_FAILED;
@@ -1294,7 +1294,7 @@ static void connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
 
 		sdp_uuid16_create(&uuid, PNP_INFO_SVCLASS_ID);
 		if (bt_search_service(&src, &dev->dst, &uuid,
-					hid_sdp_did_search_cb, dev, NULL, 0) < 0) {
+				hid_sdp_did_search_cb, dev, NULL, 0) < 0) {
 			error("failed to search did sdp details");
 			hid_device_remove(dev);
 			return;
-- 
1.7.9.5

