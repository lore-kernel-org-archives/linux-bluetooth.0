Return-Path: <cyrus@holtmann.org>
From: Anderson Briglia <anderson.briglia@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH 3/6] Bluetooth: Implement the first SMP commands
Date: Fri, 22 Oct 2010 19:56:57 -0400
Message-Id: <1287791820-22693-4-git-send-email-anderson.briglia@openbossa.org>
In-Reply-To: <linux-bluetooth@vger.kernel.org>
References: <linux-bluetooth@vger.kernel.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>

These simple commands will allow the SMP procedure to be started
and terminated with a not supported error. This is the first step
toward something useful.

Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
---
 net/bluetooth/l2cap.c |  117 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 117 insertions(+), 0 deletions(-)

diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
index 1ac44f4..ba87c84 100644
--- a/net/bluetooth/l2cap.c
+++ b/net/bluetooth/l2cap.c
@@ -54,6 +54,7 @@
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
 #include <net/bluetooth/l2cap.h>
+#include <net/bluetooth/smp.h>
 
 #define VERSION "2.15"
 
@@ -307,6 +308,85 @@ static void l2cap_chan_del(struct sock *sk, int err)
 	}
 }
 
+static struct sk_buff *smp_build_cmd(struct l2cap_conn *conn, u8 code,
+							u16 dlen, void *data)
+{
+	struct sk_buff *skb;
+	struct l2cap_hdr *lh;
+	int len;
+
+	len = L2CAP_HDR_SIZE + 1 + dlen;
+
+	if (len > conn->mtu)
+		return NULL;
+
+	skb = bt_skb_alloc(len, GFP_ATOMIC);
+	if (!skb)
+		return NULL;
+
+	lh = (struct l2cap_hdr *) skb_put(skb, L2CAP_HDR_SIZE);
+	lh->len = cpu_to_le16(1 + dlen);
+	lh->cid = cpu_to_le16(L2CAP_CID_SMP);
+
+	memcpy(skb_put(skb, 1), &code, 1);
+
+	memcpy(skb_put(skb, dlen), data, dlen);
+
+	return skb;
+}
+
+static inline void smp_send_cmd(struct l2cap_conn *conn, u8 code, u16 len, void *data)
+{
+	struct sk_buff *skb = smp_build_cmd(conn, code, len, data);
+
+	BT_DBG("code 0x%2.2x", code);
+
+	if (!skb)
+		return;
+
+	hci_send_acl(conn->hcon, skb, 0);
+}
+
+static int smp_conn_security(struct l2cap_conn *conn, __u8 sec_level)
+{
+	__u8 authreq;
+
+	BT_DBG("conn %p hcon %p level 0x%2.2x", conn, conn->hcon, sec_level);
+
+	switch (sec_level) {
+	case BT_SECURITY_MEDIUM:
+		/* Encrypted, no MITM protection */
+		authreq = 0x01;
+		break;
+
+	case BT_SECURITY_HIGH:
+		/* Bonding, MITM protection */
+		authreq = 0x05;
+		break;
+
+	case BT_SECURITY_LOW:
+	default:
+		return 1;
+	}
+
+	if (conn->hcon->link_mode & HCI_LM_MASTER) {
+		struct smp_cmd_pairing cp;
+		cp.io_capability = 0x00;
+		cp.oob_flag = 0x00;
+		cp.max_key_size = 16;
+		cp.init_key_dist = 0x00;
+		cp.resp_key_dist = 0x00;
+		cp.auth_req = authreq;
+		smp_send_cmd(conn, SMP_CMD_PAIRING_REQ, sizeof(cp), &cp);
+	} else {
+		struct smp_cmd_security_req cp;
+		cp.auth_req = authreq;
+		smp_send_cmd(conn, SMP_CMD_SECURITY_REQ, sizeof(cp), &cp);
+	}
+
+	return 0;
+}
+
 /* Service level security */
 static inline int l2cap_check_security(struct sock *sk)
 {
@@ -4562,6 +4642,43 @@ done:
 	return 0;
 }
 
+static inline void smp_sig_channel(struct l2cap_conn *conn, struct sk_buff *skb)
+{
+	__u8 code = skb->data[0];
+	__u8 reason;
+
+	skb_pull(skb, 1);
+
+	switch (code) {
+	case SMP_CMD_PAIRING_REQ:
+		reason = SMP_PAIRING_NOTSUPP;
+		smp_send_cmd(conn, SMP_CMD_PAIRING_FAIL, 1, &reason);
+		l2cap_conn_del(conn->hcon, 0x05);
+		break;
+
+	case SMP_CMD_PAIRING_FAIL:
+		break;
+
+	case SMP_CMD_PAIRING_RSP:
+	case SMP_CMD_PAIRING_CONFIRM:
+	case SMP_CMD_PAIRING_RANDOM:
+	case SMP_CMD_ENCRYPT_INFO:
+	case SMP_CMD_MASTER_IDENT:
+	case SMP_CMD_IDENT_INFO:
+	case SMP_CMD_IDENT_ADDR_INFO:
+	case SMP_CMD_SIGN_INFO:
+	case SMP_CMD_SECURITY_REQ:
+	default:
+		BT_DBG("Unknown command code 0x%2.2x", code);
+
+		reason = SMP_CMD_NOTSUPP;
+		smp_send_cmd(conn, SMP_CMD_PAIRING_FAIL, 1, &reason);
+		l2cap_conn_del(conn->hcon, 0x05);
+	}
+
+	kfree_skb(skb);
+}
+
 static void l2cap_recv_frame(struct l2cap_conn *conn, struct sk_buff *skb)
 {
 	struct l2cap_hdr *lh = (void *) skb->data;
-- 
1.7.0.4

