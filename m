Return-Path: <cyrus@holtmann.org>
From: Ilya Faenson <ifaenson@broadcom.com>
To: Marcel Holtmann <marcel@holtmann.org>
CC: <linux-bluetooth@vger.kernel.org>,
	Ilya Faenson <ifaenson@broadcom.com>
Subject: [PATCH] BlueZ line discipline baud rate setting update
Date: Mon, 15 Jun 2015 12:50:07 -0400
Message-ID: <1434387007-3666-2-git-send-email-ifaenson@broadcom.com>
In-Reply-To: <1434387007-3666-1-git-send-email-ifaenson@broadcom.com>
References: <1434387007-3666-1-git-send-email-ifaenson@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Bring the tty into a known 8 bits, 1 start bit, 1 stop bit,
hardware flow control state with a given baud rate.

Signed-off-by: Ilya Faenson <ifaenson@broadcom.com>
---
 drivers/bluetooth/hci_ldisc.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
index ac87346..606cc5a 100644
--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -271,9 +271,16 @@ void hci_uart_set_baudrate(struct hci_uart *hu, unsigned int speed)
 	struct tty_struct *tty = hu->tty;
 	struct ktermios ktermios;
 
+	/* Bring the UART into a known state with a given baud rate */
 	ktermios = tty->termios;
 	ktermios.c_cflag &= ~CBAUD;
-	ktermios.c_cflag |= BOTHER;
+	ktermios.c_iflag &= ~(IGNBRK | BRKINT | PARMRK | ISTRIP | INLCR |
+			    IGNCR | ICRNL | IXON);
+	ktermios.c_oflag &= ~OPOST;
+	ktermios.c_lflag &= ~(ECHO | ECHONL | ICANON | ISIG | IEXTEN);
+	ktermios.c_cflag &= ~(CSIZE | PARENB | CBAUD);
+	ktermios.c_cflag |= CS8;
+	ktermios.c_cflag |= CRTSCTS;
 	tty_termios_encode_baud_rate(&ktermios, speed, speed);
 
 	/* tty_set_termios() return not checked as it is always 0 */
-- 
1.9.1

