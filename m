Return-Path: <tedd.an@intel.com>
Date: Mon, 6 Mar 2017 15:38:26 -0800
From: Tedd Ho-Jeong An <tedd.an@intel.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
 Marcel Holtmann <marcel@holtmann.org>
Cc: Tedd Ho-Jeong An <tedd.an@intel.com>
Subject: [PATCH 1/4] Bluetooth: Use switch statement for Intel hardware
 variants
Message-ID: <20170306153826.13509ae8@fedora-linux-22.shared>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-bluetooth.vger.kernel.org>

From: Tedd Ho-Jeong An <tedd.an@intel.com>

Multiple new hardware variants are planned and the simple if statement
would get really complicated and unreadable. So instead replace it with
a simple switch statement.

The change is applied to both USB and UART.

Based-on-patch-by: Marcel Holtmann <marcel@holtmann.org>
Signed-off-by: Tedd Ho-Jeong An <tedd.an@intel.com>
---
 drivers/bluetooth/btusb.c     | 10 +++++++---
 drivers/bluetooth/hci_intel.c | 17 +++++++++++------
 2 files changed, 18 insertions(+), 9 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 1c8094e..348cf93 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -2024,13 +2024,17 @@ static int btusb_setup_intel_new(struct hci_dev *hdev)
 		return -EINVAL;
 	}
 
-	/* At the moment the iBT 3.0 hardware variants 0x0b (LnP/SfP)
-	 * and 0x0c (WsP) are supported by this firmware loading method.
+	/* Check for supported iBT hardware variants of this firmware
+	 * loading method.
 	 *
 	 * This check has been put in place to ensure correct forward
 	 * compatibility options when newer hardware variants come along.
 	 */
-	if (ver.hw_variant != 0x0b && ver.hw_variant != 0x0c) {
+	switch (ver.hw_variant) {
+	case 0x0b:	/* 8260 SfP */
+	case 0x0c:	/* 8265 WsP */
+		break;
+	default:
 		BT_ERR("%s: Unsupported Intel hardware variant (%u)",
 		       hdev->name, ver.hw_variant);
 		return -EINVAL;
diff --git a/drivers/bluetooth/hci_intel.c b/drivers/bluetooth/hci_intel.c
index 9e27128..351e868 100644
--- a/drivers/bluetooth/hci_intel.c
+++ b/drivers/bluetooth/hci_intel.c
@@ -601,12 +601,17 @@ static int intel_setup(struct hci_uart *hu)
 		return -EINVAL;
 	}
 
-	/* At the moment only the hardware variant iBT 3.0 (LnP/SfP) is
-	 * supported by this firmware loading method. This check has been
-	 * put in place to ensure correct forward compatibility options
-	 * when newer hardware variants come along.
-	 */
-	if (ver.hw_variant != 0x0b) {
+        /* Check for supported iBT hardware variants of this firmware
+         * loading method.
+         *
+         * This check has been put in place to ensure correct forward
+         * compatibility options when newer hardware variants come along.
+         */
+	switch (ver.hw_variant) {
+	case 0x0b:	/* 8260 LnP */
+	case 0x0c:	/* 8260 WsP */
+		break;
+	default:
 		bt_dev_err(hdev, "Unsupported Intel hardware variant (%u)",
 			   ver.hw_variant);
 		return -EINVAL;
-- 
2.7.4
