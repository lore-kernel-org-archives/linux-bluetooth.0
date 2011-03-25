Return-Path: <cyrus@holtmann.org>
Date: Fri, 25 Mar 2011 10:54:36 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org,
	par-gunnar.p.hjalmdahl@stericsson.com,
	henrik.possung@stericsson.com
Subject: Re: [PATCH v6 4/6] Add D-Bus OOB plugin
Message-ID: <20110325085436.GD30796@jh-x301>
References: <1300974459-24076-1-git-send-email-szymon.janc@tieto.com>
 <1300974459-24076-5-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1300974459-24076-5-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Thu, Mar 24, 2011, Szymon Janc wrote:
> +static GDBusMethodTable oob_methods[] = {
> +	{"AddRemoteOobData",	"sayay", "",	 add_remote_data},
> +	{"RemoveRemoteOobData",	"s",	 "",	 remove_remote_data},
> +	{"ReadLocalOobData",	"",	 "ayay", read_local_data,
> +						 G_DBUS_METHOD_FLAG_ASYNC},
> +	{ }
> +};

You're using mixing spaces and tabs for indentation within this table.
Just use table if you want to align the columns.

> +static void oob_remove(struct btd_adapter *adapter)
> +{
> +	local_data_read(adapter, NULL, NULL);
> +
> +	g_dbus_unregister_interface(connection, adapter_get_path(adapter),
> +							OOB_INTERFACE);
> +}
> +
> +
> +static struct btd_adapter_driver oob_driver = {

There should never be the need to have two consecutive empty lines.
Please remove one.

> +	while ((match = g_slist_next(oob_requests))) {
> +		oob_request = match->data;
> +		oob_remove(oob_request->adapter);
> +	}

This loop looks flawed to me. Why are you skipping the first element in
the list? It also took some time to see that you don't have an infinite
loop here as it's a quite indirect way that the elements get removed.
Furthermore, you've got functions called "local_data_read" and
"read_local_data". Do you think someone would immediately understand the
difference from those names? Maybe local_data_read could be named
read_local_data_complete or read_local_data_cb or something similar?

Johan
