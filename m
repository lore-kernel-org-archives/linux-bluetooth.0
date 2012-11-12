Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/3] Bluetooth: Add driver setup stage for early init
Date: Mon, 12 Nov 2012 14:02:14 +0900
Message-Id: <1352696536-13937-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Some drivers require a special stage for their early init. This is always
specific to the driver or transport. So call back into driver to allow
bringing up the device.

The advantage with this stage is that the Bluetooth core is actually
handling the HCI layer now. This means that command and event processing
is available.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci_core.h |  1 +
 net/bluetooth/hci_core.c         | 36 ++++++++++++++++++++++--------------
 2 files changed, 23 insertions(+), 14 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index ef5b85d..c14d52e 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -285,6 +285,7 @@ struct hci_dev {
 	int (*open)(struct hci_dev *hdev);
 	int (*close)(struct hci_dev *hdev);
 	int (*flush)(struct hci_dev *hdev);
+	int (*setup)(struct hci_dev *hdev);
 	int (*send)(struct sk_buff *skb);
 	void (*notify)(struct hci_dev *hdev, unsigned int evt);
 	int (*ioctl)(struct hci_dev *hdev, unsigned int cmd, unsigned long arg);
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index e3a49db..52acfee 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -717,29 +717,37 @@ int hci_dev_open(__u16 dev)
 		goto done;
 	}
 
-	if (test_bit(HCI_QUIRK_RAW_DEVICE, &hdev->quirks))
-		set_bit(HCI_RAW, &hdev->flags);
-
-	/* Treat all non BR/EDR controllers as raw devices if
-	   enable_hs is not set */
-	if (hdev->dev_type != HCI_BREDR && !enable_hs)
-		set_bit(HCI_RAW, &hdev->flags);
-
 	if (hdev->open(hdev)) {
 		ret = -EIO;
 		goto done;
 	}
 
-	if (!test_bit(HCI_RAW, &hdev->flags)) {
-		atomic_set(&hdev->cmd_cnt, 1);
-		set_bit(HCI_INIT, &hdev->flags);
-		hdev->init_last_cmd = 0;
+	atomic_set(&hdev->cmd_cnt, 1);
+	set_bit(HCI_INIT, &hdev->flags);
 
-		ret = __hci_request(hdev, hci_init_req, 0, HCI_INIT_TIMEOUT);
+	if (hdev->setup && test_bit(HCI_SETUP, &hdev->dev_flags)) {
+		hdev->init_last_cmd = 0;
+		ret = hdev->setup(hdev);
+	}
 
-		clear_bit(HCI_INIT, &hdev->flags);
+	if (!ret) {
+		/* Treat all non BR/EDR controllers as raw devices if
+		 * enable_hs is not set */
+		if (hdev->dev_type != HCI_BREDR && !enable_hs)
+			set_bit(HCI_RAW, &hdev->flags);
+
+		if (test_bit(HCI_QUIRK_RAW_DEVICE, &hdev->quirks))
+			set_bit(HCI_RAW, &hdev->flags);
+
+		if (!test_bit(HCI_RAW, &hdev->flags)) {
+			hdev->init_last_cmd = 0;
+			ret = __hci_request(hdev, hci_init_req, 0,
+					    HCI_INIT_TIMEOUT);
+		}
 	}
 
+	clear_bit(HCI_INIT, &hdev->flags);
+
 	if (!ret) {
 		hci_dev_hold(hdev);
 		set_bit(HCI_UP, &hdev->flags);
-- 
1.7.11.7

