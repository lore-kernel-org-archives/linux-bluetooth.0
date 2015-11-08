Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1446549771-20565-1-git-send-email-luiz.dentz@gmail.com>
References: <1446549771-20565-1-git-send-email-luiz.dentz@gmail.com>
Date: Sun, 8 Nov 2015 21:19:34 +0200
Message-ID: <CABBYNZL7S2SVzm0ugHqPD7gYhv9QjGkUG0VQpLO57cZZtPO-4Q@mail.gmail.com>
Subject: Re: [PATCH BlueZ] obexd/session: Fix crash when disconnecting
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Tue, Nov 3, 2015 at 1:22 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> If session owner disconnect from the bus while g_obex_connect is pending
> it may lead to a crash since it is never canceled connected_cb may still
> be called after callback_data is freed.
> ---
>  obexd/client/session.c | 18 +++++++++++++-----
>  1 file changed, 13 insertions(+), 5 deletions(-)
>
> diff --git a/obexd/client/session.c b/obexd/client/session.c
> index 7248768..ef998f9 100644
> --- a/obexd/client/session.c
> +++ b/obexd/client/session.c
> @@ -62,6 +62,7 @@ static guint64 counter = 0;
>
>  struct callback_data {
>         struct obc_session *session;
> +       guint id;
>         session_callback_t func;
>         void *data;
>  };
> @@ -308,6 +309,9 @@ static void callback_destroy(struct callback_data *callback, GError *err)
>  {
>         struct obc_session *session = callback->session;
>
> +       if (callback->id > 0)
> +               g_obex_cancel_req(session->obex, callback->id, TRUE);
> +
>         callback->func(session, NULL, err, callback->data);
>         g_free(callback);
>         session->callback = NULL;
> @@ -321,6 +325,8 @@ static void connect_cb(GObex *obex, GError *err, GObexPacket *rsp,
>         GError *gerr = NULL;
>         uint8_t rsp_code;
>
> +       callback->id = 0;
> +
>         if (err != NULL) {
>                 error("connect_cb: %s", err->message);
>                 gerr = g_error_copy(err);
> @@ -392,24 +398,26 @@ static void transport_func(GIOChannel *io, GError *err, gpointer user_data)
>
>                 len = g_obex_apparam_encode(apparam, buf, sizeof(buf));
>                 if (driver->target)
> -                       g_obex_connect(obex, connect_cb, callback, &err,
> +                       callback->id = g_obex_connect(obex, connect_cb,
> +                                       callback, &err,
>                                         G_OBEX_HDR_TARGET,
>                                         driver->target, driver->target_len,
>                                         G_OBEX_HDR_APPARAM,
>                                         buf, len,
>                                         G_OBEX_HDR_INVALID);
>                 else
> -                       g_obex_connect(obex, connect_cb, callback, &err,
> +                       callback->id = g_obex_connect(obex, connect_cb,
> +                                       callback, &err,
>                                         G_OBEX_HDR_APPARAM, buf, len,
>                                         G_OBEX_HDR_INVALID);
>                 g_obex_apparam_free(apparam);
>         } else if (driver->target)
> -               g_obex_connect(obex, connect_cb, callback, &err,
> +               callback->id = g_obex_connect(obex, connect_cb, callback, &err,
>                         G_OBEX_HDR_TARGET, driver->target, driver->target_len,
>                         G_OBEX_HDR_INVALID);
>         else
> -               g_obex_connect(obex, connect_cb, callback, &err,
> -                                                       G_OBEX_HDR_INVALID);
> +               callback->id = g_obex_connect(obex, connect_cb, callback,
> +                                               &err, G_OBEX_HDR_INVALID);
>
>         if (err != NULL) {
>                 error("%s", err->message);
> --
> 2.4.3

Applied.


-- 
Luiz Augusto von Dentz
