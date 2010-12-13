Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/5] Bluetooth: Add read_version management command
Date: Mon, 13 Dec 2010 21:07:04 +0200
Message-Id: <1292267227-22028-3-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1292267227-22028-1-git-send-email-johan.hedberg@gmail.com>
References: <1292267227-22028-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@nokia.com>

This patch implements the initial read_version command that userspace
will use before any other management interface operations.

Signed-off-by: Johan Hedberg <johan.hedberg@nokia.com>
---
 include/net/bluetooth/mgmt.h |    6 ++++++
 net/bluetooth/mgmt.c         |   36 ++++++++++++++++++++++++++++++++++++
 2 files changed, 42 insertions(+), 0 deletions(-)

diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index 95974da..d353d64 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -27,6 +27,12 @@ struct mgmt_hdr {
 } __packed;
 #define MGMT_HDR_SIZE			4
 
+#define MGMT_OP_READ_VERSION		0x0001
+struct mgmt_rp_read_version {
+	__u8 version;
+	__le16 revision;
+} __packed;
+
 #define MGMT_EV_CMD_COMPLETE		0x0001
 struct mgmt_ev_cmd_complete {
 	__le16 opcode;
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 7ea5489..3e24c0b 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -29,6 +29,39 @@
 #include <net/bluetooth/hci_core.h>
 #include <net/bluetooth/mgmt.h>
 
+#define MGMT_VERSION	0
+#define MGMT_REVISION	1
+
+static int read_version(struct sock *sk)
+{
+	struct sk_buff *skb;
+	struct mgmt_hdr *hdr;
+	struct mgmt_ev_cmd_complete *ev;
+	struct mgmt_rp_read_version *rp;
+
+	BT_DBG("sock %p", sk);
+
+	skb = alloc_skb(sizeof(*hdr) + sizeof(*ev) + sizeof(*rp), GFP_ATOMIC);
+	if (!skb)
+		return -ENOMEM;
+
+	hdr = (void *) skb_put(skb, sizeof(*hdr));
+	hdr->opcode = cpu_to_le16(MGMT_EV_CMD_COMPLETE);
+	hdr->len = cpu_to_le16(sizeof(*ev) + sizeof(*rp));
+
+	ev = (void *) skb_put(skb, sizeof(*ev));
+	put_unaligned_le16(MGMT_OP_READ_VERSION, &ev->opcode);
+
+	rp = (void *) skb_put(skb, sizeof(*rp));
+	rp->version = MGMT_VERSION;
+	put_unaligned_le16(MGMT_REVISION, &rp->revision);
+
+	if (sock_queue_rcv_skb(sk, skb) < 0)
+		kfree_skb(skb);
+
+	return 0;
+}
+
 static int cmd_status(struct sock *sk, u16 cmd, u8 status)
 {
 	struct sk_buff *skb;
@@ -87,6 +120,9 @@ int mgmt_control(struct sock *sk, struct msghdr *msg, size_t msglen)
 	}
 
 	switch (opcode) {
+	case MGMT_OP_READ_VERSION:
+		err = read_version(sk);
+		break;
 	default:
 		BT_DBG("Unknown op %u", opcode);
 		err = cmd_status(sk, opcode, 0x01);
-- 
1.7.2.3

