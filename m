Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 4/5] Bluetooth: Add read_info management command
Date: Mon, 13 Dec 2010 21:07:06 +0200
Message-Id: <1292267227-22028-5-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1292267227-22028-1-git-send-email-johan.hedberg@gmail.com>
References: <1292267227-22028-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@nokia.com>

This patch implements the read_info command which is used to fetch basic
info about an adapter.

Signed-off-by: Johan Hedberg <johan.hedberg@nokia.com>
---
 include/net/bluetooth/mgmt.h |   19 +++++++++
 net/bluetooth/mgmt.c         |   90 ++++++++++++++++++++++++++++++++++++++----
 2 files changed, 101 insertions(+), 8 deletions(-)

diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index c2b4c83..70985aa 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -39,6 +39,25 @@ struct mgmt_rp_read_index_list {
 	__le16 index[0];
 } __packed;
 
+#define MGMT_OP_READ_INFO		0x0004
+struct mgmt_cp_read_info {
+	__le16 index;
+} __packed;
+struct mgmt_rp_read_info {
+	__le16 index;
+	__u8 type;
+	__u8 powered;
+	__u8 discoverable;
+	__u8 pairable;
+	__u8 sec_mode;
+	bdaddr_t bdaddr;
+	__u8 dev_class[3];
+	__u8 features[8];
+	__u16 manufacturer;
+	__u8 hci_ver;
+	__u16 hci_rev;
+} __packed;
+
 #define MGMT_EV_CMD_COMPLETE		0x0001
 struct mgmt_ev_cmd_complete {
 	__le16 opcode;
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 7a8e321..d6c5a32 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -32,6 +32,33 @@
 #define MGMT_VERSION	0
 #define MGMT_REVISION	1
 
+static int cmd_status(struct sock *sk, u16 cmd, u8 status)
+{
+	struct sk_buff *skb;
+	struct mgmt_hdr *hdr;
+	struct mgmt_ev_cmd_status *ev;
+
+	BT_DBG("sock %p", sk);
+
+	skb = alloc_skb(sizeof(*hdr) + sizeof(*ev), GFP_ATOMIC);
+	if (!skb)
+		return -ENOMEM;
+
+	hdr = (void *) skb_put(skb, sizeof(*hdr));
+
+	hdr->opcode = cpu_to_le16(MGMT_EV_CMD_STATUS);
+	hdr->len = cpu_to_le16(sizeof(*ev));
+
+	ev = (void *) skb_put(skb, sizeof(*ev));
+	ev->status = status;
+	put_unaligned_le16(cmd, &ev->opcode);
+
+	if (sock_queue_rcv_skb(sk, skb) < 0)
+		kfree_skb(skb);
+
+	return 0;
+}
+
 static int read_version(struct sock *sk)
 {
 	struct sk_buff *skb;
@@ -112,26 +139,70 @@ static int read_index_list(struct sock *sk)
 	return 0;
 }
 
-static int cmd_status(struct sock *sk, u16 cmd, u8 status)
+static int read_controller_info(struct sock *sk, unsigned char *data, u16 len)
 {
 	struct sk_buff *skb;
 	struct mgmt_hdr *hdr;
-	struct mgmt_ev_cmd_status *ev;
+	struct mgmt_ev_cmd_complete *ev;
+	struct mgmt_rp_read_info *rp;
+	struct mgmt_cp_read_info *cp;
+	struct hci_dev *hdev;
+	u16 dev_id;
 
 	BT_DBG("sock %p", sk);
 
-	skb = alloc_skb(sizeof(*hdr) + sizeof(*ev), GFP_ATOMIC);
+	if (len != 2)
+		return cmd_status(sk, MGMT_OP_READ_INFO, EINVAL);
+
+	skb = alloc_skb(sizeof(*hdr) + sizeof(*ev) + sizeof(*rp), GFP_ATOMIC);
 	if (!skb)
 		return -ENOMEM;
 
 	hdr = (void *) skb_put(skb, sizeof(*hdr));
-
-	hdr->opcode = cpu_to_le16(MGMT_EV_CMD_STATUS);
-	hdr->len = cpu_to_le16(sizeof(*ev));
+	hdr->opcode = cpu_to_le16(MGMT_EV_CMD_COMPLETE);
+	hdr->len = cpu_to_le16(sizeof(*ev) + sizeof(*rp));
 
 	ev = (void *) skb_put(skb, sizeof(*ev));
-	ev->status = status;
-	put_unaligned_le16(cmd, &ev->opcode);
+	put_unaligned_le16(MGMT_OP_READ_INFO, &ev->opcode);
+
+	rp = (void *) skb_put(skb, sizeof(*rp));
+
+	cp = (void *) data;
+	dev_id = get_unaligned_le16(&cp->index);
+
+	BT_DBG("request for hci%u", dev_id);
+
+	hdev = hci_dev_get(dev_id);
+	if (!hdev) {
+		kfree_skb(skb);
+		return cmd_status(sk, MGMT_OP_READ_INFO, ENODEV);
+	}
+
+	hci_dev_lock_bh(hdev);
+
+	put_unaligned_le16(hdev->id, &rp->index);
+	rp->type = hdev->dev_type;
+
+	rp->powered = test_bit(HCI_UP, &hdev->flags);
+	rp->discoverable = test_bit(HCI_ISCAN, &hdev->flags);
+	rp->pairable = test_bit(HCI_PSCAN, &hdev->flags);
+
+	if (test_bit(HCI_AUTH, &hdev->flags))
+		rp->sec_mode = 3;
+	else if (hdev->ssp_mode > 0)
+		rp->sec_mode = 4;
+	else
+		rp->sec_mode = 2;
+
+	bacpy(&rp->bdaddr, &hdev->bdaddr);
+	memcpy(rp->features, hdev->features, 8);
+	memcpy(rp->dev_class, hdev->dev_class, 3);
+	put_unaligned_le16(hdev->manufacturer, &rp->manufacturer);
+	rp->hci_ver = hdev->hci_ver;
+	put_unaligned_le16(hdev->hci_rev, &rp->hci_rev);
+
+	hci_dev_unlock_bh(hdev);
+	hci_dev_put(hdev);
 
 	if (sock_queue_rcv_skb(sk, skb) < 0)
 		kfree_skb(skb);
@@ -176,6 +247,9 @@ int mgmt_control(struct sock *sk, struct msghdr *msg, size_t msglen)
 	case MGMT_OP_READ_INDEX_LIST:
 		err = read_index_list(sk);
 		break;
+	case MGMT_OP_READ_INFO:
+		err = read_controller_info(sk, buf + sizeof(*hdr), len);
+		break;
 	default:
 		BT_DBG("Unknown op %u", opcode);
 		err = cmd_status(sk, opcode, 0x01);
-- 
1.7.2.3

