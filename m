Return-Path: <cyrus@holtmann.org>
Subject: Re: [RFC v2 1/2] Fix debug messages logging from non-built-in
 plugins
From: Marcel Holtmann <marcel@holtmann.org>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org,
	par-gunnar.p.hjalmdahl@stericsson.com, ulrik.lauren@stericsson.com
Date: Sun, 07 Aug 2011 13:02:58 +0200
In-Reply-To: <1312385452-9770-2-git-send-email-szymon.janc@tieto.com>
References: <1312385452-9770-1-git-send-email-szymon.janc@tieto.com>
	 <1312385452-9770-2-git-send-email-szymon.janc@tieto.com>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1312714979.3373.71.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

>  Makefile.am       |    3 ++-
>  src/bluetooth.ver |    2 ++
>  src/log.c         |   49 +++++++++++++++++++++++++++++++++++++++----------
>  src/log.h         |    2 ++
>  src/plugin.c      |    8 ++++++--
>  5 files changed, 51 insertions(+), 13 deletions(-)
> 
> diff --git a/Makefile.am b/Makefile.am
> index 68380d9..083ad27 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -285,7 +285,8 @@ src_bluetoothd_SOURCES = $(gdbus_sources) $(builtin_sources) \
>  src_bluetoothd_LDADD = lib/libbluetooth.la @GLIB_LIBS@ @DBUS_LIBS@ \
>  							@CAPNG_LIBS@ -ldl -lrt
>  src_bluetoothd_LDFLAGS = -Wl,--export-dynamic \
> -				-Wl,--version-script=$(srcdir)/src/bluetooth.ver
> +			 -Wl,--version-script=$(srcdir)/src/bluetooth.ver \
> +			 -Wl,-u__start___debug -Wl,-u__stop___debug

Remind me again, we we need them here and in the bluetooth.ver file?
 
>  src_bluetoothd_DEPENDENCIES = lib/libbluetooth.la
>  
> diff --git a/src/bluetooth.ver b/src/bluetooth.ver
> index b71c70d..6ff0df2 100644
> --- a/src/bluetooth.ver
> +++ b/src/bluetooth.ver
> @@ -5,6 +5,8 @@
>  		info;
>  		error;
>  		debug;
> +		__start___debug;
> +		__stop___debug;
>  	local:
>  		*;
>  };

And why are they needed to be exported here. This means that also every
single plugin can access them.

> diff --git a/src/log.c b/src/log.c
> index 2c492e9..9d89f7d 100644
> --- a/src/log.c
> +++ b/src/log.c
> @@ -28,6 +28,7 @@
>  #include <stdio.h>
>  #include <stdarg.h>
>  #include <syslog.h>
> +#include <dlfcn.h>
>  
>  #include <glib.h>
>  
> @@ -66,10 +67,8 @@ void btd_debug(const char *format, ...)
>  	va_end(ap);
>  }
>  
> -extern struct btd_debug_desc __start___debug[];
> -extern struct btd_debug_desc __stop___debug[];
> -
>  static gchar **enabled = NULL;
> +static GSList *handles = NULL;
>  
>  static gboolean is_enabled(struct btd_debug_desc *desc)
>  {
> @@ -88,23 +87,27 @@ static gboolean is_enabled(struct btd_debug_desc *desc)
>  
>  void __btd_toggle_debug(void)
>  {
> -	struct btd_debug_desc *desc;
> +	GSList *l;
> +
> +	for (l = handles; l; l = l->next) {
> +		struct btd_debug_desc *start, *stop;
>  
> -	for (desc = __start___debug; desc < __stop___debug; desc++)
> -		desc->flags |= BTD_DEBUG_FLAG_PRINT;
> +		start = dlsym(l->data, "__start___debug");
> +		stop = dlsym(l->data, "__stop___debug");
> +
> +		for (; start < stop; start++)
> +			start->flags |= BTD_DEBUG_FLAG_PRINT;
> +	}
>  }

We might wanna check if the symbols actually exist first. It think it is
perfectly valid to have plugins without any debug symbols.

And after reading the rest of this patch, you confused me even more. Why
to we have to dlsym the symbols again. Can we not just store them. I
think this is a bit of waste.
 
>  void __btd_log_init(const char *debug, int detach)
>  {
>  	int option = LOG_NDELAY | LOG_PID;
> -	struct btd_debug_desc *desc;
>  
>  	if (debug != NULL)
>  		enabled = g_strsplit_set(debug, ":, ", 0);
>  
> -	for (desc = __start___debug; desc < __stop___debug; desc++)
> -		if (is_enabled(desc))
> -			desc->flags |= BTD_DEBUG_FLAG_PRINT;
> +	__btd_log_add(NULL);
>  
>  	if (!detach)
>  		option |= LOG_PERROR;
> @@ -116,7 +119,33 @@ void __btd_log_init(const char *debug, int detach)
>  
>  void __btd_log_cleanup(void)
>  {
> +	__btd_log_remove(NULL);
> +
>  	closelog();
>  
>  	g_strfreev(enabled);
>  }
> +
> +void __btd_log_add(void *handle)
> +{
> +	struct btd_debug_desc *start, *stop;
> +
> +	start = dlsym(handle, "__start___debug");
> +	stop = dlsym(handle, "__stop___debug");
> +
> +	if (!start || !stop) {
> +		DBG("No __debug section found");
> +		return;
> +	}

So here you check the existence of start and stop. So why not store
these entry points as well.

And please to start == NULL || stop == NULL.

> +	for (; start < stop; start++)
> +		if (is_enabled(start))
> +			start->flags |= BTD_DEBUG_FLAG_PRINT;
> +
> +	handles = g_slist_prepend(handles, handle);
> +}
> +
> +void __btd_log_remove(void *handle)
> +{
> +	handles = g_slist_remove(handles, handle);
> +}
> diff --git a/src/log.h b/src/log.h
> index 78bbdd8..6bb1a96 100644
> --- a/src/log.h
> +++ b/src/log.h
> @@ -29,6 +29,8 @@ void btd_debug(const char *format, ...) __attribute__((format(printf, 1, 2)));
>  void __btd_log_init(const char *debug, int detach);
>  void __btd_log_cleanup(void);
>  void __btd_toggle_debug(void);
> +void __btd_log_add(void *handle);
> +void __btd_log_remove(void *handle);
>  
>  struct btd_debug_desc {
>  	const char *file;
> diff --git a/src/plugin.c b/src/plugin.c
> index 3506553..05855de 100644
> --- a/src/plugin.c
> +++ b/src/plugin.c
> @@ -202,7 +202,9 @@ gboolean plugin_init(GKeyFile *config, const char *enable, const char *disable)
>  			continue;
>  		}
>  
> -		if (add_plugin(handle, desc) == FALSE)
> +		if (add_plugin(handle, desc) == TRUE)
> +			__btd_log_add(handle);
> +		else
>  			dlclose(handle);
>  	}
>  
> @@ -239,8 +241,10 @@ void plugin_cleanup(void)
>  		if (plugin->active == TRUE && plugin->desc->exit)
>  			plugin->desc->exit();
>  
> -		if (plugin->handle != NULL)
> +		if (plugin->handle != NULL) {
> +			__btd_log_remove(plugin->handle);
>  			dlclose(plugin->handle);
> +		}
>  
>  		g_free(plugin);
>  	}

So besides the fact that I think we should store the plugin start and
stop symbols and the weird linker requirements, this looks good.

Regards

Marcel


