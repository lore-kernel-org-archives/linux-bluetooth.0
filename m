Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: btintel: Create common Intel Secure Send function
Date: Sun,  5 Jul 2015 14:55:36 +0200
Message-Id: <1436100936-94207-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The Intel Secure Send command is used the same in USB and UART drivers
and with that move a generic version into the Intel module.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 drivers/bluetooth/btintel.c   | 25 +++++++++++++++++++++++++
 drivers/bluetooth/btintel.h   |  9 +++++++++
 drivers/bluetooth/btusb.c     | 33 ++++-----------------------------
 drivers/bluetooth/hci_intel.c | 32 ++++----------------------------
 4 files changed, 42 insertions(+), 57 deletions(-)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index 8b160858f7e8..d3b0fb55e340 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -123,6 +123,31 @@ void btintel_hw_error(struct hci_dev *hdev, u8 code)
 }
 EXPORT_SYMBOL_GPL(btintel_hw_error);
 
+int btintel_secure_send(struct hci_dev *hdev, u8 fragment_type, u32 plen,
+			const void *param)
+{
+	while (plen > 0) {
+		struct sk_buff *skb;
+		u8 cmd_param[253], fragment_len = (plen > 252) ? 252 : plen;
+
+		cmd_param[0] = fragment_type;
+		memcpy(cmd_param + 1, param, fragment_len);
+
+		skb = __hci_cmd_sync(hdev, 0xfc09, fragment_len + 1,
+				     cmd_param, HCI_INIT_TIMEOUT);
+		if (IS_ERR(skb))
+			return PTR_ERR(skb);
+
+		kfree_skb(skb);
+
+		plen -= fragment_len;
+		param += fragment_len;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(btintel_secure_send);
+
 MODULE_AUTHOR("Marcel Holtmann <marcel@holtmann.org>");
 MODULE_DESCRIPTION("Bluetooth support for Intel devices ver " VERSION);
 MODULE_VERSION(VERSION);
diff --git a/drivers/bluetooth/btintel.h b/drivers/bluetooth/btintel.h
index c4680cd44011..ec89e3cb645f 100644
--- a/drivers/bluetooth/btintel.h
+++ b/drivers/bluetooth/btintel.h
@@ -75,6 +75,9 @@ int btintel_check_bdaddr(struct hci_dev *hdev);
 int btintel_set_bdaddr(struct hci_dev *hdev, const bdaddr_t *bdaddr);
 void btintel_hw_error(struct hci_dev *hdev, u8 code);
 
+int btintel_secure_send(struct hci_dev *hdev, u8 fragment_type, u32 plen,
+			const void *param);
+
 #else
 
 static inline int btintel_check_bdaddr(struct hci_dev *hdev)
@@ -91,4 +94,10 @@ static inline void btintel_hw_error(struct hci_dev *hdev, u8 code)
 {
 }
 
+static inline int btintel_secure_send(struct hci_dev *hdev, u8 fragment_type,
+				      u32 plen, const void *param)
+{
+	return -EOPNOTSUPP;
+}
+
 #endif
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 21bdb89da6eb..de7395fe938c 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -1878,30 +1878,6 @@ static int btusb_send_frame_intel(struct hci_dev *hdev, struct sk_buff *skb)
 	return -EILSEQ;
 }
 
-static int btusb_intel_secure_send(struct hci_dev *hdev, u8 fragment_type,
-				   u32 plen, const void *param)
-{
-	while (plen > 0) {
-		struct sk_buff *skb;
-		u8 cmd_param[253], fragment_len = (plen > 252) ? 252 : plen;
-
-		cmd_param[0] = fragment_type;
-		memcpy(cmd_param + 1, param, fragment_len);
-
-		skb = __hci_cmd_sync(hdev, 0xfc09, fragment_len + 1,
-				     cmd_param, HCI_INIT_TIMEOUT);
-		if (IS_ERR(skb))
-			return PTR_ERR(skb);
-
-		kfree_skb(skb);
-
-		plen -= fragment_len;
-		param += fragment_len;
-	}
-
-	return 0;
-}
-
 static void btusb_intel_version_info(struct hci_dev *hdev,
 				     struct intel_version *ver)
 {
@@ -2104,7 +2080,7 @@ static int btusb_setup_intel_new(struct hci_dev *hdev)
 	/* Start the firmware download transaction with the Init fragment
 	 * represented by the 128 bytes of CSS header.
 	 */
-	err = btusb_intel_secure_send(hdev, 0x00, 128, fw->data);
+	err = btintel_secure_send(hdev, 0x00, 128, fw->data);
 	if (err < 0) {
 		BT_ERR("%s: Failed to send firmware header (%d)",
 		       hdev->name, err);
@@ -2114,7 +2090,7 @@ static int btusb_setup_intel_new(struct hci_dev *hdev)
 	/* Send the 256 bytes of public key information from the firmware
 	 * as the PKey fragment.
 	 */
-	err = btusb_intel_secure_send(hdev, 0x03, 256, fw->data + 128);
+	err = btintel_secure_send(hdev, 0x03, 256, fw->data + 128);
 	if (err < 0) {
 		BT_ERR("%s: Failed to send firmware public key (%d)",
 		       hdev->name, err);
@@ -2124,7 +2100,7 @@ static int btusb_setup_intel_new(struct hci_dev *hdev)
 	/* Send the 256 bytes of signature information from the firmware
 	 * as the Sign fragment.
 	 */
-	err = btusb_intel_secure_send(hdev, 0x02, 256, fw->data + 388);
+	err = btintel_secure_send(hdev, 0x02, 256, fw->data + 388);
 	if (err < 0) {
 		BT_ERR("%s: Failed to send firmware signature (%d)",
 		       hdev->name, err);
@@ -2148,8 +2124,7 @@ static int btusb_setup_intel_new(struct hci_dev *hdev)
 		 * firmware data buffer as a single Data fragement.
 		 */
 		if (!(frag_len % 4)) {
-			err = btusb_intel_secure_send(hdev, 0x01, frag_len,
-						      fw_ptr);
+			err = btintel_secure_send(hdev, 0x01, frag_len, fw_ptr);
 			if (err < 0) {
 				BT_ERR("%s: Failed to send firmware data (%d)",
 				       hdev->name, err);
diff --git a/drivers/bluetooth/hci_intel.c b/drivers/bluetooth/hci_intel.c
index 06398cc0d95c..bc66a9baf532 100644
--- a/drivers/bluetooth/hci_intel.c
+++ b/drivers/bluetooth/hci_intel.c
@@ -111,30 +111,6 @@ static int inject_cmd_complete(struct hci_dev *hdev, __u16 opcode)
 	return hci_recv_frame(hdev, skb);
 }
 
-static int intel_secure_send(struct hci_dev *hdev, u8 fragment_type,
-			     u32 plen, const void *param)
-{
-	while (plen > 0) {
-		struct sk_buff *skb;
-		u8 cmd_param[253], fragment_len = (plen > 252) ? 252 : plen;
-
-		cmd_param[0] = fragment_type;
-		memcpy(cmd_param + 1, param, fragment_len);
-
-		skb = __hci_cmd_sync(hdev, 0xfc09, fragment_len + 1,
-				     cmd_param, HCI_INIT_TIMEOUT);
-		if (IS_ERR(skb))
-			return PTR_ERR(skb);
-
-		kfree_skb(skb);
-
-		plen -= fragment_len;
-		param += fragment_len;
-	}
-
-	return 0;
-}
-
 static void intel_version_info(struct hci_dev *hdev,
 			       struct intel_version *ver)
 {
@@ -350,7 +326,7 @@ static int intel_setup(struct hci_uart *hu)
 	/* Start the firmware download transaction with the Init fragment
 	 * represented by the 128 bytes of CSS header.
 	 */
-	err = intel_secure_send(hdev, 0x00, 128, fw->data);
+	err = btintel_secure_send(hdev, 0x00, 128, fw->data);
 	if (err < 0) {
 		BT_ERR("%s: Failed to send firmware header (%d)",
 		       hdev->name, err);
@@ -360,7 +336,7 @@ static int intel_setup(struct hci_uart *hu)
 	/* Send the 256 bytes of public key information from the firmware
 	 * as the PKey fragment.
 	 */
-	err = intel_secure_send(hdev, 0x03, 256, fw->data + 128);
+	err = btintel_secure_send(hdev, 0x03, 256, fw->data + 128);
 	if (err < 0) {
 		BT_ERR("%s: Failed to send firmware public key (%d)",
 		       hdev->name, err);
@@ -370,7 +346,7 @@ static int intel_setup(struct hci_uart *hu)
 	/* Send the 256 bytes of signature information from the firmware
 	 * as the Sign fragment.
 	 */
-	err = intel_secure_send(hdev, 0x02, 256, fw->data + 388);
+	err = btintel_secure_send(hdev, 0x02, 256, fw->data + 388);
 	if (err < 0) {
 		BT_ERR("%s: Failed to send firmware signature (%d)",
 		       hdev->name, err);
@@ -402,7 +378,7 @@ static int intel_setup(struct hci_uart *hu)
 		/* Send each command from the firmware data buffer as
 		 * a single Data fragment.
 		 */
-		err = intel_secure_send(hdev, 0x01, frag_len, fw_ptr);
+		err = btintel_secure_send(hdev, 0x01, frag_len, fw_ptr);
 		if (err < 0) {
 			BT_ERR("%s: Failed to send firmware data (%d)",
 			       hdev->name, err);
-- 
2.4.3

