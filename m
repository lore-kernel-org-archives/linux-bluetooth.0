Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/3] Bluetooth: Fix using HCI_CONN_LE_SMP_PEND to check for SMP context
Date: Fri,  8 Aug 2014 09:28:05 +0300
Message-Id: <1407479285-4261-4-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1407479285-4261-1-git-send-email-johan.hedberg@gmail.com>
References: <1407479285-4261-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The code is consistently using the HCI_CONN_LE_SMP_PEND flag check for
the existence of the SMP context, with the exception of this one place
in smp_sig_channel(). This patch converts the place to use the flag just
like all other instances.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/smp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 40db728f044b..33016ec9b247 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -1206,7 +1206,7 @@ int smp_sig_channel(struct l2cap_conn *conn, struct sk_buff *skb)
 	 * returns an error).
 	 */
 	if (code != SMP_CMD_PAIRING_REQ && code != SMP_CMD_SECURITY_REQ &&
-	    !conn->smp_chan) {
+	    !test_bit(HCI_CONN_LE_SMP_PEND, &hcon->flags)) {
 		BT_ERR("Unexpected SMP command 0x%02x. Disconnecting.", code);
 		kfree_skb(skb);
 		return -EOPNOTSUPP;
-- 
1.9.3

