Return-Path: <bjorn.andersson@linaro.org>
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Marcel Holtmann <marcel@holtmann.org>,
	Gustavo Padovan <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-bluetooth@vger.kernel.org,
	Bjorn Andersson <bjorn.andersson@sonymobile.com>
Subject: [PATCH v3 1/2] Bluetooth: Add HCI device identifier for Qualcomm SMD
Date: Fri, 12 Aug 2016 17:01:27 -0700
Message-Id: <1471046488-14860-1-git-send-email-bjorn.andersson@linaro.org>
List-ID: <linux-bluetooth.vger.kernel.org>

From: Bjorn Andersson <bjorn.andersson@sonymobile.com>

This patch assigns the next free HCI device identifier to Bluetooth
devices based on the Qualcomm Shared Memory channels.

Signed-off-by: Bjorn Andersson <bjorn.andersson@sonymobile.com>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v2:
- Bumped the id

 include/net/bluetooth/hci.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 003b25283407..0aac123b5eee 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -63,6 +63,7 @@
 #define HCI_SDIO	6
 #define HCI_SPI		7
 #define HCI_I2C		8
+#define HCI_SMD		9
 
 /* HCI controller types */
 #define HCI_PRIMARY	0x00
-- 
2.5.0
