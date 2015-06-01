Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1432851224-19550-1-git-send-email-szymon.janc@tieto.com>
References: <1432851224-19550-1-git-send-email-szymon.janc@tieto.com>
Date: Mon, 1 Jun 2015 13:56:04 +0300
Message-ID: <CABBYNZLcj5vPEsCUHdq-MeW0eeAOmK9G7neoPrncNyv1DXGVYA@mail.gmail.com>
Subject: Re: [PATCH 1/2] monitor: Use black font for white background
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Fri, May 29, 2015 at 1:13 AM, Szymon Janc <szymon.janc@tieto.com> wrote:
> Make sure that font is always visible on white background.
> ---
>  monitor/display.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/monitor/display.h b/monitor/display.h
> index e627401..df08362 100644
> --- a/monitor/display.h
> +++ b/monitor/display.h
> @@ -35,7 +35,7 @@ bool use_color(void);
>  #define COLOR_MAGENTA  "\x1B[0;35m"
>  #define COLOR_CYAN     "\x1B[0;36m"
>  #define COLOR_WHITE    "\x1B[0;37m"
> -#define COLOR_WHITE_BG "\x1B[0;47m"
> +#define COLOR_WHITE_BG "\x1B[0;47;30m"
>  #define COLOR_HIGHLIGHT        "\x1B[1;39m"
>
>  #define COLOR_ERROR    "\x1B[1;31m"
> --
> 1.9.3

Applied, thanks/


-- 
Luiz Augusto von Dentz
