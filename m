Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Szymon Janc <szymon.janc@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@codecoup.pl>
Subject: [PATCH] shared/att: Fix handling 'Insufficent Authentication' error respone
Date: Thu, 20 Oct 2016 22:14:49 +0200
Message-Id: <1476994489-10860-1-git-send-email-szymon.janc@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

>From Core Specification 4.2 Vol.3 Part C (page 375):

When the link is not encrypted, the error code "Insufficient
Authentication" does not indicate that MITM protection is required.

When unauthenticated pairing has occurred and the link is currently
encrypted, the error code "Insufficient Authentication" indicates that
MITM protection is required.

If LE Secure Connections authenticated pairing is required but LE
legacy pairing has occurred and the link is currently encrypted, the
service request shall be rejected with the error code "Insufficient
Authentication".
---
 src/shared/att.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/src/shared/att.c b/src/shared/att.c
index f1e0f59..3071b51 100644
--- a/src/shared/att.c
+++ b/src/shared/att.c
@@ -603,13 +603,20 @@ static bool change_security(struct bt_att *att, uint8_t ecode)
 	security = bt_att_get_security(att);
 
 	if (ecode == BT_ATT_ERROR_INSUFFICIENT_ENCRYPTION &&
-					security < BT_ATT_SECURITY_MEDIUM)
+					security < BT_ATT_SECURITY_MEDIUM) {
 		security = BT_ATT_SECURITY_MEDIUM;
-	else if (ecode == BT_ATT_ERROR_AUTHENTICATION &&
-					security < BT_ATT_SECURITY_HIGH)
-		security = BT_ATT_SECURITY_HIGH;
-	else
+	} else if (ecode == BT_ATT_ERROR_AUTHENTICATION) {
+		if (security < BT_ATT_SECURITY_MEDIUM)
+			security = BT_ATT_SECURITY_MEDIUM;
+		else if (security < BT_ATT_SECURITY_HIGH)
+			security = BT_ATT_SECURITY_HIGH;
+		else if (security < BT_ATT_SECURITY_FIPS)
+			security = BT_ATT_SECURITY_FIPS;
+		else
+			return false;
+	} else {
 		return false;
+	}
 
 	return bt_att_set_security(att, security);
 }
-- 
2.7.4

