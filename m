Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/5] Bluetooth: Track not yet received keys in SMP
Date: Wed, 26 Feb 2014 23:33:43 +0200
Message-Id: <1393450427-12438-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

To make is easier to track which keys we've received and which ones
we're still waiting for simply clear the corresponding key bits from
smp->remote_key_dist as they get received. This will allow us to
simplify the code for checking for SMP completion in subsequent patches.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/smp.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 50355d045992..fe41df5c320c 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -948,6 +948,9 @@ static int smp_cmd_master_ident(struct l2cap_conn *conn, struct sk_buff *skb)
 	if (!(smp->remote_key_dist & SMP_DIST_ENC_KEY))
 		return 0;
 
+	/* Mark the information as received */
+	smp->remote_key_dist &= ~SMP_DIST_ENC_KEY;
+
 	skb_pull(skb, sizeof(*rp));
 
 	hci_dev_lock(hdev);
@@ -1001,6 +1004,9 @@ static int smp_cmd_ident_addr_info(struct l2cap_conn *conn,
 	if (!(smp->remote_key_dist & SMP_DIST_ID_KEY))
 		return 0;
 
+	/* Mark the information as received */
+	smp->remote_key_dist &= ~SMP_DIST_ID_KEY;
+
 	skb_pull(skb, sizeof(*info));
 
 	/* Strictly speaking the Core Specification (4.1) allows sending
-- 
1.8.5.3

