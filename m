Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <par-gunnar.p.hjalmdahl@stericsson.com>,
	<henrik.possung@stericsson.com>,
	Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 06/10] Bluetooth: Add add/remove_remote_oob_data management commands
Date: Thu, 17 Feb 2011 14:16:37 +0100
Message-ID: <1297948601-12723-7-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1297948601-12723-1-git-send-email-szymon.janc@tieto.com>
References: <1297948601-12723-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds commands to add and remove remote OOB data to the managment
interface. Remote data is stored in kernel and used by corresponding HCI
commands and events (also implemented in this patch) when needed.

Signed-off-by: Szymon Janc <szymon.janc@tieto.com>
---
 include/net/bluetooth/hci.h      |   17 ++++++++
 include/net/bluetooth/hci_core.h |   16 ++++++++
 include/net/bluetooth/mgmt.h     |   14 +++++++
 net/bluetooth/hci_core.c         |   76 ++++++++++++++++++++++++++++++++++++++
 net/bluetooth/hci_event.c        |   41 ++++++++++++++++++++-
 net/bluetooth/mgmt.c             |   73 ++++++++++++++++++++++++++++++++++++
 6 files changed, 236 insertions(+), 1 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 7d1aef9..d1dd7dc 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -415,6 +415,18 @@ struct hci_cp_io_capability_reply {
 	__u8     authentication;
 } __packed;
 
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
 #define HCI_OP_IO_CAPABILITY_NEG_REPLY	0x0434
 struct hci_cp_io_capability_neg_reply {
 	bdaddr_t bdaddr;
@@ -943,6 +955,11 @@ struct hci_ev_io_capa_reply {
 	__u8     authentication;
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
index 704f265..e4f370f 100644
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
@@ -501,6 +510,13 @@ int hci_add_link_key(struct hci_dev *hdev, int new_key, bdaddr_t *bdaddr,
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
index 18e2fb6..9bfd30f 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -174,6 +174,20 @@ struct mgmt_rp_read_local_oob_data_failed {
 	__le16 index;
 } __packed;
 
+#define MGMT_OP_ADD_REMOTE_OOB_DATA	0x0018
+struct mgmt_cp_add_remote_oob_data {
+	__le16 index;
+	bdaddr_t bdaddr;
+	__u8 hash[16];
+	__u8 randomizer[16];
+} __packed;
+
+#define MGMT_OP_REMOVE_REMOTE_OOB_DATA	0x0019
+struct mgmt_cp_remove_remote_oob_data {
+	__le16 index;
+	bdaddr_t bdaddr;
+} __packed;
+
 #define MGMT_EV_CMD_COMPLETE		0x0001
 struct mgmt_ev_cmd_complete {
 	__le16 opcode;
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 702d565..0f5bbb0 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1078,6 +1078,79 @@ static void hci_cmd_timer(unsigned long arg)
 	tasklet_schedule(&hdev->cmd_task);
 }
 
+struct oob_data *hci_find_remote_oob_data(struct hci_dev *hdev,
+							bdaddr_t *bdaddr)
+{
+	struct list_head *p;
+
+	list_for_each(p, &hdev->remote_oob_data) {
+		struct oob_data *data;
+
+		data = list_entry(p, struct oob_data, list);
+
+		if (bacmp(bdaddr, &data->bdaddr) == 0)
+			return data;
+	}
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
+	struct list_head *p, *n;
+
+	list_for_each_safe(p, n, &hdev->remote_oob_data) {
+		struct oob_data *data;
+
+		data = list_entry(p, struct oob_data, list);
+
+		list_del(p);
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
@@ -1142,6 +1215,8 @@ int hci_register_dev(struct hci_dev *hdev)
 
 	INIT_LIST_HEAD(&hdev->link_keys);
 
+	INIT_LIST_HEAD(&hdev->remote_oob_data);
+
 	INIT_WORK(&hdev->power_on, hci_power_on);
 	INIT_WORK(&hdev->power_off, hci_power_off);
 	setup_timer(&hdev->off_timer, hci_auto_off, (unsigned long) hdev);
@@ -1221,6 +1296,7 @@ int hci_unregister_dev(struct hci_dev *hdev)
 	hci_blacklist_clear(hdev);
 	hci_uuids_clear(hdev);
 	hci_link_keys_clear(hdev);
+	hci_remote_oob_data_clear(hdev);
 	hci_dev_unlock_bh(hdev);
 
 	__hci_dev_put(hdev);
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 053fcf7..b39c9bb 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -2333,9 +2333,14 @@ static inline void hci_io_capa_request_evt(struct hci_dev *hdev, struct sk_buff
 
 		bacpy(&cp.bdaddr, &ev->bdaddr);
 		cp.capability = conn->io_capability;
-		cp.oob_data = 0;
 		cp.authentication = hci_get_auth_req(conn);
 
+		if ((conn->out == 1 || conn->remote_oob == 0x01) &&
+				hci_find_remote_oob_data(hdev, &conn->dst))
+			cp.oob_data = 0x01;
+		else
+			cp.oob_data = 0x00;
+
 		hci_send_cmd(hdev, HCI_OP_IO_CAPABILITY_REPLY,
 							sizeof(cp), &cp);
 	} else {
@@ -2407,6 +2412,37 @@ static inline void hci_remote_host_features_evt(struct hci_dev *hdev, struct sk_
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
@@ -2603,6 +2639,9 @@ void hci_event_packet(struct hci_dev *hdev, struct sk_buff *skb)
 
 	case HCI_EV_LE_META:
 		hci_le_meta_evt(hdev, skb);
+
+	case HCI_EV_REMOTE_OOB_DATA_REQUEST:
+		hci_remote_oob_data_request_evt(hdev, skb);
 		break;
 
 	default:
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 2847934..571cbcf 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1112,6 +1112,73 @@ unlock:
 	return err;
 }
 
+static int add_remote_oob_data(struct sock *sk, unsigned char *data, u16 len)
+{
+	struct hci_dev *hdev;
+	struct mgmt_cp_add_remote_oob_data *cp;
+	u16 dev_id;
+	int err;
+
+	cp = (void *) data;
+	dev_id = get_unaligned_le16(&cp->index);
+
+	BT_DBG("hci%u ", dev_id);
+
+	hdev = hci_dev_get(dev_id);
+	if (!hdev)
+		return cmd_status(sk, MGMT_OP_ADD_REMOTE_OOB_DATA, ENODEV, NULL,
+									0);
+
+	hci_dev_lock_bh(hdev);
+
+	err = hci_add_remote_oob_data(hdev, &cp->bdaddr, cp->hash,
+								cp->randomizer);
+	if (err < 0)
+		err = cmd_status(sk, MGMT_OP_ADD_REMOTE_OOB_DATA, -err, NULL,
+									0);
+	else
+		err = cmd_complete(sk, MGMT_OP_ADD_REMOTE_OOB_DATA, &dev_id,
+								sizeof(dev_id));
+
+	hci_dev_unlock_bh(hdev);
+	hci_dev_put(hdev);
+
+	return err;
+}
+
+static int remove_remote_oob_data(struct sock *sk, unsigned char *data, u16 len)
+{
+	struct hci_dev *hdev;
+	struct mgmt_cp_remove_remote_oob_data *cp;
+	u16 dev_id;
+	int err;
+
+	cp = (void *) data;
+	dev_id = get_unaligned_le16(&cp->index);
+
+	BT_DBG("hci%u ", dev_id);
+
+	hdev = hci_dev_get(dev_id);
+	if (!hdev)
+		return cmd_status(sk, MGMT_OP_REMOVE_REMOTE_OOB_DATA, ENODEV,
+								NULL, 0);
+
+	hci_dev_lock_bh(hdev);
+
+	err = hci_remove_remote_oob_data(hdev, &cp->bdaddr);
+	if (err < 0)
+		err = cmd_status(sk, MGMT_OP_REMOVE_REMOTE_OOB_DATA, -err, NULL,
+									0);
+	else
+		err = cmd_complete(sk, MGMT_OP_REMOVE_REMOTE_OOB_DATA, &dev_id,
+								sizeof(dev_id));
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
@@ -1200,6 +1267,12 @@ int mgmt_control(struct sock *sk, struct msghdr *msg, size_t msglen)
 	case MGMT_OP_READ_LOCAL_OOB_DATA:
 		err = read_local_oob_data(sk, buf + sizeof(*hdr), len);
 		break;
+	case MGMT_OP_ADD_REMOTE_OOB_DATA:
+		err = add_remote_oob_data(sk, buf + sizeof(*hdr), len);
+		break;
+	case MGMT_OP_REMOVE_REMOTE_OOB_DATA:
+		err = remove_remote_oob_data(sk, buf + sizeof(*hdr), len);
+		break;
 	default:
 		BT_DBG("Unknown op %u", opcode);
 		err = cmd_status(sk, opcode, 0x01, NULL, 0);
-- 
1.7.0.4

