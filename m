Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1372939245-18040-1-git-send-email-luiz.dentz@gmail.com>
References: <1372939245-18040-1-git-send-email-luiz.dentz@gmail.com>
Date: Thu, 4 Jul 2013 14:19:55 +0200
Message-ID: <CANT-zCW7oe6cpwm1Wa4DLTuo1A84-bEF2aLYkvc9Xyw=gDqS+Q@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/2] audio/sink: Fix not notifying service about
 connection state
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Thu, Jul 4, 2013 at 2:00 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> btd_service_connecting_complete should be called whenever the service
> is connected otherwise the service state will not be consistent.
> ---
>  profiles/audio/sink.c | 16 ++++------------
>  1 file changed, 4 insertions(+), 12 deletions(-)
>
> diff --git a/profiles/audio/sink.c b/profiles/audio/sink.c
> index 3969417..f55efe8 100644
> --- a/profiles/audio/sink.c
> +++ b/profiles/audio/sink.c
> @@ -164,6 +164,7 @@ static void stream_state_changed(struct avdtp_stream *stream,
>                 sink->cb_id = 0;
>                 break;
>         case AVDTP_STATE_OPEN:
> +               btd_service_connecting_complete(sink->service, 0);

I guess it's impossible to enter AVDTP_STATE_STREAMING without being OPEN first?

If this is guaranteed, the patch looks good to me.

Cheers,
Mikel

>                 sink_set_state(dev, SINK_STATE_CONNECTED);
>                 break;
>         case AVDTP_STATE_STREAMING:
> @@ -182,20 +183,14 @@ static void stream_state_changed(struct avdtp_stream *stream,
>  static gboolean stream_setup_retry(gpointer user_data)
>  {
>         struct sink *sink = user_data;
> -       int err;
>
>         sink->retry_id = 0;
>
> -       if (sink->stream_state >= AVDTP_STATE_OPEN) {
> -               DBG("Stream successfully created, after XCASE connect:connect");
> -               err = 0;
> -       } else {
> +       if (sink->stream_state < AVDTP_STATE_OPEN) {
>                 DBG("Stream setup failed, after XCASE connect:connect");
> -               err = -EIO;
> +               btd_service_connecting_complete(sink->service, -EIO);
>         }
>
> -       btd_service_connecting_complete(sink->service, err);
> -
>         if (sink->connect_id > 0) {
>                 a2dp_cancel(sink->dev, sink->connect_id);
>                 sink->connect_id = 0;
> @@ -212,11 +207,8 @@ static void stream_setup_complete(struct avdtp *session, struct a2dp_sep *sep,
>
>         sink->connect_id = 0;
>
> -       if (stream) {
> -               DBG("Stream successfully created");
> -               btd_service_connecting_complete(sink->service, 0);
> +       if (stream)
>                 return;
> -       }
>
>         avdtp_unref(sink->session);
>         sink->session = NULL;
> --
> 1.8.1.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
