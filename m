Return-Path: <cyrus@holtmann.org>
Message-ID: <51E5B196.7010704@hurleysoftware.com>
Date: Tue, 16 Jul 2013 16:48:22 -0400
From: Peter Hurley <peter@hurleysoftware.com>
MIME-Version: 1.0
To: Gianluca Anzolin <gianluca@sottospazio.it>
CC: gustavo@padovan.org, linux-bluetooth@vger.kernel.org,
 marcel@holtmann.org
Subject: Re: [PATCH 3/8] Move device initialization and shutdown to tty_port_operations
References: <1373661649-1385-1-git-send-email-gianluca@sottospazio.it> <1373661649-1385-3-git-send-email-gianluca@sottospazio.it>
In-Reply-To: <1373661649-1385-3-git-send-email-gianluca@sottospazio.it>
Content-Type: text/plain; charset=UTF-8; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

On 07/12/2013 04:40 PM, Gianluca Anzolin wrote:
> Move the device initialization from rfcomm_tty_open to the .activate function of
> tty_port.
>
> At the same time move also the device shutdown from rfcomm_tty_close to the
> .shutdown function of tty_port.

This patch should be merged with patch 5/8 to maintain bisectability.
Otherwise, the .activate() and .shutdown() methods will not be called.


> Signed-off-by: Gianluca Anzolin <gianluca@sottospazio.it>
> ---
>   net/bluetooth/rfcomm/tty.c | 120 ++++++++++++++++++++++++++++-----------------
>   1 file changed, 75 insertions(+), 45 deletions(-)
>
> diff --git a/net/bluetooth/rfcomm/tty.c b/net/bluetooth/rfcomm/tty.c
> index ff60171..9b0b064 100644
> --- a/net/bluetooth/rfcomm/tty.c
> +++ b/net/bluetooth/rfcomm/tty.c
> @@ -149,8 +149,80 @@ static void rfcomm_tty_copy_pending(struct rfcomm_dev *dev)
>   		tty_flip_buffer_push(&dev->port);
>   }
>
> +/*
> + * Do the device-specific initialization by opening the DLC and waiting for
> + * a connection.
> + */
> +static int rfcomm_dev_activate(struct tty_port *port, struct tty_struct *tty)
> +{
> +	DECLARE_WAITQUEUE(wait, current);
> +	struct rfcomm_dev *dev = container_of(port, struct rfcomm_dev, port);
> +	struct rfcomm_dlc *dlc = dev->dlc;
> +	int err;
> +
> +	err = rfcomm_dlc_open(dlc, &dev->src, &dev->dst, dev->channel);
> +	if (err < 0)
> +		goto error_no_dlc;
> +
> +	/* Wait for DLC to connect */
> +	add_wait_queue(&dev->wait, &wait);
> +	while (1) {
> +		set_current_state(TASK_INTERRUPTIBLE);
> +


> +		if (dlc->state == BT_CLOSED) {
> +			err = -dev->err;
> +			break;
> +		}
> +
> +		if (dlc->state == BT_CONNECTED)
> +			break;

Please consider moving these dlc->state tests into a
.carrier_raised() port method (this is what the gsm
driver does). Then this wait loop could go away.


> +
> +		if (signal_pending(current)) {
> +			err = -EINTR;
> +			break;
> +		}
> +
> +		tty_unlock(tty);
> +		schedule();
> +		tty_lock(tty);
> +	}
> +	set_current_state(TASK_RUNNING);
> +	remove_wait_queue(&dev->wait, &wait);
> +
> +	if (err < 0)
> +		goto error_no_connection;
> +
> +	device_move(dev->tty_dev, rfcomm_get_device(dev),
> +	            DPM_ORDER_DEV_AFTER_PARENT);
> +
> +	rfcomm_tty_copy_pending(dev);
> +	rfcomm_dlc_unthrottle(dlc);
> +	return 0;
> +
> +error_no_connection:
> +	rfcomm_dlc_close(dlc, err);
> +error_no_dlc:
> +	return err;
> +}
> +
> +/*
> + * Undo the device initialization by closing the DLC
> + */
> +static void rfcomm_dev_shutdown(struct tty_port *port)
> +{
> +	struct rfcomm_dev *dev = container_of(port, struct rfcomm_dev, port);
> +
> +	if (dev->tty_dev->parent)
> +		device_move(dev->tty_dev, NULL, DPM_ORDER_DEV_LAST);
> +
> +	/* Close DLC */
> +	rfcomm_dlc_close(dev->dlc, 0);
> +}
> +
>   static const struct tty_port_operations rfcomm_port_ops = {
>   	.destruct = rfcomm_dev_destruct,
> +	.activate = rfcomm_dev_activate,
> +	.shutdown = rfcomm_dev_shutdown,
>   };
>
>   static struct rfcomm_dev *__rfcomm_dev_get(int id)
> @@ -647,11 +719,10 @@ static void rfcomm_dev_modem_status(struct rfcomm_dlc *dlc, u8 v24_sig)
>   /* ---- TTY functions ---- */
>   static int rfcomm_tty_open(struct tty_struct *tty, struct file *filp)
>   {
> -	DECLARE_WAITQUEUE(wait, current);
>   	struct rfcomm_dev *dev;
>   	struct rfcomm_dlc *dlc;
>   	unsigned long flags;
> -	int err, id;
> +	int id;
>
>   	id = tty->index;
>
> @@ -685,44 +756,7 @@ static int rfcomm_tty_open(struct tty_struct *tty, struct file *filp)
>   	rfcomm_dlc_unlock(dlc);
>   	set_bit(RFCOMM_TTY_ATTACHED, &dev->flags);
>
> -	err = rfcomm_dlc_open(dlc, &dev->src, &dev->dst, dev->channel);
> -	if (err < 0)
> -		return err;
> -
> -	/* Wait for DLC to connect */
> -	add_wait_queue(&dev->wait, &wait);
> -	while (1) {
> -		set_current_state(TASK_INTERRUPTIBLE);
> -
> -		if (dlc->state == BT_CLOSED) {
> -			err = -dev->err;
> -			break;
> -		}
> -
> -		if (dlc->state == BT_CONNECTED)
> -			break;
> -
> -		if (signal_pending(current)) {
> -			err = -EINTR;
> -			break;
> -		}
> -
> -		tty_unlock(tty);
> -		schedule();
> -		tty_lock(tty);
> -	}
> -	set_current_state(TASK_RUNNING);
> -	remove_wait_queue(&dev->wait, &wait);
> -
> -	if (err == 0)
> -		device_move(dev->tty_dev, rfcomm_get_device(dev),
> -			    DPM_ORDER_DEV_AFTER_PARENT);
> -
> -	rfcomm_tty_copy_pending(dev);
> -
> -	rfcomm_dlc_unthrottle(dev->dlc);
> -
> -	return err;
> +	return 0;
>   }
>
>   static void rfcomm_tty_close(struct tty_struct *tty, struct file *filp)
> @@ -739,12 +773,8 @@ static void rfcomm_tty_close(struct tty_struct *tty, struct file *filp)
>   	spin_lock_irqsave(&dev->port.lock, flags);
>   	if (!--dev->port.count) {
>   		spin_unlock_irqrestore(&dev->port.lock, flags);
> -		if (dev->tty_dev->parent)
> -			device_move(dev->tty_dev, NULL, DPM_ORDER_DEV_LAST);
> -
> -		/* Close DLC and dettach TTY */
> -		rfcomm_dlc_close(dev->dlc, 0);
>
> +		/* detach the TTY */
>   		clear_bit(RFCOMM_TTY_ATTACHED, &dev->flags);
>
>   		rfcomm_dlc_lock(dev->dlc);
>
