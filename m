Return-Path: <cyrus@holtmann.org>
Date: Fri, 5 Nov 2010 12:16:00 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Waldemar Rymarkiewicz <waldemar.rymarkiewicz@tieto.com>
Cc: linux-bluetooth@vger.kernel.org, suraj@atheros.com,
	joakim.xj.ceder@stericsson.com
Subject: Re: [PATCH 4/4] Sim Access Profile dummy driver
Message-ID: <20101105101600.GC32149@jh-x301>
References: <1288791271-13857-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
 <1288791271-13857-5-git-send-email-waldemar.rymarkiewicz@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1288791271-13857-5-git-send-email-waldemar.rymarkiewicz@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Waldek,

On Wed, Nov 03, 2010, Waldemar Rymarkiewicz wrote:
> +static sim_connection_status_t sim_card_connection_status = SIM_DISCONNECTED;

Consider shortening these names. At least one of them (either the type
or the variable).

> +static void *		sap_data = NULL;  /* SAP server private data.*/

No whitespace between * and sap_data. Why is this void instead of a
specific type when its static and therefore wont be seen by other
modules?

> +	if(sim_card_connection_status == SIM_MISSING)

Space before (

> +	}else if(sim_card_connection_status != SIM_CONNECTED)

Space after } and before (

> +		sap_power_sim_on_rsp(sap_device, SAP_RESULT_ERROR_NOT_ACCESSIBLE);
> +	else {
> +		sap_power_sim_on_rsp(sap_device, SAP_RESULT_ERROR_NO_REASON);
> +	}

Why do you have {} for one branch but not for the other? In general
one-line branches/scopes shouldn't have braces, though the kernel coding
guideline does allow them if at least one part of the same if-else
statement has them.

> +static inline DBusMessage *invalid_args(DBusMessage *msg)

Never mind the previous comment I had about this. I checked the rest of
the tree and it seems this inline convention for D-Bus error generating
functions is quite common (though imho might not be needed at all).

> +	if(sim_card_connection_status != SIM_CONNECTED)

Space before (

> +}
> +
> +
> +static GDBusMethodTable dummy_methods[] = {

Remove the other empty line.

> +	{ "OngoingCall",	"b",	"",	ongoing_call},
> +	{ "MaxMessageSize",	"u",	"",	max_msg_size},
> +	{ "Disconnect",		"",	"",	disconnect},
> +	{ "CardStatus",		"u",	"",	card_status},
> +	{ }

> +static GDBusSignalTable dummy_signals[] = {
> +	{ "","" },
> +	{ }
> +};

If you have no signals just pass NULL to g_dbus_register_interface
instead of declaring an (almost) empty table. Also, "" isn't a valid
value for the signal name.

Johan
