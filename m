Return-Path: <cyrus@holtmann.org>
From: Ilya Faenson <ifaenson@broadcom.com>
To: Marcel Holtmann <marcel@holtmann.org>
CC: <linux-bluetooth@vger.kernel.org>, Arend van Spriel <arend@broadcom.com>,
	Ilya Faenson <ifaenson@broadcom.com>
Subject: [PATCH v3 3/5] Broadcom Bluetooth UART Platform Driver
Date: Wed, 17 Jun 2015 11:42:45 -0400
Message-ID: <1434555767-18234-4-git-send-email-ifaenson@broadcom.com>
In-Reply-To: <1434555767-18234-1-git-send-email-ifaenson@broadcom.com>
References: <1434555767-18234-1-git-send-email-ifaenson@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-bluetooth.vger.kernel.org>

Introduce the device tree enumerated Broadcom Bluetooth UART driver.

Signed-off-by: Ilya Faenson <ifaenson@broadcom.com>
---
 drivers/bluetooth/Makefile     |   1 +
 drivers/bluetooth/btbcm_uart.c | 580 +++++++++++++++++++++++++++++++++++++++++
 drivers/bluetooth/btbcm_uart.h |  74 ++++++
 3 files changed, 655 insertions(+)
 create mode 100644 drivers/bluetooth/btbcm_uart.c
 create mode 100644 drivers/bluetooth/btbcm_uart.h

diff --git a/drivers/bluetooth/Makefile b/drivers/bluetooth/Makefile
index f40e194..7947abb 100644
--- a/drivers/bluetooth/Makefile
+++ b/drivers/bluetooth/Makefile
@@ -21,6 +21,7 @@ obj-$(CONFIG_BT_MRVL)		+= btmrvl.o
 obj-$(CONFIG_BT_MRVL_SDIO)	+= btmrvl_sdio.o
 obj-$(CONFIG_BT_WILINK)		+= btwilink.o
 obj-$(CONFIG_BT_BCM)		+= btbcm.o
+obj-$(CONFIG_BT_BCM)		+= btbcm_uart.o
 obj-$(CONFIG_BT_RTL)		+= btrtl.o
 
 btmrvl-y			:= btmrvl_main.o
