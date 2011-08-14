Return-Path: <cyrus@holtmann.org>
Subject: Re: [RFC v3 2/2] Fix debug messages logging from non-built-in
 plugins
From: Marcel Holtmann <marcel@holtmann.org>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org,
	par-gunnar.p.hjalmdahl@stericsson.com, ulrik.lauren@stericsson.com
Date: Sun, 14 Aug 2011 14:59:52 -0700
In-Reply-To: <1313068216-16802-3-git-send-email-szymon.janc@tieto.com>
References: <1313068216-16802-1-git-send-email-szymon.janc@tieto.com>
	 <1313068216-16802-3-git-send-email-szymon.janc@tieto.com>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1313359206.3373.173.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

>  src/log.c    |   38 +++++++++++++++++++++++++++++++-------
>  src/log.h    |    8 ++++++++
>  src/plugin.h |   15 +++++++++++++++
>  3 files changed, 54 insertions(+), 7 deletions(-)
> 
> diff --git a/src/log.c b/src/log.c
> index 2c492e9..ab4f92d 100644
> --- a/src/log.c
> +++ b/src/log.c
> @@ -68,8 +68,10 @@ void btd_debug(const char *format, ...)
>  
>  extern struct btd_debug_desc __start___debug[];
>  extern struct btd_debug_desc __stop___debug[];
> +static struct btd_debug_section debug_section;
>  
>  static gchar **enabled = NULL;
> +static GSList *debug_sections = NULL;
>  
>  static gboolean is_enabled(struct btd_debug_desc *desc)
>  {
> @@ -88,23 +90,27 @@ static gboolean is_enabled(struct btd_debug_desc *desc)
>  
>  void __btd_toggle_debug(void)
>  {
> -	struct btd_debug_desc *desc;
> +	GSList *l;
> +
> +	for (l = debug_sections; l; l = l->next) {
> +		struct btd_debug_section *s = l->data;
> +		struct btd_debug_desc *desc;
>  
> -	for (desc = __start___debug; desc < __stop___debug; desc++)
> -		desc->flags |= BTD_DEBUG_FLAG_PRINT;
> +		for (desc = s->start; desc < s->stop; desc++)
> +			desc->flags |= BTD_DEBUG_FLAG_PRINT;
> +	}
>  }
>  
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
> +	debug_section.start = __start___debug;
> +	debug_section.stop = __stop___debug;
> +	btd_log_add(&debug_section);
>  
>  	if (!detach)
>  		option |= LOG_PERROR;
> @@ -116,7 +122,25 @@ void __btd_log_init(const char *debug, int detach)
>  
>  void __btd_log_cleanup(void)
>  {
> +	btd_log_remove(&debug_section);
> +
>  	closelog();
>  
>  	g_strfreev(enabled);
>  }
> +
> +void btd_log_add(struct btd_debug_section *s)
> +{
> +	struct btd_debug_desc *desc;
> +
> +	for (desc = s->start; desc < s->stop; desc++)
> +		if (is_enabled(desc))
> +			desc->flags |= BTD_DEBUG_FLAG_PRINT;
> +
> +	debug_sections = g_slist_prepend(debug_sections, s);
> +}
> +
> +void btd_log_remove(struct btd_debug_section *s)
> +{
> +	debug_sections = g_slist_remove(debug_sections, s);
> +}
> diff --git a/src/log.h b/src/log.h
> index 78bbdd8..960c05c 100644
> --- a/src/log.h
> +++ b/src/log.h
> @@ -37,6 +37,14 @@ struct btd_debug_desc {
>  	unsigned int flags;
>  } __attribute__((aligned(8)));
>  
> +struct btd_debug_section {
> +	struct btd_debug_desc *start;
> +	struct btd_debug_desc *stop;
> +};
> +
> +void btd_log_add(struct btd_debug_section *s);
> +void btd_log_remove(struct btd_debug_section *s);
> +
>  /**
>   * DBG:
>   * @fmt: format string
> diff --git a/src/plugin.h b/src/plugin.h
> index 30bd415..5556cf5 100644
> --- a/src/plugin.h
> +++ b/src/plugin.h
> @@ -39,6 +39,21 @@ struct bluetooth_plugin_desc {
>  		};
>  #else
>  #define BLUETOOTH_PLUGIN_DEFINE(name, version, priority, init, exit) \
> +		extern struct btd_debug_desc __start___debug[] \
> +				__attribute__ ((visibility("hidden"))); \
> +		extern struct btd_debug_desc __stop___debug[] \
> +				__attribute__ ((visibility("hidden"))); \
> +		static struct btd_debug_section __ds; \
> +		static void __attribute__((constructor)) log_init(void) \
> +		{ \
> +			__ds.start = __start___debug; \
> +			__ds.stop = __stop___debug; \
> +			btd_log_add(&__ds); \
> +		} \
> +		static void __attribute__((destructor)) log_fini(void) \
> +		{ \
> +			btd_log_remove(&__ds); \
> +		} \
>  		extern struct bluetooth_plugin_desc bluetooth_plugin_desc \
>  				__attribute__ ((visibility("default"))); \
>  		struct bluetooth_plugin_desc bluetooth_plugin_desc = { \

after looking into this struct, I got the feeling that this is all a bit
too complicated. So I took rolled my own patch to support debug messages
from external plugins.

As far as I tested it works fine. Only exception is that you can not
toggle debug messages of external plugins via SIGUSR2, but that is
actually acceptable to me.

Have a look at this and see if it works for you as well.

Regards

Marcel


