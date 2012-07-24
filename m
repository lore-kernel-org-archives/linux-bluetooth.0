Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv2 02/20] Bluetooth: Process HCI callbacks in a workqueue
Date: Tue, 24 Jul 2012 16:21:43 +0300
Message-Id: <1343136121-22476-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1343136121-22476-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1340981212-21709-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1343136121-22476-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Use workqueue to process HCI callbacks.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 include/net/bluetooth/hci_core.h |    3 ++
 net/bluetooth/hci_core.c         |   57 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 60 insertions(+)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 479e4d1..c2506fa 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1113,5 +1113,8 @@ int hci_cmd_cb(struct hci_dev *hdev, __u16 opcode, __u32 plen, void *param,
 	       void (*destructor)(struct hci_dev *hdev, struct hci_cb_cmd *cmd),
 	       gfp_t flags);
 void hci_remove_cb(struct hci_dev *hdev, struct hci_cb_cmd *cmd);
+void hci_queue_cb(struct hci_dev *hdev, struct hci_cb_cmd *cmd,
+		  struct workqueue_struct *workqueue);
+void hci_process_cb(struct hci_dev *hdev, __u16 opcode, u8 status);
 
 #endif /* __HCI_CORE_H */
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 165c235..4c13bed 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2163,6 +2163,47 @@ struct hci_cb_cmd *hci_find_cb(struct hci_dev *hdev, __u16 opcode)
 	return NULL;
 }
 
+struct hci_cb_work {
+	struct work_struct work;
+	struct hci_dev *hdev;
+	struct hci_cb_cmd *cmd;
+};
+
+static void hci_cb_worker(struct work_struct *w)
+{
+	struct hci_cb_work *work = (struct hci_cb_work *) w;
+	struct hci_cb_cmd *cmd = work->cmd;
+	struct hci_dev *hdev = work->hdev;
+
+	cmd->cb(hdev, cmd);
+
+	hci_remove_cb(hdev, cmd);
+	kfree(w);
+	hci_dev_put(hdev);
+}
+
+void hci_queue_cb(struct hci_dev *hdev, struct hci_cb_cmd *cmd,
+		  struct workqueue_struct *workqueue)
+{
+	struct hci_cb_work *work;
+
+	BT_DBG("%s queue cmd %p", hdev->name, cmd);
+
+	work = kmalloc(sizeof(*work), GFP_KERNEL);
+	if (!work)
+		return;
+
+	INIT_WORK(&work->work, hci_cb_worker);
+	work->hdev = hdev;
+	work->cmd = cmd;
+	hci_dev_hold(hdev);
+
+	if (!queue_work(workqueue, &work->work)) {
+		kfree(work);
+		hci_dev_put(hdev);
+	}
+}
+
 void hci_remove_cb(struct hci_dev *hdev, struct hci_cb_cmd *cmd)
 {
 	BT_DBG("%s remove cmd %p", hdev->name, cmd);
@@ -2206,6 +2247,22 @@ int hci_cmd_cb(struct hci_dev *hdev, __u16 opcode, __u32 plen, void *param,
 	return hci_send_cmd(hdev, opcode, plen, param);
 }
 
+void hci_process_cb(struct hci_dev *hdev, __u16 opcode, u8 status)
+{
+	struct hci_cb_cmd *cmd;
+
+	cmd = hci_find_cb(hdev, opcode);
+	if (!cmd)
+		return;
+
+	hci_dev_lock(hdev);
+
+	cmd->status = status;
+	hci_queue_cb(hdev, cmd, hdev->workqueue);
+
+	hci_dev_unlock(hdev);
+}
+
 /* Get data from the previously sent command */
 void *hci_sent_cmd_data(struct hci_dev *hdev, __u16 opcode)
 {
-- 
1.7.9.5

