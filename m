Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ 1/4] android/AVRCP: Add bt_avrcp_connect
Date: Wed, 05 Feb 2014 14:45:24 +0100
Message-ID: <3704081.mts43YWsci@uw000953>
In-Reply-To: <1391596020-27679-1-git-send-email-luiz.dentz@gmail.com>
References: <1391596020-27679-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Wednesday 05 of February 2014 12:26:57 Luiz Augusto von Dentz wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This adds bt_avrcp_connect function which can be used to request AVRCP
> connections.
> ---
>  android/avrcp.c | 60 ++++++++++++++++++++++++++++++++++++++++++++++++++++-----
>  android/avrcp.h |  2 ++
>  2 files changed, 57 insertions(+), 5 deletions(-)
> 
> diff --git a/android/avrcp.c b/android/avrcp.c
> index ef833df..8600d98 100644
> --- a/android/avrcp.c
> +++ b/android/avrcp.c
> @@ -54,6 +54,7 @@ static GIOChannel *server = NULL;
>  struct avrcp_device {
>  	bdaddr_t	dst;
>  	struct avctp	*session;
> +	GIOChannel	*io;
>  };
>  
>  static const struct ipc_handler cmd_handlers[] = {
> @@ -197,17 +198,20 @@ static void connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
>  	}
>  
>  	ba2str(&dst, address);
> -	DBG("Incoming connection from %s", address);
>  
>  	l = g_slist_find_custom(devices, &dst, device_cmp);
>  	if (l) {
> -		error("Unexpected connection");
> -		return;
> +		dev = l->data;
> +		if (dev->session) {
> +			error("Unexpected connection");
> +			return;
> +		}
> +	} else {
> +		DBG("Incoming connection from %s", address);
> +		dev = avrcp_device_new(&dst);
>  	}
>  
>  	fd = g_io_channel_unix_get_fd(chan);
> -
> -	dev = avrcp_device_new(&dst);
>  	dev->session = avctp_new(fd, imtu, omtu, 0x0100);
>  
>  	if (!dev->session) {
> @@ -222,6 +226,11 @@ static void connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
>  
>  	g_io_channel_set_close_on_unref(chan, FALSE);
>  
> +	if (dev->io) {
> +		g_io_channel_unref(dev->io);
> +		dev->io = NULL;
> +	}
> +
>  	DBG("%s connected", address);
>  }
>  
> @@ -288,3 +297,44 @@ void bt_avrcp_unregister(void)
>  		server = NULL;
>  	}
>  }
> +
> +static bool avrcp_device_connect(struct avrcp_device *dev, BtIOConnect cb)
> +{
> +	GError *err = NULL;
> +
> +	dev->io = bt_io_connect(cb, dev, NULL, &err,
> +					BT_IO_OPT_SOURCE_BDADDR, &adapter_addr,
> +					BT_IO_OPT_DEST_BDADDR, &dev->dst,
> +					BT_IO_OPT_PSM, L2CAP_PSM_AVCTP,
> +					BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_MEDIUM,
> +					BT_IO_OPT_INVALID);
> +	if (err) {
> +		error("%s", err->message);
> +		g_error_free(err);
> +		return false;
> +	}
> +
> +	return true;
> +}
> +
> +void bt_avrcp_connect(const bdaddr_t *dst)
> +{
> +	struct avrcp_device *dev;
> +	char addr[18];
> +	GSList *l;
> +
> +	DBG("");
> +
> +	l = g_slist_find_custom(devices, dst, device_cmp);
> +	if (l)
> +		return;
> +
> +	dev = avrcp_device_new(dst);
> +	if (!avrcp_device_connect(dev, connect_cb)) {
> +		avrcp_device_free(dev);
> +		return;
> +	}
> +
> +	ba2str(&dev->dst, addr);
> +	DBG("connecting to %s", addr);
> +}
> diff --git a/android/avrcp.h b/android/avrcp.h
> index 6fe7fbf..7b0a5ed 100644
> --- a/android/avrcp.h
> +++ b/android/avrcp.h
> @@ -23,3 +23,5 @@
>  
>  bool bt_avrcp_register(const bdaddr_t *addr);
>  void bt_avrcp_unregister(void);
> +
> +void bt_avrcp_connect(const bdaddr_t *dst);
> 

All four patches applied, thanks.

-- 
Best regards, 
Szymon Janc
