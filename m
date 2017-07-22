Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: hci_nokia: select BT_BCM for btbcm_set_bdaddr()
Date: Sat, 22 Jul 2017 11:57:47 +0200
Message-Id: <20170722095747.101069-1-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The Nokia devices require the setup of its Public Bluetooth Device
Address and for that it is required to depend on vendor specific
commands. For Broadcom based Nokia devices, that is part of btbcm
module and can be selected via BT_BCM config option.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 drivers/bluetooth/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
index 35952a94875e..3a6ead603e49 100644
--- a/drivers/bluetooth/Kconfig
+++ b/drivers/bluetooth/Kconfig
@@ -98,6 +98,7 @@ config BT_HCIUART_NOKIA
 	depends on BT_HCIUART_SERDEV
 	depends on PM
 	select BT_HCIUART_H4
+	select BT_BCM
 	help
 	  Nokia H4+ is serial protocol for communication between Bluetooth
 	  device and host. This protocol is required for Bluetooth devices
-- 
2.13.3

