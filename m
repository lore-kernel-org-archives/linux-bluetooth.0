Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv0] Bluetooth: General HCI callback implementation
Date: Fri,  9 Dec 2011 15:10:48 +0200
Message-Id: <1323436248-3736-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Add general HCI callback implementation. Can be used for executing
HCI commands from A2MP protocol.
---
 include/net/bluetooth/hci_core.h |   14 +++++++++++
 net/bluetooth/hci_core.c         |   47 ++++++++++++++++++++++++++++++++++++++
 net/bluetooth/hci_event.c        |    4 +++
 3 files changed, 65 insertions(+), 0 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index cc5481d..e473cd2 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -121,6 +121,15 @@ struct adv_entry {
 	u8 bdaddr_type;
 };
 
+struct hci_dev;
+
+struct cb_cmd {
+	struct list_head list;
+	u16 opcode;
+	void *opt;
+	void (*cb)(struct hci_dev *hdev, void *opt);
+};
+
 #define NUM_REASSEMBLY 4
 struct hci_dev {
 	struct list_head list;
@@ -228,6 +237,7 @@ struct hci_dev {
 	__u16			init_last_cmd;
 
 	struct list_head	mgmt_pending;
+	struct list_head	cb_list;
 
 	struct inquiry_cache	inq_cache;
 	struct hci_conn_hash	conn_hash;
@@ -1037,4 +1047,8 @@ void hci_le_ltk_neg_reply(struct hci_conn *conn);
 int hci_do_inquiry(struct hci_dev *hdev, u8 length);
 int hci_cancel_inquiry(struct hci_dev *hdev);
 
+struct cb_cmd *hci_find_cb(struct hci_dev *hdev, __u16 opcode);
+int hci_cmd_cb(struct hci_dev *hdev, __u16 opcode, __u32 plen, void *param,
+		void (*cb)(struct hci_dev *hdev, void *opt), void *opt);
+
 #endif /* __HCI_CORE_H */
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index ff56cd3..8416593 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1560,6 +1560,8 @@ int hci_register_dev(struct hci_dev *hdev)
 
 	INIT_LIST_HEAD(&hdev->mgmt_pending);
 
+	INIT_LIST_HEAD(&hdev->cb_list);
+
 	INIT_LIST_HEAD(&hdev->blacklist);
 
 	INIT_LIST_HEAD(&hdev->uuids);
@@ -2033,6 +2035,51 @@ int hci_send_cmd(struct hci_dev *hdev, __u16 opcode, __u32 plen, void *param)
 	return 0;
 }
 
+void hci_add_cb(struct hci_dev *hdev, __u16 opcode,
+		void (*cb)(struct hci_dev *hdev, void *opt), void *opt)
+{
+	struct cb_cmd *cmd;
+
+	cmd = kmalloc(sizeof(*cmd), GFP_ATOMIC);
+	if (!cmd)
+		return;
+
+	cmd->cb = cb;
+	cmd->opcode = opcode;
+	cmd->opt = opt;
+
+	list_add(&cmd->list, &hdev->cb_list);
+}
+
+struct cb_cmd *hci_find_cb(struct hci_dev *hdev, __u16 opcode)
+{
+	struct cb_cmd *cmd;
+
+	list_for_each_entry(cmd, &hdev->cb_list, list)
+		if (cmd->opcode == opcode)
+			return cmd;
+
+	return NULL;
+}
+
+static void hci_remove_cb(struct cb_cmd *cmd)
+{
+	list_del(&cmd->list);
+
+	kfree(cmd->opt);
+	kfree(cmd);
+}
+
+/* Send HCI command with callback */
+int hci_cmd_cb(struct hci_dev *hdev, __u16 opcode, __u32 plen, void *param,
+		void (*cb)(struct hci_dev *hdev, void *opt), void *opt)
+{
+	if (cb)
+		hci_add_cb(hdev, opcode, cb, opt);
+
+	return hci_send_cmd(hdev, opcode, plen, param);
+}
+
 /* Get data from the previously sent command */
 void *hci_sent_cmd_data(struct hci_dev *hdev, __u16 opcode)
 {
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 8fb1a54..03d1b25 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1945,6 +1945,7 @@ static inline void hci_qos_setup_complete_evt(struct hci_dev *hdev, struct sk_bu
 static inline void hci_cmd_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	struct hci_ev_cmd_complete *ev = (void *) skb->data;
+	struct cb_cmd *cmd;
 	__u16 opcode;
 
 	skb_pull(skb, sizeof(*ev));
@@ -2074,6 +2075,9 @@ static inline void hci_cmd_complete_evt(struct hci_dev *hdev, struct sk_buff *sk
 
 	case HCI_OP_READ_LOCAL_AMP_INFO:
 		hci_cc_read_local_amp_info(hdev, skb);
+		cmd = hci_find_cb(hdev, opcode);
+		if (cmd)
+			cmd->cb(hdev, cmd->opt);
 		break;
 
 	case HCI_OP_DELETE_STORED_LINK_KEY:
-- 
1.7.4.1

