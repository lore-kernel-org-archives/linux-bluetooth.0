Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1352372786-18324-1-git-send-email-sunil.behera@samsung.com>
References: <1352372786-18324-1-git-send-email-sunil.behera@samsung.com>
Date: Fri, 9 Nov 2012 12:22:38 +0200
Message-ID: <CABBYNZLfEr=NcZNV6m67FtEFPE6EP3tOwOCcNveTvAhGK2iEkw@mail.gmail.com>
Subject: Re: [PATCH obexd v1 3/3] MAP: Reset ap_sent variable
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Sunil Kumar Behera <sunil.behera@samsung.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Sunil,

On Thu, Nov 8, 2012 at 1:06 PM, Sunil Kumar Behera
<sunil.behera@samsung.com> wrote:
> For multiple subsequent request for message listing
> we need to reset this variable to FALSE, so that each
> time the get next header function is executed properly.
> ---
>  plugins/mas.c |    1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/plugins/mas.c b/plugins/mas.c
> index bdf2b6b..459df87 100644
> --- a/plugins/mas.c
> +++ b/plugins/mas.c
> @@ -162,6 +162,7 @@ static void reset_request(struct mas_session *mas)
>
>         mas->nth_call = FALSE;
>         mas->finished = FALSE;
> +       mas->ap_sent = FALSE;
>  }
>
>  static void mas_clean(struct mas_session *mas)
> --
> 1.7.9.5

I went ahead and pushed this upstream, the other 2 patches Im waiting
your reply.


-- 
Luiz Augusto von Dentz
