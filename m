Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH] shared/gatt-client: Remove stray line.
Date: Tue, 23 Sep 2014 14:02:20 -0700
Message-Id: <1411506140-12207-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Remove copy-paste artifact.
---
 src/shared/gatt-client.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/src/shared/gatt-client.h b/src/shared/gatt-client.h
index 7612a6e..5ad1705 100644
--- a/src/shared/gatt-client.h
+++ b/src/shared/gatt-client.h
@@ -36,7 +36,6 @@
 #define BT_GATT_CHRC_PROP_AUTH				0x40
 #define BT_GATT_CHRC_PROP_EXT_PROP			0x80
 
-/* Client Characteristic Configuration bit field */
 struct bt_gatt_client;
 
 struct bt_gatt_client *bt_gatt_client_new(struct bt_att *att, uint16_t mtu);
-- 
2.1.0.rc2.206.gedb03e5

