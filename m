Return-Path: <john@metanate.com>
From: John Keeping <john@metanate.com>
To: linux-bluetooth@vger.kernel.org
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Gustavo Padovan <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	John Keeping <john@metanate.com>
Subject: [RFC/PATCH] Bluetooth: SMP: Fail gracefully if device doesn't support pairing
Date: Thu,  1 Jun 2017 16:35:50 +0100
Message-Id: <20170601153550.1578-1-john@metanate.com>
List-ID: <linux-bluetooth.vger.kernel.org>

If a device does not support pairing, we have no way of knowing this
except by trying and seeing if it returns a "pairing not supported"
error.

Handle this response specially so that we don't drop the connection when
an attempt at pairing fails because the device doesn't support pairing.
Also pass a specific failure value back to userspace to allow detection
of this case as distinct from an authentication failure during pairing.

Signed-off-by: John Keeping <john@metanate.com>
---
I'm not particularly happy with the use of
HCI_ERROR_PAIRING_NOT_SUPPORTED here since this is actually "pairing
with unit key is not supported" so I don't think it's technically the
right thing to return here.  But I can't see a more appropriate HCI
error to which to map the SMP_PAIRING_NOTSUPP reason.

 include/net/bluetooth/hci.h |  1 +
 net/bluetooth/smp.c         | 23 ++++++++++++++++++++---
 2 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index fe98f0a5bef0..0917385a95eb 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -463,6 +463,7 @@ enum {
 #define HCI_ERROR_PAIRING_NOT_ALLOWED	0x18
 #define HCI_ERROR_INVALID_LL_PARAMS	0x1e
 #define HCI_ERROR_UNSPECIFIED		0x1f
+#define HCI_ERROR_PAIRING_NOT_SUPPORTED	0x29
 #define HCI_ERROR_ADVERTISING_TIMEOUT	0x3c
 
 /* Flow control modes */
diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 14585edc9439..41f246a69178 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -813,7 +813,10 @@ static void smp_failure(struct l2cap_conn *conn, u8 reason)
 		smp_send_cmd(conn, SMP_CMD_PAIRING_FAIL, sizeof(reason),
 			     &reason);
 
-	mgmt_auth_failed(hcon, HCI_ERROR_AUTH_FAILURE);
+	if (reason == SMP_PAIRING_NOTSUPP)
+		mgmt_auth_failed(hcon, HCI_ERROR_PAIRING_NOT_SUPPORTED);
+	else
+		mgmt_auth_failed(hcon, HCI_ERROR_AUTH_FAILURE);
 
 	if (chan->data)
 		smp_chan_destroy(conn);
@@ -1866,6 +1869,17 @@ static u8 smp_cmd_pairing_req(struct l2cap_conn *conn, struct sk_buff *skb)
 	return 0;
 }
 
+static u8 smp_cmd_pairing_fail(struct l2cap_conn *conn, struct sk_buff *skb)
+{
+	struct smp_cmd_pairing_fail *rsp = (void *) skb->data;
+
+	if (skb->len < sizeof(*rsp))
+		return SMP_INVALID_PARAMS;
+
+	skb_pull(skb, sizeof(*rsp));
+	return rsp->reason;
+}
+
 static u8 sc_send_public_key(struct smp_chan *smp)
 {
 	struct hci_dev *hdev = smp->conn->hcon->hdev;
@@ -2864,8 +2878,11 @@ static int smp_sig_channel(struct l2cap_chan *chan, struct sk_buff *skb)
 		break;
 
 	case SMP_CMD_PAIRING_FAIL:
-		smp_failure(conn, 0);
-		err = -EPERM;
+		reason = smp_cmd_pairing_fail(conn, skb);
+		if (reason != SMP_PAIRING_NOTSUPP) {
+			smp_failure(conn, 0);
+			err = -EPERM;
+		}
 		break;
 
 	case SMP_CMD_PAIRING_RSP:
-- 
2.12.2.648.g6730d8bc62.dirty
