Return-Path: <cyrus@holtmann.org>
Date: Sun, 29 May 2011 21:57:52 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Waldemar Rymarkiewicz <waldemar.rymarkiewicz@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] Clean nad simplify SAP server error printouts
Message-ID: <20110529185525.GC32088@dell.ger.corp.intel.com>
References: <1306403760-22254-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1306403760-22254-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Waldek,

On Thu, May 26, 2011, Waldemar Rymarkiewicz wrote:
> -	DBG("Client has been authorized.");
> +	info("Access has been granted.");

You should be very conservative with the use of info() instead of DBG().
Essentially it should be reserved for some very fundamental core daemon
events only, such as init and exit of bluetoothd. Plugins shouldn't
really need to use it ever.

>  	if (conn) {
> +		info("Another SAP connection already exists.");

Same here (change to DBG)

> -	DBG("SAP incoming connection (sock %d) authorization.",
> -				g_io_channel_unix_get_fd(io));
> +	info("Authorizing incomming SAP connection from %s", dstaddr);

And here.

> @@ -1298,7 +1282,7 @@ static DBusMessage *get_properties(DBusConnection *c,
>  			DBUS_DICT_ENTRY_END_CHAR_AS_STRING, &dict);
>  
>  	connected = (conn->state == SAP_STATE_CONNECTED ||
> -			conn->state == SAP_STATE_GRACEFUL_DISCONNECT);
> +				conn->state == SAP_STATE_GRACEFUL_DISCONNECT);
>  	dict_append_entry(&dict, "Connected", DBUS_TYPE_BOOLEAN, &connected);

This looks like a coding style cleanup. Don't mix that with the logging
changes (i.e. separate patch please). Usually having the word "and" in
your commit message summary (or "nad" in this case ;) is a good
indication that you might need to consider splitting up your patch.

>  	if (!g_dbus_register_interface(connection, path, SAP_SERVER_INTERFACE,
> -				server_methods, server_signals, NULL,
> -				server, destroy_sap_interface)) {
> +					server_methods, server_signals, NULL,
> +					server, destroy_sap_interface)) {
>  		error("D-Bus failed to register %s interface",
> -						SAP_SERVER_INTERFACE);
> +							SAP_SERVER_INTERFACE);

Same here.

Johan
