Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: btintel: Create common function for Intel version info
Date: Sun,  5 Jul 2015 15:02:07 +0200
Message-Id: <1436101327-97285-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The Intel version information is shared between USB and UART drivers
and with that move it into a generic function of the Intel module.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 drivers/bluetooth/btintel.c   | 21 +++++++++++++++++++++
 drivers/bluetooth/btintel.h   |  5 +++++
 drivers/bluetooth/btusb.c     | 23 +----------------------
 drivers/bluetooth/hci_intel.c | 23 +----------------------
 4 files changed, 28 insertions(+), 44 deletions(-)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index d3b0fb55e340..1ce4ac16c7fa 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -123,6 +123,27 @@ void btintel_hw_error(struct hci_dev *hdev, u8 code)
 }
 EXPORT_SYMBOL_GPL(btintel_hw_error);
 
+void btintel_version_info(struct hci_dev *hdev, struct intel_version *ver)
+{
+	const char *variant;
+
+	switch (ver->fw_variant) {
+	case 0x06:
+		variant = "Bootloader";
+		break;
+	case 0x23:
+		variant = "Firmware";
+		break;
+	default:
+		return;
+	}
+
+	BT_INFO("%s: %s revision %u.%u build %u week %u %u", hdev->name,
+		variant, ver->fw_revision >> 4, ver->fw_revision & 0x0f,
+		ver->fw_build_num, ver->fw_build_ww, 2000 + ver->fw_build_yy);
+}
+EXPORT_SYMBOL_GPL(btintel_version_info);
+
 int btintel_secure_send(struct hci_dev *hdev, u8 fragment_type, u32 plen,
 			const void *param)
 {
diff --git a/drivers/bluetooth/btintel.h b/drivers/bluetooth/btintel.h
index ec89e3cb645f..b278d14758d5 100644
--- a/drivers/bluetooth/btintel.h
+++ b/drivers/bluetooth/btintel.h
@@ -75,6 +75,7 @@ int btintel_check_bdaddr(struct hci_dev *hdev);
 int btintel_set_bdaddr(struct hci_dev *hdev, const bdaddr_t *bdaddr);
 void btintel_hw_error(struct hci_dev *hdev, u8 code);
 
+void btintel_version_info(struct hci_dev *hdev, struct intel_version *ver);
 int btintel_secure_send(struct hci_dev *hdev, u8 fragment_type, u32 plen,
 			const void *param);
 
@@ -94,6 +95,10 @@ static inline void btintel_hw_error(struct hci_dev *hdev, u8 code)
 {
 }
 
+static void btintel_version_info(struct hci_dev *hdev, struct intel_version *ver)
+{
+}
+
 static inline int btintel_secure_send(struct hci_dev *hdev, u8 fragment_type,
 				      u32 plen, const void *param)
 {
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index de7395fe938c..93339a4f25f1 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -1878,27 +1878,6 @@ static int btusb_send_frame_intel(struct hci_dev *hdev, struct sk_buff *skb)
 	return -EILSEQ;
 }
 
-static void btusb_intel_version_info(struct hci_dev *hdev,
-				     struct intel_version *ver)
-{
-	const char *variant;
-
-	switch (ver->fw_variant) {
-	case 0x06:
-		variant = "Bootloader";
-		break;
-	case 0x23:
-		variant = "Firmware";
-		break;
-	default:
-		return;
-	}
-
-	BT_INFO("%s: %s revision %u.%u build %u week %u %u", hdev->name,
-		variant, ver->fw_revision >> 4, ver->fw_revision & 0x0f,
-		ver->fw_build_num, ver->fw_build_ww, 2000 + ver->fw_build_yy);
-}
-
 static int btusb_setup_intel_new(struct hci_dev *hdev)
 {
 	static const u8 reset_param[] = { 0x00, 0x01, 0x00, 0x01,
@@ -1960,7 +1939,7 @@ static int btusb_setup_intel_new(struct hci_dev *hdev)
 		return -EINVAL;
 	}
 
-	btusb_intel_version_info(hdev, ver);
+	btintel_version_info(hdev, ver);
 
 	/* The firmware variant determines if the device is in bootloader
 	 * mode or is running operational firmware. The value 0x06 identifies
diff --git a/drivers/bluetooth/hci_intel.c b/drivers/bluetooth/hci_intel.c
index bc66a9baf532..21dfa89751df 100644
--- a/drivers/bluetooth/hci_intel.c
+++ b/drivers/bluetooth/hci_intel.c
@@ -111,27 +111,6 @@ static int inject_cmd_complete(struct hci_dev *hdev, __u16 opcode)
 	return hci_recv_frame(hdev, skb);
 }
 
-static void intel_version_info(struct hci_dev *hdev,
-			       struct intel_version *ver)
-{
-	const char *variant;
-
-	switch (ver->fw_variant) {
-	case 0x06:
-		variant = "Bootloader";
-		break;
-	case 0x23:
-		variant = "Firmware";
-		break;
-	default:
-		return;
-	}
-
-	BT_INFO("%s: %s revision %u.%u build %u week %u %u", hdev->name,
-		variant, ver->fw_revision >> 4, ver->fw_revision & 0x0f,
-		ver->fw_build_num, ver->fw_build_ww, 2000 + ver->fw_build_yy);
-}
-
 static int intel_setup(struct hci_uart *hu)
 {
 	static const u8 reset_param[] = { 0x00, 0x01, 0x00, 0x01,
@@ -205,7 +184,7 @@ static int intel_setup(struct hci_uart *hu)
 		return -EINVAL;
 	}
 
-	intel_version_info(hdev, ver);
+	btintel_version_info(hdev, ver);
 
 	/* The firmware variant determines if the device is in bootloader
 	 * mode or is running operational firmware. The value 0x06 identifies
-- 
2.4.3

