Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <par-gunnar.p.hjalmdahl@stericsson.com>,
	<henrik.possung@stericsson.com>,
	Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH v3 4/5] Bluetooth: Add add/remove_remote_oob_data management commands
Date: Mon, 21 Mar 2011 14:07:00 +0100
Message-ID: <1300712821-23172-5-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1300712821-23172-1-git-send-email-szymon.janc@tieto.com>
References: <1300712821-23172-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds commands to add and remove remote OOB data to the managment
interface. Remote data is stored in kernel and can be used by corresponding
HCI commands and events when needed.

Signed-off-by: Szymon Janc <szymon.janc@tieto.com>
---
 include/net/bluetooth/hci.h      |   19 ++++++++++
 include/net/bluetooth/hci_core.h |   16 ++++++++
 include/net/bluetooth/mgmt.h     |   12 ++++++
 net/bluetooth/hci_core.c         |   67 ++++++++++++++++++++++++++++++++++
 net/bluetooth/hci_event.c        |   34 +++++++++++++++++
 net/bluetooth/mgmt.c             |   75 ++++++++++++++++++++++++++++++++++++++
 6 files changed, 223 insertions(+), 0 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 0ac0804..8c71e88 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -428,6 +428,20 @@ struct hci_rp_user_confirm_reply {
 
 #define HCI_OP_USER_CONFIRM_NEG_REPLY	0x042d
 
+
+#define HCI_OP_REMOTE_OOB_DATA_REPLY	0x0430
+struct hci_cp_remote_oob_data_reply {
+	bdaddr_t bdaddr;
+	__u8     hash[16];
+	__u8     randomizer[16];
+} __packed;
+
+#define HCI_OP_REMOTE_OOB_DATA_NEG_REPLY	0x0433
+struct hci_cp_remote_oob_data_neg_reply {
+	bdaddr_t bdaddr;
+} __packed;
+
+
 #define HCI_OP_IO_CAPABILITY_NEG_REPLY	0x0434
 struct hci_cp_io_capability_neg_reply {
 	bdaddr_t bdaddr;
@@ -964,6 +978,11 @@ struct hci_ev_user_confirm_req {
 	__le32		passkey;
 } __packed;
 
+#define HCI_EV_REMOTE_OOB_DATA_REQUEST	0x35
+struct hci_ev_remote_oob_data_request {
+	bdaddr_t bdaddr;
+} __packed;
+
 #define HCI_EV_SIMPLE_PAIR_COMPLETE	0x36
 struct hci_ev_simple_pair_complete {
 	__u8     status;
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index fd9b8a3..87bff51 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -82,6 +82,13 @@ struct link_key {
 	u8 pin_len;
 };
 
+struct oob_data {
+	struct list_head list;
+	bdaddr_t bdaddr;
+	u8 hash[16];
+	u8 randomizer[16];
+};
+
 #define NUM_REASSEMBLY 4
 struct hci_dev {
 	struct list_head list;
@@ -169,6 +176,8 @@ struct hci_dev {
 
 	struct list_head	link_keys;
 
+	struct list_head	remote_oob_data;
+
 	struct hci_dev_stats	stat;
 
 	struct sk_buff_head	driver_init;
@@ -505,6 +514,13 @@ int hci_add_link_key(struct hci_dev *hdev, int new_key, bdaddr_t *bdaddr,
 						u8 *key, u8 type, u8 pin_len);
 int hci_remove_link_key(struct hci_dev *hdev, bdaddr_t *bdaddr);
 
+int hci_remote_oob_data_clear(struct hci_dev *hdev);
+struct oob_data *hci_find_remote_oob_data(struct hci_dev *hdev,
+							bdaddr_t *bdaddr);
+int hci_add_remote_oob_data(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 *hash,
+								u8 *randomizer);
+int hci_remove_remote_oob_data(struct hci_dev *hdev, bdaddr_t *bdaddr);
+
 void hci_del_off_timer(struct hci_dev *hdev);
 
 void hci_event_packet(struct hci_dev *hdev, struct sk_buff *skb);
diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index 6ebb126..1a6283f 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -183,6 +183,18 @@ struct mgmt_rp_read_local_oob_data {
 	__u8 randomizer[16];
 } __packed;
 
+#define MGMT_OP_ADD_REMOTE_OOB_DATA	0x0019
+struct mgmt_cp_add_remote_oob_data {
+	bdaddr_t bdaddr;
+	__u8 hash[16];
+	__u8 randomizer[16];
+} __packed;
+
+#define MGMT_OP_REMOVE_REMOTE_OOB_DATA	0x001A
+struct mgmt_cp_remove_remote_oob_data {
+	bdaddr_t bdaddr;
+} __packed;
+
 #define MGMT_EV_CMD_COMPLETE		0x0001
 struct mgmt_ev_cmd_complete {
 	__le16 opcode;
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 1f11fe3..1fa9ce5 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1080,6 +1080,70 @@ static void hci_cmd_timer(unsigned long arg)
 	tasklet_schedule(&hdev->cmd_task);
 }
 
+struct oob_data *hci_find_remote_oob_data(struct hci_dev *hdev,
+							bdaddr_t *bdaddr)
+{
+	struct oob_data *data;
+
+	list_for_each_entry(data, &hdev->remote_oob_data, list)
+		if (bacmp(bdaddr, &data->bdaddr) == 0)
+			return data;
+
+	return NULL;
+}
+
+int hci_remove_remote_oob_data(struct hci_dev *hdev, bdaddr_t *bdaddr)
+{
+	struct oob_data *data;
+
+	data = hci_find_remote_oob_data(hdev, bdaddr);
+	if (!data)
+		return -ENOENT;
+
+	BT_DBG("%s removing %s", hdev->name, batostr(bdaddr));
+
+	list_del(&data->list);
+	kfree(data);
+
+	return 0;
+}
+
+int hci_remote_oob_data_clear(struct hci_dev *hdev)
+{
+	struct oob_data *data, *n;
+
+	list_for_each_entry_safe(data, n, &hdev->remote_oob_data, list) {
+		list_del(&data->list);
+		kfree(data);
+	}
+
+	return 0;
+}
+
+int hci_add_remote_oob_data(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 *hash,
+								u8 *randomizer)
+{
+	struct oob_data *data;
+
+	data = hci_find_remote_oob_data(hdev, bdaddr);
+
+	if (!data) {
+		data = kmalloc(sizeof(*data), GFP_ATOMIC);
+		if (!data)
+			return -ENOMEM;
+
+		bacpy(&data->bdaddr, bdaddr);
+		list_add(&data->list, &hdev->remote_oob_data);
+	}
+
+	memcpy(data->hash, hash, 16);
+	memcpy(data->randomizer, randomizer, 16);
+
+	BT_DBG("%s for %s", hdev->name, batostr(bdaddr));
+
+	return 0;
+}
+
 /* Register HCI device */
 int hci_register_dev(struct hci_dev *hdev)
 {
@@ -1144,6 +1208,8 @@ int hci_register_dev(struct hci_dev *hdev)
 
 	INIT_LIST_HEAD(&hdev->link_keys);
 
+	INIT_LIST_HEAD(&hdev->remote_oob_data);
+
 	INIT_WORK(&hdev->power_on, hci_power_on);
 	INIT_WORK(&hdev->power_off, hci_power_off);
 	setup_timer(&hdev->off_timer, hci_auto_off, (unsigned long) hdev);
@@ -1223,6 +1289,7 @@ int hci_unregister_dev(struct hci_dev *hdev)
 	hci_blacklist_clear(hdev);
 	hci_uuids_clear(hdev);
 	hci_link_keys_clear(hdev);
+	hci_remote_oob_data_clear(hdev);
 	hci_dev_unlock_bh(hdev);
 
 	__hci_dev_put(hdev);
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 0223b38..fba5998 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -2473,6 +2473,37 @@ static inline void hci_remote_host_features_evt(struct hci_dev *hdev, struct sk_
 	hci_dev_unlock(hdev);
 }
 
+static inline void hci_remote_oob_data_request_evt(struct hci_dev *hdev,
+							struct sk_buff *skb)
+{
+	struct hci_ev_remote_oob_data_request *ev = (void *) skb->data;
+	struct oob_data *data;
+
+	BT_DBG("%s", hdev->name);
+
+	hci_dev_lock(hdev);
+
+	data = hci_find_remote_oob_data(hdev, &ev->bdaddr);
+	if (data) {
+		struct hci_cp_remote_oob_data_reply cp;
+
+		bacpy(&cp.bdaddr, &ev->bdaddr);
+		memcpy(cp.hash, data->hash, 16);
+		memcpy(cp.randomizer, data->randomizer, 16);
+
+		hci_send_cmd(hdev, HCI_OP_REMOTE_OOB_DATA_REPLY, sizeof(cp),
+									&cp);
+	} else {
+		struct hci_cp_remote_oob_data_neg_reply cp;
+
+		bacpy(&cp.bdaddr, &ev->bdaddr);
+		hci_send_cmd(hdev, HCI_OP_REMOTE_OOB_DATA_NEG_REPLY, sizeof(cp),
+									&cp);
+	}
+
+	hci_dev_unlock(hdev);
+}
+
 static inline void hci_le_conn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	struct hci_ev_le_conn_complete *ev = (void *) skb->data;
@@ -2673,6 +2704,9 @@ void hci_event_packet(struct hci_dev *hdev, struct sk_buff *skb)
 
 	case HCI_EV_LE_META:
 		hci_le_meta_evt(hdev, skb);
+
+	case HCI_EV_REMOTE_OOB_DATA_REQUEST:
+		hci_remote_oob_data_request_evt(hdev, skb);
 		break;
 
 	default:
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index a72cbf6..46c96b3 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1349,6 +1349,74 @@ unlock:
 	return err;
 }
 
+static int add_remote_oob_data(struct sock *sk, u16 index, unsigned char *data,
+									u16 len)
+{
+	struct hci_dev *hdev;
+	struct mgmt_cp_add_remote_oob_data *cp = (void *) data;
+	int err;
+
+	BT_DBG("hci%u ", index);
+
+	if (len != sizeof(*cp))
+		return cmd_status(sk, index, MGMT_OP_ADD_REMOTE_OOB_DATA,
+									EINVAL);
+
+	hdev = hci_dev_get(index);
+	if (!hdev)
+		return cmd_status(sk, index, MGMT_OP_ADD_REMOTE_OOB_DATA,
+									ENODEV);
+
+	hci_dev_lock_bh(hdev);
+
+	err = hci_add_remote_oob_data(hdev, &cp->bdaddr, cp->hash,
+								cp->randomizer);
+	if (err < 0)
+		err = cmd_status(sk, index, MGMT_OP_ADD_REMOTE_OOB_DATA, -err);
+	else
+		err = cmd_complete(sk, index, MGMT_OP_ADD_REMOTE_OOB_DATA, NULL,
+									0);
+
+	hci_dev_unlock_bh(hdev);
+	hci_dev_put(hdev);
+
+	return err;
+}
+
+static int remove_remote_oob_data(struct sock *sk, u16 index,
+						unsigned char *data, u16 len)
+{
+	struct hci_dev *hdev;
+	struct mgmt_cp_remove_remote_oob_data *cp = (void *)data;
+	int err;
+
+	BT_DBG("hci%u ", index);
+
+	if (len != sizeof(*cp))
+		return cmd_status(sk, index, MGMT_OP_REMOVE_REMOTE_OOB_DATA,
+									EINVAL);
+
+	hdev = hci_dev_get(index);
+	if (!hdev)
+		return cmd_status(sk, index, MGMT_OP_REMOVE_REMOTE_OOB_DATA,
+									ENODEV);
+
+	hci_dev_lock_bh(hdev);
+
+	err = hci_remove_remote_oob_data(hdev, &cp->bdaddr);
+	if (err < 0)
+		err = cmd_status(sk, index, MGMT_OP_REMOVE_REMOTE_OOB_DATA,
+									-err);
+	else
+		err = cmd_complete(sk, index, MGMT_OP_REMOVE_REMOTE_OOB_DATA,
+								NULL, 0);
+
+	hci_dev_unlock_bh(hdev);
+	hci_dev_put(hdev);
+
+	return err;
+}
+
 int mgmt_control(struct sock *sk, struct msghdr *msg, size_t msglen)
 {
 	unsigned char *buf;
@@ -1450,6 +1518,13 @@ int mgmt_control(struct sock *sk, struct msghdr *msg, size_t msglen)
 	case MGMT_OP_READ_LOCAL_OOB_DATA:
 		err = read_local_oob_data(sk, index);
 		break;
+	case MGMT_OP_ADD_REMOTE_OOB_DATA:
+		err = add_remote_oob_data(sk, index, buf + sizeof(*hdr), len);
+		break;
+	case MGMT_OP_REMOVE_REMOTE_OOB_DATA:
+		err = remove_remote_oob_data(sk, index, buf + sizeof(*hdr),
+									len);
+		break;
 
 	default:
 		BT_DBG("Unknown op %u", opcode);
-- 
1.7.0.4

