Return-Path: <ianwmorrison@gmail.com>
To: marcel@holtmann.org, gustavo@padovan.org, johan.hedberg@gmail.com,
 linux-bluetooth@vger.kernel.org
Cc: hdegoede@redhat.com, frederic.danis.oss@gmail.com
From: Ian W MORRISON <ianwmorrison@gmail.com>
Subject: [PATCH] Bluetooth: hci_bcm: Correct context of IRQ polarity message
Message-ID: <d9ad3bdc-2f94-b3b1-1ec1-786999c1e529@gmail.com>
Date: Fri, 6 Oct 2017 18:34:30 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <linux-bluetooth.vger.kernel.org>

As the overwriting of IRQ polarity to active low occurs during the driver
probe using 'bt_dev_warn' to display the warning results in '(null)' 
being displayed for the device. This patch uses the underlying 'BT_INFO'
to directly display the warning instead.

Signed-off-by: ianwmorrison <ianwmorrison@gmail.com>
---
 drivers/bluetooth/hci_bcm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index 77326eeb6146..17c036599407 100644
--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -839,7 +839,7 @@ static int bcm_acpi_probe(struct bcm_device *dev)
 
 	dmi_id = dmi_first_match(bcm_active_low_irq_dmi_table);
 	if (dmi_id) {
-		bt_dev_warn(dev, "%s: Overwriting IRQ polarity to active low",
+		BT_INFO("%s: Overwriting IRQ polarity to active low",
 			    dmi_id->ident);
 		dev->irq_active_low = true;
 	}
-- 
2.11.0
