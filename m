Return-Path: <cyrus@holtmann.org>
From: Ilya Faenson <ifaenson@broadcom.com>
To: Marcel Holtmann <marcel@holtmann.org>
CC: <linux-bluetooth@vger.kernel.org>, Ilya Faenson <ifaenson@broadcom.com>
Subject: [PATCH 2/5] Intel based H4 line discipline enhancements
Date: Wed, 3 Jun 2015 17:01:41 -0400
Message-ID: <1433365304-16707-3-git-send-email-ifaenson@broadcom.com>
In-Reply-To: <1433365304-16707-1-git-send-email-ifaenson@broadcom.com>
References: <1433365304-16707-1-git-send-email-ifaenson@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-bluetooth.vger.kernel.org>

This is largely enhancements implemented by Frederic Danis of Intel.
I've also added the ability to flow control the UART and improved the
UART baud rate setting some.

Signed-off-by: Ilya Faenson <ifaenson@broadcom.com>
---
 drivers/bluetooth/hci_ldisc.c | 110 ++++++++++++++++++++++++++++++++++++++++--
 drivers/bluetooth/hci_uart.h  |   6 +++
 2 files changed, 113 insertions(+), 3 deletions(-)

diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
index 5c9a73f..58dcb24 100644
--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -1,4 +1,4 @@
-/*
+/*_
  *
  *  Bluetooth HCI UART driver
  *
@@ -256,7 +256,8 @@ static int hci_uart_send_frame(struct hci_dev *hdev, struct sk_buff *skb)
 	if (!test_bit(HCI_RUNNING, &hdev->flags))
 		return -EBUSY;
 
-	BT_DBG("%s: type %d len %d", hdev->name, bt_cb(skb)->pkt_type, skb->len);
+	BT_DBG("%s: type %d len %d", hdev->name, bt_cb(skb)->pkt_type,
+	       skb->len);
 
 	hu->proto->enqueue(hu, skb);
 
@@ -265,11 +266,114 @@ static int hci_uart_send_frame(struct hci_dev *hdev, struct sk_buff *skb)
 	return 0;
 }
 
+void hci_uart_flow_control_device(struct hci_uart *hu)
+{
+	struct tty_struct *tty = hu->tty;
+	struct ktermios ktermios;
+	int status;
+	unsigned int set = 0;
+	unsigned int clear = 0;
+
+	/* Disable hardware flow control */
+	ktermios = tty->termios;
+	ktermios.c_cflag &= ~CRTSCTS;
+	status = tty_set_termios(tty, &ktermios);
+	if (status)
+		BT_DBG("%s dis fc failure %d", __func__, status);
+	else
+		BT_DBG("%s hw fc disabled", __func__);
+
+	/* Clear RTS to prevent the device from sending */
+	/* (most PCs need OUT2 to enable interrupts)    */
+	status = tty->driver->ops->tiocmget(tty);
+	BT_DBG("%s cur tiocm 0x%x", __func__, status);
+	set &= ~(TIOCM_OUT2 | TIOCM_RTS);
+	clear = ~set;
+	set &= TIOCM_DTR | TIOCM_RTS | TIOCM_OUT1 |
+		TIOCM_OUT2 | TIOCM_LOOP;
+	clear &= TIOCM_DTR | TIOCM_RTS | TIOCM_OUT1 |
+		TIOCM_OUT2 | TIOCM_LOOP;
+	status = tty->driver->ops->tiocmset(tty, set, clear);
+	if (status)
+		BT_DBG("%s clr RTS fail %d", __func__, status);
+	else
+		BT_DBG("%s RTS cleared", __func__);
+	status = tty->driver->ops->tiocmget(tty);
+}
+
+void hci_uart_unflow_control_device(struct hci_uart *hu)
+{
+	struct tty_struct *tty = hu->tty;
+	struct ktermios ktermios;
+	int status;
+	unsigned int set = 0;
+	unsigned int clear = 0;
+
+	status = tty->driver->ops->tiocmget(tty);
+	BT_DBG("%s cur tiocm 0x%x", __func__, status);
+	set |= (TIOCM_OUT2 | TIOCM_RTS);
+	clear = ~set;
+	set &= TIOCM_DTR | TIOCM_RTS | TIOCM_OUT1 |
+		TIOCM_OUT2 | TIOCM_LOOP;
+	clear &= TIOCM_DTR | TIOCM_RTS | TIOCM_OUT1 |
+		TIOCM_OUT2 | TIOCM_LOOP;
+	status = tty->driver->ops->tiocmset(tty, set, clear);
+	if (status)
+		BT_DBG("%s set RTS fail %d", __func__, status);
+	else
+		BT_DBG("%s RTS set", __func__);
+
+	/* Re-enable hardware flow control */
+	ktermios = tty->termios;
+	ktermios.c_cflag |= CRTSCTS;
+	status = tty_set_termios(tty, &ktermios);
+	if (status)
+		BT_DBG("%s enable fc fail %d", __func__, status);
+	else
+		BT_DBG("%s hw fc re-enabled", __func__);
+}
+
+void hci_uart_set_baudrate(struct hci_uart *hu, unsigned int speed)
+{
+	struct tty_struct *tty = hu->tty;
+	struct ktermios ktermios;
+
+	/* Bring the UART into a known state with a given baud rate */
+	ktermios = tty->termios;
+	ktermios.c_cflag &= ~CBAUD;
+	ktermios.c_iflag &= ~(IGNBRK | BRKINT | PARMRK | ISTRIP
+		| INLCR | IGNCR | ICRNL | IXON);
+	ktermios.c_oflag &= ~OPOST;
+	ktermios.c_lflag &= ~(ECHO | ECHONL | ICANON | ISIG | IEXTEN);
+	ktermios.c_cflag &= ~(CSIZE | PARENB | CBAUD);
+	ktermios.c_cflag |= CS8;
+	ktermios.c_cflag |= CRTSCTS;
+	/* ktermios.c_cflag |= BOTHER; */
+	tty_termios_encode_baud_rate(&ktermios, speed, speed);
+
+	/* tty_set_termios() return not checked as it is always 0 */
+	tty_set_termios(tty, &ktermios);
+
+	BT_DBG("%s: New tty speeds: %d/%d, cflag: 0x%x", hu->hdev->name,
+	       tty->termios.c_ispeed, tty->termios.c_ospeed,
+	       tty->termios.c_cflag);
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
@@ -647,7 +751,7 @@ static int __init hci_uart_init(void)
 
 	/* Register the tty discipline */
 
-	memset(&hci_uart_ldisc, 0, sizeof (hci_uart_ldisc));
+	memset(&hci_uart_ldisc, 0, sizeof(hci_uart_ldisc));
 	hci_uart_ldisc.magic		= TTY_LDISC_MAGIC;
 	hci_uart_ldisc.name		= "n_hci";
 	hci_uart_ldisc.open		= hci_uart_tty_open;
diff --git a/drivers/bluetooth/hci_uart.h b/drivers/bluetooth/hci_uart.h
index 72120a5..2271cc0 100644
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
@@ -96,6 +99,9 @@ int hci_uart_register_proto(const struct hci_uart_proto *p);
 int hci_uart_unregister_proto(const struct hci_uart_proto *p);
 int hci_uart_tx_wakeup(struct hci_uart *hu);
 int hci_uart_init_ready(struct hci_uart *hu);
+void hci_uart_set_baudrate(struct hci_uart *hu, unsigned int speed);
+void hci_uart_flow_control_device(struct hci_uart *hu);
+void hci_uart_unflow_control_device(struct hci_uart *hu);
 
 #ifdef CONFIG_BT_HCIUART_H4
 int h4_init(void);
-- 
1.9.1
