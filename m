Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: jonas.holmberg@axis.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: hci_bcm: Do not change uart speed
Date: Tue,  7 Feb 2017 13:53:42 +0100
Message-Id: <20170207125342.21962-1-jonashg@axis.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Jonas Holmberg <jonashg@axis.com>

Do not change from init_speed to oper_speed per default since it may
cause failures and timeouts if the uart cannot handle the new speed.
orig_speed should probably be set using device tree instead.
---
 drivers/bluetooth/hci_bcm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index 8f6c23c..7787f82 100644
--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -809,7 +809,7 @@ static const struct hci_uart_proto bcm_proto = {
 	.name		= "Broadcom",
 	.manufacturer	= 15,
 	.init_speed	= 115200,
-	.oper_speed	= 4000000,
+	.oper_speed	= 0,
 	.open		= bcm_open,
 	.close		= bcm_close,
 	.flush		= bcm_flush,
-- 
2.10.2

