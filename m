Return-Path: <cyrus@holtmann.org>
From: Vikram Kandukuri <Vikram.Kandukuri@Atheros.com>
To: Vikram Kandukuri <Vikram.Kandukuri@Atheros.com>, "marcel@holtmann.org"
	<marcel@holtmann.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-bluetooth@vger.kernel.org"
	<linux-bluetooth@vger.kernel.org>
CC: Luis Rodriguez <Luis.Rodriguez@Atheros.com>
Date: Tue, 1 Dec 2009 17:14:37 +0530
Subject: RE: [PATCH] DFU Driver for Atheros bluetooth chipset AR3011
Message-ID: <44EE5C37ADC36343B0625A05DD408C485069714222@CHEXMB-01.global.atheros.com>
References: <20091124101007.GC7551@atheros-laptop>
In-Reply-To: <20091124101007.GC7551@atheros-laptop>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

Signed-off-by: Vikram Kandukuri <Vikram.Kandukuri@atheors.com>
Signed-off-by: Alicke Xu <sxu@atheros.com>
Reviewed-by: Luis R. Rodriguez <lrodriguez@atheros.com>

---
 drivers/bluetooth/Kconfig  |   12 +++
 drivers/bluetooth/Makefile |    1 +
 drivers/bluetooth/ath3k.c  |  191 ++++++++++++++++++++++++++++++++++++++++=
++++
 3 files changed, 204 insertions(+), 0 deletions(-)
 create mode 100644 drivers/bluetooth/ath3k.c

diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
index 652367a..89f079e 100644
--- a/drivers/bluetooth/Kconfig
+++ b/drivers/bluetooth/Kconfig
@@ -195,5 +195,17 @@ config BT_MRVL_SDIO
          Say Y here to compile support for Marvell BT-over-SDIO driver
          into the kernel or say M to compile it as module.

+config BT_ATH3K
+       tristate "Atheros firmware download driver"
+       depends on BT_HCIBTUSB
+       select FW_LOADER
+       help
+         Bluetooth firmware download driver.
+         This driver loads the firmware into the Atheros bluetooth
+          chipset.
+
+         Say Y here to compile support for "Atheros AR30XX firmware downlo=
ad driver"
+          into the  kernel or say M to compile it as module (ath3k).
+
 endmenu

diff --git a/drivers/bluetooth/Makefile b/drivers/bluetooth/Makefile
index b3f57d2..6fcdeb7 100644
--- a/drivers/bluetooth/Makefile
+++ b/drivers/bluetooth/Makefile
@@ -15,6 +15,7 @@ obj-$(CONFIG_BT_HCIBTUART)    +=3D btuart_cs.o
 obj-$(CONFIG_BT_HCIBTUSB)      +=3D btusb.o
 obj-$(CONFIG_BT_HCIBTSDIO)     +=3D btsdio.o

+obj-$(CONFIG_BT_ATH3K)         +=3D ath3k.o
 obj-$(CONFIG_BT_MRVL)          +=3D btmrvl.o
 obj-$(CONFIG_BT_MRVL_SDIO)     +=3D btmrvl_sdio.o

