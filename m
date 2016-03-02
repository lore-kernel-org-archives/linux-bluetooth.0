Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: josephsih@chromium.org
To: linux-bluetooth@vger.kernel.org
Cc: luiz.von.dentz@intel.com
Subject: [PATCH] shared/att: change security as needed
Date: Wed,  2 Mar 2016 21:28:39 +0800
Message-Id: <1456925319-16594-1-git-send-email-josephsih@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Joseph Hwang <josephsih@chromium.org>

When pairing with a BLE keyboard, bluetoothd suffers from
authentication errors as follows:

ERR bluetoothd[1103]: Report Map read failed:
                    Attribute requires authentication before read/write
ERR bluetoothd[1103]: Protocol Mode characteristic read failed:
                    Attribute requires authentication before read/write
ERR bluetoothd[1103]: HID Information read failed:
                    Attribute requires authentication before read/write

This is because the original security level is BT_ATT_SECURITY_LOW,
while BT_ATT_SECURITY_HIGH is required for pairing. This patch enables
the security elevation so that handle_error_rsp() could push the
operation back to request queue properly.

---
 src/shared/att.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/src/shared/att.c b/src/shared/att.c
index 3a84783..331fae7 100644
--- a/src/shared/att.c
+++ b/src/shared/att.c
@@ -574,9 +574,6 @@ static bool change_security(struct bt_att *att, uint8_t ecode)
 	int security;
 
 	security = bt_att_get_security(att);
-	if (security != BT_ATT_SECURITY_AUTO)
-		return false;
-
 	if (ecode == BT_ATT_ERROR_INSUFFICIENT_ENCRYPTION &&
 					security < BT_ATT_SECURITY_MEDIUM)
 		security = BT_ATT_SECURITY_MEDIUM;
-- 
2.7.0.rc3.207.g0ac5344

