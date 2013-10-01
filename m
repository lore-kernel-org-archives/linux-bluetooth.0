Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] Bluetooth: Refactor hci_dev_open to a separate hci_dev_do_open function
Date: Tue,  1 Oct 2013 14:10:27 +0300
Message-Id: <1380625828-19538-2-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1380625828-19538-1-git-send-email-johan.hedberg@gmail.com>
References: <1380625828-19538-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The requirements of an external call to hci_dev_open from hci_sock.c are
different to that from within hci_core.c. In the former case we want to
flush any pending work in hdev->req_workqueue whereas in the latter we
don't (since there we are already calling from within the workqueue
itself). This patch does the necessary refactoring to a separate
hci_dev_do_open function (analogous to hci_dev_do_close) but does not
yet introduce the synchronizations relating to the workqueue usage.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_core.c | 30 ++++++++++++++++++++----------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 1b66547..fc63e78 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1126,17 +1126,10 @@ void hci_update_ad(struct hci_request *req)
 	hci_req_add(req, HCI_OP_LE_SET_ADV_DATA, sizeof(cp), &cp);
 }
 
-/* ---- HCI ioctl helpers ---- */
-
-int hci_dev_open(__u16 dev)
+static int hci_dev_do_open(struct hci_dev *hdev)
 {
-	struct hci_dev *hdev;
 	int ret = 0;
 
-	hdev = hci_dev_get(dev);
-	if (!hdev)
-		return -ENODEV;
-
 	BT_DBG("%s %p", hdev->name, hdev);
 
 	hci_req_lock(hdev);
@@ -1220,10 +1213,27 @@ int hci_dev_open(__u16 dev)
 
 done:
 	hci_req_unlock(hdev);
-	hci_dev_put(hdev);
 	return ret;
 }
 
+/* ---- HCI ioctl helpers ---- */
+
+int hci_dev_open(__u16 dev)
+{
+	struct hci_dev *hdev;
+	int err;
+
+	hdev = hci_dev_get(dev);
+	if (!hdev)
+		return -ENODEV;
+
+	err = hci_dev_do_open(hdev);
+
+	hci_dev_put(hdev);
+
+	return err;
+}
+
 static int hci_dev_do_close(struct hci_dev *hdev)
 {
 	BT_DBG("%s %p", hdev->name, hdev);
@@ -1592,7 +1602,7 @@ static void hci_power_on(struct work_struct *work)
 
 	BT_DBG("%s", hdev->name);
 
-	err = hci_dev_open(hdev->id);
+	err = hci_dev_do_open(hdev);
 	if (err < 0) {
 		mgmt_set_powered_failed(hdev, err);
 		return;
-- 
1.8.3.1

