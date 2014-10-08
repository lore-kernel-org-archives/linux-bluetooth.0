Return-Path: <cyrus@holtmann.org>
Date: Wed, 8 Oct 2014 11:30:05 +0300
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 13/13] android/handsfree: Make remote device non-static
Message-ID: <20141008083003.GD429@aemeltch-MOBL1>
References: <1412752343-7001-1-git-send-email-szymon.janc@tieto.com>
 <1412752343-7001-13-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1412752343-7001-13-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Wed, Oct 08, 2014 at 09:12:23AM +0200, Szymon Janc wrote:
> Remote device object is now created on-demand instead of being static.
> ---
>  android/handsfree.c | 144 +++++++++++++++++++++++++++++++---------------------
>  1 file changed, 86 insertions(+), 58 deletions(-)
> 
> diff --git a/android/handsfree.c b/android/handsfree.c
> index 58eade4..2e617f6 100644
> --- a/android/handsfree.c
> +++ b/android/handsfree.c
> @@ -37,6 +37,8 @@
>  #include "src/sdp-client.h"
>  #include "src/uuid-helper.h"
>  #include "src/shared/hfp.h"
> +#include "src/shared/queue.h"
> +#include "src/shared/util.h"
>  #include "btio/btio.h"
>  #include "hal-msg.h"
>  #include "ipc-common.h"
> @@ -155,7 +157,7 @@ static const struct hfp_codec codecs_defaults[] = {
>  	{ CODEC_ID_MSBC, false, false},
>  };
>  
> -static struct hf_device device;
> +static struct queue *devices = NULL;
>  
>  static uint32_t hfp_ag_features = 0;
>  
> @@ -172,32 +174,6 @@ static GIOChannel *hsp_server = NULL;
>  
>  static GIOChannel *sco_server = NULL;
>  
> -static struct hf_device *find_default_device(void)
> -{
> -	/* TODO should be replaced by find_device() eventually */
> -
> -	return &device;
> -}
> -
> -static struct hf_device *find_device(const bdaddr_t *bdaddr)
> -{
> -	if (bacmp(&device.bdaddr, bdaddr))
> -		return NULL;
> -
> -	return &device;
> -}
> -
> -static struct hf_device *get_device(const bdaddr_t *bdaddr)
> -{
> -	struct hf_device *dev;
> -
> -	dev = find_device(bdaddr);
> -	if (dev)
> -		return dev;
> -
> -	return &device;
> -}
> -
>  static void set_state(struct hf_device *dev, uint8_t state)
>  {
>  	struct hal_ev_handsfree_conn_state ev;
> @@ -246,28 +222,38 @@ static void init_codecs(struct hf_device *dev)
>  		dev->codecs[MSBC_OFFSET].local_supported = true;
>  }
>  
> -static void device_init(struct hf_device *dev, const bdaddr_t *bdaddr)
> +static struct hf_device *device_create(const bdaddr_t *bdaddr)
>  {
> -	bacpy(&dev->bdaddr, bdaddr);
> +	struct hf_device *dev;
>  
> +	dev = new0(struct hf_device, 1);
> +	if (!dev)
> +		return NULL;
> +
> +	bacpy(&dev->bdaddr, bdaddr);
>  	dev->setup_state = HAL_HANDSFREE_CALL_STATE_IDLE;
> +	dev->state = HAL_EV_HANDSFREE_CONN_STATE_DISCONNECTED;
> +	dev->audio_state = HAL_EV_HANDSFREE_AUDIO_STATE_DISCONNECTED;
>  
>  	memcpy(dev->inds, inds_defaults, sizeof(dev->inds));
>  
>  	init_codecs(dev);
>  
> -	set_state(dev, HAL_EV_HANDSFREE_CONN_STATE_CONNECTING);
> +	if (!queue_push_head(devices, dev)) {
> +		free(dev);
> +		return NULL;
> +	}
> +
> +	return dev;
>  }
>  
> -static void device_cleanup(struct hf_device *dev)
> +static void device_destroy(struct hf_device *dev)
>  {
>  	if (dev->gw) {
>  		hfp_gw_unref(dev->gw);
>  		dev->gw = NULL;
>  	}
>  
> -	set_state(dev, HAL_EV_HANDSFREE_CONN_STATE_DISCONNECTED);
> -
>  	if (dev->sco_watch) {
>  		g_source_remove(dev->sco_watch);
>  		dev->sco_watch = 0;
> @@ -290,8 +276,45 @@ static void device_cleanup(struct hf_device *dev)
>  	}
>  
>  	set_audio_state(dev, HAL_EV_HANDSFREE_AUDIO_STATE_DISCONNECTED);
> +	set_state(dev, HAL_EV_HANDSFREE_CONN_STATE_DISCONNECTED);
> +
> +	queue_remove(devices, dev);
> +	free(dev);

So now you definitely do not need zero assignments.

> +}
> +
> +static struct hf_device *find_default_device(void)
> +{
> +	/* TODO should be replaced by find_device() eventually */
> +
> +	return queue_peek_head(devices);
> +}
>  
> -	memset(dev, 0, sizeof(*dev));
> +static bool match_by_bdaddr(const void *data, const void *match_data)
> +{
> +	const struct hf_device *dev = data;
> +	const bdaddr_t *addr = match_data;
> +
> +	return !bacmp(&dev->bdaddr, addr);
> +}
> +
> +static struct hf_device *find_device(const bdaddr_t *bdaddr)
> +{
> +	return queue_find(devices, match_by_bdaddr, bdaddr);
> +}
> +
> +static struct hf_device *get_device(const bdaddr_t *bdaddr)
> +{
> +	struct hf_device *dev;
> +
> +	dev = find_device(bdaddr);
> +	if (dev)
> +		return dev;
> +
> +	/* TODO For now allow only 1 remote device */
> +	if (!queue_isempty(devices))
> +		return NULL;
> +
> +	return device_create(bdaddr);
>  }

