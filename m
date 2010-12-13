Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/5] Bluetooth: Add read_index_list management command
Date: Mon, 13 Dec 2010 21:07:05 +0200
Message-Id: <1292267227-22028-4-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1292267227-22028-1-git-send-email-johan.hedberg@gmail.com>
References: <1292267227-22028-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@nokia.com>

This patch implements the read_index_list command through which
userspace can get a list of current adapter indices.

Signed-off-by: Johan Hedberg <johan.hedberg@nokia.com>
---
 include/net/bluetooth/mgmt.h |    6 ++++
 net/bluetooth/mgmt.c         |   53 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 59 insertions(+), 0 deletions(-)

diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index d353d64..c2b4c83 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -33,6 +33,12 @@ struct mgmt_rp_read_version {
 	__le16 revision;
 } __packed;
 
+#define MGMT_OP_READ_INDEX_LIST		0x0003
+struct mgmt_rp_read_index_list {
+	__le16 num_controllers;
+	__le16 index[0];
+} __packed;
+
 #define MGMT_EV_CMD_COMPLETE		0x0001
 struct mgmt_ev_cmd_complete {
 	__le16 opcode;
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 3e24c0b..7a8e321 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -62,6 +62,56 @@ static int read_version(struct sock *sk)
 	return 0;
 }
 
+static int read_index_list(struct sock *sk)
+{
+	struct sk_buff *skb;
+	struct mgmt_hdr *hdr;
+	struct mgmt_ev_cmd_complete *ev;
+	struct mgmt_rp_read_index_list *rp;
+	struct list_head *p;
+	size_t body_len;
+	u16 count;
+	int i;
+
+	BT_DBG("sock %p", sk);
+
+	read_lock(&hci_dev_list_lock);
+
+	count = 0;
+	list_for_each(p, &hci_dev_list) {
+		count++;
+	}
+
+	body_len = sizeof(*ev) + sizeof(*rp) + (2 * count);
+	skb = alloc_skb(sizeof(*hdr) + body_len, GFP_ATOMIC);
+	if (!skb)
+		return -ENOMEM;
+
+	hdr = (void *) skb_put(skb, sizeof(*hdr));
+	hdr->opcode = cpu_to_le16(MGMT_EV_CMD_COMPLETE);
+	hdr->len = cpu_to_le16(body_len);
+
+	ev = (void *) skb_put(skb, sizeof(*ev));
+	put_unaligned_le16(MGMT_OP_READ_INDEX_LIST, &ev->opcode);
+
+	rp = (void *) skb_put(skb, sizeof(*rp) + (2 * count));
+	put_unaligned_le16(count, &rp->num_controllers);
+
+	i = 0;
+	list_for_each(p, &hci_dev_list) {
+		struct hci_dev *d = list_entry(p, struct hci_dev, list);
+		put_unaligned_le16(d->id, &rp->index[i++]);
+		BT_DBG("Added hci%u", d->id);
+	}
+
+	read_unlock(&hci_dev_list_lock);
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
@@ -123,6 +173,9 @@ int mgmt_control(struct sock *sk, struct msghdr *msg, size_t msglen)
 	case MGMT_OP_READ_VERSION:
 		err = read_version(sk);
 		break;
+	case MGMT_OP_READ_INDEX_LIST:
+		err = read_index_list(sk);
+		break;
 	default:
 		BT_DBG("Unknown op %u", opcode);
 		err = cmd_status(sk, opcode, 0x01);
-- 
1.7.2.3

