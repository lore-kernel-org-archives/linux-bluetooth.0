Return-Path: <cyrus@holtmann.org>
From: Waldemar Rymarkiewicz <waldemar.rymarkiewicz@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Johan Hedberg <johan.hedberg@gmail.com>, <padovan@profusion.mobi>,
	Waldemar Rymarkiewicz <waldemar.rymarkiewicz@gmail.com>
Subject: [PATCH] Bluetooth: Fix possible NULL pointer dereference
Date: Thu, 22 Sep 2011 07:58:12 +0200
Message-ID: <1316671092-4387-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
In-Reply-To: <20110921070804.GA5982@elgon.mountain>
References: <20110921070804.GA5982@elgon.mountain>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Waldemar Rymarkiewicz <waldemar.rymarkiewicz@gmail.com>

Checking conn->pending_sec_level if there is no connection leads to potential
null pointer dereference. Don't process pin_code_request_event at all if no
connection exists.

Signed-off-by: Waldemar Rymarkiewicz <waldemar.rymarkiewicz@gmail.com>
---
 net/bluetooth/hci_event.c |   30 ++++++++++++++++--------------
 1 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index a520787..41c2562 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -2175,24 +2175,26 @@ static inline void hci_pin_code_request_evt(struct hci_dev *hdev, struct sk_buff
 	hci_dev_lock(hdev);
 
 	conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK, &ev->bdaddr);
-	if (conn && conn->state == BT_CONNECTED) {
-		hci_conn_hold(conn);
-		conn->disc_timeout = HCI_PAIRING_TIMEOUT;
-		hci_conn_put(conn);
-	}
+	if (conn) {
+		if (conn->state == BT_CONNECTED) {
+			hci_conn_hold(conn);
+			conn->disc_timeout = HCI_PAIRING_TIMEOUT;
+			hci_conn_put(conn);
+		}
 
-	if (!test_bit(HCI_PAIRABLE, &hdev->flags))
-		hci_send_cmd(hdev, HCI_OP_PIN_CODE_NEG_REPLY,
+		if (!test_bit(HCI_PAIRABLE, &hdev->flags))
+			hci_send_cmd(hdev, HCI_OP_PIN_CODE_NEG_REPLY,
 					sizeof(ev->bdaddr), &ev->bdaddr);
-	else if (test_bit(HCI_MGMT, &hdev->flags)) {
-		u8 secure;
+		else if (test_bit(HCI_MGMT, &hdev->flags)) {
+			u8 secure;
 
-		if (conn->pending_sec_level == BT_SECURITY_HIGH)
-			secure = 1;
-		else
-			secure = 0;
+			if (conn->pending_sec_level == BT_SECURITY_HIGH)
+				secure = 1;
+			else
+				secure = 0;
 
-		mgmt_pin_code_request(hdev->id, &ev->bdaddr, secure);
+			mgmt_pin_code_request(hdev->id, &ev->bdaddr, secure);
+		}
 	}
 
 	hci_dev_unlock(hdev);
-- 
1.7.6.3

