Return-Path: <cyrus@holtmann.org>
Message-ID: <1402906372.27142.77.camel@jrissane-mobl.ger.corp.intel.com>
Subject: Re: [PATCH v6 1/4] Bluetooth: 6LoWPAN: Use connected oriented
 channel instead of fixed one
From: Jukka Rissanen <jukka.rissanen@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Date: Mon, 16 Jun 2014 11:12:52 +0300
In-Reply-To: <1402664013-29358-2-git-send-email-jukka.rissanen@linux.intel.com>
References: <1402664013-29358-1-git-send-email-jukka.rissanen@linux.intel.com>
	 <1402664013-29358-2-git-send-email-jukka.rissanen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On pe, 2014-06-13 at 15:53 +0300, Jukka Rissanen wrote:
> Create a CoC dynamically instead of one fixed channel for communication
> to peer devices.
> 

> +static void chan_close(struct l2cap_chan *chan, int reason)
> +{
> +	l2cap_chan_lock(chan);
> +	l2cap_chan_close(chan, reason);
> +	l2cap_chan_unlock(chan);
> +	l2cap_chan_put(chan);
> +}
> +

This channel locking is wrong as I get locking errors and eventually the
kernel will freeze. I will send a new version fixing this.


Cheers,
Jukka


