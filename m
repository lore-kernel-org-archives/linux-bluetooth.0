Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv5 1/4] android/gatt: Send Exchange MTU request on connect
Date: Thu, 22 May 2014 16:49:32 +0200
Message-ID: <3514086.fNq38fX02p@uw000953>
In-Reply-To: <1400756073-16330-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1400756073-16330-1-git-send-email-jakub.tyszkowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jakub,

On Thursday 22 of May 2014 12:54:30 Jakub Tyszkowski wrote:
> This adds sending exchange MTU request on connection.
> 
> This is needed to pass TC_GAC_CL_BV_01_C.
> ---
>  android/gatt.c | 71 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 71 insertions(+)
> 
> diff --git a/android/gatt.c b/android/gatt.c
> index 89da60d..82e8dc1 100644
> --- a/android/gatt.c
> +++ b/android/gatt.c
> @@ -979,6 +979,73 @@ static void send_app_connect_notifications(void *data, void *user_data)
>  
>  static void att_handler(const uint8_t *ipdu, uint16_t len, gpointer user_data);
>  
> +static void exchange_mtu_cb(guint8 status, const guint8 *pdu, guint16 plen,
> +							gpointer user_data)
> +{
> +	struct gatt_device *device = user_data;
> +	GIOChannel *io;
> +	GError *gerr = NULL;
> +	uint16_t rmtu, mtu, imtu;
> +
> +	if (status) {
> +		error("gatt: MTU exchange: %s", att_ecode2str(status));
> +		goto failed;
> +	}
> +
> +	if (!dec_mtu_resp(pdu, plen, &rmtu)) {
> +		error("gatt: MTU exchange: protocol error");
> +		goto failed;
> +	}
> +
> +	if (rmtu < ATT_DEFAULT_LE_MTU) {
> +		error("gatt: MTU exchange: mtu error");
> +		goto failed;
> +	}
> +
> +	io = g_attrib_get_channel(device->attrib);
> +
> +	bt_io_get(io, &gerr, BT_IO_OPT_IMTU, &imtu, BT_IO_OPT_INVALID);
> +	if (gerr) {
> +		error("gatt: Could not get imtu: %s", gerr->message);
> +		g_error_free(gerr);
> +
> +		return;
> +	}
> +
> +	mtu = MIN(rmtu, imtu);
> +	if (mtu != imtu && !g_attrib_set_mtu(device->attrib, mtu)) {
> +		error("gatt: MTU exchange failed");
> +		goto failed;
> +	}
> +
> +	DBG("MTU exchange succeeded: rmtu:%d, old mtu:%d, new mtu:%d", rmtu,
> +								imtu, mtu);
> +
> +failed:
> +	device_unref(device);
> +}
> +
> +static void send_exchange_mtu_request(struct gatt_device *device)
> +{
> +	GIOChannel *io;
> +	GError *gerr = NULL;
> +	uint16_t imtu;
> +
> +	io = g_attrib_get_channel(device->attrib);
> +
> +	bt_io_get(io, &gerr, BT_IO_OPT_IMTU, &imtu, BT_IO_OPT_INVALID);
> +	if (gerr) {
> +		error("gatt: Could not get imtu: %s", gerr->message);
> +		g_error_free(gerr);
> +
> +		return;
> +	}
> +
> +	if (!gatt_exchange_mtu(device->attrib, imtu, exchange_mtu_cb,
> +							device_ref(device)))
> +		device_unref(device);
> +}
> +
>  static void connect_cb(GIOChannel *io, GError *gerr, gpointer user_data)
>  {
>  	struct gatt_device *dev = user_data;
> @@ -1024,6 +1091,10 @@ static void connect_cb(GIOChannel *io, GError *gerr, gpointer user_data)
>  
>  	device_set_state(dev, DEVICE_CONNECTED);
>  
> +	/* Send exchange mtu request as we assume being client and server */
> +	/* TODO: Dont exchange mtu if no client apps */
> +	send_exchange_mtu_request(dev);
> +
>  	status = GATT_SUCCESS;
>  
>  reply:

Patch 1/4 is now applied but rest need rebase. Thanks.


-- 
Best regards, 
Szymon Janc
