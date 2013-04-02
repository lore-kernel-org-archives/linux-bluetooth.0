Return-Path: <cyrus@holtmann.org>
From: Chan-yeol Park <chanyeol.park@samsung.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v4 3/3] Bluetooth: Remove trivial white space
Date: Tue, 02 Apr 2013 21:24:23 +0900
Message-id: <1364905463-1752-3-git-send-email-chanyeol.park@samsung.com>
In-reply-to: <1364905463-1752-1-git-send-email-chanyeol.park@samsung.com>
References: <1364905463-1752-1-git-send-email-chanyeol.park@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Signed-off-by: Chan-yeol Park <chanyeol.park@samsung.com>
---
 drivers/bluetooth/hci_ldisc.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
index d710d8b..bc68a44 100644
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
@@ -365,15 +365,15 @@ static void hci_uart_tty_wakeup(struct tty_struct *tty)
 }
 
 /* hci_uart_tty_receive()
- * 
+ *
  *     Called by tty low level driver when receive data is
  *     available.
- *     
+ *
  * Arguments:  tty          pointer to tty isntance data
  *             data         pointer to received data
  *             flags        pointer to flags for data
  *             count        count of received data in bytes
- *     
+ *
  * Return Value:    None
  */
 static void hci_uart_tty_receive(struct tty_struct *tty, const u8 *data, char *flags, int count)
-- 
1.7.10.4

