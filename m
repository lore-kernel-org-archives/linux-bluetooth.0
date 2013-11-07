Return-Path: <cyrus@holtmann.org>
Date: Thu, 7 Nov 2013 17:36:47 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Cc: linux-bluetooth@vger.kernel.org, szymon.janc@tieto.com
Subject: Re: [PATCH v2] android: Add set/get for discovery timeout
Message-ID: <20131107153647.GA26202@x220.p-661hnu-f1>
References: <1383837979-4390-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1383837979-4390-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lukasz,

On Thu, Nov 07, 2013, Lukasz Rymanowski wrote:
> @@ -1169,6 +1184,8 @@ void bt_adapter_init(uint16_t index, struct mgmt *mgmt, bt_adapter_ready cb)
>  	adapter->index = index;
>  	adapter->discovering = false;
>  	adapter->ready = cb;
> +	/* TODO: Read it from some storage */
> +	adapter->discoverable_timeout = DEFAULT_DISCOVERABLE_TIMEOUT;
>  
>  	if (mgmt_send(mgmt, MGMT_OP_READ_INFO, index, 0, NULL,
>  					read_info_complete, NULL, NULL) > 0)
> @@ -1286,11 +1303,25 @@ static bool get_devices(void)
>  
>  static bool get_discoverable_timeout(void)
>  {
> -	DBG("Not implemented");
> +	struct hal_ev_adapter_props_changed *ev;
> +	int len = sizeof(uint32_t);
> +	uint8_t buf[BASELEN_PROP_CHANGED + len];
>  
> -	/* TODO: Add implementation */
>  
> -	return false;
> +	memset(buf, 0, sizeof(buf));

Looks like you're leaving two empty lines above? Please remove one.

> +	ev = (void *) buf;
> +
> +	ev->num_props = 1;
> +	ev->status = HAL_STATUS_SUCCESS;
> +
> +	ev->props[0].type = HAL_PROP_ADAPTER_DISC_TIMEOUT;
> +	ev->props[0].len = len;

The len variable seems quite unnecessary to me since you could just use
sizeof(uint32_t) in the two places where you need it.

> +	memcpy(&ev->props[0].val, &adapter->discoverable_timeout, sizeof(uint32_t));
> +
> +	ipc_send(notification_sk, HAL_SERVICE_ID_BLUETOOTH,
> +				HAL_EV_ADAPTER_PROPS_CHANGED, sizeof(buf), ev, -1);

Please pay attention to your line lengths. You've got at least two lines
above that are over 79 characters.

Johan
