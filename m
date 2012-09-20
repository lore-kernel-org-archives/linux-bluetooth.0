Return-Path: <cyrus@holtmann.org>
Date: Thu, 20 Sep 2012 14:43:23 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: =?iso-8859-1?Q?Jo=E3o?= Paulo Rechi Vita <jprvita@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ v6 03/11] core: Mutually exclude concurrent
 connections
Message-ID: <20120920114323.GA11861@x220>
References: <1347370387-17670-1-git-send-email-jprvita@openbossa.org>
 <1347370387-17670-3-git-send-email-jprvita@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1347370387-17670-3-git-send-email-jprvita@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Tue, Sep 11, 2012, João Paulo Rechi Vita wrote:
> Since controllers don't support more than one ongoing connection
> procedure at the same time, new connection attempts needs to yield if
> there is an ongoing connection procedure already.
> ---
>  src/adapter.c | 61 +++++++++++++++++++++++++++++++++++++++++++++++++++--------
>  src/device.c  |  6 +++---
>  src/device.h  |  2 +-
>  3 files changed, 57 insertions(+), 12 deletions(-)

Couple of coding style things I'd like to get fixed in this one. Patches
1/11 and 2/11 have been already applied though so no need to resend
them.

> +	if (g_slist_length(adapter->connect_list))
> +		mgmt_start_discovery(adapter->dev_id);

Since you're not testing for a boolean I'd rather have a clear > 0 here.

>  	const char *path = adapter->path;
> +	guint connect_list_size;

Call this conn_list_len (to make it shorter and to match what the
function you get this value from is called)

> +	if (!adapter_has_discov_sessions(adapter) && !connect_list_size)
>  		return;

Again since conn_list_len is not a boolean I'd rather have a clear == 0.

> -	DBG("hci%u restarting discovery, disc_sessions %u", adapter->dev_id,
> -					g_slist_length(adapter->disc_sessions));
> +	DBG("hci%u restarting discovery: disc_sessions %u, connect_list size "
> +		"%u", adapter->dev_id, g_slist_length(adapter->disc_sessions),

Splitting strings like this is something that we really should try to
avoid. If you do the variable rename as I suggested you can get this on
the same line.

> +static gboolean clean_connecting_state(GIOChannel *io, GIOCondition cond, gpointer user_data)

Looks like a too long line to me.

> +	if (adapter->waiting_to_connect == 0 &&
> +					g_slist_length(adapter->connect_list))
> +		mgmt_start_discovery(adapter->dev_id);

Again > 0 here (which is especially strange that you didn't do it from
the start as in the first test you do use == 0).

> +	btd_device_unref(device);
> +	return FALSE;
> +}

Empty line before the return statement please.

> +	btd_device_unref(device);
>  	return FALSE;
>  }

Same here.

As a general note (not relating specifically to this patch) I'd like to
see a clearer split and naming of LE/GATT-specific functionality and
variables (function names, struct btd_adapter/device member naming &
grouping, etc.). Right now these seem to be sprinkled all over the place
which can be confusing for someone looking at the code from a
BR/EDR-only or LE-only perspective.

Johan
