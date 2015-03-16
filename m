Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Add clarifying comment when setting local OOB flag
Date: Mon, 16 Mar 2015 21:12:34 +0200
Message-Id: <1426533154-10483-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

It might be a bit counterintuitive to set a 'local' flag based on remote
data. This patch adds a clarifying comment to the pairing req/rsp
handlers when setting the LOCAL_OOB flag based on the PDU received from
the remote side.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/smp.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 82824213d0fb..1bd281060de2 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -1735,6 +1735,10 @@ static u8 smp_cmd_pairing_req(struct l2cap_conn *conn, struct sk_buff *skb)
 	memcpy(&smp->preq[1], req, sizeof(*req));
 	skb_pull(skb, sizeof(*req));
 
+	/* If the remote side's OOB flag is set it means it has
+	 * successfully received our local OOB data - therefore set the
+	 * flag to indicate that local OOB is in use.
+	 */
 	if (req->oob_flag == SMP_OOB_PRESENT)
 		set_bit(SMP_FLAG_LOCAL_OOB, &smp->flags);
 
@@ -1902,6 +1906,10 @@ static u8 smp_cmd_pairing_rsp(struct l2cap_conn *conn, struct sk_buff *skb)
 	if (hci_dev_test_flag(hdev, HCI_SC_ONLY) && !(auth & SMP_AUTH_SC))
 		return SMP_AUTH_REQUIREMENTS;
 
+	/* If the remote side's OOB flag is set it means it has
+	 * successfully received our local OOB data - therefore set the
+	 * flag to indicate that local OOB is in use.
+	 */
 	if (rsp->oob_flag == SMP_OOB_PRESENT)
 		set_bit(SMP_FLAG_LOCAL_OOB, &smp->flags);
 
-- 
2.1.0

