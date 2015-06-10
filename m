Return-Path: <cyrus@holtmann.org>
From: Ilya Faenson <ifaenson@broadcom.com>
To: Marcel Holtmann <marcel@holtmann.org>
CC: <linux-bluetooth@vger.kernel.org>, Arend van Spriel <arend@broadcom.com>,
	Ilya Faenson <ifaenson@broadcom.com>
Subject: [PATCH v2 3/5] Broadcom Bluetooth UART Platform Driver
Date: Wed, 10 Jun 2015 16:05:18 -0400
Message-ID: <1433966720-17482-4-git-send-email-ifaenson@broadcom.com>
In-Reply-To: <1433966720-17482-1-git-send-email-ifaenson@broadcom.com>
References: <1433966720-17482-1-git-send-email-ifaenson@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-bluetooth.vger.kernel.org>

Introduce the device tree enumerated Broadcom Bluetooth UART driver.

Signed-off-by: Ilya Faenson <ifaenson@broadcom.com>
---
 drivers/bluetooth/Kconfig      |   9 +
 drivers/bluetooth/Makefile     |   1 +
 drivers/bluetooth/btbcm_uart.c | 673 +++++++++++++++++++++++++++++++++++++++++
 drivers/bluetooth/btbcm_uart.h |  89 ++++++
 4 files changed, 772 insertions(+)
 create mode 100644 drivers/bluetooth/btbcm_uart.c
 create mode 100644 drivers/bluetooth/btbcm_uart.h

diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
index 2e77707..5eee3ed 100644
--- a/drivers/bluetooth/Kconfig
+++ b/drivers/bluetooth/Kconfig
@@ -143,6 +143,7 @@ config BT_HCIUART_BCM
 	bool "Broadcom protocol support"
 	depends on BT_HCIUART
 	select BT_HCIUART_H4
+	select BT_UART_BCM
 	select BT_BCM
 	help
 	  The Broadcom protocol support enables Bluetooth HCI over serial
@@ -150,6 +151,14 @@ config BT_HCIUART_BCM
 
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
index f40e194..e908a88 100644
--- a/drivers/bluetooth/Makefile
+++ b/drivers/bluetooth/Makefile
@@ -21,6 +21,7 @@ obj-$(CONFIG_BT_MRVL)		+= btmrvl.o
 obj-$(CONFIG_BT_MRVL_SDIO)	+= btmrvl_sdio.o
 obj-$(CONFIG_BT_WILINK)		+= btwilink.o
 obj-$(CONFIG_BT_BCM)		+= btbcm.o
+obj-$(CONFIG_BT_UART_BCM)	+= btbcm_uart.o
 obj-$(CONFIG_BT_RTL)		+= btrtl.o
 
 btmrvl-y			:= btmrvl_main.o
