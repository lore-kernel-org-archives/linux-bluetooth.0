Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 03/12] Bluetooth: Fix HCI_CONN_AUTH_PEND flag for all authentication requests
Date: Thu, 28 Apr 2011 11:28:55 -0700
Message-Id: <1304015344-12238-3-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1304015344-12238-1-git-send-email-johan.hedberg@gmail.com>
References: <1304015344-12238-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@nokia.com>

The HCI_CONN_AUTH_PEND flag should be set whenever requesting
authentication so that multiple pending requests can't occur.

Signed-off-by: Johan Hedberg <johan.hedberg@nokia.com>
---
 net/bluetooth/hci_event.c |   22 ++++++++++++++++++----
 1 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index a479389..94c1296 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1021,12 +1021,19 @@ static void hci_cs_remote_name_req(struct hci_dev *hdev, __u8 status)
 	hci_dev_lock(hdev);
 
 	conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK, &cp->bdaddr);
-	if (conn && hci_outgoing_auth_needed(hdev, conn)) {
+	if (!conn)
+		goto unlock;
+
+	if (!hci_outgoing_auth_needed(hdev, conn))
+		goto unlock;
+
+	if (!test_and_set_bit(HCI_CONN_AUTH_PEND, &conn->pend)) {
 		struct hci_cp_auth_requested cp;
-		cp.handle = __cpu_to_le16(conn->handle);
+		cp.handle = cpu_to_le16(conn->handle);
 		hci_send_cmd(hdev, HCI_OP_AUTH_REQUESTED, sizeof(cp), &cp);
 	}
 
+unlock:
 	hci_dev_unlock(hdev);
 }
 
@@ -1516,12 +1523,19 @@ static inline void hci_remote_name_evt(struct hci_dev *hdev, struct sk_buff *skb
 		mgmt_remote_name(hdev->id, &ev->bdaddr, ev->name);
 
 	conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK, &ev->bdaddr);
-	if (conn && hci_outgoing_auth_needed(hdev, conn)) {
+	if (!conn)
+		goto unlock;
+
+	if (!hci_outgoing_auth_needed(hdev, conn))
+		goto unlock;
+
+	if (!test_and_set_bit(HCI_CONN_AUTH_PEND, &conn->pend)) {
 		struct hci_cp_auth_requested cp;
-		cp.handle = __cpu_to_le16(conn->handle);
+		cp.handle = cpu_to_le16(conn->handle);
 		hci_send_cmd(hdev, HCI_OP_AUTH_REQUESTED, sizeof(cp), &cp);
 	}
 
+unlock:
 	hci_dev_unlock(hdev);
 }
 
-- 
1.7.4.4

