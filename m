Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Add defines for SPI, I2C & local HCI bus types
Date: Fri, 22 Apr 2016 15:54:00 +0300
Message-Id: <1461329640-11440-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

Extend the set of possible HCI bus types with SPI, I2C and local. A
local bus means that the controller is part of the same address
space/CPU as the host and doesn't have a physical HCI transport as
such.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 5d38d980b89d..b3024f4090e8 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -61,6 +61,9 @@
 #define HCI_RS232	4
 #define HCI_PCI		5
 #define HCI_SDIO	6
+#define HCI_SPI		7
+#define HCI_I2C		8
+#define HCI_LOCAL	9
 
 /* HCI controller types */
 #define HCI_BREDR	0x00
-- 
2.5.5

