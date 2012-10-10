Return-Path: <cyrus@holtmann.org>
Message-ID: <1349890472.27233.142.camel@aeonflux>
Subject: Re: [PATCH v3 02/10] adapter: Read name in storage at init
From: Marcel Holtmann <marcel@holtmann.org>
To: =?ISO-8859-1?Q?Fr=E9d=E9ric?= Danis
	<frederic.danis@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Wed, 10 Oct 2012 19:34:32 +0200
In-Reply-To: <1349878219-14359-3-git-send-email-frederic.danis@linux.intel.com>
References: <1349878219-14359-1-git-send-email-frederic.danis@linux.intel.com>
	 <1349878219-14359-3-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Fred,

>  src/adapter.c |   34 ++++++++++++++++++++++++++++++++++
>  src/adapter.h |    1 +
>  2 files changed, 35 insertions(+)
> 
> diff --git a/src/adapter.c b/src/adapter.c
> index ad8ee06..8b9af28 100644
> --- a/src/adapter.c
> +++ b/src/adapter.c
> @@ -115,6 +115,10 @@ struct service_auth {
>  	struct agent *agent;		/* NULL for queued auths */
>  };
>  
> +struct btd_adapter_config {
> +	char *name;
> +};
> +

why are we bothering we a separate config here? I think that should be
just put into btd_adapter.

>  struct btd_adapter {
>  	uint16_t dev_id;
>  	gboolean up;
> @@ -155,6 +159,8 @@ struct btd_adapter {
>  	gboolean pairable;		/* pairable state */
>  	gboolean initialized;
>  
> +	struct btd_adapter_config config;
> +
>  	gboolean off_requested;		/* DEVDOWN ioctl was called */
>  
>  	gint ref;
> @@ -780,11 +786,24 @@ int adapter_set_name(struct btd_adapter *adapter, const char *name)
>  		adapter->name = g_strdup(maxname);
>  	}
>  
> +	g_free(adapter->config.name);
> +	adapter->config.name = g_strdup(maxname);
> +
>  	write_local_name(&adapter->bdaddr, maxname);
>  
>  	return 0;
>  }
>  
> +int adapter_get_config_name(struct btd_adapter *adapter, char **name)
> +{
> +	if (adapter->config.name == NULL)
> +		return -EINVAL;
> +
> +	*name = adapter->config.name;
> +
> +	return 0;
> +}
> +

Who is the user of this. And why not just return const char *.

>  static void set_name(struct btd_adapter *adapter, const char *name,
>  						GDBusPendingPropertySet id)
>  {
> @@ -2665,6 +2684,18 @@ void btd_adapter_unref(struct btd_adapter *adapter)
>  	g_free(path);
>  }
>  
> +static void load_config(struct btd_adapter *adapter)
> +{
> +	char name[MAX_NAME_LENGTH + 1];
> +
> +	/* Get name */
> +	if (read_local_name(&adapter->bdaddr, name) < 0)
> +		adapter->config.name = NULL;
> +	else
> +		adapter->config.name = g_strdup(name);
> +
> +}
> +
>  gboolean adapter_init(struct btd_adapter *adapter, gboolean up)
>  {
>  	adapter->up = up;
> @@ -2684,6 +2715,7 @@ gboolean adapter_init(struct btd_adapter *adapter, gboolean up)
>  	if (main_opts.gatt_enabled)
>  		btd_adapter_gatt_server_start(adapter);
>  
> +	load_config(adapter);
>  	load_drivers(adapter);
>  	btd_profile_foreach(probe_profile, adapter);
>  	clear_blocked(adapter);
> @@ -2752,6 +2784,8 @@ void adapter_remove(struct btd_adapter *adapter)
>  	/* Return adapter to down state if it was not up on init */
>  	if (!adapter->already_up && adapter->up)
>  		mgmt_set_powered(adapter->dev_id, FALSE);
> +
> +	g_free(adapter->config.name);
>  }
>  
>  uint16_t adapter_get_dev_id(struct btd_adapter *adapter)
> diff --git a/src/adapter.h b/src/adapter.h
> index b5bff10..b575c1b 100644
> --- a/src/adapter.h
> +++ b/src/adapter.h
> @@ -133,6 +133,7 @@ void adapter_update_found_devices(struct btd_adapter *adapter,
>  void adapter_emit_device_found(struct btd_adapter *adapter,
>  						struct remote_dev_info *dev);
>  void adapter_mode_changed(struct btd_adapter *adapter, uint8_t scan_mode);
> +int adapter_get_config_name(struct btd_adapter *adapter, char **name);
>  int adapter_set_name(struct btd_adapter *adapter, const char *name);
>  void adapter_name_changed(struct btd_adapter *adapter, const char *name);
>  void adapter_service_insert(struct btd_adapter *adapter, void *rec);

Regards

Marcel


