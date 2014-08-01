Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1406813720-4382-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1406813720-4382-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Date: Fri, 1 Aug 2014 10:36:33 +0300
Message-ID: <CABBYNZJSfWa8r8Ab-Dp3cmSwcxQc_7t7W0Cb2EALobM4RQnLkw@mail.gmail.com>
Subject: Re: [PATCH] gobex: Fix use after free
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Thu, Jul 31, 2014 at 4:35 PM, Andrei Emeltchenko
<Andrei.Emeltchenko.news@gmail.com> wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
>
> It is better not to dereference freed pointer
> ---
>  gobex/gobex.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/gobex/gobex.c b/gobex/gobex.c
> index 3848884..35e546f 100644
> --- a/gobex/gobex.c
> +++ b/gobex/gobex.c
> @@ -263,8 +263,6 @@ static gboolean req_timeout(gpointer user_data)
>         g_error_free(err);
>         pending_pkt_free(p);
>
> -       p->timeout_id = 0;
> -

A more correct fix would be to move this line to the beginning of the
function so we don't call g_source_remove unnecessarily.


-- 
Luiz Augusto von Dentz
