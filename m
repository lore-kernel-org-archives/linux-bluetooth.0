Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1461659429-19139-3-git-send-email-beaufort.francois@gmail.com>
References: <1461659429-19139-1-git-send-email-beaufort.francois@gmail.com>
	<1461659429-19139-3-git-send-email-beaufort.francois@gmail.com>
Date: Tue, 26 Apr 2016 13:39:04 +0300
Message-ID: <CABBYNZLPMSsartuiO848emyniWCo-+QiKbS1oyq_C6NyUD4vTA@mail.gmail.com>
Subject: Re: [PATCH BlueZ] [client] Fix select-attribute behaviour
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Francois Beaufort <beaufort.francois@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Francois,

On Tue, Apr 26, 2016 at 11:30 AM, Francois Beaufort
<beaufort.francois@gmail.com> wrote:
> ---
>  client/main.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/client/main.c b/client/main.c
> index 209cf0c..c75b558 100644
> --- a/client/main.c
> +++ b/client/main.c
> @@ -350,7 +350,6 @@ done:
>         rl_set_prompt(desc ? desc : PROMPT_ON);
>         printf("\r");
>         rl_on_new_line();
> -       rl_redisplay();
>         g_free(desc);
>  }
>
> --
> 2.7.0

Applied, thanks.

-- 
Luiz Augusto von Dentz
