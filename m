Return-Path: <cyrus@holtmann.org>
Date: Tue, 8 Jun 2010 15:09:36 +0800
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Get IEEE1284 for a single printer
Message-ID: <20100608070935.GA22068@jh-x301>
References: <1275849744.7994.38.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1275849744.7994.38.camel@localhost.localdomain>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bastien,

On Sun, Jun 06, 2010, Bastien Nocera wrote:
> Let me know what you think.

Sounds ok'ish to me, but how exactly would udev-configure-printer be
called? If it's directly executed (as opposed to e.g. using D-Bus) then
privilege and environment inheritance needs to be considered (i.e. is it
fine that it gets run with the same privileges and environment as
bluetoothd itself).

> The patch below could still be useful for debugging (in the worst
> case).

I have nothing against pushing the patch upstream as long as its coding
style issues are fixed:

> +	message = dbus_message_new_method_call("org.bluez", "/",
> +					       "org.bluez.Manager",
> +					       "DefaultAdapter");

Mixed tabs and spaces for indentation.

> +	adapter_reply = dbus_connection_send_with_reply_and_block(conn,
> +								  message, -1, NULL);

Same.

> +	if (dbus_message_get_args(adapter_reply, NULL, DBUS_TYPE_OBJECT_PATH, &adapter, DBUS_TYPE_INVALID) == FALSE)

Longer line than 79 characters.

> +	message = dbus_message_new_method_call("org.bluez", adapter,
> +					       "org.bluez.Adapter",
> +					       "FindDevice");

Mixed tabs and spaces.

> +		message = dbus_message_new_method_call("org.bluez", adapter,
> +						       "org.bluez.Adapter",
> +						       "CreateDevice");

Mixed tabs and spaces.

> +		dbus_message_iter_init_append(message, &iter);
> +		dbus_message_iter_append_basic(&iter, DBUS_TYPE_STRING, &bdaddr);

Longer line than 79 characters.

> +		reply = dbus_connection_send_with_reply_and_block(conn,
> +								  message, -1, NULL);

Mixed tabs and spaces as well as overlong line.

> +		if (!reply)
> +			return FALSE;
> +	}
> +	if (dbus_message_get_args(reply, NULL, DBUS_TYPE_OBJECT_PATH, &object_path,

Missing empty line after } as well as too long line.

> +				  DBUS_TYPE_INVALID) == FALSE) {

Mixed tabs and spaces.

> +			fprintf(stderr, "Invalid Bluetooth address '%s'\n", argv[2]);

Too long line.

Johan
