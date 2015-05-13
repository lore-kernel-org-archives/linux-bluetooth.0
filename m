Return-Path: <cyrus@holtmann.org>
From: Ilya Faenson <ifaenson@broadcom.com>
To: Marcel Holtmann <marcel@holtmann.org>
CC: <linux-bluetooth@vger.kernel.org>,
	Ilya Faenson <ifaenson@broadcom.com>
Subject: [RFC v3 3/4] Broadcom Bluetooth protocol UART support
Date: Wed, 13 May 2015 17:50:22 -0400
Message-ID: <1431553823-25670-4-git-send-email-ifaenson@broadcom.com>
In-Reply-To: <1431553823-25670-1-git-send-email-ifaenson@broadcom.com>
References: <1431553823-25670-1-git-send-email-ifaenson@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Signed-off-by: Ilya Faenson <ifaenson@broadcom.com>
---
 drivers/bluetooth/btbcm.c | 155 ++++++++++++++++++++++++++++++++++++++++++++--
 drivers/bluetooth/btbcm.h |  13 ++++
 2 files changed, 163 insertions(+), 5 deletions(-)

diff --git a/drivers/bluetooth/btbcm.c b/drivers/bluetooth/btbcm.c
index 4bba866..8b5530d 100644
--- a/drivers/bluetooth/btbcm.c
+++ b/drivers/bluetooth/btbcm.c
@@ -3,6 +3,7 @@
  *  Bluetooth support for Broadcom devices
  *
  *  Copyright (C) 2015  Intel Corporation
+ *  Copyright (C) 2015  Broadcom Corporation
  *
  *
  *  This program is free software; you can redistribute it and/or modify
@@ -23,14 +24,16 @@
 
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
 
 #define BDADDR_BCM20702A0 (&(bdaddr_t) {{0x00, 0xa0, 0x02, 0x70, 0x20, 0x00}})
 
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
 
@@ -268,6 +273,127 @@ static const struct {
 	{ }
 };
 
+/*
+ * Set the UART into the defaults
+ */
+int btbcm_init_uart(struct hci_uart *hu)
+{
+	struct tty_struct *tty = hu->tty;
+	struct ktermios ktermios;
+	int err, speed;
+
+	/* Flush the line discipline buffers and the TTY buffers */
+	if (tty->ldisc->ops->flush_buffer)
+		tty->ldisc->ops->flush_buffer(tty);
+	tty_driver_flush_buffer(tty);
+
+
+	/* Init UART to default settings */
+	ktermios = tty->termios;
+	ktermios.c_iflag &= ~(IGNBRK | BRKINT | PARMRK | ISTRIP
+		| INLCR | IGNCR | ICRNL | IXON);
+	ktermios.c_oflag &= ~OPOST;
+	ktermios.c_lflag &= ~(ECHO | ECHONL | ICANON | ISIG | IEXTEN);
+	ktermios.c_cflag &= ~(CSIZE | PARENB | CBAUD);
+	ktermios.c_cflag |= CS8;
+	ktermios.c_cflag |= CRTSCTS;
+	ktermios.c_cflag |= B115200;
+	ktermios.c_ispeed = 115200;
+	ktermios.c_ospeed = 115200;
+	err = tty_set_termios(tty, &ktermios);
+	if (err) {
+		BT_DBG("init_uart set_termios failure %d", err);
+		return err;
+	}
+
+	speed = tty_get_baud_rate(tty);
+
+	BT_DBG("init_uart set_termios completed, spd %d", speed);
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
+	struct tty_struct *tty = hu->tty;
+	struct ktermios ktermios;
+	int status, speed, cflag;
+	struct sk_buff *skb;
+	u8 enable = 0x01;
+	u8 baud_rate_vsc_pars[] = {0, 0, 0, 0x10, 0x0e, 0};
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
+	put_unaligned_le32((u32)baud_rate, &baud_rate_vsc_pars[2]);
+	skb = __hci_cmd_sync(hu->hdev, 0xfc18, sizeof(baud_rate_vsc_pars),
+			     baud_rate_vsc_pars, HCI_INIT_TIMEOUT);
+	if (IS_ERR(skb)) {
+		status = PTR_ERR(skb);
+		BT_ERR("set_baud_rate VSC failed (%d)", status);
+		return status;
+	}
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
@@ -275,7 +401,8 @@ int btbcm_setup_patchram(struct hci_dev *hdev)
 	const char *hw_name = NULL;
 	struct sk_buff *skb;
 	struct hci_rp_read_local_version *ver;
-	int i, err;
+	int i, err, is_uart = false;
+	struct hci_uart *hu = hci_get_drvdata(hdev);
 
 	/* Reset */
 	err = btbcm_reset(hdev);
@@ -297,14 +424,18 @@ int btbcm_setup_patchram(struct hci_dev *hdev)
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
@@ -312,7 +443,7 @@ int btbcm_setup_patchram(struct hci_dev *hdev)
 		snprintf(fw_name, sizeof(fw_name), "brcm/%s.hcd",
 			 hw_name ? : "BCM");
 		break;
-	case 1:
+
 	case 2:
 		/* Read USB Product Info */
 		skb = btbcm_read_usb_product(hdev);
@@ -345,11 +476,25 @@ int btbcm_setup_patchram(struct hci_dev *hdev)
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
index eb6ab5f..77fa60a 100644
--- a/drivers/bluetooth/btbcm.h
+++ b/drivers/bluetooth/btbcm.h
@@ -3,6 +3,7 @@
  *  Bluetooth support for Broadcom devices
  *
  *  Copyright (C) 2015  Intel Corporation
+ *  Copyright (C) 2015  Broadcom Corporation
  *
  *
  *  This program is free software; you can redistribute it and/or modify
@@ -30,6 +31,8 @@ int btbcm_patchram(struct hci_dev *hdev, const char *firmware);
 int btbcm_setup_patchram(struct hci_dev *hdev);
 int btbcm_setup_apple(struct hci_dev *hdev);
 
+int btbcm_init_uart(struct hci_uart *hu);
+int btbcm_set_baud_rate(struct hci_uart *hu, int baud_rate);
 #else
 
 static inline int btbcm_check_bdaddr(struct hci_dev *hdev)
@@ -57,4 +60,14 @@ static inline int btbcm_setup_apple(struct hci_dev *hdev)
 	return 0;
 }
 
+static inline int btbcm_init_uart(void *hu)
+{
+	return 0;
+}
+
+static inline int btbcm_set_baud_rate(void *hu, int baud_rate);
+{
+	return 0;
+}
+
 #endif
-- 
1.9.1

