Return-Path: <cyrus@holtmann.org>
Message-ID: <51E5B259.2090501@hurleysoftware.com>
Date: Tue, 16 Jul 2013 16:51:37 -0400
From: Peter Hurley <peter@hurleysoftware.com>
MIME-Version: 1.0
To: Gianluca Anzolin <gianluca@sottospazio.it>
CC: gustavo@padovan.org, linux-bluetooth@vger.kernel.org,
 marcel@holtmann.org
Subject: Re: [PATCH 5/8] Use the tty_port_* functions in tty_open/tty_close/tty_hangup
References: <1373661649-1385-1-git-send-email-gianluca@sottospazio.it> <1373661649-1385-5-git-send-email-gianluca@sottospazio.it>
In-Reply-To: <1373661649-1385-5-git-send-email-gianluca@sottospazio.it>
Content-Type: text/plain; charset=UTF-8; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

On 07/12/2013 04:40 PM, Gianluca Anzolin wrote:
> Use the tty_port_open tty_port_close and tty_port_hangup functions that manage
> properly the port.count and the tty_port operations.

Please merge this patch with 'Move device initialization and shutdown...".
See comments below.

> Signed-off-by: Gianluca Anzolin <gianluca@sottospazio.it>
> ---
>   net/bluetooth/rfcomm/tty.c | 35 +++++------------------------------
>   1 file changed, 5 insertions(+), 30 deletions(-)
>
> diff --git a/net/bluetooth/rfcomm/tty.c b/net/bluetooth/rfcomm/tty.c
> index c1dd55d..c8ef06d 100644
> --- a/net/bluetooth/rfcomm/tty.c
> +++ b/net/bluetooth/rfcomm/tty.c
> @@ -766,47 +766,23 @@ static void rfcomm_tty_cleanup(struct tty_struct *tty)
>   static int rfcomm_tty_open(struct tty_struct *tty, struct file *filp)
>   {
>   	struct rfcomm_dev *dev = tty->driver_data;
> -	unsigned long flags;
> -	int id;
> -
> -	id = tty->index;
>
> -	BT_DBG("tty %p id %d", tty, id);
> +	BT_DBG("tty %p id %d", tty, tty->index);
>
>   	BT_DBG("dev %p dst %pMR channel %d opened %d", dev, &dev->dst,
>   	       dev->channel, dev->port.count);
>
> -	spin_lock_irqsave(&dev->port.lock, flags);
> -	if (++dev->port.count > 1) {
> -		spin_unlock_irqrestore(&dev->port.lock, flags);
> -		return 0;
> -	}
> -	spin_unlock_irqrestore(&dev->port.lock, flags);
> -
> -	return 0;
> +	return tty_port_open(&dev->port, tty, filp);

As noted in my review of patch 3/8, this needs to be in the patch which
introduces the .activate() port method to maintain bisectability.

>   }
>
>   static void rfcomm_tty_close(struct tty_struct *tty, struct file *filp)
>   {
>   	struct rfcomm_dev *dev = (struct rfcomm_dev *) tty->driver_data;
> -	unsigned long flags;
>
>   	BT_DBG("tty %p dev %p dlc %p opened %d", tty, dev, dev->dlc,
>   						dev->port.count);
>
> -	spin_lock_irqsave(&dev->port.lock, flags);
> -	if (!--dev->port.count) {
> -		spin_unlock_irqrestore(&dev->port.lock, flags);
> -
> -		if (test_bit(RFCOMM_TTY_RELEASED, &dev->flags)) {
> -			spin_lock(&rfcomm_dev_lock);
> -			list_del_init(&dev->list);
> -			spin_unlock(&rfcomm_dev_lock);

Removal from the rfcomm_dev_list should be in a separate patch
with the list node removal in the rfcomm dev destructor from
patch 6/8.

> -
> -			tty_port_put(&dev->port);
> -		}
> -	} else
> -		spin_unlock_irqrestore(&dev->port.lock, flags);
> +	tty_port_close(&dev->port, tty, filp);

As with the tty_port_open(), this hunk needs to be in the patch which
introduces the .shutdown() port method to maintain bisectability.

>   }
>
>   static int rfcomm_tty_write(struct tty_struct *tty, const unsigned char *buf, int count)
> @@ -1106,11 +1082,10 @@ static void rfcomm_tty_hangup(struct tty_struct *tty)
>
>   	BT_DBG("tty %p dev %p", tty, dev);
>
> -	if (!dev)
> -		return;
> -
>   	rfcomm_tty_flush_buffer(tty);
>
> +	tty_port_hangup(&dev->port);
> +

Same as above.

>   	if (test_bit(RFCOMM_RELEASE_ONHUP, &dev->flags)) {
>   		if (rfcomm_dev_get(dev->id) == NULL)
>   			return;
>
