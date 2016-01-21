Return-Path: <jjmeijer88@gmail.com>
From: "J.J. Meijer" <jjmeijer88@gmail.com>
To: marcel@holtmann.org
Cc: linux-bluetooth@vger.kernel.org,
	meijjaa <jjmeijer88@gmail.com>
Subject: [PATCH] Fix failing ioctl set flags from x86 user space to x64 kernel
Date: Thu, 21 Jan 2016 22:38:38 +0100
Message-Id: <1453412318-31325-1-git-send-email-jjmeijer88@gmail.com>
In-Reply-To: <[BUG] Btattach, ioctl fails to set flags from 32-bit user space to 64-bit>
References: <[BUG] Btattach, ioctl fails to set flags from 32-bit user space to 64-bit>
List-ID: <linux-bluetooth.vger.kernel.org>

From: meijjaa <jjmeijer88@gmail.com>

Signed-off-by: meijjaa <jjmeijer88@gmail.com>
---
 drivers/bluetooth/hci_ldisc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
index 96bcec5..c0eeda0 100644
--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -774,6 +774,7 @@ static int __init hci_uart_init(void)
 	hci_uart_ldisc.read		= hci_uart_tty_read;
 	hci_uart_ldisc.write		= hci_uart_tty_write;
 	hci_uart_ldisc.ioctl		= hci_uart_tty_ioctl;
+	hci_uart_ldisc.compat_ioctl	= hci_uart_tty_ioctl;
 	hci_uart_ldisc.poll		= hci_uart_tty_poll;
 	hci_uart_ldisc.receive_buf	= hci_uart_tty_receive;
 	hci_uart_ldisc.write_wakeup	= hci_uart_tty_wakeup;
-- 
2.7.0
