Return-Path: <john@metanate.com>
From: John Keeping <john@metanate.com>
To: linux-bluetooth@vger.kernel.org
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Gustavo Padovan <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	John Keeping <john@metanate.com>
Subject: [PATCH v2 3/3] Bluetooth: SMP: Fail gracefully if device doesn't support pairing
Date: Tue, 13 Jun 2017 17:28:59 +0100
Message-Id: <20170613162859.25769-4-john@metanate.com>
In-Reply-To: <20170613162859.25769-1-john@metanate.com>
References: <20170613162859.25769-1-john@metanate.com>
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
 net/bluetooth/smp.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 5c8b1f28d354..a53335114d79 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -813,7 +813,10 @@ static void smp_failure(struct l2cap_conn *conn, u8 reason)
 		smp_send_cmd(conn, SMP_CMD_PAIRING_FAIL, sizeof(reason),
 			     &reason);
 
-	mgmt_auth_failed(hcon, MGMT_STATUS_AUTH_FAILED);
+	if (reason == SMP_PAIRING_NOTSUPP)
+		mgmt_auth_failed(hcon, MGMT_STATUS_NOT_SUPPORTED);
+	else
+		mgmt_auth_failed(hcon, MGMT_STATUS_AUTH_FAILED);
 
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
