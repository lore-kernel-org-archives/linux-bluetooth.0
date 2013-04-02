Return-Path: <cyrus@holtmann.org>
Date: Tue, 2 Apr 2013 12:23:32 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Chan-yeol Park <chanyeol.park@samsung.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v4 2/3] Bluetooth: Fix possible NULL dereference
Message-ID: <20130402092332.GB9284@x220>
References: <1364404149-12853-1-git-send-email-chanyeol.park@samsung.com>
 <1364404149-12853-2-git-send-email-chanyeol.park@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1364404149-12853-2-git-send-email-chanyeol.park@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Chan-yeol,

On Thu, Mar 28, 2013, Chan-yeol Park wrote:
> This patch adds NULL check for hci uart ldisc driver because some of
> hci uart driver allow hci_uart_tty_receive function could be called
> though hci uart driver is not registered properly.
> 
> hci h4 driever's backtrace is attached.
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
>  drivers/bluetooth/hci_ldisc.c |    5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
> index ed0fade..d710d8b 100644
> --- a/drivers/bluetooth/hci_ldisc.c
> +++ b/drivers/bluetooth/hci_ldisc.c
> @@ -388,7 +388,10 @@ static void hci_uart_tty_receive(struct tty_struct *tty, const u8 *data, char *f
>  
>  	spin_lock(&hu->rx_lock);
>  	hu->proto->recv(hu, (void *) data, count);
> -	hu->hdev->stat.byte_rx += count;
> +
> +	if (hu->hdev)
> +		hu->hdev->stat.byte_rx += count;
> +
>  	spin_unlock(&hu->rx_lock);
>  
>  	tty_unthrottle(tty);

All patches in this set seem fine to me, except that the backtrace
you've got in this commit message doesn't seem to match the issue that
it is fixing. If there's a NULL pointer dereference related issue (if
hu->hdev is NULL) then the last function in the trace should be
hci_uart_tty_receive and not hci_recv_stream_fragment.

Johan
