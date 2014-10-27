Return-Path: <cyrus@holtmann.org>
From: Jakub Pawlowski <jpawlowski@google.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Pawlowski <jpawlowski@google.com>
Subject: [PATCH v1 3/4] Adding HCI_QUIRK_ADV_RSSI_DEDUP. When this quirk is set, the device, when in scan with deduplication is not sending advertising reports for device when RSSI value changes.
Date: Mon, 27 Oct 2014 13:41:43 -0700
Message-Id: <1414442504-14290-4-git-send-email-jpawlowski@google.com>
In-Reply-To: <1414442504-14290-1-git-send-email-jpawlowski@google.com>
References: <1414442504-14290-1-git-send-email-jpawlowski@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 include/net/bluetooth/hci.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 6e8f249..69af571 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -129,6 +129,15 @@ enum {
 	 * during the hdev->setup vendor callback.
 	 */
 	HCI_QUIRK_INVALID_BDADDR,
+
+	/* When this quirk is set, the device, when in scan with deduplication
+	 * is not sending advertising reports for device when RSSI value
+	 * changes.
+	 *
+	 * This quirk can be set before hci_register_dev is called or
+	 * during the hdev->setup vendor callback.
+	 */
+	HCI_QUIRK_ADV_RSSI_DEDUP,
 };
 
 /* HCI device flags */
-- 
2.1.0.rc2.206.gedb03e5