These get_device() functions needs to be merged with the previous patch.

Best regards 
Andrei Emeltchenko 

>  
>  static void disconnect_watch(void *user_data)
> @@ -300,7 +323,7 @@ static void disconnect_watch(void *user_data)
>  
>  	DBG("");
>  
> -	device_cleanup(dev);
> +	device_destroy(dev);
>  }
>  
>  static void at_cmd_unknown(const char *command, void *user_data)
> @@ -1421,7 +1444,7 @@ static void connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
>  
>  failed:
>  	g_io_channel_shutdown(chan, TRUE, NULL);
> -	device_cleanup(dev);
> +	device_destroy(dev);
>  }
>  
>  static void confirm_cb(GIOChannel *chan, gpointer data)
> @@ -1454,15 +1477,16 @@ static void confirm_cb(GIOChannel *chan, gpointer data)
>  		goto drop;
>  	}
>  
> -	device_init(dev, &bdaddr);
> -
>  	if (!bt_io_accept(chan, connect_cb, dev, NULL, NULL)) {
>  		error("handsfree: failed to accept connection");
> -		device_cleanup(dev);
> +		device_destroy(dev);
>  		goto drop;
>  	}
>  
>  	dev->hsp = GPOINTER_TO_INT(data);
> +
> +	set_state(dev, HAL_EV_HANDSFREE_CONN_STATE_CONNECTING);
> +
>  	return;
>  
>  drop:
> @@ -1541,7 +1565,7 @@ static void sdp_hsp_search_cb(sdp_list_t *recs, int err, gpointer data)
>  	return;
>  
>  fail:
> -	device_cleanup(dev);
> +	device_destroy(dev);
>  }
>  
>  static int sdp_search_hsp(struct hf_device *dev)
> @@ -1629,7 +1653,7 @@ static void sdp_hfp_search_cb(sdp_list_t *recs, int err, gpointer data)
>  	return;
>  
>  fail:
> -	device_cleanup(dev);
> +	device_destroy(dev);
>  }
>  
>  static int sdp_search_hfp(struct hf_device *dev)
> @@ -1653,13 +1677,8 @@ static void handle_connect(const void *buf, uint16_t len)
>  
>  	DBG("");
>  
> -	dev = find_default_device();
> -	if (dev) {
> -		status = HAL_STATUS_FAILED;
> -		goto failed;
> -	}
> -
>  	android2bdaddr(&cmd->bdaddr, &bdaddr);
> +
>  	dev = get_device(&bdaddr);
>  	if (!dev) {
>  		status = HAL_STATUS_FAILED;
> @@ -1674,17 +1693,17 @@ static void handle_connect(const void *buf, uint16_t len)
>  	ba2str(&bdaddr, addr);
>  	DBG("connecting to %s", addr);
>  
> -	device_init(dev, &bdaddr);
> -
>  	/* prefer HFP over HSP */
>  	ret = hfp_server ? sdp_search_hfp(dev) : sdp_search_hsp(dev);
>  	if (ret < 0) {
>  		error("handsfree: SDP search failed");
> -		device_cleanup(dev);
> +		device_destroy(dev);
>  		status = HAL_STATUS_FAILED;
>  		goto failed;
>  	}
>  
> +	set_state(dev, HAL_EV_HANDSFREE_CONN_STATE_CONNECTING);
> +
>  	status = HAL_STATUS_SUCCESS;
>  
>  failed:
> @@ -1712,7 +1731,6 @@ static void handle_disconnect(const void *buf, uint16_t len)
>  	if (dev->state == HAL_EV_HANDSFREE_CONN_STATE_DISCONNECTED) {
>  		status = HAL_STATUS_FAILED;
>  		goto failed;
> -
>  	}
>  
>  	if (dev->state == HAL_EV_HANDSFREE_CONN_STATE_DISCONNECTING) {
> @@ -1721,7 +1739,7 @@ static void handle_disconnect(const void *buf, uint16_t len)
>  	}
>  
>  	if (dev->state == HAL_EV_HANDSFREE_CONN_STATE_CONNECTING) {
> -		device_cleanup(dev);
> +		device_destroy(dev);
>  	} else {
>  		set_state(dev, HAL_EV_HANDSFREE_CONN_STATE_DISCONNECTING);
>  		hfp_gw_disconnect(dev->gw);
> @@ -2849,13 +2867,15 @@ bool bt_handsfree_register(struct ipc *ipc, const bdaddr_t *addr, uint8_t mode)
>  
>  	bacpy(&adapter_addr, addr);
>  
> -	if (!enable_hsp_ag())
> +	devices = queue_new();
> +	if (!devices)
>  		return false;
>  
> -	if (!enable_sco_server()) {
> -		cleanup_hsp_ag();
> -		return false;
> -	}
> +	if (!enable_hsp_ag())
> +		goto failed_queue;
> +
> +	if (!enable_sco_server())
> +		goto failed_hsp;
>  
>  	if (mode == HAL_MODE_HANDSFREE_HSP_ONLY)
>  		goto done;
> @@ -2868,9 +2888,14 @@ bool bt_handsfree_register(struct ipc *ipc, const bdaddr_t *addr, uint8_t mode)
>  	if (enable_hfp_ag())
>  		goto done;
>  
> -	cleanup_hsp_ag();
>  	disable_sco_server();
>  	hfp_ag_features = 0;
> +failed_hsp:
> +	cleanup_hsp_ag();
> +failed_queue:
> +	queue_destroy(devices, NULL);
> +	devices = NULL;
> +
>  	return false;
>  
>  done:
> @@ -2896,4 +2921,7 @@ void bt_handsfree_unregister(void)
>  	disable_sco_server();
>  
>  	hfp_ag_features = 0;
> +
> +	queue_destroy(devices, (queue_destroy_func_t) device_destroy);
> +	devices = NULL;
>  }
> -- 
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
