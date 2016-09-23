Return-Path: <Dean_Jenkins@mentor.com>
From: Dean Jenkins <Dean_Jenkins@mentor.com>
To: Dean Jenkins <Dean_Jenkins@mentor.com>, Marcel Holtmann
	<marcel@holtmann.org>, Gustavo Padovan <gustavo@padovan.org>, Johan Hedberg
	<johan.hedberg@gmail.com>
CC: <linux-bluetooth@vger.kernel.org>
Subject: [PATCH V2 4/7] Bluetooth: Add mutex to hci_uart_tty_ioctl()
Date: Fri, 23 Sep 2016 18:56:29 +0100
Message-ID: <1474653392-28770-5-git-send-email-Dean_Jenkins@mentor.com>
In-Reply-To: <1474653392-28770-1-git-send-email-Dean_Jenkins@mentor.com>
References: <1474653392-28770-1-git-send-email-Dean_Jenkins@mentor.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-bluetooth.vger.kernel.org>

Add global mutex lock to prevent reentrancy in the hci_uart_tty_ioctl()
ioctl handling. This prevents concurrency of all function calls within
hci_uart_tty_ioctl() handling including hci_uart_set_proto().

Signed-off-by: Vignesh Raman <Vignesh_Raman@mentor.com>
Signed-off-by: Dean Jenkins <Dean_Jenkins@mentor.com>
---
 drivers/bluetooth/hci_ldisc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
index 9497c46..01590f6 100644
--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -51,6 +51,8 @@
 
 #define VERSION "2.3"
 
+static DEFINE_MUTEX(ioctl_mutex);
+
 static const struct hci_uart_proto *hup[HCI_UART_MAX_PROTO];
 
 int hci_uart_register_proto(const struct hci_uart_proto *p)
@@ -693,6 +695,7 @@ static int hci_uart_tty_ioctl(struct tty_struct *tty, struct file *file,
 	if (!hu)
 		return -EBADF;
 
+	mutex_lock(&ioctl_mutex);
 	switch (cmd) {
 	case HCIUARTSETPROTO:
 		if (!test_and_set_bit(HCI_UART_PROTO_SET, &hu->flags)) {
@@ -732,6 +735,7 @@ static int hci_uart_tty_ioctl(struct tty_struct *tty, struct file *file,
 		err = n_tty_ioctl_helper(tty, file, cmd, arg);
 		break;
 	}
+	mutex_unlock(&ioctl_mutex);
 
 	return err;
 }
-- 
2.7.4
