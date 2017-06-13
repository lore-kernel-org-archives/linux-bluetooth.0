Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v3] core/gatt: Add GATT.Cache config option
In-Reply-To: <20170609130258.23401-1-luiz.dentz@gmail.com>
References: <20170609130258.23401-1-luiz.dentz@gmail.com>
Date: Tue, 13 Jun 2017 10:44:00 -0700
Message-ID: <87h8zjg4v3.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

Luiz Augusto von Dentz <luiz.dentz@gmail.com> writes:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> This adds GATT.Cache config option to main.conf which can be used
> to adjust the cache expected behavior of attributes found over GATT.
> ---
>  src/device.c  | 28 ++++++++++++++++++++++++++++
>  src/hcid.h    |  7 +++++++
>  src/main.c    | 26 +++++++++++++++++++++++++-
>  src/main.conf |  6 ++++++
>  4 files changed, 66 insertions(+), 1 deletion(-)
>

[...]

>
> +static void parse_gatt_cache(const char *cache)
> +{
> +	if (!strcmp(cache, "always")) {
> +		main_opts.gatt_cache = BT_GATT_CACHE_ALWAYS;
> +	} else if (!strcmp(cache, "yes")) {
> +		main_opts.gatt_cache = BT_GATT_CACHE_YES;
> +	} else if (!strcmp(cache, "no")) {
> +		main_opts.gatt_cache = BT_GATT_CACHE_NO;
> +	} else {
> +		DBG("Invalid value for KeepCache=%s", cache);
> +	}

[optional] I wonder if making this return the enum, and return the
default if 'cache' is NULL, would make the code clearer.

> +}
> +
>  static void check_config(GKeyFile *config)
>  {
> -	const char *valid_groups[] = { "General", "Policy", NULL };
> +	const char *valid_groups[] = { "General", "Policy", "GATT", NULL };
>  	char **keys;
>  	int i;
>
> @@ -357,6 +370,17 @@ static void parse_config(GKeyFile *config)
>  		g_clear_error(&err);
>  	else
>  		main_opts.fast_conn = boolean;
> +
> +	str = g_key_file_get_string(config, "GATT", "Cache", &err);
> +	if (err) {
> +		g_clear_error(&err);
> +		main_opts.gatt_cache = BT_GATT_CACHE_ALWAYS;
> +		return;
> +	}
> +
> +	parse_gatt_cache(str);
> +
> +	g_free(str);
>  }
>
>  static void init_defaults(void)
> diff --git a/src/main.conf b/src/main.conf
> index a649276..7807a8f 100644
> --- a/src/main.conf
> +++ b/src/main.conf
> @@ -71,6 +71,12 @@
>  # Defaults to "off"
>  # Privacy = off
>
> +[GATT]
> +# GATT attribute cache.
> +# Possible values: always, yes, no
> +# Default: always
> +#Cache = always
> +
>  [Policy]
>  #
>  # The ReconnectUUIDs defines the set of remote services that should try
> --
> 2.9.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


Cheers,
--
Vinicius
