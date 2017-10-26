Return-Path: <foo00@h08.hostsharing.net>
Date: Thu, 26 Oct 2017 08:52:02 +0200
From: Lukas Wunner <lukas@wunner.de>
To: =?us-ascii?B?PT9VVEYtOD9xP1JvbmFsZD0yMFRzY2hhbD1DMz1BNHI/PQ==?= <ronald@innovation.ch>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Gustavo Padovan <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Dean Jenkins <Dean_Jenkins@mentor.com>,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: hci_ldisc: Fix another race when closing the
 tty.
Message-ID: <20171026065202.GA6487@wunner.de>
References: <20171026051519.GA15958@innovation.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171026051519.GA15958@innovation.ch>
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, Oct 25, 2017 at 10:15:19PM -0700, =?UTF-8?q?Ronald=20Tschal=C3=A4r?= wrote:
> --- a/drivers/bluetooth/hci_ldisc.c
> +++ b/drivers/bluetooth/hci_ldisc.c
> @@ -523,13 +523,13 @@ static void hci_uart_tty_close(struct tty_struct *tty)
>  	if (hdev)
>  		hci_uart_close(hdev);
>  
> -	cancel_work_sync(&hu->write_work);
> -
>  	if (test_bit(HCI_UART_PROTO_READY, &hu->flags)) {
>  		percpu_down_write(&hu->proto_lock);
>  		clear_bit(HCI_UART_PROTO_READY, &hu->flags);
>  		percpu_up_write(&hu->proto_lock);
>  
> +		cancel_work_sync(&hu->write_work);
> +

Now the work is only cancelled if HCI_UART_PROTO_READY is set,
but that seems fine, so

Reviewed-by: Lukas Wunner <lukas@wunner.de>

It should be noted that this patch only applies cleanly if Ronald's
other patch is applied before.
