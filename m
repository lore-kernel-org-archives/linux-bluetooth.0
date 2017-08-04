Return-Path: <eramoto.masaya@jp.fujitsu.com>
Subject: Re: [PATCH v4] Support to change set file via arg
To: C Shapiro <shapiroc@chromium.org>, <linux-bluetooth@vger.kernel.org>
CC: Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Marcel Holtmann
	<marcel@holtmann.org>
References: <20170803172003.81839-1-shapiroc@chromium.org>
From: ERAMOTO Masaya <eramoto.masaya@jp.fujitsu.com>
Message-ID: <b46fd4a8-df9c-9311-d014-f06e00a9f9fe@jp.fujitsu.com>
Date: Fri, 4 Aug 2017 14:33:17 +0900
MIME-Version: 1.0
In-Reply-To: <20170803172003.81839-1-shapiroc@chromium.org>
Content-Type: text/plain; charset="utf-8"
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Charles,

I could not apply this patch to upstream because perhaps changes of
check_config() were strange.

  Applying: 
  error: patch failed: src/main.c:192
  error: src/main.c: patch does not apply

Could you rebase this and rewrite a simpler commit message?
Btw, there is the following description at "Submitting patches" in
HACKING text.

   1) Do *not* add "Signed-off-by" lines in your commit messages. BlueZ does not
   use them, so including them is actually an error.


Regards,
Eramoto

On 08/04/2017 02:20 AM, C Shapiro wrote:
> ChromeOS is currently shifting to a more dynamic build system where a
> single build will be created/managed/deployed to support multiple models
> that were all created based on a single reference board.
> 
> This is being done for general cost/maintenance savings around the sheer
> number of builds that are currently managed for ChromeOS.
> 
> To support this, we're changing our build images to have all of the
> configuration available for all of the models supported by a given
> build.
> 
> For the bluetooth stack, models have different product id values in the
> DeviceID field for the main.conf config file.
> 
> E.g.
>  - https://chromium.googlesource.com/chromiumos/overlays/board-overlays/+/master/overlay-pyro/chromeos-base/chromeos-bsp-pyro/files/main.conf
>  - https://chromium.googlesource.com/chromiumos/overlays/board-overlays/+/master/overlay-reef/chromeos-base/chromeos-bsp-reef/files/main.conf
>  - https://chromium.googlesource.com/chromiumos/overlays/board-overlays/+/master/overlay-snappy/chromeos-base/chromeos-bsp-snappy/files/main.conf
> 
> This change allows the config file to be passed as a runtime argument to
> bluetoothd, which allows the ChromeOS init script to determine the model
> at runtime and then pass the appropriate model specific config file.
> 
> This change is also beneficial in general development since the conf
> file can be easily edited and the src file location then be used
> directly.
> 
> Signed-off-by: C Shapiro <shapiroc@chromium.org>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> ---
> Changes in v4:
> - Based on feedback about the utility of the change for local
> testing/debug, change all of the log messages that reference main.conf
> to log the full path to the instance of main.conf that was used.
> 
>  src/bluetoothd.8.in |  4 ++++
>  src/main.c          | 22 ++++++++++++++++++----
>  2 files changed, 22 insertions(+), 4 deletions(-)
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
> index bcc1e6fae..cf12ca3fe 100644
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
> @@ -172,7 +173,8 @@ static void check_config(GKeyFile *config)
>  		}
>  
>  		if (!match)
> -			warn("Unknown group %s in main.conf", keys[i]);
> +			warn("Unknown group %s in %s", keys[i],
> +						main_conf_file_path);
>  	}
>  
>  	g_strfreev(keys);
> @@ -192,7 +194,8 @@ static void check_config(GKeyFile *config)
>  		}
>  
>  		if (!found)
> -			warn("Unknown key %s in main.conf", keys[i]);
> +			warn("Unknown key %s in %s", keys[i],
> +						main_conf_file_path);
>  	}
>  
>  	g_strfreev(keys);
> @@ -224,7 +227,7 @@ static void parse_config(GKeyFile *config)
>  
>  	check_config(config);
>  
> -	DBG("parsing main.conf");
> +	DBG("parsing %s", main_conf_file_path);
>  
>  	val = g_key_file_get_integer(config, "General",
>  						"DiscoverableTimeout", &err);
> @@ -490,6 +493,7 @@ static guint setup_signalfd(void)
>  static char *option_debug = NULL;
>  static char *option_plugin = NULL;
>  static char *option_noplugin = NULL;
> +static char *option_configfile = NULL;
>  static gboolean option_compat = FALSE;
>  static gboolean option_detach = TRUE;
>  static gboolean option_version = FALSE;
> @@ -505,6 +509,9 @@ static void free_options(void)
>  
>  	g_free(option_noplugin);
>  	option_noplugin = NULL;
> +
> +	g_free(option_configfile);
> +	option_configfile = NULL;
>  }
>  
>  static void disconnect_dbus(void)
> @@ -577,6 +584,9 @@ static GOptionEntry options[] = {
>  				"Specify plugins to load", "NAME,..," },
>  	{ "noplugin", 'P', 0, G_OPTION_ARG_STRING, &option_noplugin,
>  				"Specify plugins not to load", "NAME,..." },
> +	{ "configfile", 'f', 0, G_OPTION_ARG_STRING, &option_configfile,
> +				"Specify an explicit path to the config file",
> +				"FILE"},
>  	{ "compat", 'C', 0, G_OPTION_ARG_NONE, &option_compat,
>  				"Provide deprecated command line interfaces" },
>  	{ "experimental", 'E', 0, G_OPTION_ARG_NONE, &option_experimental,
> @@ -636,8 +646,12 @@ int main(int argc, char *argv[])
>  
>  	sd_notify(0, "STATUS=Starting up");
>  
> -	main_conf = load_config(CONFIGDIR "/main.conf");
> +	if (option_configfile)
> +		main_conf_file_path = option_configfile;
> +	else
> +		main_conf_file_path = CONFIGDIR "/main.conf";
>  
> +	main_conf = load_config(main_conf_file_path);
>  	parse_config(main_conf);
>  
>  	if (connect_dbus() < 0) {
> 
