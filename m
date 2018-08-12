Return-Path: <sean.wang@mediatek.com>
From: <sean.wang@mediatek.com>
To: <marcel@holtmann.org>, <johan.hedberg@gmail.com>
CC: <linux-bluetooth@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH v1 2/2] Bluetooth: mediatek: Add protocol support for MediaTek MT7663U USB devices
Date: Sun, 12 Aug 2018 16:46:52 +0800
Message-ID: <faa3b96dd4597b59e8ec7395629f3d3cd44657c3.1534062988.git.sean.wang@mediatek.com>
In-Reply-To: <cover.1534062988.git.sean.wang@mediatek.com>
References: <cover.1534062988.git.sean.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-bluetooth.vger.kernel.org>

From: Sean Wang <sean.wang@mediatek.com>

This adds the support of enabling MT7663U Bluetooth function running
on the top of btusb driver.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/bluetooth/btmtk.c | 1 +
 drivers/bluetooth/btmtk.h | 1 +
 drivers/bluetooth/btusb.c | 3 +++
 3 files changed, 5 insertions(+)

diff --git a/drivers/bluetooth/btmtk.c b/drivers/bluetooth/btmtk.c
index 9e39a0a..d46c25d 100644
--- a/drivers/bluetooth/btmtk.c
+++ b/drivers/bluetooth/btmtk.c
@@ -305,4 +305,5 @@ MODULE_AUTHOR("Sean Wang <sean.wang@mediatek.com>");
 MODULE_DESCRIPTION("MediaTek Bluetooth device driver ver " VERSION);
 MODULE_VERSION(VERSION);
 MODULE_LICENSE("GPL");
+MODULE_FIRMWARE(FIRMWARE_MT7663);
 MODULE_FIRMWARE(FIRMWARE_MT7668);
diff --git a/drivers/bluetooth/btmtk.h b/drivers/bluetooth/btmtk.h
index 64fc395..f90292c 100644
--- a/drivers/bluetooth/btmtk.h
+++ b/drivers/bluetooth/btmtk.h
@@ -9,6 +9,7 @@
  *
  */
 
+#define FIRMWARE_MT7663		"mt7663pr2h.bin"
 #define FIRMWARE_MT7668		"mt7668pr2h.bin"
 
 enum {
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 773238b..56f7862 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -2494,6 +2494,9 @@ static int btusb_mtk_setup(struct hci_dev *hdev)
 	}
 
 	switch (dev_id) {
+	case 0x7663:
+		fwname = FIRMWARE_MT7663;
+		break;
 	case 0x7668:
 		fwname = FIRMWARE_MT7668;
 		break;
-- 
2.7.4
