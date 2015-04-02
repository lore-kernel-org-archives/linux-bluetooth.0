Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2070.6\))
Subject: Re: [RFC 1/5] Bluetooth: hci_uart: Add HCIUARTSETDEVTYPE ioctl
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1427985456-31536-2-git-send-email-frederic.danis@linux.intel.com>
Date: Thu, 2 Apr 2015 07:57:45 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <85856913-3AA1-4D1E-9F8B-A5450ADC4E4F@holtmann.org>
References: <1427985456-31536-1-git-send-email-frederic.danis@linux.intel.com> <1427985456-31536-2-git-send-email-frederic.danis@linux.intel.com>
To: Frederic Danis <frederic.danis@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Fred,

> This allows user space application to set the correct vendor specific
> setup function.
> 
> Signed-off-by: Frederic Danis <frederic.danis@linux.intel.com>
> ---
> drivers/bluetooth/hci_ldisc.c | 50 +++++++++++++++++++++++++++++++++++++++++++
> drivers/bluetooth/hci_uart.h  |  4 ++++
> 2 files changed, 54 insertions(+)
> 
> diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
> index 1363dc6..cb7fcc6 100644
> --- a/drivers/bluetooth/hci_ldisc.c
> +++ b/drivers/bluetooth/hci_ldisc.c
> @@ -467,9 +467,19 @@ static int hci_uart_register_dev(struct hci_uart *hu)
> 	return 0;
> }
> 
> +struct hci_uart_devtype_t {
> +	char type[HCI_UART_DEVTYPE_SIZE];
> +	int (*setup)(struct hci_uart *hu);
> +};
> +
> +struct hci_uart_devtype_t devtypes[] = {
> +		{ "", 0 }
> +};
> +

I am actually not in favor of this and I do not think this is needed.

If you want a different hdev->setup function, then you need to implement a new protocol. We already have the HCIUARTSETPROTO ioctl and that should be the main selection point on which driver/vendor is attached to the TTY.

Lets focus on just using HCIUARTSETPROTO for now and when needed just introduce a new driver/vendor in case we want to add special setup code. We can have generic_* type of helpers in hci_ldisc.c for generic H:4 stuff in case it is just a H:4 driver. We can use select in Kconfig to ensure that hci_h4.c gets include when another driver/vendor needs it.

Regards

Marcel

