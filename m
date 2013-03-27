Return-Path: <cyrus@holtmann.org>
From: Chan-yeol Park <chanyeol.park@samsung.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 3/3] Bluetooth: Remove trivial white space
Date: Thu, 28 Mar 2013 01:55:00 +0900
Message-id: <1364403300-11220-3-git-send-email-chanyeol.park@samsung.com>
In-reply-to: <1364403300-11220-1-git-send-email-chanyeol.park@samsung.com>
References: <1364401575-9868-1-git-send-email-chanyeol.park@samsung.com>
 <1364403300-11220-1-git-send-email-chanyeol.park@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 drivers/bluetooth/hci_ldisc.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
index d710d8b..69fa0d2 100644
--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -260,12 +260,12 @@ static int hci_uart_send_frame(struct sk_buff *skb)
 
 /* ------ LDISC part ------ */
 /* hci_uart_tty_open
- * 
+ *
  *     Called when line discipline changed to HCI_UART.
  *
  * Arguments:
  *     tty    pointer to tty info structure
- * Return Value:    
+ * Return Value:
  *     0 if success, otherwise error code
  */
 static int hci_uart_tty_open(struct tty_struct *tty)
-- 
1.7.10.4

