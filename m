Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: hci_uart: Provide initial manufacturer information
Date: Tue, 20 Oct 2015 21:30:45 +0200
Message-Id: <1445369445-83359-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Provide an early indication about the manufacturer information so that
it can be forwarded into monitor channel.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 drivers/bluetooth/hci_ath.c   | 1 +
 drivers/bluetooth/hci_bcm.c   | 1 +
 drivers/bluetooth/hci_intel.c | 1 +
 drivers/bluetooth/hci_ldisc.c | 7 +++++++
 drivers/bluetooth/hci_qca.c   | 1 +
 drivers/bluetooth/hci_uart.h  | 1 +
 6 files changed, 12 insertions(+)

diff --git a/drivers/bluetooth/hci_ath.c b/drivers/bluetooth/hci_ath.c
index 6da5e4ca13ea..d776dfd51478 100644
--- a/drivers/bluetooth/hci_ath.c
+++ b/drivers/bluetooth/hci_ath.c
@@ -243,6 +243,7 @@ static struct sk_buff *ath_dequeue(struct hci_uart *hu)
 static const struct hci_uart_proto athp = {
 	.id		= HCI_UART_ATH3K,
 	.name		= "ATH3K",
+	.manufacturer	= 69,
 	.open		= ath_open,
 	.close		= ath_close,
 	.flush		= ath_flush,
diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index 645e66e9a945..1aa88dbd6fec 100644
--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -799,6 +799,7 @@ static int bcm_remove(struct platform_device *pdev)
 static const struct hci_uart_proto bcm_proto = {
 	.id		= HCI_UART_BCM,
 	.name		= "BCM",
+	.manufacturer	= 15,
 	.init_speed	= 115200,
 	.oper_speed	= 4000000,
 	.open		= bcm_open,
diff --git a/drivers/bluetooth/hci_intel.c b/drivers/bluetooth/hci_intel.c
index c5e69e08788a..4a414a5a3165 100644
--- a/drivers/bluetooth/hci_intel.c
+++ b/drivers/bluetooth/hci_intel.c
@@ -1148,6 +1148,7 @@ static struct sk_buff *intel_dequeue(struct hci_uart *hu)
 static const struct hci_uart_proto intel_proto = {
 	.id		= HCI_UART_INTEL,
 	.name		= "Intel",
+	.manufacturer	= 2,
 	.init_speed	= 115200,
 	.oper_speed	= 3000000,
 	.open		= intel_open,
diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
index 01a83a3f8a1d..96bcec5598c2 100644
--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -587,6 +587,13 @@ static int hci_uart_register_dev(struct hci_uart *hu)
 	hdev->bus = HCI_UART;
 	hci_set_drvdata(hdev, hu);
 
+	/* Only when vendor specific setup callback is provided, consider
+	 * the manufacturer information valid. This avoids filling in the
+	 * value for Ericsson when nothing is specified.
+	 */
+	if (hu->proto->setup)
+		hdev->manufacturer = hu->proto->manufacturer;
+
 	hdev->open  = hci_uart_open;
 	hdev->close = hci_uart_close;
 	hdev->flush = hci_uart_flush;
diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index b4a0393b2862..77eae64000b3 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -947,6 +947,7 @@ static int qca_setup(struct hci_uart *hu)
 static struct hci_uart_proto qca_proto = {
 	.id		= HCI_UART_QCA,
 	.name		= "QCA",
+	.manufacturer	= 29,
 	.init_speed	= 115200,
 	.oper_speed	= 3000000,
 	.open		= qca_open,
diff --git a/drivers/bluetooth/hci_uart.h b/drivers/bluetooth/hci_uart.h
index 2f7bb35a890e..82c92f1b65b4 100644
--- a/drivers/bluetooth/hci_uart.h
+++ b/drivers/bluetooth/hci_uart.h
@@ -59,6 +59,7 @@ struct hci_uart;
 struct hci_uart_proto {
 	unsigned int id;
 	const char *name;
+	unsigned int manufacturer;
 	unsigned int init_speed;
 	unsigned int oper_speed;
 	int (*open)(struct hci_uart *hu);
-- 
2.4.3

