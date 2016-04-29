Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Amitkumar Karwar <akarwar@marvell.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, Ganapathi Bhat <gbhat@marvell.com>,
	Amitkumar Karwar <akarwar@marvell.com>
Subject: [PATCH v9 1/3] Bluetooth: hci_uart: add prepare callback
Date: Fri, 29 Apr 2016 03:24:36 -0700
Message-ID: <1461925478-31851-1-git-send-email-akarwar@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Ganapathi Bhat <gbhat@marvell.com>

This new uart protocol callback is used to prepare the device before
HCI becomes ready. One can use this to download firmware if the
download process doesn't use HCI commands.

Signed-off-by: Ganapathi Bhat <gbhat@marvell.com>
Signed-off-by: Amitkumar Karwar <akarwar@marvell.com>
---
 drivers/bluetooth/hci_ldisc.c | 6 ++++++
 drivers/bluetooth/hci_uart.h  | 1 +
 2 files changed, 7 insertions(+)

diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
index 49b3e1e..075a82d 100644
--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -641,6 +641,12 @@ static int hci_uart_set_proto(struct hci_uart *hu, int id)
 	hu->proto = p;
 	set_bit(HCI_UART_PROTO_READY, &hu->flags);
 
+	if (p->prepare) {
+		err = p->prepare(hu);
+		if (err)
+			return err;
+	}
+
 	err = hci_uart_register_dev(hu);
 	if (err) {
 		clear_bit(HCI_UART_PROTO_READY, &hu->flags);
diff --git a/drivers/bluetooth/hci_uart.h b/drivers/bluetooth/hci_uart.h
index 839bad1..ad4d66b 100644
--- a/drivers/bluetooth/hci_uart.h
+++ b/drivers/bluetooth/hci_uart.h
@@ -67,6 +67,7 @@ struct hci_uart_proto {
 	int (*close)(struct hci_uart *hu);
 	int (*flush)(struct hci_uart *hu);
 	int (*setup)(struct hci_uart *hu);
+	int (*prepare)(struct hci_uart *hu);
 	int (*set_baudrate)(struct hci_uart *hu, unsigned int speed);
 	int (*recv)(struct hci_uart *hu, const void *data, int len);
 	int (*enqueue)(struct hci_uart *hu, struct sk_buff *skb);
-- 
1.8.1.4
