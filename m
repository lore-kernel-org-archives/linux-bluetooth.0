Return-Path: <cyrus@holtmann.org>
Date: Mon, 22 Aug 2011 10:22:28 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Bartosz Szatkowski <bulislaw@linux.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/3] Add SetRemoteProperties method for OOB COD setting
Message-ID: <20110822072228.GA31063@dell>
References: <CAPGrrxU2otU=wmvtsq=xdcc35FOA5p02h=stg-h4WV-u=dJb7g@mail.gmail.com>
 <1313133349-4215-1-git-send-email-bulislaw@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1313133349-4215-1-git-send-email-bulislaw@linux.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bartosz,

On Fri, Aug 12, 2011, Bartosz Szatkowski wrote:
> +struct oob_remote_parameters {
> +	bdaddr_t local;
> +	bdaddr_t peer;
> +	const char *address;
> +	uint32_t class;
> +};

Could you add a "gboolean device_found;" to this struct and then use it
as follows:

> +static DBusMessage *parse_class(DBusMessageIter *value,
> +			struct oob_remote_parameters *params, DBusMessage *msg)
> +{
> +	if (dbus_message_iter_get_arg_type(value) != DBUS_TYPE_UINT32)
> +		return btd_error_invalid_args(msg);
> +
> +	dbus_message_iter_get_basic(value, &params->class);

	params->device_found = TRUE;

> +	return NULL;
> +}
> +
> +static gboolean set_class(struct oob_remote_parameters *params)
> +{
> +	if (params->class == 0)
> +		return FALSE;

You can move the above if-statement here:

> +static void set_properties(struct btd_adapter *adapter,
> +					struct oob_remote_parameters *params)
> +{
> +	gboolean device_found = FALSE;
> +
> +	if (set_class(params))
> +		device_found = TRUE;

I.e. change this to:

	if (params->class != 0)
		write_remote_class(...);

I suppose you could keep the set_class function if you want, but since
all it does is make a single write_remote_class call you might as well
do the call directly as above.

> +	if (device_found)
> +		emit_device_found(adapter_get_path(adapter), params);
> +}

The above would become:

	if (params->device_found)
		emit_device_found(..., params);

With these changes the flow of logic becomes a bit easier to follow (to
me at least).

Johan

