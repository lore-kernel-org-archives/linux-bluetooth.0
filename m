Return-Path: <cyrus@holtmann.org>
From: Ilya Faenson <ifaenson@broadcom.com>
To: Marcel Holtmann <marcel@holtmann.org>
CC: <linux-bluetooth@vger.kernel.org>,
	Ilya Faenson <ifaenson@broadcom.com>
Subject: [RFC 2/2] Broadcom Bluetooth UART device driver
Date: Thu, 7 May 2015 16:25:29 -0400
Message-ID: <1431030329-22929-3-git-send-email-ifaenson@broadcom.com>
In-Reply-To: <1431030329-22929-1-git-send-email-ifaenson@broadcom.com>
References: <1431030329-22929-1-git-send-email-ifaenson@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This code implements the Broadcom Bluetooth device driver.
It manages device configuration, firmware download and
power management.

Signed-off-by: Ilya Faenson <ifaenson@broadcom.com>
---
 drivers/bluetooth/Kconfig      |  35 +-
 drivers/bluetooth/Makefile     |   1 +
 drivers/bluetooth/btbcm.c      | 173 ++++++++-
 drivers/bluetooth/btbcm.h      |  19 +-
 drivers/bluetooth/btbcm_uart.c | 679 +++++++++++++++++++++++++++++++++
 drivers/bluetooth/btbcm_uart.h |  90 +++++
 drivers/bluetooth/hci_bcm.c    | 838 +++++++++++++++++++++++++++++++++++++----
 7 files changed, 1745 insertions(+), 90 deletions(-)
 create mode 100644 drivers/bluetooth/btbcm_uart.c
 create mode 100644 drivers/bluetooth/btbcm_uart.h

diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
index ed5c273..1bfe36b 100644
--- a/drivers/bluetooth/Kconfig
+++ b/drivers/bluetooth/Kconfig
@@ -8,6 +8,12 @@ config BT_INTEL
 config BT_BCM
 	tristate
 	select FW_LOADER
+	help
+	  This feature is required if you want to use Broadcom Bluetooth
+	  over both USB and UART.
+
+	  Say Y here to compile support for Broadcom Bluetooth
+	  kernel or say M to compile it as module (btusb).
 
 config BT_HCIBTUSB
 	tristate "HCI USB driver"
@@ -22,15 +28,16 @@ config BT_HCIBTUSB
 	  kernel or say M to compile it as module (btusb).
 
 config BT_HCIBTUSB_BCM
-	bool "Broadcom protocol support"
+	bool "Broadcom USB support"
 	depends on BT_HCIBTUSB
 	select BT_BCM
 	default y
 	help
-	  The Broadcom protocol support enables firmware and patchram
-	  download support for Broadcom Bluetooth controllers.
+	  Broadcom Bluetooth USB driver support.
+	  The Broadcom USB support enables firmware and patchram
+	  download for Broadcom Bluetooth USB controllers.
 
-	  Say Y here to compile support for Broadcom protocol.
+	  Say Y here to compile support for Broadcom USB.
 
 config BT_HCIBTSDIO
 	tristate "HCI SDIO driver"
@@ -125,15 +132,25 @@ config BT_HCIUART_INTEL
 	  Say Y here to compile support for Intel protocol.
 
 config BT_HCIUART_BCM
-	bool "Broadcom protocol support"
-	depends on BT_HCIUART
+	bool "Broadcom BT UART serial support"
 	select BT_HCIUART_H4
+	select BT_UART_BCM
 	select BT_BCM
 	help
-	  The Broadcom protocol support enables Bluetooth HCI over serial
-	  port interface for Broadcom Bluetooth controllers.
+	  HCI_UART_BCM is a protocol for initializing, managing and
+	  communicating with Broadcom UART Bluetooth devices.
+	  This protocol initializes chips and power-manages them.
+	  Enable this if you have serial Broadcom Bluetooth device.
+
+	  Say Y here to compile support for Broadcom UART protocol.
+
+config BT_UART_BCM
+	tristate "Broadcom BT UART driver"
+	depends on BT_HCIUART_H4 && TTY
+	help
+	  This driver supports the HCI_UART_BT protocol.
 
-	  Say Y here to compile support for Broadcom protocol.
+	  It manages Bluetooth UART device properties and GPIOs.
 
 config BT_HCIBCM203X
 	tristate "HCI BCM203x USB driver"
diff --git a/drivers/bluetooth/Makefile b/drivers/bluetooth/Makefile
index dd0d9c4..0e5fd66 100644
--- a/drivers/bluetooth/Makefile
+++ b/drivers/bluetooth/Makefile
@@ -21,6 +21,7 @@ obj-$(CONFIG_BT_MRVL)		+= btmrvl.o
 obj-$(CONFIG_BT_MRVL_SDIO)	+= btmrvl_sdio.o
 obj-$(CONFIG_BT_WILINK)		+= btwilink.o
 obj-$(CONFIG_BT_BCM)		+= btbcm.o
+obj-$(CONFIG_BT_UART_BCM)	+= btbcm_uart.o
 
 btmrvl-y			:= btmrvl_main.o
 btmrvl-$(CONFIG_DEBUG_FS)	+= btmrvl_debugfs.o
diff --git a/drivers/bluetooth/btbcm.c b/drivers/bluetooth/btbcm.c
index 4bba866..3e9ac30 100644
--- a/drivers/bluetooth/btbcm.c
+++ b/drivers/bluetooth/btbcm.c
@@ -2,7 +2,8 @@
  *
  *  Bluetooth support for Broadcom devices
  *
- *  Copyright (C) 2015  Intel Corporation
+ *  Copyright (C) 2015 Intel Corporation
+ *  Copyright (C) 2015 Broadcom Corporation
  *
  *
  *  This program is free software; you can redistribute it and/or modify
@@ -15,24 +16,22 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
- *
  */
 
 #include <linux/module.h>
 #include <linux/firmware.h>
+#include <linux/tty.h>
 #include <asm/unaligned.h>
 
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
 
+#include "hci_uart.h"
 #include "btbcm.h"
 
-#define VERSION "0.1"
+#define VERSION "0.2"
 
-#define BDADDR_BCM20702A0 (&(bdaddr_t) {{0x00, 0xa0, 0x02, 0x70, 0x20, 0x00}})
+#define BDADDR_BCM20702A0 (&(bdaddr_t) {{0x00, 0xa0, 0x02, 0x70, 0x20, 0x00} })
 
 int btbcm_check_bdaddr(struct hci_dev *hdev)
 {
@@ -43,6 +42,7 @@ int btbcm_check_bdaddr(struct hci_dev *hdev)
 			     HCI_INIT_TIMEOUT);
 	if (IS_ERR(skb)) {
 		int err = PTR_ERR(skb);
+
 		BT_ERR("%s: BCM: Reading device address failed (%d)",
 		       hdev->name, err);
 		return err;
@@ -159,6 +159,8 @@ int btbcm_patchram(struct hci_dev *hdev, const char *firmware)
 	}
 
 	/* 250 msec delay after Launch Ram completes */
+	BT_INFO("%s: BCM: Delaying upon the patch download completion...",
+		hdev->name);
 	msleep(250);
 
 done:
@@ -174,6 +176,7 @@ static int btbcm_reset(struct hci_dev *hdev)
 	skb = __hci_cmd_sync(hdev, HCI_OP_RESET, 0, NULL, HCI_INIT_TIMEOUT);
 	if (IS_ERR(skb)) {
 		int err = PTR_ERR(skb);
+
 		BT_ERR("%s: BCM: Reset failed (%d)", hdev->name, err);
 		return err;
 	}
@@ -246,8 +249,10 @@ static struct sk_buff *btbcm_read_usb_product(struct hci_dev *hdev)
 static const struct {
 	u16 subver;
 	const char *name;
+	u32 baud_rate;	/* operational baud rate */
 } bcm_uart_subver_table[] = {
-	{ 0x410e, "BCM43341B0"	},	/* 002.001.014 */
+	{ 0x410e, "BCM43341B0", 3000000},                    /* 002.001.014 */
+	{ 0x610c, "BCM4354_003.001.012.0306.0659", 3000000}, /* 003.001.012 */
 	{ }
 };
 
@@ -268,6 +273,133 @@ static const struct {
 	{ }
 };
 
