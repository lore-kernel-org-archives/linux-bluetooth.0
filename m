Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2 4/7] android/handsfree-client: Add incoming connection handling
Date: Mon, 10 Nov 2014 20:45:03 +0100
Message-ID: <7069865.YusejmGpyu@leonov>
In-Reply-To: <1415492659-3296-5-git-send-email-lukasz.rymanowski@tieto.com>
References: <1415492659-3296-1-git-send-email-lukasz.rymanowski@tieto.com> <1415492659-3296-5-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lukasz,

On Sunday 09 of November 2014 01:24:16 Lukasz Rymanowski wrote:
> ---
>  android/handsfree-client.c | 173
> ++++++++++++++++++++++++++++++++++++++++++++- 1 file changed, 172
> insertions(+), 1 deletion(-)
> 
> diff --git a/android/handsfree-client.c b/android/handsfree-client.c
> index aa3912b..4914baf 100644
> --- a/android/handsfree-client.c
> +++ b/android/handsfree-client.c
> @@ -36,6 +36,8 @@
>  #include "lib/sdp_lib.h"
>  #include "src/sdp-client.h"
>  #include "src/shared/queue.h"
> +#include "src/shared/util.h"
> +#include "btio/btio.h"
>  #include "ipc.h"
>  #include "ipc-common.h"
>  #include "src/log.h"
> @@ -64,6 +66,11 @@
>  				HFP_HF_FEAT_RVC | HFP_HF_FEAT_ECS |\
>  				HFP_HF_FEAT_ECC)
> 
> +struct device {
> +	bdaddr_t bdaddr;
> +	uint8_t state;
> +};
> +
>  static bdaddr_t adapter_addr;
> 
>  static struct ipc *hal_ipc = NULL;
> @@ -71,6 +78,55 @@ static struct ipc *hal_ipc = NULL;
>  static uint32_t hfp_hf_features = 0;
>  static uint32_t hfp_hf_record_id = 0;
>  static struct queue *devices = NULL;
> +static GIOChannel *hfp_hf_server = NULL;
> +
> +static bool match_by_bdaddr(const void *data, const void *user_data)
> +{
> +	const bdaddr_t *addr1 = data;
> +	const bdaddr_t *addr2 = user_data;
> +
> +	return !bacmp(addr1, addr2);
> +}
> +
> +static struct device *find_device(const bdaddr_t *addr)
> +{
> +	return queue_find(devices, match_by_bdaddr, addr);
> +}
> +
> +static struct device *device_create(const bdaddr_t *bdaddr)
> +{
> +	struct device *dev;
> +
> +	dev = new0(struct device, 1);
> +	if (!dev)
> +		return NULL;
> +
> +	if (!queue_push_tail(devices, dev)) {
> +		error("hf-client: Could not push dev on the list");
> +		free(dev);
> +		return NULL;
> +	}
> +
> +	bacpy(&dev->bdaddr, bdaddr);
> +	dev->state = HAL_HF_CLIENT_CONN_STATE_DISCONNECTED;
> +
> +	return dev;
> +}
> +
> +static struct device *get_device(const bdaddr_t *addr)
> +{
> +	struct device *dev;
> +
> +	dev = find_device(addr);
> +	if (dev)
> +		return dev;
> +
> +	/* We do support only one device as for now */
> +	if (queue_isempty(devices))
> +		return device_create(addr);
> +
> +	return NULL;
> +}
> 
>  static void handle_connect(const void *buf, uint16_t len)
>  {
> @@ -192,6 +248,102 @@ static void handle_get_last_vc_tag_num(const void
> *buf, uint16_t len) HAL_STATUS_UNSUPPORTED);
>  }
> 
> +static void device_set_state(struct device *dev, uint8_t state)
> +{
> +	struct hal_ev_hf_client_conn_state ev;
> +	char address[18];
> +
> +	if (dev->state == state)
> +		return;
> +
> +	memset(&ev, 0, sizeof(ev));
> +
> +	dev->state = state;
> +
> +	ba2str(&dev->bdaddr, address);
> +	DBG("device %s state %u", address, state);
> +
> +	bdaddr2android(&dev->bdaddr, ev.bdaddr);
> +	ev.state = state;
> +
> +	ipc_send_notif(hal_ipc, HAL_SERVICE_ID_HANDSFREE_CLIENT,
> +				HAL_EV_HF_CLIENT_CONN_STATE, sizeof(ev), &ev);
> +}
> +
> +static void device_destroy(struct device *dev)
> +{
> +	device_set_state(dev, HAL_HF_CLIENT_CONN_STATE_DISCONNECTED);
> +	queue_remove(devices, dev);
> +	free(dev);
> +}
> +
> +static void connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
> +{
> +	struct device *dev = user_data;
> +
> +	DBG("");
> +
> +	if (err) {
> +		error("hf-client: connect failed (%s)", err->message);
> +		goto failed;
> +	}
> +
> +	g_io_channel_set_close_on_unref(chan, FALSE);
> +
> +	/* TODO Create SLC here. For now do nothing, link will be dropped */
> +
> +	return;
> +
> +failed:
> +	g_io_channel_shutdown(chan, TRUE, NULL);
> +	device_destroy(dev);
> +}
> +
> +static void confirm_cb(GIOChannel *chan, gpointer data)
> +{
> +	struct device *dev;
> +	char address[18];
> +	bdaddr_t bdaddr;
> +	GError *err = NULL;
> +
> +	bt_io_get(chan, &err,
> +			BT_IO_OPT_DEST, address,
> +			BT_IO_OPT_DEST_BDADDR, &bdaddr,
> +			BT_IO_OPT_INVALID);
> +	if (err) {
> +		error("hf-client: confirm failed (%s)", err->message);
> +		g_error_free(err);
> +		goto drop;
> +	}
> +
> +	DBG("Incoming connection from %s", address);
> +
> +	dev = get_device(&bdaddr);
> +	if (!dev) {
> +		error("hf-client: There is other AG connected");
> +		goto drop;
> +	}
> +
> +	if (dev->state != HAL_HF_CLIENT_CONN_STATE_DISCONNECTED) {
> +		/* TODO: Handle colision */
> +		error("hf-client: Connections is up or ongoing ?");
> +		goto drop;
> +	}
> +
> +	device_set_state(dev, HAL_HF_CLIENT_CONN_STATE_CONNECTING);
> +
> +	if (!bt_io_accept(chan, connect_cb, dev, NULL, NULL)) {
> +		error("hf-client: failed to accept connection");
> +		device_destroy(dev);
> +		goto drop;
> +	}
> +
> +	return;
> +
> +drop:
> +	g_io_channel_shutdown(chan, TRUE, NULL);
> +}
> +
>  static const struct ipc_handler cmd_handlers[] = {
>  	/* HAL_OP_HF_CLIENT_CONNECT */
>  	{ handle_connect, false,
> @@ -304,6 +456,19 @@ static sdp_record_t *hfp_hf_record(void)
>  static bool enable_hf_client(void)
>  {
>  	sdp_record_t *rec;
> +	GError *err = NULL;
> +
> +	hfp_hf_server =  bt_io_listen(NULL, confirm_cb, NULL, NULL, &err,
> +					BT_IO_OPT_SOURCE_BDADDR, &adapter_addr,
> +					BT_IO_OPT_CHANNEL, HFP_HF_CHANNEL,
> +					BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_MEDIUM,
> +					BT_IO_OPT_INVALID);
> +	if (!hfp_hf_server) {
> +		error("hf-client: Failed to listen on Handsfree rfcomm: %s",
> +								err->message);
> +		g_error_free(err);
> +		return false;
> +	}
> 

g_io_channel cleanup is missing further in error paths.

>  	hfp_hf_features = HFP_HF_FEATURES;
> 
> @@ -326,6 +491,12 @@ static bool enable_hf_client(void)
> 
>  static void cleanup_hfp_hf(void)
>  {
> +	if (hfp_hf_server) {
> +		g_io_channel_shutdown(hfp_hf_server, TRUE, NULL);
> +		g_io_channel_unref(hfp_hf_server);
> +		hfp_hf_server = NULL;
> +	}
> +
>  	if (hfp_hf_record_id > 0) {
>  		bt_adapter_remove_record(hfp_hf_record_id);
>  		hfp_hf_record_id = 0;
> @@ -366,7 +537,7 @@ void bt_hf_client_unregister(void)
> 
>  	cleanup_hfp_hf();
> 
> -	queue_destroy(devices, free);
> +	queue_destroy(devices, (void *) device_destroy);
>  	devices = NULL;
> 
>  	ipc_unregister(hal_ipc, HAL_SERVICE_ID_HANDSFREE);

-- 
BR
Szymon Janc
