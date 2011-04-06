Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [RFC 05/15] Bluetooth: Reject an encryption request when the key isn't found
Date: Tue,  5 Apr 2011 23:11:18 -0300
Message-Id: <1302055888-28177-6-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1302055888-28177-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1302055888-28177-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Now that we have methods to finding keys by its parameters we can
reject an encryption request if the key isn't found.

Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
---
 net/bluetooth/hci_event.c |   18 ++++++++++++++++--
 1 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index ce06d97..7282c39 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -2631,21 +2631,35 @@ static inline void hci_le_ltk_request_evt(struct hci_dev *hdev,
 {
 	struct hci_ev_le_ltk_req *ev = (void *) skb->data;
 	struct hci_cp_le_ltk_reply cp;
+	struct hci_cp_le_ltk_neg_reply neg;
 	struct hci_conn *conn;
+	struct link_key *ltk;
 
 	BT_DBG("%s handle %d", hdev->name, cpu_to_le16(ev->handle));
 
 	hci_dev_lock(hdev);
 
 	conn = hci_conn_hash_lookup_handle(hdev, __le16_to_cpu(ev->handle));
+	if (conn == NULL)
+		goto not_found;
+
+	ltk = hci_find_ltk(hdev, ev->ediv, ev->random);
+	if (ltk == NULL)
+		goto not_found;
 
-	memset(&cp, 0, sizeof(cp));
+	memcpy(cp.ltk, ltk->val, sizeof(ltk->val));
 	cp.handle = cpu_to_le16(conn->handle);
-	memcpy(cp.ltk, conn->ltk, sizeof(conn->ltk));
 
 	hci_send_cmd(hdev, HCI_OP_LE_LTK_REPLY, sizeof(cp), &cp);
 
 	hci_dev_unlock(hdev);
+
+	return;
+
+not_found:
+	neg.handle = ev->handle;
+	hci_send_cmd(hdev, HCI_OP_LE_LTK_NEG_REPLY, sizeof(neg), &neg);
+	hci_dev_unlock(hdev);
 }
 
 static inline void hci_le_adv_report_evt(struct hci_dev *hdev,
-- 
1.7.4.1

