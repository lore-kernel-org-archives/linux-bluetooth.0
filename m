Return-Path: <marex@denx.de>
Subject: Re: [PATCH] [RFC] Bluetooth: hci_ldisc: Possible race condition
To: linux-bluetooth@vger.kernel.org
References: <20161210013655.6013-1-marex@denx.de>
Cc: marcel@holtmann.org
From: Marek Vasut <marex@denx.de>
Message-ID: <db740e53-aad6-5e54-bbcf-e4759a62a492@denx.de>
Date: Thu, 5 Jan 2017 20:33:16 +0100
MIME-Version: 1.0
In-Reply-To: <20161210013655.6013-1-marex@denx.de>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-bluetooth.vger.kernel.org>

On 12/10/2016 02:36 AM, Marek Vasut wrote:
> I suspect the following race condition happens on system reboot,
> when using the TI UART bluetooth adapter, attached using:
> 
> $ hciattach -n /dev/ttymxc0 texas 115200 flow
> 
> In drivers/bluetooth/hci_ldisc.c:
> 1) write_work is canceled in hci_uart_tty_close() using cancel_work_sync()
> 2) transmission is scheduled right after the work is canceled using
>    hci_uart_send_frame()
> 3) protocol is closed in hci_uart_tty_close() using hu->proto->close(),
>    which sets ll->priv to NULL
> 4) hci_uart_write_work() calls hci_uart_dequeue() , which calls
>    ll_dequeue() , which accesses hu->priv->txq using skb_dequeue() .
>    In fact, skb_dequeue() locks the spinlock lock in hu->priv->txq->lock
>    first , which is located at offset 0x18 from start of hu->priv
>    (struct ll_struct) .
> 
> NOTE: The system I use is so far on 4.7, but I will be rebasing this forward.
>       I would like to check with you whether I could be hitting something or
>       whether my hypothesis is completely wrong and there's possibly some
>       other problem. Thanks!
> 
> Signed-off-by: Marek Vasut <marex@denx.de>

Bump ?

