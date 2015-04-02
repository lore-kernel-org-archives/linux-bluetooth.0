Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2070.6\))
Subject: Re: [RFC 3/5] Bluetooth: hci_uart: Add HCIUARTSETBAUDRATE ioctl
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1427985456-31536-4-git-send-email-frederic.danis@linux.intel.com>
Date: Thu, 2 Apr 2015 08:12:37 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <5B2C0E42-6EE3-4B82-94FA-01A1E4FEE9F6@holtmann.org>
References: <1427985456-31536-1-git-send-email-frederic.danis@linux.intel.com> <1427985456-31536-4-git-send-email-frederic.danis@linux.intel.com>
To: Frederic Danis <frederic.danis@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Fred,

> This allows user space application to set final speed requested for UART
> device. UART port is open at init speed by user space application.
> 
> Signed-off-by: Frederic Danis <frederic.danis@linux.intel.com>
> ---
> drivers/bluetooth/hci_ldisc.c | 4 ++++
> drivers/bluetooth/hci_uart.h  | 2 ++
> 2 files changed, 6 insertions(+)
> 
> diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
> index e8412f8..4b09369 100644
> --- a/drivers/bluetooth/hci_ldisc.c
> +++ b/drivers/bluetooth/hci_ldisc.c
> @@ -614,6 +614,10 @@ static int hci_uart_tty_ioctl(struct tty_struct *tty, struct file * file,
> 	case HCIUARTGETFLAGS:
> 		return hu->hdev_flags;
> 
> +	case HCIUARTSETBAUDRATE:
> +		hu->speed = arg;
> +		break;
> +
> 	case HCIUARTSETDEVTYPE:
> 		err = hci_tty_ioctl_set_devtype(hu, cmd, arg);
> 		if (err)
> diff --git a/drivers/bluetooth/hci_uart.h b/drivers/bluetooth/hci_uart.h
> index bf6f0e5..dcbedaf 100644
> --- a/drivers/bluetooth/hci_uart.h
> +++ b/drivers/bluetooth/hci_uart.h
> @@ -34,6 +34,7 @@
> #define HCIUARTSETFLAGS		_IOW('U', 203, int)
> #define HCIUARTGETFLAGS		_IOR('U', 204, int)
> #define HCIUARTSETDEVTYPE	_IOW('U', 205, int)
> +#define HCIUARTSETBAUDRATE	_IOW('U', 206, int)

lets do a combination of SET and GET here. We want to be able readout the the baudrate configured as well.

The only question I have is we want to do some enumeration or the plain baud rate value. Any thoughts on this?

Regards

Marcel

