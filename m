Return-Path: <tedd.an@intel.com>
Date: Mon, 6 Mar 2017 15:38:35 -0800
From: Tedd Ho-Jeong An <tedd.an@intel.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
 Marcel Holtmann <marcel@holtmann.org>
Cc: Tedd Ho-Jeong An <tedd.an@intel.com>, "jaya.p.g"
 <jaya.p.g@linux.intel.com>
Subject: [PATCH 4/4] Bluetooth: hci_intel: Add support Intel Bluetooth
 device 9160/9260 for UART
Message-ID: <20170306153835.0d7ed9e5@fedora-linux-22.shared>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-bluetooth.vger.kernel.org>

From: Tedd Ho-Jeong An <tedd.an@intel.com>

This patch adds support for Intel Bluetooth device 9160/9260 also
known as ThunderPeak(ThP) for UART.

Signed-off-by: Tedd Ho-Jeong An <tedd.an@intel.com>
---
 drivers/bluetooth/hci_intel.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bluetooth/hci_intel.c b/drivers/bluetooth/hci_intel.c
index 63970d0..831c934 100644
--- a/drivers/bluetooth/hci_intel.c
+++ b/drivers/bluetooth/hci_intel.c
@@ -610,6 +610,7 @@ static int intel_setup(struct hci_uart *hu)
 	switch (ver.hw_variant) {
 	case 0x0b:	/* 8260 LnP */
 	case 0x0c:	/* 8260 WsP */
+	case 0x12:	/* 9160/9260 ThP */
 		break;
 	default:
 		bt_dev_err(hdev, "Unsupported Intel hardware variant (%u)",
-- 
2.7.4
