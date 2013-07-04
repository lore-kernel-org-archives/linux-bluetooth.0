Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1372864541-10763-20-git-send-email-luiz.dentz@gmail.com>
References: <1372864541-10763-1-git-send-email-luiz.dentz@gmail.com>
	<1372864541-10763-20-git-send-email-luiz.dentz@gmail.com>
Date: Thu, 4 Jul 2013 09:05:57 +0200
Message-ID: <CANT-zCWU3-BJB18DXs1bgKwioZru-8=73H3fQ9J4zK0A1cL0ew@mail.gmail.com>
Subject: Re: [RFC 19/20] audio/sink: Fix not notifying service about
 connection state
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Wed, Jul 3, 2013 at 5:15 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> btd_service_connecting_complete should be called whenever the service
> is connected otherwise the service state will not be consistent.
> ---
>  profiles/audio/sink.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/profiles/audio/sink.c b/profiles/audio/sink.c
> index bb9ab21..5206920 100644
> --- a/profiles/audio/sink.c
> +++ b/profiles/audio/sink.c
> @@ -164,6 +164,7 @@ static void stream_state_changed(struct avdtp_stream *stream,
>                 sink->cb_id = 0;
>                 break;
>         case AVDTP_STATE_OPEN:
> +               btd_service_connecting_complete(sink->service, 0);
>                 sink_set_state(sink, SINK_STATE_CONNECTED);
>                 break;
>         case AVDTP_STATE_STREAMING:
> @@ -212,11 +213,8 @@ static void stream_setup_complete(struct avdtp *session, struct a2dp_sep *sep,
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

If this is a fix, it'd be good to document the steps to reproduce and
point out the commit that broke this.

In particular, I'm interested in knowing whether this was introduced
during the transition to btd_service. If you look at
10620c1c0fbb211455fde597a1d2e5e47806f25d, you'll see that the previous
approach also missed the state notification in stream_state_changed().

If this is indeed an issue introduced by btd_service, other profiles
might need to be double-checked.

Cheers,
Mikel
