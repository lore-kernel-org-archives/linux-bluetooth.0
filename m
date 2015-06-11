Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/5] Bluetooth: Move SC-only check outside of BT_CONFIG branch
Date: Thu, 11 Jun 2015 13:52:28 +0300
Message-Id: <1434019950-24959-4-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1434019950-24959-1-git-send-email-johan.hedberg@gmail.com>
References: <1434019950-24959-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

Checking for SC-only mode requirements when we get an encrypt change
event shouldn't be limited to the BT_CONFIG state but done any time
encryption changes.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_event.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index fcbfa4138eb1..62934151431b 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -2650,22 +2650,22 @@ static void hci_encrypt_change_evt(struct hci_dev *hdev, struct sk_buff *skb)
 		goto unlock;
 	}
 
+	/* In Secure Connections Only mode, do not allow any connections
+	 * that are not encrypted with AES-CCM using a P-256 authenticated
+	 * combination key.
+	 */
+	if (hci_dev_test_flag(hdev, HCI_SC_ONLY) &&
+	    (!test_bit(HCI_CONN_AES_CCM, &conn->flags) ||
+	     conn->key_type != HCI_LK_AUTH_COMBINATION_P256)) {
+		hci_connect_cfm(conn, HCI_ERROR_AUTH_FAILURE);
+		hci_conn_drop(conn);
+		goto unlock;
+	}
+
 	if (conn->state == BT_CONFIG) {
 		if (!ev->status)
 			conn->state = BT_CONNECTED;
 
-		/* In Secure Connections Only mode, do not allow any
-		 * connections that are not encrypted with AES-CCM
-		 * using a P-256 authenticated combination key.
-		 */
-		if (hci_dev_test_flag(hdev, HCI_SC_ONLY) &&
-		    (!test_bit(HCI_CONN_AES_CCM, &conn->flags) ||
-		     conn->key_type != HCI_LK_AUTH_COMBINATION_P256)) {
-			hci_connect_cfm(conn, HCI_ERROR_AUTH_FAILURE);
-			hci_conn_drop(conn);
-			goto unlock;
-		}
-
 		hci_connect_cfm(conn, ev->status);
 		hci_conn_drop(conn);
 	} else
-- 
2.4.3

