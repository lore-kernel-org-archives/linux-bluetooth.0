Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv0 3/3] Bluetooth: AMP: Read Local AMP Info
Date: Wed, 30 Nov 2011 15:54:32 +0200
Message-Id: <1322661272-32027-4-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1322661272-32027-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1322661272-32027-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Execute HCI command Read Local AMP Info upon receiving A2MP
Discover Request
---
 net/bluetooth/a2mp.c      |    4 +++
 net/bluetooth/amp.c       |   62 +++++++++++++++++++++++++++++++++++++++++++++
 net/bluetooth/hci_event.c |    4 +++
 3 files changed, 70 insertions(+), 0 deletions(-)

diff --git a/net/bluetooth/a2mp.c b/net/bluetooth/a2mp.c
index b6b9cde..49f9978 100644
--- a/net/bluetooth/a2mp.c
+++ b/net/bluetooth/a2mp.c
@@ -24,6 +24,8 @@ struct workqueue_struct *a2mp_workqueue;
 
 static struct amp_mgr *get_amp_mgr_sk(struct sock *sk);
 
+int amp_read_local_amp_info(struct hci_dev *hdev, struct amp_mgr *mgr);
+
 LIST_HEAD(amp_mgr_list);
 DEFINE_RWLOCK(amp_mgr_list_lock);
 
@@ -99,6 +101,8 @@ static void __a2mp_add_cl(struct amp_mgr *mgr, struct a2mp_cl *cl, u8 num_ctrl)
 		cl[i].id = hdev->id;
 		cl[i].type = hdev->amp_type;
 		cl[i].status = hdev->amp_status;
+
+		amp_read_local_amp_info(hdev, mgr);
 	}
 out:
 	read_unlock_bh(&hci_dev_list_lock);
diff --git a/net/bluetooth/amp.c b/net/bluetooth/amp.c
index d5c48b6..218ae29 100644
--- a/net/bluetooth/amp.c
+++ b/net/bluetooth/amp.c
@@ -77,3 +77,65 @@ void amp_pending_remove_all(struct hci_dev *hdev)
 	list_for_each_entry(cmd, &hdev->amp_pending, list)
 		amp_pending_remove(cmd);
 }
+
+/* Invoked with hci_dev locked */
+int amp_read_local_amp_info(struct hci_dev *hdev, struct amp_mgr *mgr)
+{
+	int err = 0;
+	struct pending_amp *cmd;
+
+	cmd = amp_pending_add(mgr, HCI_OP_READ_LOCAL_AMP_INFO, hdev, NULL, 0);
+	if (!cmd) {
+		err = -ENOMEM;
+		goto out;
+	}
+
+	BT_DBG("Read Local AMP Info for %s cmd %p", hdev->name, cmd);
+
+	err = hci_send_cmd(hdev, HCI_OP_READ_LOCAL_AMP_INFO, 0, NULL);
+	if (err < 0)
+		amp_pending_remove(cmd);
+out:
+	return err;
+}
+
+struct amp_work {
+	struct work_struct work;
+	struct hci_dev *hdev;
+};
+
+static void amp_local_info_wrk(struct work_struct *w)
+{
+	struct amp_work *work = (struct amp_work *) w;
+	struct pending_amp *cmd;
+	struct hci_dev *hdev;
+
+	hdev = work->hdev;
+
+	cmd = amp_pending_find(HCI_OP_READ_LOCAL_AMP_INFO, hdev);
+	if (cmd) {
+		BT_DBG("Found pending amp cmd %p", cmd);
+
+		/* TODO correct AMP information if needed */
+
+		amp_pending_remove(cmd);
+	}
+
+	hci_dev_put(hdev);
+}
+
+void amp_read_local_amp_info_complete(struct hci_dev *hdev)
+{
+	struct amp_work *work;
+
+	work = kmalloc(sizeof(*work), GFP_ATOMIC);
+	if (work) {
+		INIT_WORK(&work->work, amp_local_info_wrk);
+		work->hdev = hdev;
+		hci_dev_hold(hdev);
+		if (!queue_work(a2mp_workqueue, &work->work)) {
+			kfree(work);
+			hci_dev_put(hdev);
+		}
+	}
+}
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 2ada168..fa66d88 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -45,6 +45,8 @@
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
 
+int amp_read_local_amp_info_complete(struct hci_dev *hdev);
+
 static int enable_le;
 
 /* Handle HCI Event packets */
@@ -835,6 +837,8 @@ static void hci_cc_read_local_amp_info(struct hci_dev *hdev,
 	hdev->amp_max_flush_to = __le32_to_cpu(rp->max_flush_to);
 
 	hci_req_complete(hdev, HCI_OP_READ_LOCAL_AMP_INFO, rp->status);
+
+	amp_read_local_amp_info_complete(hdev);
 }
 
 static void hci_cc_delete_stored_link_key(struct hci_dev *hdev,
-- 
1.7.4.1

