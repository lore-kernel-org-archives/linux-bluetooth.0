Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluteooth: Reject SMP bonding if HCI_PAIRABLE is not set
Date: Thu, 10 Jul 2014 11:02:07 +0300
Message-Id: <1404979327-9384-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

If the remote device tries to initiate bonding with us and we don't have
HCI_PAIRABLE set we should just flat out reject the request. This brings
SMP in line with how the flag is used for BR/EDR SSP.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/smp.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index fa81a3a9dbaf..4ea31b021714 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -683,6 +683,7 @@ int smp_user_confirm_reply(struct hci_conn *hcon, u16 mgmt_op, __le32 passkey)
 static u8 smp_cmd_pairing_req(struct l2cap_conn *conn, struct sk_buff *skb)
 {
 	struct smp_cmd_pairing rsp, *req = (void *) skb->data;
+	struct hci_dev *hdev = conn->hcon->hdev;
 	struct smp_chan *smp;
 	u8 key_size, auth, sec_level;
 	int ret;
@@ -703,6 +704,10 @@ static u8 smp_cmd_pairing_req(struct l2cap_conn *conn, struct sk_buff *skb)
 	if (!smp)
 		return SMP_UNSPECIFIED;
 
+	if (!test_bit(HCI_PAIRABLE, &hdev->dev_flags) &&
+	    (req->auth_req & SMP_AUTH_BONDING))
+		return SMP_PAIRING_NOTSUPP;
+
 	smp->preq[0] = SMP_CMD_PAIRING_REQ;
 	memcpy(&smp->preq[1], req, sizeof(*req));
 	skb_pull(skb, sizeof(*req));
@@ -918,6 +923,10 @@ static u8 smp_cmd_security_req(struct l2cap_conn *conn, struct sk_buff *skb)
 	if (test_and_set_bit(HCI_CONN_LE_SMP_PEND, &hcon->flags))
 		return 0;
 
+	if (!test_bit(HCI_PAIRABLE, &hcon->hdev->dev_flags) &&
+	    (rp->auth_req & SMP_AUTH_BONDING))
+		return SMP_PAIRING_NOTSUPP;
+
 	smp = smp_chan_create(conn);
 	if (!smp)
 		return SMP_UNSPECIFIED;
-- 
1.9.3

