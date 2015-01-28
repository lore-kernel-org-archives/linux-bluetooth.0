Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Introduce hci_dev_do_reset helper function
Date: Wed, 28 Jan 2015 11:53:05 -0800
Message-Id: <1422474785-17178-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Split the hci_dev_reset ioctl handling into using hci_dev_do_reset
helper function. Similar to what has been done with hci_dev_do_open
and hci_dev_do_close.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_core.c | 57 +++++++++++++++++++++++++++++-------------------
 1 file changed, 34 insertions(+), 23 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 0f98d9057ae7..79693a9ef4eb 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1719,32 +1719,14 @@ done:
 	return err;
 }
 
-int hci_dev_reset(__u16 dev)
+static int hci_dev_do_reset(struct hci_dev *hdev)
 {
-	struct hci_dev *hdev;
-	int ret = 0;
+	int ret;
 
-	hdev = hci_dev_get(dev);
-	if (!hdev)
-		return -ENODEV;
+	BT_DBG("%s %p", hdev->name, hdev);
 
 	hci_req_lock(hdev);
 
-	if (!test_bit(HCI_UP, &hdev->flags)) {
-		ret = -ENETDOWN;
-		goto done;
-	}
-
-	if (test_bit(HCI_USER_CHANNEL, &hdev->dev_flags)) {
-		ret = -EBUSY;
-		goto done;
-	}
-
-	if (test_bit(HCI_UNCONFIGURED, &hdev->dev_flags)) {
-		ret = -EOPNOTSUPP;
-		goto done;
-	}
-
 	/* Drop queues */
 	skb_queue_purge(&hdev->rx_q);
 	skb_queue_purge(&hdev->cmd_q);
@@ -1767,12 +1749,41 @@ int hci_dev_reset(__u16 dev)
 
 	ret = __hci_req_sync(hdev, hci_reset_req, 0, HCI_INIT_TIMEOUT);
 
-done:
 	hci_req_unlock(hdev);
-	hci_dev_put(hdev);
 	return ret;
 }
 
+int hci_dev_reset(__u16 dev)
+{
+	struct hci_dev *hdev;
+	int err;
+
+	hdev = hci_dev_get(dev);
+	if (!hdev)
+		return -ENODEV;
+
+	if (!test_bit(HCI_UP, &hdev->flags)) {
+		err = -ENETDOWN;
+		goto done;
+	}
+
+	if (test_bit(HCI_USER_CHANNEL, &hdev->dev_flags)) {
+		err = -EBUSY;
+		goto done;
+	}
+
+	if (test_bit(HCI_UNCONFIGURED, &hdev->dev_flags)) {
+		err = -EOPNOTSUPP;
+		goto done;
+	}
+
+	err = hci_dev_do_reset(hdev);
+
+done:
+	hci_dev_put(hdev);
+	return err;
+}
+
 int hci_dev_reset_stat(__u16 dev)
 {
 	struct hci_dev *hdev;
-- 
2.1.0

