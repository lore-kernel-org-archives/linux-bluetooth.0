Return-Path: <loic.poulain@intel.com>
From: Loic Poulain <loic.poulain@intel.com>
To: marcel@holtmann.org
Cc: linux-bluetooth@vger.kernel.org,
	Loic Poulain <loic.poulain@intel.com>
Subject: [PATCH] Bluetooth: hci_bcm: Change protocol name
Date: Mon, 19 Sep 2016 12:05:12 +0200
Message-Id: <1474279512-5729-1-git-send-email-loic.poulain@intel.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Use full name instead of abbreviation.

Signed-off-by: Loic Poulain <loic.poulain@intel.com>
---
 drivers/bluetooth/hci_bcm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index 1c97eda..5ccb90e 100644
--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -798,7 +798,7 @@ static int bcm_remove(struct platform_device *pdev)
 
 static const struct hci_uart_proto bcm_proto = {
 	.id		= HCI_UART_BCM,
-	.name		= "BCM",
+	.name		= "Broadcom",
 	.manufacturer	= 15,
 	.init_speed	= 115200,
 	.oper_speed	= 4000000,
-- 
1.9.1
