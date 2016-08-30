Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH 4/4] Bluetooth: hci_ldisc: make sure we don't loose HCI_UART_TX_WAKEUP events
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1471592327-14133-5-git-send-email-boris.brezillon@free-electrons.com>
Date: Tue, 30 Aug 2016 09:53:53 -0700
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        jason.abele@gmail.com
Message-Id: <23C61632-54CF-43DD-8F99-B18176DF6C07@holtmann.org>
References: <1471592327-14133-1-git-send-email-boris.brezillon@free-electrons.com> <1471592327-14133-5-git-send-email-boris.brezillon@free-electrons.com>
To: Boris Brezillon <boris.brezillon@free-electrons.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Boris,

> The HCI_UART_TX_WAKEUP flag checking is racy and some HCI_UART_TX_WAKEUP
> events can be lost.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> ---
> drivers/bluetooth/hci_ldisc.c | 11 +++++++++++
> 1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
> index 27f73294edcb..ee7b25f1c6ce 100644
> --- a/drivers/bluetooth/hci_ldisc.c
> +++ b/drivers/bluetooth/hci_ldisc.c
> @@ -172,6 +172,17 @@ restart:
> 		goto restart;
> 
> 	clear_bit(HCI_UART_SENDING, &hu->tx_state);
> +
> +	/*
> +	 * One last check to make sure hci_uart_tx_wakeup() did not set
> +	 * HCI_UART_TX_WAKEUP while we where clearing HCI_UART_SENDING.
> +	 * The work might have been scheduled by someone else in the
> +	 * meantime, in this case we return directly.
> +	 */
> +	if (test_bit(HCI_UART_TX_WAKEUP, &hu->tx_state) &&
> +	    !test_and_set_bit(HCI_UART_SENDING, &hu->tx_state))
> +		goto restart;
> +

I know this is correct, but I would actually make it visually different.

	if (test_bit(UART_TX_WAKEUP, ..) {
		/* comment goes here
		 */
		if (!test_and_set_bit(UART_SENDING, ..)
			goto restart;
	}

For me with a proper comment that is a lot easier to read and grok that it is correct.

Regards

Marcel

