Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: hci_bcm: Use operation speed of 4Mbps only for ACPI devices
Date: Wed, 16 Aug 2017 09:53:30 +0200
Message-Id: <20170816075330.45923-1-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Not all Broadcom controller support the 4Mbps operational speed on UART
devices. This is because the UART clock setting changes might not be
supported.

  < HCI Command: Broadcom Write UART Clock Setting (0x3f|0x0045) plen 1
         01                                               .
  > HCI Event: Command Complete (0x0e) plen 4
       Broadcom Write UART Clock Setting (0x3f|0x0045) ncmd 1
         Status: Unknown HCI Command (0x01)

To support any operational speed higher than 3Mbps, support for this
command is required. With that respect it is better to not enforce any
operational speed by default. Only when its support is known, then allow
for higher operational speed.

This patch assigns the 4Mbps opertional speed only for devices
discovered through ACPI and leave all others at the default 115200.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 drivers/bluetooth/hci_bcm.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index 6b42372c53ef..1eb286ade48a 100644
--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -59,6 +59,7 @@ struct bcm_device {
 	bool			clk_enabled;
 
 	u32			init_speed;
+	u32			oper_speed;
 	int			irq;
 	u8			irq_polarity;
 
@@ -303,6 +304,7 @@ static int bcm_open(struct hci_uart *hu)
 		if (hu->tty->dev->parent == dev->pdev->dev.parent) {
 			bcm->dev = dev;
 			hu->init_speed = dev->init_speed;
+			hu->oper_speed = dev->oper_speed;
 #ifdef CONFIG_PM
 			dev->hu = hu;
 #endif
@@ -699,8 +701,10 @@ static int bcm_resource(struct acpi_resource *ares, void *data)
 
 	case ACPI_RESOURCE_TYPE_SERIAL_BUS:
 		sb = &ares->data.uart_serial_bus;
-		if (sb->type == ACPI_RESOURCE_SERIAL_TYPE_UART)
+		if (sb->type == ACPI_RESOURCE_SERIAL_TYPE_UART) {
 			dev->init_speed = sb->default_baud_rate;
+			dev->oper_speed = 4000000;
+		}
 		break;
 
 	default:
@@ -853,7 +857,6 @@ static const struct hci_uart_proto bcm_proto = {
 	.name		= "Broadcom",
 	.manufacturer	= 15,
 	.init_speed	= 115200,
-	.oper_speed	= 4000000,
 	.open		= bcm_open,
 	.close		= bcm_close,
 	.flush		= bcm_flush,
-- 
2.13.5

