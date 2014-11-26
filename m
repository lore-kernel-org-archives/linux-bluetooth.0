Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 4/4] android/gatt: Set proper MTU for BR/EDR link
Date: Wed, 26 Nov 2014 09:47:40 +0100
Message-Id: <1416991660-21828-4-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1416991660-21828-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1416991660-21828-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Minimum mtu depends on transport layer and is larger for BREDR link.
---
 android/gatt.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index b9b3c7b..95ddba0 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -1439,7 +1439,7 @@ static void connect_cb(GIOChannel *io, GError *gerr, gpointer user_data)
 	uint32_t status;
 	GAttrib *attrib;
 	uint16_t mtu;
-	uint16_t cid;
+	uint8_t dst_type;
 
 	if (dev->state != DEVICE_CONNECT_READY) {
 		error("gatt: Device not in a connecting state!?");
@@ -1459,9 +1459,11 @@ static void connect_cb(GIOChannel *io, GError *gerr, gpointer user_data)
 		goto reply;
 	}
 
-	if (!bt_io_get(io, &gerr, BT_IO_OPT_IMTU, &mtu, BT_IO_OPT_CID, &cid,
-				BT_IO_OPT_INVALID) || cid == ATT_CID)
-		mtu = ATT_DEFAULT_LE_MTU;
+	mtu = ATT_DEFAULT_LE_MTU;
+
+	if (bt_io_get(io, &gerr, BT_IO_OPT_DEST_TYPE, &dst_type,
+			BT_IO_OPT_INVALID) && (dst_type == BDADDR_BREDR))
+		mtu = ATT_DEFAULT_L2CAP_MTU;
 
 	attrib = g_attrib_new(io, mtu);
 	if (!attrib) {
-- 
1.9.1

