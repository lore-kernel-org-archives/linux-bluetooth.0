Return-Path: <cyrus@holtmann.org>
From: Jakub Pawlowski <jpawlowski@google.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Pawlowski <jpawlowski@google.com>
Subject: [PATCH v2 3/4] Adding HCI_QUIRK_ADV_RSSI_DEDUP
Date: Wed, 29 Oct 2014 11:24:30 -0700
Message-Id: <1414607071-9801-3-git-send-email-jpawlowski@google.com>
In-Reply-To: <1414607071-9801-1-git-send-email-jpawlowski@google.com>
References: <1414607071-9801-1-git-send-email-jpawlowski@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When this quirk is set, the device, when in scan with deduplication is
not sending advertising reports for device when RSSI value changes.

Signed-off-by: Jakub Pawlowski <jpawlowski@google.com>
---
 include/net/bluetooth/hci.h      | 9 +++++++++
 include/net/bluetooth/hci_core.h | 2 ++
 2 files changed, 11 insertions(+)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index b15d240..d8a8e0d 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -129,6 +129,15 @@ enum {
 	 * during the hdev->setup vendor callback.
 	 */
 	HCI_QUIRK_INVALID_BDADDR,
+
+	/* When this quirk is set, the device, when in scan with de-duplication
+	 * is not sending advertising reports for device when RSSI value
+	 * changes.
+	 *
+	 * This quirk can be set before hci_register_dev is called or
+	 * during the hdev->setup vendor callback.
+	 */
+	HCI_QUIRK_DUPLICATION,
 };
 
 /* HCI device flags */
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 3c585885..e8e55f0 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1304,6 +1304,8 @@ void hci_sock_dev_event(struct hci_dev *hdev, int event);
 #define DISCOV_INTERLEAVED_INQUIRY_LEN	0x04
 #define DISCOV_BREDR_INQUIRY_LEN	0x08
 
+#define DISCOV_LE_RESTART_DELAY msecs_to_jiffies(300)
+
 int mgmt_control(struct sock *sk, struct msghdr *msg, size_t len);
 int mgmt_new_settings(struct hci_dev *hdev);
 void mgmt_index_added(struct hci_dev *hdev);
-- 
2.1.0.rc2.206.gedb03e5

