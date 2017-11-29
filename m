Return-Path: <hdegoede@redhat.com>
From: Hans de Goede <hdegoede@redhat.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Gustavo Padovan <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>,
	linux-bluetooth@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] Bluetooth: btsdio: Do not bind to non-removable BCM43341
Date: Wed, 29 Nov 2017 20:29:07 +0100
Message-Id: <20171129192907.27969-1-hdegoede@redhat.com>
List-ID: <linux-bluetooth.vger.kernel.org>

BCM43341 devices soldered onto the PCB (non-removable) always (AFAICT)
use an UART connection for bluetooth. But they also advertise btsdio
support on their 3th sdio function, this causes 2 problems:

1) A non functioning BT HCI getting registered

2) Since the btsdio driver does not have suspend/resume callbacks,
mmc_sdio_pre_suspend will return -ENOSYS, causing mmc_pm_notify()
to react as if the SDIO-card is removed and since the slot is
marked as non-removable it will never get detected as inserted again.
Which results in wifi no longer working after a suspend/resume.

This commit fixes both by making btsdio ignore BCM43341 devices
when connected to a slot which is marked non-removable.

Cc: stable@vger.kernel.org
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/bluetooth/btsdio.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/bluetooth/btsdio.c b/drivers/bluetooth/btsdio.c
index c8e945d19ffe..76c1405c7242 100644
--- a/drivers/bluetooth/btsdio.c
+++ b/drivers/bluetooth/btsdio.c
@@ -31,6 +31,7 @@
 #include <linux/errno.h>
 #include <linux/skbuff.h>
 
+#include <linux/mmc/host.h>
 #include <linux/mmc/sdio_ids.h>
 #include <linux/mmc/sdio_func.h>
 
@@ -292,6 +293,15 @@ static int btsdio_probe(struct sdio_func *func,
 		tuple = tuple->next;
 	}
 
+	/*
+	 * BCM43341 devices soldered onto the PCB (non-removable) use an
+	 * uart connection for bluetooth, ignore the BT SDIO interface.
+	 */
+	if (func->vendor == SDIO_VENDOR_ID_BROADCOM &&
+	    func->device == SDIO_DEVICE_ID_BROADCOM_43341 &&
+	    !mmc_card_is_removable(func->card->host))
+		return -ENODEV;
+
 	data = devm_kzalloc(&func->dev, sizeof(*data), GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
-- 
2.14.3
