Return-Path: <linux-kernel-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH 1/4] Bluetooth: hci_ldisc: fix a race in the hdev closing path
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1471592327-14133-2-git-send-email-boris.brezillon@free-electrons.com>
Date: Tue, 30 Aug 2016 09:53:59 -0700
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        jason.abele@gmail.com
Message-Id: <3FF88393-A83A-4C5D-B438-E76C923159A5@holtmann.org>
References: <1471592327-14133-1-git-send-email-boris.brezillon@free-electrons.com> <1471592327-14133-2-git-send-email-boris.brezillon@free-electrons.com>
To: Boris Brezillon <boris.brezillon@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Boris,

> hci_uart_tty_close() is cancelling any pending write work, but some
> hci_uart_proto implementations might re-schedule this work after its
> cancellation (by calling hci_uart_tx_wakeup()).
> 
> Make sure the write work is not re-scheduled in our back while we're
> closing the device.
> 
> We also cancel any pending init work and prevent the active one (if
> any) from registering the hdev if the line discipline is being closed.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> ---
> drivers/bluetooth/hci_ldisc.c | 15 ++++++++++++++-
> drivers/bluetooth/hci_uart.h  |  1 +
> 2 files changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
> index dda97398c59a..de7f7f1f995c 100644
> --- a/drivers/bluetooth/hci_ldisc.c
> +++ b/drivers/bluetooth/hci_ldisc.c
> @@ -130,7 +130,9 @@ int hci_uart_tx_wakeup(struct hci_uart *hu)
> 
> 	BT_DBG("");
> 
> -	schedule_work(&hu->write_work);
> +	/* Don't schedule the work if the device is being closed. */
> +	if (!test_bit(HCI_UART_CLOSING, &hu->flags))
> +		schedule_work(&hu->write_work);
> 
> 	return 0;
> }
> @@ -180,6 +182,11 @@ static void hci_uart_init_work(struct work_struct *work)
> 	if (!test_and_clear_bit(HCI_UART_INIT_PENDING, &hu->hdev_flags))
> 		return;
> 
> +	if (test_bit(HCI_UART_CLOSING, &hu->flags)) {
> +		BT_DBG("HCI device is being closed, don't register it.");
> +		return;
> +	}
> +
> 	err = hci_register_dev(hu->hdev);
> 	if (err < 0) {
> 		BT_ERR("Can't register HCI device");
> @@ -490,7 +497,13 @@ static void hci_uart_tty_close(struct tty_struct *tty)
> 	if (hdev)
> 		hci_uart_close(hdev);
> 
> +	/*
> +	 * Set the closing bit to make sure nobody re-schedules the write work
> +	 * in our back.
> +	 */

please use the network subsystem comment style here.

Regards

Marcel
