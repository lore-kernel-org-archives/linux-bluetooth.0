Return-Path: <Dean_Jenkins@mentor.com>
From: Dean Jenkins <Dean_Jenkins@mentor.com>
To: Dean Jenkins <Dean_Jenkins@mentor.com>, Marcel Holtmann
	<marcel@holtmann.org>, Gustavo Padovan <gustavo@padovan.org>, Johan Hedberg
	<johan.hedberg@gmail.com>
CC: <linux-bluetooth@vger.kernel.org>
Subject: [PATCH v1 1/4] Bluetooth: Fix HCI UART HCI_UART_PROTO_SET locking
Date: Wed, 7 Sep 2016 15:15:07 +0100
Message-ID: <1473257710-2073-2-git-send-email-Dean_Jenkins@mentor.com>
In-Reply-To: <1473257710-2073-1-git-send-email-Dean_Jenkins@mentor.com>
References: <1473257710-2073-1-git-send-email-Dean_Jenkins@mentor.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-bluetooth.vger.kernel.org>

From: Vignesh Raman <Vignesh_Raman@mentor.com>

Here is a NULL pointer dereference that causes a Bluetooth crash:

(hci_uart_tty_receive+0x0/0x84 [hci_uart]) from (flush_to_ldisc+0x104/0x190)
(flush_to_ldisc+0x0/0x190) from (tty_flip_buffer_push+0x50/0x5c)
(tty_flip_buffer_push+0x0/0x5c) from (imx_rxint+0x228/0x23c)
(imx_rxint+0x0/0x23c) from (imx_int+0xa8/0x174)
(imx_int+0x0/0x174) from (handle_irq_event_percpu+0x90/0x280)
(handle_irq_event_percpu+0x0/0x280) from (handle_irq_event+0x44/0x64)
(handle_irq_event+0x0/0x64) from (handle_fasteoi_irq+0xc0/0x108)
(handle_fasteoi_irq+0x0/0x108) from (generic_handle_irq+0x28/0x38)
(generic_handle_irq+0x0/0x38) from (handle_IRQ+0x6c/0x94)
(handle_IRQ+0x0/0x94) from (gic_handle_irq+0x44/0x68)
(gic_handle_irq+0x0/0x68) from (__irq_svc+0x40/0x70)
(bcsp_open+0x0/0xcc [hci_uart]) from (hci_uart_tty_ioctl+0xa8/0x238 [hci_uart])
(hci_uart_tty_ioctl+0x0/0x238 [hci_uart]) from (tty_ioctl+0xa88/0xae8)
(tty_ioctl+0x0/0xae8) from (vfs_ioctl+0x30/0x44)
(vfs_ioctl+0x0/0x44) from (do_vfs_ioctl+0x53c/0x590)
(do_vfs_ioctl+0x0/0x590) from (sys_ioctl+0x40/0x68)
(sys_ioctl+0x0/0x68) from (ret_fast_syscall+0x0/0x30)

It can be seen that bcsp_open() is pre-empted by an interrupt relating
to reception of UART characters. bcsp_open() is called from
hci_uart_set_proto() which is called from hci_uart_tty_ioctl() due to
HCIUARTSETPROTO handling.

The crash occurs in hci_uart_tty_receive() and analysis shows:
	if (!test_bit(HCI_UART_PROTO_SET, &hu->flags))
		return;

	spin_lock(&hu->rx_lock);
	hu->proto->recv(hu, (void *) data, count);

The crash occurs in the dereference hu->proto->recv. Presumably no recv
function has been set and a NULL pointer dereference occurs.

Note that the flag HCI_UART_PROTO_SET being clear should prevent the failure
but in fact fails. This indicates that HCI_UART_PROTO_SET is in the set state.

The HCI_UART_PROTO_SET locking fails because HCI_UART_PROTO_SET is put into
the set state in hci_uart_tty_ioctl() BEFORE calling hci_uart_set_proto()
to set the recv function pointer. Therefore, there is a race condition.

The solution is to set the flag HCI_UART_PROTO_SET after successfully
calling hci_uart_set_proto() in the HCIUARTSETPROTO handling in
hci_uart_tty_ioctl(). This will prevent hci_uart_tty_receive() from
performing the recv function pointer dereference until hci_uart_set_proto()
has set the recv function pointer.

Signed-off-by: Vignesh Raman <Vignesh_Raman@mentor.com>
Signed-off-by: Dean Jenkins <Dean_Jenkins@mentor.com>
Signed-off-by: Mark Craske <Mark_Craske@mentor.com>
---
 drivers/bluetooth/hci_ldisc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
index dda9739..1e338d5 100644
--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -695,12 +695,12 @@ static int hci_uart_tty_ioctl(struct tty_struct *tty, struct file *file,
 
 	switch (cmd) {
 	case HCIUARTSETPROTO:
-		if (!test_and_set_bit(HCI_UART_PROTO_SET, &hu->flags)) {
+		if (!test_bit(HCI_UART_PROTO_SET, &hu->flags)) {
 			err = hci_uart_set_proto(hu, arg);
-			if (err) {
-				clear_bit(HCI_UART_PROTO_SET, &hu->flags);
+			if (!err)
+				set_bit(HCI_UART_PROTO_SET, &hu->flags);
+			else
 				return err;
-			}
 		} else
 			return -EBUSY;
 		break;
-- 
2.7.4