diff --git a/drivers/bluetooth/btbcm_uart.c b/drivers/bluetooth/btbcm_uart.c
new file mode 100644
index 0000000..ccd02a9
--- /dev/null
+++ b/drivers/bluetooth/btbcm_uart.c
@@ -0,0 +1,673 @@
+/*
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
+	bool configure_sleep;
+	u32 manual_fc;
+	u32 oper_speed;
+	bool configure_audio;
+	u32 pcm_clockmode;
+	u32 pcm_fillmethod;
+	u32 pcm_fillnum;
+	u32 pcm_fillvalue;
+	u32 pcm_incallbitclock;
+	u32 pcm_lsbfirst;
+	u32 pcm_rightjustify;
+	u32 pcm_routing;
+	u32 pcm_shortframesync;
+	u32 pcm_syncmode;
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
+	int gpio_value;
+	struct bcm_device *p_bcm_device =
+		container_of(ws, struct bcm_device, wakeup_work);
+
+	if (!p_bcm_device) {
+		BT_DBG("%s - failing, no device", __func__);
+		return;
+	}
+
+	/* Make sure the device is resumed */
+	gpio_value = !p_bcm_device->dev_wake_active_low;
+	if (p_bcm_device->dev_wake_gpio) {
+		gpiod_set_value(p_bcm_device->dev_wake_gpio, gpio_value);
+		BT_DBG("%s - resume %d written, delaying 15 ms",
+		       __func__, gpio_value);
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
+	BT_DBG("%s with bt_wake of %d (active_low %d), req bh",
+	       __func__, bt_wake, p->bt_wake_active_low);
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
+		BT_DBG("%s - failing due to no memory", __func__);
+		return -ENOMEM;
+	}
+	p_bcm_device->pdev = pdev;
+	BT_DBG("%s %p context", __func__, p_bcm_device);
+
+	/* Get dev wake GPIO */
+	p_bcm_device->dev_wake_gpio = gpiod_get(&pdev->dev, "bt-wake");
+	BT_DBG("%s - gpiod_get for bt-wake returned %p",
+	       __func__, p_bcm_device->dev_wake_gpio);
+	if (IS_ERR(p_bcm_device->dev_wake_gpio)) {
+		ret = PTR_ERR(p_bcm_device->dev_wake_gpio);
+		if (ret != -ENOENT) {
+			dev_err(&pdev->dev,
+				"%s - dev_wake GPIO: %d\n", __func__, ret);
+		}
+		p_bcm_device->dev_wake_gpio = NULL;
+	} else {
+		int gpio_value;
+
+		p_bcm_device->dev_wake_active_low = gpiod_is_active_low
+			(p_bcm_device->dev_wake_gpio);
+		BT_DBG("%s - dev_wake a-low is %d (cans %d)",
+		       __func__, p_bcm_device->dev_wake_active_low,
+		       gpiod_cansleep(p_bcm_device->dev_wake_gpio));
+
+		/* configure dev_wake as output with init resumed state */
+		gpio_value = !p_bcm_device->dev_wake_active_low;
+		ret = gpiod_direction_output(p_bcm_device->dev_wake_gpio,
+					     gpio_value);
+		if (ret < 0) {
+			dev_err(&pdev->dev,
+				"%s s dev_wake GPIO: %d\n", __func__, ret);
+			gpiod_put(p_bcm_device->dev_wake_gpio);
+			p_bcm_device->dev_wake_gpio = NULL;
+			goto end;
+		} else {
+			BT_DBG("%s - dev_wake set to %d", __func__,
+			       gpio_value);
+		}
+	}
+
+	/* Get power on/off GPIO */
+	p_bcm_device->reg_on_gpio = gpiod_get(&pdev->dev, "bt-reg-on");
+	BT_DBG("%s - gpiod_get for bt-reg-on returned %p", __func__,
+	       p_bcm_device->reg_on_gpio);
+	if (IS_ERR(p_bcm_device->reg_on_gpio)) {
+		ret = PTR_ERR(p_bcm_device->reg_on_gpio);
+		if (ret != -ENOENT) {
+			dev_err(&pdev->dev,
+				"%s - reg_on GPIO: %d\n", __func__, ret);
+		}
+		p_bcm_device->reg_on_gpio = NULL;
+	} else {
+		int poweron_flag;
+
+		p_bcm_device->reg_on_active_low = gpiod_is_active_low
+			(p_bcm_device->reg_on_gpio);
+		BT_DBG("%s - reg_on a-low is %d (cans %d)",
+		       __func__, p_bcm_device->reg_on_active_low,
+		       gpiod_cansleep(p_bcm_device->reg_on_gpio));
+
+		/* configure reg_on as output with init on state */
+		poweron_flag = !p_bcm_device->reg_on_active_low;
+		ret = gpiod_direction_output(p_bcm_device->reg_on_gpio,
+					     poweron_flag);
+		if (ret < 0) {
+			dev_err(&pdev->dev,
+				"%s set reg_on GPIO: %d\n", __func__, ret);
+			gpiod_put(p_bcm_device->reg_on_gpio);
+			p_bcm_device->reg_on_gpio = NULL;
+		} else {
+			BT_DBG("%s - reg_on initially set to %d", __func__,
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
+	BT_DBG("%s - gpiod_get for bt-host-wake returned %p", __func__,
+	       p_bcm_device->bt_wake_gpio);
+	if (IS_ERR(p_bcm_device->bt_wake_gpio)) {
+		ret = PTR_ERR(p_bcm_device->bt_wake_gpio);
+		if (ret != -ENOENT) {
+			dev_err(&pdev->dev,
+				"%s - bt_wake GPIO: %d\n", __func__, ret);
+		}
+		p_bcm_device->bt_wake_gpio = NULL;
+	} else {
+		/* configure bt_wake as input */
+		ret = gpiod_direction_input(p_bcm_device->bt_wake_gpio);
+		if (ret < 0) {
+			dev_err(&pdev->dev,
+				"%s set bt_wake GPIO: %d\n", __func__, ret);
+			gpiod_put(p_bcm_device->bt_wake_gpio);
+			p_bcm_device->bt_wake_gpio = NULL;
+		} else {
+			p_bcm_device->bt_wake_active_low = gpiod_is_active_low
+				(p_bcm_device->bt_wake_gpio);
+			BT_DBG("%s -bt_wake a-low is %d(cans%d)",
+			       __func__, p_bcm_device->bt_wake_active_low,
+			       gpiod_cansleep(p_bcm_device->bt_wake_gpio));
+			p_bcm_device->bt_wake_irq = gpiod_to_irq
+				(p_bcm_device->bt_wake_gpio);
+			if (p_bcm_device->bt_wake_irq < 0) {
+				dev_err(&pdev->dev,
+				"%s - HOST_WAKE IRQ: %d\n", __func__, ret);
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
+					dev_err(&pdev->dev,
+						"%s - failed IRQ %d: %d",
+						__func__,
+						p_bcm_device->bt_wake_irq, ret);
+				} else {
+					BT_DBG("%s - IRQ %d", __func__,
+					       p_bcm_device->bt_wake_irq);
+				}
+			}
+		}
+	}
+
+	p_bcm_device->configure_sleep = of_property_read_bool(
+		np, "configure-sleep");
+	BT_DBG("configure-sleep read as %d", p_bcm_device->configure_sleep);
+	p_bcm_device->manual_fc = 0;
+	if (!of_property_read_u32(np, "manual-fc",
+				  &p_bcm_device->manual_fc)) {
+		BT_DBG("manual-fc read as %d",
+			p_bcm_device->manual_fc);
+	}
+	p_bcm_device->oper_speed = 3000000;
+	if (!of_property_read_u32(
+		np, "oper-speed",
+		&p_bcm_device->oper_speed)) {
+		BT_DBG("oper-speed read as %d",
+			p_bcm_device->oper_speed);
+	}
+	p_bcm_device->configure_audio = of_property_read_bool(
+		np, "configure-audio");
+	BT_DBG("configure-audio read as %d", p_bcm_device->configure_audio);
+	if (p_bcm_device->configure_audio) {
+		/* Defaults for audio */
+		p_bcm_device->pcm_clockmode = 0;
+		p_bcm_device->pcm_fillmethod = 2;
+		p_bcm_device->pcm_fillnum = 0;
+		p_bcm_device->pcm_fillvalue = 3;
+		p_bcm_device->pcm_incallbitclock = 0;
+		p_bcm_device->pcm_lsbfirst = 0;
+		p_bcm_device->pcm_rightjustify = 0;
+		p_bcm_device->pcm_routing = 0;
+		p_bcm_device->pcm_shortframesync = 0;
+		p_bcm_device->pcm_syncmode = 0;
+
+		if (!of_property_read_u32(np, "pcm-clockmode",
+					  &p_bcm_device->pcm_clockmode))
+			BT_DBG("pcm-clockmode read as %d",
+				p_bcm_device->pcm_clockmode);
+		if (!of_property_read_u32(np, "pcm-fillmethod",
+					  &p_bcm_device->pcm_fillmethod))
+			BT_DBG("pcm-fillmethod readas %d",
+				p_bcm_device->pcm_fillmethod);
+		if (!of_property_read_u32(np, "pcm-fillnum",
+					  &p_bcm_device->pcm_fillnum))
+			BT_DBG("pcm-fillnum read as %d",
+				p_bcm_device->pcm_fillnum);
+		if (!of_property_read_u32(np, "pcm-fillvalue",
+					  &p_bcm_device->pcm_fillvalue))
+			BT_DBG("pcm-fillvalue read as %d",
+				p_bcm_device->pcm_fillvalue);
+		if (!of_property_read_u32(np, "pcm-incallbitclock",
+					  &p_bcm_device->pcm_incallbitclock))
+			BT_DBG("pcm-incallbitclock read as %d",
+				p_bcm_device->pcm_incallbitclock);
+		if (!of_property_read_u32(np, "pcm-lsbfirst",
+					  &p_bcm_device->pcm_lsbfirst))
+			BT_DBG("pcm-lsbfirst read as %d",
+				p_bcm_device->pcm_lsbfirst);
+		if (!of_property_read_u32(np, "pcm-rightjustify",
+					  &p_bcm_device->pcm_rightjustify))
+			BT_DBG("pcm-rightjustify read as %d",
+				p_bcm_device->pcm_rightjustify);
+		if (!of_property_read_u32(np, "pcm-routing",
+					  &p_bcm_device->pcm_routing))
+			BT_DBG("pcm-routing read as %d",
+				p_bcm_device->pcm_routing);
+		if (!of_property_read_u32(np, "pcm-shortframesync",
+					  &p_bcm_device->pcm_shortframesync))
+			BT_DBG("pcm-shortframesync read as %d",
+				p_bcm_device->pcm_shortframesync);
+		if (!of_property_read_u32(np, "pcm-syncmode",
+					  &p_bcm_device->pcm_syncmode))
+			BT_DBG("pcm-syncmode read as %d",
+				p_bcm_device->pcm_syncmode);
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
+	BT_DBG("%s with the result %d", __func__, ret);
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
+		BT_DBG("%s - logic error, no probe?!", __func__);
+		return 0;
+	}
+
+	BT_DBG("%s %p context", __func__, p_bcm_device);
+
+	spin_lock(&device_list_lock);
+	list_del(&p_bcm_device->list);
+	spin_unlock(&device_list_lock);
+
+	BT_DBG("%s - freeing interrupt %d", __func__,
+		p_bcm_device->bt_wake_irq);
+	free_irq(p_bcm_device->bt_wake_irq, p_bcm_device);
+
+	if (p_bcm_device->reg_on_gpio) {
+		BT_DBG("%s - releasing reg_on_gpio", __func__);
+		gpiod_put(p_bcm_device->reg_on_gpio);
+		p_bcm_device->reg_on_gpio = NULL;
+	}
+
+	if (p_bcm_device->dev_wake_gpio) {
+		BT_DBG("%s - releasing dev_wake_gpio", __func__);
+		gpiod_put(p_bcm_device->dev_wake_gpio);
+		p_bcm_device->dev_wake_gpio = NULL;
+	}
+
+	if (p_bcm_device->bt_wake_gpio) {
+		BT_DBG("%s - releasing bt_wake_gpio", __func__);
+		gpiod_put(p_bcm_device->bt_wake_gpio);
+		p_bcm_device->bt_wake_gpio = NULL;
+	}
+
+	BT_DBG("%s %p done", __func__, p_bcm_device);
+	return 0;
+}
+
+/*
+ * Platform resume callback
+ */
+static int bcm_bt_uart_resume(struct device *pdev)
+{
+	int gpio_value;
+	struct bcm_device *p_bcm_device = platform_get_drvdata(
+		to_platform_device(pdev));
+
+	if (p_bcm_device == NULL) {
+		BT_DBG("%s - logic error, no device?!", __func__);
+		return 0;
+	}
+
+	BT_DBG("%s %p", __func__, p_bcm_device);
+
+	gpio_value = !p_bcm_device->dev_wake_active_low;
+	if (p_bcm_device->dev_wake_gpio) {
+		gpiod_set_value(p_bcm_device->dev_wake_gpio, gpio_value);
+		BT_DBG("%s - %d written, delaying 15 ms", __func__,
+		       gpio_value);
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
+	int gpio_value;
+	struct bcm_device *p_bcm_device = platform_get_drvdata(
+		to_platform_device(pdev));
+
+	if (p_bcm_device == NULL) {
+		BT_DBG("%s - logic error, no device?!", __func__);
+		return 0;
+	}
+
+	BT_DBG("%s %p", __func__, p_bcm_device);
+
+	/* Let the protocol know the platform is suspending */
+	if (p_bcm_device->protocol_callbacks.p_suspend)
+		p_bcm_device->protocol_callbacks.p_suspend(
+			p_bcm_device->protocol_callbacks.context);
+
+	/* Suspend the device */
+	if (p_bcm_device->dev_wake_gpio) {
+		gpio_value = !!p_bcm_device->dev_wake_active_low;
+		gpiod_set_value(p_bcm_device->dev_wake_gpio, gpio_value);
+		BT_DBG("%s - %d written, delaying 15 ms", __func__,
+			gpio_value);
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
+	int gpio_value, poweron_flag;
+	struct bcm_device *p_bcm_device = device_context;
+	struct list_head *ptr;
+	bool is_found = false;
+
+	/* Special processing for the callback configuration */
+	if (action == BTBCM_UART_ACTION_CONFIGURE_CALLBACKS) {
+		pc = p_data;
+
+		BT_DBG("%s - configure callbacks", __func__);
+		if (p_data == NULL || *p_size != sizeof(struct
+		    btbcm_uart_callbacks) || (pc->interface_version !=
+		    BTBCM_UART_INTERFACE_VERSION)) {
+			BT_DBG("%s - callbacks mismatch!", __func__);
+			return -E2BIG;
+		}
+
+		BT_DBG("%s - configure callbacks for %s(%p)", __func__,
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
+				BT_DBG("%s - no device!", __func__);
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
+		BT_DBG("%s - failing, no device", __func__);
+		return -ENOENT;
+	}
+
+	switch (action) {
+	case BTBCM_UART_ACTION_POWER_ON:
+		BT_DBG("%s %p - power on", __func__, device_context);
+		if (p_bcm_device->reg_on_gpio) {
+			poweron_flag = !p_bcm_device->reg_on_active_low;
+			gpiod_set_value(p_bcm_device->reg_on_gpio,
+					poweron_flag);
+			BT_DBG("%s - pwron %d, delay 15 ms", __func__,
+			       poweron_flag);
+			mdelay(15);
+		}
+		break;
+
+	case BTBCM_UART_ACTION_POWER_OFF:
+		BT_DBG("%s %p - power off", __func__, device_context);
+		if (p_bcm_device->reg_on_gpio) {
+			poweron_flag = p_bcm_device->reg_on_active_low;
+			gpiod_set_value(p_bcm_device->reg_on_gpio,
+					poweron_flag);
+			BT_DBG("%s - pwroff %d, delay 15 ms", __func__,
+			       poweron_flag);
+			mdelay(15);
+		}
+		break;
+
+	case BTBCM_UART_ACTION_RESUME:
+		BT_DBG("%s %p - resume", __func__, device_context);
+		if (p_bcm_device->dev_wake_gpio) {
+			gpio_value = !p_bcm_device->dev_wake_active_low;
+			gpiod_set_value(p_bcm_device->dev_wake_gpio,
+					gpio_value);
+			BT_DBG("%s - resume %d, delay 15 ms", __func__,
+			       gpio_value);
+			mdelay(15);
+		}
+		break;
+
+	case BTBCM_UART_ACTION_SUSPEND:
+		BT_DBG("%s %p - suspend", __func__, device_context);
+		if (p_bcm_device->dev_wake_gpio) {
+			gpio_value = !!p_bcm_device->dev_wake_active_low;
+			gpiod_set_value(p_bcm_device->dev_wake_gpio,
+					gpio_value);
+			BT_DBG("btbcm_uart_control - suspend %d, delay 15ms",
+			       gpio_value);
+			mdelay(15);
+		}
+		break;
+
+	case BTBCM_UART_ACTION_GET_PARAMETERS:
+		BT_DBG("%s %p - get pars", __func__, device_context);
+		if ((p_data == NULL) ||
+			(*p_size < sizeof(struct btbcm_uart_parameters))) {
+			BT_DBG("%s - failing, wrong par size", __func__);
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
+		pp->oper_speed = p_bcm_device->oper_speed;
+		pp->configure_audio = p_bcm_device->configure_audio;
+		pp->pcm_clockmode = p_bcm_device->pcm_clockmode;
+		pp->pcm_fillmethod = p_bcm_device->pcm_fillmethod;
+		pp->pcm_fillnum = p_bcm_device->pcm_fillnum;
+		pp->pcm_fillvalue = p_bcm_device->pcm_fillvalue;
+		pp->pcm_incallbitclock = p_bcm_device->pcm_incallbitclock;
+		pp->pcm_lsbfirst = p_bcm_device->pcm_lsbfirst;
+		pp->pcm_rightjustify = p_bcm_device->pcm_rightjustify;
+		pp->pcm_routing = p_bcm_device->pcm_routing;
+		pp->pcm_shortframesync = p_bcm_device->pcm_shortframesync;
+		pp->pcm_syncmode = p_bcm_device->pcm_syncmode;
+		*p_size = sizeof(struct btbcm_uart_parameters);
+		break;
+
+	default:
+		BT_DBG("%s %p unknown act %d", __func__,
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
+MODULE_LICENSE("GPL");
+
diff --git a/drivers/bluetooth/btbcm_uart.h b/drivers/bluetooth/btbcm_uart.h
new file mode 100644
index 0000000..fbc7285
--- /dev/null
+++ b/drivers/bluetooth/btbcm_uart.h
@@ -0,0 +1,89 @@
+/*
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
+	bool configure_sleep;
+	int manual_fc;
+	int dev_wake_active_low;
+	int bt_wake_active_low;
+	int idle_timeout_in_secs;
+	int oper_speed;
+	bool configure_audio;
+	int pcm_clockmode;
+	int pcm_fillmethod;
+	int pcm_fillnum;
+	int pcm_fillvalue;
+	int pcm_incallbitclock;
+	int pcm_lsbfirst;
+	int pcm_rightjustify;
+	int pcm_routing;
+	int pcm_shortframesync;
+	int pcm_syncmode;
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
