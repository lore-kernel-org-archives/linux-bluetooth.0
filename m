Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: hci_uart: Make struct hci_uart_proto always const
Date: Sat,  4 Apr 2015 22:11:43 -0700
Message-Id: <1428210703-2808-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The usage of struct hci_uart_proto should always be const. Change the
function headers and individual protocol drivers.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 drivers/bluetooth/hci_ath.c   |  2 +-
 drivers/bluetooth/hci_bcsp.c  |  2 +-
 drivers/bluetooth/hci_h4.c    |  2 +-
 drivers/bluetooth/hci_h5.c    |  2 +-
 drivers/bluetooth/hci_ldisc.c | 10 +++++-----
 drivers/bluetooth/hci_ll.c    |  2 +-
 drivers/bluetooth/hci_uart.h  |  6 +++---
 7 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/bluetooth/hci_ath.c b/drivers/bluetooth/hci_ath.c
index 15beb974f3a0..c1c0b0c7e1c9 100644
--- a/drivers/bluetooth/hci_ath.c
+++ b/drivers/bluetooth/hci_ath.c
@@ -205,7 +205,7 @@ static int ath_recv(struct hci_uart *hu, const void *data, int count)
 	return count;
 }
 
-static struct hci_uart_proto athp = {
+static const struct hci_uart_proto athp = {
 	.id = HCI_UART_ATH3K,
 	.open = ath_open,
 	.close = ath_close,
diff --git a/drivers/bluetooth/hci_bcsp.c b/drivers/bluetooth/hci_bcsp.c
index 50ef2e613d59..7d30e05a973f 100644
--- a/drivers/bluetooth/hci_bcsp.c
+++ b/drivers/bluetooth/hci_bcsp.c
@@ -735,7 +735,7 @@ static int bcsp_close(struct hci_uart *hu)
 	return 0;
 }
 
-static struct hci_uart_proto bcsp = {
+static const struct hci_uart_proto bcsp = {
 	.id		= HCI_UART_BCSP,
 	.open		= bcsp_open,
 	.close		= bcsp_close,
diff --git a/drivers/bluetooth/hci_h4.c b/drivers/bluetooth/hci_h4.c
index d8414540f743..fc783103ee36 100644
--- a/drivers/bluetooth/hci_h4.c
+++ b/drivers/bluetooth/hci_h4.c
@@ -139,7 +139,7 @@ static struct sk_buff *h4_dequeue(struct hci_uart *hu)
 	return skb_dequeue(&h4->txq);
 }
 
-static struct hci_uart_proto h4p = {
+static const struct hci_uart_proto h4p = {
 	.id		= HCI_UART_H4,
 	.open		= h4_open,
 	.close		= h4_close,
diff --git a/drivers/bluetooth/hci_h5.c b/drivers/bluetooth/hci_h5.c
index 0f681cc1af64..aac0e8f718b0 100644
--- a/drivers/bluetooth/hci_h5.c
+++ b/drivers/bluetooth/hci_h5.c
@@ -743,7 +743,7 @@ static int h5_flush(struct hci_uart *hu)
 	return 0;
 }
 
-static struct hci_uart_proto h5p = {
+static const struct hci_uart_proto h5p = {
 	.id		= HCI_UART_3WIRE,
 	.open		= h5_open,
 	.close		= h5_close,
diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
index 50dbaf3579ed..ba3b988ce60a 100644
--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -48,9 +48,9 @@
 
 #define VERSION "2.2"
 
-static struct hci_uart_proto *hup[HCI_UART_MAX_PROTO];
+static const struct hci_uart_proto *hup[HCI_UART_MAX_PROTO];
 
-int hci_uart_register_proto(struct hci_uart_proto *p)
+int hci_uart_register_proto(const struct hci_uart_proto *p)
 {
 	if (p->id >= HCI_UART_MAX_PROTO)
 		return -EINVAL;
@@ -63,7 +63,7 @@ int hci_uart_register_proto(struct hci_uart_proto *p)
 	return 0;
 }
 
-int hci_uart_unregister_proto(struct hci_uart_proto *p)
+int hci_uart_unregister_proto(const struct hci_uart_proto *p)
 {
 	if (p->id >= HCI_UART_MAX_PROTO)
 		return -EINVAL;
@@ -76,7 +76,7 @@ int hci_uart_unregister_proto(struct hci_uart_proto *p)
 	return 0;
 }
 
-static struct hci_uart_proto *hci_uart_get_proto(unsigned int id)
+static const struct hci_uart_proto *hci_uart_get_proto(unsigned int id)
 {
 	if (id >= HCI_UART_MAX_PROTO)
 		return NULL;
@@ -506,7 +506,7 @@ static int hci_uart_register_dev(struct hci_uart *hu)
 
 static int hci_uart_set_proto(struct hci_uart *hu, int id)
 {
-	struct hci_uart_proto *p;
+	const struct hci_uart_proto *p;
 	int err;
 
 	p = hci_uart_get_proto(id);
diff --git a/drivers/bluetooth/hci_ll.c b/drivers/bluetooth/hci_ll.c
index 79eea1cbd988..e66f0fa65485 100644
--- a/drivers/bluetooth/hci_ll.c
+++ b/drivers/bluetooth/hci_ll.c
@@ -505,7 +505,7 @@ static struct sk_buff *ll_dequeue(struct hci_uart *hu)
 	return skb_dequeue(&ll->txq);
 }
 
-static struct hci_uart_proto llp = {
+static const struct hci_uart_proto llp = {
 	.id		= HCI_UART_LL,
 	.open		= ll_open,
 	.close		= ll_close,
diff --git a/drivers/bluetooth/hci_uart.h b/drivers/bluetooth/hci_uart.h
index 53b329229f2e..683153d2e9db 100644
--- a/drivers/bluetooth/hci_uart.h
+++ b/drivers/bluetooth/hci_uart.h
@@ -75,7 +75,7 @@ struct hci_uart {
 	struct work_struct	init_ready;
 	struct work_struct	write_work;
 
-	struct hci_uart_proto	*proto;
+	const struct hci_uart_proto *proto;
 	void			*priv;
 
 	struct sk_buff		*tx_skb;
@@ -91,8 +91,8 @@ struct hci_uart {
 #define HCI_UART_SENDING	1
 #define HCI_UART_TX_WAKEUP	2
 
-int hci_uart_register_proto(struct hci_uart_proto *p);
-int hci_uart_unregister_proto(struct hci_uart_proto *p);
+int hci_uart_register_proto(const struct hci_uart_proto *p);
+int hci_uart_unregister_proto(const struct hci_uart_proto *p);
 int hci_uart_tx_wakeup(struct hci_uart *hu);
 int hci_uart_init_ready(struct hci_uart *hu);
 
-- 
2.1.0

