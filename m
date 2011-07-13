Return-Path: <cyrus@holtmann.org>
Date: Wed, 13 Jul 2011 12:11:32 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: David Herrmann <dh.herrmann@googlemail.com>
Cc: linux-bluetooth@vger.kernel.org, padovan@profusion.mobi,
	marcel@holtmann.org
Subject: Re: [PATCH 1/2] Add pin-code hook to adapter api
Message-ID: <20110713091132.GE15147@dell.ger.corp.intel.com>
References: <1310142895-20224-1-git-send-email-dh.herrmann@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1310142895-20224-1-git-send-email-dh.herrmann@googlemail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi David,

On Fri, Jul 08, 2011, David Herrmann wrote:
> +void btd_adapter_register_pincb(struct btd_adapter *adapter,
> +							btd_adapter_pincb_t cb)

Could you call this pin_cb instead of pincb (here and all other places).

> +GSList *btd_adapter_get_pincbs(struct btd_adapter *adapter)
> +{
> +	return adapter->pin_callbacks;
> +}

I think we could have btd_adapter_get_pin instead of your get_pin()
function and then this btd_adapter_get_pincbs wouldn't be needed at all.

> +static int get_pin(struct btd_adapter *adapter, struct btd_device *device,
> +				bdaddr_t *sba, bdaddr_t *dba, char *pinbuf)

For correctness I suppose the return value should really be ssize_t
instead of int. However, then you'll probably want to fix read_pin_code
in storage.c too. Furthermore, if you're passing btd_adapter and
btd_device it's redundant to pass sba and dba too.

> +	GSList *ele;

Call this variable just "l".

> +	ele = btd_adapter_get_pincbs(adapter);
> +	while (ele) {

Please use a for-loop here (the following example assumes you've moved
this internal to adapter.c as I proposed earlier):

	for (l = adapter->pin_callbacks; l != NULL; l = g_slist_next(l)) {
		...

> +		cb = (void*)ele->data;

There's no typecast needed for void*/gpointer. And even if it was the
coding style mandates a space between the case and the variable name.

Johan
