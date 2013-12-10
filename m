Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1386598648-31619-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1386598648-31619-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Date: Tue, 10 Dec 2013 13:40:32 +0200
Message-ID: <CABBYNZJBtWjgO45+J+Js-GHbOfdbuVpAWjpLDfdarskdp5qNSg@mail.gmail.com>
Subject: Re: [PATCH] bnep: Remove unneeded assignment
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Mon, Dec 9, 2013 at 4:17 PM, Andrei Emeltchenko
<Andrei.Emeltchenko.news@gmail.com> wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
>
> ---
>  profiles/network/bnep.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/profiles/network/bnep.c b/profiles/network/bnep.c
> index 0a719a2..912c0c2 100644
> --- a/profiles/network/bnep.c
> +++ b/profiles/network/bnep.c
> @@ -88,7 +88,6 @@ static void free_bnep_connect(struct bnep_conn *bc)
>         }
>
>         g_free(bc);
> -       bc = NULL;
>  }
>
>  uint16_t bnep_service_id(const char *svc)
> --
> 1.8.3.2

Pushed, thanks.


-- 
Luiz Augusto von Dentz
