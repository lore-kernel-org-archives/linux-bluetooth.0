Return-Path: <cyrus@holtmann.org>
From: Frederic Danis <frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/7] Bluetooth: hci_uart: Support final speed during setup
Date: Fri, 10 Apr 2015 15:37:42 +0200
Message-Id: <1428673066-1349-3-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1428673066-1349-1-git-send-email-frederic.danis@linux.intel.com>
References: <1428673066-1349-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Change to full speed as soon as possible.
Vendor specific setup is splited into setup() and post_setup() functions
because setup() may have reseted Bluetooth controller speed to default
speed during firmware loading.
This implies to set UART speed back to default speed then set speed to
full speed again before calling post_setup().

Signed-off-by: Frederic Danis <frederic.danis@linux.intel.com>
---
 drivers/bluetooth/hci_ldisc.c | 48 +++++++++++++++++++++++++++++++++++++++++--
 drivers/bluetooth/hci_uart.h  |  2 ++
 2 files changed, 48 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
index 190a7f8..6e33a14 100644
--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -265,14 +265,58 @@ static int hci_uart_send_frame(struct hci_dev *hdev, struct sk_buff *skb)
 	return 0;
 }
 
+static void hci_uart_set_baudrate(struct hci_uart *hu, speed_t speed)
+{
+	struct tty_struct *tty = hu->tty;
+	struct ktermios ktermios;
+
+	ktermios = tty->termios;
+	ktermios.c_cflag &= ~CBAUD;
+	ktermios.c_cflag |= BOTHER;
+	tty_termios_encode_baud_rate(&ktermios, speed, speed);
+
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
+	speed_t init_speed = hu->tty->termios.c_ispeed;
+	int err;
+
+	if (hu->proto->set_baudrate && hu->speed) {
+		err = hu->proto->set_baudrate(hu, hu->speed);
+		if (err)
+			return err;
+		hci_uart_set_baudrate(hu, hu->speed);
+	}
+
+	if (hu->proto->setup) {
+		err = hu->proto->setup(hu);
+		/* If there is no firmware (-ENOENT), discard the error and
+		 * continue */
+		if (err == -ENOENT)
+			return 0;
+
+		if (hu->proto->set_baudrate && hu->speed) {
+			/* Controller speed has been reset to default speed */
+			hci_uart_set_baudrate(hu, init_speed);
+
+			err = hu->proto->set_baudrate(hu, hu->speed);
+			if (err)
+				return err;
+			hci_uart_set_baudrate(hu, hu->speed);
+		}
+
+		if (hu->proto->post_setup)
+			err = hu->proto->post_setup(hu);
 
-	if (hu->proto->setup)
-		return hu->proto->setup(hu);
+		return err;
+	}
 
 	if (!test_bit(HCI_UART_VND_DETECT, &hu->hdev_flags))
 		return 0;
diff --git a/drivers/bluetooth/hci_uart.h b/drivers/bluetooth/hci_uart.h
index 09a47b4..18050e0 100644
--- a/drivers/bluetooth/hci_uart.h
+++ b/drivers/bluetooth/hci_uart.h
@@ -63,6 +63,8 @@ struct hci_uart_proto {
 	int (*close)(struct hci_uart *hu);
 	int (*flush)(struct hci_uart *hu);
 	int (*setup)(struct hci_uart *hu);
+	int (*post_setup)(struct hci_uart *hu);
+	int (*set_baudrate)(struct hci_uart *hu, int speed);
 	int (*recv)(struct hci_uart *hu, const void *data, int len);
 	int (*enqueue)(struct hci_uart *hu, struct sk_buff *skb);
 	struct sk_buff *(*dequeue)(struct hci_uart *hu);
-- 
1.9.1

