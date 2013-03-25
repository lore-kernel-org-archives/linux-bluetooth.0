Return-Path: <cyrus@holtmann.org>
Date: Mon, 25 Mar 2013 11:59:56 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Chan-yeol Park <chanyeol.park@samsung.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Fix crash with incoming uart packet
Message-ID: <20130325095956.GA11646@x220.ger.corp.intel.com>
References: <1363959853-21666-1-git-send-email-chanyeol.park@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1363959853-21666-1-git-send-email-chanyeol.park@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Chan-yeol,

On Fri, Mar 22, 2013, Chan-yeol Park wrote:
> This patch adds check HCI_UART_REGISTERED before reading uart packet because
> BT uart data could be read before hci_uart is registered.
> 
> Backtrace:
> [<c05f27ec>] (hci_recv_stream_fragment+0x0/0x74) from [<c04126f4>] (h4_recv+0x18/0x40)
>  r7:eb1d4d1c r6:eb7683b0 r5:eae8e800 r4:0000000c
> [<c04126dc>] (h4_recv+0x0/0x40) from [<c0411870>] (hci_uart_tty_receive+0x6c/0x94)
>  r5:eae8e800 r4:eb768380
> [<c0411804>] (hci_uart_tty_receive+0x0/0x94) from [<c027be88>] (flush_to_ldisc+0x16c/0x17c)
>  r6:eae8e8d8 r5:eae8e800 r4:eae8e8c8
> [<c027bd1c>] (flush_to_ldisc+0x0/0x17c) from [<c0050ae8>] (process_one_work+0x144/0x4d4)
> [<c00509a4>] (process_one_work+0x0/0x4d4) from [<c0051208>] (worker_thread+0x180/0x370)
> [<c0051088>] (worker_thread+0x0/0x370) from [<c005617c>] (kthread+0x90/0x9c)
> [<c00560ec>] (kthread+0x0/0x9c) from [<c003a3a0>] (do_exit+0x0/0x7ec)
> 
> Signed-off-by: Chan-yeol Park <chanyeol.park@samsung.com>
> ---
>  drivers/bluetooth/hci_ldisc.c |    3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
> index ed0fade..476a307 100644
> --- a/drivers/bluetooth/hci_ldisc.c
> +++ b/drivers/bluetooth/hci_ldisc.c
> @@ -386,6 +386,9 @@ static void hci_uart_tty_receive(struct tty_struct *tty, const u8 *data, char *f
>  	if (!test_bit(HCI_UART_PROTO_SET, &hu->flags))
>  		return;
>  
> +	if (!test_bit(HCI_UART_REGISTERED, &hu->flags))
> +		return;
> +
>  	spin_lock(&hu->rx_lock);
>  	hu->proto->recv(hu, (void *) data, count);
>  	hu->hdev->stat.byte_rx += count;

Wouldn't this break HCI drivers that have a transport specific init
sequence, like H5, i.e. those that rely on transmitting data before the
HCI device is registered?

I think your commit message should more clearly explain how you manage
to reproduce this condition. It seems to me like data arrives when
inside the hci_uart_tty_ioctl function after calling test_and_set_bit
for HCI_UART_PROTO_SET but before the hci_uart_set_proto function has
returned (and thus called hci_register_dev in the case of H4). Is that
correct?

Johan
