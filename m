Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv3 31/34] Bluetooth: General HCI callback implementation
Date: Thu, 19 Jan 2012 11:20:20 +0200
Message-Id: <1326964823-26747-32-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1326964823-26747-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1326964823-26747-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Add general HCI callback implementation. Can be used for executing
HCI commands from A2MP protocol.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 include/net/bluetooth/hci_core.h |   18 ++++++++++++
 net/bluetooth/hci_core.c         |   57 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 75 insertions(+), 0 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 039d8b1..4ee2065 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -125,6 +125,17 @@ struct adv_entry {
 	u8 bdaddr_type;
 };
 
+struct hci_dev;
+
+struct cb_cmd {
+	struct list_head list;
+	u16 opcode;
+	u8 status;
+	void *opt;
+	void (*cb)(struct hci_dev *hdev, struct cb_cmd *cmd);
+	void (*destructor)(struct cb_cmd *cmd);
+};
+
 #define NUM_REASSEMBLY 4
 struct hci_dev {
 	struct list_head list;
@@ -231,6 +242,7 @@ struct hci_dev {
 	__u16			init_last_cmd;
 
 	struct list_head	mgmt_pending;
+	struct list_head	cb_list;
 
 	struct discovery_state	discovery;
 	struct hci_conn_hash	conn_hash;
@@ -1029,4 +1041,10 @@ void hci_le_ltk_neg_reply(struct hci_conn *conn);
 int hci_do_inquiry(struct hci_dev *hdev, u8 length);
 int hci_cancel_inquiry(struct hci_dev *hdev);
 
+struct cb_cmd *hci_find_cb(struct hci_dev *hdev, __u16 opcode);
+int hci_cmd_cb(struct hci_dev *hdev, __u16 opcode, __u32 plen, void *param,
+	void (*cb)(struct hci_dev *hdev, struct cb_cmd *cmd), void *opt,
+				void (*destructor)(struct cb_cmd *cmd));
+void hci_remove_cb(struct cb_cmd *cmd);
+
 #endif /* __HCI_CORE_H */
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 95ece9d..5aefb61 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1678,6 +1678,8 @@ int hci_register_dev(struct hci_dev *hdev)
 
 	INIT_LIST_HEAD(&hdev->mgmt_pending);
 
+	INIT_LIST_HEAD(&hdev->cb_list);
+
 	INIT_LIST_HEAD(&hdev->blacklist);
 
 	INIT_LIST_HEAD(&hdev->uuids);
@@ -2081,6 +2083,61 @@ int hci_send_cmd(struct hci_dev *hdev, __u16 opcode, __u32 plen, void *param)
 	return 0;
 }
 
+void hci_add_cb(struct hci_dev *hdev, __u16 opcode,
+			void (*cb)(struct hci_dev *hdev, struct cb_cmd *cmd),
+			void *opt, void (*destructor)(struct cb_cmd *cmd))
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
+	cmd->status = 0;
+
+	if (destructor)
+		cmd->destructor = destructor;
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
+void hci_remove_cb(struct cb_cmd *cmd)
+{
+	list_del(&cmd->list);
+
+	if (cmd->destructor) {
+		cmd->destructor(cmd);
+	} else {
+		kfree(cmd->opt);
+		kfree(cmd);
+	}
+}
+
+/* Send HCI command with callback */
+int hci_cmd_cb(struct hci_dev *hdev, __u16 opcode, __u32 plen, void *param,
+			void (*cb)(struct hci_dev *hdev, struct cb_cmd *cmd),
+			void *opt, void (*destructor)(struct cb_cmd *cmd))
+{
+	if (cb)
+		hci_add_cb(hdev, opcode, cb, opt, destructor);
+
+	return hci_send_cmd(hdev, opcode, plen, param);
+}
+
 /* Get data from the previously sent command */
 void *hci_sent_cmd_data(struct hci_dev *hdev, __u16 opcode)
 {
-- 
1.7.4.1

