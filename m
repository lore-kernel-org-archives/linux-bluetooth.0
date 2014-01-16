Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 2/5] Bluetooth: Introduce requirements for security level 4
Date: Wed, 15 Jan 2014 22:37:39 -0800
Message-Id: <1389854262-62467-2-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The security level 4 is a new strong security requirement that is based
around 128-bit equivalent strength for link and encryption keys required
using FIPS approved algorithms. Which means that E0, SAFER+ and P-192
are not allowed. Only connections created with P-256 resulting from
using Secure Connections support are allowed.

This security level needs to be enforced when Secure Connection Only
mode is enabled for a controller or a service requires FIPS compliant
strong security. Currently it is not possible to enable either of
these two cases. This patch just puts in the foundation for being
able to handle security level 4 in the future.

It should be noted that devices or services with security level 4
requirement can only communicate using Bluetooth 4.1 controllers
with support for Secure Connections. There is no backward compatibilty
if used with older hardware.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/bluetooth.h |  1 +
 include/net/bluetooth/hci.h       |  1 +
 net/bluetooth/hci_conn.c          | 18 +++++++++++++-----
 3 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index f4f9ee466791..904777c1cd24 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -65,6 +65,7 @@ struct bt_security {
 #define BT_SECURITY_LOW		1
 #define BT_SECURITY_MEDIUM	2
 #define BT_SECURITY_HIGH	3
+#define BT_SECURITY_FIPS	4
 
 #define BT_DEFER_SETUP	7
 
diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 2bc19881e250..0064a9aa5df1 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -313,6 +313,7 @@ enum {
 #define HCI_LM_TRUSTED	0x0008
 #define HCI_LM_RELIABLE	0x0010
 #define HCI_LM_SECURE	0x0020
+#define HCI_LM_FIPS	0x0040
 
 /* Authentication types */
 #define HCI_AT_NO_BONDING		0x00
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index cf96b3438a91..0266bd8e4913 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -800,10 +800,17 @@ int hci_conn_security(struct hci_conn *conn, __u8 sec_level, __u8 auth_type)
 	if (!(conn->link_mode & HCI_LM_AUTH))
 		goto auth;
 
-	/* An authenticated combination key has sufficient security for any
-	   security level. */
-	if (conn->key_type == HCI_LK_AUTH_COMBINATION_P192 ||
-	    conn->key_type == HCI_LK_AUTH_COMBINATION_P256)
+	/* An authenticated FIPS approved combination key has sufficient
+	 * security for security level 4. */
+	if (conn->key_type == HCI_LK_AUTH_COMBINATION_P256 &&
+	    sec_level == BT_SECURITY_FIPS)
+		goto encrypt;
+
+	/* An authenticated combination key has sufficient security for
+	   security level 3. */
+	if ((conn->key_type == HCI_LK_AUTH_COMBINATION_P192 ||
+	     conn->key_type == HCI_LK_AUTH_COMBINATION_P256) &&
+	    sec_level == BT_SECURITY_HIGH)
 		goto encrypt;
 
 	/* An unauthenticated combination key has sufficient security for
@@ -818,7 +825,8 @@ int hci_conn_security(struct hci_conn *conn, __u8 sec_level, __u8 auth_type)
 	   is generated using maximum PIN code length (16).
 	   For pre 2.1 units. */
 	if (conn->key_type == HCI_LK_COMBINATION &&
-	    (sec_level != BT_SECURITY_HIGH || conn->pin_length == 16))
+	    (sec_level == BT_SECURITY_MEDIUM || sec_level == BT_SECURITY_LOW ||
+	     conn->pin_length == 16))
 		goto encrypt;
 
 auth:
-- 
1.8.4.2

