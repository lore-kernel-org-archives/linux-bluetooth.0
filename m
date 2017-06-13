Return-Path: <john@metanate.com>
From: John Keeping <john@metanate.com>
To: linux-bluetooth@vger.kernel.org
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Gustavo Padovan <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	John Keeping <john@metanate.com>
Subject: [PATCH v2 2/3] Bluetooth: pass MGMT_STATUS_* into mgmt_auth_failed()
Date: Tue, 13 Jun 2017 17:28:58 +0100
Message-Id: <20170613162859.25769-3-john@metanate.com>
In-Reply-To: <20170613162859.25769-1-john@metanate.com>
References: <20170613162859.25769-1-john@metanate.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Move the mapping from HCI status to MGMT_STATUS_ into the caller.  The
next patch will handle a case for which no suitable HCI status exists.

Signed-off-by: John Keeping <john@metanate.com>
---
 include/net/bluetooth/hci_core.h | 2 +-
 net/bluetooth/hci_event.c        | 4 ++--
 net/bluetooth/mgmt.c             | 7 +++----
 net/bluetooth/smp.c              | 2 +-
 4 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 1c830730294c..1e3173389f4e 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1498,7 +1498,7 @@ int mgmt_user_passkey_neg_reply_complete(struct hci_dev *hdev, bdaddr_t *bdaddr,
 int mgmt_user_passkey_notify(struct hci_dev *hdev, bdaddr_t *bdaddr,
 			     u8 link_type, u8 addr_type, u32 passkey,
 			     u8 entered);
-void mgmt_auth_failed(struct hci_conn *conn, u8 status);
+void mgmt_auth_failed(struct hci_conn *conn, u8 mgmt_status);
 void mgmt_auth_enable_complete(struct hci_dev *hdev, u8 status);
 void mgmt_ssp_enable_complete(struct hci_dev *hdev, u8 enable, u8 status);
 void mgmt_set_class_of_dev_complete(struct hci_dev *hdev, u8 *dev_class,
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 0b4dba08a14e..f95eda8c647f 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -2440,7 +2440,7 @@ static void hci_auth_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 		if (ev->status == HCI_ERROR_PIN_OR_KEY_MISSING)
 			set_bit(HCI_CONN_AUTH_FAILURE, &conn->flags);
 
-		mgmt_auth_failed(conn, ev->status);
+		mgmt_auth_failed(conn, mgmt_status(ev->status));
 	}
 
 	clear_bit(HCI_CONN_AUTH_PEND, &conn->flags);
@@ -4232,7 +4232,7 @@ static void hci_simple_pair_complete_evt(struct hci_dev *hdev,
 	 * event gets always produced as initiator and is also mapped to
 	 * the mgmt_auth_failed event */
 	if (!test_bit(HCI_CONN_AUTH_PEND, &conn->flags) && ev->status)
-		mgmt_auth_failed(conn, ev->status);
+		mgmt_auth_failed(conn, mgmt_status(ev->status));
 
 	hci_conn_drop(conn);
 
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 69b784fbe691..877028eccead 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -7142,15 +7142,14 @@ int mgmt_user_passkey_notify(struct hci_dev *hdev, bdaddr_t *bdaddr,
 	return mgmt_event(MGMT_EV_PASSKEY_NOTIFY, hdev, &ev, sizeof(ev), NULL);
 }
 
-void mgmt_auth_failed(struct hci_conn *conn, u8 hci_status)
+void mgmt_auth_failed(struct hci_conn *conn, u8 mgmt_status)
 {
 	struct mgmt_ev_auth_failed ev;
 	struct mgmt_pending_cmd *cmd;
-	u8 status = mgmt_status(hci_status);
 
 	bacpy(&ev.addr.bdaddr, &conn->dst);
 	ev.addr.type = link_to_bdaddr(conn->type, conn->dst_type);
-	ev.status = status;
+	ev.status = mgmt_status;
 
 	cmd = find_pairing(conn);
 
@@ -7158,7 +7157,7 @@ void mgmt_auth_failed(struct hci_conn *conn, u8 hci_status)
 		    cmd ? cmd->sk : NULL);
 
 	if (cmd) {
-		cmd->cmd_complete(cmd, status);
+		cmd->cmd_complete(cmd, mgmt_status);
 		mgmt_pending_remove(cmd);
 	}
 }
diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 14585edc9439..5c8b1f28d354 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -813,7 +813,7 @@ static void smp_failure(struct l2cap_conn *conn, u8 reason)
 		smp_send_cmd(conn, SMP_CMD_PAIRING_FAIL, sizeof(reason),
 			     &reason);
 
-	mgmt_auth_failed(hcon, HCI_ERROR_AUTH_FAILURE);
+	mgmt_auth_failed(hcon, MGMT_STATUS_AUTH_FAILED);
 
 	if (chan->data)
 		smp_chan_destroy(conn);
-- 
2.12.2.648.g6730d8bc62.dirty
