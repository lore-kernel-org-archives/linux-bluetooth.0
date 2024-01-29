Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA69615442D
	for <linux-bluetooth@vger.kernel.org>; Mon, 29 Jan 2024 15:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706542656; cv=none; b=YvVgXBSsK9HaiUs3Z5Wm2FiN7mATC5c7CnwsgxImOLdnF5VtSQhsivz8x5ui6Gefeo0Zd2HBgjwUkeFYRy3RZgVzSx2SwRNkNhNQKfYgZTZ3Xm67SSNDfIwmpwH1m2QbcTwOVQAnkhuk8lYJv5/TmnywBkkrv2dikmOxowH/HZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706542656; c=relaxed/simple;
	bh=B1RDRtxbW9YHYS2pr8x9oKCILyCsK99gSTol+4GaYZc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h3qG8kHVryHF1N/vFdWTxFGJ8t2x+M5boYFM161UYIbvmPdYkLvJDJ1uaMPkiv7Na1OaNnA+ZDayS2IzaVe3FwzasHTQFg3XCHxWSn7+rWp9bPeMAxCPjeT6Q/WkOEQi9kTj8BE4YVqxBSlhkv6ZgVxQeyiMJ1xiu1YzCepOJls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.220.34] (g34.guest.molgen.mpg.de [141.14.220.34])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id F0C2D61E5FE36;
	Mon, 29 Jan 2024 16:37:23 +0100 (CET)
Message-ID: <a97398e2-856b-4034-b8d3-e65f54b2bb17@molgen.mpg.de>
Date: Mon, 29 Jan 2024 16:37:23 +0100
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH BlueZ v4 7/8] bluetoothd: change plugin loading alike
 obexd
To: Emil Velikov <emil.velikov@collabora.com>
Cc: linux-bluetooth@vger.kernel.org, emil.l.velikov@gmail.com
References: <20240129-rm-ext-plugins-v4-0-bfd1e08c7f99@gmail.com>
 <20240129-rm-ext-plugins-v4-7-bfd1e08c7f99@gmail.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20240129-rm-ext-plugins-v4-7-bfd1e08c7f99@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Emil,


Thank you for your patches.

Am 29.01.24 um 15:44 schrieb Emil Velikov via B4 Relay:
> From: Emil Velikov <emil.velikov@collabora.com>
> 
> Currently, we print "Loading foobar" for every plugin, before we try the
> respective init() callback. Instead we handle the latter in a bunch, at
> the end of the process.

Excuse my ignorance, but would you be so kind to state the problem. It’s 
causing confusion to have `Loading foobar`, in case it fails? It 
clutters the output or uses unnecessory resources?

> Do the init() call early, print "Loaded" once it's actually successful
> and drop the no-longer "active" tracking.

It would help me, if you pasted the logs without and with your patch.


Kind regards,

Paul


> ---
>   src/plugin.c | 53 +++++++++++++++++++++++++++++------------------------
>   1 file changed, 29 insertions(+), 24 deletions(-)
> 
> diff --git a/src/plugin.c b/src/plugin.c
> index b6a84299a..e6d05be4c 100644
> --- a/src/plugin.c
> +++ b/src/plugin.c
> @@ -32,7 +32,6 @@ static GSList *plugins = NULL;
>   
>   struct bluetooth_plugin {
>   	void *handle;
> -	gboolean active;
>   	const struct bluetooth_plugin_desc *desc;
>   };
>   
> @@ -44,6 +43,22 @@ static int compare_priority(gconstpointer a, gconstpointer b)
>   	return plugin2->desc->priority - plugin1->desc->priority;
>   }
>   
> +static int init_plugin(const struct bluetooth_plugin_desc *desc)
> +{
> +	int err;
> +
> +	err = desc->init();
> +	if (err < 0) {
> +		if (err == -ENOSYS || err == -ENOTSUP)
> +			warn("System does not support %s plugin",
> +						desc->name);
> +		else
> +			error("Failed to init %s plugin",
> +						desc->name);
> +	}
> +	return err;
> +}
> +
>   static gboolean add_external_plugin(void *handle,
>   				const struct bluetooth_plugin_desc *desc)
>   {
> @@ -57,19 +72,22 @@ static gboolean add_external_plugin(void *handle,
>   		return FALSE;
>   	}
>   
> -	DBG("Loading %s plugin", desc->name);
> -
>   	plugin = g_try_new0(struct bluetooth_plugin, 1);
>   	if (plugin == NULL)
>   		return FALSE;
>   
>   	plugin->handle = handle;
> -	plugin->active = FALSE;
>   	plugin->desc = desc;
>   
> +	if (init_plugin(desc) < 0) {
> +		g_free(plugin);
> +		return FALSE;
> +	}
> +
>   	__btd_enable_debug(desc->debug_start, desc->debug_stop);
>   
>   	plugins = g_slist_insert_sorted(plugins, plugin, compare_priority);
> +	DBG("Plugin %s loaded", desc->name);
>   
>   	return TRUE;
>   }
> @@ -86,7 +104,13 @@ static void add_plugin(const struct bluetooth_plugin_desc *desc)
>   
>   	plugin->desc = desc;
>   
> +	if (init_plugin(desc) < 0) {
> +		g_free(plugin);
> +		return;
> +	}
> +
>   	plugins = g_slist_insert_sorted(plugins, plugin, compare_priority);
> +	DBG("Plugin %s loaded", desc->name);
>   }
>   
>   static gboolean enable_plugin(const char *name, char **cli_enable,
> @@ -177,7 +201,6 @@ static void external_plugin_init(char **cli_disabled, char **cli_enabled)
>   
>   void plugin_init(const char *enable, const char *disable)
>   {
> -	GSList *list;
>   	char **cli_disabled = NULL;
>   	char **cli_enabled = NULL;
>   	unsigned int i;
> @@ -205,24 +228,6 @@ void plugin_init(const char *enable, const char *disable)
>   	if IS_ENABLED(EXTERNAL_PLUGINS)
>   		external_plugin_init(cli_enabled, cli_disabled);
>   
> -	for (list = plugins; list; list = list->next) {
> -		struct bluetooth_plugin *plugin = list->data;
> -		int err;
> -
> -		err = plugin->desc->init();
> -		if (err < 0) {
> -			if (err == -ENOSYS || err == -ENOTSUP)
> -				warn("System does not support %s plugin",
> -							plugin->desc->name);
> -			else
> -				error("Failed to init %s plugin",
> -							plugin->desc->name);
> -			continue;
> -		}
> -
> -		plugin->active = TRUE;
> -	}
> -
>   	g_strfreev(cli_enabled);
>   	g_strfreev(cli_disabled);
>   }
> @@ -236,7 +241,7 @@ void plugin_cleanup(void)
>   	for (list = plugins; list; list = list->next) {
>   		struct bluetooth_plugin *plugin = list->data;
>   
> -		if (plugin->active == TRUE && plugin->desc->exit)
> +		if (plugin->desc->exit)
>   			plugin->desc->exit();
>   
>   		if (plugin->handle != NULL)
> 
