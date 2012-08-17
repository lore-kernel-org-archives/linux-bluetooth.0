Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv1 04/26] Bluetooth: General HCI callback implementation
Date: Fri, 17 Aug 2012 17:32:59 +0300
Message-Id: <1345214001-7053-5-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1345214001-7053-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1340981212-21709-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1345214001-7053-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Add general HCI callback implementation. Can be used for executing
HCI commands from A2MP protocol.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 include/net/bluetooth/hci_core.h |   25 +++++++++
 net/bluetooth/hci_core.c         |  106 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 131 insertions(+)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 5354e7b..3b98640 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -124,6 +124,17 @@ struct le_scan_params {
 
 #define HCI_MAX_SHORT_NAME_LENGTH	10
 
+struct hci_dev;
+
+struct hci_cb_cmd {
+	struct list_head list;
+	u16 opcode;
+	u8 status;
+	void *opt;
+	void (*cb)(struct hci_dev *hdev, struct hci_cb_cmd *cmd);
+	void (*destructor)(struct hci_dev *hdev, struct hci_cb_cmd *cmd);
+};
+
 #define NUM_REASSEMBLY 4
 struct hci_dev {
 	struct list_head list;
@@ -236,6 +247,9 @@ struct hci_dev {
 
 	struct list_head	mgmt_pending;
 
+	struct mutex		cb_list_lock;
+	struct list_head	cb_list;
+
 	struct discovery_state	discovery;
 	struct hci_conn_hash	conn_hash;
 	struct list_head	blacklist;
@@ -1096,5 +1110,16 @@ int hci_le_scan(struct hci_dev *hdev, u8 type, u16 interval, u16 window,
 int hci_cancel_le_scan(struct hci_dev *hdev);
 
 u8 bdaddr_to_le(u8 bdaddr_type);
+struct hci_cb_cmd *hci_callback_find(struct hci_dev *hdev, __u16 opcode);
+int hci_callback_send_cmd(struct hci_dev *hdev, __u16 opcode, __u32 plen,
+			  void *param,
+			  void (*cb)(struct hci_dev *hdev,
+				     struct hci_cb_cmd *cmd),
+			  void *opt,
+			  void (*destructor)(struct hci_dev *hdev,
+					     struct hci_cb_cmd *cmd),
+			  gfp_t flags);
+void hci_callback_remove(struct hci_dev *hdev, struct hci_cb_cmd *cmd);
+void hci_callback_process(struct hci_dev *hdev, __u16 opcode, u8 status);
 
 #endif /* __HCI_CORE_H */
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 42c00d18..a70f933 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -36,6 +36,7 @@
 static void hci_rx_work(struct work_struct *work);
 static void hci_cmd_work(struct work_struct *work);
 static void hci_tx_work(struct work_struct *work);
+static void hci_callback_clear(struct hci_dev *hdev);
 
 /* HCI device list */
 LIST_HEAD(hci_dev_list);
@@ -1644,6 +1645,7 @@ struct hci_dev *hci_alloc_dev(void)
 
 	mutex_init(&hdev->lock);
 	mutex_init(&hdev->req_lock);
+	mutex_init(&hdev->cb_list_lock);
 
 	INIT_LIST_HEAD(&hdev->mgmt_pending);
 	INIT_LIST_HEAD(&hdev->blacklist);
@@ -1651,6 +1653,7 @@ struct hci_dev *hci_alloc_dev(void)
 	INIT_LIST_HEAD(&hdev->link_keys);
 	INIT_LIST_HEAD(&hdev->long_term_keys);
 	INIT_LIST_HEAD(&hdev->remote_oob_data);
+	INIT_LIST_HEAD(&hdev->cb_list);
 
 	INIT_WORK(&hdev->rx_work, hci_rx_work);
 	INIT_WORK(&hdev->cmd_work, hci_cmd_work);
@@ -1816,6 +1819,7 @@ void hci_unregister_dev(struct hci_dev *hdev)
 	hci_link_keys_clear(hdev);
 	hci_smp_ltks_clear(hdev);
 	hci_remote_oob_data_clear(hdev);
+	hci_callback_clear(hdev);
 	hci_dev_unlock(hdev);
 
 	hci_dev_put(hdev);
@@ -2117,6 +2121,108 @@ int hci_send_cmd(struct hci_dev *hdev, __u16 opcode, __u32 plen, void *param)
 	return 0;
 }
 
+static int hci_callback_add(struct hci_dev *hdev, __u16 opcode,
+			    void (*cb)(struct hci_dev *hdev,
+				       struct hci_cb_cmd *cmd),
+			    void *opt,
+			    void (*destructor)(struct hci_dev *hdev,
+					       struct hci_cb_cmd *cmd),
+			    gfp_t flags)
+{
+	struct hci_cb_cmd *cmd;
+
+	cmd = kmalloc(sizeof(*cmd), flags);
+	if (!cmd)
+		return -ENOMEM;
+
+	cmd->cb = cb;
+	cmd->opcode = opcode;
+	cmd->opt = opt;
+	cmd->status = 0;
+	cmd->destructor = destructor;
+
+	mutex_lock(&hdev->cb_list_lock);
+	list_add(&cmd->list, &hdev->cb_list);
+	mutex_unlock(&hdev->cb_list_lock);
+
+	return 0;
+}
+
+struct hci_cb_cmd *hci_callback_find(struct hci_dev *hdev, __u16 opcode)
+{
+	struct hci_cb_cmd *cmd;
+
+	mutex_lock(&hdev->cb_list_lock);
+	list_for_each_entry(cmd, &hdev->cb_list, list)
+		if (cmd->opcode == opcode) {
+			mutex_unlock(&hdev->cb_list_lock);
+			return cmd;
+		}
+	mutex_unlock(&hdev->cb_list_lock);
+
+	return NULL;
+}
+
+void hci_callback_remove(struct hci_dev *hdev, struct hci_cb_cmd *cmd)
+{
+	BT_DBG("%s remove cmd %p", hdev->name, cmd);
+
+	mutex_lock(&hdev->cb_list_lock);
+	list_del(&cmd->list);
+	mutex_unlock(&hdev->cb_list_lock);
+
+	if (cmd->destructor) {
+		cmd->destructor(hdev, cmd);
+	} else {
+		kfree(cmd->opt);
+		kfree(cmd);
+	}
+}
+
+static void hci_callback_clear(struct hci_dev *hdev)
+{
+	struct hci_cb_cmd *cmd, *tmp;
+
+	list_for_each_entry_safe(cmd, tmp, &hdev->cb_list, list)
+		hci_callback_remove(hdev, cmd);
+}
+
+/* Send HCI command with callback */
+int hci_callback_send_cmd(struct hci_dev *hdev, __u16 opcode, __u32 plen,
+			  void *param,
+			  void (*cb)(struct hci_dev *hdev,
+				     struct hci_cb_cmd *cmd),
+			  void *opt,
+			  void (*destructor)(struct hci_dev *hdev,
+					     struct hci_cb_cmd *cmd),
+			  gfp_t flags)
+{
+	int ret;
+
+	if (!cb)
+		return -EINVAL;
+
+	ret = hci_callback_add(hdev, opcode, cb, opt, destructor, flags);
+	if (ret)
+		return ret;
+
+	return hci_send_cmd(hdev, opcode, plen, param);
+}
+
+void hci_callback_process(struct hci_dev *hdev, __u16 opcode, u8 status)
+{
+	struct hci_cb_cmd *cmd;
+
+	cmd = hci_callback_find(hdev, opcode);
+	if (!cmd)
+		return;
+
+	cmd->status = status;
+	cmd->cb(hdev, cmd);
+
+	hci_callback_remove(hdev, cmd);
+}
+
 /* Get data from the previously sent command */
 void *hci_sent_cmd_data(struct hci_dev *hdev, __u16 opcode)
 {
-- 
1.7.9.5

