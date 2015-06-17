Return-Path: <cyrus@holtmann.org>
From: Ilya Faenson <ifaenson@broadcom.com>
To: Marcel Holtmann <marcel@holtmann.org>
CC: <linux-bluetooth@vger.kernel.org>,
	Arend van Spriel <arend@broadcom.com>,
	Ilya Faenson <ifaenson@broadcom.com>
Subject: [PATCH v4 4/4] hci_bcm: Broadcom UART protocol enhancements
Date: Wed, 17 Jun 2015 17:30:58 -0400
Message-ID: <1434576658-20730-5-git-send-email-ifaenson@broadcom.com>
In-Reply-To: <1434576658-20730-1-git-send-email-ifaenson@broadcom.com>
References: <1434576658-20730-1-git-send-email-ifaenson@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Merge Broadcom protocol with the existing implementation, providing:
	UART setup
	Idle suspend
	Suspend/resume upon platform suspend/resume
	Integration with the Broadcom platform device
	PCM configuration

Signed-off-by: Ilya Faenson <ifaenson@broadcom.com>
---
 drivers/bluetooth/hci_bcm.c | 340 ++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 332 insertions(+), 8 deletions(-)

diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index aa3c9ac..bfe04df 100644
--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -3,6 +3,7 @@
  *  Bluetooth HCI UART driver for Broadcom devices
  *
  *  Copyright (C) 2015  Intel Corporation
+ *  Copyright (C) 2015  Broadcom Corporation
  *
  *
  *  This program is free software; you can redistribute it and/or modify
@@ -24,6 +25,7 @@
 #include <linux/kernel.h>
 #include <linux/errno.h>
 #include <linux/skbuff.h>
+#include <linux/tty.h>
 #include <linux/firmware.h>
 
 #include <net/bluetooth/bluetooth.h>
@@ -31,12 +33,161 @@
 
 #include "btbcm.h"
 #include "hci_uart.h"
+#include "btbcm_uart.h"
 
 struct bcm_data {
 	struct sk_buff *rx_skb;
 	struct sk_buff_head txq;
+	struct hci_uart *hu;
+
+	bool is_suspended; /* suspend/resume flag */
+
+	struct timer_list timer; /* idle timer */
+
+	struct btbcm_uart_params params; /* device parameters */
+	void *device_context; /* ACPI/DT device context */
 };
 
