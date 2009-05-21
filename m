Return-Path: <cyrus@holtmann.org>
From: Bing Zhao <bzhao@marvell.com>
To: linux-bluetooth@vger.kernel.org
Cc: Bing Zhao <bzhao@marvell.com>
Subject: [PATCH 1/4] bluetooth: add bt_mrvl driver to support Marvell bluetooth devices
Date: Wed, 20 May 2009 17:35:38 -0700
Message-Id: <1242866141-22325-1-git-send-email-bzhao@marvell.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This driver, bt_mrvl, provides basic definitions and library functions
to support Marvell Bluetooth enabled devices, such as 88W8688 WLAN/BT
combo chip.

This patch incorporates a lot of comments given by
Nicolas Pitre <nico@marvell.com>. Many thanks to Nicolas Pitre.

Signed-off-by: Rahul Tank <rahult@marvell.com>
Signed-off-by: Bing Zhao <bzhao@marvell.com>
---
 drivers/bluetooth/Kconfig            |    2 +
 drivers/bluetooth/Makefile           |    2 +
 drivers/bluetooth/bt_mrvl/Kconfig    |   12 +
 drivers/bluetooth/bt_mrvl/Makefile   |    7 +
 drivers/bluetooth/bt_mrvl/btm_drv.h  |  223 +++++++++++
 drivers/bluetooth/bt_mrvl/btm_main.c |  728 ++++++++++++++++++++++++++++++++++
 6 files changed, 974 insertions(+), 0 deletions(-)
 create mode 100644 drivers/bluetooth/bt_mrvl/Kconfig
 create mode 100644 drivers/bluetooth/bt_mrvl/Makefile
 create mode 100644 drivers/bluetooth/bt_mrvl/btm_drv.h
 create mode 100644 drivers/bluetooth/bt_mrvl/btm_main.c

diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
index 1164837..6e4b9b5 100644
--- a/drivers/bluetooth/Kconfig
+++ b/drivers/bluetooth/Kconfig
@@ -170,5 +170,7 @@ config BT_HCIVHCI
 	  Say Y here to compile support for virtual HCI devices into the
 	  kernel or say M to compile it as module (hci_vhci).
 
+source "drivers/bluetooth/bt_mrvl/Kconfig"
+
 endmenu
 
diff --git a/drivers/bluetooth/Makefile b/drivers/bluetooth/Makefile
index 16930f9..a428510 100644
--- a/drivers/bluetooth/Makefile
+++ b/drivers/bluetooth/Makefile
@@ -15,6 +15,8 @@ obj-$(CONFIG_BT_HCIBTUART)	+= btuart_cs.o
 obj-$(CONFIG_BT_HCIBTUSB)	+= btusb.o
 obj-$(CONFIG_BT_HCIBTSDIO)	+= btsdio.o
 
+obj-$(CONFIG_BT_MRVL)		+= bt_mrvl/
+
 hci_uart-y				:= hci_ldisc.o
 hci_uart-$(CONFIG_BT_HCIUART_H4)	+= hci_h4.o
 hci_uart-$(CONFIG_BT_HCIUART_BCSP)	+= hci_bcsp.o
