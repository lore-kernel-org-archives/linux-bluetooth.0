Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Sebastian <sebastianchlad@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Sebastian Chlad <sebastian.chlad@tieto.com>
Subject: Re: [PATCH] Adding paired-devices cmd to the bluetoothctl
Date: Mon, 25 Nov 2013 14:08:07 +0100
Message-ID: <7144304.2MX7gdvi4Y@uw000953>
In-Reply-To: <1384978912-27461-1-git-send-email-sebastian.chlad@tieto.com>
References: <1384978912-27461-1-git-send-email-sebastian.chlad@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

> From: Sebastian Chlad <sebastian.chlad@tieto.com>
> 
> Paired-devices command lists only paired devices
> ---
>  client/main.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/client/main.c b/client/main.c
> index 0dd1510..c39ebf8 100644
> --- a/client/main.c
> +++ b/client/main.c
> @@ -538,6 +538,26 @@ static void cmd_devices(const char *arg)
>  	}
>  }
>  
> +static void cmd_devices_paired(const char *arg)
> +{
> +	GList *list;
> +
> +	for (list = g_list_first(dev_list); list; list = g_list_next(list)) {
> +		DBusMessageIter iter;
> +		GDBusProxy *proxy = list->data;
> +		dbus_bool_t paired;
> +
> +		if (g_dbus_proxy_get_property(proxy, "Paired", &iter) == FALSE)
> +			return;
> +		dbus_message_iter_get_basic(&iter, &paired);
> +
> +		if (!paired)
> +			break;

Shouldn't this be
  if (!paired)
      continue;

? Or paired devices are guaranteed to be first on list?

> +
> +		print_device(proxy, NULL);
> +	}
> +}
> +
>  static void generic_callback(const DBusError *error, void *user_data)
>  {
>  	char *str = user_data;
> @@ -1047,6 +1067,8 @@ static const struct {
>  	{ "select",       "<ctrl>",   cmd_select, "Select default controller",
>  							ctrl_generator },
>  	{ "devices",      NULL,       cmd_devices, "List available devices" },
> +	{ "paired-devices", NULL,     cmd_devices_paired,
> +					"List paired devices"},
>  	{ "system-alias", "<name>",   cmd_system_alias },
>  	{ "reset-alias",  NULL,       cmd_reset_alias },
>  	{ "power",        "<on/off>", cmd_power, "Set controller power" },
> 

-- 
BR
Szymon Janc