diff --git a/drivers/bluetooth/btbcm_uart.c b/drivers/bluetooth/btbcm_uart.c
new file mode 100644
index 0000000..8069997
--- /dev/null
+++ b/drivers/bluetooth/btbcm_uart.c
@@ -0,0 +1,580 @@
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
+/* Calling the BCM protocol at lower execution priority */
+static void bcm_wakeup_task(struct work_struct *work)
+{
+	struct bcm_device *dev = container_of(work, struct bcm_device,
+					      wakeup_work);
+	int gpio_value;
+
+	if (!dev)
+		return;
+
+	/* Make sure the device is resumed */
+	gpio_value = !dev->dev_wake_active_low;
+	if (dev->dev_wake_gpio) {
+		gpiod_set_value(dev->dev_wake_gpio, gpio_value);
+		BT_DBG("wakeup_task - resume %d written, delaying 15 ms",
+		       gpio_value);
+		mdelay(15);
+	}
+
+	/* Let the protocol know it's time to wake up */
+	if (dev->protocol_callbacks.p_wakeup)
+		dev->protocol_callbacks.p_wakeup(
+			dev->protocol_callbacks.context);
+}
+
+/* Interrupt routine for the wake from the device */
+static irqreturn_t bcm_uart_isr(int irq, void *context)
+{
+	unsigned int bt_wake;
+	struct bcm_device *p = (struct bcm_device *)context;
+
+	bt_wake = gpiod_get_value(p->bt_wake_gpio);
+	BT_DBG("isr with bt_wake of %d (active_low %d), req bh",
+	       bt_wake, p->bt_wake_active_low);
+
+	/* Defer the actual processing to the platform work queue */
+	schedule_work(&p->wakeup_work);
+	return IRQ_HANDLED;
+}
+
+/* Device instance startup */
+static int bcm_uart_probe(struct platform_device *pdev)
+{
+	struct device_node *np = pdev->dev.of_node;
+	const char *tty_name;
+	int ret;
+	struct bcm_device *dev;
+
+	dev = devm_kzalloc(&pdev->dev, sizeof(*dev), GFP_KERNEL);
+	if (!dev) {
+		BT_DBG("probe - failing due to no memory");
+		return -ENOMEM;
+	}
+
+	dev->pdev = pdev;
+
+	/* Get dev wake GPIO */
+	dev->dev_wake_gpio = gpiod_get(&pdev->dev, "bt-wake");
+	BT_DBG("probe %p - gpiod_get for bt-wake returned %p", dev,
+	       dev->dev_wake_gpio);
+	if (IS_ERR(dev->dev_wake_gpio)) {
+		ret = PTR_ERR(dev->dev_wake_gpio);
+		if (ret != -ENOENT)
+			dev_err(&pdev->dev, "probe - dev_wake GPIO: %d\n", ret);
+		dev->dev_wake_gpio = NULL;
+	} else {
+		int gpio_value;
+
+		dev->dev_wake_active_low = gpiod_is_active_low
+			(dev->dev_wake_gpio);
+		BT_DBG("probe - dev_wake a-low is %d (cans %d)",
+		       dev->dev_wake_active_low,
+		       gpiod_cansleep(dev->dev_wake_gpio));
+
+		/* configure dev_wake as output with init resumed state */
+		gpio_value = !dev->dev_wake_active_low;
+		ret = gpiod_direction_output(dev->dev_wake_gpio, gpio_value);
+		if (ret < 0) {
+			dev_err(&pdev->dev,
+				"probe - s dev_wake GPIO: %d\n", ret);
+			gpiod_put(dev->dev_wake_gpio);
+			dev->dev_wake_gpio = NULL;
+			goto end;
+		} else {
+			BT_DBG("probe - dev_wake set to %d", gpio_value);
+		}
+	}
+
+	/* Get power on/off GPIO */
+	dev->reg_on_gpio = gpiod_get(&pdev->dev, "bt-reg-on");
+	BT_DBG("probe - gpiod_get for bt-reg-on returned %p", dev->reg_on_gpio);
+	if (IS_ERR(dev->reg_on_gpio)) {
+		ret = PTR_ERR(dev->reg_on_gpio);
+		if (ret != -ENOENT)
+			dev_err(&pdev->dev, "probe - reg_on GPIO: %d\n", ret);
+		dev->reg_on_gpio = NULL;
+	} else {
+		int poweron_flag;
+
+		dev->reg_on_active_low = gpiod_is_active_low(dev->reg_on_gpio);
+		BT_DBG("probe - reg_on a-low is %d (cansleep %d)",
+		       dev->reg_on_active_low,
+		       gpiod_cansleep(dev->reg_on_gpio));
+
+		/* configure reg_on as output with init on state */
+		poweron_flag = !dev->reg_on_active_low;
+		ret = gpiod_direction_output(dev->reg_on_gpio, poweron_flag);
+		if (ret < 0) {
+			dev_err(&pdev->dev,
+				"probe - set reg_on GPIO: %d\n", ret);
+			gpiod_put(dev->reg_on_gpio);
+			dev->reg_on_gpio = NULL;
+		} else
+			BT_DBG("probe - reg_on initially set to %d",
+			       poweron_flag);
+	}
+
+	platform_set_drvdata(pdev, dev);
+	/* Must be done before interrupt is requested */
+	INIT_WORK(&dev->wakeup_work, bcm_wakeup_task);
+
+	/* Get bt host wake GPIO */
+	dev->bt_wake_gpio = gpiod_get(&pdev->dev, "bt-host-wake");
+	BT_DBG("probe - gpiod_get for bt-host-wake returned %p",
+	       dev->bt_wake_gpio);
+	if (IS_ERR(dev->bt_wake_gpio)) {
+		ret = PTR_ERR(dev->bt_wake_gpio);
+		if (ret != -ENOENT)
+			dev_err(&pdev->dev, "probe - bt_wake GPIO: %d\n", ret);
+		dev->bt_wake_gpio = NULL;
+	} else {
+		/* configure bt_wake as input */
+		ret = gpiod_direction_input(dev->bt_wake_gpio);
+		if (ret < 0) {
+			dev_err(&pdev->dev,
+				"probe - set bt_wake GPIO: %d\n", ret);
+			gpiod_put(dev->bt_wake_gpio);
+			dev->bt_wake_gpio = NULL;
+		} else {
+			dev->bt_wake_active_low = gpiod_is_active_low
+				(dev->bt_wake_gpio);
+			BT_DBG("probe -bt_wake a-low is %d(cansleep %d)",
+			       dev->bt_wake_active_low,
+			       gpiod_cansleep(dev->bt_wake_gpio));
+			dev->bt_wake_irq = gpiod_to_irq
+				(dev->bt_wake_gpio);
+			if (dev->bt_wake_irq < 0)
+				dev_err(&pdev->dev,
+					"probe - HOST_WAKE IRQ: %d\n", ret);
+			else {
+				unsigned long intflags = IRQF_TRIGGER_RISING;
+
+				if (dev->bt_wake_active_low)
+					intflags = IRQF_TRIGGER_FALLING;
+
+				ret = request_irq(dev->bt_wake_irq,
+						  bcm_uart_isr, intflags,
+						  "bt_host_wake", dev);
+				if (ret < 0)
+					dev_err(&pdev->dev,
+						"probe - failed IRQ %d: %d",
+						dev->bt_wake_irq, ret);
+				else
+					BT_DBG("probe - IRQ %d",
+					       dev->bt_wake_irq);
+			}
+		}
+	}
+
+	dev->configure_sleep = of_property_read_bool(np, "configure-sleep");
+	dev->manual_fc = 0;
+	of_property_read_u32(np, "manual-fc", &dev->manual_fc);
+	dev->oper_speed = 3000000;
+	of_property_read_u32(np, "oper-speed", &dev->oper_speed);
+		BT_DBG("oper-speed read as %d", dev->oper_speed);
+	dev->configure_audio = of_property_read_bool(np, "configure-audio");
+	BT_DBG("conf-sleep %d, manual-fc %d, oper-speed %d, conf-audio %d",
+	       dev->configure_sleep, dev->manual_fc, dev->oper_speed,
+	       dev->configure_audio);
+
+	if (dev->configure_audio) {
+		/* Defaults for audio */
+		dev->pcm_clockmode = 0;
+		dev->pcm_fillmethod = 2;
+		dev->pcm_fillnum = 0;
+		dev->pcm_fillvalue = 3;
+		dev->pcm_incallbitclock = 0;
+		dev->pcm_lsbfirst = 0;
+		dev->pcm_rightjustify = 0;
+		dev->pcm_routing = 0;
+		dev->pcm_shortframesync = 0;
+		dev->pcm_syncmode = 0;
+
+		of_property_read_u32(np, "pcm-clockmode", &dev->pcm_clockmode);
+		of_property_read_u32(np, "pcm-fillmethod",
+				     &dev->pcm_fillmethod);
+		of_property_read_u32(np, "pcm-fillnum", &dev->pcm_fillnum);
+		of_property_read_u32(np, "pcm-fillvalue", &dev->pcm_fillvalue);
+		of_property_read_u32(np, "pcm-incallbitclock",
+				     &dev->pcm_incallbitclock);
+		BT_DBG("pcm-clockmode %d, method %d, num %d, value %d, bit %d",
+		       dev->pcm_clockmode, dev->pcm_fillmethod,
+		       dev->pcm_fillnum, dev->pcm_fillvalue,
+		       dev->pcm_incallbitclock);
+
+		of_property_read_u32(np, "pcm-lsbfirst", &dev->pcm_lsbfirst);
+		of_property_read_u32(np, "pcm-rightjustify",
+				     &dev->pcm_rightjustify);
+		of_property_read_u32(np, "pcm-routing", &dev->pcm_routing);
+		of_property_read_u32(np, "pcm-shortframesync",
+				     &dev->pcm_shortframesync);
+		of_property_read_u32(np, "pcm-syncmode", &dev->pcm_syncmode);
+		BT_DBG("pcm-lsb %d, right %d, routing %d, short %d, sync %d",
+		       dev->pcm_lsbfirst, dev->pcm_rightjustify,
+		       dev->pcm_routing, dev->pcm_shortframesync,
+		       dev->pcm_syncmode);
+	}
+
+	if (!of_property_read_string(np, "tty", &tty_name)) {
+		strcpy(dev->tty_name, tty_name);
+		BT_DBG("tty name read as %s", dev->tty_name);
+	}
+
+	BT_DBG("idle_timeout set as %d", idle_timeout);
+
+	ret = 0;  /* If we made it here, we're fine */
+
+	/* Place this instance on the device list */
+	spin_lock(&device_list_lock);
+	list_add_tail(&dev->list, &device_list);
+	spin_unlock(&device_list_lock);
+
+end:
+	if (ret) {
+		if (dev->reg_on_gpio) {
+			gpiod_put(dev->reg_on_gpio);
+			dev->reg_on_gpio = NULL;
+		}
+		if (dev->bt_wake_gpio) {
+			gpiod_put(dev->bt_wake_gpio);
+			dev->bt_wake_gpio = NULL;
+		}
+		if (dev->dev_wake_gpio) {
+			gpiod_put(dev->dev_wake_gpio);
+			dev->dev_wake_gpio = NULL;
+		}
+	}
+
+	BT_DBG("probe with the result %d", ret);
+	return ret;
+}
+
+/* Device instance removal */
+static int bcm_uart_remove(struct platform_device *pdev)
+{
+	struct bcm_device *dev = platform_get_drvdata(pdev);
+
+	if (!dev) {
+		BT_DBG("remove - logic error, no probe?!");
+		return 0;
+	}
+
+	spin_lock(&device_list_lock);
+	list_del(&dev->list);
+	spin_unlock(&device_list_lock);
+
+	BT_DBG("remove %p - freeing interrupt %d", dev, dev->bt_wake_irq);
+	free_irq(dev->bt_wake_irq, dev);
+
+	if (dev->reg_on_gpio) {
+		BT_DBG("remove - releasing reg_on_gpio");
+		gpiod_put(dev->reg_on_gpio);
+		dev->reg_on_gpio = NULL;
+	}
+
+	if (dev->dev_wake_gpio) {
+		BT_DBG("remove - releasing dev_wake_gpio");
+		gpiod_put(dev->dev_wake_gpio);
+		dev->dev_wake_gpio = NULL;
+	}
+
+	if (dev->bt_wake_gpio) {
+		BT_DBG("remove - releasing bt_wake_gpio");
+		gpiod_put(dev->bt_wake_gpio);
+		dev->bt_wake_gpio = NULL;
+	}
+
+	BT_DBG("remove - %p done", dev);
+	return 0;
+}
+
+/* Platform resume callback */
+static int bcm_uart_resume(struct device *pdev)
+{
+	struct bcm_device *dev = platform_get_drvdata(
+		to_platform_device(pdev));
+	int gpio_value;
+
+	if (!dev) {
+		BT_DBG("resume - logic error, no device?!");
+		return 0;
+	}
+
+	BT_DBG("resume %p", dev);
+
+	gpio_value = !dev->dev_wake_active_low;
+	if (dev->dev_wake_gpio) {
+		gpiod_set_value(dev->dev_wake_gpio, gpio_value);
+		BT_DBG("resume - %d written, delaying 15 ms", gpio_value);
+		mdelay(15);
+	}
+
+	/* Let the protocol know the platform is resuming */
+	if (dev->protocol_callbacks.p_resume)
+		dev->protocol_callbacks.p_resume(
+			dev->protocol_callbacks.context);
+
+	return 0;
+}
+
+/* Platform suspend callback */
+static int bcm_uart_suspend(struct device *pdev)
+{
+	struct bcm_device *dev = platform_get_drvdata(
+		to_platform_device(pdev));
+	int gpio_value;
+
+	if (!dev) {
+		BT_DBG("suspend - logic error, no device?!");
+		return 0;
+	}
+
+	BT_DBG("suspend - %p", dev);
+
+	/* Let the protocol know the platform is suspending */
+	if (dev->protocol_callbacks.p_suspend)
+		dev->protocol_callbacks.p_suspend(
+			dev->protocol_callbacks.context);
+
+	/* Suspend the device */
+	if (dev->dev_wake_gpio) {
+		gpio_value = !!dev->dev_wake_active_low;
+		gpiod_set_value(dev->dev_wake_gpio, gpio_value);
+		BT_DBG("suspend - %d written, delaying 15 ms", gpio_value);
+		mdelay(15);
+	}
+
+	return 0;
+}
+
+/* Entry point for calls from the protocol */
+void *btbcm_uart_set_callbacks(struct btbcm_uart_callbacks *pc)
+{
+	struct bcm_device *dev = NULL;
+	bool is_found = false;
+	struct list_head *ptr;
+
+	BT_DBG("set_callbacks for %s(%p)", pc->name, pc->context);
+
+	spin_lock(&device_list_lock);
+	list_for_each(ptr, &device_list) {
+		dev = list_entry(ptr, struct bcm_device, list);
+		if (!strcmp(dev->tty_name, pc->name)) {
+			is_found = true;
+			break;
+		}
+	}
+	spin_unlock(&device_list_lock);
+
+	if (!is_found) {
+		BT_DBG("set_callbacks - no device!");
+		return NULL;
+	}
+
+	dev->protocol_callbacks = *pc;
+	return dev;
+}
+EXPORT_SYMBOL_GPL(btbcm_uart_set_callbacks);
+
+void btbcm_uart_reset_callbacks(void *device_context)
+{
+	struct bcm_device *dev = device_context;
+
+	memset(&dev->protocol_callbacks, 0, sizeof(dev->protocol_callbacks));
+}
+EXPORT_SYMBOL_GPL(btbcm_uart_reset_callbacks);
+
+void btbcm_uart_poweron(void *device_context)
+{
+	struct bcm_device *dev = device_context;
+	int poweron_flag;
+
+	if (dev->reg_on_gpio) {
+		poweron_flag = !dev->reg_on_active_low;
+		gpiod_set_value(dev->reg_on_gpio, poweron_flag);
+		BT_DBG("poweron %d, delay 15 ms", poweron_flag);
+	}
+}
+EXPORT_SYMBOL_GPL(btbcm_uart_poweron);
+
+void btbcm_uart_poweroff(void *device_context)
+{
+	struct bcm_device *dev = device_context;
+	int poweron_flag;
+
+	if (dev->reg_on_gpio) {
+		poweron_flag = dev->reg_on_active_low;
+		gpiod_set_value(dev->reg_on_gpio, poweron_flag);
+		BT_DBG("poweroff %d, delay 15 ms", poweron_flag);
+	}
+}
+EXPORT_SYMBOL_GPL(btbcm_uart_poweroff);
+
+void btbcm_uart_suspend(void *device_context)
+{
+	struct bcm_device *dev = device_context;
+	int gpio_value;
+
+	if (dev->dev_wake_gpio) {
+		gpio_value = !!dev->dev_wake_active_low;
+		gpiod_set_value(dev->dev_wake_gpio, gpio_value);
+		BT_DBG("suspend %d, delay 15ms", gpio_value);
+		mdelay(15);
+	}
+}
+EXPORT_SYMBOL_GPL(btbcm_uart_suspend);
+
+void btbcm_uart_resume(void *device_context)
+{
+	struct bcm_device *dev = device_context;
+	int gpio_value;
+
+	if (dev->dev_wake_gpio) {
+		gpio_value = !dev->dev_wake_active_low;
+		gpiod_set_value(dev->dev_wake_gpio, gpio_value);
+		BT_DBG("resume %d, delay 15ms", gpio_value);
+		mdelay(15);
+	}
+}
+EXPORT_SYMBOL_GPL(btbcm_uart_resume);
+
+void btbcm_uart_get_params(void *device_context, struct btbcm_uart_params *pp)
+{
+	struct bcm_device *dev = device_context;
+
+	memset(pp, 0, sizeof(struct btbcm_uart_params));
+	pp->configure_sleep = dev->configure_sleep;
+	pp->manual_fc = dev->manual_fc;
+	pp->dev_wake_active_low = dev->dev_wake_active_low;
+	pp->bt_wake_active_low = dev->bt_wake_active_low;
+	pp->idle_timeout_in_secs = idle_timeout;
+	pp->oper_speed = dev->oper_speed;
+	pp->configure_audio = dev->configure_audio;
+	pp->pcm_clockmode = dev->pcm_clockmode;
+	pp->pcm_fillmethod = dev->pcm_fillmethod;
+	pp->pcm_fillnum = dev->pcm_fillnum;
+	pp->pcm_fillvalue = dev->pcm_fillvalue;
+	pp->pcm_incallbitclock = dev->pcm_incallbitclock;
+	pp->pcm_lsbfirst = dev->pcm_lsbfirst;
+	pp->pcm_rightjustify = dev->pcm_rightjustify;
+	pp->pcm_routing = dev->pcm_routing;
+	pp->pcm_shortframesync = dev->pcm_shortframesync;
+	pp->pcm_syncmode = dev->pcm_syncmode;
+}
+EXPORT_SYMBOL_GPL(btbcm_uart_get_params);
+
+/* Platform susp and resume callbacks */
+static SIMPLE_DEV_PM_OPS(bcm_uart_pm_ops, bcm_uart_suspend, bcm_uart_resume);
+
+/* Driver match table */
+static const struct of_device_id bcm_uart_table[] = {
+	{ .compatible = "brcm,brcm-bt-uart" },
+	{}
+};
+
+/* Driver configuration */
+static struct platform_driver bcm_uart_driver = {
+	.probe = bcm_uart_probe,
+	.remove = bcm_uart_remove,
+	.driver = {
+		.name = "btbcm_uart",
+		.of_match_table = of_match_ptr(bcm_uart_table),
+		.owner = THIS_MODULE,
+		.pm = &bcm_uart_pm_ops,
+	},
+};
+
+module_platform_driver(bcm_uart_driver);
+
+MODULE_AUTHOR("Ilya Faenson <ifaenson@broadcom.com>");
+MODULE_DESCRIPTION("Broadcom Bluetooth UART Driver");
+MODULE_LICENSE("GPL");
+
diff --git a/drivers/bluetooth/btbcm_uart.h b/drivers/bluetooth/btbcm_uart.h
new file mode 100644
index 0000000..96dae85
--- /dev/null
+++ b/drivers/bluetooth/btbcm_uart.h
@@ -0,0 +1,74 @@
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
+/* Callbacks from the driver into the protocol */
+struct btbcm_uart_callbacks {
+	void *context;	/* protocol instance context */
+	char name[64];	/* protocol tty device, for example, ttyS0 */
+
+	/* client callbacks */
+	void (*p_suspend)(void *context);
+	void (*p_resume)(void *context);
+	void (*p_wakeup)(void *context);
+};
+
+/* Driver parameters retrieved from the DT or ACPI */
+struct btbcm_uart_params {
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
+/* Actions on the BTBCM_UART driver
+ */
+
+/* Configure protocol callbacks */
+extern void *btbcm_uart_set_callbacks(struct btbcm_uart_callbacks *pc);
+
+/* Reset protocol callbacks */
+extern void btbcm_uart_reset_callbacks(void *device_context);
+
+/* Retrieve BT device parameters */
+extern void btbcm_uart_get_params(void *device_context,
+				  struct btbcm_uart_params *pp);
+
+/* Resume the BT device via GPIO */
+extern void btbcm_uart_resume(void *device_context);
+
+/* Suspend the BT device via GPIO */
+extern void btbcm_uart_suspend(void *device_context);
+
+/* Power the BT device off via GPIO */
+extern void btbcm_uart_poweroff(void *device_context);
+
+/* Power the BT device on via GPIO */
+extern void btbcm_uart_poweron(void *device_context);
+
-- 
1.9.1
