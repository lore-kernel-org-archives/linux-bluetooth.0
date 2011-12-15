Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1323943267-14576-5-git-send-email-mikel.astiz.oss@gmail.com>
References: <1323943267-14576-1-git-send-email-mikel.astiz.oss@gmail.com>
	<1323943267-14576-5-git-send-email-mikel.astiz.oss@gmail.com>
Date: Thu, 15 Dec 2011 13:51:26 +0200
Message-ID: <CABBYNZK3ABq0mzaBiQoD9cQGtBv0cx6sL1L2_rcapc9hz3VzBg@mail.gmail.com>
Subject: Re: [PATCH 4/4] audio: do not disconnect on gateway SCO failure
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Mikel Astiz <mikel.astiz.oss@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Mikel Astiz <mikel.astiz@bmw-carit.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mikel,

On Thu, Dec 15, 2011 at 12:01 PM, Mikel Astiz <mikel.astiz.oss@gmail.com> wrote:
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
> index 9b1aab3..f28b14d 100644
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
> 1.7.6.4
>

Ack, this should be up to the endpoint to decided since it may want to retry.

-- 
Luiz Augusto von Dentz
