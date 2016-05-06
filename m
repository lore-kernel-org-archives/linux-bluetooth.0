Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ 1/4] doc/gatt-api: Add options dictionary to ReadValue/WriteValue
In-Reply-To: <1462561862-500-1-git-send-email-luiz.dentz@gmail.com>
References: <1462561862-500-1-git-send-email-luiz.dentz@gmail.com>
Date: Fri, 06 May 2016 19:18:20 -0300
Message-ID: <87zis2espf.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Luiz Augusto von Dentz <luiz.dentz@gmail.com> writes:

> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> This adds the possibility to pass an offset to these operations, and
> also in the server case to give the device object.
> ---
>  doc/gatt-api.txt    |  20 ++++--
>  src/gatt-client.c   | 135 +++++++++++++++++++++++++++++----------
>  src/gatt-database.c | 177 +++++++++++++++++++++++++++++++++++++---------------
>  3 files changed, 245 insertions(+), 87 deletions(-)
>
> diff --git a/doc/gatt-api.txt b/doc/gatt-api.txt
> index ad2ab16..683b1b7 100644
> --- a/doc/gatt-api.txt
> +++ b/doc/gatt-api.txt
> @@ -61,23 +61,29 @@ Service		org.bluez
>  Interface	org.bluez.GattCharacteristic1 [Experimental]
>  Object path	[variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX/serviceXX/charYYYY
>
> -Methods		array{byte} ReadValue()
> +Methods		array{byte} ReadValue(dict options)
>
>  			Issues a request to read the value of the
>  			characteristic and returns the value if the
>  			operation was successful.
>
> +			Possible options: "offset": uint16 offset
> +					  "device": Object Device (Server only)
> +

[...]

>
> +static int parse_options(DBusMessage *msg, uint16_t *offset)
> +{
> +	DBusMessageIter args, flags;
> +
> +	if (!dbus_message_iter_init(msg, &args))
> +		return -EINVAL;
> +
> +	if (dbus_message_iter_get_arg_type(&args) != DBUS_TYPE_ARRAY)
> +		return -EINVAL;
> +
> +	dbus_message_iter_recurse(&args, &flags);
> +	if (dbus_message_iter_get_arg_type(&flags) != DBUS_TYPE_DICT_ENTRY)
> +		return -EINVAL;
> +

I would think that from the documentation, "Possible options", that providing
the offset would be optional. I don't think much is gained making this mandatory.

> +	while (dbus_message_iter_get_arg_type(&flags) == DBUS_TYPE_DICT_ENTRY) {
> +		const char *key;
> +		DBusMessageIter value, entry;
> +		int var;
> +
> +		dbus_message_iter_recurse(&flags, &entry);
> +		dbus_message_iter_get_basic(&entry, &key);
> +
> +		dbus_message_iter_next(&entry);
> +		dbus_message_iter_recurse(&entry, &value);
> +
> +		var = dbus_message_iter_get_arg_type(&value);
> +		if (strcasecmp(key, "offset") == 0) {
> +			if (var != DBUS_TYPE_UINT16)
> +				return -EINVAL;
> +			dbus_message_iter_get_basic(&value, offset);
> +		}
> +	}
> +
> +	return 0;
> +}
> +


Cheers,
--
Vinicius
