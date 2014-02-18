Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/9] Bluetooth: Fix missing PDU length checks for SMP
Date: Tue, 18 Feb 2014 10:19:29 +0200
Message-Id: <1392711577-31431-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

For each received SMP PDU we need to check that we have enough data to
fit the specified size of the PDU. This patch adds the necessary checks
for each SMP PDU handler and ensures that buffer overflows do not occur
if to little data has been received.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/smp.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index efe51ccdc615..1730bb2b6259 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -565,6 +565,9 @@ static u8 smp_cmd_pairing_req(struct l2cap_conn *conn, struct sk_buff *skb)
 
 	BT_DBG("conn %p", conn);
 
+	if (skb->len < sizeof(*req))
+		return SMP_UNSPECIFIED;
+
 	if (conn->hcon->link_mode & HCI_LM_MASTER)
 		return SMP_CMD_NOTSUPP;
 
@@ -617,6 +620,9 @@ static u8 smp_cmd_pairing_rsp(struct l2cap_conn *conn, struct sk_buff *skb)
 
 	BT_DBG("conn %p", conn);
 
+	if (skb->len < sizeof(*rsp))
+		return SMP_UNSPECIFIED;
+
 	if (!(conn->hcon->link_mode & HCI_LM_MASTER))
 		return SMP_CMD_NOTSUPP;
 
@@ -661,6 +667,9 @@ static u8 smp_cmd_pairing_confirm(struct l2cap_conn *conn, struct sk_buff *skb)
 
 	BT_DBG("conn %p %s", conn, conn->hcon->out ? "master" : "slave");
 
+	if (skb->len < sizeof(smp->pcnf))
+		return SMP_UNSPECIFIED;
+
 	memcpy(smp->pcnf, skb->data, sizeof(smp->pcnf));
 	skb_pull(skb, sizeof(smp->pcnf));
 
@@ -686,6 +695,9 @@ static u8 smp_cmd_pairing_random(struct l2cap_conn *conn, struct sk_buff *skb)
 
 	BT_DBG("conn %p", conn);
 
+	if (skb->len < sizeof(smp->rrnd))
+		return SMP_UNSPECIFIED;
+
 	swap128(skb->data, smp->rrnd);
 	skb_pull(skb, sizeof(smp->rrnd));
 
@@ -725,6 +737,9 @@ static u8 smp_cmd_security_req(struct l2cap_conn *conn, struct sk_buff *skb)
 
 	BT_DBG("conn %p", conn);
 
+	if (skb->len < sizeof(*rp))
+		return SMP_UNSPECIFIED;
+
 	if (!(conn->hcon->link_mode & HCI_LM_MASTER))
 		return SMP_CMD_NOTSUPP;
 
@@ -814,6 +829,11 @@ static int smp_cmd_encrypt_info(struct l2cap_conn *conn, struct sk_buff *skb)
 	struct smp_cmd_encrypt_info *rp = (void *) skb->data;
 	struct smp_chan *smp = conn->smp_chan;
 
+	BT_DBG("conn %p", conn);
+
+	if (skb->len < sizeof(*rp))
+		return SMP_UNSPECIFIED;
+
 	skb_pull(skb, sizeof(*rp));
 
 	memcpy(smp->tk, rp->ltk, sizeof(smp->tk));
@@ -829,6 +849,11 @@ static int smp_cmd_master_ident(struct l2cap_conn *conn, struct sk_buff *skb)
 	struct hci_conn *hcon = conn->hcon;
 	u8 authenticated;
 
+	BT_DBG("conn %p", conn);
+
+	if (skb->len < sizeof(*rp))
+		return SMP_UNSPECIFIED;
+
 	skb_pull(skb, sizeof(*rp));
 
 	hci_dev_lock(hdev);
-- 
1.8.5.3

