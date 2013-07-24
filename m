Return-Path: <cyrus@holtmann.org>
Message-ID: <51F04F5A.5000602@hurleysoftware.com>
Date: Wed, 24 Jul 2013 18:04:10 -0400
From: Peter Hurley <peter@hurleysoftware.com>
MIME-Version: 1.0
To: Gianluca Anzolin <gianluca@sottospazio.it>
CC: linux-bluetooth@vger.kernel.org, gustavo@padovan.org,
	marcel@holtmann.org
Subject: Re: [PATCH v2 5/7] rfcomm: Remove the device from the dev_list in
 the destructor
References: <1374510435-12149-1-git-send-email-gianluca@sottospazio.it> <1374510435-12149-5-git-send-email-gianluca@sottospazio.it>
In-Reply-To: <1374510435-12149-5-git-send-email-gianluca@sottospazio.it>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On 07/22/2013 12:27 PM, Gianluca Anzolin wrote:
> Remove the device from rfcomm_dev_list in the tty_port destructor.
>
> Signed-off-by: Gianluca Anzolin <gianluca@sottospazio.it>
> ---
>   net/bluetooth/rfcomm/tty.c | 27 ++++++---------------------
>   1 file changed, 6 insertions(+), 21 deletions(-)
>
> diff --git a/net/bluetooth/rfcomm/tty.c b/net/bluetooth/rfcomm/tty.c
> index 1258678..17e5faa 100644
> --- a/net/bluetooth/rfcomm/tty.c
> +++ b/net/bluetooth/rfcomm/tty.c
> @@ -75,13 +75,6 @@ static void rfcomm_dev_modem_status(struct rfcomm_dlc *dlc, u8 v24_sig);
>
>   /* ---- Device functions ---- */
>
> -/*
> - * The reason this isn't actually a race, as you no doubt have a little voice
> - * screaming at you in your head, is that the refcount should never actually
> - * reach zero unless the device has already been taken off the list, in
> - * rfcomm_dev_del(). And if that's not true, we'll hit the BUG() in
> - * rfcomm_dev_destruct() anyway.
> - */
>   static void rfcomm_dev_destruct(struct tty_port *port)
>   {
>   	struct rfcomm_dev *dev = container_of(port, struct rfcomm_dev, port);
> @@ -89,10 +82,9 @@ static void rfcomm_dev_destruct(struct tty_port *port)
>
>   	BT_DBG("dev %p dlc %p", dev, dlc);
>
> -	/* Refcount should only hit zero when called from rfcomm_dev_del()
> -	   which will have taken us off the list. Everything else are
> -	   refcounting bugs. */
> -	BUG_ON(!list_empty(&dev->list));
> +	spin_lock(&rfcomm_dev_lock);
> +	list_del(&dev->list);
> +	spin_unlock(&rfcomm_dev_lock);
>
>   	rfcomm_dlc_lock(dlc);
>   	/* Detach DLC if it's owned by this dev */
> @@ -295,7 +287,9 @@ out:
>   			dev->id, NULL);
>   	if (IS_ERR(dev->tty_dev)) {
>   		err = PTR_ERR(dev->tty_dev);
> +		spin_lock(&rfcomm_dev_lock);
>   		list_del(&dev->list);
> +		spin_unlock(&rfcomm_dev_lock);
>   		goto free;
>   	}
>
> @@ -328,10 +322,6 @@ static void rfcomm_dev_del(struct rfcomm_dev *dev)
>   	}
>   	spin_unlock_irqrestore(&dev->port.lock, flags);
>
> -	spin_lock(&rfcomm_dev_lock);
> -	list_del_init(&dev->list);
> -	spin_unlock(&rfcomm_dev_lock);
> -
>   	tty_port_put(&dev->port);
>   }
>
> @@ -753,13 +743,8 @@ static void rfcomm_tty_close(struct tty_struct *tty, struct file *filp)
>
>   	tty_port_close(&dev->port, tty, filp);
>
> -	if (test_bit(RFCOMM_TTY_RELEASED, &dev->flags)) {
> -		spin_lock(&rfcomm_dev_lock);
> -		list_del_init(&dev->list);
> -		spin_unlock(&rfcomm_dev_lock);
> -

Gianluca,

I think you may have missed my comment that this patch should
be earlier in the series. That way you wouldn't be adding code
in 4/7 that you're removing here.

Regards,
Peter Hurley


> +	if (test_bit(RFCOMM_TTY_RELEASED, &dev->flags))
>   		tty_port_put(&dev->port);
> -	}
>   }
>
>   static int rfcomm_tty_write(struct tty_struct *tty, const unsigned char *buf, int count)
>

