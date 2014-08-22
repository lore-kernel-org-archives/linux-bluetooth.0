Return-Path: <cyrus@holtmann.org>
From: Tim Niemeyer <tim.niemeyer@corscience.de>
To: Felipe Balbi <balbi@ti.com>,
	Greg KH <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	Gustavo Padovan <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	jslaby@suse.cz,
	grant.likely@linaro.org,
	linux-bluetooth@vger.kernel.org,
	andreas@biessmann.de
Subject: [PATCH] bluetooth: hci_ldisc: fix deadlock condition
Date: Fri, 22 Aug 2014 15:45:07 +0200
Message-Id: <1408715107-21299-1-git-send-email-tim.niemeyer@corscience.de>
In-Reply-To: <1398265117-11793-2-git-send-email-balbi@ti.com>
References: <1398265117-11793-2-git-send-email-balbi@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

This Patch was applied to 3.10 and 3.2. It's probably missed on 3.4.

---------------------

From: Felipe Balbi <balbi@ti.com>

LDISCs shouldn't call tty->ops->write() from within
->write_wakeup().

->write_wakeup() is called with port lock taken and
IRQs disabled, tty->ops->write() will try to acquire
the same port lock and we will deadlock.

Acked-by: Marcel Holtmann <marcel@holtmann.org>
Reviewed-by: Peter Hurley <peter@hurleysoftware.com>
Reported-by: Huang Shijie <b32955@freescale.com>
Signed-off-by: Felipe Balbi <balbi@ti.com>
Tested-by: Andreas Bie=C3=9Fmann <andreas@biessmann.de>
[tim.niemeyer@corscience.de: rebased on 3.4.103]
Signed-off-by: Tim Niemeyer <tim.niemeyer@corscience.de>
---
 drivers/bluetooth/hci_ldisc.c |   25 ++++++++++++++++++++-----
 drivers/bluetooth/hci_uart.h  |    2 ++
 2 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.=
c
index 98a8c05..d4550f9 100644
--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -118,10 +118,6 @@ static inline struct sk_buff *hci_uart_dequeue(struc=
t hci_uart *hu)
=20
 int hci_uart_tx_wakeup(struct hci_uart *hu)
 {
-	struct tty_struct *tty =3D hu->tty;
-	struct hci_dev *hdev =3D hu->hdev;
-	struct sk_buff *skb;
-
 	if (test_and_set_bit(HCI_UART_SENDING, &hu->tx_state)) {
 		set_bit(HCI_UART_TX_WAKEUP, &hu->tx_state);
 		return 0;
@@ -129,6 +125,22 @@ int hci_uart_tx_wakeup(struct hci_uart *hu)
=20
 	BT_DBG("");
=20
+	schedule_work(&hu->write_work);
+
+	return 0;
+}
+
+static void hci_uart_write_work(struct work_struct *work)
+{
+	struct hci_uart *hu =3D container_of(work, struct hci_uart, write_work)=
;
+	struct tty_struct *tty =3D hu->tty;
+	struct hci_dev *hdev =3D hu->hdev;
+	struct sk_buff *skb;
+
+	/* REVISIT: should we cope with bad skbs or ->write() returning
+	 * and error value ?
+	 */
+
 restart:
 	clear_bit(HCI_UART_TX_WAKEUP, &hu->tx_state);
=20
@@ -153,7 +165,6 @@ restart:
 		goto restart;
=20
 	clear_bit(HCI_UART_SENDING, &hu->tx_state);
-	return 0;
 }
=20
 /* ------- Interface to HCI layer ------ */
@@ -264,6 +275,8 @@ static int hci_uart_tty_open(struct tty_struct *tty)
 	hu->tty =3D tty;
 	tty->receive_room =3D 65536;
=20
+	INIT_WORK(&hu->write_work, hci_uart_write_work);
+
 	spin_lock_init(&hu->rx_lock);
=20
 	/* Flush any pending characters in the driver and line discipline. */
@@ -298,6 +311,8 @@ static void hci_uart_tty_close(struct tty_struct *tty=
)
 		if (hdev)
 			hci_uart_close(hdev);
=20
+		cancel_work_sync(&hu->write_work);
+
 		if (test_and_clear_bit(HCI_UART_PROTO_SET, &hu->flags)) {
 			if (hdev) {
 				hci_unregister_dev(hdev);
diff --git a/drivers/bluetooth/hci_uart.h b/drivers/bluetooth/hci_uart.h
index 6cf6ab22..af93d83 100644
--- a/drivers/bluetooth/hci_uart.h
+++ b/drivers/bluetooth/hci_uart.h
@@ -66,6 +66,8 @@ struct hci_uart {
 	unsigned long		flags;
 	unsigned long		hdev_flags;
=20
+	struct work_struct	write_work;
+
 	struct hci_uart_proto	*proto;
 	void			*priv;
=20
--=20
1.7.10.4
