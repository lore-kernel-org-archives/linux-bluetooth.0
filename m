Return-Path: <cyrus@holtmann.org>
Date: Mon, 14 Feb 2011 12:49:31 -0200
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: =?utf-8?B?0JLQu9Cw0LTQuNGB0LvQsNCy?= <vladisslav@inbox.ru>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: rfcomm: Release BTM while sleeping to avoid
 deadlock.
Message-ID: <20110214144931.GD2597@joana>
References: <E1PoQLR-0008E5-00.vladisslav-inbox-ru@f68.mail.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <E1PoQLR-0008E5-00.vladisslav-inbox-ru@f68.mail.ru>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi 

* Владислав <vladisslav@inbox.ru> [2011-02-13 04:01:45 +0300]:

> Bug description:
> Kernel freezes for ~2 seconds after trying to access /dev/rfcommX device.
> Steps to reproduce:
> 1. Edit /etc/bluetooth/rfcomm.conf - uncomment default config, set "bind" to "yes".
> 2. Issue "sudo rfcomm bind all" to create /dev/rfcomm0 device node.
> 3. Issue "cat /dev/rfcomm0" to trigger a bug.
> Everything freezes (at least GUI): cursor does not move, no response from
> keypresses, no gui redraw for 2~3 seconds.
> Then cat displays expected error message "cat: /dev/rfcomm0: Host is down"
> and system starts to respond again.
> What expected (and occurs with 2.6.35) : no freeze between cat and error message.
> Things goes worse when device, mentioned in /etc/bluetooth/rfcomm.conf
> is in range and not paired - system displays pairing request and locks
> up for a longer time, maybe completely - I did not wait longer than ~30
> seconds and turned off bluetooth device.
> 
> Fix:
> Release BTM while sleeping to avoid deadlock.
> 
> diff --git a/net/bluetooth/rfcomm/tty.c b/net/bluetooth/rfcomm/tty.c
> index 2575c2d..d7b9af4 100644
> --- a/net/bluetooth/rfcomm/tty.c
> +++ b/net/bluetooth/rfcomm/tty.c
> @@ -727,7 +727,9 @@ static int rfcomm_tty_open(struct tty_struct *tty, struct file *filp)
>  			break;
>  		}
>  
> +		tty_unlock();
>  		schedule();
> +		tty_lock();
>  	}
>  	set_current_state(TASK_RUNNING);
>  	remove_wait_queue(&dev->wait, &wait);

I've faced this issue some days ago and your patch looks good. But I need
proper git patch with your Signed-off-by line.

-- 
Gustavo F. Padovan
http://profusion.mobi
