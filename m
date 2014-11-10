Return-Path: <cyrus@holtmann.org>
Date: Mon, 10 Nov 2014 23:08:35 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 3/3] Bluetooth: Trigger SMP for the appropriate LE CoC
 errors
Message-ID: <20141110210835.GA3944@t440s.P-661HNU-F1>
References: <1415618695-21363-1-git-send-email-johan.hedberg@gmail.com>
 <1415618695-21363-4-git-send-email-johan.hedberg@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1415618695-21363-4-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Mon, Nov 10, 2014, johan.hedberg@gmail.com wrote:
> +		/* smp_conn_security() will call l2cap_chan_lock() -
> +		 * never for any CoC channel but only for the SMP
> +		 * channel. However, this will still trigger lockdep
> +		 * warnings of recursive locking, so to avoid these
> +		 * unlock the channel here instead of after the call to
> +		 * smp_conn_security().
> +		 */
> +		sec_level = chan->sec_level;
> +		l2cap_chan_unlock(chan);
> +
> +		smp_conn_security(hcon, sec_level);
> +		goto unlock;

It's might be possible to avoid this "hack" by using nested locking
annotation, so you might want to hold off with this patch for now.

I'm right now experimenting in making the rather simple change of using
mutex_lock_nested(&chan->lock, chan->chan_type) in l2cap_chan_lock() to
classify channels into separate groups based on their type. This should
allow simultaneous CoC and SMP (fixed channel) lock acquisition without
getting (false positive) warnings from lockdep.

Johan
