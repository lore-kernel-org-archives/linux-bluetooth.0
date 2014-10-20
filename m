Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1413550093-16448-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1413550093-16448-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Date: Mon, 20 Oct 2014 15:38:17 +0300
Message-ID: <CABBYNZJiQUC5041CuSuuThGuEVM6rZUkZaR3K1=b=jJYp_uroA@mail.gmail.com>
Subject: Re: [PATCH] hciattach: Add sleep|nosleep keyword
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Fri, Oct 17, 2014 at 3:48 PM, Andrei Emeltchenko
<Andrei.Emeltchenko.news@gmail.com> wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
>
> ---
>  tools/hciattach.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/tools/hciattach.c b/tools/hciattach.c
> index d8ef7e7..808bbac 100644
> --- a/tools/hciattach.c
> +++ b/tools/hciattach.c
> @@ -1276,7 +1276,9 @@ static void usage(void)
>  {
>         printf("hciattach - HCI UART driver initialization utility\n");
>         printf("Usage:\n");
> -       printf("\thciattach [-n] [-p] [-b] [-r] [-t timeout] [-s initial_speed] <tty> <type | id> [speed] [flow|noflow] [bdaddr]\n");
> +       printf("\thciattach [-n] [-p] [-b] [-r] [-t timeout] [-s initial_speed]"
> +                       " <tty> <type | id> [speed] [flow|noflow]"
> +                       " [sleep|nosleep] [bdaddr]\n");
>         printf("\thciattach -l\n");
>  }
>
> --
> 1.9.1

Applied, thanks.

-- 
Luiz Augusto von Dentz
