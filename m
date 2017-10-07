Return-Path: <ianwmorrison@gmail.com>
To: marcel@holtmann.org, gustavo@padovan.org, johan.hedberg@gmail.com,
 "bluez mailin list (linux-bluetooth@vger.kernel.org)"
 <linux-bluetooth@vger.kernel.org>
Cc: hdegoede@redhat.com, frederic.danis.oss@gmail.com
From: Ian W MORRISON <ianwmorrison@gmail.com>
Subject: [PATCH v2] Bluetooth: hci_bcm: Correct context of IRQ polarity
 message
Message-ID: <b54325b3-280f-4fc0-b340-8e4b850af603@gmail.com>
Date: Sat, 7 Oct 2017 17:16:08 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <linux-bluetooth.vger.kernel.org>

As the overwriting of IRQ polarity to active low occurs during the driver probe using 'bt_dev_warn' to display the warning results in '(null)' being displayed for the device. This patch uses 'dev_warn' to correctly display the device in the warning instead.

Signed-off-by: ianwmorrison <ianwmorrison@gmail.com>
---
v2: Uses 'dev_warn' (Suggested-by: Marcel Holtmann <marcel@holtmann.org>)

Testing shows the following improvements using an extract from dmesg of the affected message:

Without patch:
[    5.512175] Bluetooth: (null): MINIX Z83-4: Overwriting IRQ polarity to active low

v1 (superseded) patch:
[    5.592238] Bluetooth: MINIX Z83-4: Overwriting IRQ polarity to active low

v2 patch (with a kernel excluding serdev ACPI support patches):
[    6.112265] hci_bcm BCM2EA4:00: MINIX Z83-4: Overwriting IRQ polarity to active low

v2 patch (with a kernel including serdev ACPI support patches):
[    6.367829] hci_uart_bcm serial1-0: MINIX Z83-4: Overwriting IRQ polarity to active low
---
 drivers/bluetooth/hci_bcm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index 77326eeb6146..16c2eaaaf72b 100644
--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -839,7 +839,7 @@ static int bcm_acpi_probe(struct bcm_device *dev)
 
 	dmi_id = dmi_first_match(bcm_active_low_irq_dmi_table);
 	if (dmi_id) {
-		bt_dev_warn(dev, "%s: Overwriting IRQ polarity to active low",
+		dev_warn(dev->dev, "%s: Overwriting IRQ polarity to active low",
 			    dmi_id->ident);
 		dev->irq_active_low = true;
 	}
-- 
2.11.0
