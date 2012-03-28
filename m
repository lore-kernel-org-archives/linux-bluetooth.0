Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv6 23/26] Bluetooth: General HCI callback implementation
Date: Wed, 28 Mar 2012 16:31:46 +0300
Message-Id: <1332941509-21345-24-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1332941509-21345-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1332519246-16656-27-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1332941509-21345-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Add general HCI callback implementation. Can be used for executing
HCI commands from A2MP protocol.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 include/net/bluetooth/hci_core.h |   20 +++++++++
 net/bluetooth/hci_core.c         |   82 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 102 insertions(+), 0 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 9f9a0d2..8a18e8a 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -131,6 +131,17 @@ struct le_scan_params {
 
 #define HCI_MAX_SHORT_NAME_LENGTH	10
 
+struct hci_dev;
+
+struct hci_cb_cmd {
+	struct list_head list;
+	u16 opcode;
+	u8 status;
+	void *opt;
+	void (*cb)(struct hci_dev *hdev, struct hci_cb_cmd *cmd);
+	void (*destructor)(struct hci_cb_cmd *cmd);
+};
+
 #define NUM_REASSEMBLY 4
 struct hci_dev {
 	struct list_head list;
@@ -243,6 +254,9 @@ struct hci_dev {
 
 	struct list_head	mgmt_pending;
 
+	struct mutex		cb_list_lock;
+	struct list_head	cb_list;
+
 	struct discovery_state	discovery;
 	struct hci_conn_hash	conn_hash;
 	struct list_head	blacklist;
@@ -1093,4 +1107,10 @@ int hci_le_scan(struct hci_dev *hdev, u8 type, u16 interval, u16 window,
 		int timeout);
 int hci_cancel_le_scan(struct hci_dev *hdev);
 
+struct hci_cb_cmd *hci_find_cb(struct hci_dev *hdev, __u16 opcode);
+int hci_cmd_cb(struct hci_dev *hdev, __u16 opcode, __u32 plen, void *param,
+	void (*cb)(struct hci_dev *hdev, struct hci_cb_cmd *cmd), void *opt,
+		void (*destructor)(struct hci_cb_cmd *cmd), gfp_t flags);
+void hci_remove_cb(struct hci_dev *hdev, struct hci_cb_cmd *cmd);
+
 #endif /* __HCI_CORE_H */
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index f27e3e8..8073d7a 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -57,6 +57,7 @@
 static void hci_rx_work(struct work_struct *work);
 static void hci_cmd_work(struct work_struct *work);
 static void hci_tx_work(struct work_struct *work);
+static void hci_cb_clear(struct hci_dev *hdev);
 
 /* HCI device list */
 LIST_HEAD(hci_dev_list);
@@ -1848,6 +1849,9 @@ int hci_register_dev(struct hci_dev *hdev)
 
 	INIT_LIST_HEAD(&hdev->mgmt_pending);
 
+	INIT_LIST_HEAD(&hdev->cb_list);
+	mutex_init(&hdev->cb_list_lock);
+
 	INIT_LIST_HEAD(&hdev->blacklist);
 
 	INIT_LIST_HEAD(&hdev->uuids);
@@ -1964,6 +1968,7 @@ void hci_unregister_dev(struct hci_dev *hdev)
 	hci_smp_ltks_clear(hdev);
 	hci_remote_oob_data_clear(hdev);
 	hci_adv_entries_clear(hdev);
+	hci_cb_clear(hdev);
 	hci_dev_unlock(hdev);
 
 	hci_dev_put(hdev);
@@ -2263,6 +2268,83 @@ int hci_send_cmd(struct hci_dev *hdev, __u16 opcode, __u32 plen, void *param)
 	return 0;
 }
 
+static int hci_add_cb(struct hci_dev *hdev, __u16 opcode,
+		void (*cb)(struct hci_dev *hdev, struct hci_cb_cmd *cmd),
+	void *opt, void (*destructor)(struct hci_cb_cmd *cmd), gfp_t flags)
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
+struct hci_cb_cmd *hci_find_cb(struct hci_dev *hdev, __u16 opcode)
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
+void hci_remove_cb(struct hci_dev *hdev, struct hci_cb_cmd *cmd)
+{
+	mutex_lock(&hdev->cb_list_lock);
+	list_del(&cmd->list);
+	mutex_unlock(&hdev->cb_list_lock);
+
+	if (cmd->destructor) {
+		cmd->destructor(cmd);
+	} else {
+		kfree(cmd->opt);
+		kfree(cmd);
+	}
+}
+
+static void hci_cb_clear(struct hci_dev *hdev)
+{
+	struct hci_cb_cmd *cmd, *tmp;
+
+	list_for_each_entry_safe(cmd, tmp, &hdev->cb_list, list)
+		hci_remove_cb(hdev, cmd);
+}
+
+/* Send HCI command with callback */
+int hci_cmd_cb(struct hci_dev *hdev, __u16 opcode, __u32 plen, void *param,
+		void (*cb)(struct hci_dev *hdev, struct hci_cb_cmd *cmd),
+	void *opt, void (*destructor)(struct hci_cb_cmd *cmd), gfp_t flags)
+{
+	int ret;
+
+	if (!cb)
+		return -EINVAL;
+
+	ret = hci_add_cb(hdev, opcode, cb, opt, destructor, flags);
+	if (ret)
+		return ret;
+
+	return hci_send_cmd(hdev, opcode, plen, param);
+}
+
 /* Get data from the previously sent command */
 void *hci_sent_cmd_data(struct hci_dev *hdev, __u16 opcode)
 {
-- 
1.7.9.1

