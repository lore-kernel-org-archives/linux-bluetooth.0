Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1417003176-15649-1-git-send-email-chethan.tn@samsung.com>
References: <1417003176-15649-1-git-send-email-chethan.tn@samsung.com>
Date: Mon, 1 Dec 2014 12:57:27 +0200
Message-ID: <CABBYNZJP4LcKiUc9dY=9CG3dbgqRg9zBL51gAm2WpO+y8N=TeA@mail.gmail.com>
Subject: Re: [PATCH] audio/AVDTP: Fix crash during an ongoing a2dp connection
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Chethan T N <chethan.tn@samsung.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Wed, Nov 26, 2014 at 1:59 PM, Chethan T N <chethan.tn@samsung.com> wrote:
> Crash observed when bluetoothd shutdown during an ongoing
> a2dp connection
>
>     0  0x00000000 in ?? ()
>     1  0xb6e90fa4 in finalize_discovery (session=0xb6f24d08, err=<value optimized out>) at profiles/audio/avdtp.c:1232
>     2  0xb6e8da36 in sink_free (service=<value optimized out>) at profiles/audio/sink.c:316
>     3  sink_unregister (service=<value optimized out>) at profiles/audio/sink.c:348
>     4  0xb6eccf5c in service_remove (service=0xb6f2b7e8) at src/service.c:174
>     5  0xb6ed325c in device_remove (device=0xb6f2b828, remove_stored=0) at src/device.c:3667
>     6  0xb6ec0234 in adapter_remove (adapter=0xb6f1f670) at src/adapter.c:5842
>     7  0xb6eca4e6 in adapter_unregister (index=<value optimized out>, length=<value optimized out>, param=<value optimized out>, user_data=<value optimized out>) at src/adapter.c:8084
>     8  index_removed (index=<value optimized out>, length=<value optimized out>, param=<value optimized out>, user_data=<value optimized out>) at src/adapter.c:8615
>     9  0xb6ed5702 in notify_handler (data=<value optimized out>, user_data=<value optimized out>) at src/shared/mgmt.c:275
>     10 notify_handler (data=<value optimized out>, user_data=<value optimized out>) at src/shared/mgmt.c:260
>     11 0xb6ed5206 in queue_foreach (queue=<value optimized out>, function=0xb6ed56d1 <notify_handler>, user_data=0xbeb78a4c) at src/shared/queue.c:186
>     12 0xb6ed581a in process_notify (io=<value optimized out>, user_data=<value optimized out>) at src/shared/mgmt.c:287
>     13 can_read_data (io=<value optimized out>, user_data=<value optimized out>) at src/shared/mgmt.c:362
>     14 0xb6ed4eea in read_callback (channel=<value optimized out>, cond=<value optimized out>, user_data=<value optimized out>) at src/shared/io-glib.c:168
>     15 read_callback (channel=<value optimized out>, cond=<value optimized out>, user_data=<value optimized out>) at src/shared/io-glib.c:158
>     16 0xb6dc0392 in g_io_unix_dispatch (source=0xb6f1b948, callback=<value optimized out>, user_data=0xb6f1b650) at giounix.c:166
>     17 0xb6d97378 in g_main_dispatch (context=0xb6f13048) at gmain.c:2539
>     18 g_main_context_dispatch (context=0xb6f13048) at gmain.c:3075
>     19 0xb6d975c8 in g_main_context_iterate (context=0xb6f13048, block=<value optimized out>, dispatch=1, self=<value optimized out>) at gmain.c:3146
>     20 g_main_context_iterate (context=0xb6f13048, block=<value optimized out>, dispatch=1, self=<value optimized out>) at gmain.c:3083
>     21 0xb6d978ac in g_main_loop_run (loop=0xb6f12168) at gmain.c:3340
>     22 0xb6e88a02 in main (argc=1, argv=0xbeb78d64) at src/main.c:604
>     (gdb) frame 1
>     1  0xb6e90fa4 in finalize_discovery (session=0xb6f24d08, err=<value optimized out>) at profiles/audio/avdtp.c:1232
>     1232        profiles/audio/avdtp.c: No such file or directory.
>         in profiles/audio/avdtp.c
>     (gdb) p session
>     $1 = (struct avdtp *) 0xb6f24d08
>     (gdb) p *session->discover
>     $2 = {id = 0, cb = 0, user_data = 0x0}

This trace makes little sense to me, it is like someone would be
passing a NULL cb to avdtp_discover but the current code always set a
valid callback.

> ---
>  profiles/audio/avdtp.c |    5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
> index ba5f0e5..50d7999 100644
> --- a/profiles/audio/avdtp.c
> +++ b/profiles/audio/avdtp.c
> @@ -1053,8 +1053,9 @@ static void finalize_discovery(struct avdtp *session, int err)
>         if (discover->id > 0)
>                 g_source_remove(discover->id);
>
> -       discover->cb(session, session->seps, err ? &avdtp_err : NULL,
> -                                                       discover->user_data);
> +       if (discover->cb)
> +               discover->cb(session, session->seps, err ? &avdtp_err : NULL,
> +                                                               discover->user_data);
>         g_free(discover);
>         session->discover = NULL;
>  }
> --
> 1.7.9.5
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Luiz Augusto von Dentz