+/*
+ * Set the UART into the defaults
+ */
+int btbcm_init_uart(struct hci_uart *hu)
+{
+	struct ktermios ktermios;
+	struct tty_struct *tty = hu->tty;
+	int status, speed;
+
+	/* Bring UART into default setting at 115200 */
+	if (tty->ldisc->ops->flush_buffer)
+		tty->ldisc->ops->flush_buffer(tty);
+	tty_driver_flush_buffer(tty);
+	ktermios = tty->termios;
+	BT_DBG("init_uart def flags c_o %x c_l %x c_c %x spd %d/%d",
+	       ktermios.c_oflag, ktermios.c_lflag, ktermios.c_cflag,
+	       ktermios.c_ispeed, ktermios.c_ospeed);
+	       ktermios.c_iflag &= ~(IGNBRK | BRKINT | PARMRK | ISTRIP
+		| INLCR | IGNCR | ICRNL | IXON);
+	ktermios.c_oflag &= ~OPOST;
+	ktermios.c_lflag &= ~(ECHO | ECHONL | ICANON | ISIG | IEXTEN);
+	ktermios.c_cflag &= ~(CSIZE | PARENB | CBAUD);
+	ktermios.c_cflag |= CS8;
+	ktermios.c_cflag |= CRTSCTS;
+	ktermios.c_cflag |= B115200;
+	ktermios.c_ispeed = 115200;
+	ktermios.c_ospeed = 115200;
+	status = tty_set_termios(tty, &ktermios);
+	if (status) {
+		BT_DBG("init_uart set_termios failure %d", status);
+		return status;
+	}
+
+	speed = tty_get_baud_rate(tty);
+	BT_DBG("init_uart set_termios completed, spd %d", speed);
+	ktermios = tty->termios;
+	BT_DBG("init_uart new flags c_o %x c_l %x c_c %x spd %d/%d",
+	       ktermios.c_oflag, ktermios.c_lflag, ktermios.c_cflag,
+	       ktermios.c_ispeed, ktermios.c_ospeed);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(btbcm_init_uart);
+
+/*
+ * Set the baud rate on the UART and the device
+ */
+int btbcm_set_baud_rate(struct hci_uart *hu, int baud_rate)
+{
+	struct ktermios ktermios;
+	struct tty_struct *tty = hu->tty;
+	int status, speed, cflag;
+	struct sk_buff *skb;
+	unsigned char enable = 1;
+	unsigned char baud_rate_vsc_pars[] = {0, 0, 0, 0x10, 0x0e, 0};
+
+	/* If the baud rate is higher than 3000000, change the clock */
+	if (baud_rate > 3000000) {
+		skb = __hci_cmd_sync(hu->hdev, 0xfc45, 1, &enable,
+				     HCI_INIT_TIMEOUT);
+		if (IS_ERR(skb)) {
+			status = PTR_ERR(skb);
+			return status;
+		}
+
+		kfree_skb(skb);
+		BT_DBG("set_baud_rate write UART 48 MHz VSC succeeded");
+	}
+
+	/* Now let the device know about the rate change */
+	baud_rate_vsc_pars[2] = (unsigned char)(baud_rate & 0xff);
+	baud_rate_vsc_pars[3] = (unsigned char)((baud_rate >> 8) & 0xff);
+	baud_rate_vsc_pars[4] = (unsigned char)((baud_rate >> 16) & 0xff);
+	baud_rate_vsc_pars[5] = (unsigned char)((baud_rate >> 24) & 0xff);
+	skb = __hci_cmd_sync(hu->hdev, 0xfc18, sizeof(baud_rate_vsc_pars),
+			     baud_rate_vsc_pars, HCI_INIT_TIMEOUT);
+	if (IS_ERR(skb)) {
+		status = PTR_ERR(skb);
+		BT_ERR("set_baud_rate VSC failed (%d)", status);
+		return status;
+		}
+
+	kfree_skb(skb);
+	BT_DBG("set_baud_rate VSC succeeded");
+
+	/* Set UART into this rate as well */
+	ktermios = tty->termios;
+	BT_DBG("set_baud_rate start flags c_o %x c_l %x c_c %x spd %d/%d",
+	       ktermios.c_oflag, ktermios.c_lflag, ktermios.c_cflag,
+	       ktermios.c_ispeed, ktermios.c_ospeed);
+	switch (baud_rate) {
+	case 115200:
+		cflag |= B115200; break;
+	case 921600:
+		cflag |= B921600; break;
+	case 3000000:
+		cflag |= B3000000; break;
+	case 3500000:
+		cflag |= B3500000; break;
+	case 4000000:
+		cflag |= B4000000; break;
+	default:
+		BT_DBG("set_baud_rate unknown rate %d", baud_rate);
+		return -EINVAL;
+	}
+
+	ktermios.c_cflag &= ~CBAUD;
+	ktermios.c_cflag |= cflag;
+	ktermios.c_ispeed = baud_rate;
+	ktermios.c_ospeed = baud_rate;
+	status = tty_set_termios(tty, &ktermios);
+	if (status) {
+		BT_DBG("set_baud_rate set_termios failure %d", status);
+		return status;
+	}
+
+	speed = tty_get_baud_rate(tty);
+	BT_DBG("set_baud_rate set_termios completed, spd %d", speed);
+	ktermios = tty->termios;
+	BT_DBG("set_baud_rate flags c_o %x c_l %x c_c %x spd %d/%d",
+	       ktermios.c_oflag, ktermios.c_lflag, ktermios.c_cflag,
+	       ktermios.c_ispeed, ktermios.c_ospeed);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(btbcm_set_baud_rate);
+
 int btbcm_setup_patchram(struct hci_dev *hdev)
 {
 	char fw_name[64];
@@ -275,7 +407,8 @@ int btbcm_setup_patchram(struct hci_dev *hdev)
 	const char *hw_name = NULL;
 	struct sk_buff *skb;
 	struct hci_rp_read_local_version *ver;
-	int i, err;
+	int i, err, is_uart = false;
+	struct hci_uart *hu = hci_get_drvdata(hdev);
 
 	/* Reset */
 	err = btbcm_reset(hdev);
@@ -297,14 +430,18 @@ int btbcm_setup_patchram(struct hci_dev *hdev)
 	if (IS_ERR(skb))
 		return PTR_ERR(skb);
 
-	BT_INFO("%s: BCM: chip id %u", hdev->name, skb->data[1]);
+	BT_INFO("%s: BCM: chip id %u, rev 0x%x subver 0x%x",
+		hdev->name, skb->data[1], rev, subver);
 	kfree_skb(skb);
 
 	switch ((rev & 0xf000) >> 12) {
 	case 0:
+	case 1:
 		for (i = 0; bcm_uart_subver_table[i].name; i++) {
 			if (subver == bcm_uart_subver_table[i].subver) {
 				hw_name = bcm_uart_subver_table[i].name;
+				BT_INFO("UART firmware found: %s", hw_name);
+				is_uart = true;
 				break;
 			}
 		}
@@ -312,7 +449,7 @@ int btbcm_setup_patchram(struct hci_dev *hdev)
 		snprintf(fw_name, sizeof(fw_name), "brcm/%s.hcd",
 			 hw_name ? : "BCM");
 		break;
-	case 1:
+
 	case 2:
 		/* Read USB Product Info */
 		skb = btbcm_read_usb_product(hdev);
@@ -345,11 +482,25 @@ int btbcm_setup_patchram(struct hci_dev *hdev)
 	if (err == -ENOENT)
 		return 0;
 
+	/* Once the patch is downloaded, the device is back at default rate */
+	if (is_uart) {
+		err = btbcm_init_uart(hu);
+		if (err)
+			return 0;
+	}
+
 	/* Reset */
 	err = btbcm_reset(hdev);
 	if (err)
 		return err;
 
+	if (is_uart) {
+		err = btbcm_set_baud_rate(hu,
+					  bcm_uart_subver_table[i].baud_rate);
+		if (err)
+			return 0;
+	}
+
 	/* Read Local Version Info */
 	skb = btbcm_read_local_version(hdev);
 	if (IS_ERR(skb))
diff --git a/drivers/bluetooth/btbcm.h b/drivers/bluetooth/btbcm.h
index eb6ab5f..f7d30c6 100644
--- a/drivers/bluetooth/btbcm.h
+++ b/drivers/bluetooth/btbcm.h
@@ -2,7 +2,8 @@
  *
  *  Bluetooth support for Broadcom devices
  *
- *  Copyright (C) 2015  Intel Corporation
+ *  Copyright (C) 2015 Intel Corporation
+ *  Copyright (C) 2015 Broadcom Corporation
  *
  *
  *  This program is free software; you can redistribute it and/or modify
@@ -15,10 +16,6 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
- *
  */
 
 #if IS_ENABLED(CONFIG_BT_BCM)
@@ -30,6 +27,8 @@ int btbcm_patchram(struct hci_dev *hdev, const char *firmware);
 int btbcm_setup_patchram(struct hci_dev *hdev);
 int btbcm_setup_apple(struct hci_dev *hdev);
 
+int btbcm_init_uart(struct hci_uart *hu);
+int btbcm_set_baud_rate(struct hci_uart *hu, int baud_rate);
 #else
 
 static inline int btbcm_check_bdaddr(struct hci_dev *hdev)
@@ -57,4 +56,14 @@ static inline int btbcm_setup_apple(struct hci_dev *hdev)
 	return 0;
 }
 
+static int btbcm_init_uart(void *hu)
+{
+	return 0;
+}
+
+static int btbcm_set_baud_rate(void *hu, int baud_rate);
+{
+	return 0;
+}
+
 #endif
diff --git a/drivers/bluetooth/btbcm_uart.c b/drivers/bluetooth/btbcm_uart.c
new file mode 100644
index 0000000..3308bdb
--- /dev/null
+++ b/drivers/bluetooth/btbcm_uart.c
@@ -0,0 +1,679 @@
+/*
+ *
+ *  Bluetooth BCM UART Driver
+ *
+ *  Copyright (c) 2015 Broadcom Corporation
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
+ */
+
+#include <linux/module.h>
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/types.h>
+#include <linux/fcntl.h>
+#include <linux/interrupt.h>
+#include <linux/ptrace.h>
+#include <linux/poll.h>
+
+#include <linux/slab.h>
+#include <linux/tty.h>
+#include <linux/errno.h>
+#include <linux/string.h>
+#include <linux/signal.h>
+#include <linux/ioctl.h>
+#include <linux/skbuff.h>
+#include <linux/list.h>
+
+#include <net/bluetooth/bluetooth.h>
+#include <net/bluetooth/hci_core.h>
+
+#include <linux/gpio/consumer.h>
+#include <linux/of.h>
+#include <linux/of_gpio.h>
+#include <linux/of_platform.h>
+
+#include "btbcm_uart.h"
+
+static int idleTimeout = 5;
+module_param(idleTimeout, int, 0);
+MODULE_PARM_DESC(idleTimeout, "Bluetooth idle timeout in seconds");
+
+/* Device context */
+struct bcm_device {
+	struct list_head list;
+
+	struct platform_device *pdev;
+	struct gpio_desc *bt_wake_gpio;
+	struct gpio_desc *dev_wake_gpio;
+	struct gpio_desc *reg_on_gpio;
+	int bt_wake_irq;
+	int dev_wake_active_low;
+	int reg_on_active_low;
+	int bt_wake_active_low;
+	u32 configure_sleep;
+	u32 manual_fc;
+	u32 baud_rate_before_config_download;
+	u32 configure_audio;
+	u32 PCMClockMode;
+	u32 PCMFillMethod;
+	u32 PCMFillNum;
+	u32 PCMFillValue;
+	u32 PCMInCallBitclock;
+	u32 PCMLSBFirst;
+	u32 PCMRightJustify;
+	u32 PCMRouting;
+	u32 PCMShortFrameSync;
+	u32 PCMSyncMode;
+
+	char tty_name[64];
+
+	struct btbcm_uart_callbacks protocol_callbacks;
+	struct work_struct wakeup_work;
+};
+
+/* List of BCM BT UART devices */
+static DEFINE_SPINLOCK(device_list_lock);
+static LIST_HEAD(device_list);
+
+/*
+ * Calling the BCM protocol at lower execution priority
+ */
+static void bcm_bt_wakeup_task(struct work_struct *ws)
+{
+	int resume_flag;
+	struct bcm_device *p_bcm_device =
+		container_of(ws, struct bcm_device, wakeup_work);
+
+	if (!p_bcm_device) {
+		BT_DBG("bcm_bt_wakeup_task - failing, no device");
+		return;
+	}
+
+	/* Make sure the device is resumed */
+	resume_flag = !p_bcm_device->dev_wake_active_low;
+	if (p_bcm_device->dev_wake_gpio) {
+		gpiod_set_value(p_bcm_device->dev_wake_gpio, resume_flag);
+		BT_DBG("bcm_bt_wakeup_task - resume %d written, delaying 15 ms",
+		       resume_flag);
+		mdelay(15);
+	}
+
+	/* Let the protocol know it's time to wake up */
+	if (p_bcm_device->protocol_callbacks.p_wakeup)
+		p_bcm_device->protocol_callbacks.p_wakeup(
+			p_bcm_device->protocol_callbacks.context);
+}
+
+/*
+ * Interrupt routine for the wake from the device
+ */
+static irqreturn_t bcm_bt_uart_isr(int irq, void *context)
+{
+	unsigned int bt_wake;
+	struct bcm_device *p = (struct bcm_device *)context;
+
+	bt_wake = gpiod_get_value(p->bt_wake_gpio);
+	BT_DBG("bcm_bt_uart_isr with bt_wake of %d (active_low %d), req bh",
+	       bt_wake, p->bt_wake_active_low);
+
+	/* Defer the actual processing to the platform work queue */
+	schedule_work(&p->wakeup_work);
+	return IRQ_HANDLED;
+}
+
+/*
+ * Device instance startup
+ */
+static int bcm_bt_uart_probe(struct platform_device *pdev)
+{
+	int ret = 0;
+	struct device_node *np = pdev->dev.of_node;
+	const char *tty_name;
+	struct bcm_device *p_bcm_device = NULL;
+
+	p_bcm_device = devm_kzalloc(&pdev->dev, sizeof(*p_bcm_device),
+		GFP_KERNEL);
+	if (!p_bcm_device) {
+		BT_DBG("bcm_bt_uart_probe - failing due to no memory");
+		return -ENOMEM;
+	}
+	p_bcm_device->pdev = pdev;
+	BT_DBG("bcm_bt_uart_probe %p context", p_bcm_device);
+
+	/* Get dev wake GPIO */
+	p_bcm_device->dev_wake_gpio = gpiod_get(&pdev->dev, "bt-wake");
+	BT_DBG("bcm_bt_uart_probe - gpiod_get for bt-wake returned %p",
+	       p_bcm_device->dev_wake_gpio);
+	if (IS_ERR(p_bcm_device->dev_wake_gpio)) {
+		ret = PTR_ERR(p_bcm_device->dev_wake_gpio);
+		if (ret != -ENOENT) {
+			dev_err(&pdev->dev,
+				"bcm_bt_uart_probe - dev_wake GPIO: %d\n", ret);
+		}
+		p_bcm_device->dev_wake_gpio = NULL;
+	} else {
+		int resume_flag;
+
+		p_bcm_device->dev_wake_active_low = gpiod_is_active_low
+			(p_bcm_device->dev_wake_gpio);
+		BT_DBG("bcm_bt_uart_probe - dev_wake a-low is %d (cans %d)",
+		       p_bcm_device->dev_wake_active_low,
+		       gpiod_cansleep(p_bcm_device->dev_wake_gpio));
+
+		/* configure dev_wake as output with init resumed state */
+		resume_flag = !p_bcm_device->dev_wake_active_low;
+		ret = gpiod_direction_output(p_bcm_device->dev_wake_gpio,
+					     resume_flag);
+		if (ret < 0) {
+			dev_err(&pdev->dev,
+				"bcm_bt_uart_probe s dev_wake GPIO: %d\n", ret);
+			gpiod_put(p_bcm_device->dev_wake_gpio);
+			p_bcm_device->dev_wake_gpio = NULL;
+			goto end;
+		} else {
+			BT_DBG("bcm_bt_uart_probe - dev_wake set to %d",
+			       resume_flag);
+		}
+	}
+
+	/* Get power on/off GPIO */
+	p_bcm_device->reg_on_gpio = gpiod_get(&pdev->dev, "reg-on");
+	BT_DBG("bcm_bt_uart_probe - gpiod_get for reg-on returned %p",
+	       p_bcm_device->reg_on_gpio);
+	if (IS_ERR(p_bcm_device->reg_on_gpio)) {
+		ret = PTR_ERR(p_bcm_device->reg_on_gpio);
+		if (ret != -ENOENT) {
+			dev_err(&pdev->dev,
+				"bcm_bt_uart_probe - reg_on GPIO: %d\n", ret);
+		}
+		p_bcm_device->reg_on_gpio = NULL;
+	} else {
+		int poweron_flag;
+
+		p_bcm_device->reg_on_active_low = gpiod_is_active_low
+			(p_bcm_device->reg_on_gpio);
+		BT_DBG("bcm_bt_uart_probe - reg_on a-low is %d (cans %d)",
+		       p_bcm_device->reg_on_active_low,
+		       gpiod_cansleep(p_bcm_device->reg_on_gpio));
+
+		/* configure reg_on as output with init on state */
+		poweron_flag = !p_bcm_device->reg_on_active_low;
+		ret = gpiod_direction_output(p_bcm_device->reg_on_gpio,
+					     poweron_flag);
+		if (ret < 0) {
+			dev_err(&pdev->dev,
+				"bcm_bt_uart_probe s reg_on GPIO: %d\n", ret);
+			gpiod_put(p_bcm_device->reg_on_gpio);
+			p_bcm_device->reg_on_gpio = NULL;
+		} else {
+			BT_DBG("bcm_bt_uart_probe - reg_on initially set to %d",
+			       poweron_flag);
+		}
+	}
+
+	platform_set_drvdata(pdev, p_bcm_device);
+	/* Must be done before interrupt is requested */
+	INIT_WORK(&p_bcm_device->wakeup_work, bcm_bt_wakeup_task);
+
+	/* Get bt host wake GPIO */
+	p_bcm_device->bt_wake_gpio = gpiod_get(&pdev->dev, "bt-host-wake");
+	BT_DBG("bcm_bt_uart_probe - gpiod_get for bt-host-wake returned %p",
+	       p_bcm_device->bt_wake_gpio);
+	if (IS_ERR(p_bcm_device->bt_wake_gpio)) {
+		ret = PTR_ERR(p_bcm_device->bt_wake_gpio);
+		if (ret != -ENOENT) {
+			dev_err(&pdev->dev,
+				"bcm_bt_uart_probe - bt_wake GPIO: %d\n", ret);
+		}
+		p_bcm_device->bt_wake_gpio = NULL;
+	} else {
+		/* configure bt_wake as input */
+		ret = gpiod_direction_input(p_bcm_device->bt_wake_gpio);
+		if (ret < 0) {
+			dev_err(&pdev->dev,
+				"bcm_bt_uart_probe s bt_wake GPIO: %d\n", ret);
+			gpiod_put(p_bcm_device->bt_wake_gpio);
+			p_bcm_device->bt_wake_gpio = NULL;
+		} else {
+			p_bcm_device->bt_wake_active_low = gpiod_is_active_low
+				(p_bcm_device->bt_wake_gpio);
+			BT_DBG("bcm_bt_uart_probe -bt_wake a-low is %d(cans%d)",
+			       p_bcm_device->bt_wake_active_low,
+			       gpiod_cansleep(p_bcm_device->bt_wake_gpio));
+			p_bcm_device->bt_wake_irq = gpiod_to_irq
+				(p_bcm_device->bt_wake_gpio);
+			if (p_bcm_device->bt_wake_irq < 0) {
+				dev_err(&pdev->dev,
+				"bcm_bt_uart_probe - HOST_WAKE IRQ: %d\n", ret);
+			} else {
+				unsigned long intflags = IRQF_TRIGGER_RISING;
+
+				if (p_bcm_device->bt_wake_active_low)
+					intflags = IRQF_TRIGGER_FALLING;
+
+				ret = request_irq(p_bcm_device->bt_wake_irq,
+						  bcm_bt_uart_isr,
+						  intflags, "bt_host_wake",
+						  p_bcm_device);
+				if (ret < 0) {
+					dev_err(&pdev->dev, "bcm_bt_uart_probe - failed to conf IRQ %d: %d",
+						p_bcm_device->bt_wake_irq, ret);
+				} else {
+					BT_DBG("bcm_bt_uart_probe - IRQ %d",
+					       p_bcm_device->bt_wake_irq);
+				}
+			}
+		}
+	}
+
+	p_bcm_device->configure_sleep = 0;
+	if (!of_property_read_u32(np, "configure-sleep",
+				  &p_bcm_device->configure_sleep)) {
+		BT_DBG("configure-sleep read as %d",
+			p_bcm_device->configure_sleep);
+	}
+	p_bcm_device->manual_fc = 0;
+	if (!of_property_read_u32(np, "manual-fc",
+				  &p_bcm_device->manual_fc)) {
+		BT_DBG("manual-fc read as %d",
+			p_bcm_device->manual_fc);
+	}
+	p_bcm_device->baud_rate_before_config_download = 3000000;
+	if (!of_property_read_u32(
+		np, "baud-rate-before-config-download",
+		&p_bcm_device->baud_rate_before_config_download)) {
+		BT_DBG("baud-rate-before-config-download read as %d",
+			p_bcm_device->baud_rate_before_config_download);
+	}
+	p_bcm_device->configure_audio = 0;
+	if (!of_property_read_u32(np, "configure-audio",
+				  &p_bcm_device->configure_audio)) {
+		BT_DBG("configure-audio read as %d",
+			p_bcm_device->configure_audio);
+	}
+	if (p_bcm_device->configure_audio) {
+		/* Defaults for audio */
+		p_bcm_device->PCMClockMode = 0;
+		p_bcm_device->PCMFillMethod = 2;
+		p_bcm_device->PCMFillNum = 0;
+		p_bcm_device->PCMFillValue = 3;
+		p_bcm_device->PCMInCallBitclock = 0;
+		p_bcm_device->PCMLSBFirst = 0;
+		p_bcm_device->PCMRightJustify = 0;
+		p_bcm_device->PCMRouting = 0;
+		p_bcm_device->PCMShortFrameSync = 0;
+		p_bcm_device->PCMSyncMode = 0;
+
+		if (!of_property_read_u32(np, "PCMClockMode",
+					  &p_bcm_device->PCMClockMode))
+			BT_DBG("PCMClockMode read as %d",
+				p_bcm_device->PCMClockMode);
+		if (!of_property_read_u32(np, "PCMFillMethod",
+					  &p_bcm_device->PCMFillMethod))
+			BT_DBG("PCMFillMethod readas %d",
+				p_bcm_device->PCMFillMethod);
+		if (!of_property_read_u32(np, "PCMFillNum",
+					  &p_bcm_device->PCMFillNum))
+			BT_DBG("PCMFillNum read as %d",
+				p_bcm_device->PCMFillNum);
+		if (!of_property_read_u32(np, "PCMFillValue",
+					  &p_bcm_device->PCMFillValue))
+			BT_DBG("PCMFillValue read as %d",
+				p_bcm_device->PCMFillValue);
+		if (!of_property_read_u32(np, "PCMInCallBitclock",
+					  &p_bcm_device->PCMInCallBitclock))
+			BT_DBG("PCMInCallBitclock read as %d",
+				p_bcm_device->PCMInCallBitclock);
+		if (!of_property_read_u32(np, "PCMLSBFirst",
+					  &p_bcm_device->PCMLSBFirst))
+			BT_DBG("PCMLSBFirst read as %d",
+				p_bcm_device->PCMLSBFirst);
+		if (!of_property_read_u32(np, "PCMRightJustify",
+					  &p_bcm_device->PCMRightJustify))
+			BT_DBG("PCMRightJustify read as %d",
+				p_bcm_device->PCMRightJustify);
+		if (!of_property_read_u32(np, "PCMRouting",
+					  &p_bcm_device->PCMRouting))
+			BT_DBG("PCMRouting read as %d",
+				p_bcm_device->PCMRouting);
+		if (!of_property_read_u32(np, "PCMShortFrameSync",
+					  &p_bcm_device->PCMShortFrameSync))
+			BT_DBG("PCMShortFrameSync read as %d",
+				p_bcm_device->PCMShortFrameSync);
+		if (!of_property_read_u32(np, "PCMSyncMode",
+					  &p_bcm_device->PCMSyncMode))
+			BT_DBG("PCMSyncMode read as %d",
+				p_bcm_device->PCMSyncMode);
+	}
+
+	if (!of_property_read_string(np, "tty", &tty_name)) {
+		strcpy(p_bcm_device->tty_name, tty_name);
+		BT_DBG("tty name read as %s", p_bcm_device->tty_name);
+	}
+
+	BT_DBG("idleTimeout set as %d", idleTimeout);
+
+	ret = 0;  /* If we made it here, we're fine */
+
+	/* Place this instance on the device list */
+	spin_lock(&device_list_lock);
+	list_add_tail(&p_bcm_device->list, &device_list);
+	spin_unlock(&device_list_lock);
+
+end:
+	if (ret) {
+		if (p_bcm_device->reg_on_gpio) {
+			gpiod_put(p_bcm_device->reg_on_gpio);
+			p_bcm_device->reg_on_gpio = NULL;
+		}
+		if (p_bcm_device->bt_wake_gpio) {
+			gpiod_put(p_bcm_device->bt_wake_gpio);
+			p_bcm_device->bt_wake_gpio = NULL;
+		}
+		if (p_bcm_device->dev_wake_gpio) {
+			gpiod_put(p_bcm_device->dev_wake_gpio);
+			p_bcm_device->dev_wake_gpio = NULL;
+		}
+	}
+
+	BT_DBG("bcm_bt_uart_probe with the result %d", ret);
+	return ret;
+}
+
+/*
+ * Device instance removal
+ */
+static int bcm_bt_uart_remove(struct platform_device *pdev)
+{
+	struct bcm_device *p_bcm_device = platform_get_drvdata(pdev);
+
+	if (p_bcm_device == NULL) {
+		BT_DBG("bcm_bt_uart_remove - logic error, no probe?!");
+		return 0;
+	}
+
+	BT_DBG("bcm_bt_uart_remove %p context", p_bcm_device);
+
+	spin_lock(&device_list_lock);
+	list_del(&p_bcm_device->list);
+	spin_unlock(&device_list_lock);
+
+	BT_DBG("bcm_bt_uart_remove - freeing interrupt %d",
+		p_bcm_device->bt_wake_irq);
+	free_irq(p_bcm_device->bt_wake_irq, p_bcm_device);
+
+	if (p_bcm_device->reg_on_gpio) {
+		BT_DBG("bcm_bt_uart_remove - releasing reg_on_gpio");
+		gpiod_put(p_bcm_device->reg_on_gpio);
+		p_bcm_device->reg_on_gpio = NULL;
+	}
+
+	if (p_bcm_device->dev_wake_gpio) {
+		BT_DBG("bcm_bt_uart_remove - releasing dev_wake_gpio");
+		gpiod_put(p_bcm_device->dev_wake_gpio);
+		p_bcm_device->dev_wake_gpio = NULL;
+	}
+
+	if (p_bcm_device->bt_wake_gpio) {
+		BT_DBG("bcm_bt_uart_remove - releasing bt_wake_gpio");
+		gpiod_put(p_bcm_device->bt_wake_gpio);
+		p_bcm_device->bt_wake_gpio = NULL;
+	}
+
+	BT_DBG("bcm_bt_uart_remove %p done", p_bcm_device);
+	return 0;
+}
+
+/*
+ * Platform resume callback
+ */
+static int bcm_bt_uart_resume(struct device *pdev)
+{
+	int resume_flag;
+	struct bcm_device *p_bcm_device = platform_get_drvdata(
+		to_platform_device(pdev));
+
+	if (p_bcm_device == NULL) {
+		BT_DBG("bcm_bt_uart_resume - logic error, no device?!");
+		return 0;
+	}
+
+	BT_DBG("bcm_bt_uart_resume %p", p_bcm_device);
+
+	resume_flag = !p_bcm_device->dev_wake_active_low;
+	if (p_bcm_device->dev_wake_gpio) {
+		gpiod_set_value(p_bcm_device->dev_wake_gpio, resume_flag);
+		BT_DBG("bcm_bt_uart_resume: %d written, delaying 15 ms",
+		       resume_flag);
+		mdelay(15);
+	}
+
+	/* Let the protocol know the platform is resuming */
+	if (p_bcm_device->protocol_callbacks.p_resume)
+		p_bcm_device->protocol_callbacks.p_resume(
+			p_bcm_device->protocol_callbacks.context);
+
+	return 0;
+}
+
+/*
+ * Platform suspend callback
+ */
+static int bcm_bt_uart_suspend(struct device *pdev)
+{
+	int resume_flag;
+	struct bcm_device *p_bcm_device = platform_get_drvdata(
+		to_platform_device(pdev));
+
+	if (p_bcm_device == NULL) {
+		BT_DBG("bcm_bt_uart_suspend - logic error, no device?!");
+		return 0;
+	}
+
+	BT_DBG("bcm_bt_uart_suspend %p", p_bcm_device);
+
+	/* Let the protocol know the platform is suspending */
+	if (p_bcm_device->protocol_callbacks.p_suspend)
+		p_bcm_device->protocol_callbacks.p_suspend(
+			p_bcm_device->protocol_callbacks.context);
+
+	/* Suspend the device */
+	if (p_bcm_device->dev_wake_gpio) {
+		resume_flag = !p_bcm_device->dev_wake_active_low;
+		gpiod_set_value(p_bcm_device->dev_wake_gpio, !resume_flag);
+		BT_DBG("bcm_bt_uart_suspend: %d written, delaying 15 ms",
+			!resume_flag);
+		mdelay(15);
+	}
+
+	return 0;
+}
+
+/*
+ * Entry point for calls from the protocol
+ */
+int btbcm_uart_control(int action, void *device_context,
+	void *p_data, unsigned long *p_size)
+{
+	struct btbcm_uart_callbacks *pc;
+	struct btbcm_uart_parameters *pp = p_data; /* for pars action only */
+	int ret = 0;
+	int resume_flag, poweron_flag;
+	struct bcm_device *p_bcm_device = device_context;
+	struct list_head *ptr;
+	bool is_found = false;
+
+	/* Special processing for the callback configuration */
+	if (action == BTBCM_UART_ACTION_CONFIGURE_CALLBACKS) {
+		pc = p_data;
+
+		BT_DBG("btbcm_uart_control - configure callbacks");
+		if ((p_data == NULL) || *p_size != sizeof(struct
+			btbcm_uart_callbacks) || (pc->interface_version !=
+			BTBCM_UART_INTERFACE_VERSION)) {
+			BT_DBG("btbcm_uart_control - callbacks mismatch!");
+			return -E2BIG;
+		}
+
+		BT_DBG("btbcm_uart_control - configure callbacks for %s(%p)",
+		       pc->name, pc->context);
+		if (p_bcm_device == NULL) {
+			spin_lock(&device_list_lock);
+			list_for_each(ptr, &device_list) {
+				p_bcm_device = list_entry(ptr, struct
+							  bcm_device, list);
+				if (!strcmp(p_bcm_device->tty_name, pc->name)) {
+					is_found = true;
+					break;
+				}
+			}
+
+			spin_unlock(&device_list_lock);
+			if (!is_found) {
+				BT_DBG("btbcm_uart_control - no device!");
+				return -ENOENT;
+			}
+		}
+
+		p_bcm_device->protocol_callbacks = *pc;
+		memcpy(p_data, &p_bcm_device, sizeof(p_bcm_device));
+		*p_size = sizeof(p_bcm_device);
+		return ret;
+	}
+
+	/* All other requests must have the right context */
+	if (p_bcm_device == NULL) {
+		BT_DBG("btbcm_uart_control - failing, no device");
+		return -ENOENT;
+	}
+
+	switch (action) {
+	case BTBCM_UART_ACTION_POWER_ON:
+		BT_DBG("btbcm_uart_control %p - power on", device_context);
+		if (p_bcm_device->reg_on_gpio) {
+			poweron_flag = !p_bcm_device->reg_on_active_low;
+			gpiod_set_value(p_bcm_device->reg_on_gpio,
+					poweron_flag);
+			BT_DBG("btbcm_uart_control - pwron %d, delay 15 ms",
+			       poweron_flag);
+			mdelay(15);
+		}
+		break;
+
+	case BTBCM_UART_ACTION_POWER_OFF:
+		BT_DBG("btbcm_uart_control %p - power off", device_context);
+		if (p_bcm_device->reg_on_gpio) {
+			poweron_flag = p_bcm_device->reg_on_active_low;
+			gpiod_set_value(p_bcm_device->reg_on_gpio,
+					poweron_flag);
+			BT_DBG("btbcm_uart_control - pwroff %d, delay 15 ms",
+			       poweron_flag);
+			mdelay(15);
+		}
+		break;
+
+	case BTBCM_UART_ACTION_RESUME:
+		BT_DBG("btbcm_uart_control %p - resume", device_context);
+		if (p_bcm_device->dev_wake_gpio) {
+			resume_flag = !p_bcm_device->dev_wake_active_low;
+			gpiod_set_value(p_bcm_device->dev_wake_gpio,
+					resume_flag);
+			BT_DBG("btbcm_uart_control - resume %d, delay 15 ms",
+			       resume_flag);
+			mdelay(15);
+		}
+		break;
+
+	case BTBCM_UART_ACTION_SUSPEND:
+		BT_DBG("btbcm_uart_control %p - suspend", device_context);
+		if (p_bcm_device->dev_wake_gpio) {
+			resume_flag = !p_bcm_device->dev_wake_active_low;
+			gpiod_set_value(p_bcm_device->dev_wake_gpio,
+					!resume_flag);
+			BT_DBG("btbcm_uart_control - suspend %d, delay 15ms",
+			       !resume_flag);
+			mdelay(15);
+		}
+		break;
+
+	case BTBCM_UART_ACTION_GET_PARAMETERS:
+		BT_DBG("btbcm_uart_control %p - get pars", device_context);
+		if ((p_data == NULL) ||
+			(*p_size < sizeof(struct btbcm_uart_parameters))) {
+			BT_DBG("btbcm_uart_control - failing, wrong par size");
+			return -E2BIG;
+		}
+
+		memset(pp, 0, sizeof(struct btbcm_uart_parameters));
+		pp->interface_version = BTBCM_UART_INTERFACE_VERSION;
+		pp->configure_sleep = p_bcm_device->configure_sleep;
+		pp->manual_fc = p_bcm_device->manual_fc;
+		pp->dev_wake_active_low = p_bcm_device->dev_wake_active_low;
+		pp->bt_wake_active_low = p_bcm_device->bt_wake_active_low;
+		pp->idle_timeout_in_secs = idleTimeout;
+		pp->baud_rate_before_config_download =
+			p_bcm_device->baud_rate_before_config_download;
+		pp->configure_audio = p_bcm_device->configure_audio;
+		pp->PCMClockMode = p_bcm_device->PCMClockMode;
+		pp->PCMFillMethod = p_bcm_device->PCMFillMethod;
+		pp->PCMFillNum = p_bcm_device->PCMFillNum;
+		pp->PCMFillValue = p_bcm_device->PCMFillValue;
+		pp->PCMInCallBitclock = p_bcm_device->PCMInCallBitclock;
+		pp->PCMLSBFirst = p_bcm_device->PCMLSBFirst;
+		pp->PCMRightJustify = p_bcm_device->PCMRightJustify;
+		pp->PCMRouting = p_bcm_device->PCMRouting;
+		pp->PCMShortFrameSync = p_bcm_device->PCMShortFrameSync;
+		pp->PCMSyncMode = p_bcm_device->PCMSyncMode;
+		*p_size = sizeof(struct btbcm_uart_parameters);
+		break;
+
+	default:
+		BT_DBG("btbcm_uart_control %p unknown act %d",
+		       device_context, action);
+		ret = -EINVAL;
+		break;
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL(btbcm_uart_control);
+
+/* Platform susp and resume callbacks */
+static SIMPLE_DEV_PM_OPS(bcm_bt_uart_pm_ops,
+	bcm_bt_uart_suspend, bcm_bt_uart_resume);
+
+/* Driver match table */
+static const struct of_device_id bcm_bt_uart_match_table[] = {
+	{ .compatible = "brcm,brcm-bt-uart" },
+	{}
+};
+
+/* Driver configuration */
+static struct platform_driver bcm_bt_uart_platform_driver = {
+	.probe = bcm_bt_uart_probe,
+	.remove = bcm_bt_uart_remove,
+	.driver = {
+		.name = "brcm_bt_uart",
+		.of_match_table = of_match_ptr(bcm_bt_uart_match_table),
+		.owner = THIS_MODULE,
+		.pm = &bcm_bt_uart_pm_ops,
+	},
+};
+
+module_platform_driver(bcm_bt_uart_platform_driver);
+
+MODULE_AUTHOR("Ilya Faenson");
+MODULE_DESCRIPTION("Broadcom Bluetooth UART Driver");
+MODULE_LICENSE("Dual BSD/GPL");
+
diff --git a/drivers/bluetooth/btbcm_uart.h b/drivers/bluetooth/btbcm_uart.h
new file mode 100644
index 0000000..5801753
--- /dev/null
+++ b/drivers/bluetooth/btbcm_uart.h
@@ -0,0 +1,90 @@
+/*
+ *
+ *  Bluetooth BCM UART Driver Header
+ *
+ *  Copyright (c) 2015 Broadcom Corporation
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
+ */
+#ifndef BTBCM_UART_H
+#define BTBCM_UART_H
+
+/* Change the version if you change anything in this header */
+#define BTBCM_UART_INTERFACE_VERSION 1
+
+/* Callbacks from the driver into the protocol */
+typedef void (*p_suspend_callback)(void *context);
+typedef void (*p_resume_callback)(void *context);
+typedef void (*p_wakeup_callback)(void *context);
+struct btbcm_uart_callbacks {
+	int interface_version; /* interface # compiled against */
+	void *context;         /* protocol instance context */
+	char name[64];         /* protocol tty device, for example, ttyS0 */
+
+	/* Callbacks proper */
+	p_suspend_callback p_suspend;
+	p_resume_callback p_resume;
+	p_wakeup_callback p_wakeup;
+};
+
+/* Driver parameters retrieved from the DT or ACPI */
+struct btbcm_uart_parameters {
+	int interface_version; /* interface # compiled against */
+
+	/* Parameters proper */
+	int configure_sleep;
+	int manual_fc;
+	int dev_wake_active_low;
+	int bt_wake_active_low;
+	int idle_timeout_in_secs;
+	int baud_rate_before_config_download;
+	int configure_audio;
+	int PCMClockMode;
+	int PCMFillMethod;
+	int PCMFillNum;
+	int PCMFillValue;
+	int PCMInCallBitclock;
+	int PCMLSBFirst;
+	int PCMRightJustify;
+	int PCMRouting;
+	int PCMShortFrameSync;
+	int PCMSyncMode;
+};
+
+/*
+ * Actions on the BTBCM_UART driver
+ */
+
+/* Configure protocol callbacks */
+#define BTBCM_UART_ACTION_CONFIGURE_CALLBACKS 0
+
+/* Retrieve BT device parameters */
+#define BTBCM_UART_ACTION_GET_PARAMETERS      1
+
+/* Resume the BT device via GPIO */
+#define BTBCM_UART_ACTION_RESUME              2
+
+/* Suspend the BT device via GPIO */
+#define BTBCM_UART_ACTION_SUSPEND             3
+
+/* Power the BT device off via GPIO */
+#define BTBCM_UART_ACTION_POWER_OFF           4
+
+/* Power the BT device on via GPIO */
+#define BTBCM_UART_ACTION_POWER_ON            5
+
+/* Execute an action on the BT device */
+extern int btbcm_uart_control(int action, void *device_context,
+			      void *p_data, unsigned long *p_size);
+
+#endif
+
diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index 1ec0b4a..e70f89b 100644
--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -1,8 +1,13 @@
 /*
  *
- *  Bluetooth HCI UART driver for Broadcom devices
+ *  Bluetooth UART H4 protocol for Broadcom devices
  *
- *  Copyright (C) 2015  Intel Corporation
+ *  Copyright (c) 2015 Intel Corporation
+ *  Copyright (c) 2015 Broadcom Corporation
+ *
+ *  Acknowledgements:
+ *  This file has been based on hci_h4.c originally developed
+ *  by Maxim Krasnyansky and Marcel Holtmann.
  *
  *
  *  This program is free software; you can redistribute it and/or modify
@@ -15,139 +20,842 @@
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU General Public License for more details.
  *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
- *
  */
 
+#include <linux/module.h>
+
 #include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/types.h>
+#include <linux/fcntl.h>
+#include <linux/interrupt.h>
+#include <linux/ptrace.h>
+#include <linux/poll.h>
+
+#include <linux/slab.h>
+#include <linux/tty.h>
 #include <linux/errno.h>
+#include <linux/string.h>
+#include <linux/signal.h>
+#include <linux/ioctl.h>
 #include <linux/skbuff.h>
 
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
 
-#include "btbcm.h"
+#include <linux/gpio/consumer.h>
+#include <linux/of_gpio.h>
+#include <linux/of_platform.h>
+
 #include "hci_uart.h"
+#include "btbcm.h"
+#include "btbcm_uart.h"
 
-struct bcm_data {
-	struct sk_buff *rx_skb;
+/* Protocol context */
+struct bcm_h4_struct {
 	struct sk_buff_head txq;
+	struct hci_uart *hu;
+
+	bool is_suspended; /* suspend/resume flag */
+
+	/* Recv data parsing is not used in normal operation */
+	bool parse_recv;
+	/* buffer includes the type */
+	unsigned char reassembly[1 + HCI_MAX_FRAME_SIZE];
+	unsigned int rsize;
+	u16 rexpected;
+
+	struct timer_list timer; /* idle timer */
+
+	struct btbcm_uart_parameters pars; /* device parameters */
+	void *device_context; /* ACPI/DT device context */
 };
 
-static int bcm_open(struct hci_uart *hu)
+/* Static function prototypes for forward references */
+static void suspend_notification(void *context);
+static void resume_notification(void *context);
+static void wakeup_notification(void *context);
+static void bcm_ensure_wakeup(struct hci_uart *hu);
+
+/* Suspend/resume synchronization mutex */
+static DEFINE_MUTEX(plock);
+
+/*
+ * Idle timer callback
+ */
+static void bcm_idle_timeout(unsigned long arg)
 {
-	struct bcm_data *bcm;
+	struct hci_uart *hu = (struct hci_uart *)arg;
+	struct bcm_h4_struct *h4 = hu->priv;
+	int status;
 
-	BT_DBG("hu %p", hu);
+	BT_DBG("bcm_idle_timeout hu %p", hu);
+
+	/* Suspend/resume operations are serialized */
+	mutex_lock(&plock);
+
+	if (!h4->is_suspended) {
+		/* Flow control the port if configured */
+		suspend_notification(hu);
+
+		/* Suspend the device */
+		status = btbcm_uart_control(BTBCM_UART_ACTION_SUSPEND,
+					    h4->device_context, NULL, NULL);
+		if (status)
+			BT_DBG("bcm_idle_timeout failed to suspend device %d",
+			       status);
+	}
 
-	bcm = kzalloc(sizeof(*bcm), GFP_KERNEL);
-	if (!bcm)
+	mutex_unlock(&plock);
+}
+
+/*
+ * Initialize protocol
+ */
+static int bcm_h4_open(struct hci_uart *hu)
+{
+	struct btbcm_uart_callbacks callbacks;
+	unsigned long callbacks_size = sizeof(callbacks);
+	int status;
+	struct bcm_h4_struct *h4;
+	struct tty_struct *tty = hu->tty;
+
+	BT_DBG("bcm_h4_open hu %p", hu);
+
+	h4 = kzalloc(sizeof(*h4), GFP_KERNEL);
+	if (!h4)
 		return -ENOMEM;
 
-	skb_queue_head_init(&bcm->txq);
+	skb_queue_head_init(&h4->txq);
+	hu->priv = h4;
+	h4->hu = hu;
+	h4->is_suspended = false;
+	h4->parse_recv = false;
+	h4->rsize = 0;
+
+	/* Configure callbacks on the driver */
+	callbacks.interface_version = BTBCM_UART_INTERFACE_VERSION;
+	callbacks.context = hu;
+	strcpy(callbacks.name, tty->name);
+	callbacks.p_suspend = suspend_notification;
+	callbacks.p_resume = resume_notification;
+	callbacks.p_wakeup = wakeup_notification;
+	status = btbcm_uart_control(BTBCM_UART_ACTION_CONFIGURE_CALLBACKS,
+				    NULL, &callbacks, &callbacks_size);
+	if (status) {
+		BT_DBG("bcm_h4_open failed to set driver callbacks %d", status);
+		return status;
+	}
+	if (callbacks_size != sizeof(void *)) {
+		BT_DBG("bcm_h4_open got back %d bytes from callbacks?!",
+		       (int)callbacks_size);
+		return -EMSGSIZE;
+	}
+	memcpy(&h4->device_context, &callbacks, sizeof(void *));
+	BT_DBG("bcm_h4_open callbacks context %p", h4->device_context);
+
+	/* Retrieve device parameters */
+	callbacks_size = sizeof(h4->pars);
+	status = btbcm_uart_control(BTBCM_UART_ACTION_GET_PARAMETERS,
+				    h4->device_context, &h4->pars,
+				    &callbacks_size);
+	if (status) {
+		BT_DBG("bcm_h4_open failed to get dev parameters %d", status);
+		return status;
+	}
+	BT_DBG("Pars ver %d csleep %d dalow %d balow %d idle %d",
+	       h4->pars.interface_version, h4->pars.configure_sleep,
+	       h4->pars.dev_wake_active_low, h4->pars.bt_wake_active_low,
+	       h4->pars.idle_timeout_in_secs);
+
+	/* Cycle power to make sure the device is in the known state */
+	status = btbcm_uart_control(BTBCM_UART_ACTION_POWER_OFF,
+				    h4->device_context, NULL, NULL);
+	if (status) {
+		BT_DBG("bcm_h4_open failed to power off %d", status);
+	} else {
+		status = btbcm_uart_control(BTBCM_UART_ACTION_POWER_ON,
+					    h4->device_context, NULL, NULL);
+		if (status)
+			BT_DBG("bcm_h4_open failed to power on %d", status);
+	}
+
+	/* Start the idle timer */
+	if (h4->pars.configure_sleep) {
+		setup_timer(&h4->timer, bcm_idle_timeout, (unsigned long)hu);
+		if (h4->pars.configure_sleep)
+			mod_timer(&h4->timer, jiffies + msecs_to_jiffies(
+				  h4->pars.idle_timeout_in_secs * 1000));
+	}
+
+	return 0;
+}
+
+/*
+ * Flush protocol data
+ */
+static int bcm_h4_flush(struct hci_uart *hu)
+{
+	struct bcm_h4_struct *h4 = hu->priv;
 
-	hu->priv = bcm;
+	BT_DBG("bcm_h4_flush hu %p", hu);
+
+	skb_queue_purge(&h4->txq);
 	return 0;
 }
 
-static int bcm_close(struct hci_uart *hu)
+/*
+ * Make sure we're awake
+ * (called when the resumed state is required)
+ */
+static void bcm_ensure_wakeup(struct hci_uart *hu)
 {
-	struct bcm_data *bcm = hu->priv;
+	struct bcm_h4_struct *h4 = hu->priv;
+	int status;
+
+	if (!h4->pars.configure_sleep)
+		return;
+
+	/* Suspend/resume operations are serialized */
+	mutex_lock(&plock);
+
+	/* Nothing to do if resumed already */
+	if (!h4->is_suspended) {
+		mutex_unlock(&plock);
 
-	BT_DBG("hu %p", hu);
+		/* Just reset the timer */
+		status = mod_timer(&h4->timer, jiffies + msecs_to_jiffies(
+				   h4->pars.idle_timeout_in_secs * 1000));
+		return;
+	}
+
+	/* Wakeup the device */
+	status = btbcm_uart_control(BTBCM_UART_ACTION_RESUME,
+				    h4->device_context, NULL, NULL);
+	if (status)
+		BT_DBG("bcm_ensure_wakeup failed to resume driver %d", status);
 
-	skb_queue_purge(&bcm->txq);
-	kfree_skb(bcm->rx_skb);
-	kfree(bcm);
+	/* Unflow control the port if configured */
+	resume_notification(hu);
+
+	mutex_unlock(&plock);
+}
+
+/*
+ * Close protocol
+ */
+static int bcm_h4_close(struct hci_uart *hu)
+{
+	struct btbcm_uart_callbacks callbacks;
+	unsigned long callbacks_size = sizeof(callbacks);
+	struct bcm_h4_struct *h4 = hu->priv;
+	int status;
 
 	hu->priv = NULL;
+
+	BT_DBG("bcm_h4_close hu %p", hu);
+
+	/* If we're being closed, we must suspend */
+	if (h4->pars.configure_sleep) {
+		mutex_lock(&plock);
+
+		if (!h4->is_suspended) {
+			/* Flow control the port */
+			suspend_notification(hu);
+
+			/* Suspend the device */
+			status = btbcm_uart_control(BTBCM_UART_ACTION_SUSPEND,
+						    h4->device_context, NULL,
+						    NULL);
+			if (status) {
+				BT_DBG("bcm_h4_close suspend driver fail %d",
+				       status);
+			}
+		}
+
+	mutex_unlock(&plock);
+
+	del_timer_sync(&h4->timer);
+	}
+
+	/* Power off the device if possible */
+	status = btbcm_uart_control(BTBCM_UART_ACTION_POWER_OFF,
+				    h4->device_context, NULL, NULL);
+	if (status)
+		BT_DBG("bcm_h4_close failed to power off %d", status);
+
+	/* de-configure callbacks on the driver */
+	callbacks.interface_version = BTBCM_UART_INTERFACE_VERSION;
+	callbacks.context = hu;
+	callbacks.p_suspend = NULL;
+	callbacks.p_resume = NULL;
+	callbacks.p_wakeup = NULL;
+	status = btbcm_uart_control(BTBCM_UART_ACTION_CONFIGURE_CALLBACKS,
+				    h4->device_context, &callbacks,
+				    &callbacks_size);
+	if (status)
+		BT_DBG("bcm_h4_close failed to reset drv callbacks %d", status);
+	skb_queue_purge(&h4->txq);
+
+	hu->priv = NULL;
+	kfree(h4);
+
 	return 0;
 }
 
-static int bcm_flush(struct hci_uart *hu)
+/*
+ * Enqueue frame for transmittion (padding, crc, etc)
+ */
+static int bcm_h4_enqueue(struct hci_uart *hu, struct sk_buff *skb)
 {
-	struct bcm_data *bcm = hu->priv;
+	struct bcm_h4_struct *h4 = hu->priv;
+
+	BT_DBG("bcm_h4_enqueue hu %p skb %p type %d len %d (%x %x %x)",
+	       hu, skb, bt_cb(skb)->pkt_type, skb->len,
+		skb->data[0], skb->data[1], skb->data[2]);
 
-	BT_DBG("hu %p", hu);
+	/* Make sure we're resumed */
+	bcm_ensure_wakeup(hu);
 
-	skb_queue_purge(&bcm->txq);
+	/* Prepend skb with frame type */
+	memcpy(skb_push(skb, 1), &bt_cb(skb)->pkt_type, 1);
+	skb_queue_tail(&h4->txq, skb);
 
 	return 0;
 }
 
-static int bcm_setup(struct hci_uart *hu)
+/*
+ * HCI event processing if our own parsing of events is required
+ * NOTE: return 0 if the event is not to be passed up to BlueZ
+ */
+static bool bcm_process_hci_event(struct hci_uart *hu)
+{
+	struct bcm_h4_struct *h4 = hu->priv;
+	int status;
+	unsigned char evt_code = h4->reassembly[1];
+	unsigned char len = h4->reassembly[2];
+
+	BT_DBG("bcm_process_hci_event %02x event %02x len %02x %02x",
+	       h4->reassembly[0], evt_code, len, h4->reassembly[3]);
+
+	/* switch (evt_code) { case HCI_EV_CMD_COMPLETE: break } */
+
+	status = hci_recv_stream_fragment(hu->hdev, h4->reassembly, h4->rsize);
+	if (status < 0)
+		BT_ERR("bcm_process_hci_event - reassembly failed %d", status);
+	return true;
+}
+
+/*
+ * ACL data processing if our own parsing of data is required
+ * NOTE: return 0 if the data is not to be passed up to BlueZ
+ */
+static bool bcm_process_acl_data(struct hci_uart *hu)
 {
-	BT_DBG("hu %p", hu);
+	struct bcm_h4_struct *h4 = hu->priv;
+	int ret;
 
-	hu->hdev->set_bdaddr = btbcm_set_bdaddr;
+	BT_DBG("bcm_process_acl_data %02x %02x %02x %02x %02x",
+	       h4->reassembly[0], h4->reassembly[1], h4->reassembly[2],
+	       h4->reassembly[3], h4->reassembly[4]);
 
-	return btbcm_setup_patchram(hu->hdev);
+	ret = hci_recv_stream_fragment(hu->hdev, h4->reassembly, h4->rsize);
+	if (ret < 0)
+		BT_ERR("bcm_process_acl_data - Frame Reassembly Failed");
+	return true;
 }
 
-static const struct h4_recv_pkt bcm_recv_pkts[] = {
-	{ H4_RECV_ACL,   .recv = hci_recv_frame },
-	{ H4_RECV_SCO,   .recv = hci_recv_frame },
-	{ H4_RECV_EVENT, .recv = hci_recv_frame },
-};
+/*
+ * Fragment parsing in the active filtering phase
+ * (not currently actively used)
+ */
+static void parse_fragment(struct hci_uart *hu, unsigned char *data, int count)
+{
+	struct bcm_h4_struct *h4 = hu->priv;
+
+	if (h4->rsize)
+		BT_DBG("parse_fragment type %x expected %d",
+		       h4->reassembly[0], h4->rexpected);
+
+	while (count) {
+		if (!h4->rsize) {
+			/* Start of the frame */
+			h4->reassembly[0] = *data++;
+			h4->rsize++;
+			count--;
+			continue;
+		}
+
+		switch (h4->reassembly[0]) {
+		case HCI_EVENT_PKT:
+		if (h4->rsize == 1) {
+			/* event proper */
+			h4->reassembly[h4->rsize++] = *data++;
+			count--;
+			continue;
+		}
+		if (h4->rsize == 2) {
+			/* length */
+			h4->rexpected = *data;
+			h4->reassembly[h4->rsize++] = *data++;
+			count--;
+			BT_DBG("evthdr len %d, left %d", h4->rexpected, count);
+			continue;
+		}
+		if (count >= h4->rexpected) {
+			memcpy(&h4->reassembly[h4->rsize], data, h4->rexpected);
+			h4->rsize += h4->rexpected;
+			data += h4->rexpected;
+			count -= h4->rexpected;
+			bcm_process_hci_event(hu);
+			h4->rsize = 0; /* starting anew */
+			continue;
+		}
+		/* only piece of the event received */
+		memcpy(&h4->reassembly[h4->rsize], data, count);
+		h4->rsize += count;
+		data += count;
+		h4->rexpected -= count;
+		count = 0;
+		break;
+
+		case HCI_ACLDATA_PKT:
+		if ((h4->rsize == 1) || (h4->rsize == 2) || (h4->rsize == 3)) {
+			/* handle and first byte of length */
+			h4->reassembly[h4->rsize++] = *data++;
+			count--;
+			continue;
+		}
+		if (h4->rsize == 4) {
+			/* last byte of the length */
+			h4->reassembly[h4->rsize++] = *data++;
+			h4->rexpected = h4->reassembly[h4->rsize - 2] +
+				(h4->reassembly[h4->rsize - 1] << 8);
+			count--;
+			BT_DBG("dathdr len %d, left %d", h4->rexpected, count);
+			continue;
+		}
+		if (count >= h4->rexpected) {
+			memcpy(&h4->reassembly[h4->rsize], data, h4->rexpected);
+			h4->rsize += h4->rexpected;
+			data += h4->rexpected;
+			count -= h4->rexpected;
+			bcm_process_acl_data(hu);
+			h4->rsize = 0; /* starting anew */
+			continue;
+		}
+		/* only piece of data received */
+		memcpy(&h4->reassembly[h4->rsize], data, count);
+		h4->rsize += count;
+		data += count;
+		h4->rexpected -= count;
+		count = 0;
+		break;
+
+		default: /* Note that SCO may NOT come through the UART */
+		if (count >= 3)
+			BT_DBG("unexpected pkt type of %x (%02x %02x %02x)?!",
+			       h4->reassembly[0], data[0], data[1], data[2]);
+		else if (count == 2)
+			BT_DBG("unexpected pkt type of %x (%02x %02x)?!",
+			       h4->reassembly[0], data[0], data[1]);
+		else if (count == 1)
+			BT_DBG("unexpected pkt type of %x (%02x)?!",
+			       h4->reassembly[0], data[0]);
+		else
+			BT_DBG("unexpected pkt type of %x?!",
+			       h4->reassembly[0]);
+		h4->rsize = 0;
+		return;
+	}
+	}
+}
 
-static int bcm_recv(struct hci_uart *hu, const void *data, int count)
+/*
+ * Data indication from the line discipline
+ */
+static int bcm_h4_recv(struct hci_uart *hu, void *data, int count)
 {
-	struct bcm_data *bcm = hu->priv;
+	struct bcm_h4_struct *h4 = hu->priv;
+	int ret;
 
-	if (!test_bit(HCI_UART_REGISTERED, &hu->flags))
+	BT_DBG("bcm_h4_recv hu %p len %d", hu, count);
+
+	if (!test_bit(HCI_UART_REGISTERED, &hu->flags)) {
+		BT_DBG("h4_recv UART not registered!");
 		return -EUNATCH;
+	}
 
-	bcm->rx_skb = h4_recv_buf(hu->hdev, bcm->rx_skb, data, count,
-				  bcm_recv_pkts, ARRAY_SIZE(bcm_recv_pkts));
-	if (IS_ERR(bcm->rx_skb)) {
-		int err = PTR_ERR(bcm->rx_skb);
-		BT_ERR("%s: Frame reassembly failed (%d)", hu->hdev->name, err);
-		return err;
+	/* Make sure we're resumed */
+	bcm_ensure_wakeup(hu);
+
+	/* If we're in the active phase, parse what we get */
+	if (h4->parse_recv) {
+		parse_fragment(hu, data, count);
+	} else {
+		ret = hci_recv_stream_fragment(hu->hdev, data, count);
+		if (ret < 0) {
+			BT_ERR("bcm_h4_recv: frame reassembly failed");
+			return ret;
+		}
 	}
 
 	return count;
 }
 
-static int bcm_enqueue(struct hci_uart *hu, struct sk_buff *skb)
+/*
+ * Line discipline is grabbing a packet from the tx queue
+ */
+static struct sk_buff *bcm_h4_dequeue(struct hci_uart *hu)
 {
-	struct bcm_data *bcm = hu->priv;
+	struct bcm_h4_struct *h4 = hu->priv;
+	int is_qempty = skb_queue_empty(&h4->txq);
 
-	BT_DBG("hu %p skb %p", hu, skb);
+	if (!is_qempty)
+		BT_DBG("bcm_h4_dequeue with non-empty queue");
+	return skb_dequeue(&h4->txq);
+}
 
-	/* Prepend skb with frame type */
-	memcpy(skb_push(skb, 1), &bt_cb(skb)->pkt_type, 1);
-	skb_queue_tail(&bcm->txq, skb);
+/*
+ * Callbacks from the BCMBT_UART device
+ */
 
-	return 0;
+/*
+ * The platform is suspending. Stop UART activity
+ */
+static void suspend_notification(void *context)
+{
+	struct ktermios ktermios;
+	struct hci_uart *hu = (struct hci_uart *)context;
+	struct bcm_h4_struct *h4 = hu->priv;
+	struct tty_struct *tty = hu->tty;
+	int status;
+	unsigned int set = 0;
+	unsigned int clear = 0;
+
+	BT_DBG("suspend_notification with is_suspended %d", h4->is_suspended);
+
+	if (!h4->pars.configure_sleep)
+		return;
+
+	if (!h4->is_suspended) {
+		if (h4->pars.manual_fc) {
+			/* Disable hardware flow control */
+			ktermios = tty->termios;
+			ktermios.c_cflag &= ~CRTSCTS;
+			status = tty_set_termios(tty, &ktermios);
+			if (status)
+				BT_DBG("suspend_notification dis fc fail %d",
+				       status);
+			else
+				BT_DBG("suspend_notification hw fc disabled");
+
+			/* Clear RTS to prevent the device from sending */
+			/* (most PCs need OUT2 to enable interrupts)    */
+			status = tty->driver->ops->tiocmget(tty);
+			BT_DBG("suspend_notification cur tiocm 0x%x", status);
+			set &= ~(TIOCM_OUT2 | TIOCM_RTS);
+			clear = ~set;
+			set &= TIOCM_DTR | TIOCM_RTS | TIOCM_OUT1 |
+				TIOCM_OUT2 | TIOCM_LOOP;
+			clear &= TIOCM_DTR | TIOCM_RTS | TIOCM_OUT1 |
+				TIOCM_OUT2 | TIOCM_LOOP;
+			status = tty->driver->ops->tiocmset(tty, set, clear);
+			if (status)
+				BT_DBG("suspend_notification clr RTS fail %d",
+				       status);
+			else
+				BT_DBG("suspend_notification RTS cleared");
+			status = tty->driver->ops->tiocmget(tty);
+			BT_DBG("suspend_notification end tiocm 0x%x", status);
+		}
+
+		/* Once this callback returns, driver suspends BT via GPIO */
+		h4->is_suspended = true;
+	}
+}
+
+/*
+ * The platform is resuming. Resume UART activity.
+ */
+static void resume_notification(void *context)
+{
+	struct ktermios ktermios;
+	struct hci_uart *hu = (struct hci_uart *)context;
+	struct bcm_h4_struct *h4 = hu->priv;
+	struct tty_struct *tty = hu->tty;
+	int status;
+	unsigned int set = 0;
+	unsigned int clear = 0;
+
+	BT_DBG("resume_notification with is_suspended %d", h4->is_suspended);
+
+	if (!h4->pars.configure_sleep)
+		return;
+
+	/* When this callback executes, the device has woken up already */
+	if (h4->is_suspended) {
+		h4->is_suspended = false;
+
+		if (h4->pars.manual_fc) {
+			status = tty->driver->ops->tiocmget(tty);
+			BT_DBG("resume_notification cur tiocm 0x%x", status);
+			set |= (TIOCM_OUT2 | TIOCM_RTS);
+			clear = ~set;
+			set &= TIOCM_DTR | TIOCM_RTS | TIOCM_OUT1 |
+				TIOCM_OUT2 | TIOCM_LOOP;
+			clear &= TIOCM_DTR | TIOCM_RTS | TIOCM_OUT1 |
+				TIOCM_OUT2 | TIOCM_LOOP;
+			status = tty->driver->ops->tiocmset(tty, set, clear);
+			if (status)
+				BT_DBG("resume_notification set RTS fail %d",
+				       status);
+			else
+				BT_DBG("resume_notification RTS set");
+
+			/* Re-enable hardware flow control */
+			ktermios = tty->termios;
+			ktermios.c_cflag |= CRTSCTS;
+			status = tty_set_termios(tty, &ktermios);
+			if (status)
+				BT_DBG("resume_notification enable fc fail %d",
+				       status);
+			else
+				BT_DBG("resume_notification hw fc re-enabled");
+		}
+	}
+
+	/* If we're resumed, the idle timer must be running */
+	status = mod_timer(&h4->timer, jiffies +
+	    msecs_to_jiffies(h4->pars.idle_timeout_in_secs * 1000));
 }
 
-static struct sk_buff *bcm_dequeue(struct hci_uart *hu)
+/*
+ * The BT device is resuming. Resume UART activity if suspended
+ */
+static void wakeup_notification(void *context)
 {
-	struct bcm_data *bcm = hu->priv;
+	struct ktermios ktermios;
+	struct hci_uart *hu = (struct hci_uart *)context;
+	struct bcm_h4_struct *h4 = hu->priv;
+	struct tty_struct *tty = hu->tty;
+	int status;
+	unsigned int set = 0;
+	unsigned int clear = 0;
+
+	if (!h4->pars.configure_sleep)
+		return;
+
+	status = tty->driver->ops->tiocmget(tty);
+	BT_DBG("wakeup_notification hu %p current tiocm 0x%x", hu, status);
+	if (h4->is_suspended) {
+		if (h4->pars.manual_fc) {
+			set |= (TIOCM_OUT2 | TIOCM_RTS);
+			clear = ~set;
+			set &= TIOCM_DTR | TIOCM_RTS | TIOCM_OUT1 |
+				TIOCM_OUT2 | TIOCM_LOOP;
+			clear &= TIOCM_DTR | TIOCM_RTS | TIOCM_OUT1 |
+				TIOCM_OUT2 | TIOCM_LOOP;
+			status = tty->driver->ops->tiocmset(tty, set, clear);
+			if (status)
+				BT_DBG("wakeup_notification set RTS fail %d",
+				       status);
+			else
+				BT_DBG("wakeup_notification RTS set");
+
+			/* Re-enable hardware flow control */
+			ktermios = tty->termios;
+			ktermios.c_cflag |= CRTSCTS;
+			status = tty_set_termios(tty, &ktermios);
+			if (status)
+				BT_DBG("wakeup_notification fc-en failure %d",
+				       status);
+			else
+				BT_DBG("wakeup_notification hw fc re-enabled");
+		}
+
+		h4->is_suspended = false;
+	}
 
-	return skb_dequeue(&bcm->txq);
+	/* If we're resumed, the idle timer must be running */
+	status = mod_timer(&h4->timer, jiffies + msecs_to_jiffies(
+			   h4->pars.idle_timeout_in_secs * 1000));
 }
 
-static const struct hci_uart_proto bcm_proto = {
+/*
+ * Device setup that follows the protocol open
+ */
+static int bcm_h4_setup(struct hci_uart *hu)
+{
+	struct bcm_h4_struct *h4 = hu->priv;
+	int status;
+	struct sk_buff *skb;
+	unsigned char sleep_pars[] = {
+	0x01,       /* sleep mode 1=UART */
+	0x02,       /* idle threshold HOST (value * 300ms) */
+	0x02,       /* idle threshold HC   (value * 300ms) */
+	0x01,       /* BT_WAKE active mode - 1=active high, 0 = active low */
+	0x00,       /* HOST_WAKE active mode - 1=active high, 0 = active low */
+	0x01,       /* Allow host sleep during SCO - FALSE */
+	0x01,       /* combine sleep mode and LPM - 1 == TRUE */
+	0x00,       /* enable tristate control of UART TX line - FALSE */
+	0x00,       /* USB auto-sleep on USB SUSPEND */
+	0x00,       /* USB USB RESUME timeout (seconds) */
+	0x00,       /* Pulsed Host Wake */
+	0x00        /* Enable Break To Host */
+	};
+	unsigned char pcm_int_pars[] = {
+	0x00,       /* 0=PCM routing, 1=SCO over HCI */
+	0x02,       /* 0=128Kbps,1=256Kbps,2=512Kbps,3=1024Kbps,4=2048Kbps */
+	0x00,       /* short frame sync  0=short, 1=long */
+	0x00,       /* sync mode         0=slave, 1=master */
+	0x00        /* clock mode        0=slave, 1=master */
+	};
+	unsigned char pcm_format_pars[] = {
+	0x00,       /* LSB_First 1=TRUE, 0=FALSE */
+	0x00,       /* Fill_Value (use 0-7 for fill bits value) */
+	0x02,       /* Fill_Method   (2=sign extended) */
+	0x03,       /* Fill_Num      # of fill bits 0-3) */
+	0x01        /* Right_Justify 1=TRUE, 0=FALSE */
+	};
+	unsigned char time_slot_number = 0;
+
+	BT_DBG("bcm_h4_setup hu %p", hu);
+
+	/* Bring the UART into known default state */
+	status = btbcm_init_uart(hu);
+	if (status) {
+		BT_DBG("bcm_h4_setup failed to init BT device %d", status);
+		return status;
+	}
+
+	/* Basic sanity check */
+	skb = __hci_cmd_sync(hu->hdev, HCI_OP_RESET, 0, NULL, HCI_INIT_TIMEOUT);
+	if (IS_ERR(skb)) {
+		status = PTR_ERR(skb);
+		BT_ERR("bcm_h4_setup HCI Reset failed (%d)", status);
+		return status;
+	}
+	kfree_skb(skb);
+	BT_DBG("bcm_h4_setup HCI Reset succeeded");
+
+	/* Set the new baud rate */
+	status = btbcm_set_baud_rate(hu,
+				     h4->pars.baud_rate_before_config_download);
+	if (status) {
+		BT_ERR("bcm_h4_setup set_baud_rate faiilure %d", status);
+		return status;
+	}
+
+	hu->hdev->set_bdaddr = btbcm_set_bdaddr;
+
+	/* Download the firmware and reconfigure the UART afterwards */
+	status = btbcm_setup_patchram(hu->hdev);
+	if (status) {
+		BT_ERR("bcm_h4_setup setup_patchram faiilure %d", status);
+		return status;
+	}
+
+	/* Configure SCO PCM parameters */
+	if (h4->pars.configure_audio) {
+		pcm_int_pars[0] = h4->pars.PCMRouting;
+		pcm_int_pars[1] = h4->pars.PCMInCallBitclock;
+		pcm_int_pars[2] = h4->pars.PCMShortFrameSync;
+		pcm_int_pars[3] = h4->pars.PCMSyncMode;
+		pcm_int_pars[4] = h4->pars.PCMClockMode;
+		skb = __hci_cmd_sync(hu->hdev, 0xfc1c, sizeof(pcm_int_pars),
+				     pcm_int_pars, HCI_INIT_TIMEOUT);
+		if (IS_ERR(skb)) {
+			status = PTR_ERR(skb);
+			BT_ERR("bcm_h4_setup PCM INT VSC failed (%d)", status);
+			return status;
+		}
+		kfree_skb(skb);
+		BT_DBG("bcm_h4_setup PCM INT Parameters VSC succeeded");
+
+		pcm_format_pars[0] = h4->pars.PCMLSBFirst;
+		pcm_format_pars[1] = h4->pars.PCMFillValue;
+		pcm_format_pars[2] = h4->pars.PCMFillMethod;
+		pcm_format_pars[3] = h4->pars.PCMFillNum;
+		pcm_format_pars[4] = h4->pars.PCMRightJustify;
+		skb = __hci_cmd_sync(hu->hdev, 0xfc1e, sizeof(pcm_format_pars),
+				     pcm_format_pars, HCI_INIT_TIMEOUT);
+		if (IS_ERR(skb)) {
+			status = PTR_ERR(skb);
+			BT_ERR("bcm_h4_setup PCM Format VSC failed (%d)",
+			       status);
+			return status;
+		}
+		kfree_skb(skb);
+		BT_DBG("bcm_h4_setup PCM Format VSC succeeded");
+
+		skb = __hci_cmd_sync(hu->hdev, 0xfc22, sizeof(time_slot_number),
+				     &time_slot_number, HCI_INIT_TIMEOUT);
+		if (IS_ERR(skb)) {
+			status = PTR_ERR(skb);
+			BT_ERR("bcm_h4_setup SCO Time Slot VSC failed (%d)",
+			       status);
+			return status;
+		}
+		kfree_skb(skb);
+		BT_DBG("bcm_h4_setup SCO Time Slot VSC succeeded");
+	}
+
+	/* Configure device's suspend/resume operation */
+	if (h4->pars.configure_sleep) {
+		/* Override the default */
+		sleep_pars[3] = (unsigned char)!h4->pars.bt_wake_active_low;
+		sleep_pars[4] = (unsigned char)!h4->pars.dev_wake_active_low;
+		skb = __hci_cmd_sync(hu->hdev, 0xfc27, sizeof(sleep_pars),
+				     sleep_pars, HCI_INIT_TIMEOUT);
+		if (IS_ERR(skb)) {
+			status = PTR_ERR(skb);
+			BT_ERR("bcm_h4_setup Sleep VSC failed (%d)", status);
+			return status;
+		}
+		kfree_skb(skb);
+		BT_DBG("bcm_h4_setup Set Sleep Parameters VSC succeeded");
+	}
+
+	return 0;
+}
+
+/*
+ * Protocol callbacks
+ */
+static struct hci_uart_proto h4p = {
 	.id		= HCI_UART_BCM,
-	.name		= "BCM",
-	.open		= bcm_open,
-	.close		= bcm_close,
-	.flush		= bcm_flush,
-	.setup		= bcm_setup,
-	.recv		= bcm_recv,
-	.enqueue	= bcm_enqueue,
-	.dequeue	= bcm_dequeue,
+	.name		= "UARTBCM",
+	.open		= bcm_h4_open,
+	.close		= bcm_h4_close,
+	.flush		= bcm_h4_flush,
+	.setup		= bcm_h4_setup,
+	.recv		= bcm_h4_recv,
+	.enqueue	= bcm_h4_enqueue,
+	.dequeue	= bcm_h4_dequeue,
 };
 
+/*
+ * Protocol init
+ */
 int __init bcm_init(void)
 {
-	return hci_uart_register_proto(&bcm_proto);
+	int status = hci_uart_register_proto(&h4p);
+
+	if (!status)
+		BT_INFO("Broadcom H4 protocol initialized");
+	else
+		BT_ERR("Broadcom H4 protocol registration failed %d", status);
+
+	return status;
 }
 
+/*
+ * Protocol shutdown
+ */
 int __exit bcm_deinit(void)
 {
-	return hci_uart_unregister_proto(&bcm_proto);
+	BT_INFO("Broadcom H4 protocol de-initialized");
+	return hci_uart_unregister_proto(&h4p);
 }
+
-- 
1.9.1

