Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 02/11] shared/att: Add BT_ATT_SECURITY_AUTO
Date: Tue, 23 Jun 2015 15:53:28 +0300
Message-Id: <1435064017-8178-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1435064017-8178-1-git-send-email-luiz.dentz@gmail.com>
References: <1435064017-8178-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This security level enables auto elevation (on by default), this would be
useful for unit tests since it can now control this behavior (default for
non L2CAP transport is BT_ATT_SECURITY_LOW).
---
 src/shared/att-types.h |  2 +-
 src/shared/att.c       | 10 +++++-----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/src/shared/att-types.h b/src/shared/att-types.h
index ee20992..d474495 100644
--- a/src/shared/att-types.h
+++ b/src/shared/att-types.h
@@ -27,7 +27,7 @@
 #define __packed __attribute__((packed))
 #endif
 
-#define BT_ATT_SECURITY_NONE	0
+#define BT_ATT_SECURITY_AUTO	0
 #define BT_ATT_SECURITY_LOW	1
 #define BT_ATT_SECURITY_MEDIUM	2
 #define BT_ATT_SECURITY_HIGH	3
diff --git a/src/shared/att.c b/src/shared/att.c
index e8be4cc..70f5d72 100644
--- a/src/shared/att.c
+++ b/src/shared/att.c
@@ -581,6 +581,9 @@ static bool change_security(struct bt_att *att, uint8_t ecode)
 	int security;
 
 	security = bt_att_get_security(att);
+	if (security != BT_ATT_SECURITY_AUTO)
+		return false;
+
 	if (ecode == BT_ATT_ERROR_INSUFFICIENT_ENCRYPTION &&
 					security < BT_ATT_SECURITY_MEDIUM)
 		security = BT_ATT_SECURITY_MEDIUM;
@@ -608,10 +611,6 @@ static bool handle_error_rsp(struct bt_att *att, uint8_t *pdu,
 
 	*opcode = rsp->opcode;
 
-	/* Only try to change security on L2CAP */
-	if (!att->io_on_l2cap)
-		return false;
-
 	/* Attempt to change security */
 	if (!change_security(att, rsp->ecode))
 		return false;
@@ -1416,7 +1415,8 @@ bool bt_att_set_security(struct bt_att *att, int level)
 {
 	struct bt_security sec;
 
-	if (!att || level < BT_ATT_SECURITY_LOW || level > BT_ATT_SECURITY_HIGH)
+	if (!att || level < BT_ATT_SECURITY_AUTO ||
+						level > BT_ATT_SECURITY_HIGH)
 		return false;
 
 	if (!att->io_on_l2cap) {
-- 
2.1.0

