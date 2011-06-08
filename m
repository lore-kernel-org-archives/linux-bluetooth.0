Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1307452201-11057-5-git-send-email-lkslawek@gmail.com>
References: <1307452201-11057-1-git-send-email-lkslawek@gmail.com>
	<1307452201-11057-5-git-send-email-lkslawek@gmail.com>
Date: Wed, 8 Jun 2011 13:27:43 +0900
Message-ID: <BANLkTi=LXBzm+9g-VdonozngKhQfOZoz2w@mail.gmail.com>
Subject: Re: [PATCH 4/4] Fix handling asynchronous plugin reads
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Slawomir Bochenski <lkslawek@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Tue, Jun 7, 2011 at 10:10 PM, Slawomir Bochenski <lkslawek@gmail.com> wrote:
> Calling OBEX_ResumeRequest() from handle_async_io() may result in direct
> calling obex_event_cb() (this happens when obex_write_stream() will
> deliver not enough bytes to fully fill OpenOBEX TX packet). In this case
> set_io_watch will fail if handle_async_io() is called from
> obex_object_set_io_flags(), because the watch is already installed.
> Originally when code returns from OBEX_ResumeRequest(), handle_async_io()
> returns FALSE which makes obex_object_set_io_flags() remove this watch.
>
> This patch adds variable for tracking whether subsequent calls suspended
> stream, causing obex_object_set_io_flags() remove the watch only when the
> streaming is still running (i.e. not suspended).
> ---
>  src/obex-priv.h |    1 +
>  src/obex.c      |   15 ++++++++++++---
>  2 files changed, 13 insertions(+), 3 deletions(-)
>
> diff --git a/src/obex-priv.h b/src/obex-priv.h
> index 8c722dc..54ec991 100644
> --- a/src/obex-priv.h
> +++ b/src/obex-priv.h
> @@ -46,6 +46,7 @@ struct obex_session {
>        obex_object_t *obj;
>        struct obex_mime_type_driver *driver;
>        gboolean streaming;
> +       gboolean stream_running;
>  };

I guess we can call this suspended.

>  int obex_session_start(GIOChannel *io, uint16_t tx_mtu, uint16_t rx_mtu,
> diff --git a/src/obex.c b/src/obex.c
> index 659f39b..5f437c7 100644
> --- a/src/obex.c
> +++ b/src/obex.c
> @@ -311,6 +311,7 @@ static void os_reset_session(struct obex_session *os)
>        os->offset = 0;
>        os->size = OBJECT_SIZE_DELETE;
>        os->streaming = FALSE;
> +       os->stream_running = FALSE;
>  }
>
>  static void obex_session_free(struct obex_session *os)
> @@ -670,6 +671,7 @@ static int obex_write_stream(struct obex_session *os,
>                        OBEX_ObjectAddHeader(obex, obj, hi, hd, 0,
>                                                OBEX_FL_STREAM_START);
>                        os->streaming = TRUE;
> +                       os->stream_running = TRUE;
>                }
>
>                hd.bs = os->buf;
> @@ -698,6 +700,8 @@ static void suspend_stream(struct obex_session *os, obex_t *obex,
>  {
>        obex_headerdata_t hd;
>
> +       os->stream_running = FALSE;
> +
>        if (os->streaming) {
>                OBEX_SuspendRequest(obex, obj);
>                return;
> @@ -731,10 +735,15 @@ proceed:
>        if (ret < 0) {
>                os_set_response(os->obj, err);
>                OBEX_CancelRequest(os->obex, TRUE);
> -       } else
> +       } else {
> +               os->stream_running = TRUE;
>                OBEX_ResumeRequest(os->obex);
> +       }
>
> -       return FALSE;
> +       if (os->stream_running)
> +               return FALSE;
> +       else
> +               return TRUE;
>  }
>
>  static void cmd_get(struct obex_session *os, obex_t *obex, obex_object_t *obj)
> @@ -1225,7 +1234,7 @@ static void obex_event_cb(obex_t *obex, obex_object_t *obj, int mode,
>        case OBEX_EV_STREAMEMPTY:
>                err = obex_write_stream(os, obex, obj);
>                if (err == -EAGAIN) {
> -                       OBEX_SuspendRequest(obex, obj);
> +                       suspend_stream(os, obex, obj);
>                        os->obj = obj;
>                        os->driver->set_io_watch(os->object, handle_async_io,
>                                                                        os);
> --

I guess we should be calling suspend_stream whenever we suspend the
stream so we set suspended/stream_running, also don't we need a
resume_stream to reset the flag?



-- 
Luiz Augusto von Dentz
Computer Engineer
