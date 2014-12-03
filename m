Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 21/49] Bluetooth: Add support for LE SC DHKey check PDU
Date: Wed,  3 Dec 2014 17:02:15 +0200
Message-Id: <1417618963-18010-22-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1417618963-18010-1-git-send-email-johan.hedberg@gmail.com>
References: <1417618963-18010-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

Once we receive the DHKey check PDU it's time to first verify that the
value is correct and then proceed with encrypting the link.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/smp.c | 56 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index bdbfbdba0089..a759105b252c 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -1894,6 +1894,58 @@ static int smp_cmd_public_key(struct l2cap_conn *conn, struct sk_buff *skb)
 	return 0;
 }
 
+static int smp_cmd_dhkey_check(struct l2cap_conn *conn, struct sk_buff *skb)
+{
+	struct smp_cmd_dhkey_check *check = (void *) skb->data;
+	struct l2cap_chan *chan = conn->smp;
+	struct hci_conn *hcon = conn->hcon;
+	struct smp_chan *smp = chan->data;
+	u8 a[7], b[7], *local_addr, *remote_addr;
+	u8 io_cap[3], r[16], e[16];
+	int err;
+
+	BT_DBG("conn %p", conn);
+
+	if (skb->len < sizeof(*check))
+		return SMP_INVALID_PARAMS;
+
+	memcpy(a, &hcon->init_addr, 6);
+	memcpy(b, &hcon->resp_addr, 6);
+	a[6] = hcon->init_addr_type;
+	b[6] = hcon->resp_addr_type;
+
+	if (hcon->out) {
+		local_addr = a;
+		remote_addr = b;
+		memcpy(io_cap, &smp->prsp[1], 3);
+	} else {
+		local_addr = b;
+		remote_addr = a;
+		memcpy(io_cap, &smp->preq[1], 3);
+	}
+
+	memset(r, 0, sizeof(r));
+
+	err = smp_f6(smp->tfm_cmac, smp->mackey, smp->rrnd, smp->prnd, r,
+		     io_cap, remote_addr, local_addr, e);
+	if (err)
+		return SMP_UNSPECIFIED;
+
+	if (memcmp(check->e, e, 16))
+		return SMP_DHKEY_CHECK_FAILED;
+
+	smp->ltk = hci_add_ltk(hcon->hdev, &hcon->dst, hcon->dst_type,
+			       SMP_LTK_P256, 0, smp->tk, smp->enc_key_size,
+			       0, 0);
+
+	if (hcon->out) {
+		hci_le_start_enc(hcon, 0, 0, smp->tk);
+		hcon->enc_key_size = smp->enc_key_size;
+	}
+
+	return 0;
+}
+
 static int smp_sig_channel(struct l2cap_chan *chan, struct sk_buff *skb)
 {
 	struct l2cap_conn *conn = chan->conn;
@@ -1982,6 +2034,10 @@ static int smp_sig_channel(struct l2cap_chan *chan, struct sk_buff *skb)
 		reason = smp_cmd_public_key(conn, skb);
 		break;
 
+	case SMP_CMD_DHKEY_CHECK:
+		reason = smp_cmd_dhkey_check(conn, skb);
+		break;
+
 	default:
 		BT_DBG("Unknown command code 0x%2.2x", code);
 		reason = SMP_CMD_NOTSUPP;
-- 
2.1.0