+/* Suspend/resume synchronization mutex */
+static DEFINE_MUTEX(power_lock);
+
+/* Useful timer restart helper */
+static void restart_idle_timer(struct hci_uart *hu)
+{
+	struct bcm_data *h4 = hu->priv;
+
+	mod_timer(&h4->timer, jiffies +
+		  msecs_to_jiffies(h4->params.idle_timeout_in_secs * 1000));
+}
+
+/* Callbacks from the BCMBT_UART device
+ */
+
+/* The platform is suspending. Stop UART activity */
+static void suspend_notification(void *context)
+{
+	struct hci_uart *hu = (struct hci_uart *)context;
+	struct bcm_data *h4 = hu->priv;
+
+	BT_DBG("suspend: is_suspended %d", h4->is_suspended);
+
+	if (!h4->params.configure_sleep)
+		return;
+
+	if (!h4->is_suspended) {
+		if (h4->params.manual_fc)
+			hci_uart_set_flow_control(hu, true);
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
+	struct hci_uart *hu = (struct hci_uart *)context;
+	struct bcm_data *h4 = hu->priv;
+
+	BT_DBG("resume: is_suspended %d", h4->is_suspended);
+
+	if (!h4->params.configure_sleep)
+		return;
+
+	/* When this callback executes, the device has woken up already */
+	if (h4->is_suspended) {
+		h4->is_suspended = false;
+
+		if (h4->params.manual_fc)
+			hci_uart_set_flow_control(hu, false);
+	}
+
+	/* If we're resumed, the idle timer must be running */
+	restart_idle_timer(hu);
+}
+
+/*
+ * The BT device is resuming. Resume UART activity if suspended
+ */
+static void wakeup_notification(void *context)
+{
+	struct hci_uart *hu = (struct hci_uart *)context;
+	struct bcm_data *h4 = hu->priv;
+
+	BT_DBG("wakeup: is_suspended %d", h4->is_suspended);
+
+	if (!h4->params.configure_sleep)
+		return;
+
+	if (h4->is_suspended) {
+		if (h4->params.manual_fc)
+			hci_uart_set_flow_control(hu, false);
+
+		h4->is_suspended = false;
+	}
+
+	/* If we're resumed, the idle timer must be running */
+	restart_idle_timer(hu);
+}
+
+/*
+ * Make sure we're awake
+ * (called when the resumed state is required)
+ */
+static void bcm_ensure_wakeup(struct hci_uart *hu)
+{
+	struct bcm_data *h4 = hu->priv;
+
+	if (!h4->params.configure_sleep)
+		return;
+
+	/* Suspend/resume operations are serialized */
+	mutex_lock(&power_lock);
+
+	/* Nothing to do if resumed already */
+	if (!h4->is_suspended) {
+		mutex_unlock(&power_lock);
+
+		/* Just reset the timer */
+		restart_idle_timer(hu);
+		return;
+	}
+
+	/* Wakeup the device */
+	btbcm_uart_resume(h4->device_context);
+
+	/* Unflow control the port if configured */
+	resume_notification(hu);
+
+	mutex_unlock(&power_lock);
+}
+
+/*
+ * Idle timer callback
+ */
+static void bcm_idle_timeout(unsigned long arg)
+{
+	struct hci_uart *hu = (struct hci_uart *)arg;
+	struct bcm_data *h4 = hu->priv;
+
+	BT_DBG("idle_timeout: hu %p", hu);
+
+	/* Suspend/resume operations are serialized */
+	mutex_lock(&power_lock);
+
+	if (!h4->is_suspended) {
+		/* Flow control the port if configured */
+		suspend_notification(hu);
+
+		/* Suspend the device */
+		btbcm_uart_suspend(h4->device_context);
+	}
+
+	mutex_unlock(&power_lock);
+}
+
 static int bcm_set_baudrate(struct hci_uart *hu, unsigned int speed)
 {
 	struct hci_dev *hdev = hu->hdev;
@@ -89,6 +240,8 @@ static int bcm_set_baudrate(struct hci_uart *hu, unsigned int speed)
 static int bcm_open(struct hci_uart *hu)
 {
 	struct bcm_data *bcm;
+	struct btbcm_uart_callbacks callbacks;
+	struct tty_struct *tty = hu->tty;
 
 	BT_DBG("hu %p", hu);
 
@@ -99,6 +252,48 @@ static int bcm_open(struct hci_uart *hu)
 	skb_queue_head_init(&bcm->txq);
 
 	hu->priv = bcm;
+	bcm->hu = hu;
+	bcm->is_suspended = false;
+	memset(&bcm->params, 0, sizeof(bcm->params));
+
+	/* Reset UART to a default state */
+	hci_uart_init_tty(hu);
+
+	/* Configure callbacks on the driver */
+	callbacks.context = hu;
+	strcpy(callbacks.name, tty->name);
+	callbacks.suspend = suspend_notification;
+	callbacks.resume = resume_notification;
+	callbacks.wakeup = wakeup_notification;
+	bcm->device_context = btbcm_uart_set_callbacks(&callbacks);
+	if (!bcm->device_context) {
+		/* That is likely an indication of no bcm driver present */
+		BT_DBG("Callback set failure (no driver present)");
+
+		/* Using speed defaults */
+		hci_uart_set_speeds(hu, 115200, 3000000);
+		return 0;
+	}
+
+	/* Retrieve device parameters */
+	btbcm_uart_get_params(bcm->device_context, &bcm->params);
+	BT_DBG("Context %p conf_sleep %d dev_actlow %d bt_actlow %d idle_t %d",
+	       bcm->device_context, bcm->params.configure_sleep,
+	       bcm->params.dev_wake_active_low, bcm->params.bt_wake_active_low,
+	       bcm->params.idle_timeout_in_secs);
+	hci_uart_set_speeds(hu, 115200, bcm->params.oper_speed);
+
+	/* Cycle power to make sure the device is in the known state */
+	btbcm_uart_poweroff(bcm->device_context);
+	btbcm_uart_poweron(bcm->device_context);
+
+	/* Start the idle timer */
+	if (bcm->params.configure_sleep) {
+		setup_timer(&bcm->timer, bcm_idle_timeout, (unsigned long)hu);
+		if (bcm->params.configure_sleep)
+			restart_idle_timer(hu);
+	}
+
 	return 0;
 }
 
@@ -108,6 +303,31 @@ static int bcm_close(struct hci_uart *hu)
 
 	BT_DBG("hu %p", hu);
 
+	/* If we're being closed, we must suspend */
+	if (bcm->params.configure_sleep) {
+		mutex_lock(&power_lock);
+
+		if (!bcm->is_suspended) {
+			/* Flow control the port */
+			suspend_notification(hu);
+
+			/* Suspend the device */
+			btbcm_uart_suspend(bcm->device_context);
+		}
+
+		mutex_unlock(&power_lock);
+
+		del_timer_sync(&bcm->timer);
+	}
+
+	/* Power off the device if possible */
+	if (bcm->device_context) {
+		btbcm_uart_poweroff(bcm->device_context);
+
+		/* de-configure callbacks on the driver */
+		btbcm_uart_reset_callbacks(bcm->device_context);
+	}
+
 	skb_queue_purge(&bcm->txq);
 	kfree_skb(bcm->rx_skb);
 	kfree(bcm);
@@ -129,9 +349,12 @@ static int bcm_flush(struct hci_uart *hu)
 
 static int bcm_setup(struct hci_uart *hu)
 {
-	char fw_name[64];
+	char fw_name[128];
 	const struct firmware *fw;
 	int err;
+	struct sk_buff *skb;
+	struct bcm_data *h4 = hu->priv;
+	unsigned char time_slot_number = 0;
 
 	BT_DBG("hu %p", hu);
 
@@ -153,13 +376,110 @@ static int bcm_setup(struct hci_uart *hu)
 		goto finalize;
 	}
 
-	if (hu->proto->init_speed)
-		hci_uart_set_baudrate(hu, hu->proto->init_speed);
+	if (hu->init_speed)
+		hci_uart_set_baudrate(hu, hu->init_speed);
 
-	if (hu->proto->oper_speed) {
-		err = bcm_set_baudrate(hu, hu->proto->oper_speed);
+	if (hu->oper_speed) {
+		err = bcm_set_baudrate(hu, hu->oper_speed);
 		if (!err)
-			hci_uart_set_baudrate(hu, hu->proto->oper_speed);
+			hci_uart_set_baudrate(hu, hu->oper_speed);
+	}
+
+	/* Configure SCO PCM parameters */
+	if (h4->params.configure_audio) {
+		struct bcm_set_pcm_int_params pcm_int_params;
+		struct bcm_set_pcm_format_params pcm_format_params;
+
+		/* 0=PCM routing, 1=SCO over HCI */
+		pcm_int_params.routing = h4->params.pcm_routing;
+		/* 0=128Kbps,1=256Kbps,2=512Kbps,3=1024Kbps,4=2048Kbps */
+		pcm_int_params.rate = h4->params.pcm_incallbitclock;
+		/* short frame sync 0=short, 1=long */
+		pcm_int_params.frame_sync = h4->params.pcm_shortframesync;
+		/* sync mode 0=slave, 1=master */
+		pcm_int_params.sync_mode = h4->params.pcm_syncmode;
+		/* clock mode 0=slave, 1=master */
+		pcm_int_params.clock_mode = h4->params.pcm_clockmode;
+
+		skb = __hci_cmd_sync(hu->hdev, 0xfc1c, sizeof(pcm_int_params),
+				     &pcm_int_params, HCI_INIT_TIMEOUT);
+		if (IS_ERR(skb)) {
+			err = PTR_ERR(skb);
+			BT_ERR("bcm_setup PCM INT VSC failed (%d)", err);
+			goto finalize;
+		}
+		kfree_skb(skb);
+		BT_DBG("bcm_setup PCM INT Parameters VSC succeeded");
+
+		/* LSB_First 1=TRUE, 0=FALSE */
+		pcm_format_params.lsb_first = h4->params.pcm_lsbfirst;
+		/* Fill_Value (use 0-7 for fill bits value) */
+		pcm_format_params.fill_value = h4->params.pcm_fillvalue;
+		/* Fill_Method (2=sign extended) */
+		pcm_format_params.fill_method = h4->params.pcm_fillmethod;
+		/* Fill_Num # of fill bits 0-3) */
+		pcm_format_params.fill_num = h4->params.pcm_fillnum;
+		/* Right_Justify 1=TRUE, 0=FALSE */
+		pcm_format_params.right_justify = h4->params.pcm_rightjustify;
+
+		skb = __hci_cmd_sync(hu->hdev, 0xfc1e,
+				     sizeof(pcm_format_params),
+				     &pcm_format_params, HCI_INIT_TIMEOUT);
+		if (IS_ERR(skb)) {
+			err = PTR_ERR(skb);
+			BT_ERR("bcm_setup PCM Format VSC failed (%d)",
+			       err);
+			goto finalize;
+		}
+		kfree_skb(skb);
+		BT_DBG("bcm_setup PCM Format VSC succeeded");
+
+		skb = __hci_cmd_sync(hu->hdev, 0xfc22, sizeof(time_slot_number),
+				     &time_slot_number, HCI_INIT_TIMEOUT);
+		if (IS_ERR(skb)) {
+			err = PTR_ERR(skb);
+			BT_ERR("bcm_setup SCO Time Slot VSC failed (%d)",
+			       err);
+			goto finalize;
+		}
+		kfree_skb(skb);
+		BT_DBG("bcm_setup SCO Time Slot VSC succeeded");
+	}
+
+	/* Configure device's suspend/resume operation */
+	if (h4->params.configure_sleep) {
+		struct bcm_set_sleep_mode sleep_params;
+
+		sleep_params.sleep_mode = 1; /* UART */
+		sleep_params.idle_host = 2; /* idle threshold HOST, in 300ms */
+		sleep_params.idle_dev = 2; /* idle threshold device, in 300ms */
+		/* BT_WAKE active mode - 1=active high, 0 = active low */
+		sleep_params.bt_wake_active = (unsigned char)
+					      !h4->params.bt_wake_active_low;
+		/* HOST_WAKE active mode - 1=active high, 0 = active low */
+		sleep_params.host_wake_active = (unsigned char)
+						!h4->params.dev_wake_active_low;
+		/* Allow host sleep in SCO flag */
+		sleep_params.allow_host_sleep = 1;
+		/* Combine sleep and LPM flag */
+		sleep_params.combine_modes = 1;
+		/** Allow tristate control of UART tx flag */
+		sleep_params.tristate_control = 0;
+		/* Irrelevant USB flags */
+		sleep_params.usb_auto_sleep = 0;
+		sleep_params.usb_resume_timeout = 0;
+		sleep_params.pulsed_host_wake = 0;
+		sleep_params.break_to_host = 0;
+
+		skb = __hci_cmd_sync(hu->hdev, 0xfc27, sizeof(sleep_params),
+				     &sleep_params, HCI_INIT_TIMEOUT);
+		if (IS_ERR(skb)) {
+			err = PTR_ERR(skb);
+			BT_ERR("bcm_setup Sleep VSC failed (%d)", err);
+			goto finalize;
+		}
+		kfree_skb(skb);
+		BT_DBG("bcm_setup Set Sleep Parameters VSC succeeded");
 	}
 
 finalize:
@@ -183,6 +503,9 @@ static int bcm_recv(struct hci_uart *hu, const void *data, int count)
 	if (!test_bit(HCI_UART_REGISTERED, &hu->flags))
 		return -EUNATCH;
 
+	/* Make sure we're resumed */
+	bcm_ensure_wakeup(hu);
+
 	bcm->rx_skb = h4_recv_buf(hu->hdev, bcm->rx_skb, data, count,
 				  bcm_recv_pkts, ARRAY_SIZE(bcm_recv_pkts));
 	if (IS_ERR(bcm->rx_skb)) {
@@ -201,6 +524,9 @@ static int bcm_enqueue(struct hci_uart *hu, struct sk_buff *skb)
 
 	BT_DBG("hu %p skb %p", hu, skb);
 
+	/* Make sure we're resumed */
+	bcm_ensure_wakeup(hu);
+
 	/* Prepend skb with frame type */
 	memcpy(skb_push(skb, 1), &bt_cb(skb)->pkt_type, 1);
 	skb_queue_tail(&bcm->txq, skb);
@@ -218,8 +544,6 @@ static struct sk_buff *bcm_dequeue(struct hci_uart *hu)
 static const struct hci_uart_proto bcm_proto = {
 	.id		= HCI_UART_BCM,
 	.name		= "BCM",
-	.init_speed	= 115200,
-	.oper_speed	= 4000000,
 	.open		= bcm_open,
 	.close		= bcm_close,
 	.flush		= bcm_flush,
-- 
1.9.1

