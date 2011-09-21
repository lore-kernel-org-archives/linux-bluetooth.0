Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1316543496-18575-4-git-send-email-lucas.demarchi@profusion.mobi>
References: <1316543496-18575-1-git-send-email-lucas.demarchi@profusion.mobi>
	<1316543496-18575-4-git-send-email-lucas.demarchi@profusion.mobi>
Date: Wed, 21 Sep 2011 13:33:28 +0300
Message-ID: <CABBYNZLjLTBtd9AeRzkzzRBjxeiq+20hC_bf-KM+_1C6sNXocw@mail.gmail.com>
Subject: Re: [PATCH 3/3] avrcp: handle volume up/down passthroughs as TG
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lucas,

On Tue, Sep 20, 2011 at 9:31 PM, Lucas De Marchi
<lucas.demarchi@profusion.mobi> wrote:
> ---
>  audio/avctp.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
>
> diff --git a/audio/avctp.c b/audio/avctp.c
> index e9b8e40..59fbed9 100644
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

Have a look at the SIMULTANEOUS USE OF HFP, A2DP, AND AVRCP PROFILES
white paper:

Recommendation 16:
If volume is changed on the RD, the RD should not send an AVRCP volume
command to the MP device.
Motivation 16:
Sending an AVRCP volume command to the MP may cause the MP to send
again an AVRCP volume
command to the RD device which could lead to an endless loop of AVRCP
volume commands.

We don't support those because it is very likely that it would create
the endless loop with those devices as we can only act as a MP we just
ignore, for RD this would probably be useful so the handling of the
keys need to take into account the role of the device.

-- 
Luiz Augusto von Dentz
