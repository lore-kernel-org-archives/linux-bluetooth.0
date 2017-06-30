Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH] Support to change set file via arg
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20170630172920.1968-1-shapiroc@chromium.org>
Date: Fri, 30 Jun 2017 19:42:55 +0200
Cc: linux-bluetooth@vger.kernel.org, Simon Glass <sjg@chromium.org>,
        C Shapiro <shapiroc@chromium.org>
Message-Id: <5A47203A-A671-4854-9EAB-B09B15AF7680@holtmann.org>
References: <20170630172920.1968-1-shapiroc@chromium.org>
To: C Shapiro <shapiroc@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Shapiro,

> Currently, there is an expectation of the main.conf file at a specific
> location.  This prevents system builds that support more than one
> platform.
> 
> This adds support so the main.conf file can be specified as a command
> line arg instead, so systems can manage multiple conf files as necessary
> and pass the appropriate conf file when the daemon is started.
> 
> Signed-off-by: C Shapiro <shapiroc@chromium.org>
> ---
> src/bluetoothd.8.in |  4 ++++
> src/main.c          | 12 +++++++++++-
> 2 files changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/src/bluetoothd.8.in b/src/bluetoothd.8.in
> index 97ef3ec94..d61dcc5b3 100644
> --- a/src/bluetoothd.8.in
> +++ b/src/bluetoothd.8.in
> @@ -27,6 +27,10 @@ Print bluetoothd options and exit.
> Enable logging in foreground. Directs log output to the controlling terminal \
> in addition to syslog.
> .TP
> +.B -f, --configfile
> +Specifies an explicit config file path instead of relying on the default path \
> +(@CONFIGDIR@/main.conf) for the config file.
> +.TP
> .B -d, --debug=<file1>:<file2>:...
> Sets how much information bluetoothd sends to the log destination (usually \
> syslog's "daemon" facility). If the file options are omitted, then debugging \
> diff --git a/src/main.c b/src/main.c
> index bcc1e6fae..87bdb66cb 100644
> --- a/src/main.c
> +++ b/src/main.c
> @@ -490,6 +490,7 @@ static guint setup_signalfd(void)
> static char *option_debug = NULL;
> static char *option_plugin = NULL;
> static char *option_noplugin = NULL;
> +static char *option_configfile = NULL;
> static gboolean option_compat = FALSE;
> static gboolean option_detach = TRUE;
> static gboolean option_version = FALSE;
> @@ -505,6 +506,9 @@ static void free_options(void)
> 
> 	g_free(option_noplugin);
> 	option_noplugin = NULL;
> +
> +	g_free(option_configfile);
> +	option_configfile = NULL;
> }
> 
> static void disconnect_dbus(void)
> @@ -577,6 +581,9 @@ static GOptionEntry options[] = {
> 				"Specify plugins to load", "NAME,..," },
> 	{ "noplugin", 'P', 0, G_OPTION_ARG_STRING, &option_noplugin,
> 				"Specify plugins not to load", "NAME,..." },
> +	{ "configfile", 'f', 0, G_OPTION_ARG_STRING, &option_configfile,
> +				"Specify an explicit path to the config file",
> +				"FILE”},

I am failing to understand why this is needed. What problem are you trying to solve here? Can you give an example.

Regards

Marcel

