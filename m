Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 1/5] android/gatt: Fix MTU exchange
Date: Sat,  7 Feb 2015 16:18:14 +0100
Message-Id: <1423322298-6502-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This fix using invalid MTU on LE link. Previous attempt to fix this
"android/gatt: Fix initial setting of MTU" was not correct since
on LE default MTU is always 23 and we are not allowed to send bigger
requests before MTU exchange was performed.

This was affecting multiple PTS GATT test cases.
---
 android/gatt.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index 5f3050f..f754f30 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -1490,7 +1490,7 @@ static void connect_cb(GIOChannel *io, GError *gerr, gpointer user_data)
 	uint32_t status;
 	GError *err = NULL;
 	GAttrib *attrib;
-	uint16_t mtu;
+	uint16_t mtu, cid;
 
 	if (dev->state != DEVICE_CONNECT_READY) {
 		error("gatt: Device not in a connecting state!?");
@@ -1510,14 +1510,21 @@ static void connect_cb(GIOChannel *io, GError *gerr, gpointer user_data)
 		goto reply;
 	}
 
-	if (!bt_io_get(io, &err, BT_IO_OPT_IMTU, &mtu, BT_IO_OPT_INVALID)) {
-		error("gatt: Could not get imtu: %s", err->message);
+	if (!bt_io_get(io, &err, BT_IO_OPT_IMTU, &mtu, BT_IO_OPT_CID, &cid,
+							BT_IO_OPT_INVALID)) {
+		error("gatt: Could not get imtu or cid: %s", err->message);
 		device_set_state(dev, DEVICE_DISCONNECTED);
 		status = GATT_FAILURE;
 		g_error_free(err);
 		goto reply;
 	}
 
+	DBG("mtu %u cid %u", mtu, cid);
+
+	/* on LE we always start with default MTU */
+	if (cid == ATT_CID)
+		mtu = ATT_DEFAULT_LE_MTU;
+
 	attrib = g_attrib_new(io, mtu);
 	if (!attrib) {
 		error("gatt: unable to create new GAttrib instance");
-- 
1.9.3

