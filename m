Return-Path: <cyrus@holtmann.org>
Message-ID: <1349890997.27233.150.camel@aeonflux>
Subject: Re: [PATCH v3 04/10] adapter: Read device class in storage at init
From: Marcel Holtmann <marcel@holtmann.org>
To: =?ISO-8859-1?Q?Fr=E9d=E9ric?= Danis
	<frederic.danis@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Wed, 10 Oct 2012 19:43:17 +0200
In-Reply-To: <1349878219-14359-5-git-send-email-frederic.danis@linux.intel.com>
References: <1349878219-14359-1-git-send-email-frederic.danis@linux.intel.com>
	 <1349878219-14359-5-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Fred,

>  src/adapter.c |   21 ++++++++++++---------
>  1 file changed, 12 insertions(+), 9 deletions(-)
> 
> diff --git a/src/adapter.c b/src/adapter.c
> index 8b9af28..93dc0fb 100644
> --- a/src/adapter.c
> +++ b/src/adapter.c
> @@ -117,6 +117,7 @@ struct service_auth {
>  
>  struct btd_adapter_config {
>  	char *name;
> +	uint8_t class[3];
>  };

same as the other one. Directly in btd_adapter if you ask me.

>  
>  struct btd_adapter {
> @@ -729,6 +730,10 @@ void btd_adapter_class_changed(struct btd_adapter *adapter, uint8_t *new_class)
>  	if (class == adapter->dev_class)
>  		return;
>  
> +	adapter->config.class[0] = new_class[0];
> +	adapter->config.class[1] = new_class[1];
> +	adapter->config.class[2] = new_class[2];
> +
>  	write_local_class(&adapter->bdaddr, new_class);

Is this still needed this way. Should not just say, store_adapter_info
or something alike.

>  
>  	adapter->dev_class = class;
> @@ -2353,15 +2358,8 @@ void btd_adapter_get_mode(struct btd_adapter *adapter, uint8_t *mode,
>  void btd_adapter_read_class(struct btd_adapter *adapter, uint8_t *major,
>  								uint8_t *minor)
>  {
> -	uint8_t cls[3];
> -
> -	if (read_local_class(&adapter->bdaddr, cls) < 0) {
> -		uint32_t class = htobl(main_opts.class);
> -		memcpy(cls, &class, 3);
> -	}
> -
> -	*major = cls[1];
> -	*minor = cls[0];
> +	*major = adapter->config.class[1];
> +	*minor = adapter->config.class[0];
>  }

Actually this is no longer read_class, this would be get_major_minor.

>  
>  uint32_t btd_adapter_get_class(struct btd_adapter *adapter)
> @@ -2694,6 +2692,11 @@ static void load_config(struct btd_adapter *adapter)
>  	else
>  		adapter->config.name = g_strdup(name);
>  
> +	/* Get class */
> +	if (read_local_class(&adapter->bdaddr, adapter->config.class) < 0) {
> +		uint32_t class = htobl(main_opts.class);
> +		memcpy(adapter->config.class, &class, 3);
> +	}
>  }

I really want to open the file once and read it all at once. Multiple
reads seem to be wrong.

Regards

Marcel


