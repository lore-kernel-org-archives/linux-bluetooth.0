Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/8] shared/att: Add own security definitions
Date: Mon, 27 Apr 2015 16:14:30 +0300
Message-Id: <1430140475-20349-4-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1430140475-20349-1-git-send-email-luiz.dentz@gmail.com>
References: <1430140475-20349-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This defines security level at ATT level so it is not necessary to use
transport specific defines.
---
 src/shared/att-types.h | 5 +++++
 src/shared/att.c       | 2 +-
 unit/test-gatt.c       | 2 +-
 3 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/src/shared/att-types.h b/src/shared/att-types.h
index ce531d1..ea4c009 100644
--- a/src/shared/att-types.h
+++ b/src/shared/att-types.h
@@ -27,6 +27,11 @@
 #define __packed __attribute__((packed))
 #endif
 
+#define BT_ATT_SECURITY_NONE	0
+#define BT_ATT_SECURITY_LOW	1
+#define BT_ATT_SECURITY_MEDIUM	2
+#define BT_ATT_SECURITY_HIGH	3
+
 #define BT_ATT_DEFAULT_LE_MTU	23
 #define BT_ATT_MAX_LE_MTU	517
 #define BT_ATT_MAX_VALUE_LEN	512
diff --git a/src/shared/att.c b/src/shared/att.c
index 3b37cdf..f24da18 100644
--- a/src/shared/att.c
+++ b/src/shared/att.c
@@ -1364,7 +1364,7 @@ bool bt_att_set_sec_level(struct bt_att *att, int level)
 {
 	struct bt_security sec;
 
-	if (!att || level < BT_SECURITY_LOW || level > BT_SECURITY_HIGH)
+	if (!att || level < BT_ATT_SECURITY_LOW || level > BT_ATT_SECURITY_HIGH)
 		return false;
 
 	if (!att->io_on_l2cap) {
diff --git a/unit/test-gatt.c b/unit/test-gatt.c
index 415680b..caaacbd 100644
--- a/unit/test-gatt.c
+++ b/unit/test-gatt.c
@@ -1002,7 +1002,7 @@ static void test_signed_write_seclevel(struct context *context)
 	g_assert(bt_att_set_local_key(context->att, key, local_counter,
 								context));
 
-	g_assert(bt_att_set_sec_level(context->att, BT_SECURITY_MEDIUM));
+	g_assert(bt_att_set_sec_level(context->att, BT_ATT_SECURITY_MEDIUM));
 
 	g_assert(bt_gatt_client_write_without_response(context->client,
 							step->handle,
-- 
2.1.0

