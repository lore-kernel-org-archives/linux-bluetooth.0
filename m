Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ 5/8] shared/att-types: Add attribute permission bitfield definitions.
Date: Mon, 20 Oct 2014 14:00:58 -0700
Message-Id: <1413838861-29956-6-git-send-email-armansito@chromium.org>
In-Reply-To: <1413838861-29956-1-git-send-email-armansito@chromium.org>
References: <1413838861-29956-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

GATT doesn't have a standard way of representing attribute permissions
but coming up with values that can be used consistently among code that
uses shared/att is valuable. This patch introduces macros to represent
attribute permissions in a bitfield, with specific bits assigned to
read and write access, encryption, authentication, and authorization
permissions.
---
 src/shared/att-types.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/src/shared/att-types.h b/src/shared/att-types.h
index b57a5f3..a6b23e4 100644
--- a/src/shared/att-types.h
+++ b/src/shared/att-types.h
@@ -74,6 +74,18 @@
 #define BT_ATT_ERROR_UNSUPPORTED_GROUP_TYPE		0x10
 #define BT_ATT_ERROR_INSUFFICIENT_RESOURCES		0x11
 
+/*
+ * ATT attribute permission bitfield values. Permissions are grouped as
+ * "Access", "Encryption", "Authentication", and "Authorization". A bitmask of
+ * permissions is a byte that encodes a combination of these.
+ */
+#define BT_ATT_PERM_READ	0x01
+#define BT_ATT_PERM_WRITE	0x02
+#define BT_ATT_PERM_ENCRYPT	0x04
+#define BT_ATT_PERM_AUTHEN	0x08
+#define BT_ATT_PERM_AUTHOR	0x10
+#define BT_ATT_PERM_NONE	0x20
+
 /* GATT Characteristic Properties Bitfield values */
 #define BT_GATT_CHRC_PROP_BROADCAST			0x01
 #define BT_GATT_CHRC_PROP_READ				0x02
-- 
2.1.0.rc2.206.gedb03e5

