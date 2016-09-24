Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.0 \(3226\))
Subject: Re: [PATCH V2 5/7] Bluetooth: Fix HCI UART HCI_UART_PROTO_SET locking
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1474653392-28770-6-git-send-email-Dean_Jenkins@mentor.com>
Date: Sat, 24 Sep 2016 06:41:42 +0200
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org
Message-Id: <4B493FC9-949B-4110-8281-4FAE90B43C11@holtmann.org>
References: <1474653392-28770-1-git-send-email-Dean_Jenkins@mentor.com>
 <1474653392-28770-6-git-send-email-Dean_Jenkins@mentor.com>
To: Dean Jenkins <Dean_Jenkins@mentor.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Dean,

> Here is a NULL pointer dereference that causes a Bluetooth crash:
> 
> (hci_uart_tty_receive+0x0/0x84 [hci_uart]) from (flush_to_ldisc+0x104/0x190)
> (flush_to_ldisc+0x0/0x190) from (tty_flip_buffer_push+0x50/0x5c)
> (tty_flip_buffer_push+0x0/0x5c) from (imx_rxint+0x228/0x23c)
> (imx_rxint+0x0/0x23c) from (imx_int+0xa8/0x174)
> (imx_int+0x0/0x174) from (handle_irq_event_percpu+0x90/0x280)
> (handle_irq_event_percpu+0x0/0x280) from (handle_irq_event+0x44/0x64)
> (handle_irq_event+0x0/0x64) from (handle_fasteoi_irq+0xc0/0x108)
> (handle_fasteoi_irq+0x0/0x108) from (generic_handle_irq+0x28/0x38)
> (generic_handle_irq+0x0/0x38) from (handle_IRQ+0x6c/0x94)
> (handle_IRQ+0x0/0x94) from (gic_handle_irq+0x44/0x68)
> (gic_handle_irq+0x0/0x68) from (__irq_svc+0x40/0x70)
> (bcsp_open+0x0/0xcc [hci_uart]) from (hci_uart_tty_ioctl+0xa8/0x238 [hci_uart])
> (hci_uart_tty_ioctl+0x0/0x238 [hci_uart]) from (tty_ioctl+0xa88/0xae8)
> (tty_ioctl+0x0/0xae8) from (vfs_ioctl+0x30/0x44)
> (vfs_ioctl+0x0/0x44) from (do_vfs_ioctl+0x53c/0x590)
> (do_vfs_ioctl+0x0/0x590) from (sys_ioctl+0x40/0x68)
> (sys_ioctl+0x0/0x68) from (ret_fast_syscall+0x0/0x30)
> 
> It can be seen that bcsp_open() is pre-empted by an interrupt relating
> to reception of UART characters. bcsp_open() is called from
> hci_uart_set_proto() which is called from hci_uart_tty_ioctl() due to
> HCIUARTSETPROTO handling.
> 
> The crash occurs in hci_uart_tty_receive() and analysis shows:
> 	if (!test_bit(HCI_UART_PROTO_SET, &hu->flags))
> 		return;
> 
> 	spin_lock(&hu->rx_lock);
> 	hu->proto->recv(hu, (void *) data, count);
> 
> The crash occurs in the dereference hu->proto->recv. Presumably no recv
> function has been set and a NULL pointer dereference occurs.
> 
> Note that the flag HCI_UART_PROTO_SET being clear should prevent the failure
> but in fact fails. This indicates that HCI_UART_PROTO_SET is in the set state.
> 
> The HCI_UART_PROTO_SET locking fails because HCI_UART_PROTO_SET is put into
> the set state in hci_uart_tty_ioctl() BEFORE calling hci_uart_set_proto()
> to set the recv function pointer. Therefore, there is a race condition.
> 
> It would seem that HCI_UART_PROTO_SET was being used as a dual flag:
> 
> a) HCI_UART_PROTO_SET being used to indicate the protocol Data Link
> layer had been successfully opened.
> 
> b) HCI_UART_PROTO_SET being used as a lockless solution for
> hci_uart_tty_ioctl(). (mutex now added by a previous commit to prevent
> concurrency so HCI_UART_PROTO_SET no longer needs to fill that role.)
> 
> The solution is to set the flag HCI_UART_PROTO_SET after successfully
> calling hci_uart_set_proto() in the HCIUARTSETPROTO handling in
> hci_uart_tty_ioctl(). This will prevent hci_uart_tty_receive() from
> performing the recv function pointer dereference until hci_uart_set_proto()
> has set the recv function pointer.
> 
> Signed-off-by: Vignesh Raman <Vignesh_Raman@mentor.com>
> Signed-off-by: Dean Jenkins <Dean_Jenkins@mentor.com>
> Signed-off-by: Mark Craske <Mark_Craske@mentor.com>
> ---
> drivers/bluetooth/hci_ldisc.c | 6 +++---
> 1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
> index 01590f6..1fc9817 100644
> --- a/drivers/bluetooth/hci_ldisc.c
> +++ b/drivers/bluetooth/hci_ldisc.c
> @@ -698,10 +698,10 @@ static int hci_uart_tty_ioctl(struct tty_struct *tty, struct file *file,
> 	mutex_lock(&ioctl_mutex);
> 	switch (cmd) {
> 	case HCIUARTSETPROTO:
> -		if (!test_and_set_bit(HCI_UART_PROTO_SET, &hu->flags)) {
> +		if (!test_bit(HCI_UART_PROTO_SET, &hu->flags)) {
> 			err = hci_uart_set_proto(hu, arg);
> -			if (err)
> -				clear_bit(HCI_UART_PROTO_SET, &hu->flags);
> +			if (!err)
> +				set_bit(HCI_UART_PROTO_SET, &hu->flags);
> 		} else

the extensive commit message is great, but can be get a small comment included here why we are doing it this way. I think that would help to accidentally revert it back to what it was in the future.

Regards

Marcel

