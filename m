Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/4] Bluetooth: Add a new workqueue for hci_request operations
Date: Mon, 14 Jan 2013 22:33:50 +0200
Message-Id: <1358195633-29303-2-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1358195633-29303-1-git-send-email-johan.hedberg@gmail.com>
References: <1358195633-29303-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The hci_request function is blocking and cannot be called through the
usual per-HCI device workqueue (hdev->workqueue). While hci_request is
in progress any other work from que queue, including sending HCI
commands to the controller would be blocked and eventually cause the
hci_request call to time out.

This patch adds a second workqueue to be used by operations needing
hci_request and thereby avoiding issues with blocking other workqueue
users.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci_core.h |    1 +
 net/bluetooth/hci_core.c         |   11 +++++++++++
 2 files changed, 12 insertions(+)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 014a2ea..769a740 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -216,6 +216,7 @@ struct hci_dev {
 	unsigned long	le_last_tx;
 
 	struct workqueue_struct	*workqueue;
+	struct workqueue_struct	*req_workqueue;
 
 	struct work_struct	power_on;
 	struct delayed_work	power_off;
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 596660d..f73907a 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1799,6 +1799,15 @@ int hci_register_dev(struct hci_dev *hdev)
 		goto err;
 	}
 
+	hdev->req_workqueue = alloc_workqueue(hdev->name,
+					      WQ_HIGHPRI | WQ_UNBOUND |
+					      WQ_MEM_RECLAIM, 1);
+	if (!hdev->req_workqueue) {
+		destroy_workqueue(hdev->workqueue);
+		error = -ENOMEM;
+		goto err;
+	}
+
 	error = hci_add_sysfs(hdev);
 	if (error < 0)
 		goto err_wqueue;
@@ -1827,6 +1836,7 @@ int hci_register_dev(struct hci_dev *hdev)
 
 err_wqueue:
 	destroy_workqueue(hdev->workqueue);
+	destroy_workqueue(hdev->req_workqueue);
 err:
 	ida_simple_remove(&hci_index_ida, hdev->id);
 	write_lock(&hci_dev_list_lock);
@@ -1880,6 +1890,7 @@ void hci_unregister_dev(struct hci_dev *hdev)
 	hci_del_sysfs(hdev);
 
 	destroy_workqueue(hdev->workqueue);
+	destroy_workqueue(hdev->req_workqueue);
 
 	hci_dev_lock(hdev);
 	hci_blacklist_clear(hdev);
-- 
1.7.10.4

