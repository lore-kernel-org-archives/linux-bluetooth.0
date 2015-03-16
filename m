Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/4] Bluetooth: Set local OOB data flag if remote has our OOB data
Date: Mon, 16 Mar 2015 11:45:45 +0200
Message-Id: <1426499146-11959-3-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1426499146-11959-1-git-send-email-johan.hedberg@gmail.com>
References: <1426499146-11959-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

If the SMP Pairing Request or Response PDU received from the remote
device indicates that it has received our OOB data we should set the
SMP_FLAG_LOCAL_OOB flag.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/smp.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index c8382f4fcd5c..b8a6ce840603 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -1735,6 +1735,9 @@ static u8 smp_cmd_pairing_req(struct l2cap_conn *conn, struct sk_buff *skb)
 	memcpy(&smp->preq[1], req, sizeof(*req));
 	skb_pull(skb, sizeof(*req));
 
+	if (req->oob_flag == SMP_OOB_PRESENT)
+		set_bit(SMP_FLAG_LOCAL_OOB, &smp->flags);
+
 	/* SMP over BR/EDR requires special treatment */
 	if (conn->hcon->type == ACL_LINK) {
 		/* We must have a BR/EDR SC link */
@@ -1899,6 +1902,9 @@ static u8 smp_cmd_pairing_rsp(struct l2cap_conn *conn, struct sk_buff *skb)
 	if (hci_dev_test_flag(hdev, HCI_SC_ONLY) && !(auth & SMP_AUTH_SC))
 		return SMP_AUTH_REQUIREMENTS;
 
+	if (rsp->oob_flag == SMP_OOB_PRESENT)
+		set_bit(SMP_FLAG_LOCAL_OOB, &smp->flags);
+
 	smp->prsp[0] = SMP_CMD_PAIRING_RSP;
 	memcpy(&smp->prsp[1], rsp, sizeof(*rsp));
 
-- 
2.1.0

