Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: bpa10x: Fix missing BT_HCIUART dependency
Date: Thu,  8 Oct 2015 19:30:05 +0200
Message-Id: <1444325405-112323-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Selecting just BT_HCIUART_H4 is not enough and it also needs to select
BT_HCIUART to avoid this warning:

warning: (BT_HCIBPA10X) selects BT_HCIUART_H4 which has unmet direct
dependencies (NET && BT && BT_HCIUART)

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 drivers/bluetooth/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
index c9c5dd0bad36..fcf52fdb1ba3 100644
--- a/drivers/bluetooth/Kconfig
+++ b/drivers/bluetooth/Kconfig
@@ -184,6 +184,7 @@ config BT_HCIBCM203X
 config BT_HCIBPA10X
 	tristate "HCI BPA10x USB driver"
 	depends on USB
+	select BT_HCIUART
 	select BT_HCIUART_H4
 	help
 	  Bluetooth HCI BPA10x USB driver.
-- 
2.4.3

