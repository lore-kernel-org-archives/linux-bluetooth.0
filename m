Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1392029145-7954-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1392029145-7954-1-git-send-email-andrzej.kaczmarek@tieto.com>
Date: Mon, 10 Feb 2014 13:36:56 +0200
Message-ID: <CABBYNZLJwgTXzanW5=xOPaPVawCe_T1Yz2KSspF6nTpqbiQgWg@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] android/a2dp: Shutdown AVDTP gracefully
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrzej,

On Mon, Feb 10, 2014 at 12:45 PM, Andrzej Kaczmarek
<andrzej.kaczmarek@tieto.com> wrote:
> When shutting down AVDTP connection we first abort and wait for stream
> to go to idle state before disconnecting signalling channel.
> ---
>  android/avdtp.c | 21 +++++++++++++++++----
>  1 file changed, 17 insertions(+), 4 deletions(-)
>
> diff --git a/android/avdtp.c b/android/avdtp.c
> index e26d6ec..2629e67 100644
> --- a/android/avdtp.c
> +++ b/android/avdtp.c
> @@ -398,6 +398,8 @@ struct avdtp {
>         struct pending_req *req;
>
>         GSList *disconnect;
> +
> +       bool shutdown;
>  };
>
>  static GSList *lseps = NULL;
> @@ -913,6 +915,11 @@ static void avdtp_sep_set_state(struct avdtp *session,
>                 session->streams = g_slist_remove(session->streams, stream);
>                 stream_free(stream);
>         }
> +
> +       if (session->io && session->shutdown && session->streams == NULL) {
> +               int sock = g_io_channel_unix_get_fd(session->io);
> +               shutdown(sock, SHUT_RDWR);
> +       }
>  }
>
>  static void finalize_discovery(struct avdtp *session, int err)
> @@ -2141,7 +2148,7 @@ gboolean avdtp_remove_disconnect_cb(struct avdtp *session, unsigned int id)
>  void avdtp_shutdown(struct avdtp *session)
>  {
>         GSList *l;
> -       int sock;
> +       bool aborting = false;
>
>         if (!session->io)
>                 return;
> @@ -2149,12 +2156,18 @@ void avdtp_shutdown(struct avdtp *session)
>         for (l = session->streams; l; l = g_slist_next(l)) {
>                 struct avdtp_stream *stream = l->data;
>
> -               avdtp_close(session, stream, TRUE);
> +               if (stream->abort_int || avdtp_abort(session, stream) == 0)
> +                       aborting = true;
>         }
>
> -       sock = g_io_channel_unix_get_fd(session->io);
> +       if (aborting) {
> +               /* defer shutdown until all streams are aborted properly */
> +               session->shutdown = true;
> +       } else {
> +               int sock = g_io_channel_unix_get_fd(session->io);
>
> -       shutdown(sock, SHUT_RDWR);
> +               shutdown(sock, SHUT_RDWR);
> +       }
>  }
>
>  static void queue_request(struct avdtp *session, struct pending_req *req,
> --
> 1.8.5.3

Applied, thanks.


-- 
Luiz Augusto von Dentz
