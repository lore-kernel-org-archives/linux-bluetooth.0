Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1332515027-31529-1-git-send-email-puffy.taco@gmail.com>
References: <1332515027-31529-1-git-send-email-puffy.taco@gmail.com>
Date: Mon, 26 Mar 2012 11:24:25 -0300
Message-ID: <CABBYNZKXVaXTjHVioHXwqZsGvn8c+bjGXJpgg1kgi+7k0F_23A@mail.gmail.com>
Subject: Re: [PATCH] avdtp: fix audio source init check
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Mike Brudevold <puffy.taco@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Michael Brudevold <michael.brudevold@logicpd.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mike,

On Fri, Mar 23, 2012 at 12:03 PM, Mike Brudevold <puffy.taco@gmail.com> wrote:
> From: Michael Brudevold <michael.brudevold@logicpd.com>
>
> ---
>  audio/avdtp.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/audio/avdtp.c b/audio/avdtp.c
> index cd66fd4..8b36f0b 100644
> --- a/audio/avdtp.c
> +++ b/audio/avdtp.c
> @@ -1520,7 +1520,7 @@ static gboolean avdtp_setconf_cmd(struct avdtp *session, uint8_t transaction,
>        case AVDTP_SEP_TYPE_SINK:
>                if (!dev->source) {
>                        btd_device_add_uuid(dev->btd_dev, A2DP_SOURCE_UUID);
> -                       if (!dev->sink) {
> +                       if (!dev->source) {
>                                error("Unable to get a audio source object");
>                                err = AVDTP_BAD_STATE;
>                                goto failed;
> --
> 1.7.5.4
>
> --

Ack.


-- 
Luiz Augusto von Dentz
