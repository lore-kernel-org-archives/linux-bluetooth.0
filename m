Return-Path: <cyrus@holtmann.org>
From: Waldemar Rymarkiewicz <waldemar.rymarkiewicz@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <padovan@profusion.mobi>,
	Waldemar Rymarkiewicz <waldemar.rymarkiewicz@tieto.com>
Subject: [PATCH] Bluetooth: Simplify hci_conn_accept_secure check
Date: Thu, 2 Jun 2011 14:24:52 +0200
Message-ID: <1307017492-5684-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If the link key is secure (authenticated or combination 16 digit)
the sec_level will be always BT_SECURITY_HIGH. Therefore, instead
of checking the link key type simply check the sec_level on the link.

Signed-off-by: Waldemar Rymarkiewicz <waldemar.rymarkiewicz@tieto.com>
---
 net/bluetooth/hci_conn.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 0408a93..37f5a17 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -643,9 +643,7 @@ int hci_conn_check_secure(struct hci_conn *conn, __u8 sec_level)
 	if (sec_level != BT_SECURITY_HIGH)
 		return 1; /* Accept if non-secure is required */
 
-	if (conn->key_type == HCI_LK_AUTH_COMBINATION ||
-			(conn->key_type == HCI_LK_COMBINATION &&
-			conn->pin_length == 16))
+	if (conn->sec_level == BT_SECURITY_HIGH)
 		return 1;
 
 	return 0; /* Reject not secure link */
-- 
1.7.4.1

