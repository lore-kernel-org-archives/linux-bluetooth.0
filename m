Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 1/3] Bluetooth: Add driver setup stage for early init
Date: Tue,  2 Apr 2013 20:21:25 +0300
Message-Id: <1364923287-25935-2-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1364923287-25935-1-git-send-email-johan.hedberg@gmail.com>
References: <1364923287-25935-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Marcel Holtmann <marcel@holtmann.org>

Some drivers require a special stage for their early init. This is
always specific to the driver or transport. So call back into driver to
allow bringing up the device.

The advantage with this stage is that the Bluetooth core is actually
handling the HCI layer now. This means that command and event processing
is available.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
Acked-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci_core.h |    1 +
 net/bluetooth/hci_core.c         |   33 ++++++++++++++++++++-------------
 2 files changed, 21 insertions(+), 13 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 0e7ee89..b464b2e 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -292,6 +292,7 @@ struct hci_dev {
 	int (*open)(struct hci_dev *hdev);
 	int (*close)(struct hci_dev *hdev);
 	int (*flush)(struct hci_dev *hdev);
+	int (*setup)(struct hci_dev *hdev);
 	int (*send)(struct sk_buff *skb);
 	void (*notify)(struct hci_dev *hdev, unsigned int evt);
 	int (*ioctl)(struct hci_dev *hdev, unsigned int cmd, unsigned long arg);
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index a199d63..cd93986 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1012,26 +1012,33 @@ int hci_dev_open(__u16 dev)
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
-		ret = __hci_init(hdev);
-		clear_bit(HCI_INIT, &hdev->flags);
+	atomic_set(&hdev->cmd_cnt, 1);
+	set_bit(HCI_INIT, &hdev->flags);
+
+	if (hdev->setup && test_bit(HCI_SETUP, &hdev->dev_flags))
+		ret = hdev->setup(hdev);
+
+	if (!ret) {
+		/* Treat all non BR/EDR controllers as raw devices if
+		 * enable_hs is not set.
+		 */
+		if (hdev->dev_type != HCI_BREDR && !enable_hs)
+			set_bit(HCI_RAW, &hdev->flags);
+
+		if (test_bit(HCI_QUIRK_RAW_DEVICE, &hdev->quirks))
+			set_bit(HCI_RAW, &hdev->flags);
+
+		if (!test_bit(HCI_RAW, &hdev->flags))
+			ret = __hci_init(hdev);
 	}
 
+	clear_bit(HCI_INIT, &hdev->flags);
+
 	if (!ret) {
 		hci_dev_hold(hdev);
 		set_bit(HCI_UP, &hdev->flags);
-- 
1.7.10.4

