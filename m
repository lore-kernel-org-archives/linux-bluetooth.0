Return-Path: <cyrus@holtmann.org>
From: Frederic Danis <frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v6 2/5] Bluetooth: hci_uart: Support operational speed during setup
Date: Wed, 20 May 2015 17:46:07 +0200
Message-Id: <1432136770-13328-3-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1432136770-13328-1-git-send-email-frederic.danis@linux.intel.com>
References: <1432136770-13328-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add initial and operational speeds.
Change to operational speed as soon as possible. If controller
set_baudrate() fails, continue at initial speed.

Signed-off-by: Frederic Danis <frederic.danis@linux.intel.com>
---
 drivers/bluetooth/hci_ldisc.c | 26 ++++++++++++++++++++++++++
 drivers/bluetooth/hci_uart.h  |  4 ++++
 2 files changed, 30 insertions(+)

diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
index 5c9a73f..a39e1ab 100644
--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -265,11 +265,37 @@ static int hci_uart_send_frame(struct hci_dev *hdev, struct sk_buff *skb)
 	return 0;
 }
 
+void hci_uart_set_baudrate(struct hci_uart *hu, unsigned int speed)
+{
+	struct tty_struct *tty = hu->tty;
+	struct ktermios ktermios;
+
+	ktermios = tty->termios;
+	ktermios.c_cflag &= ~CBAUD;
+	ktermios.c_cflag |= BOTHER;
+	tty_termios_encode_baud_rate(&ktermios, speed, speed);
+
+	/* tty_set_termios() return not checked as it is always 0 */
+	tty_set_termios(tty, &ktermios);
+
+	BT_DBG("%s: New tty speed: %d", hu->hdev->name, tty->termios.c_ispeed);
+}
+
 static int hci_uart_setup(struct hci_dev *hdev)
 {
 	struct hci_uart *hu = hci_get_drvdata(hdev);
 	struct hci_rp_read_local_version *ver;
 	struct sk_buff *skb;
+	int err;
+
+	if (hu->proto->init_speed)
+		hci_uart_set_baudrate(hu, hu->proto->init_speed);
+
+	if (hu->proto->set_baudrate && hu->proto->oper_speed) {
+		err = hu->proto->set_baudrate(hu, hu->proto->oper_speed);
+		if (!err)
+			hci_uart_set_baudrate(hu, hu->proto->oper_speed);
+	}
 
 	if (hu->proto->setup)
 		return hu->proto->setup(hu);
diff --git a/drivers/bluetooth/hci_uart.h b/drivers/bluetooth/hci_uart.h
index 72120a5..e9f970c 100644
--- a/drivers/bluetooth/hci_uart.h
+++ b/drivers/bluetooth/hci_uart.h
@@ -58,10 +58,13 @@ struct hci_uart;
 struct hci_uart_proto {
 	unsigned int id;
 	const char *name;
+	unsigned int init_speed;
+	unsigned int oper_speed;
 	int (*open)(struct hci_uart *hu);
 	int (*close)(struct hci_uart *hu);
 	int (*flush)(struct hci_uart *hu);
 	int (*setup)(struct hci_uart *hu);
+	int (*set_baudrate)(struct hci_uart *hu, unsigned int speed);
 	int (*recv)(struct hci_uart *hu, const void *data, int len);
 	int (*enqueue)(struct hci_uart *hu, struct sk_buff *skb);
 	struct sk_buff *(*dequeue)(struct hci_uart *hu);
@@ -96,6 +99,7 @@ int hci_uart_register_proto(const struct hci_uart_proto *p);
 int hci_uart_unregister_proto(const struct hci_uart_proto *p);
 int hci_uart_tx_wakeup(struct hci_uart *hu);
 int hci_uart_init_ready(struct hci_uart *hu);
+void hci_uart_set_baudrate(struct hci_uart *hu, unsigned int speed);
 
 #ifdef CONFIG_BT_HCIUART_H4
 int h4_init(void);
-- 
1.9.1

