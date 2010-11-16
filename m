Return-Path: <cyrus@holtmann.org>
Date: Tue, 16 Nov 2010 16:16:11 +0000
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv3 1/7] Add support for Out of Band (OOB) association
 model.
Message-ID: <20101116161611.GA3638@jh-x301>
References: <1289922247-20712-1-git-send-email-szymon.janc@tieto.com>
 <1289922247-20712-2-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1289922247-20712-2-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Tue, Nov 16, 2010, Szymon Janc wrote:
> +gboolean device_get_oob_data(struct btd_device *device, uint8_t *hash,
> +		uint8_t *randomizer)

Looks like the continuation line should be indented a bit more. Basicly
indent at least past the ( on the above line and as much as possible as
long as the entire line stays under 79 columns. I think I saw other
places with the same issue so please fix those too.

> +void device_set_oob_data(struct btd_device *device, uint8_t *hash,
> +		uint8_t *randomizer);
> +gboolean device_get_oob_data(struct btd_device *device, uint8_t *hash,
> +		uint8_t *randomizer);
> +gboolean device_has_oob_data(struct btd_device *device);

I suppose you could just use get_oob_data(dev, NULL, NULL) instead of
having a separate has_oob_data function.

> +gboolean device_request_oob_data(struct btd_device *device, void *cb);

Why is the callback type void* instead of having a well defined
signature?

> +void device_set_local_auth_cap(struct btd_device *device, uint8_t auth,
> +		uint8_t cap);
> +void device_get_local_auth_cap(struct btd_device *device, uint8_t *auth,
> +		uint8_t *cap);

This local_cap/auth in struct device had me wondering a little bit since
it felt like that should actually be in struct adapter, however this is
really per adapter-device pair data in which case it should be fine,
right?

> +static void btd_event_io_cap_reply(struct btd_device *device)
> +{
> +	io_capability_reply_cp cp;
> +	int dev;
> +	struct btd_adapter *adapter = device_get_adapter(device);
> +	uint16_t dev_id = adapter_get_dev_id(adapter);
> +
> +	dev = hci_open_dev(dev_id);

That's a no no. Only hciops should use raw HCI sockets anymore. If you
need to do something like this you'll need to add a new adapter_ops
callback and send your HCI command through that.

>  {
>  	struct btd_adapter *adapter;
>  	struct btd_device *device;
>  	struct agent *agent = NULL;
>  	uint8_t agent_cap;
>  	int err;
> +	uint8_t cap;
> +	uint8_t auth;

These can be on the same line.

> +	if (!plugin || !plugin->local_data_read|| !plugin->plugin_deactivated
> +			|| !plugin->request_remote_data
> +			|| active_plugin == plugin)
> +		return;

When you split lines the break should be after || && etc. In this case
you could also consider splitting this up into multiple if-statements
for better readability.

Johan
