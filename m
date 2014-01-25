Return-Path: <cyrus@holtmann.org>
Date: Sat, 25 Jan 2014 18:08:45 -0500
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 2/3] Bluetooth: Fix freeing l2cap_chan while it's locked
Message-ID: <20140125230845.GA16167@x220.p-661hnu-f1>
References: <1390687809-14408-1-git-send-email-johan.hedberg@gmail.com>
 <1390687809-14408-2-git-send-email-johan.hedberg@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1390687809-14408-2-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Sat, Jan 25, 2014, johan.hedberg@gmail.com wrote:
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -442,10 +442,14 @@ static void l2cap_chan_destroy(struct kref *kref)
>  
>  	BT_DBG("chan %p", chan);
>  
> +	l2cap_chan_lock(chan);
> +
>  	write_lock(&chan_list_lock);
>  	list_del(&chan->global_l);
>  	write_unlock(&chan_list_lock);
>  
> +	l2cap_chan_unlock(chan);
> +
>  	kfree(chan);
>  }

Please hold on a bit with this patch. The other two in the set should be
good to go though.

Since the race is hard to reproduce I'm not 100% sure this actually
fixes it. Looking at l2cap_get_chan_by_scid holding the lock should not
prevent it from returning the channel.

Johan
