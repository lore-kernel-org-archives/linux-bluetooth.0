Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/5] Bluetooth: Introduce HCI_DEV_OPEN and HCI_DEV_CLOSE events
Date: Sun,  4 Oct 2015 23:34:00 +0200
Message-Id: <1443994443-123453-2-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When opening the HCI transport via hdev->open send HCI_DEV_OPEN event
and when closing the HCI transport via hdev->close send HCI_DEV_CLOSE.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci.h | 2 ++
 net/bluetooth/hci_core.c    | 6 ++++++
 2 files changed, 8 insertions(+)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 7ca6690355ea..e7f938cac7c6 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -44,6 +44,8 @@
 #define HCI_DEV_DOWN			4
 #define HCI_DEV_SUSPEND			5
 #define HCI_DEV_RESUME			6
+#define HCI_DEV_OPEN			7
+#define HCI_DEV_CLOSE			8
 
 /* HCI notify events */
 #define HCI_NOTIFY_CONN_ADD		1
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 79356469c377..5af33c87cbba 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1385,6 +1385,8 @@ static int hci_dev_do_open(struct hci_dev *hdev)
 		goto done;
 	}
 
+	hci_notify(hdev, HCI_DEV_OPEN);
+
 	atomic_set(&hdev->cmd_cnt, 1);
 	set_bit(HCI_INIT, &hdev->flags);
 
@@ -1466,6 +1468,8 @@ static int hci_dev_do_open(struct hci_dev *hdev)
 			hdev->sent_cmd = NULL;
 		}
 
+		hci_notify(hdev, HCI_DEV_CLOSE);
+
 		hdev->close(hdev);
 		hdev->flags &= BIT(HCI_RAW);
 	}
@@ -1649,6 +1653,8 @@ int hci_dev_do_close(struct hci_dev *hdev)
 		hdev->sent_cmd = NULL;
 	}
 
+	hci_notify(hdev, HCI_DEV_CLOSE);
+
 	/* After this point our queues are empty
 	 * and no tasks are scheduled. */
 	hdev->close(hdev);
-- 
2.4.3

