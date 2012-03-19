Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1331559165-28367-5-git-send-email-mikel.astiz.oss@gmail.com>
References: <1331559165-28367-1-git-send-email-mikel.astiz.oss@gmail.com>
	<1331559165-28367-5-git-send-email-mikel.astiz.oss@gmail.com>
Date: Mon, 19 Mar 2012 10:03:12 -0300
Message-ID: <CABBYNZJ2T===Bu_UwgUb1zQepWz=-ksndkn-sAPEcbm6hSDAWg@mail.gmail.com>
Subject: Re: [PATCH obexd v0 04/11] client: fix progress report before field update
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Mikel Astiz <mikel.astiz.oss@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Mikel Astiz <mikel.astiz@bmw-carit.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mikel,

On Mon, Mar 12, 2012 at 10:32 AM, Mikel Astiz <mikel.astiz.oss@gmail.com> wrote:
> From: Mikel Astiz <mikel.astiz@bmw-carit.de>
>
> The progress report in put_xfer_progress was done before the
> corresponding field was updated.
> ---
>  client/transfer.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/client/transfer.c b/client/transfer.c
> index f2a153c..bc896f8 100644
> --- a/client/transfer.c
> +++ b/client/transfer.c
> @@ -493,10 +493,10 @@ static gssize put_xfer_progress(void *buf, gsize len, gpointer user_data)
>        if (size <= 0)
>                return size;
>
> -       transfer_notify_progress(transfer);
> -
>        transfer->transferred += size;
>
> +       transfer_notify_progress(transfer);
> +
>        return size;
>  }
>
> --
> 1.7.7.6
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Ack.

-- 
Luiz Augusto von Dentz
