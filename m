Return-Path: <cyrus@holtmann.org>
Date: Thu, 4 Apr 2013 11:25:25 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Chan-yeol Park <chanyeol.park@samsung.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v4 1/3] Bluetooth: Fix hci-uart-h4 crash from incoming
 uart packet
Message-ID: <20130404082525.GB2340@x220>
References: <1364905463-1752-1-git-send-email-chanyeol.park@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1364905463-1752-1-git-send-email-chanyeol.park@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Chan-yeol,

On Tue, Apr 02, 2013, Chan-yeol Park wrote:
> This patch adds check HCI_UART_REGISTERED before reading uart data for
> hci uart h4 driver. Uart data could be arrived when inside the
> hci_uart_tty_ioctl function after calling test_and_set_bit for
> HCI_UART_PROTO_SET but before the hci_uart_set_proto function has
> returned.
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
>  drivers/bluetooth/hci_h4.c |    3 +++
>  1 file changed, 3 insertions(+)

After some language fixes to the commit messages all three patches in
this set have now been pushed to the bluetooth-next tree.

Johan
