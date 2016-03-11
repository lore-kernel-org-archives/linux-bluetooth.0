Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.2 \(3112\))
Subject: Re: [PATCH] Bluetooth: hci_ldisc: Fix null pointer derefence in case of early data
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1457695166-16467-1-git-send-email-loic.poulain@intel.com>
Date: Fri, 11 Mar 2016 07:34:24 -0800
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <F0DC5D64-B3BF-4495-8C8D-2A4C472EEC84@holtmann.org>
References: <1457695166-16467-1-git-send-email-loic.poulain@intel.com>
To: Loic Poulain <loic.poulain@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Loic,

> HCI_UART_PROTO_SET flag is set before hci_uart_set_proto call. If we
> receive data from tty layer during this procedure, proto pointer may
> not be assigned yet, leading to null pointer dereference in rx method
> hci_uart_tty_receive.
> 
> This patch fixes this by setting the HCI_UART_PROTO_SET flag once proto
> is fully initialized and introduces HCI_UART_PROTO_BUSY flag to avoid
> concurrent call to set_proto. We could have fixed this with a mutex as
> well.
> 
> Signed-off-by: Loic Poulain <loic.poulain@intel.com>
> ---
> drivers/bluetooth/hci_ldisc.c | 16 +++++++++-------
> drivers/bluetooth/hci_uart.h  |  1 +
> 2 files changed, 10 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
> index c00168a..fab2641 100644
> --- a/drivers/bluetooth/hci_ldisc.c
> +++ b/drivers/bluetooth/hci_ldisc.c
> @@ -638,6 +638,7 @@ static int hci_uart_set_proto(struct hci_uart *hu, int id)
> 		return err;
> 
> 	hu->proto = p;
> +	set_bit(HCI_UART_PROTO_SET, &hu->flags);
> 
> 	err = hci_uart_register_dev(hu);
> 	if (err) {
> @@ -692,14 +693,15 @@ static int hci_uart_tty_ioctl(struct tty_struct *tty, struct file *file,
> 
> 	switch (cmd) {
> 	case HCIUARTSETPROTO:
> -		if (!test_and_set_bit(HCI_UART_PROTO_SET, &hu->flags)) {
> -			err = hci_uart_set_proto(hu, arg);
> -			if (err) {
> -				clear_bit(HCI_UART_PROTO_SET, &hu->flags);
> -				return err;
> -			}
> -		} else
> +		if (test_and_set_bit(HCI_UART_PROTO_BUSY, &hu->flags))
> 			return -EBUSY;
> +		if (test_bit(HCI_UART_PROTO_SET, &hu->flags))
> +			err = -EBUSY;
> +		else
> +			err = hci_uart_set_proto(hu, arg);
> +		clear_bit(HCI_UART_PROTO_BUSY, &hu->flags);
> +		if (err)
> +			return err;
> 		break;

I do not like overloading the PROTO_SET flag since that is only suppose to be used when the ioctl has been called. I think what we really want to introduce a PROTO_READY and set + check that later on.

Regards

Marcel

