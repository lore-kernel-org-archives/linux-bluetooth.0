Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1424780809-23449-4-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1424780809-23449-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	<1424780809-23449-4-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Date: Tue, 24 Feb 2015 14:57:39 +0200
Message-ID: <CABBYNZKVkbP94YARwvmzdoT2P6h-HsdS4OjkAtR3uRzXneRDhw@mail.gmail.com>
Subject: Re: [RFCv0 3/6] audio/avdtp: Refactor avdtp_new
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Tue, Feb 24, 2015 at 2:26 PM, Andrei Emeltchenko
<Andrei.Emeltchenko.news@gmail.com> wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
>
> avdtp_new() is split to avdtp_new() and avdtp_transport_connect() which
> takes care about opening transport channel.
> ---
>  profiles/audio/a2dp.c  | 10 +++++++---
>  profiles/audio/avdtp.c | 20 ++++++++++++--------
>  profiles/audio/avdtp.h |  2 +-
>  3 files changed, 20 insertions(+), 12 deletions(-)
>
> diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
> index 6a86c19..e669f43 100644
> --- a/profiles/audio/a2dp.c
> +++ b/profiles/audio/a2dp.c
> @@ -1222,7 +1222,7 @@ struct avdtp *a2dp_avdtp_get(struct btd_device *device)
>         if (server == NULL)
>                 return NULL;
>
> -       session = avdtp_new(server, server->sessions, NULL, device);
> +       session = avdtp_new(server, server->sessions, device);
>         if (!session)
>                 return NULL;
>
> @@ -1328,11 +1328,15 @@ static void avdtp_confirm_cb(GIOChannel *chan, gpointer data)
>         if (!avdtp_server)
>                 goto drop;
>
> -       session = avdtp_new(avdtp_server, avdtp_server->sessions, chan, device);
> +       session = avdtp_new(avdtp_server, avdtp_server->sessions, device);
>         if (!session)
>                 goto drop;
>
> -       avdtp_request_authorization(session, &src, &dst, auth_cb);
> +
> +       if (avdtp_transport_connect(session, chan)) {
> +               btd_device_add_uuid(device, ADVANCED_AUDIO_UUID);
> +               avdtp_request_authorization(session, &src, &dst, auth_cb);
> +       }

What is going on here, why you are not using the same API as in
android again? what is wrong with avdtp_stream_set_transport?

>         return;
>
> diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
> index 1a16170..aaaf3b2 100644
> --- a/profiles/audio/avdtp.c
> +++ b/profiles/audio/avdtp.c
> @@ -2374,7 +2374,6 @@ failed:
>  }
>
>  struct avdtp *avdtp_new(struct avdtp_server *server, GSList *sessions,
> -                                               GIOChannel *chan,
>                                                 struct btd_device *device)
>  {
>         struct avdtp *session;
> @@ -2396,9 +2395,14 @@ struct avdtp *avdtp_new(struct avdtp_server *server, GSList *sessions,
>         server->sessions = g_slist_append(server->sessions, session);
>
>         session->lseps = server->seps;
> -       if (!chan)
> -               return session;
>
> +       DBG("Created session %p added to server %p", session, server);
> +
> +       return session;
> +}
> +
> +bool avdtp_transport_connect(struct avdtp *session, GIOChannel *chan)
> +{
>         /* This state (ie, session is already *connecting*) happens when the
>          * device initiates a connect (really a config'd L2CAP channel) even
>          * though there is a connect we initiated in progress. In sink.c &
> @@ -2414,7 +2418,7 @@ struct avdtp *avdtp_new(struct avdtp_server *server, GSList *sessions,
>                 if (!bt_io_accept(chan, avdtp_connect_cb, session, NULL, NULL))
>                         goto drop;
>
> -               return NULL;
> +               return false;
>         }
>
>         if (session->io) {
> @@ -2422,17 +2426,17 @@ struct avdtp *avdtp_new(struct avdtp_server *server, GSList *sessions,
>                 goto drop;
>         }
>
> -       btd_device_add_uuid(device, ADVANCED_AUDIO_UUID);
> -
>         session->io = g_io_channel_ref(chan);
>         avdtp_set_state(session, AVDTP_SESSION_STATE_CONNECTING);
>
>         session->io_id = g_io_add_watch(chan, G_IO_ERR | G_IO_HUP | G_IO_NVAL,
>                                         (GIOFunc) session_cb, session);
>
> -       return session;
> +       return true;
> +
>  drop:
> -       return NULL;
> +       g_io_channel_shutdown(chan, TRUE, NULL);
> +       return false;
>  }
>
>  bool avdtp_request_authorization(struct avdtp *session, const bdaddr_t *src,
> diff --git a/profiles/audio/avdtp.h b/profiles/audio/avdtp.h
> index c2c223a..4aa3936 100644
> --- a/profiles/audio/avdtp.h
> +++ b/profiles/audio/avdtp.h
> @@ -294,8 +294,8 @@ struct btd_device *avdtp_get_device(struct avdtp *session);
>  struct avdtp_server *avdtp_get_server(struct avdtp_local_sep *lsep);
>
>  struct avdtp *avdtp_new(struct avdtp_server *server, GSList *sessions,
> -                                               GIOChannel *chan,
>                                                 struct btd_device *device);
> +bool avdtp_transport_connect(struct avdtp *session, GIOChannel *chan);
>  void avdtp_free(void *data);
>  void connection_lost(struct avdtp *session, int err);
>  void avdtp_accept(struct avdtp *session);
> --
> 2.1.0
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Luiz Augusto von Dentz
