Return-Path: <linux-wpan-owner@vger.kernel.org>
Message-ID: <1492005420.2926.17.camel@linux.intel.com>
Subject: Re: [PATCH 3/6] Bluetooth: 6lowpan: Use netif APIs to flow control
From: Jukka Rissanen <jukka.rissanen@linux.intel.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org
Cc: patrik.flykt@linux.intel.com, aar@pengutronix.de,
        linux-wpan@vger.kernel.org
Date: Wed, 12 Apr 2017 16:57:00 +0300
In-Reply-To: <20170411192103.3209-3-luiz.dentz@gmail.com>
References: <20170411192103.3209-1-luiz.dentz@gmail.com>
         <20170411192103.3209-3-luiz.dentz@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,


On Tue, 2017-04-11 at 22:21 +0300, Luiz Augusto von Dentz wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> Rely on netif_wake_queue and netif_stop_queue to flow control when
> transmit resources are unavailable.
> 
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
>  net/bluetooth/6lowpan.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
> index 22bd936..dc7fda3 100644
> --- a/net/bluetooth/6lowpan.c
> +++ b/net/bluetooth/6lowpan.c
> @@ -867,12 +867,28 @@ static struct sk_buff *chan_alloc_skb_cb(struct
> l2cap_chan *chan,
>  
>  static void chan_suspend_cb(struct l2cap_chan *chan)
>  {
> +	struct lowpan_btle_dev *dev;
> +
>  	BT_DBG("chan %p suspend", chan);
> +
> +	dev = lookup_dev(chan->conn);
> +	if (!dev || !dev->netdev)
> +		return;
> +
> +	netif_stop_queue(dev->netdev);
>  }
>  
>  static void chan_resume_cb(struct l2cap_chan *chan)
>  {
> +	struct lowpan_btle_dev *dev;
> +
>  	BT_DBG("chan %p resume", chan);
> +
> +	dev = lookup_dev(chan->conn);
> +	if (!dev || !dev->netdev)
> +		return;
> +
> +	netif_wake_queue(dev->netdev);
>  }
>  
>  static long chan_get_sndtimeo_cb(struct l2cap_chan *chan)


Acked-by: Jukka Rissanen <jukka.rissanen@linux.intel.com>


Cheers,
Jukka


