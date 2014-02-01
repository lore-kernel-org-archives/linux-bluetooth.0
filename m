Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Include security level 4 in connections check
Date: Sat,  1 Feb 2014 11:32:25 -0800
Message-Id: <1391283145-21148-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This check is only used for RFCOMM connections and most likely no
RFCOMM based profile will require security level 4 secure connection
security policy. In case it ever does make sure that seucrity level 4
is treated as sufficient security level.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_conn.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 7ef5bffb61aa..801820f12226 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -860,13 +860,17 @@ int hci_conn_check_secure(struct hci_conn *conn, __u8 sec_level)
 {
 	BT_DBG("hcon %p", conn);
 
-	if (sec_level != BT_SECURITY_HIGH)
-		return 1; /* Accept if non-secure is required */
+	/* Accept if non-secure or higher security level is required */
+	if (sec_level != BT_SECURITY_HIGH && sec_level != BT_SECURITY_FIPS)
+		return 1;
 
-	if (conn->sec_level == BT_SECURITY_HIGH)
+	/* Accept if secure or higher security level is already present */
+	if (conn->sec_level == BT_SECURITY_HIGH ||
+	    conn->sec_level == BT_SECURITY_FIPS)
 		return 1;
 
-	return 0; /* Reject not secure link */
+	/* Reject not secure link */
+	return 0;
 }
 EXPORT_SYMBOL(hci_conn_check_secure);
 
-- 
1.8.5.3

