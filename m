Return-Path: <cyrus@holtmann.org>
Message-ID: <5527EB14.9000608@hurleysoftware.com>
Date: Fri, 10 Apr 2015 11:24:04 -0400
From: Peter Hurley <peter@hurleysoftware.com>
MIME-Version: 1.0
To: Frederic Danis <frederic.danis@linux.intel.com>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 2/7] Bluetooth: hci_uart: Add HCIUARTSETBAUDRATE ioctl
References: <1428673066-1349-1-git-send-email-frederic.danis@linux.intel.com> <1428673066-1349-2-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1428673066-1349-2-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On 04/10/2015 09:37 AM, Frederic Danis wrote:
> This allows user space application to set final speed requested for UART
> device. UART port is open at init speed by user space application.
> 
> Signed-off-by: Frederic Danis <frederic.danis@linux.intel.com>
> ---
>  drivers/bluetooth/hci_ldisc.c | 6 ++++++
>  drivers/bluetooth/hci_uart.h  | 2 ++
>  2 files changed, 8 insertions(+)
> 
> diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
> index 5c9a73f..190a7f8 100644
> --- a/drivers/bluetooth/hci_ldisc.c
> +++ b/drivers/bluetooth/hci_ldisc.c
> @@ -609,6 +609,12 @@ static int hci_uart_tty_ioctl(struct tty_struct *tty, struct file *file,
>  	case HCIUARTGETFLAGS:
>  		return hu->hdev_flags;
>  
> +	case HCIUARTSETBAUDRATE:
> +		if (test_bit(HCI_UART_PROTO_SET, &hu->flags))
> +			return -EBUSY;
> +		hu->speed = arg;
> +		break;
> +

So now that the kernel can set line rate, why is an ioctl necessary
to determine what the line rate should be?


>  	default:
>  		err = n_tty_ioctl_helper(tty, file, cmd, arg);
>  		break;
> diff --git a/drivers/bluetooth/hci_uart.h b/drivers/bluetooth/hci_uart.h
> index 72120a5..09a47b4 100644
> --- a/drivers/bluetooth/hci_uart.h
> +++ b/drivers/bluetooth/hci_uart.h
> @@ -33,6 +33,7 @@
>  #define HCIUARTGETDEVICE	_IOR('U', 202, int)
>  #define HCIUARTSETFLAGS		_IOW('U', 203, int)
>  #define HCIUARTGETFLAGS		_IOR('U', 204, int)
> +#define HCIUARTSETBAUDRATE	_IOW('U', 205, int)
>  
>  /* UART protocols */
>  #define HCI_UART_MAX_PROTO	8
> @@ -72,6 +73,7 @@ struct hci_uart {
>  	struct hci_dev		*hdev;
>  	unsigned long		flags;
>  	unsigned long		hdev_flags;
> +	unsigned long		speed;
>  
>  	struct work_struct	init_ready;
>  	struct work_struct	write_work;
> 

