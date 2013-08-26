Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1377187669-3691-1-git-send-email-christian.fetzer@oss.bmw-carit.de>
References: <1377187669-3691-1-git-send-email-christian.fetzer@oss.bmw-carit.de>
Date: Mon, 26 Aug 2013 15:33:01 +0300
Message-ID: <CABBYNZJi2BhJTgSa29m3-_fmA05yoxD62+CTi+gT0AJYf9ZzQw@mail.gmail.com>
Subject: Re: [PATCH 1/1] obexd: Fix memleak when unregistering MAP event handler
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Christian Fetzer <christian.fetzer@oss.bmw-carit.de>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Christian,

On Thu, Aug 22, 2013 at 7:07 PM, Christian Fetzer
<christian.fetzer@oss.bmw-carit.de> wrote:
> From: Christian Fetzer <christian.fetzer@bmw-carit.de>
>
> 96 bytes in 3 blocks are definitely lost in loss record 217 of 310
>   at 0x4C29E84: calloc (in /usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
>   by 0x5977858: g_malloc0 (in /usr/lib/libglib-2.0.so.0.3600.3)
>   by 0x433A87: map_register_event_handler (map-event.c:76)
>   by 0x4324C1: set_notification_registration (map.c:1722)
>   by 0x4325BB: map_probe (map.c:1801)
>   by 0x42D55C: obc_session_register (session.c:862)
>   by 0x42BE4B: create_callback (manager.c:100)
>   by 0x42CA0D: connect_cb (session.c:281)
>   by 0x4191CB: handle_response (gobex.c:949)
>   by 0x4196F0: incoming_data (gobex.c:1192)
>   by 0x5971DA5: g_main_context_dispatch (in /usr/lib/libglib-2.0.so.0.3600.3)
>   by 0x59720F7: ??? (in /usr/lib/libglib-2.0.so.0.3600.3)
> ---
>  obexd/client/map-event.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/obexd/client/map-event.c b/obexd/client/map-event.c
> index 76dfb84..bbe3519 100644
> --- a/obexd/client/map-event.c
> +++ b/obexd/client/map-event.c
> @@ -97,6 +97,7 @@ void map_unregister_event_handler(struct obc_session *session, int mas_id)
>         handlers = g_slist_remove(handlers, handler);
>         DBG("Handler %p for %s:%d unregistered", handler,
>                         obc_session_get_destination(session), mas_id);
> +       g_free(handler);
>  }
>
>  void map_dispatch_event(int mas_id, const char *device,
> --
> 1.8.3.4

Applied thanks.


-- 
Luiz Augusto von Dentz
