Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1335784301-7606-1-git-send-email-jaganath.k@samsung.com>
References: <1335784301-7606-1-git-send-email-jaganath.k@samsung.com>
Date: Wed, 2 May 2012 16:13:06 +0300
Message-ID: <CABBYNZJE321X-iK6oU203t-8xzdcnsDZQxTV-g4YwKZ_fGrBnA@mail.gmail.com>
Subject: Re: [PATCH obexd] opp: Emit TransferStarted signal only if stream
 start is success
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Jaganath Kanakkassery <jaganath.k@samsung.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jaganath,

On Mon, Apr 30, 2012 at 2:11 PM, Jaganath Kanakkassery
<jaganath.k@samsung.com> wrote:
> Even if obex_put_stream_start() fails TransferStarted signal will be
> emitted where as transfer start is actually failed.
> ---
>  plugins/opp.c |    7 +++++--
>  1 files changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/plugins/opp.c b/plugins/opp.c
> index fa3ee91..c7ddc63 100644
> --- a/plugins/opp.c
> +++ b/plugins/opp.c
> @@ -154,12 +154,15 @@ skip_auth:
>
>        path = g_build_filename(folder, name, NULL);
>
> -       manager_emit_transfer_started(os);
> -
>        err = obex_put_stream_start(os, path);
>
>        g_free(path);
>
> +       if (err < 0)
> +               goto failed;
> +
> +       manager_emit_transfer_started(os);
> +
>  failed:
>        g_free(folder);
>        g_free(name);
> --
> 1.7.1

Applied, thanks.

-- 
Luiz Augusto von Dentz
