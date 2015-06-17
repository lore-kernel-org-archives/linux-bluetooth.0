Return-Path: <cyrus@holtmann.org>
From: Chan-yeol Park <chanyeol.park@samsung.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 1/2] Bluetooth: hci_uart: Include vendor struct if required
Date: Wed, 17 Jun 2015 13:59:08 +0900
Message-id: <1434517149-1728-1-git-send-email-chanyeol.park@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Vendor specific structs should be included only when enabled because
hci_uart does not need it always.

Signed-off-by: Chan-yeol Park <chanyeol.park@samsung.com>
---
 drivers/bluetooth/btbcm.h   | 4 ++--
 drivers/bluetooth/btintel.h | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/bluetooth/btbcm.h b/drivers/bluetooth/btbcm.h
index 02f5f96..ce6e15c 100644
--- a/drivers/bluetooth/btbcm.h
+++ b/drivers/bluetooth/btbcm.h
@@ -21,6 +21,8 @@
  *
  */
 
+#if IS_ENABLED(CONFIG_BT_BCM)
+
 #define BCM_UART_CLOCK_48MHZ	0x01
 #define BCM_UART_CLOCK_24MHZ	0x02
 
@@ -33,8 +35,6 @@ struct bcm_write_uart_clock_setting {
 	__u8 type;
 } __packed;
 
-#if IS_ENABLED(CONFIG_BT_BCM)
-
 int btbcm_check_bdaddr(struct hci_dev *hdev);
 int btbcm_set_bdaddr(struct hci_dev *hdev, const bdaddr_t *bdaddr);
 int btbcm_patchram(struct hci_dev *hdev, const struct firmware *fw);
diff --git a/drivers/bluetooth/btintel.h b/drivers/bluetooth/btintel.h
index 4bda6ab..f92a9cf 100644
--- a/drivers/bluetooth/btintel.h
+++ b/drivers/bluetooth/btintel.h
@@ -21,6 +21,8 @@
  *
  */
 
+#if IS_ENABLED(CONFIG_BT_INTEL)
+
 struct intel_version {
 	u8 status;
 	u8 hw_platform;
@@ -69,8 +71,6 @@ struct intel_secure_send_result {
 	__u8     status;
 } __packed;
 
-#if IS_ENABLED(CONFIG_BT_INTEL)
-
 int btintel_check_bdaddr(struct hci_dev *hdev);
 int btintel_set_bdaddr(struct hci_dev *hdev, const bdaddr_t *bdaddr);
 
-- 
2.1.4

