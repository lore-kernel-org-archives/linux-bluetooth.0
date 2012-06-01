Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv1 2/3] Bluetooth: Process HCI callbacks in a workqueue
Date: Fri,  1 Jun 2012 14:44:33 +0300
Message-Id: <1338551074-7882-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1338551074-7882-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1338551074-7882-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Use workqueue to process HCI callbacks.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 include/net/bluetooth/hci_core.h |    2 ++
 net/bluetooth/hci_core.c         |   41 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 6a31f0c..ccf6067 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1115,5 +1115,7 @@ int hci_cmd_cb(struct hci_dev *hdev, __u16 opcode, __u32 plen, void *param,
 	       void (*destructor)(struct hci_dev *hdev, struct hci_cb_cmd *cmd),
 	       gfp_t flags);
 void hci_remove_cb(struct hci_dev *hdev, struct hci_cb_cmd *cmd);
+void hci_queue_cb(struct hci_dev *hdev, struct hci_cb_cmd *cmd,
+		  struct workqueue_struct *workqueue);
 
 #endif /* __HCI_CORE_H */
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index eebb354..1815c33 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2160,6 +2160,47 @@ struct hci_cb_cmd *hci_find_cb(struct hci_dev *hdev, __u16 opcode)
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
+	BT_DBG("%s: queue cmd %p", hdev->name, cmd);
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
 	BT_DBG("%s: remove cmd %p", hdev->name, cmd);
-- 
1.7.9.5

