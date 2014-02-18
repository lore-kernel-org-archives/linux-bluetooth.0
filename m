Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 9/9] Bluetooth: Fix properly ignoring unexpected SMP PDUs
Date: Tue, 18 Feb 2014 10:19:37 +0200
Message-Id: <1392711577-31431-9-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1392711577-31431-1-git-send-email-johan.hedberg@gmail.com>
References: <1392711577-31431-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

If we didn't request certain pieces of information during the key
distribution negotiation we should properly ignore those PDUs if the
peer incorrectly sends them. This includes the Encryption Information
and Master Identification PDUs if the EncKey bit was not set, and the
Identity Information and Identity Address Information PDUs if the IdKey
bit was not set.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/smp.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 024baa789eb9..5867c1c3f436 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -891,6 +891,10 @@ static int smp_cmd_encrypt_info(struct l2cap_conn *conn, struct sk_buff *skb)
 	if (skb->len < sizeof(*rp))
 		return SMP_UNSPECIFIED;
 
+	/* Ignore this PDU if it wasn't requested */
+	if (!(smp->remote_key_dist & SMP_DIST_ENC_KEY))
+		return 0;
+
 	skb_pull(skb, sizeof(*rp));
 
 	memcpy(smp->tk, rp->ltk, sizeof(smp->tk));
@@ -911,6 +915,10 @@ static int smp_cmd_master_ident(struct l2cap_conn *conn, struct sk_buff *skb)
 	if (skb->len < sizeof(*rp))
 		return SMP_UNSPECIFIED;
 
+	/* Ignore this PDU if it wasn't requested */
+	if (!(smp->remote_key_dist & SMP_DIST_ENC_KEY))
+		return 0;
+
 	skb_pull(skb, sizeof(*rp));
 
 	hci_dev_lock(hdev);
@@ -935,6 +943,10 @@ static int smp_cmd_ident_info(struct l2cap_conn *conn, struct sk_buff *skb)
 	if (skb->len < sizeof(*info))
 		return SMP_UNSPECIFIED;
 
+	/* Ignore this PDU if it wasn't requested */
+	if (!(smp->remote_key_dist & SMP_DIST_ID_KEY))
+		return 0;
+
 	skb_pull(skb, sizeof(*info));
 
 	memcpy(smp->irk, info->irk, 16);
@@ -955,6 +967,10 @@ static int smp_cmd_ident_addr_info(struct l2cap_conn *conn,
 	if (skb->len < sizeof(*info))
 		return SMP_UNSPECIFIED;
 
+	/* Ignore this PDU if it wasn't requested */
+	if (!(smp->remote_key_dist & SMP_DIST_ID_KEY))
+		return 0;
+
 	skb_pull(skb, sizeof(*info));
 
 	bacpy(&smp->id_addr, &info->bdaddr);
-- 
1.8.5.3

