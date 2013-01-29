Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Fix handling of unexpected SMP PDUs
Date: Mon, 28 Jan 2013 18:04:06 -0600
Message-Id: <1359417846-5064-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The hdev->smp_chan pointer can be NULL if SMP PDUs arrive at unexpected
moments. To avoid NULL pointer dereferences the code should be checking
for this and simply ignore such PDUs. This patch fixes the issue by
adding the checks into each individual PDU handler. It's done there
instead of a global place since for some PDUs it *is* ok for smp_chan to
be NULL (e.g. pairing request and security request).

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
CC: stable@vger.kernel.org
---
 net/bluetooth/smp.c |   15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 68a9587..30b58a0 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -630,6 +630,9 @@ static u8 smp_cmd_pairing_rsp(struct l2cap_conn *conn, struct sk_buff *skb)
 
 	BT_DBG("conn %p", conn);
 
+	if (!smp)
+		return 0;
+
 	if (!(conn->hcon->link_mode & HCI_LM_MASTER))
 		return SMP_CMD_NOTSUPP;
 
@@ -676,6 +679,9 @@ static u8 smp_cmd_pairing_confirm(struct l2cap_conn *conn, struct sk_buff *skb)
 
 	BT_DBG("conn %p %s", conn, conn->hcon->out ? "master" : "slave");
 
+	if (!smp)
+		return 0;
+
 	memcpy(smp->pcnf, skb->data, sizeof(smp->pcnf));
 	skb_pull(skb, sizeof(smp->pcnf));
 
@@ -699,6 +705,9 @@ static u8 smp_cmd_pairing_random(struct l2cap_conn *conn, struct sk_buff *skb)
 	struct smp_chan *smp = conn->smp_chan;
 	struct hci_dev *hdev = conn->hcon->hdev;
 
+	if (!smp)
+		return 0;
+
 	BT_DBG("conn %p", conn);
 
 	swap128(skb->data, smp->rrnd);
@@ -817,6 +826,9 @@ static int smp_cmd_encrypt_info(struct l2cap_conn *conn, struct sk_buff *skb)
 	struct smp_cmd_encrypt_info *rp = (void *) skb->data;
 	struct smp_chan *smp = conn->smp_chan;
 
+	if (!smp)
+		return 0;
+
 	skb_pull(skb, sizeof(*rp));
 
 	memcpy(smp->tk, rp->ltk, sizeof(smp->tk));
@@ -832,6 +844,9 @@ static int smp_cmd_master_ident(struct l2cap_conn *conn, struct sk_buff *skb)
 	struct hci_conn *hcon = conn->hcon;
 	u8 authenticated;
 
+	if (!smp)
+		return 0;
+
 	skb_pull(skb, sizeof(*rp));
 
 	hci_dev_lock(hdev);
-- 
1.7.10.4

