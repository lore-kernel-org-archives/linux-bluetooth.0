Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1371471055-25591-1-git-send-email-christian.fetzer@oss.bmw-carit.de>
References: <1371471055-25591-1-git-send-email-christian.fetzer@oss.bmw-carit.de>
Date: Tue, 18 Jun 2013 14:33:44 +0300
Message-ID: <CABBYNZJa0Yeoi2X89UxZ9hzCk7kDBTmdYunjTOi9Jcrbozix4g@mail.gmail.com>
Subject: Re: [PATCH 1/4] obexd: Fix handling error cases in setpath
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Christian Fetzer <christian.fetzer@oss.bmw-carit.de>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Christian,

On Mon, Jun 17, 2013 at 3:10 PM, Christian Fetzer
<christian.fetzer@oss.bmw-carit.de> wrote:
> From: Christian Fetzer <christian.fetzer@bmw-carit.de>
>
> This adds a setpath_op_complete callback, that unpacks the user data and
> finally calls the user callback. The callback is now used for success and error
> cases.
>
> The previous implementation was using setpath_complete which did not
> work for error cases, because it was called with incorrect user data.
> This was leading to a crash, that can be reproduced by disconnecting PBAP
> after trying to select a non existing phone book.
>
>   0  setpath_complete (session=0x66bd90, transfer=0x0, err=0x69b370,
>      user_data=0x69a810) at obexd/client/session.c:912
>   1  0x000000000042d100 in obc_session_shutdown (session=0x66bd90)
>      at obexd/client/session.c:537
>   2  0x000000000040f227 in service_filter (connection=0x664b20,
>      message=<optimized out>, user_data=0x66bed0) at gdbus/watch.c:486
>   3  0x000000000040f49b in message_filter (connection=0x664b20,
>      message=0x66ba30, user_data=<optimized out>) at gdbus/watch.c:554
>   4  0x00007ffff72f40a6 in dbus_connection_dispatch ()
>      from /usr/lib/libdbus-1.so.3
>   5  0x000000000040e148 in message_dispatch (data=0x664b20)
>      at gdbus/mainloop.c:76
>   6  0x00007ffff702e9a3 in ?? () from /usr/lib/libglib-2.0.so.0
>   7  0x00007ffff702de46 in g_main_context_dispatch ()
>      from /usr/lib/libglib-2.0.so.0
>   8  0x00007ffff702e198 in ?? () from /usr/lib/libglib-2.0.so.0
>   9  0x00007ffff702e59a in g_main_loop_run () from
>      /usr/lib/libglib-2.0.so.0
>   10 0x000000000040dd72 in main (argc=1, argv=0x7fffffffddc8)
>      at obexd/src/main.c:319
> ---
>  obexd/client/session.c | 17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)
>
> diff --git a/obexd/client/session.c b/obexd/client/session.c
> index f1915db..eda3412 100644
> --- a/obexd/client/session.c
> +++ b/obexd/client/session.c
> @@ -907,10 +907,9 @@ static void setpath_complete(struct obc_session *session,
>                                                 GError *err, void *user_data)
>  {
>         struct pending_request *p = user_data;
> -       struct setpath_data *data = p->data;
>
> -       if (data->func)
> -               data->func(session, NULL, err, data->user_data);
> +       if (p->func)
> +               p->func(session, NULL, err, p->data);
>
>         if (session->p == p)
>                 session->p = NULL;
> @@ -920,6 +919,16 @@ static void setpath_complete(struct obc_session *session,
>         session_process_queue(session);
>  }
>
> +static void setpath_op_complete(struct obc_session *session,
> +                                               struct obc_transfer *transfer,
> +                                               GError *err, void *user_data)
> +{
> +       struct setpath_data *data = user_data;
> +
> +       if (data->func)
> +               data->func(session, NULL, err, data->user_data);
> +}
> +
>  static void setpath_cb(GObex *obex, GError *err, GObexPacket *rsp,
>                                                         gpointer user_data)
>  {
> @@ -1005,7 +1014,7 @@ guint obc_session_setpath(struct obc_session *session, const char *path,
>         data->remaining = g_strsplit(strlen(path) ? path : "/", "/", 0);
>
>         p = pending_request_new(session, session_process_setpath, NULL,
> -                               setpath_complete, data, setpath_data_free);
> +                               setpath_op_complete, data, setpath_data_free);
>         session_queue(p);
>         return p->id;
>  }
> --
> 1.8.2.3

Pushed, thanks.


--
Luiz Augusto von Dentz
