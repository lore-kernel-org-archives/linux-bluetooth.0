Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 2/4] android/health: Remove mcl instance on mcl_disconnected call back
Date: Tue, 19 Aug 2014 18:43:53 +0200
Message-ID: <5832975.EmNLQ3qPM9@leonov>
In-Reply-To: <1408352822-21572-2-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1408352822-21572-1-git-send-email-ravikumar.veeramally@linux.intel.com> <1408352822-21572-2-git-send-email-ravikumar.veeramally@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ravi,

On Monday 18 of August 2014 12:07:00 Ravi kumar Veeramally wrote:
> MCAP library is maintaining two sets of mcl list. On mcl_disconnected
> call mcl instance is removed from regular mcl list and cached in mcl_cache
> list. health.c doesn't maintain any cached mcls list. So mcl_conn variable
> doesn't make any sense of not being connected on mcl_disconnected call back.
> So unref mcl on mcl_disconnected and don't do anything in mcl_unached
> callback. ---
>  android/health.c | 18 ++++--------------
>  1 file changed, 4 insertions(+), 14 deletions(-)
> 
> diff --git a/android/health.c b/android/health.c
> index f86fd26..361b043 100644
> --- a/android/health.c
> +++ b/android/health.c
> @@ -85,7 +85,6 @@ struct health_device {
>  	uint16_t app_id;
> 
>  	struct mcap_mcl *mcl;
> -	bool mcl_conn;
> 
>  	struct queue *channels;     /* data channels */
> 
> @@ -193,7 +192,6 @@ static void unref_mcl(struct health_device *dev)
>  	mcap_close_mcl(dev->mcl, FALSE);
>  	mcap_mcl_unref(dev->mcl);
>  	dev->mcl = NULL;
> -	dev->mcl_conn = false;
>  }
> 
>  static void free_health_device(void *data)
> @@ -1824,7 +1822,6 @@ static void create_mcl_cb(struct mcap_mcl *mcl, GError
> *err, gpointer data) if (!channel->dev->mcl)
>  		channel->dev->mcl = mcap_mcl_ref(mcl);
> 
> -	channel->dev->mcl_conn = true;
>  	info("MCL connected");
> 
>  	ret = set_mcl_cb(channel->dev->mcl, channel, &gerr);
> @@ -1949,7 +1946,7 @@ static void bt_health_connect_channel(const void *buf,
> uint16_t len) }
>  	}
> 
> -	if (!dev->mcl || (dev->mcl && !dev->mcl_conn)) {
> +	if (!dev->mcl) {
>  		if (connect_mcl(channel) < 0) {
>  			error("health: error retrieving HDP SDP record");
>  			goto fail;
> @@ -2069,8 +2066,6 @@ static void mcl_reconnected(struct mcap_mcl *mcl,
> gpointer data) error("device data does not exists");
>  		return;
>  	}
> -
> -	dev->mcl_conn = true;
>  }
> 
>  static void mcl_disconnected(struct mcap_mcl *mcl, gpointer data)
> @@ -2080,18 +2075,13 @@ static void mcl_disconnected(struct mcap_mcl *mcl,
> gpointer data) DBG("");
> 
>  	dev = search_dev_by_mcl(mcl);
> -	if (dev)
> -		dev->mcl_conn = false;
> +	mcap_mcl_unref(dev->mcl);
> +	dev->mcl = NULL;

So, previously dev was check for NULL before accessing it. Now it is not.
Is this always true that dev is not NULL here?

>  }
> 
>  static void mcl_uncached(struct mcap_mcl *mcl, gpointer data)
>  {
> -	struct health_device *dev;
> -
> -	DBG("");
> -
> -	dev = search_dev_by_mcl(mcl);
> -	free_health_device(dev);
> +	/* mcap library maintains cache of mcls, not required here*/
>  }
> 
>  bool bt_health_register(struct ipc *ipc, const bdaddr_t *addr, uint8_t
> mode)

-- 
BR
Szymon Janc
