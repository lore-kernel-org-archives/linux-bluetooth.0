Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.3 \(1503\))
Subject: Re: [PATCH 1/5] core: Add option to list available plugins
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1369951317-16789-1-git-send-email-szymon.janc@gmail.com>
Date: Fri, 31 May 2013 07:13:51 +0900
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <90A041DA-6E52-4FB3-8BFE-423FF3D8AC54@holtmann.org>
References: <1369951317-16789-1-git-send-email-szymon.janc@gmail.com>
To: Szymon Janc <szymon.janc@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

> This allows to list plugins names that can be passed with -p/-P
> options. This is usefull with binary provided by distribution to easily
> determine what plugins are supported.
> ---
> src/hcid.h   |    1 +
> src/main.c   |    8 ++++++++
> src/plugin.c |   47 +++++++++++++++++++++++++++++++++++++++++++++++
> 3 files changed, 56 insertions(+)
> 
> diff --git a/src/hcid.h b/src/hcid.h
> index ea67cc2..ff4a3c5 100644
> --- a/src/hcid.h
> +++ b/src/hcid.h
> @@ -43,6 +43,7 @@ extern struct main_opts main_opts;
> 
> gboolean plugin_init(const char *enable, const char *disable);
> void plugin_cleanup(void);
> +void plugin_list(void);
> 
> void rfkill_init(void);
> void rfkill_exit(void);
> diff --git a/src/main.c b/src/main.c
> index dc0478e..aea3e3f 100644
> --- a/src/main.c
> +++ b/src/main.c
> @@ -381,6 +381,7 @@ static guint setup_signalfd(void)
> static char *option_debug = NULL;
> static char *option_plugin = NULL;
> static char *option_noplugin = NULL;
> +static gboolean option_listplugins = FALSE;
> static gboolean option_compat = FALSE;
> static gboolean option_detach = TRUE;
> static gboolean option_version = FALSE;
> @@ -468,6 +469,8 @@ static GOptionEntry options[] = {
> 				"Specify plugins to load", "NAME,..," },
> 	{ "noplugin", 'P', 0, G_OPTION_ARG_STRING, &option_noplugin,
> 				"Specify plugins not to load", "NAME,..." },
> +	{ "list-plugins", 'l', 0, G_OPTION_ARG_NONE, &option_listplugins,
> +				"List available plugins", },

I am not in favor of doing this. Distributions should build it with the plugins that are useful for that distro and they should be enabled all the time. The disabling of plugins for for developers only.

Regards

Marcel

