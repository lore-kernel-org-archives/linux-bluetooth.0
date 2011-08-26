Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1314293588-29190-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1314293588-29190-1-git-send-email-lucas.demarchi@profusion.mobi>
Date: Fri, 26 Aug 2011 10:27:14 +0300
Message-ID: <CABBYNZ+Y9g4rte=wukrHwdPwTHOJFyRGFTjKc3fxb34u8OfLTg@mail.gmail.com>
Subject: Re: [PATCH] avrcp: do not get fd when not connected
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lucas,

On Thu, Aug 25, 2011 at 8:33 PM, Lucas De Marchi
<lucas.demarchi@profusion.mobi> wrote:
> ---
>  audio/control.c |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletions(-)
>
> diff --git a/audio/control.c b/audio/control.c
> index 882c9fb..9990b06 100644
> --- a/audio/control.c
> +++ b/audio/control.c
> @@ -727,7 +727,7 @@ static int avctp_send_event(struct control *control, uint8_t id, void *data)
>        struct avrcp_header *avrcp = (void *) &buf[AVCTP_HEADER_LENGTH];
>        struct avrcp_spec_avc_pdu *pdu = (void *) &buf[AVCTP_HEADER_LENGTH +
>                                                        AVRCP_HEADER_LENGTH];
> -       int sk = g_io_channel_unix_get_fd(control->io);
> +       int sk;
>        uint16_t size;
>
>        if (control->state != AVCTP_STATE_CONNECTED)
> @@ -783,6 +783,8 @@ static int avctp_send_event(struct control *control, uint8_t id, void *data)
>        size += AVCTP_HEADER_LENGTH + AVRCP_HEADER_LENGTH +
>                                        AVRCP_SPECAVCPDU_HEADER_LENGTH;
>
> +       sk = g_io_channel_unix_get_fd(control->io);
> +
>        if (write(sk, buf, size) < 0)
>                return -errno;
>
> --
> 1.7.6

This looks like a bug, in such case we usually use 'fix' in the
description. But the patch looks good.

-- 
Luiz Augusto von Dentz
