Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] shared/gatt-client: Fix not detecting BT_ATT_SECURITY_AUTO
Date: Thu,  3 Mar 2016 13:46:46 +0200
Message-Id: <1457005606-13728-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Using bt_gatt_security cannot detect if BT_ATT_SECURITY_AUTO is enabled
since it actually checks the current level when operating over L2CAP, so
instead use io_sec_level internal field to detect the security level in
which ATT is supposed to be operating.
---
 src/shared/att.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/src/shared/att.c b/src/shared/att.c
index 3a84783..7b20757 100644
--- a/src/shared/att.c
+++ b/src/shared/att.c
@@ -573,10 +573,11 @@ static bool change_security(struct bt_att *att, uint8_t ecode)
 {
 	int security;
 
-	security = bt_att_get_security(att);
-	if (security != BT_ATT_SECURITY_AUTO)
+	if (att->io_sec_level != BT_ATT_SECURITY_AUTO)
 		return false;
 
+	security = bt_att_get_security(att);
+
 	if (ecode == BT_ATT_ERROR_INSUFFICIENT_ENCRYPTION &&
 					security < BT_ATT_SECURITY_MEDIUM)
 		security = BT_ATT_SECURITY_MEDIUM;
@@ -979,7 +980,7 @@ struct bt_att *bt_att_new(int fd, bool ext_signed)
 
 	att->io_on_l2cap = is_io_l2cap_based(att->fd);
 	if (!att->io_on_l2cap)
-		att->io_sec_level = BT_SECURITY_LOW;
+		att->io_sec_level = BT_ATT_SECURITY_LOW;
 
 	return bt_att_ref(att);
 
-- 
2.5.0

