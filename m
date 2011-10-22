Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1319219908-2819-5-git-send-email-lucas.demarchi@profusion.mobi>
References: <1319219908-2819-1-git-send-email-lucas.demarchi@profusion.mobi>
	<1319219908-2819-5-git-send-email-lucas.demarchi@profusion.mobi>
Date: Sat, 22 Oct 2011 13:19:00 +0300
Message-ID: <CABBYNZLPF0OkRuo_tjYXd-+VwyYrk-rJB=FkKq4KfT1JJqz0kw@mail.gmail.com>
Subject: Re: [PATCH 5/5] AVRCP: handle volume up/down keys as TG
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lucas,

On Fri, Oct 21, 2011 at 8:58 PM, Lucas De Marchi
<lucas.demarchi@profusion.mobi> wrote:
> ---
>  audio/avctp.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
>
> diff --git a/audio/avctp.c b/audio/avctp.c
> index df3b2b8..fdd8a9e 100644
> --- a/audio/avctp.c
> +++ b/audio/avctp.c
> @@ -155,6 +155,8 @@ static struct {
>        { "BACKWARD",           BACKWARD_OP,            KEY_PREVIOUSSONG },
>        { "REWIND",             REWIND_OP,              KEY_REWIND },
>        { "FAST FORWARD",       FAST_FORWARD_OP,        KEY_FASTFORWARD },
> +       { "VOLUME UP",          VOL_UP_OP,              KEY_VOLUMEUP },
> +       { "VOLUME DOWN",        VOL_DOWN_OP,            KEY_VOLUMEDOWN },
>        { NULL }
>  };
>
> --
> 1.7.7
>

I remember discussing this before, this is not as simple as it seems
because we need to check what A2DP role we are doing so I would like
to do absolute volume control instead which solves the volume
synchronization problem and don't have any recommendation against
using it.

-- 
Luiz Augusto von Dentz