diff --git a/drivers/bluetooth/bt_mrvl/Kconfig b/drivers/bluetooth/bt_mrvl/Kconfig
new file mode 100644
index 0000000..9b6202b
--- /dev/null
+++ b/drivers/bluetooth/bt_mrvl/Kconfig
@@ -0,0 +1,12 @@
+config BT_MRVL
+	tristate "Marvell Bluetooth driver support"
+	depends on BT
+	select FW_LOADER
+	help
+	  The core driver to support Marvell Bluetooth devices.
+
+	  This driver is required if you want to support
+	  Marvell Bluetooth devices, such as 8688.
+
+	  Say Y here to compile Marvell Bluetooth driver
+	  into the kernel or say M to compile it as module.
diff --git a/drivers/bluetooth/bt_mrvl/Makefile b/drivers/bluetooth/bt_mrvl/Makefile
new file mode 100644
index 0000000..88b457b
--- /dev/null
+++ b/drivers/bluetooth/bt_mrvl/Makefile
@@ -0,0 +1,7 @@
+#
+# Makefile for Marvell Bluetooth driver
+#
+
+bt_mrvl-objs := btm_main.o
+
+obj-$(CONFIG_BT_MRVL) += bt_mrvl.o
diff --git a/drivers/bluetooth/bt_mrvl/btm_drv.h b/drivers/bluetooth/bt_mrvl/btm_drv.h
new file mode 100644
index 0000000..68a74cc
--- /dev/null
+++ b/drivers/bluetooth/bt_mrvl/btm_drv.h
@@ -0,0 +1,223 @@
+/*
+ * Marvell Bluetooth driver: global definitions & declarations
+ *
+ * Copyright (C) 2009, Marvell International Ltd.
+ *
+ * This software file (the "File") is distributed by Marvell International
+ * Ltd. under the terms of the GNU General Public License Version 2, June 1991
+ * (the "License").  You may use, redistribute and/or modify this File in
+ * accordance with the terms and conditions of the License, a copy of which
+ * is available by writing to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA or on the
+ * worldwide web at http://www.gnu.org/licenses/old-licenses/gpl-2.0.txt.
+ *
+ *
+ * THE FILE IS DISTRIBUTED AS-IS, WITHOUT WARRANTY OF ANY KIND, AND THE
+ * IMPLIED WARRANTIES OF MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE
+ * ARE EXPRESSLY DISCLAIMED.  The License provides additional details about
+ * this warranty disclaimer.
+ *
+ */
+
+#ifndef _BTM_DRV_H_
+#define _BTM_DRV_H_
+
+#include <linux/kthread.h>
+#include <linux/bitops.h>
+
+#define BTM_HEADER_LEN		4
+
+#define	DBG_MSG			BIT(0)	/* Message */
+#define DBG_FATAL		BIT(1)	/* Fatal */
+#define DBG_ERROR		BIT(2)	/* Error */
+#define DBG_CMD			BIT(3)	/* Command */
+#define DBG_DATA		BIT(27)	/* Data */
+#define DBG_ENTRY		BIT(28)	/* Entry */
+#define DBG_WARN		BIT(29)	/* Warning */
+#define DBG_INFO		BIT(30)	/* Informative */
+
+#ifdef	CONFIG_BT_MRVL_DEBUG
+extern u32 btm_drvdbg;
+
+#define	PRINTM_INFO(msg...)  do {if (btm_drvdbg & DBG_INFO)  \
+				printk(KERN_DEBUG msg); } while (0)
+
+#define	PRINTM_WARN(msg...)  do {if (btm_drvdbg & DBG_WARN)  \
+				printk(KERN_DEBUG msg); } while (0)
+
+#define	PRINTM_ENTRY(msg...) do {if (btm_drvdbg & DBG_ENTRY) \
+				printk(KERN_DEBUG msg); } while (0)
+
+#define	PRINTM_CMD(msg...)   do {if (btm_drvdbg & DBG_CMD)   \
+				printk(KERN_DEBUG msg); } while (0)
+
+#define	PRINTM_ERROR(msg...) do {if (btm_drvdbg & DBG_ERROR) \
+				printk(KERN_DEBUG msg); } while (0)
+
+#define	PRINTM_FATAL(msg...) do {if (btm_drvdbg & DBG_FATAL) \
+				printk(KERN_DEBUG msg); } while (0)
+
+#define	PRINTM_MSG(msg...)   do {if (btm_drvdbg & DBG_MSG)   \
+				printk(KERN_ALERT msg); } while (0)
+
+/* Print message with required level */
+#define	PRINTM(level, msg...) PRINTM_##level(msg)
+
+#define	ENTER()			PRINTM(ENTRY, "Enter: %s, %s:%i\n", \
+					__func__, __FILE__, __LINE__)
+#define	LEAVE()			PRINTM(ENTRY, "Leave: %s, %s:%i\n", \
+					__func__, __FILE__, __LINE__)
+
+#define DBG_DUMP_BUF_LEN 	64
+#define MAX_DUMP_PER_LINE	16
+
+static inline void btm_hexdump(char *prompt, u8 *buf, int len)
+{
+	int i;
+	char dbgdumpbuf[DBG_DUMP_BUF_LEN];
+	char *ptr = dbgdumpbuf;
+
+	printk(KERN_DEBUG "%s: len=%d\n", prompt, len);
+
+	for (i = 1; i <= len; i++) {
+		ptr += sprintf(ptr, "%02x ", *buf);
+		buf++;
+		if (i % MAX_DUMP_PER_LINE == 0) {
+			*ptr = 0;
+			printk(KERN_DEBUG "%s\n", dbgdumpbuf);
+			ptr = dbgdumpbuf;
+		}
+	}
+
+	if (len % MAX_DUMP_PER_LINE) {
+		*ptr = 0;
+		printk(KERN_DEBUG "%s\n", dbgdumpbuf);
+	}
+}
+
+#define DBG_HEXDUMP_DBG_DATA(x, y, z)	do {if (btm_drvdbg & DBG_DATA) \
+						btm_hexdump(x, y, z); \
+					} while (0)
+
+#define	DBG_HEXDUMP(level, x, y, z)	DBG_HEXDUMP_##level(x, y, z)
+
+#else
+
+/* Do nothing */
+#define	PRINTM(level, msg...)		do {} while (0)
+#define DBG_HEXDUMP(level, x, y, z)	do {} while (0)
+#define	ENTER()				do {} while (0)
+#define	LEAVE()				do {} while (0)
+
+#endif /* CONFIG_BT_MRVL_DEBUG */
+
+#define BT_DEV_NAME_LEN			32
+#define	BT_UPLD_SIZE			2312
+
+/* Time to wait until Host Sleep state change in millisecond */
+#define WAIT_UNTIL_HS_STATE_CHANGED	5000
+/* Time to wait for command response in millisecond */
+#define WAIT_UNTIL_CMD_RESP		5000
+
+struct btm_thread {
+	struct task_struct *task;
+	wait_queue_head_t wait_q;
+	pid_t pid;
+	void *priv;
+};
+
+struct btm_device {
+	char name[BT_DEV_NAME_LEN];
+	void *card;
+	struct hci_dev *hcidev;
+
+	u8 tx_dnld_rdy;
+
+	u8 psmode;
+	u8 pscmd;
+	u8 hsmode;
+	u8 hscmd;
+
+	/* Low byte is gap, high byte is GPIO */
+	u16 gpio_gap;
+
+	u8 hscfgcmd;
+	u8 sendcmdflag;
+};
+
+struct btm_adapter {
+	u32 int_count;
+	struct sk_buff_head tx_queue;
+	u8 psmode;
+	u8 ps_state;
+	u8 hs_state;
+	u8 wakeup_tries;
+	wait_queue_head_t cmd_wait_q;
+	u8 cmd_complete;
+};
+
+struct btm_private {
+	struct btm_device btm_dev;
+	struct btm_adapter *adapter;
+	struct btm_thread main_thread;
+	int (*hw_host_to_card) (struct btm_private *priv,
+				u8 *payload, u16 nb);
+	int (*hw_wakeup_firmware) (struct btm_private *priv);
+	spinlock_t driver_lock;		/* spinlock used by driver */
+};
+
+#define MRVL_VENDOR_PKT			0xFE
+
+/* Bluetooth commands  */
+#define BT_CMD_AUTO_SLEEP_MODE		0x23
+#define BT_CMD_HOST_SLEEP_CONFIG	0x59
+#define BT_CMD_HOST_SLEEP_ENABLE	0x5A
+#define BT_CMD_MODULE_CFG_REQ		0x5B
+
+/* Sub-commands: Module Bringup/Shutdown Request */
+#define MODULE_BRINGUP_REQ		0xF1
+#define MODULE_SHUTDOWN_REQ		0xF2
+
+#define BT_EVENT_POWER_STATE		0x20
+
+/* Bluetooth Power States */
+#define BT_PS_ENABLE			0x02
+#define BT_PS_DISABLE			0x03
+#define BT_PS_SLEEP			0x01
+
+#define OGF				0x3F
+
+/* Host Sleep states */
+#define HS_ACTIVATED			0x01
+#define HS_DEACTIVATED			0x00
+
+/* Power Save modes */
+#define PS_SLEEP			0x01
+#define PS_AWAKE			0x00
+
+struct btm_cmd {
+	__le16 ocf_ogf;
+	u8 length;
+	u8 data[4];
+} __attribute__ ((packed));
+
+struct btm_event {
+	u8 ec;		/* event counter */
+	u8 length;
+	u8 data[4];
+} __attribute__ ((packed));
+
+/* Prototype of global function */
+
+struct btm_private *btm_add_card(void *card);
+int btm_remove_card(struct btm_private *priv);
+
+void btm_interrupt(struct btm_private *priv);
+
+void btm_check_evtpkt(struct btm_private *priv, struct sk_buff *skb);
+int btm_process_event(struct btm_private *priv, struct sk_buff *skb);
+
+int btm_send_module_cfg_cmd(struct btm_private *priv, int subcmd);
+int btm_prepare_command(struct btm_private *priv);
+
+#endif /* _BTM_DRV_H_ */
diff --git a/drivers/bluetooth/bt_mrvl/btm_main.c b/drivers/bluetooth/bt_mrvl/btm_main.c
new file mode 100644
index 0000000..0bdd297
--- /dev/null
+++ b/drivers/bluetooth/bt_mrvl/btm_main.c
@@ -0,0 +1,728 @@
+/**
+ * Marvell Bluetooth driver
+ *
+ * Copyright (C) 2009, Marvell International Ltd.
+ *
+ * This software file (the "File") is distributed by Marvell International
+ * Ltd. under the terms of the GNU General Public License Version 2, June 1991
+ * (the "License").  You may use, redistribute and/or modify this File in
+ * accordance with the terms and conditions of the License, a copy of which
+ * is available by writing to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA or on the
+ * worldwide web at http://www.gnu.org/licenses/old-licenses/gpl-2.0.txt.
+ *
+ *
+ * THE FILE IS DISTRIBUTED AS-IS, WITHOUT WARRANTY OF ANY KIND, AND THE
+ * IMPLIED WARRANTIES OF MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE
+ * ARE EXPRESSLY DISCLAIMED.  The License provides additional details about
+ * this warranty disclaimer.
+ **/
+
+#include <net/bluetooth/bluetooth.h>
+#include <net/bluetooth/hci_core.h>
+
+#include "btm_drv.h"
+
+#define VERSION "1.0"
+
+#ifdef CONFIG_BT_MRVL_DEBUG
+u32 btm_drvdbg = DBG_MSG | DBG_FATAL | DBG_ERROR;
+EXPORT_SYMBOL_GPL(btm_drvdbg);
+#endif
+
+/*
+ * This function is called by interface specific interrupt handler.
+ * It updates Power Save & Host Sleep states, and wakes up the main
+ * thread.
+ */
+void btm_interrupt(struct btm_private *priv)
+{
+	ENTER();
+
+	priv->adapter->ps_state = PS_AWAKE;
+
+	priv->adapter->wakeup_tries = 0;
+
+	priv->adapter->int_count++;
+
+	wake_up_interruptible(&priv->main_thread.wait_q);
+
+	LEAVE();
+}
+EXPORT_SYMBOL_GPL(btm_interrupt);
+
+void btm_check_evtpkt(struct btm_private *priv, struct sk_buff *skb)
+{
+	struct hci_event_hdr *hdr = (struct hci_event_hdr *)skb->data;
+	struct hci_ev_cmd_complete *ec;
+	u16 opcode, ocf;
+
+	ENTER();
+
+	if (hdr->evt == HCI_EV_CMD_COMPLETE) {
+		ec = (struct hci_ev_cmd_complete *)(skb->data +
+						    HCI_EVENT_HDR_SIZE);
+		opcode = __le16_to_cpu(ec->opcode);
+		ocf = hci_opcode_ocf(opcode);
+		if ((ocf == BT_CMD_MODULE_CFG_REQ) &&
+		    (priv->btm_dev.sendcmdflag)) {
+			priv->btm_dev.sendcmdflag = false;
+			priv->adapter->cmd_complete = true;
+			wake_up_interruptible(&priv->adapter->cmd_wait_q);
+		}
+	}
+
+	LEAVE();
+}
+EXPORT_SYMBOL_GPL(btm_check_evtpkt);
+
+int btm_process_event(struct btm_private *priv, struct sk_buff *skb)
+{
+	struct btm_adapter *adapter = priv->adapter;
+	u8 ret = 0;
+	struct btm_event *event;
+
+	ENTER();
+
+	event = (struct btm_event *) skb->data;
+	if (event->ec != 0xff) {
+		PRINTM(CMD, "Not Marvell Event=%x\n", event->ec);
+		ret = -EINVAL;
+		goto exit;
+	}
+
+	switch (event->data[0]) {
+	case BT_CMD_AUTO_SLEEP_MODE:
+		if (!event->data[2]) {
+			if (event->data[1] == BT_PS_ENABLE)
+				adapter->psmode = 1;
+			else
+				adapter->psmode = 0;
+			PRINTM(CMD, "PS Mode:%s\n",
+				(adapter->psmode) ? "Enable" : "Disable");
+		} else {
+			PRINTM(CMD, "PS Mode command failed\n");
+		}
+		break;
+
+	case BT_CMD_HOST_SLEEP_CONFIG:
+		if (!event->data[3])
+			PRINTM(CMD, "gpio=%x, gap=%x\n",
+					event->data[1],
+					event->data[2]);
+		else
+			PRINTM(CMD, "HSCFG command failed\n");
+		break;
+
+	case BT_CMD_HOST_SLEEP_ENABLE:
+		if (!event->data[1]) {
+			adapter->hs_state = HS_ACTIVATED;
+			if (adapter->psmode)
+				adapter->ps_state = PS_SLEEP;
+			wake_up_interruptible(&adapter->cmd_wait_q);
+			PRINTM(CMD, "HS ACTIVATED!\n");
+		} else {
+			PRINTM(CMD, "HS Enable failed\n");
+		}
+		break;
+
+	case BT_CMD_MODULE_CFG_REQ:
+		if ((priv->btm_dev.sendcmdflag) &&
+			(event->data[1] == MODULE_BRINGUP_REQ)) {
+			PRINTM(CMD, "EVENT:%s\n",
+				(event->data[2]) ?
+					"Bring-up failed" :
+					"Bring-up succeed");
+		} else if ((priv->btm_dev.sendcmdflag) &&
+			(event->data[1] == MODULE_SHUTDOWN_REQ)) {
+			PRINTM(CMD, "EVENT:%s\n",
+				(event->data[2]) ?
+					"Shutdown failed" :
+					"Shutdown succeed");
+		} else {
+			PRINTM(CMD, "BT_CMD_MODULE_CFG_REQ resp for APP\n");
+			ret = -EINVAL;
+		}
+		break;
+
+	case BT_EVENT_POWER_STATE:
+		if (event->data[1] == BT_PS_SLEEP)
+			adapter->ps_state = PS_SLEEP;
+		PRINTM(CMD, "EVENT:%s\n",
+			(adapter->ps_state) ? "PS_SLEEP" : "PS_AWAKE");
+		break;
+
+	default:
+		PRINTM(CMD, "Unknown Event=%d\n", event->data[0]);
+		ret = -EINVAL;
+		break;
+	}
+
+exit:
+	if (!ret)
+		kfree_skb(skb);
+
+	LEAVE();
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(btm_process_event);
+
+int btm_send_module_cfg_cmd(struct btm_private *priv, int subcmd)
+{
+	struct sk_buff *skb = NULL;
+	u8 ret = 0;
+	struct btm_cmd *cmd;
+
+	ENTER();
+
+	skb = bt_skb_alloc(sizeof(*cmd), GFP_ATOMIC);
+	if (skb == NULL) {
+		PRINTM(WARN, "No free skb\n");
+		ret = -ENOMEM;
+		goto exit;
+	}
+
+	cmd = (struct btm_cmd *) skb->tail;
+	cmd->ocf_ogf = cpu_to_le16((OGF << 10) | BT_CMD_MODULE_CFG_REQ);
+	cmd->length = 1;
+	cmd->data[0] = subcmd;
+
+	bt_cb(skb)->pkt_type = MRVL_VENDOR_PKT;
+
+	skb_put(skb, sizeof(*cmd));
+	skb->dev = (void *)priv->btm_dev.hcidev;
+	skb_queue_head(&priv->adapter->tx_queue, skb);
+
+	priv->btm_dev.sendcmdflag = true;
+
+	priv->adapter->cmd_complete = false;
+
+	PRINTM(CMD, "Queue module cfg Command\n");
+
+	wake_up_interruptible(&priv->main_thread.wait_q);
+
+	if (!wait_event_interruptible_timeout(
+			priv->adapter->cmd_wait_q,
+			priv->adapter->cmd_complete,
+			msecs_to_jiffies(WAIT_UNTIL_CMD_RESP))) {
+		ret = -ETIMEDOUT;
+		PRINTM(MSG, "module_cfg_cmd(%x): timeout: %d\n",
+				subcmd, priv->btm_dev.sendcmdflag);
+	}
+
+	PRINTM(CMD, "module cfg Command done\n");
+
+exit:
+	LEAVE();
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(btm_send_module_cfg_cmd);
+
+static int btm_enable_hs(struct btm_private *priv)
+{
+	struct sk_buff *skb = NULL;
+	u8 ret = 0;
+	struct btm_cmd *cmd;
+
+	ENTER();
+
+	skb = bt_skb_alloc(sizeof(*cmd), GFP_ATOMIC);
+	if (skb == NULL) {
+		PRINTM(WARN, "No free skb\n");
+		ret = -ENOMEM;
+		goto exit;
+	}
+
+	cmd = (struct btm_cmd *) skb->tail;
+	cmd->ocf_ogf = cpu_to_le16((OGF << 10) | BT_CMD_HOST_SLEEP_ENABLE);
+	cmd->length = 0;
+
+	bt_cb(skb)->pkt_type = MRVL_VENDOR_PKT;
+
+	skb_put(skb, sizeof(*cmd));
+	skb->dev = (void *)priv->btm_dev.hcidev;
+	skb_queue_head(&priv->adapter->tx_queue, skb);
+
+	PRINTM(CMD, "Queue hs enable Command\n");
+
+	wake_up_interruptible(&priv->main_thread.wait_q);
+
+	if (!wait_event_interruptible_timeout(
+			priv->adapter->cmd_wait_q,
+			priv->adapter->hs_state,
+			msecs_to_jiffies(WAIT_UNTIL_HS_STATE_CHANGED))) {
+		ret = -ETIMEDOUT;
+		PRINTM(MSG, "btm_enable_hs: timeout: %d, %d,%d\n",
+			priv->adapter->hs_state,
+			priv->adapter->ps_state,
+			priv->adapter->wakeup_tries);
+	}
+
+exit:
+	LEAVE();
+
+	return ret;
+}
+
+int btm_prepare_command(struct btm_private *priv)
+{
+	struct sk_buff *skb = NULL;
+	u8 ret = 0;
+	struct btm_cmd *cmd;
+
+	ENTER();
+
+	if (priv->btm_dev.hscfgcmd) {
+		priv->btm_dev.hscfgcmd = 0;
+
+		skb = bt_skb_alloc(sizeof(*cmd), GFP_ATOMIC);
+		if (skb == NULL) {
+			PRINTM(WARN, "No free skb\n");
+			ret = -ENOMEM;
+			goto exit;
+		}
+
+		cmd = (struct btm_cmd *) skb->tail;
+		cmd->ocf_ogf = cpu_to_le16((OGF << 10) |
+						BT_CMD_HOST_SLEEP_CONFIG);
+		cmd->length = 2;
+		cmd->data[0] = (priv->btm_dev.gpio_gap & 0xff00) >> 8;
+		cmd->data[1] = (u8) (priv->btm_dev.gpio_gap & 0x00ff);
+
+		bt_cb(skb)->pkt_type = MRVL_VENDOR_PKT;
+
+		skb_put(skb, sizeof(*cmd));
+		skb->dev = (void *)priv->btm_dev.hcidev;
+		skb_queue_head(&priv->adapter->tx_queue, skb);
+
+		PRINTM(CMD, "Queue HSCFG Command, gpio=0x%x, gap=0x%x\n",
+		       cmd->data[0], cmd->data[1]);
+	}
+
+	if (priv->btm_dev.pscmd) {
+		priv->btm_dev.pscmd = 0;
+
+		skb = bt_skb_alloc(sizeof(*cmd), GFP_ATOMIC);
+		if (skb == NULL) {
+			PRINTM(WARN, "No free skb\n");
+			ret = -ENOMEM;
+			goto exit;
+		}
+
+		cmd = (struct btm_cmd *) skb->tail;
+		cmd->ocf_ogf = cpu_to_le16((OGF << 10) |
+						BT_CMD_AUTO_SLEEP_MODE);
+		cmd->length = 1;
+
+		if (priv->btm_dev.psmode)
+			cmd->data[0] = BT_PS_ENABLE;
+		else
+			cmd->data[0] = BT_PS_DISABLE;
+
+		bt_cb(skb)->pkt_type = MRVL_VENDOR_PKT;
+
+		skb_put(skb, sizeof(*cmd));
+		skb->dev = (void *)priv->btm_dev.hcidev;
+		skb_queue_head(&priv->adapter->tx_queue, skb);
+
+		PRINTM(CMD, "Queue PSMODE Command:%d\n", cmd->data[0]);
+	}
+
+	if (priv->btm_dev.hscmd) {
+		priv->btm_dev.hscmd = 0;
+
+		if (priv->btm_dev.hsmode) {
+			ret = btm_enable_hs(priv);
+		} else {
+			ret = priv->hw_wakeup_firmware(priv);
+			priv->adapter->hs_state = HS_DEACTIVATED;
+		}
+	}
+
+exit:
+	LEAVE();
+
+	return ret;
+}
+
+static int btm_tx_pkt(struct btm_private *priv, struct sk_buff *skb)
+{
+	u8 ret = 0;
+
+	ENTER();
+
+	if (!skb || !skb->data) {
+		LEAVE();
+		return -EINVAL;
+	}
+
+	if (!skb->len || ((skb->len + BTM_HEADER_LEN) > BT_UPLD_SIZE)) {
+		PRINTM(ERROR, "Tx Error: Bad skb length %d : %d\n",
+			skb->len, BT_UPLD_SIZE);
+		LEAVE();
+		return -EINVAL;
+	}
+
+	if (skb_headroom(skb) < BTM_HEADER_LEN) {
+		struct sk_buff *tmp = skb;
+
+		skb = skb_realloc_headroom(skb, BTM_HEADER_LEN);
+		if (!skb) {
+			PRINTM(ERROR, "Tx Error: realloc_headroom failed %d\n",
+				BTM_HEADER_LEN);
+			skb = tmp;
+			LEAVE();
+			return -EINVAL;
+		}
+
+		kfree_skb(tmp);
+	}
+
+	skb_push(skb, BTM_HEADER_LEN);
+
+	/* header type: byte[3]
+	 * HCI_COMMAND = 1, ACL_DATA = 2, SCO_DATA = 3, 0xFE = Vendor
+	 * header length: byte[2][1][0]
+	 */
+
+	skb->data[0] = (skb->len & 0x0000ff);
+	skb->data[1] = (skb->len & 0x00ff00) >> 8;
+	skb->data[2] = (skb->len & 0xff0000) >> 16;
+	skb->data[3] = bt_cb(skb)->pkt_type;
+
+	if (priv->hw_host_to_card)
+		ret = priv->hw_host_to_card(priv, skb->data, skb->len);
+
+	LEAVE();
+
+	return ret;
+}
+
+static void btm_init_adapter(struct btm_private *priv)
+{
+	ENTER();
+
+	skb_queue_head_init(&priv->adapter->tx_queue);
+
+	priv->adapter->ps_state = PS_AWAKE;
+
+	init_waitqueue_head(&priv->adapter->cmd_wait_q);
+
+	LEAVE();
+}
+
+static void btm_free_adapter(struct btm_private *priv)
+{
+	ENTER();
+
+	skb_queue_purge(&priv->adapter->tx_queue);
+
+	kfree(priv->adapter);
+
+	priv->adapter = NULL;
+
+	LEAVE();
+}
+
+static int
+btm_ioctl(struct hci_dev *hdev, unsigned int cmd, unsigned long arg)
+{
+	ENTER();
+
+	LEAVE();
+
+	return -ENOIOCTLCMD;
+}
+
+static void btm_destruct(struct hci_dev *hdev)
+{
+	ENTER();
+
+	LEAVE();
+}
+
+static int btm_send_frame(struct sk_buff *skb)
+{
+	struct hci_dev *hdev = (struct hci_dev *)skb->dev;
+	struct btm_private *priv = NULL;
+
+	ENTER();
+
+	PRINTM(INFO, "btm_send_frame: Type=%d, len=%d\n", skb->pkt_type,
+	       skb->len);
+
+	DBG_HEXDUMP(DBG_DATA, "btm_send_frame", skb->data, skb->len);
+
+	if (!hdev || !hdev->driver_data) {
+		PRINTM(ERROR, "Frame for unknown HCI device (hdev=NULL)\n");
+		LEAVE();
+		return -ENODEV;
+	}
+
+	priv = (struct btm_private *)hdev->driver_data;
+	if (!test_bit(HCI_RUNNING, &hdev->flags)) {
+		PRINTM(ERROR, "Fail test HCI_RUNING,flag=%lx\n", hdev->flags);
+		LEAVE();
+		return -EBUSY;
+	}
+
+	switch (bt_cb(skb)->pkt_type) {
+	case HCI_COMMAND_PKT:
+		hdev->stat.cmd_tx++;
+		break;
+
+	case HCI_ACLDATA_PKT:
+		hdev->stat.acl_tx++;
+		break;
+
+	case HCI_SCODATA_PKT:
+		hdev->stat.sco_tx++;
+		break;
+	}
+
+	skb_queue_tail(&priv->adapter->tx_queue, skb);
+
+	wake_up_interruptible(&priv->main_thread.wait_q);
+
+	LEAVE();
+
+	return 0;
+}
+
+static int btm_flush(struct hci_dev *hdev)
+{
+	struct btm_private *priv = (struct btm_private *)hdev->driver_data;
+
+	ENTER();
+
+	skb_queue_purge(&priv->adapter->tx_queue);
+
+	LEAVE();
+
+	return 0;
+}
+
+static int btm_close(struct hci_dev *hdev)
+{
+	struct btm_private *priv = (struct btm_private *)hdev->driver_data;
+
+	ENTER();
+
+	if (!test_and_clear_bit(HCI_RUNNING, &hdev->flags)) {
+		LEAVE();
+		return 0;
+	}
+
+	skb_queue_purge(&priv->adapter->tx_queue);
+
+	LEAVE();
+
+	return 0;
+}
+
+static int btm_open(struct hci_dev *hdev)
+{
+	ENTER();
+
+	set_bit(HCI_RUNNING, &hdev->flags);
+
+	LEAVE();
+
+	return 0;
+}
+
+/*
+ * This function handles the event generated by firmware, rx data
+ * received from firmware, and tx data sent from kernel.
+ */
+static int btm_service_main_thread(void *data)
+{
+	struct btm_thread *thread = data;
+	struct btm_private *priv = thread->priv;
+	struct btm_adapter *adapter = priv->adapter;
+	wait_queue_t wait;
+	struct sk_buff *skb;
+	ulong flags;
+
+	ENTER();
+
+	thread->pid = current->pid;
+
+	init_waitqueue_entry(&wait, current);
+
+	current->flags |= PF_NOFREEZE;
+
+	for (;;) {
+		add_wait_queue(&thread->wait_q, &wait);
+
+		set_current_state(TASK_INTERRUPTIBLE);
+
+		if (adapter->wakeup_tries ||
+		    ((!adapter->int_count) &&
+		     (!priv->btm_dev.tx_dnld_rdy ||
+		      skb_queue_empty(&adapter->tx_queue)))) {
+			PRINTM(INFO, "main_thread is sleeping...\n");
+			schedule();
+		}
+
+		set_current_state(TASK_RUNNING);
+
+		remove_wait_queue(&thread->wait_q, &wait);
+
+		PRINTM(INFO, "main_thread woke up\n");
+
+		if (kthread_should_stop()) {
+			PRINTM(INFO, "main_thread: break from main thread");
+			break;
+		}
+
+		spin_lock_irqsave(&priv->driver_lock, flags);
+		if (adapter->int_count) {
+			adapter->int_count = 0;
+		} else if ((adapter->ps_state == PS_SLEEP) &&
+			   !skb_queue_empty(&adapter->tx_queue)) {
+			spin_unlock_irqrestore(&priv->driver_lock, flags);
+			adapter->wakeup_tries++;
+			priv->hw_wakeup_firmware(priv);
+			continue;
+		}
+		spin_unlock_irqrestore(&priv->driver_lock, flags);
+
+		if (adapter->ps_state == PS_SLEEP)
+			continue;
+
+		if (!priv->btm_dev.tx_dnld_rdy)
+			continue;
+
+		skb = skb_dequeue(&adapter->tx_queue);
+		if (skb) {
+			if (btm_tx_pkt(priv, skb))
+				priv->btm_dev.hcidev->stat.err_tx++;
+			else
+				priv->btm_dev.hcidev->stat.byte_tx += skb->len;
+
+			kfree_skb(skb);
+		}
+	}
+
+	thread->pid = 0;
+
+	LEAVE();
+
+	return 0;
+}
+
+struct btm_private *btm_add_card(void *card)
+{
+	struct hci_dev *hdev = NULL;
+	struct btm_private *priv = NULL;
+	int ret;
+
+	ENTER();
+
+	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
+	if (!priv) {
+		PRINTM(FATAL, "Can not allocate priv\n");
+		goto err_priv;
+	}
+
+	priv->adapter = kzalloc(sizeof(*priv->adapter), GFP_KERNEL);
+	if (!priv->adapter) {
+		PRINTM(FATAL, "Allocate buffer for btm_adapter failed!\n");
+		goto err_adapter;
+	}
+
+	btm_init_adapter(priv);
+
+	hdev = hci_alloc_dev();
+	if (!hdev) {
+		PRINTM(FATAL, "Can not allocate HCI device\n");
+		goto err_hdev;
+	}
+
+	PRINTM(INFO, "Starting kthread...\n");
+	priv->main_thread.priv = priv;
+	spin_lock_init(&priv->driver_lock);
+
+	init_waitqueue_head(&priv->main_thread.wait_q);
+	priv->main_thread.task = kthread_run(btm_service_main_thread,
+		&priv->main_thread, "btm_main_service");
+
+	priv->btm_dev.hcidev = hdev;
+	priv->btm_dev.card = card;
+
+	hdev->driver_data = priv;
+
+	priv->btm_dev.tx_dnld_rdy = true;
+
+	hdev->type = HCI_SDIO;
+	hdev->open = btm_open;
+	hdev->close = btm_close;
+	hdev->flush = btm_flush;
+	hdev->send = btm_send_frame;
+	hdev->destruct = btm_destruct;
+	hdev->ioctl = btm_ioctl;
+	hdev->owner = THIS_MODULE;
+
+	ret = hci_register_dev(hdev);
+	if (ret < 0) {
+		PRINTM(FATAL, "Can not register HCI device\n");
+		goto err_hci_register_dev;
+	}
+
+	LEAVE();
+	return priv;
+
+err_hci_register_dev:
+	/* Stop the thread servicing the interrupts */
+	kthread_stop(priv->main_thread.task);
+
+	hci_free_dev(hdev);
+
+err_hdev:
+	btm_free_adapter(priv);
+
+err_adapter:
+	kfree(priv);
+
+err_priv:
+	LEAVE();
+
+	return NULL;
+}
+EXPORT_SYMBOL_GPL(btm_add_card);
+
+int btm_remove_card(struct btm_private *priv)
+{
+	struct hci_dev *hdev;
+
+	ENTER();
+
+	hdev = priv->btm_dev.hcidev;
+
+	wake_up_interruptible(&priv->adapter->cmd_wait_q);
+
+	kthread_stop(priv->main_thread.task);
+
+	hci_unregister_dev(hdev);
+
+	hci_free_dev(hdev);
+
+	priv->btm_dev.hcidev = NULL;
+
+	btm_free_adapter(priv);
+
+	kfree(priv);
+
+	LEAVE();
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(btm_remove_card);
+
+MODULE_AUTHOR("Marvell International Ltd.");
+MODULE_DESCRIPTION("Marvell Bluetooth Driver v" VERSION);
+MODULE_VERSION(VERSION);
+MODULE_LICENSE("GPL v2");
-- 
1.5.3.6

