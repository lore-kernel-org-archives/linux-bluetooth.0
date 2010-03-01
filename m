Return-Path: <cyrus@holtmann.org>
From: Romain Guillebert <romain.py@gmail.com>
To: alan@linux.intel.com
Cc: linux-bluetooth@vger.kernel.org,
	Romain Guillebert <romain.py@gmail.com>
Subject: [PATCH] drivers: bluetooth: hci_ldisc: Fixed multiple coding style issues
Date: Mon,  1 Mar 2010 21:33:18 +0100
Message-Id: <1267475598-4120-1-git-send-email-romain.py@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Fixes many coding style issues in this file

Signed-off-by: Romain Guillebert <romain.py@gmail.com>
---
 drivers/bluetooth/hci_ldisc.c |   23 +++++++++++++----------
 1 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
index aa09193..6aa1c25 100644
--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -48,7 +48,7 @@
 
 #define VERSION "2.2"
 
-static int reset = 0;
+static int reset;
 
 static struct hci_uart_proto *hup[HCI_UART_MAX_PROTO];
 
@@ -244,12 +244,12 @@ static void hci_uart_destruct(struct hci_dev *hdev)
 
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
@@ -261,7 +261,8 @@ static int hci_uart_tty_open(struct tty_struct *tty)
 	if (hu)
 		return -EEXIST;
 
-	if (!(hu = kzalloc(sizeof(struct hci_uart), GFP_KERNEL))) {
+	hu = kzalloc(sizeof(struct hci_uart), GFP_KERNEL);
+	if (!hu) {
 		BT_ERR("Can't allocate control structure");
 		return -ENFILE;
 	}
@@ -339,15 +340,15 @@ static void hci_uart_tty_wakeup(struct tty_struct *tty)
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
@@ -515,7 +516,7 @@ static int __init hci_uart_init(void)
 
 	/* Register the tty discipline */
 
-	memset(&hci_uart_ldisc, 0, sizeof (hci_uart_ldisc));
+	memset(&hci_uart_ldisc, 0, sizeof(hci_uart_ldisc));
 	hci_uart_ldisc.magic		= TTY_LDISC_MAGIC;
 	hci_uart_ldisc.name		= "n_hci";
 	hci_uart_ldisc.open		= hci_uart_tty_open;
@@ -528,7 +529,8 @@ static int __init hci_uart_init(void)
 	hci_uart_ldisc.write_wakeup	= hci_uart_tty_wakeup;
 	hci_uart_ldisc.owner		= THIS_MODULE;
 
-	if ((err = tty_register_ldisc(N_HCI, &hci_uart_ldisc))) {
+	err = tty_register_ldisc(N_HCI, &hci_uart_ldisc);
+	if (err) {
 		BT_ERR("HCI line discipline registration failed. (%d)", err);
 		return err;
 	}
@@ -561,7 +563,8 @@ static void __exit hci_uart_exit(void)
 #endif
 
 	/* Release tty registration of line discipline */
-	if ((err = tty_unregister_ldisc(N_HCI)))
+	err = tty_unregister_ldisc(N_HCI);
+	if (err)
 		BT_ERR("Can't unregister HCI line discipline (%d)", err);
 }
 
-- 
1.7.0

