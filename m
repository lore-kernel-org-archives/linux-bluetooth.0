Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1340872326-20627-1-git-send-email-luiz.dentz@gmail.com>
References: <1340872326-20627-1-git-send-email-luiz.dentz@gmail.com>
Date: Thu, 28 Jun 2012 18:18:39 -0300
Message-ID: <CAFAvTnN=jGXXVb7XtOnAXE2CgHq=n48HCJMtkeiBYKdp05SPeQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ v0] AVDTP: Fix disconnecting when acting as sink
From: Henrique Dante <hdante@profusion.mobi>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

 This fixed disconnection with iPhone, thanks

On Thu, Jun 28, 2012 at 5:32 AM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> Usually after pairing the source will attempt to connect and create a
> stream, but it may never send AVDTP_START command as it is not
> playing anything. In the meantime the local endpoint may attempt to
> acquire the transport, but since it was the remote side that opened the
> stream instead of sending AVDTP_START the code now wait and eventually
> timeout.
>
> To fix this now instead of just waiting the remote to send AVDTP_START
> the code will attempt to send the command if nothing is received after
> a small timeout (1s).
> ---
> v0: Only tested against MW600 which was the original cause of
> introducing wait logic.
>
>
>  audio/avdtp.c |   25 ++++++++++++++++++++++---
>  1 file changed, 22 insertions(+), 3 deletions(-)
>
> diff --git a/audio/avdtp.c b/audio/avdtp.c
> index 041abc3..d6f9682 100644
> --- a/audio/avdtp.c
> +++ b/audio/avdtp.c
> @@ -93,6 +93,7 @@
>  #define ABORT_TIMEOUT 2
>  #define DISCONNECT_TIMEOUT 1
>  #define STREAM_TIMEOUT 20
> +#define WAIT_TIMEOUT 1
>
>  #if __BYTE_ORDER == __LITTLE_ENDIAN
>
> @@ -1068,8 +1069,7 @@ static void avdtp_sep_set_state(struct avdtp *session,
>                break;
>        case AVDTP_STATE_OPEN:
>                stream->starting = FALSE;
> -               if ((old_state > AVDTP_STATE_OPEN && session->auto_dc) ||
> -                                                       stream->open_acp)
> +               if ((old_state > AVDTP_STATE_OPEN && session->auto_dc))
>                        stream->idle_timer = g_timeout_add_seconds(STREAM_TIMEOUT,
>                                                                stream_timeout,
>                                                                stream);
> @@ -3647,6 +3647,19 @@ int avdtp_open(struct avdtp *session, struct avdtp_stream *stream)
>                                                        &req, sizeof(req));
>  }
>
> +static gboolean wait_timeout(gpointer user_data)
> +{
> +       struct avdtp_stream *stream = user_data;
> +       struct avdtp *session = stream->session;
> +
> +       if (avdtp_start(session, stream) < 0)
> +               error("wait_timeout: avdtp_start failed");
> +
> +       stream->idle_timer = 0;
> +
> +       return FALSE;
> +}
> +
>  int avdtp_start(struct avdtp *session, struct avdtp_stream *stream)
>  {
>        struct start_req req;
> @@ -3663,7 +3676,13 @@ int avdtp_start(struct avdtp *session, struct avdtp_stream *stream)
>         *  to start the streaming via GAVDP_START.
>         */
>        if (stream->open_acp) {
> -               stream->starting = TRUE;
> +               /* If timer already active wait it */
> +               if (stream->idle_timer)
> +                       return 0;
> +
> +               stream->idle_timer = g_timeout_add_seconds(WAIT_TIMEOUT,
> +                                                               wait_timeout,
> +                                                               stream);
>                return 0;
>        }
>
> --
> 1.7.10.2
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
