Return-Path: <cyrus@holtmann.org>
Date: Wed, 10 Jul 2013 16:46:23 +0100
From: Gustavo Padovan <gustavo@padovan.org>
To: Gianluca Anzolin <gianluca@sottospazio.it>
Cc: marcel@holtmann.org, linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] Fix tty refcounting in rfcomm/tty.c
Message-ID: <20130710154623.GD2952@joana>
References: <20130709170502.GA32765@debian.seek.priv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130709170502.GA32765@debian.seek.priv>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gianluca,

* Gianluca Anzolin <gianluca@sottospazio.it> [2013-07-09 19:05:02 +0200]:

> In net/bluetooth/rfcomm/tty.c the struct tty is used without proper
> refcounting. This leads to OOPS and panics triggered by the tty layer functions
> which are invoked after the struct tty has already been destroyed.
> 
> This happens for example when the bluetooth connection is lost because the host
> goes down unexpectedly.
> 
> The fix uses the tty_port_* helpers already in place.
> 
> This patch depends on patch "Fix refcount leak in tty_port.c" already sent to
> linux-kernel. [0]
> 
> Signed-off-by: Gianluca Anzolin <gianluca@sottospazio.it>
> 
> [0] http://lkml.indiana.edu/hypermail/linux/kernel/1307.1/00600.html
> 

haven't looked into detail into these patches, but to get rfcomm patches
upstream you would first need the tty maintainer to accept this patch you are
mentioning since our side would depend on it. It seems to be a regression
caused by aa27a094e2c and your patch seems to be the right fix.


> --- linux/net/bluetooth/rfcomm/tty.c.orig	2013-07-09 18:10:09.071322663 +0200
> +++ linux/net/bluetooth/rfcomm/tty.c	2013-07-09 18:14:44.517783673 +0200
> @@ -333,10 +333,11 @@ static inline unsigned int rfcomm_room(s
>  static void rfcomm_wfree(struct sk_buff *skb)
>  {
>  	struct rfcomm_dev *dev = (void *) skb->sk;
> -	struct tty_struct *tty = dev->port.tty;
> +
>  	atomic_sub(skb->truesize, &dev->wmem_alloc);
> -	if (test_bit(RFCOMM_TTY_ATTACHED, &dev->flags) && tty)
> -		tty_wakeup(tty);
> +	if (test_bit(RFCOMM_TTY_ATTACHED, &dev->flags))
> +		tty_port_tty_wakeup(&dev->port);
> +
>  	tty_port_put(&dev->port);
>  }
>  
> @@ -410,6 +411,7 @@ static int rfcomm_release_dev(void __use
>  {
>  	struct rfcomm_dev_req req;
>  	struct rfcomm_dev *dev;
> +	struct tty_struct *tty;
>  
>  	if (copy_from_user(&req, arg, sizeof(req)))
>  		return -EFAULT;
> @@ -429,11 +431,15 @@ static int rfcomm_release_dev(void __use
>  		rfcomm_dlc_close(dev->dlc, 0);
>  
>  	/* Shut down TTY synchronously before freeing rfcomm_dev */
> -	if (dev->port.tty)
> -		tty_vhangup(dev->port.tty);
> +	tty = tty_port_tty_get(&dev->port);
> +	if (tty) {
> +		tty_vhangup(tty);
> +		tty_kref_put(tty);
> +	}
>  
>  	if (!test_bit(RFCOMM_RELEASE_ONHUP, &dev->flags))
>  		rfcomm_dev_del(dev);
> +

Please remove the extra blank line.

>  	tty_port_put(&dev->port);
>  	return 0;
>  }
> @@ -563,6 +569,7 @@ static void rfcomm_dev_data_ready(struct
>  static void rfcomm_dev_state_change(struct rfcomm_dlc *dlc, int err)
>  {
>  	struct rfcomm_dev *dev = dlc->owner;
> +	struct tty_struct *tty;
>  	if (!dev)
>  		return;
>  
> @@ -572,7 +579,8 @@ static void rfcomm_dev_state_change(stru
>  	wake_up_interruptible(&dev->wait);
>  
>  	if (dlc->state == BT_CLOSED) {
> -		if (!dev->port.tty) {
> +		tty = tty_port_tty_get(&dev->port);
> +		if (!tty) {
>  			if (test_bit(RFCOMM_RELEASE_ONHUP, &dev->flags)) {
>  				/* Drop DLC lock here to avoid deadlock
>  				 * 1. rfcomm_dev_get will take rfcomm_dev_lock
> @@ -591,8 +599,10 @@ static void rfcomm_dev_state_change(stru
>  				tty_port_put(&dev->port);
>  				rfcomm_dlc_lock(dlc);
>  			}
> -		} else
> -			tty_hangup(dev->port.tty);
> +		} else {
> +			tty_hangup(tty);
> +			tty_kref_put(tty);
> +		}

Shouldn't we be using tty_port_tyy_hangup?

>  	}
>  }
>  
> @@ -604,10 +614,8 @@ static void rfcomm_dev_modem_status(stru
>  
>  	BT_DBG("dlc %p dev %p v24_sig 0x%02x", dlc, dev, v24_sig);
>  
> -	if ((dev->modem_status & TIOCM_CD) && !(v24_sig & RFCOMM_V24_DV)) {
> -		if (dev->port.tty && !C_CLOCAL(dev->port.tty))
> -			tty_hangup(dev->port.tty);
> -	}
> +	if ((dev->modem_status & TIOCM_CD) && !(v24_sig & RFCOMM_V24_DV))
> +		tty_port_tty_hangup(&dev->port, true);
>  
>  	dev->modem_status =
>  		((v24_sig & RFCOMM_V24_RTC) ? (TIOCM_DSR | TIOCM_DTR) : 0) |
> @@ -674,7 +682,7 @@ static int rfcomm_tty_open(struct tty_st
>  
>  	rfcomm_dlc_lock(dlc);
>  	tty->driver_data = dev;
> -	dev->port.tty = tty;
> +	tty_port_tty_set(&dev->port, tty);
>  	rfcomm_dlc_unlock(dlc);
>  	set_bit(RFCOMM_TTY_ATTACHED, &dev->flags);
>  
> @@ -742,7 +750,7 @@ static void rfcomm_tty_close(struct tty_
>  
>  		rfcomm_dlc_lock(dev->dlc);
>  		tty->driver_data = NULL;
> -		dev->port.tty = NULL;
> +		tty_port_tty_set(&dev->port, NULL);
>  		rfcomm_dlc_unlock(dev->dlc);
>  
>  		if (test_bit(RFCOMM_TTY_RELEASED, &dev->flags)) {


	Gustavo
