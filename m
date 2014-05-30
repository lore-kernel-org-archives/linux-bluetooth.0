Return-Path: <cyrus@holtmann.org>
Message-ID: <1401437509.2400.40.camel@jrissane-mobl.ger.corp.intel.com>
Subject: Re: [PATCH v3 5/6] Bluetooth: 6LoWPAN: Count module usage
From: Jukka Rissanen <jukka.rissanen@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Date: Fri, 30 May 2014 11:11:49 +0300
In-Reply-To: <1401277388-4611-6-git-send-email-jukka.rissanen@linux.intel.com>
References: <1401277388-4611-1-git-send-email-jukka.rissanen@linux.intel.com>
	 <1401277388-4611-6-git-send-email-jukka.rissanen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On ke, 2014-05-28 at 14:43 +0300, Jukka Rissanen wrote:
> Count how many 6LoWPAN connections there exists so that we
> do not unload the module if there are still connections alive.
> 
> Signed-off-by: Jukka Rissanen <jukka.rissanen@linux.intel.com>
> ---
>  net/bluetooth/6lowpan.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
> index 79e753b..5028b2e 100644
> --- a/net/bluetooth/6lowpan.c
> +++ b/net/bluetooth/6lowpan.c
> @@ -103,6 +103,8 @@ static inline bool peer_del(struct lowpan_dev *dev, struct lowpan_peer *peer)
>  
>  	if (atomic_dec_and_test(&dev->peer_count)) {
>  		BT_DBG("last peer");
> +
> +		module_put(THIS_MODULE);

Ouch, this module_put() is in wrong place. We should decrement the
module count always when we delete the peer.


>  		return true;
>  	}
>  
> @@ -728,6 +730,9 @@ static inline void bt_6lowpan_chan_ready_cb(struct l2cap_chan *chan)
>  		}
>  	}
>  
> +	if (!try_module_get(THIS_MODULE))
> +		return;
> +
>  	add_peer_chan(chan, dev);
>  	ifup(dev->netdev);
>  }


Cheers,
Jukka


