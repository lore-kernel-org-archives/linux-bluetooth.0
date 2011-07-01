Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH v2 04/12] Bluetooth: Reject an encryption request when the key isn't found
Date: Fri,  1 Jul 2011 16:07:39 -0300
Message-Id: <1309547267-9514-5-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1309547267-9514-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1309547267-9514-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Now that we have methods to finding keys by its parameters we can
reject an encryption request if the key isn't found.

Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
---
 net/bluetooth/hci_event.c |   18 ++++++++++++++++--
 1 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index ac2c5e8..9c7c370 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -2793,21 +2793,35 @@ static inline void hci_le_ltk_request_evt(struct hci_dev *hdev,
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
 
 static inline void hci_le_meta_evt(struct hci_dev *hdev, struct sk_buff *skb)
-- 
1.7.6

