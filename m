Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1329210394-31405-4-git-send-email-mikel.astiz.oss@gmail.com>
References: <1329210394-31405-1-git-send-email-mikel.astiz.oss@gmail.com>
	<1329210394-31405-4-git-send-email-mikel.astiz.oss@gmail.com>
Date: Tue, 14 Feb 2012 11:29:31 +0200
Message-ID: <CABBYNZKQ_4uqU4HqbFk118Ng6g-xPh_SQu_a-Df0sM6=RWO0Jw@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] audio: do not disconnect on gateway SCO failure
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Mikel Astiz <mikel.astiz.oss@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Mikel Astiz <mikel.astiz@bmw-carit.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mikel,

On Tue, Feb 14, 2012 at 11:06 AM, Mikel Astiz <mikel.astiz.oss@gmail.com> wrote:
> From: Mikel Astiz <mikel.astiz@bmw-carit.de>
>
> Failure on BlueZ-initiated SCO requests should not drop the RFCOMM
> connection to the gateway. Instead, considering the stream as suspended
> should be enough.
> ---
>  audio/gateway.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/audio/gateway.c b/audio/gateway.c
> index bde3e02..163f7b5 100644
> --- a/audio/gateway.c
> +++ b/audio/gateway.c
> @@ -255,7 +255,7 @@ static void sco_connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
>
>        if (err) {
>                error("sco_connect_cb(): %s", err->message);
> -               gateway_close(dev);
> +               gateway_suspend_stream(dev);
>                return;
>        }
>
> --
> 1.7.6.5

Ack

-- 
Luiz Augusto von Dentz
