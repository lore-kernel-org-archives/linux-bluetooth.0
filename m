Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1441955802-20449-1-git-send-email-luiz.dentz@gmail.com>
References: <1441955802-20449-1-git-send-email-luiz.dentz@gmail.com>
Date: Mon, 14 Sep 2015 10:50:19 +0300
Message-ID: <CABBYNZLYqs20PBMtYRrv3CSFccQv=W=5O0yNtcdfeUSjLe8ANA@mail.gmail.com>
Subject: Re: [PATCH BlueZ] obexd: Fix not destroying session if owner disconnects
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Fri, Sep 11, 2015 at 10:16 AM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> If the owner disconnects the session should be destroyed even if the
> connection is pending:
>
> obexd/client/session.c:owner_disconnected()
> obexd/client/session.c:obc_session_shutdown() 0x822abb8
> obexd/client/session.c:obc_session_ref() 0x822abb8: ref=3
> obexd/client/session.c:obc_session_unref() 0x822abb8: ref=2
> obexd/client/bluetooth.c:transport_connect() port 19
> obexd/client/bluetooth.c:transport_callback()
> obexd/client/session.c:transport_func()
> obexd/client/bluetooth.c:bluetooth_getpacketopt()
> obexd/client/pbap.c:pbap_probe() /org/bluez/obex/client/session1
> obexd/client/session.c:obc_session_ref() 0x822abb8: ref=3
> obexd/client/session.c:obc_session_register() Session(0x822abb8) registered /org/bluez/obex/client/session1
> obexd/client/session.c:obc_session_unref() 0x822abb8: ref=2
>
> To fix this the code now checks if the connect callback is pending, in
> that case destroy the callback releasing the reference it carrying.
> ---
>  obexd/client/session.c | 34 ++++++++++++++++++++++++++++------
>  1 file changed, 28 insertions(+), 6 deletions(-)
>
> diff --git a/obexd/client/session.c b/obexd/client/session.c
> index d6da0a7..7248768 100644
> --- a/obexd/client/session.c
> +++ b/obexd/client/session.c
> @@ -112,6 +112,7 @@ struct obc_session {
>         GQueue *queue;
>         guint process_id;
>         char *folder;
> +       struct callback_data *callback;
>  };
>
>  static GSList *sessions = NULL;
> @@ -303,6 +304,16 @@ disconnect:
>         session_free(session);
>  }
>
> +static void callback_destroy(struct callback_data *callback, GError *err)
> +{
> +       struct obc_session *session = callback->session;
> +
> +       callback->func(session, NULL, err, callback->data);
> +       g_free(callback);
> +       session->callback = NULL;
> +       obc_session_unref(session);
> +}
> +
>  static void connect_cb(GObex *obex, GError *err, GObexPacket *rsp,
>                                                         gpointer user_data)
>  {
> @@ -322,11 +333,9 @@ static void connect_cb(GObex *obex, GError *err, GObexPacket *rsp,
>                                 "OBEX Connect failed with 0x%02x", rsp_code);
>
>  done:
> -       callback->func(callback->session, NULL, gerr, callback->data);
> +       callback_destroy(callback, gerr);
>         if (gerr != NULL)
>                 g_error_free(gerr);
> -       obc_session_unref(callback->session);
> -       g_free(callback);
>  }
>
>  static void session_disconnected(GObex *obex, GError *err, gpointer user_data)
> @@ -415,17 +424,28 @@ static void transport_func(GIOChannel *io, GError *err, gpointer user_data)
>
>         return;
>  done:
> -       callback->func(callback->session, NULL, err, callback->data);
> -       obc_session_unref(callback->session);
> -       g_free(callback);
> +       callback_destroy(callback, err);
>  }
>
>  static void owner_disconnected(DBusConnection *connection, void *user_data)
>  {
>         struct obc_session *session = user_data;
> +       GError *err;
>
>         DBG("");
>
> +       /*
> +        * If connection still connecting notify the callback to destroy the
> +        * session.
> +        */
> +       if (session->callback) {
> +               err = g_error_new(OBEX_IO_ERROR, OBEX_IO_DISCONNECTED,
> +                                               "Session closed by user");
> +               callback_destroy(session->callback, err);
> +               g_error_free(err);
> +               return;
> +       }
> +
>         obc_session_shutdown(session);
>  }
>
> @@ -531,6 +551,8 @@ static int session_connect(struct obc_session *session,
>                 return -EINVAL;
>         }
>
> +       session->callback = callback;
> +
>         return 0;
>  }
>
> --
> 2.4.3

Applied.


-- 
Luiz Augusto von Dentz
