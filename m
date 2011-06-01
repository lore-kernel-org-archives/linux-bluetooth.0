Return-Path: <cyrus@holtmann.org>
Date: Wed, 1 Jun 2011 15:06:36 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Rafal Michalski <michalski.raf@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v4] Fix disconnect devices after enabling offline mode
Message-ID: <20110601120636.GD26952@dell.ger.corp.intel.com>
References: <1306918189-2333-1-git-send-email-michalski.raf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1306918189-2333-1-git-send-email-michalski.raf@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Rafal,

On Wed, Jun 01, 2011, Rafal Michalski wrote:
> Previously paired and connected devices were disconnected automatically
> after turning bluetooth off directly via bluetooth UI. This patch makes
> that also other ways of turning bluetooth off (which should lead to
> disconnecting paired and connected devices), such as enabling offline
> mode (which turns bluetooth off as well), can be handled properly.
> ---
>  plugins/maemo6.c |    4 ++--
>  src/adapter.c    |   47 ++++++++++++++++++++++++++++++++++++++++++++++-
>  src/adapter.h    |    2 +-
>  3 files changed, 49 insertions(+), 4 deletions(-)

A couple more things:

> --- a/plugins/maemo6.c
> +++ b/plugins/maemo6.c
> @@ -77,7 +77,7 @@ static gboolean mce_signal_callback(DBusConnection *connection,
>  		if (mce_bt_set)
>  			btd_adapter_switch_online(adapter);
>  		else
> -			btd_adapter_switch_offline(adapter);
> +			btd_adapter_switch_offline(adapter, TRUE);
>  	}
>  
>  	return TRUE;
> @@ -124,7 +124,7 @@ static void read_radio_states_cb(DBusPendingCall *call, void *user_data)
>  	if (mce_bt_set)
>  		btd_adapter_switch_online(adapter);
>  	else
> -		btd_adapter_switch_offline(adapter);
> +		btd_adapter_switch_offline(adapter, TRUE);

Since plugins/maemo6.c seems to be the only user of this API and always
passes TRUE to it, could we just make this the only possible behavior
until a use case shows up where an "unclean" switch_offline is needed?
I.e. remove the boolean completely.

In general this kind of boolean APIs aren't really the most readable
ones since when looking at the function call you have no idea what the
boolean actually does. In this kind of cases it might be worth creating
an enum (even though you've just got two possible values). Then
something like the following is more clear when looking at the function
call:

btd_adapter_switch_offline(adapter, SWITCH_OFFLINE_CLEAN);

However just remove the boolean for now and we don't need to even
consider this.

> +static void off_timer_free(struct btd_adapter *adapter)
> +{
> +	g_source_remove(adapter->off_timer);
> +	adapter->off_timer = 0;
> +}

I think off_timer_remove would be a more appropriate name here.

> +static void disconnect_device(struct btd_device *device, gpointer user_data)
> +{
> +	device_request_disconnect(device, NULL);
> +}
<snip>
> +		g_slist_foreach(adapter->connections,
> +					(GFunc) disconnect_device, NULL);

In general try to avoid function typecasts by defining the target
function to the exact needed type. However in this case you don't even
need an intermediate function if you do the typecast. Just pass
device_request_disconnect directly to g_slist_foreach.

Johan
