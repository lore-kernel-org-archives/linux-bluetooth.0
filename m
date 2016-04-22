Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2] Bluetooth: Add defines for SPI and I2C
Date: Fri, 22 Apr 2016 15:59:25 +0300
Message-Id: <1461329965-12553-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

Extend the set of possible HCI bus types with SPI and I2C.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 5d38d980b89d..eefcf3e96421 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -61,6 +61,8 @@
 #define HCI_RS232	4
 #define HCI_PCI		5
 #define HCI_SDIO	6
+#define HCI_SPI		7
+#define HCI_I2C		8
 
 /* HCI controller types */
 #define HCI_BREDR	0x00
-- 
2.5.5

