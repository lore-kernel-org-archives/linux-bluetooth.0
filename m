Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1347344186-8517-1-git-send-email-par-gunnar.hjalmdahl@stericsson.com>
References: <1347344186-8517-1-git-send-email-par-gunnar.hjalmdahl@stericsson.com>
Date: Tue, 11 Sep 2012 11:22:03 +0300
Message-ID: <CABBYNZKa-Mm3XPEOw2M2xwz2ya3YDVKqVYktbNPx3_dumHC4Sw@mail.gmail.com>
Subject: Re: [PATCH] avctp: Fix reply for message with invalid PID
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Par-Gunnar Hjalmdahl <par-gunnar.hjalmdahl@stericsson.com>
Cc: linux-bluetooth@vger.kernel.org,
	Anurag Gupta <anurag.gupta@stericsson.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Tue, Sep 11, 2012 at 9:16 AM, Par-Gunnar Hjalmdahl
<par-gunnar.hjalmdahl@stericsson.com> wrote:
> Reply for control message with invalid (not registered for reception
> of messages) PID should not have message information field present.
>
> This was affecting AVCTP qualification test case TP/NFR/BI-01-C.
> ---
>  audio/avctp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/audio/avctp.c b/audio/avctp.c
> index 03f3e7f..4e0e8dc 100644
> --- a/audio/avctp.c
> +++ b/audio/avctp.c
> @@ -500,7 +500,7 @@ static gboolean session_cb(GIOChannel *chan, GIOCondition cond,
>
>         if (avctp->pid != htons(AV_REMOTE_SVCLASS_ID)) {
>                 avctp->ipid = 1;
> -               avc->code = AVC_CTYPE_REJECTED;
> +               packet_size = AVCTP_HEADER_LENGTH;
>                 goto done;
>         }
>
> --
> 1.7.11.3

Pushed, thanks.


-- 
Luiz Augusto von Dentz
