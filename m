Return-Path: <cyrus@holtmann.org>
Message-ID: <51F2D650.4080706@hurleysoftware.com>
Date: Fri, 26 Jul 2013 16:04:32 -0400
From: Peter Hurley <peter@hurleysoftware.com>
MIME-Version: 1.0
To: Gianluca Anzolin <gianluca@sottospazio.it>
CC: gustavo@padovan.org, marcel@holtmann.org,
 linux-bluetooth@vger.kernel.org, gregkh@linuxfoundation.org,
 jslaby@suse.cz
Subject: Re: [PATCH v4 3/6] rfcomm: Move the tty initialization and cleanup
 out of open/close
References: <1374859138-19467-1-git-send-email-gianluca@sottospazio.it> <1374859138-19467-4-git-send-email-gianluca@sottospazio.it>
In-Reply-To: <1374859138-19467-4-git-send-email-gianluca@sottospazio.it>
Content-Type: text/plain; charset=UTF-8; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

On 07/26/2013 01:18 PM, Gianluca Anzolin wrote:
> Move the tty_struct initialization from rfcomm_tty_open() to
> rfcomm_tty_install() and do the same for the cleanup moving the code from
> rfcomm_tty_close() to rfcomm_tty_cleanup().
>
> Add also extra error handling in rfcomm_tty_install() because, unlike
> .open()/.close(), .cleanup() is not called if .install() fails.
>
> Signed-off-by: Gianluca Anzolin <gianluca@sottospazio.it>
> ---
>   net/bluetooth/rfcomm/tty.c | 108 +++++++++++++++++++++++++++++----------------
>   1 file changed, 69 insertions(+), 39 deletions(-)
>
> diff --git a/net/bluetooth/rfcomm/tty.c b/net/bluetooth/rfcomm/tty.c
> index 9c0e142..bfaa444 100644
> --- a/net/bluetooth/rfcomm/tty.c
> +++ b/net/bluetooth/rfcomm/tty.c
> @@ -633,49 +633,64 @@ static void rfcomm_tty_copy_pending(struct rfcomm_dev *dev)
>   		tty_flip_buffer_push(&dev->port);
>   }
>
> -static int rfcomm_tty_open(struct tty_struct *tty, struct file *filp)
> +/* do the reverse of install, clearing the tty fields and releasing the
> + * reference to tty_port
> + */
> +static void rfcomm_tty_cleanup(struct tty_struct *tty)
> +{
> +	struct rfcomm_dev *dev = tty->driver_data;
> +
> +	if (dev->tty_dev->parent)
> +		device_move(dev->tty_dev, NULL, DPM_ORDER_DEV_LAST);
> +
> +	/* Close DLC and dettach TTY */
> +	rfcomm_dlc_close(dev->dlc, 0);
> +
> +	clear_bit(RFCOMM_TTY_ATTACHED, &dev->flags);
> +
> +	rfcomm_dlc_lock(dev->dlc);
> +	tty->driver_data = NULL;
> +	dev->port.tty = NULL;
> +	rfcomm_dlc_unlock(dev->dlc);
> +
> +	tty_port_put(&dev->port);
> +}
> +
> +/* we acquire the tty_port reference since it's here the tty is first used
> + * by setting the termios. We also populate the driver_data field and install
> + * the tty port
> + */
> +static int rfcomm_tty_install(struct tty_driver *driver, struct tty_struct *tty)
>   {
>   	DECLARE_WAITQUEUE(wait, current);
>   	struct rfcomm_dev *dev;
>   	struct rfcomm_dlc *dlc;
> -	unsigned long flags;
> -	int err, id;
> -
> -	id = tty->index;
> +	int err;
>
> -	BT_DBG("tty %p id %d", tty, id);
> -
> -	/* We don't leak this refcount. For reasons which are not entirely
> -	   clear, the TTY layer will call our ->close() method even if the
> -	   open fails. We decrease the refcount there, and decreasing it
> -	   here too would cause breakage. */
> -	dev = rfcomm_dev_get(id);
> +	dev = rfcomm_dev_get(tty->index);
>   	if (!dev)
>   		return -ENODEV;
>


>   	BT_DBG("dev %p dst %pMR channel %d opened %d", dev, &dev->dst,
>   	       dev->channel, dev->port.count);

This debug message is probably more useful in rfcomm_tty_open().
But if you decide to leave it here, the port count will always be 0 so
that field should be removed.

Regards,
Peter Hurley
