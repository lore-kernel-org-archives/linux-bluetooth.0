Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ 4/8] shared/att-types: Move GATT characteristic property defines to att-types.
Date: Mon, 20 Oct 2014 14:00:57 -0700
Message-Id: <1413838861-29956-5-git-send-email-armansito@chromium.org>
In-Reply-To: <1413838861-29956-1-git-send-email-armansito@chromium.org>
References: <1413838861-29956-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch moves GATT characteristic property macros from gatt-client to
att-types. att-types is a logical place for these since gatt-server will
make use of them as well.
---
 src/shared/att-types.h   | 14 ++++++++++++++
 src/shared/gatt-client.h |  9 ---------
 2 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/src/shared/att-types.h b/src/shared/att-types.h
index b85c969..b57a5f3 100644
--- a/src/shared/att-types.h
+++ b/src/shared/att-types.h
@@ -73,3 +73,17 @@
 #define BT_ATT_ERROR_INSUFFICIENT_ENCRYPTION		0x0F
 #define BT_ATT_ERROR_UNSUPPORTED_GROUP_TYPE		0x10
 #define BT_ATT_ERROR_INSUFFICIENT_RESOURCES		0x11
+
+/* GATT Characteristic Properties Bitfield values */
+#define BT_GATT_CHRC_PROP_BROADCAST			0x01
+#define BT_GATT_CHRC_PROP_READ				0x02
+#define BT_GATT_CHRC_PROP_WRITE_WITHOUT_RESP		0x04
+#define BT_GATT_CHRC_PROP_WRITE				0x08
+#define BT_GATT_CHRC_PROP_NOTIFY			0x10
+#define BT_GATT_CHRC_PROP_INDICATE			0x20
+#define BT_GATT_CHRC_PROP_AUTH				0x40
+#define BT_GATT_CHRC_PROP_EXT_PROP			0x80
+
+/* GATT Characteristic Extended Properties Bitfield values */
+#define BT_GATT_CHRC_EXT_PROP_RELIABLE_WRITE	0x01
+#define BT_GATT_CHRC_EXT_PROP_WRITABLE_AUX	0x02
diff --git a/src/shared/gatt-client.h b/src/shared/gatt-client.h
index 6807f6b..6b8719f 100644
--- a/src/shared/gatt-client.h
+++ b/src/shared/gatt-client.h
@@ -27,15 +27,6 @@
 
 #define BT_GATT_UUID_SIZE 16
 
-#define BT_GATT_CHRC_PROP_BROADCAST			0x01
-#define BT_GATT_CHRC_PROP_READ				0x02
-#define BT_GATT_CHRC_PROP_WRITE_WITHOUT_RESP		0x04
-#define BT_GATT_CHRC_PROP_WRITE				0x08
-#define BT_GATT_CHRC_PROP_NOTIFY			0x10
-#define BT_GATT_CHRC_PROP_INDICATE			0x20
-#define BT_GATT_CHRC_PROP_AUTH				0x40
-#define BT_GATT_CHRC_PROP_EXT_PROP			0x80
-
 struct bt_gatt_client;
 
 struct bt_gatt_client *bt_gatt_client_new(struct bt_att *att, uint16_t mtu);
-- 
2.1.0.rc2.206.gedb03e5