diff --git a/drivers/bluetooth/ath3k.c b/drivers/bluetooth/ath3k.c
new file mode 100644
index 0000000..d338802
--- /dev/null
+++ b/drivers/bluetooth/ath3k.c
@@ -0,0 +1,191 @@
+/*
+ * Copyright (c) 2008-2009 Atheros Communications Inc.
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  =
USA
+ *
+ */
+
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/slab.h>
+#include <linux/types.h>
+#include <linux/errno.h>
+#include <linux/device.h>
+#include <linux/firmware.h>
+#include <linux/usb.h>
+#include <net/bluetooth/bluetooth.h>
+
+#define VERSION "1.0"
+
+
+static struct usb_device_id ath3k_table[] =3D {
+       /* Atheros AR3011 */
+       { USB_DEVICE(0x0CF3, 0x3000) },
+       { }     /* Terminating entry */
+};
+
+MODULE_DEVICE_TABLE(usb, ath3k_table);
+
+#define USB_REQ_DFU_DNLOAD     1
+#define FIRST_20BYTE            20
+#define BULK_SIZE               4096
+
+#define ATHBT_IN_EP(data)       (0x81)
+#define ATHBT_OUT_EP(data)     (0x02)
+
+struct ath3k_data {
+       struct usb_device *udev;
+       u8 *fw_data;
+       u32 fw_size;
+       u32 fw_sent;
+};
+
+static int ath3k_load_firmware(struct ath3k_data *data,
+                               unsigned char *firmware,
+                               int count)
+{
+       u8 *send_buf;
+       int err, pipe, len, size, sent =3D 0;
+
+       BT_DBG("ath3k %p udev %p\n", data, data->udev);
+
+       pipe =3D usb_sndctrlpipe(data->udev, 0);
+
+       if ((usb_control_msg(data->udev, pipe,
+                               USB_REQ_DFU_DNLOAD,
+                               USB_TYPE_VENDOR, 0, 0,
+                               firmware, 20, USB_CTRL_SET_TIMEOUT)) < 0) {
+               BT_ERR("Can't change to loading configuration err\n");
+               return -EBUSY;
+       }
+       sent +=3D 20;
+       count -=3D 20;
+
+       send_buf =3D kmalloc(BULK_SIZE, GFP_ATOMIC);
+       if (!send_buf) {
+               BT_ERR("Can't allocate memory chunk for firmware\n");
+               return -ENOMEM;
+       }
+
+       while (count) {
+               size =3D min_t(uint, count, BULK_SIZE);
+               pipe =3D usb_sndbulkpipe(data->udev, ATHBT_OUT_EP(data));
+               memcpy(send_buf, firmware + sent, size);
+
+               err =3D usb_bulk_msg(data->udev, pipe, send_buf, size,
+                                       &len, 3000);
+
+               if (err || (len !=3D size)) {
+                       BT_ERR("Error in firmware loading err =3D %d,"
+                               "len =3D %d, size =3D %d\n", err, len, size=
);
+                       goto error;
+               }
+
+               sent  +=3D size;
+               count -=3D size;
+       }
+
+       kfree(send_buf);
+       return 0;
+
+error:
+       kfree(send_buf);
+       return err;
+}
+
+static int ath3k_probe(struct usb_interface *intf,
+                       const struct usb_device_id *id)
+{
+       const struct firmware *firmware;
+       struct usb_device *udev =3D interface_to_usbdev(intf);
+       struct ath3k_data *data;
+       int size;
+
+       BT_DBG("ath3k_probe intf %p id %p\n", intf, id);
+
+       if (intf->cur_altsetting->desc.bInterfaceNumber !=3D 0)
+               return -ENODEV;
+
+       data =3D kzalloc(sizeof(*data), GFP_KERNEL);
+       if (!data)
+               return -ENOMEM;
+
+       data->udev  =3D udev;
+
+       if (request_firmware(&firmware, "ath3k-1.fw", &udev->dev) < 0) {
+               kfree(data);
+               return -EIO;
+       }
+
+       size =3D max_t(uint, firmware->size, 4096);
+       data->fw_data =3D kmalloc(size, GFP_KERNEL);
+       if (!data->fw_data) {
+               release_firmware(firmware);
+               kfree(data);
+               return -ENOMEM;
+       }
+
+       memcpy(data->fw_data, firmware->data, firmware->size);
+       data->fw_size =3D firmware->size;
+       data->fw_sent =3D 0;
+       release_firmware(firmware);
+
+       usb_set_intfdata(intf, data);
+       if (ath3k_load_firmware(data, data->fw_data, data->fw_size)) {
+               usb_set_intfdata(intf, NULL);
+               return -EIO;
+       }
+
+       return 0;
+}
+
+static void ath3k_disconnect(struct usb_interface *intf)
+{
+       struct ath3k_data *data =3D usb_get_intfdata(intf);
+
+       BT_DBG("ath3k_disconnect intf %p\n", intf);
+
+       kfree(data->fw_data);
+       kfree(data);
+}
+
+static struct usb_driver ath3k_driver =3D {
+       .name           =3D "ath3k",
+       .probe          =3D ath3k_probe,
+       .disconnect     =3D ath3k_disconnect,
+       .id_table       =3D ath3k_table,
+};
+
+static int __init ath3k_init(void)
+{
+       BT_INFO("Atheros AR30XX firmware driver ver %s", VERSION);
+       return usb_register(&ath3k_driver);
+}
+
+static void __exit ath3k_exit(void)
+{
+       usb_deregister(&ath3k_driver);
+}
+
+module_init(ath3k_init);
+module_exit(ath3k_exit);
+
+MODULE_AUTHOR("Atheros Communications");
+MODULE_DESCRIPTION("Atheros AR30XX firmware driver");
+MODULE_VERSION(VERSION);
+MODULE_LICENSE("GPL");
+MODULE_FIRMWARE("ath3k-1.fw");
--
1.6.0.4

--
Please let me know your comments on this patch.

Thanks
Vikram
