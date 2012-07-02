Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1341242171-20485-1-git-send-email-frederic.dalleau@linux.intel.com>
References: <1341242171-20485-1-git-send-email-frederic.dalleau@linux.intel.com>
Date: Mon, 2 Jul 2012 18:33:51 +0300
Message-ID: <CABBYNZ+DiLyWoXjxDzZKbK+acq5Gsdv5HULtrL_OZHaZwoXqEg@mail.gmail.com>
Subject: Re: [PATCH] audio: Fix missing reply to Acquire in AVDTP
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: =?ISO-8859-1?Q?Fr=E9d=E9ric_Dalleau?=
	<frederic.dalleau@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Frédéric,

On Mon, Jul 2, 2012 at 6:16 PM, Frédéric Dalleau
<frederic.dalleau@linux.intel.com> wrote:
> Calling org.bluez.MediaEndpoint.Acquire ends in avdtp_start().
> If bluez is acceptor of AVDTP_OPEN, then avdtp_start is delayed in a
> timer in order to wait for the initiator to send AVDTP_START.
> If the timer expires, avdtp_start() is called a second time and find
> that Bluez is acceptor. This time, since a timer already exists, Bluez
> does nothing and the answer to Acquire is never sent.
> The idea of this patch is that if we get in the timeout, we will no longer
> care whether we accepted open or not.
> ---
>  audio/avdtp.c |    2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/audio/avdtp.c b/audio/avdtp.c
> index 56a0905..e431ce8 100644
> --- a/audio/avdtp.c
> +++ b/audio/avdtp.c
> @@ -3627,6 +3627,8 @@ static gboolean start_timeout(gpointer user_data)
>         struct avdtp_stream *stream = user_data;
>         struct avdtp *session = stream->session;
>
> +       stream->open_acp = 0;
> +
>         if (avdtp_start(session, stream) < 0)
>                 error("wait_timeout: avdtp_start failed");
>
> --
> 1.7.9.5
>

Pushed, thanks.


-- 
Luiz Augusto von Dentz
