Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Subject: Re: [PATCH BlueZ 9/9] client: Add unregister-descriptor command
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        <linux-bluetooth@vger.kernel.org>
References: <20170628125423.26208-1-luiz.dentz@gmail.com>
 <20170628125423.26208-10-luiz.dentz@gmail.com>
From: ERAMOTO Masaya <eramoto.masaya@jp.fujitsu.com>
Message-ID: <74e58cfd-5cba-2776-038f-69e9d9ff44e5@jp.fujitsu.com>
Date: Fri, 30 Jun 2017 16:30:16 +0900
MIME-Version: 1.0
In-Reply-To: <20170628125423.26208-10-luiz.dentz@gmail.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

It seems a memory leak occurs when do unregister-[characteristic|descriptor].
The following is valgrind output when I alternately repeated register and 
unregister three times.

==11130== 33 bytes in 3 blocks are definitely lost in loss record 69 of 190
==11130==    at 0x4C2DB8F: malloc (in /usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
==11130==    by 0x4E89718: g_malloc (in /lib/x86_64-linux-gnu/libglib-2.0.so.0.4800.2)
==11130==    by 0x4EA2527: g_memdup (in /lib/x86_64-linux-gnu/libglib-2.0.so.0.4800.2)
==11130==    by 0x40BB6A: str2bytearray (gatt.c:1229)
==11130==    by 0x40BC10: chrc_set_value (gatt.c:1238)
==11130==    by 0x409614: rl_release_prompt (display.c:161)
==11130==    by 0x407E6B: rl_handler (main.c:2375)
==11130==    by 0x53C16F4: rl_callback_read_char (in /lib/x86_64-linux-gnu/libreadline.so.6.3)
==11130==    by 0x40801C: input_handler (main.c:104)
==11130==    by 0x4E84049: g_main_context_dispatch (in /lib/x86_64-linux-gnu/libglib-2.0.so.0.4800.2)
==11130==    by 0x4E843EF: ??? (in /lib/x86_64-linux-gnu/libglib-2.0.so.0.4800.2)
==11130==    by 0x4E84711: g_main_loop_run (in /lib/x86_64-linux-gnu/libglib-2.0.so.0.4800.2)


On 2017年06月28日 21:54, Luiz Augusto von Dentz wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This adds unregister-descriptor which can be used to unregister
> descriptors registered with register-descriptor:
> 
> unregister-descriptor /org/bluez/app/service0xf48150/chrc0xf49a40/desc0xf4d350
> [DEL] Descriptor
> 	/org/bluez/app/service0xf48150/chrc0xf49a40/desc0xf4d350
> 	8260c653-1a54-426b-9e36-e84c238bc669
> 	Vendor specific
> ---
>  client/gatt.c | 46 ++++++++++++++++++++++++++++++++++++++++++++++
>  client/gatt.h |  2 ++
>  client/main.c | 25 +++++++++++++++++++++++++
>  3 files changed, 73 insertions(+)
> 
> diff --git a/client/gatt.c b/client/gatt.c
> index 7cfdc54..47bf0ae 100644
> --- a/client/gatt.c
> +++ b/client/gatt.c
> @@ -1461,3 +1461,49 @@ void gatt_register_desc(DBusConnection *conn, GDBusProxy *proxy, wordexp_t *w)
>  
>  	rl_prompt_input(desc->path, "Enter value:", desc_set_value, desc);
>  }
> +
> +static struct desc *desc_find(const char *pattern)
> +{
> +	GList *l, *lc, *ld;
> +	struct service *service;
> +	struct chrc *chrc;
> +	struct desc *desc;
> +
> +	for (l = local_services; l; l = g_list_next(l)) {
> +		service = l->data;
> +
> +		for (lc = service->chrcs; lc; lc = g_list_next(lc)) {
> +			chrc = lc->data;
> +
> +			for (ld = chrc->descs; ld; ld = g_list_next(ld)) {
> +				desc = ld->data;
> +
> +				/* match object path */
> +				if (!strcmp(desc->path, pattern))
> +					return desc;
> +
> +				/* match UUID */
> +				if (!strcmp(desc->uuid, pattern))
> +					return desc;
> +			}
> +		}
> +	}
> +
> +	return NULL;
> +}
> +
> +void gatt_unregister_desc(DBusConnection *conn, GDBusProxy *proxy,
> +								wordexp_t *w)
> +{
> +	struct desc *desc;
> +
> +	desc = desc_find(w->we_wordv[0]);
> +	if (!desc) {
> +		rl_printf("Failed to unregister descriptor object\n");
> +		return;
> +	}
> +
> +	desc->chrc->descs = g_list_remove(desc->chrc->descs, desc);
> +
> +	desc_unregister(desc);
> +}
> diff --git a/client/gatt.h b/client/gatt.h
> index 4d1e63f..8031a46 100644
> --- a/client/gatt.h
> +++ b/client/gatt.h
> @@ -54,3 +54,5 @@ void gatt_unregister_chrc(DBusConnection *conn, GDBusProxy *proxy,
>  								wordexp_t *w);
>  
>  void gatt_register_desc(DBusConnection *conn, GDBusProxy *proxy, wordexp_t *w);
> +void gatt_unregister_desc(DBusConnection *conn, GDBusProxy *proxy,
> +								wordexp_t *w);
> diff --git a/client/main.c b/client/main.c
> index 88dbdb3..985859c 100644
> --- a/client/main.c
> +++ b/client/main.c
> @@ -1949,6 +1949,28 @@ static void cmd_register_descriptor(const char *arg)
>  	wordfree(&w);
>  }
>  
> +static void cmd_unregister_descriptor(const char *arg)
> +{
> +	wordexp_t w;
> +
> +	if (check_default_ctrl() == FALSE)
> +		return;
> +
> +	if (wordexp(arg, &w, WRDE_NOCMD)) {
> +		rl_printf("Invalid argument\n");
> +		return;
> +	}
> +
> +	if (w.we_wordc < 1) {
> +		rl_printf("Missing arguments\n");
> +		return;

It seems that the memory of the variable w leaks.

> +	}
> +
> +	gatt_unregister_desc(dbus_conn, default_ctrl->proxy, &w);
> +
> +	wordfree(&w);
> +}
> +
>  static void cmd_version(const char *arg)
>  {
>  	rl_printf("Version %s\n", VERSION);
> @@ -2264,6 +2286,9 @@ static const struct {
>  	{ "register-descriptor", "<UUID> <Flags=read,write...>",
>  					cmd_register_descriptor,
>  					"Register application descriptor" },
> +	{ "unregister-descriptor", "<UUID/object>",
> +					cmd_unregister_descriptor,
> +					"Unregister application descriptor" },
>  	{ "version",      NULL,       cmd_version, "Display version" },
>  	{ "quit",         NULL,       cmd_quit, "Quit program" },
>  	{ "exit",         NULL,       cmd_quit, "Quit program" },
> 

Regards,
Eramoto
