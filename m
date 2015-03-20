Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH 3/6] Bluetooth: Add data structure for advertising instance
Date: Thu, 19 Mar 2015 17:04:34 -0700
Message-Id: <1426809877-22469-4-git-send-email-armansito@chromium.org>
In-Reply-To: <1426809877-22469-1-git-send-email-armansito@chromium.org>
References: <1426809877-22469-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch introduces a new data structure to represent advertising
instances that were added using the "Add Advertising" mgmt command.
Initially an hci_dev structure will support only one of these instances
at a time, so the current instance is simply stored as a direct member
of hci_dev.

Signed-off-by: Arman Uguray <armansito@chromium.org>
---
 include/net/bluetooth/hci_core.h | 18 ++++++++++++++++++
 net/bluetooth/hci_core.c         |  1 +
 2 files changed, 19 insertions(+)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index b65c53d..4e32e06 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -155,6 +155,15 @@ struct oob_data {
 	u8 rand256[16];
 };
 
+struct le_adv_instance {
+	__u8 index;
+	__u32 flags;
+	__u16 adv_data_len;
+	__u8 adv_data[HCI_MAX_AD_LENGTH];
+	__u16 scan_rsp_len;
+	__u8 scan_rsp_data[HCI_MAX_AD_LENGTH];
+};
+
 #define HCI_MAX_SHORT_NAME_LENGTH	10
 
 /* Default LE RPA expiry time, 15 minutes */
@@ -364,6 +373,9 @@ struct hci_dev {
 	__u8			scan_rsp_data[HCI_MAX_AD_LENGTH];
 	__u8			scan_rsp_data_len;
 
+	struct le_adv_instance	adv_instance;
+	__u8			cur_adv_index;
+
 	__u8			irk[16];
 	__u32			rpa_timeout;
 	struct delayed_work	rpa_expired;
@@ -550,6 +562,12 @@ static inline void hci_discovery_filter_clear(struct hci_dev *hdev)
 	hdev->discovery.scan_duration = 0;
 }
 
+static inline void hci_le_adv_instance_init(struct hci_dev *hdev)
+{
+	memset(&hdev->adv_instance, 0, sizeof(struct le_adv_instance));
+	hdev->cur_adv_index = 0;
+}
+
 bool hci_discovery_active(struct hci_dev *hdev);
 
 void hci_discovery_set_state(struct hci_dev *hdev, int state);
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 773f216..50a5f4c 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3125,6 +3125,7 @@ struct hci_dev *hci_alloc_dev(void)
 
 	hci_init_sysfs(hdev);
 	discovery_init(hdev);
+	hci_le_adv_instance_init(hdev);
 
 	return hdev;
 }
-- 
2.2.0.rc0.207.ga3a616c

