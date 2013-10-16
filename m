Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/6] Bluetooth: Store scan response data in HCI device
Date: Wed, 16 Oct 2013 00:16:47 -0700
Message-Id: <1381907811-33872-2-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The scan response data needs to be stored in HCI device and so
add a buffer for it and also ensure to clear it when resetting
the controller.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci_core.h | 2 ++
 net/bluetooth/hci_event.c        | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 0a3a10a..d987c79 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -283,6 +283,8 @@ struct hci_dev {
 	__s8			adv_tx_power;
 	__u8			adv_data[HCI_MAX_AD_LENGTH];
 	__u8			adv_data_len;
+	__u8			scan_rsp_data[HCI_MAX_AD_LENGTH];
+	__u8			scan_rsp_data_len;
 
 	int (*open)(struct hci_dev *hdev);
 	int (*close)(struct hci_dev *hdev);
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 7450626..e71c98f 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -195,6 +195,9 @@ static void hci_cc_reset(struct hci_dev *hdev, struct sk_buff *skb)
 
 	memset(hdev->adv_data, 0, sizeof(hdev->adv_data));
 	hdev->adv_data_len = 0;
+
+	memset(hdev->scan_rsp_data, 0, sizeof(hdev->scan_rsp_data));
+	hdev->scan_rsp_data_len = 0;
 }
 
 static void hci_cc_write_local_name(struct hci_dev *hdev, struct sk_buff *skb)
-- 
1.8.3.1

