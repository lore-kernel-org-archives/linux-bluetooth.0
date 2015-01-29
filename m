Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v2 2/2] android/gatt: Remove not used variable
Date: Thu, 29 Jan 2015 21:50:49 +0100
Message-Id: <1422564649-32210-2-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1422564649-32210-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1422564649-32210-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/gatt.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index 23ffb9e..5f3050f 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -1491,7 +1491,6 @@ static void connect_cb(GIOChannel *io, GError *gerr, gpointer user_data)
 	GError *err = NULL;
 	GAttrib *attrib;
 	uint16_t mtu;
-	uint16_t cid;
 
 	if (dev->state != DEVICE_CONNECT_READY) {
 		error("gatt: Device not in a connecting state!?");
@@ -1511,8 +1510,7 @@ static void connect_cb(GIOChannel *io, GError *gerr, gpointer user_data)
 		goto reply;
 	}
 
-	if (!bt_io_get(io, &err, BT_IO_OPT_IMTU, &mtu, BT_IO_OPT_CID, &cid,
-							BT_IO_OPT_INVALID)) {
+	if (!bt_io_get(io, &err, BT_IO_OPT_IMTU, &mtu, BT_IO_OPT_INVALID)) {
 		error("gatt: Could not get imtu: %s", err->message);
 		device_set_state(dev, DEVICE_DISCONNECTED);
 		status = GATT_FAILURE;
-- 
1.8.4

