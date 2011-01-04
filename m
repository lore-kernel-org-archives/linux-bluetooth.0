Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 10/11] Bluetooth: Implement UUID handling through the management interface
Date: Tue,  4 Jan 2011 12:08:51 +0200
Message-Id: <1294135732-26765-10-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1294135732-26765-1-git-send-email-johan.hedberg@gmail.com>
References: <1294135732-26765-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@nokia.com>

This patch adds methods to the management interface for userspace to
notify the kernel of which services have been registered for specific
adapters. This information is needed for setting the appropriate Class
of Device value as well as the Extended Inquiry Response value. This
patch doesn't actually implement setting of these values but just
provides the storage of the UUIDs so the needed functionality can be
built on top of it.

Signed-off-by: Johan Hedberg <johan.hedberg@nokia.com>
---
 include/net/bluetooth/hci_core.h |   10 +++
 include/net/bluetooth/mgmt.h     |   12 ++++
 net/bluetooth/hci_core.c         |   19 ++++++
 net/bluetooth/mgmt.c             |  120 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 161 insertions(+), 0 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 8d800d9..3008f33 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -66,6 +66,12 @@ struct bdaddr_list {
 	struct list_head list;
 	bdaddr_t bdaddr;
 };
+
+struct bt_uuid {
+	struct list_head list;
+	u8 uuid[16];
+};
+
 #define NUM_REASSEMBLY 4
 struct hci_dev {
 	struct list_head list;
@@ -139,6 +145,8 @@ struct hci_dev {
 	struct hci_conn_hash	conn_hash;
 	struct list_head	blacklist;
 
+	struct list_head	uuids;
+
 	struct hci_dev_stats	stat;
 
 	struct sk_buff_head	driver_init;
@@ -440,6 +448,8 @@ int hci_inquiry(void __user *arg);
 struct bdaddr_list *hci_blacklist_lookup(struct hci_dev *hdev, bdaddr_t *bdaddr);
 int hci_blacklist_clear(struct hci_dev *hdev);
 
+int hci_uuids_clear(struct hci_dev *hdev);
+
 void hci_del_off_timer(struct hci_dev *hdev);
 
 void hci_event_packet(struct hci_dev *hdev, struct sk_buff *skb);
diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index a554802..c118ad3 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -72,6 +72,18 @@ struct mgmt_mode {
 
 #define MGMT_OP_SET_PAIRABLE		0x0008
 
+#define MGMT_OP_ADD_UUID		0x0009
+struct mgmt_cp_add_uuid {
+	__le16 index;
+	__u8 uuid[16];
+} __packed;
+
+#define MGMT_OP_REMOVE_UUID		0x000A
+struct mgmt_cp_remove_uuid {
+	__le16 index;
+	__u8 uuid[16];
+} __packed;
+
 #define MGMT_EV_CMD_COMPLETE		0x0001
 struct mgmt_ev_cmd_complete {
 	__le16 opcode;
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index f01dcea..49590c6 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -955,6 +955,22 @@ void hci_del_off_timer(struct hci_dev *hdev)
 	del_timer(&hdev->off_timer);
 }
 
+int hci_uuids_clear(struct hci_dev *hdev)
+{
+	struct list_head *p, *n;
+
+	list_for_each_safe(p, n, &hdev->uuids) {
+		struct bt_uuid *uuid;
+
+		uuid = list_entry(p, struct bt_uuid, list);
+
+		list_del(p);
+		kfree(uuid);
+	}
+
+	return 0;
+}
+
 /* Register HCI device */
 int hci_register_dev(struct hci_dev *hdev)
 {
@@ -1012,6 +1028,8 @@ int hci_register_dev(struct hci_dev *hdev)
 
 	INIT_LIST_HEAD(&hdev->blacklist);
 
+	INIT_LIST_HEAD(&hdev->uuids);
+
 	INIT_WORK(&hdev->power_on, hci_power_on);
 	INIT_WORK(&hdev->power_off, hci_power_off);
 	setup_timer(&hdev->off_timer, hci_auto_off, (unsigned long) hdev);
@@ -1087,6 +1105,7 @@ int hci_unregister_dev(struct hci_dev *hdev)
 
 	hci_dev_lock_bh(hdev);
 	hci_blacklist_clear(hdev);
+	hci_uuids_clear(hdev);
 	hci_dev_unlock_bh(hdev);
 
 	__hci_dev_put(hdev);
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 04d8ad2..e6d7104 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -569,6 +569,120 @@ failed:
 	return err;
 }
 
+static int uuid_rsp(struct sock *sk, u16 opcode, u16 index)
+{
+	struct mgmt_hdr *hdr;
+	struct mgmt_ev_cmd_complete *ev;
+	struct sk_buff *skb;
+
+	skb = alloc_skb(sizeof(*hdr) + sizeof(*ev) + sizeof(index), GFP_ATOMIC);
+	if (!skb)
+		return -ENOMEM;
+
+	hdr = (void *) skb_put(skb, sizeof(*hdr));
+	hdr->opcode = cpu_to_le16(MGMT_EV_CMD_COMPLETE);
+	hdr->len = cpu_to_le16(sizeof(*ev) + sizeof(index));
+
+	ev = (void *) skb_put(skb, sizeof(*ev));
+	put_unaligned_le16(opcode, &ev->opcode);
+
+	put_unaligned_le16(index, skb_put(skb, sizeof(index)));
+
+	if (sock_queue_rcv_skb(sk, skb) < 0)
+		kfree_skb(skb);
+
+	return 0;
+}
+
+static int add_uuid(struct sock *sk, unsigned char *data, u16 len)
+{
+	struct mgmt_cp_add_uuid *cp;
+	struct hci_dev *hdev;
+	struct bt_uuid *uuid;
+	u16 dev_id;
+	int err;
+
+	cp = (void *) data;
+	dev_id = get_unaligned_le16(&cp->index);
+
+	BT_DBG("request for hci%u", dev_id);
+
+	hdev = hci_dev_get(dev_id);
+	if (!hdev)
+		return cmd_status(sk, MGMT_OP_ADD_UUID, ENODEV);
+
+	hci_dev_lock_bh(hdev);
+
+	uuid = kmalloc(sizeof(*uuid), GFP_ATOMIC);
+	if (!uuid) {
+		err = -ENOMEM;
+		goto failed;
+	}
+
+	memcpy(uuid->uuid, cp->uuid, 16);
+
+	list_add(&uuid->list, &hdev->uuids);
+
+	err = uuid_rsp(sk, MGMT_OP_ADD_UUID, dev_id);
+
+failed:
+	hci_dev_unlock_bh(hdev);
+	hci_dev_put(hdev);
+
+	return err;
+}
+
+static int remove_uuid(struct sock *sk, unsigned char *data, u16 len)
+{
+	struct list_head *p, *n;
+	struct mgmt_cp_add_uuid *cp;
+	struct hci_dev *hdev;
+	u8 bt_uuid_any[] = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };
+	u16 dev_id;
+	int err, found;
+
+	cp = (void *) data;
+	dev_id = get_unaligned_le16(&cp->index);
+
+	BT_DBG("request for hci%u", dev_id);
+
+	hdev = hci_dev_get(dev_id);
+	if (!hdev)
+		return cmd_status(sk, MGMT_OP_REMOVE_UUID, ENODEV);
+
+	hci_dev_lock_bh(hdev);
+
+	if (memcmp(cp->uuid, bt_uuid_any, 16) == 0) {
+		err = hci_uuids_clear(hdev);
+		goto unlock;
+	}
+
+	found = 0;
+
+	list_for_each_safe(p, n, &hdev->uuids) {
+		struct bt_uuid *match = list_entry(p, struct bt_uuid, list);
+
+		if (memcmp(match->uuid, cp->uuid, 16) != 0)
+			continue;
+
+		list_del(&match->list);
+		found++;
+	}
+
+	if (found == 0) {
+		cmd_status(sk, MGMT_OP_REMOVE_UUID, ENOENT);
+		goto unlock;
+	}
+
+	err = uuid_rsp(sk, MGMT_OP_REMOVE_UUID, dev_id);
+
+unlock:
+	hci_dev_unlock_bh(hdev);
+	hci_dev_put(hdev);
+
+	return err;
+}
+
 int mgmt_control(struct sock *sk, struct msghdr *msg, size_t msglen)
 {
 	unsigned char *buf;
@@ -621,6 +735,12 @@ int mgmt_control(struct sock *sk, struct msghdr *msg, size_t msglen)
 	case MGMT_OP_SET_PAIRABLE:
 		err = set_pairable(sk, buf + sizeof(*hdr), len);
 		break;
+	case MGMT_OP_ADD_UUID:
+		err = add_uuid(sk, buf + sizeof(*hdr), len);
+		break;
+	case MGMT_OP_REMOVE_UUID:
+		err = remove_uuid(sk, buf + sizeof(*hdr), len);
+		break;
 	default:
 		BT_DBG("Unknown op %u", opcode);
 		err = cmd_status(sk, opcode, 0x01);
-- 
1.7.2.3

