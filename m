Return-Path: <cyrus@holtmann.org>
From: Ilya Faenson <ifaenson@broadcom.com>
To: Marcel Holtmann <marcel@holtmann.org>
CC: <linux-bluetooth@vger.kernel.org>,
	Ilya Faenson <ifaenson@broadcom.com>
Subject: [RFC v3 2/4] Broadcom Bluetooth UART Platform Driver
Date: Wed, 13 May 2015 17:50:21 -0400
Message-ID: <1431553823-25670-3-git-send-email-ifaenson@broadcom.com>
In-Reply-To: <1431553823-25670-1-git-send-email-ifaenson@broadcom.com>
References: <1431553823-25670-1-git-send-email-ifaenson@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Introduce the device tree enumerated Broadcom Bluetooth UART driver.

Signed-off-by: Ilya Faenson <ifaenson@broadcom.com>
---
 drivers/bluetooth/Kconfig      |   9 +
 drivers/bluetooth/Makefile     |   1 +
 drivers/bluetooth/btbcm_uart.c | 705 +++++++++++++++++++++++++++++++++++++++++
 drivers/bluetooth/btbcm_uart.h | 116 +++++++
 4 files changed, 831 insertions(+)
 create mode 100644 drivers/bluetooth/btbcm_uart.c
 create mode 100644 drivers/bluetooth/btbcm_uart.h

diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
index ed5c273..7127ada 100644
--- a/drivers/bluetooth/Kconfig
+++ b/drivers/bluetooth/Kconfig
@@ -128,6 +128,7 @@ config BT_HCIUART_BCM
 	bool "Broadcom protocol support"
 	depends on BT_HCIUART
 	select BT_HCIUART_H4
+	select BT_UART_BCM
 	select BT_BCM
 	help
 	  The Broadcom protocol support enables Bluetooth HCI over serial
@@ -135,6 +136,14 @@ config BT_HCIUART_BCM
 
 	  Say Y here to compile support for Broadcom protocol.
 
+config BT_UART_BCM
+	tristate "Broadcom BT UART driver"
+	depends on BT_HCIUART_H4 && TTY
+	help
+	  This driver supports the HCI_UART_BT protocol.
+
+	  It manages Bluetooth UART device properties and GPIOs.
+
 config BT_HCIBCM203X
 	tristate "HCI BCM203x USB driver"
 	depends on USB
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
diff --git a/drivers/bluetooth/btbcm_uart.c b/drivers/bluetooth/btbcm_uart.c
new file mode 100644
index 0000000..2afaed1
--- /dev/null
+++ b/drivers/bluetooth/btbcm_uart.c
@@ -0,0 +1,705 @@
+/*
+ *  Bluetooth BCM UART Driver
+ *
+ *  Copyright (c) 2015 Broadcom Corporation
+ *
+ *  This file is provided under a dual BSD/GPLv2 license.  When using or
+ *  redistributing this file, you may do so under either license.
+ *
+ *  GPL LICENSE SUMMARY
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  BSD LICENSE SUMMARY
+ *  Redistribution and use in source and binary forms, with or without
+ *  modification, are permitted provided that the following conditions
+ *  are met:
+ *    Redistributions of source code must retain the above copyright
+ *    notice, this list of conditions and the following disclaimer.
+ *    Redistributions in binary form must reproduce the above copyright
+ *    notice, this list of conditions and the following disclaimer in
+ *    the documentation and/or other materials provided with the
+ *    distribution.
+ *    Neither the name of Intel Corporation nor the names of its
+ *    contributors may be used to endorse or promote products derived
+ *    from this software without specific prior written permission.
+ *  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
+ *  "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
+ *  LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
+ *  A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
+ *  OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
+ *  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
+ *  LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
+ *  DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
+ *  THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
+ *  OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
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
+static int idle_timeout = 5;
+module_param(idle_timeout, int, 0);
+MODULE_PARM_DESC(idle_timeout, "Bluetooth idle timeout in seconds");
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
+	BT_DBG("idle_timeout set as %d", idle_timeout);
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
+		if (p_data == NULL || *p_size != sizeof(struct
+		    btbcm_uart_callbacks) || (pc->interface_version !=
+		    BTBCM_UART_INTERFACE_VERSION)) {
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
+		pp->idle_timeout_in_secs = idle_timeout;
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
+static const struct of_device_id bcm_bt_uart_table[] = {
+	{ .compatible = "brcm,brcm-bt-uart" },
+	{}
+};
+
+/* Driver configuration */
+static struct platform_driver bcm_bt_uart_driver = {
+	.probe = bcm_bt_uart_probe,
+	.remove = bcm_bt_uart_remove,
+	.driver = {
+		.name = "brcm_bt_uart",
+		.of_match_table = of_match_ptr(bcm_bt_uart_table),
+		.owner = THIS_MODULE,
+		.pm = &bcm_bt_uart_pm_ops,
+	},
+};
+
+module_platform_driver(bcm_bt_uart_driver);
+
+MODULE_AUTHOR("Ilya Faenson");
+MODULE_DESCRIPTION("Broadcom Bluetooth UART Driver");
+MODULE_LICENSE("Dual BSD/GPL");
+
diff --git a/drivers/bluetooth/btbcm_uart.h b/drivers/bluetooth/btbcm_uart.h
new file mode 100644
index 0000000..3b02a4e
--- /dev/null
+++ b/drivers/bluetooth/btbcm_uart.h
@@ -0,0 +1,116 @@
+/*
+ *  Bluetooth BCM UART Driver Header
+ *
+ *  Copyright (c) 2015 Broadcom Corporation
+ *
+ *  This file is provided under a dual BSD/GPLv2 license.  When using or
+ *  redistributing this file, you may do so under either license.
+ *
+ *  GPL LICENSE SUMMARY
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  BSD LICENSE SUMMARY
+ *  Redistribution and use in source and binary forms, with or without
+ *  modification, are permitted provided that the following conditions
+ *  are met:
+ *    Redistributions of source code must retain the above copyright
+ *    notice, this list of conditions and the following disclaimer.
+ *    Redistributions in binary form must reproduce the above copyright
+ *    notice, this list of conditions and the following disclaimer in
+ *    the documentation and/or other materials provided with the
+ *    distribution.
+ *    Neither the name of Intel Corporation nor the names of its
+ *    contributors may be used to endorse or promote products derived
+ *    from this software without specific prior written permission.
+ *  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
+ *  "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
+ *  LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
+ *  A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
+ *  OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
+ *  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
+ *  LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
+ *  DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
+ *  THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
+ *  OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+#ifndef BTBCM_UART_H
+#define BTBCM_UART_H
+
+/* Change the version if you change anything in this header */
+#define BTBCM_UART_INTERFACE_VERSION 1
+/* Callbacks from the driver into the protocol */
+typedef void (*p_suspend_callback)(void *context);
+typedef void (*p_resume_callback)(void *context);
+typedef void (*p_wakeup_callback)(void *context);
+struct btbcm_uart_callbacks {
+	int interface_version; /* interface # compiled against */
+	void *context;         /* protocol instance context */
+	char name[64];         /* protocol tty device, for example, ttyS0 */
+
+	/* client callbacks */
+	p_suspend_callback p_suspend;
+	p_resume_callback p_resume;
+	p_wakeup_callback p_wakeup;
+};
+
+/* Driver parameters retrieved from the DT or ACPI */
+struct btbcm_uart_parameters {
+	int interface_version; /* interface # compiled against */
+
+	/* Parameters themselves */
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
-- 
1.9.1