> ---
> Unable to handle kernel NULL pointer dereference at virtual address 00000018
> pgd = c0004000
> [00000018] *pgd=00000000
> Internal error: Oops: 5 [#1] SMP ARM
> Modules linked in: evbug wl12xx wlcore_sdio wlcore
> CPU: 0 PID: 21 Comm: kworker/0:1 Not tainted 4.7.10-00952-gb49feff6-dirty #64
> Hardware name: Freescale i.MX6 SoloX (Device Tree)
> Workqueue: events hci_uart_write_work
> task: da4d2a00 ti: da59e000 task.ti: da59e000
> PC is at _raw_spin_lock_irqsave+0x1c/0x5c
> LR is at skb_dequeue+0x1c/0x70
> pc : [<c08e045c>]    lr : [<c070a944>]    psr: 600d0093
> sp : da59fe70  ip : da59fe80  fp : da59fe7c
> r10: 00000000  r9 : d8decc5c  r8 : 00000005
> r7 : d8c54000  r6 : 00000018  r5 : 0000000c  r4 : 00000000
> r3 : c06674bc  r2 : 00000018  r1 : d8dec8bc  r0 : 600d0013
> Flags: nZCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment none
> Control: 10c5387d  Table: 98e2c04a  DAC: 00000051
> Process kworker/0:1 (pid: 21, stack limit = 0xda59e210)
> Stack: (0xda59fe70 to 0xda5a0000)
> fe60:                                     da59fe9c da59fe80 c070a944 c08e044c
> fe80: 00000000 d8dec8a0 d8decb00 d8c54000 da59feac da59fea0 c06674d4 c070a934
> fea0: da59fee4 da59feb0 c0666acc c06674c8 d8dec880 d8dec8bc da59fee4 d8dec8a0
> fec0: da561e00 dabad700 00000000 dabb0a00 00000000 da561e00 da59ff1c da59fee8
> fee0: c013a208 c06669d8 c0d02100 da59e000 dabad700 da561e18 00000008 dabad718
> ff00: c0d02100 da59e000 dabad700 da561e00 da59ff5c da59ff20 c013af04 c013a028
> ff20: 00000000 da561e00 c013aec4 00000000 00000000 00000000 da563300 da561e00
> ff40: c013aec4 00000000 00000000 00000000 da59ffac da59ff60 c01402d8 c013aed0
> ff60: 00005423 00000000 c0140200 da561e00 00000000 00000000 da59ff78 da59ff78
> ff80: 00000000 00000000 da59ff88 da59ff88 da563300 c0140200 00000000 00000000
> ffa0: 00000000 da59ffb0 c0107b98 c014020c 00000000 00000000 00000000 00000000
> ffc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> ffe0: 00000000 00000000 00000000 00000000 00000013 00000000 ffffffff 00000000
> Backtrace:
> [<c08e0440>] (_raw_spin_lock_irqsave) from [<c070a944>] (skb_dequeue+0x1c/0x70)
> [<c070a928>] (skb_dequeue) from [<c06674d4>] (ll_dequeue+0x18/0x1c)
>  r7:d8c54000 r6:d8decb00 r5:d8dec8a0 r4:00000000
> [<c06674bc>] (ll_dequeue) from [<c0666acc>] (hci_uart_write_work+0x100/0x130)
> [<c06669cc>] (hci_uart_write_work) from [<c013a208>] (process_one_work+0x1ec/0x418)
>  r10:da561e00 r9:00000000 r8:dabb0a00 r7:00000000 r6:dabad700 r5:da561e00
>  r4:d8dec8a0
> [<c013a01c>] (process_one_work) from [<c013af04>] (worker_thread+0x40/0x5bc)
>  r10:da561e00 r9:dabad700 r8:da59e000 r7:c0d02100 r6:dabad718 r5:00000008
>  r4:da561e18
> [<c013aec4>] (worker_thread) from [<c01402d8>] (kthread+0xd8/0xf8)
>  r10:00000000 r9:00000000 r8:00000000 r7:c013aec4 r6:da561e00 r5:da563300
>  r4:00000000
> [<c0140200>] (kthread) from [<c0107b98>] (ret_from_fork+0x14/0x3c)
>  r7:00000000 r6:00000000 r5:c0140200 r4:da563300
> Code: e1a02000 e10f0000 f10c0080 f5d2f000 (e1923f9f)
> ---[ end trace fe4ab10f7f9fd772 ]---
> ---
>  drivers/bluetooth/hci_ldisc.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
> index 49b3e1e..f02f406 100644
> --- a/drivers/bluetooth/hci_ldisc.c
> +++ b/drivers/bluetooth/hci_ldisc.c
> @@ -253,7 +253,8 @@ static int hci_uart_send_frame(struct hci_dev *hdev, struct sk_buff *skb)
>  
>  	hu->proto->enqueue(hu, skb);
>  
> -	hci_uart_tx_wakeup(hu);
> +	if (test_bit(HCI_UART_PROTO_READY, &hu->flags))
> +		hci_uart_tx_wakeup(hu);
>  
>  	return 0;
>  }
> @@ -477,6 +478,7 @@ static void hci_uart_tty_close(struct tty_struct *tty)
>  {
>  	struct hci_uart *hu = tty->disc_data;
>  	struct hci_dev *hdev;
> +	unsigned long flags;
>  
>  	BT_DBG("tty %p", tty);
>  
> @@ -490,9 +492,11 @@ static void hci_uart_tty_close(struct tty_struct *tty)
>  	if (hdev)
>  		hci_uart_close(hdev);
>  
> +	flags = test_and_clear_bit(HCI_UART_PROTO_READY, &hu->flags);
> +
>  	cancel_work_sync(&hu->write_work);
>  
> -	if (test_and_clear_bit(HCI_UART_PROTO_READY, &hu->flags)) {
> +	if (flags) {
>  		if (hdev) {
>  			if (test_bit(HCI_UART_REGISTERED, &hu->flags))
>  				hci_unregister_dev(hdev);
> 


-- 
Best regards,
Marek Vasut
