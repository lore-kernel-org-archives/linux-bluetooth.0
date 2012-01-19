Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv3 32/34] Bluetooth: Process HCI callbacks in a workqueue
Date: Thu, 19 Jan 2012 11:20:21 +0200
Message-Id: <1326964823-26747-33-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1326964823-26747-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1326964823-26747-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>


Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 include/net/bluetooth/hci_core.h |    2 +
 net/bluetooth/hci_core.c         |   42 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 44 insertions(+), 0 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 4ee2065..b43784e 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1046,5 +1046,7 @@ int hci_cmd_cb(struct hci_dev *hdev, __u16 opcode, __u32 plen, void *param,
 	void (*cb)(struct hci_dev *hdev, struct cb_cmd *cmd), void *opt,
 				void (*destructor)(struct cb_cmd *cmd));
 void hci_remove_cb(struct cb_cmd *cmd);
+void hci_queue_cb(struct hci_dev * hdev, struct cb_cmd *cmd,
+					struct workqueue_struct *workqueue);
 
 #endif /* __HCI_CORE_H */
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 5aefb61..35c0dc8 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2115,6 +2115,48 @@ struct cb_cmd *hci_find_cb(struct hci_dev *hdev, __u16 opcode)
 	return NULL;
 }
 
+struct cb_work {
+	struct work_struct work;
+	struct hci_dev *hdev;
+	struct cb_cmd *cmd;
+};
+
+static void hci_cb_work(struct work_struct *w)
+{
+	struct cb_work *work = (struct cb_work *) w;
+	struct cb_cmd *cmd = work->cmd;
+	struct hci_dev *hdev = work->hdev;
+
+	cmd->cb(hdev, cmd);
+
+	hci_dev_put(hdev);
+
+	hci_remove_cb(cmd);
+	kfree(w);
+}
+
+void hci_queue_cb(struct hci_dev * hdev, struct cb_cmd *cmd,
+					struct workqueue_struct *workqueue)
+{
+	struct cb_work *work;
+
+	BT_ERR("Queue cmd %p opt %p", cmd, cmd->opt);
+
+	work = kmalloc(sizeof(*work), GFP_ATOMIC);
+	if (!work)
+		return;
+
+	INIT_WORK(&work->work, hci_cb_work);
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
 void hci_remove_cb(struct cb_cmd *cmd)
 {
 	list_del(&cmd->list);
-- 
1.7.4.1

