Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 2/2] Bluetooth: hci_uart: Use const data pointer for received data
Date: Sat,  4 Apr 2015 20:59:41 -0700
Message-Id: <1428206381-6111-2-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The TTY layer provides its data pointers as const, but the HCI UART
callbacks expect them as general data pointers. This is of course
wrong and instead of casting them, just fix the individual drivers
to actually take a const data pointer.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 drivers/bluetooth/hci_ath.c   | 2 +-
 drivers/bluetooth/hci_bcsp.c  | 4 ++--
 drivers/bluetooth/hci_h4.c    | 2 +-
 drivers/bluetooth/hci_h5.c    | 4 ++--
 drivers/bluetooth/hci_ldisc.c | 2 +-
 drivers/bluetooth/hci_ll.c    | 4 ++--
 drivers/bluetooth/hci_uart.h  | 2 +-
 7 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/bluetooth/hci_ath.c b/drivers/bluetooth/hci_ath.c
index 9c4dcf4c62ea..4e89d3e33b7b 100644
--- a/drivers/bluetooth/hci_ath.c
+++ b/drivers/bluetooth/hci_ath.c
@@ -188,7 +188,7 @@ static struct sk_buff *ath_dequeue(struct hci_uart *hu)
 }
 
 /* Recv data */
-static int ath_recv(struct hci_uart *hu, void *data, int count)
+static int ath_recv(struct hci_uart *hu, const void *data, int count)
 {
 	int ret;
 
diff --git a/drivers/bluetooth/hci_bcsp.c b/drivers/bluetooth/hci_bcsp.c
index 21cc45b34f13..50ef2e613d59 100644
--- a/drivers/bluetooth/hci_bcsp.c
+++ b/drivers/bluetooth/hci_bcsp.c
@@ -554,10 +554,10 @@ static u16 bscp_get_crc(struct bcsp_struct *bcsp)
 }
 
 /* Recv data */
-static int bcsp_recv(struct hci_uart *hu, void *data, int count)
+static int bcsp_recv(struct hci_uart *hu, const void *data, int count)
 {
 	struct bcsp_struct *bcsp = hu->priv;
-	unsigned char *ptr;
+	const unsigned char *ptr;
 
 	BT_DBG("hu %p count %d rx_state %d rx_count %ld", 
 		hu, count, bcsp->rx_state, bcsp->rx_count);
diff --git a/drivers/bluetooth/hci_h4.c b/drivers/bluetooth/hci_h4.c
index 0d9ba07d2730..97a5df4941b4 100644
--- a/drivers/bluetooth/hci_h4.c
+++ b/drivers/bluetooth/hci_h4.c
@@ -113,7 +113,7 @@ static int h4_enqueue(struct hci_uart *hu, struct sk_buff *skb)
 }
 
 /* Recv data */
-static int h4_recv(struct hci_uart *hu, void *data, int count)
+static int h4_recv(struct hci_uart *hu, const void *data, int count)
 {
 	int ret;
 
diff --git a/drivers/bluetooth/hci_h5.c b/drivers/bluetooth/hci_h5.c
index ec0fa7732c0d..0f681cc1af64 100644
--- a/drivers/bluetooth/hci_h5.c
+++ b/drivers/bluetooth/hci_h5.c
@@ -511,10 +511,10 @@ static void h5_reset_rx(struct h5 *h5)
 	clear_bit(H5_RX_ESC, &h5->flags);
 }
 
-static int h5_recv(struct hci_uart *hu, void *data, int count)
+static int h5_recv(struct hci_uart *hu, const void *data, int count)
 {
 	struct h5 *h5 = hu->priv;
-	unsigned char *ptr = data;
+	const unsigned char *ptr = data;
 
 	BT_DBG("%s pending %zu count %d", hu->hdev->name, h5->rx_pending,
 	       count);
diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
index a3b906bcfca6..50dbaf3579ed 100644
--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -441,7 +441,7 @@ static void hci_uart_tty_receive(struct tty_struct *tty, const u8 *data,
 		return;
 
 	spin_lock(&hu->rx_lock);
-	hu->proto->recv(hu, (void *) data, count);
+	hu->proto->recv(hu, data, count);
 
 	if (hu->hdev)
 		hu->hdev->stat.byte_rx += count;
diff --git a/drivers/bluetooth/hci_ll.c b/drivers/bluetooth/hci_ll.c
index 69a90b1b5ff5..79eea1cbd988 100644
--- a/drivers/bluetooth/hci_ll.c
+++ b/drivers/bluetooth/hci_ll.c
@@ -370,10 +370,10 @@ static inline int ll_check_data_len(struct hci_dev *hdev, struct ll_struct *ll,
 }
 
 /* Recv data */
-static int ll_recv(struct hci_uart *hu, void *data, int count)
+static int ll_recv(struct hci_uart *hu, const void *data, int count)
 {
 	struct ll_struct *ll = hu->priv;
-	char *ptr;
+	const char *ptr;
 	struct hci_event_hdr *eh;
 	struct hci_acl_hdr   *ah;
 	struct hci_sco_hdr   *sh;
diff --git a/drivers/bluetooth/hci_uart.h b/drivers/bluetooth/hci_uart.h
index 4dc8ab3009a9..79bbcefb0112 100644
--- a/drivers/bluetooth/hci_uart.h
+++ b/drivers/bluetooth/hci_uart.h
@@ -60,7 +60,7 @@ struct hci_uart_proto {
 	int (*open)(struct hci_uart *hu);
 	int (*close)(struct hci_uart *hu);
 	int (*flush)(struct hci_uart *hu);
-	int (*recv)(struct hci_uart *hu, void *data, int len);
+	int (*recv)(struct hci_uart *hu, const void *data, int len);
 	int (*enqueue)(struct hci_uart *hu, struct sk_buff *skb);
 	int (*setup)(struct hci_uart *hu);
 	struct sk_buff *(*dequeue)(struct hci_uart *hu);
-- 
2.1.0

