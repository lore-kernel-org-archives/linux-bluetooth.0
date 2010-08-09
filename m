Return-Path: <cyrus@holtmann.org>
Message-ID: <4C604FAD.40801@csr.com>
Date: Mon, 09 Aug 2010 19:57:49 +0100
From: David Vrabel <david.vrabel@csr.com>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
CC: Marcel Holtmann <marcel@holtmann.org>
Subject: [PATCH] Bluetooth: Support SDIO devices that are AMP controllers
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Signed-off-by: David Vrabel <david.vrabel@csr.com>
---
  drivers/bluetooth/btsdio.c   |    4 ++++
  include/linux/mmc/sdio_ids.h |    1 +
  2 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/drivers/bluetooth/btsdio.c b/drivers/bluetooth/btsdio.c
index 76e5127..061e0a4 100644
--- a/drivers/bluetooth/btsdio.c
+++ b/drivers/bluetooth/btsdio.c
@@ -46,6 +46,9 @@ static const struct sdio_device_id btsdio_table[] = {
  	/* Generic Bluetooth Type-B SDIO device */
  	{ SDIO_DEVICE_CLASS(SDIO_CLASS_BT_B) },

+	/* Generic Bluetooth AMP controller */
+	{ SDIO_DEVICE_CLASS(SDIO_CLASS_BT_AMP) },
+
  	{ }	/* Terminating entry */
  };

@@ -327,6 +330,7 @@ static int btsdio_probe(struct sdio_func *func,
  	}

  	hdev->bus = HCI_SDIO;
+	hdev->dev_type = (id->class == SDIO_CLASS_BT_AMP) ? HCI_AMP : HCI_BREDR;
  	hdev->driver_data = data;

  	data->hdev = hdev;
diff --git a/include/linux/mmc/sdio_ids.h b/include/linux/mmc/sdio_ids.h
index 33b2ea0..a36ab3b 100644
--- a/include/linux/mmc/sdio_ids.h
+++ b/include/linux/mmc/sdio_ids.h
@@ -18,6 +18,7 @@
  #define SDIO_CLASS_PHS		0x06	/* PHS standard interface */
  #define SDIO_CLASS_WLAN		0x07	/* WLAN interface */
  #define SDIO_CLASS_ATA		0x08	/* Embedded SDIO-ATA std interface */
+#define SDIO_CLASS_BT_AMP	0x09	/* Type-A Bluetooth AMP interface */

  /*
   * Vendors and devices.  Sort key: vendor first, device next.
-- 
1.5.4.3

-- 
David Vrabel, Senior Software Engineer, Drivers
CSR, Churchill House, Cambridge Business Park,  Tel: +44 (0)1223 692562
Cowley Road, Cambridge, CB4 0WZ                 http://www.csr.com/


Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
