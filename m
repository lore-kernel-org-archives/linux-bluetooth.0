Return-Path: <cyrus@holtmann.org>
From: Waldemar Rymarkiewicz <waldemar.rymarkiewicz@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Marcel Holtmann <marcel@holtmann.org>, <padovan@profusion.mobi>, Johan
 Hedberg <johan.hedberg@gmail.com>, Waldemar Rymarkiewicz
	<waldemar.rymarkiewicz@tieto.com>, Waldemar Rymarkiewicz
	<waldemar.rymarkiewicz@gmail.com>
Subject: [PATCH v2] Bluetooth: Fix possible NULL pointer dereference
Date: Fri, 23 Sep 2011 10:01:30 +0200
Message-ID: <1316764890-11806-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-bluetooth.vger.kernel.org>

Checking conn->pending_sec_level if there is no connection leads to potential
null pointer dereference. Don't process pin_code_request_event at all if no
connection exists.

Signed-off-by: Waldemar Rymarkiewicz <waldemar.rymarkiewicz@gmail.com>
---
 net/bluetooth/hci_event.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index a520787..10a4569 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -2175,7 +2175,10 @@ static inline void hci_pin_code_request_evt(struct hci_dev *hdev, struct sk_buff
 	hci_dev_lock(hdev);
 
 	conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK, &ev->bdaddr);
-	if (conn && conn->state == BT_CONNECTED) {
+	if (!conn)
+		goto unlock;
+
+	if (conn->state == BT_CONNECTED) {
 		hci_conn_hold(conn);
 		conn->disc_timeout = HCI_PAIRING_TIMEOUT;
 		hci_conn_put(conn);
@@ -2195,6 +2198,7 @@ static inline void hci_pin_code_request_evt(struct hci_dev *hdev, struct sk_buff
 		mgmt_pin_code_request(hdev->id, &ev->bdaddr, secure);
 	}
 
+unlock:
 	hci_dev_unlock(hdev);
 }
 
-- 
1.7.6.3
