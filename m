Return-Path: <cyrus@holtmann.org>
Date: Tue, 17 Aug 2010 13:30:51 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Daniel =?iso-8859-1?Q?=D6rstadius?= <daniel.orstadius@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 2/3] Maemo6 MCE: listen to adapter mode changes
Message-ID: <20100817103051.GA29845@jh-x301>
References: <AANLkTim2ni6aE3-9Rx+HGeFFmmG-by6PMh4zgrJFnk-m@mail.gmail.com>
 <AANLkTimpogcSN1eKO9A2aWB1aB7YNZSRD7f-vGMvma9q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <AANLkTimpogcSN1eKO9A2aWB1aB7YNZSRD7f-vGMvma9q@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Daniel,

> From: Daniel Orstadius <daniel.orstadius@nokia.com>
> Date: Tue, 17 Aug 2010 11:41:33 +0300
> Subject: [PATCH] Maemo6 MCE: listen to adapter powered state
> 
> Registers a callback in btd_adapter to get notified when the
> powered state of the adapter is changed. This is needed to update
> the state stored in the MCE if the adapter is powered on or off
> using for example SetProperty(Powered). The current setting of
> the MCE is saved in a variable and if the notification to the
> plugin does not match this value the MCE is updated accordingly
> using its DBus method for setting radio states.
> ---
>  plugins/maemo6.c |   48 ++++++++++++++++++++++++++++++++++++++++++++++--
>  1 files changed, 46 insertions(+), 2 deletions(-)

A couple of issues I noticed:

> +	DBG("adapter_powered called with %d", (int) powered);

I don't think the int cast is necessary here. Or do you get a warning
otherwise?

> +	dbus_message_append_args(msg, DBUS_TYPE_UINT32, &radio_states,
> +				DBUS_TYPE_UINT32, &radio_mask);

DBUS_TYPE_INVALID is missing from the end of the arguments list.

> +}
> +
> +
>  static int mce_probe(struct btd_adapter *adapter)

Why the two consecutive empty lines? Please remove one.

> @@ -132,6 +173,9 @@ static int mce_probe(struct btd_adapter *adapter)
>  	watch_id = g_dbus_add_signal_watch(conn, NULL, MCE_SIGNAL_PATH,
>  					MCE_SIGNAL_IF, MCE_RADIO_STATES_SIG,
>  					mce_signal_callback, adapter, NULL);
> +
> +	btd_adapter_register_powered_callback(adapter, adapter_powered);
> +
>  	return 0;
>  }
>  

It seems you're missing the corresponding unregister_powered_callback
call in mce_remove().

Johan
