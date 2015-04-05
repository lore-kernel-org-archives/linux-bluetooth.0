Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] Bluetooth: hci_uart: Add name information to hci_uart_proto struct
Date: Sat,  4 Apr 2015 22:27:34 -0700
Message-Id: <1428211655-15217-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This adds an extra name field to the hci_uart_proto struct that provides
a simple way of adding a string identifier to the protocol.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 drivers/bluetooth/hci_ath.c  | 15 ++++++++-------
 drivers/bluetooth/hci_bcsp.c |  1 +
 drivers/bluetooth/hci_h4.c   |  1 +
 drivers/bluetooth/hci_h5.c   |  1 +
 drivers/bluetooth/hci_ll.c   |  1 +
 drivers/bluetooth/hci_uart.h |  1 +
 6 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/bluetooth/hci_ath.c b/drivers/bluetooth/hci_ath.c
index c1c0b0c7e1c9..32c46cd40d85 100644
--- a/drivers/bluetooth/hci_ath.c
+++ b/drivers/bluetooth/hci_ath.c
@@ -206,13 +206,14 @@ static int ath_recv(struct hci_uart *hu, const void *data, int count)
 }
 
 static const struct hci_uart_proto athp = {
-	.id = HCI_UART_ATH3K,
-	.open = ath_open,
-	.close = ath_close,
-	.recv = ath_recv,
-	.enqueue = ath_enqueue,
-	.dequeue = ath_dequeue,
-	.flush = ath_flush,
+	.id		= HCI_UART_ATH3K,
+	.name		= "ATH3K",
+	.open		= ath_open,
+	.close		= ath_close,
+	.recv		= ath_recv,
+	.enqueue	= ath_enqueue,
+	.dequeue	= ath_dequeue,
+	.flush		= ath_flush,
 };
 
 int __init ath_init(void)
diff --git a/drivers/bluetooth/hci_bcsp.c b/drivers/bluetooth/hci_bcsp.c
index 7d30e05a973f..285fd0a97311 100644
--- a/drivers/bluetooth/hci_bcsp.c
+++ b/drivers/bluetooth/hci_bcsp.c
@@ -737,6 +737,7 @@ static int bcsp_close(struct hci_uart *hu)
 
 static const struct hci_uart_proto bcsp = {
 	.id		= HCI_UART_BCSP,
+	.name		= "BCSP",
 	.open		= bcsp_open,
 	.close		= bcsp_close,
 	.enqueue	= bcsp_enqueue,
diff --git a/drivers/bluetooth/hci_h4.c b/drivers/bluetooth/hci_h4.c
index fc783103ee36..7c5e68cb9959 100644
--- a/drivers/bluetooth/hci_h4.c
+++ b/drivers/bluetooth/hci_h4.c
@@ -141,6 +141,7 @@ static struct sk_buff *h4_dequeue(struct hci_uart *hu)
 
 static const struct hci_uart_proto h4p = {
 	.id		= HCI_UART_H4,
+	.name		= "H4",
 	.open		= h4_open,
 	.close		= h4_close,
 	.recv		= h4_recv,
diff --git a/drivers/bluetooth/hci_h5.c b/drivers/bluetooth/hci_h5.c
index aac0e8f718b0..de7da17ccdab 100644
--- a/drivers/bluetooth/hci_h5.c
+++ b/drivers/bluetooth/hci_h5.c
@@ -745,6 +745,7 @@ static int h5_flush(struct hci_uart *hu)
 
 static const struct hci_uart_proto h5p = {
 	.id		= HCI_UART_3WIRE,
+	.name		= "Three-wire (H5)",
 	.open		= h5_open,
 	.close		= h5_close,
 	.recv		= h5_recv,
diff --git a/drivers/bluetooth/hci_ll.c b/drivers/bluetooth/hci_ll.c
index e66f0fa65485..c6a1aeb4e7fb 100644
--- a/drivers/bluetooth/hci_ll.c
+++ b/drivers/bluetooth/hci_ll.c
@@ -507,6 +507,7 @@ static struct sk_buff *ll_dequeue(struct hci_uart *hu)
 
 static const struct hci_uart_proto llp = {
 	.id		= HCI_UART_LL,
+	.name		= "LL",
 	.open		= ll_open,
 	.close		= ll_close,
 	.recv		= ll_recv,
diff --git a/drivers/bluetooth/hci_uart.h b/drivers/bluetooth/hci_uart.h
index 683153d2e9db..80e694a36143 100644
--- a/drivers/bluetooth/hci_uart.h
+++ b/drivers/bluetooth/hci_uart.h
@@ -57,6 +57,7 @@ struct hci_uart;
 
 struct hci_uart_proto {
 	unsigned int id;
+	const char *name;
 	int (*open)(struct hci_uart *hu);
 	int (*close)(struct hci_uart *hu);
 	int (*flush)(struct hci_uart *hu);
-- 
2.1.0

