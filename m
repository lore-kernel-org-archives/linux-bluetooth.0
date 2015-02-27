Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 4/6] android/gatt: Fix check if CSRK is authenticated
Date: Fri, 27 Feb 2015 16:01:12 +0100
Message-Id: <1425049274-11552-4-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1425049274-11552-1-git-send-email-szymon.janc@tieto.com>
References: <1425049274-11552-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/gatt.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index 3f98e71..2e3a5c9 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -4683,9 +4683,15 @@ static uint8_t check_device_permissions(struct gatt_device *device,
 		if (!(permissions & GATT_PERM_WRITE_SIGNED))
 				return ATT_ECODE_WRITE_NOT_PERM;
 
-		if ((permissions & GATT_PERM_WRITE_SIGNED_MITM) &&
-						sec_level < BT_SECURITY_HIGH)
+		if (permissions & GATT_PERM_WRITE_SIGNED_MITM) {
+			bool auth;
+
+			if (bt_get_csrk(&device->bdaddr, true, NULL, NULL,
+					&auth) && auth)
+				break;
+
 			return ATT_ECODE_AUTHENTICATION;
+		}
 		break;
 	case ATT_OP_READ_BY_TYPE_REQ:
 	case ATT_OP_READ_REQ:
-- 
1.9.3

