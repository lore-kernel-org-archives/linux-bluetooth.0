Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Subject: Re: [PATCH v5] Support to set main.conf file location via cl arg
To: <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC: C Shapiro <shapiroc@chromium.org>,
        Marcel Holtmann <marcel@holtmann.org>
References: <20170804213423.118259-1-shapiroc@chromium.org>
From: ERAMOTO Masaya <eramoto.masaya@jp.fujitsu.com>
Message-ID: <71582bb7-35cd-6682-13e6-f88b73bda1ae@jp.fujitsu.com>
Date: Mon, 7 Aug 2017 10:10:42 +0900
MIME-Version: 1.0
In-Reply-To: <20170804213423.118259-1-shapiroc@chromium.org>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

This patch does not seem to have problems as far as I confirmed.
Do you have any problems with merging this patch?


Regards,
Eramoto

On 08/05/2017 06:34 AM, C Shapiro wrote:
> Adds command line arg, which allows the caller to set the location of
> the conf file used.
> 
> This allows system builds that easily support multiple bluetooth configs
> (e.g. ChromeOS) and also makes debugging/testing easier.
> 
> Reviewed-by: Simon Glass <sjg@chromium.org>
> ---
> Changes in v5:
> - Rebased the change to master
> - Simplified the commit message
> 
>  src/bluetoothd.8.in |  4 ++++
>  src/main.c          | 23 ++++++++++++++++++-----
>  2 files changed, 22 insertions(+), 5 deletions(-)
> 
> diff --git a/src/bluetoothd.8.in b/src/bluetoothd.8.in
> index 97ef3ec94..d61dcc5b3 100644
> --- a/src/bluetoothd.8.in
> +++ b/src/bluetoothd.8.in
> @@ -27,6 +27,10 @@ Print bluetoothd options and exit.
>  Enable logging in foreground. Directs log output to the controlling terminal \
>  in addition to syslog.
>  .TP
> +.B -f, --configfile
> +Specifies an explicit config file path instead of relying on the default path \
> +(@CONFIGDIR@/main.conf) for the config file.
> +.TP
>  .B -d, --debug=<file1>:<file2>:...
>  Sets how much information bluetoothd sends to the log destination (usually \
>  syslog's "daemon" facility). If the file options are omitted, then debugging \
> diff --git a/src/main.c b/src/main.c
> index 805d33023..08393a971 100644
> --- a/src/main.c
> +++ b/src/main.c
> @@ -69,6 +69,7 @@
>  
>  struct main_opts main_opts;
>  static GKeyFile *main_conf;
> +static char *main_conf_file_path;
>  
>  static enum {
>  	MPS_OFF,
> @@ -209,8 +210,8 @@ static void check_options(GKeyFile *config, const char *group,
>  		}
>  
>  		if (!found)
> -			warn("Unknown key %s for group %s in main.conf",
> -							keys[i], group);
> +			warn("Unknown key %s for group %s in %s",
> +					keys[i], group, main_conf_file_path);
>  	}
>  
>  	g_strfreev(keys);
> @@ -238,7 +239,8 @@ static void check_config(GKeyFile *config)
>  		}
>  
>  		if (!match)
> -			warn("Unknown group %s in main.conf", keys[i]);
> +			warn("Unknown group %s in %s", keys[i],
> +						main_conf_file_path);
>  	}
>  
>  	g_strfreev(keys);
> @@ -273,7 +275,7 @@ static void parse_config(GKeyFile *config)
>  
>  	check_config(config);
>  
> -	DBG("parsing main.conf");
> +	DBG("parsing %s", main_conf_file_path);
>  
>  	val = g_key_file_get_integer(config, "General",
>  						"DiscoverableTimeout", &err);
> @@ -550,6 +552,7 @@ static guint setup_signalfd(void)
>  static char *option_debug = NULL;
>  static char *option_plugin = NULL;
>  static char *option_noplugin = NULL;
> +static char *option_configfile = NULL;
>  static gboolean option_compat = FALSE;
>  static gboolean option_detach = TRUE;
>  static gboolean option_version = FALSE;
> @@ -565,6 +568,9 @@ static void free_options(void)
>  
>  	g_free(option_noplugin);
>  	option_noplugin = NULL;
> +
> +	g_free(option_configfile);
> +	option_configfile = NULL;
>  }
>  
>  static void disconnect_dbus(void)
> @@ -637,6 +643,8 @@ static GOptionEntry options[] = {
>  				"Specify plugins to load", "NAME,..," },
>  	{ "noplugin", 'P', 0, G_OPTION_ARG_STRING, &option_noplugin,
>  				"Specify plugins not to load", "NAME,..." },
> +	{ "configfile", 'f', 0, G_OPTION_ARG_STRING, &option_configfile,
> +			"Specify an explicit path to the config file", "FILE"},
>  	{ "compat", 'C', 0, G_OPTION_ARG_NONE, &option_compat,
>  				"Provide deprecated command line interfaces" },
>  	{ "experimental", 'E', 0, G_OPTION_ARG_NONE, &option_experimental,
> @@ -696,7 +704,12 @@ int main(int argc, char *argv[])
>  
>  	sd_notify(0, "STATUS=Starting up");
>  
> -	main_conf = load_config(CONFIGDIR "/main.conf");
> +	if (option_configfile)
> +		main_conf_file_path = option_configfile;
> +	else
> +		main_conf_file_path = CONFIGDIR "/main.conf";
> +
> +	main_conf = load_config(main_conf_file_path);
>  
>  	parse_config(main_conf);
>  
> 

