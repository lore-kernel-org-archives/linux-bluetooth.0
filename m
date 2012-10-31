Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: =?ISO-8859-1?Q?Fr=E9d=E9ric?= Danis
	<frederic.danis@linux.intel.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH v10 4/6] dbusoob: Set device name in device object
Date: Wed, 31 Oct 2012 08:22:04 +0100
Message-ID: <14230948.4LRRcOUNYX@uw000953>
In-Reply-To: <1351616728-10075-4-git-send-email-frederic.danis@linux.intel.com>
References: <1351616728-10075-1-git-send-email-frederic.danis@linux.intel.com> <1351616728-10075-4-git-send-email-frederic.danis@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Frédéric,

On Tuesday 30 of October 2012 19:05:26 Frédéric Danis wrote:
> ---
>  plugins/dbusoob.c |   11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/plugins/dbusoob.c b/plugins/dbusoob.c
> index 5c5b6ef..0278941 100644
> --- a/plugins/dbusoob.c
> +++ b/plugins/dbusoob.c
> @@ -193,6 +193,7 @@ static gboolean parse_data(DBusMessageIter *data, struct oob_data *remote_data)
>  
>  static gboolean store_data(struct btd_adapter *adapter, struct oob_data *data)
>  {
> +	bdaddr_t local = *adapter_get_address(adapter);
>  	bdaddr_t bdaddr;
>  
>  	str2ba(data->addr, &bdaddr);
> @@ -207,9 +208,13 @@ static gboolean store_data(struct btd_adapter *adapter, struct oob_data *data)
>  		write_remote_class(adapter_get_address(adapter), &bdaddr,
>  								data->class);
>  
> -	if (data->name)
> -		write_device_name(adapter_get_address(adapter), &bdaddr, 0,
> -								data->name);
> +	if (data->name) {
> +		char *str;
> +
> +		str = g_strdup(data->name);
> +		btd_event_remote_name(&local, &bdaddr, str);
> +		g_free(str);

Is this g_strdup needed? Why not just pass data->name directly?

> +	}
>  
>  	return TRUE;
>  }
> -- 
> 1.7.9.5
> 

-- 
BR
Szymon Janc
