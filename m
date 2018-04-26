Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20180426123200.3916-1-grzegorz.kolodziejczyk@codecoup.pl>
References: <20180426123200.3916-1-grzegorz.kolodziejczyk@codecoup.pl>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 26 Apr 2018 15:58:26 +0300
Message-ID: <CABBYNZJwKs9T4_esyi+DTfxmGgZo6ABBgdUN8WHH+SqD6pPpPw@mail.gmail.com>
Subject: Re: [PATCH BlueZ v3 1/4] tools/hcitool: Change connection handle
 condition for lecup
To: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@codecoup.pl>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Grzegorz,

On Thu, Apr 26, 2018 at 3:31 PM, Grzegorz Kolodziejczyk
<grzegorz.kolodziejczyk@codecoup.pl> wrote:
> According to BLUETOOTH SPECIFICATION Version 5.0 | Vol 2, Part E
> 7.8.18 LE Connection Update Command, connection handle range is
> 0x0000-0x0EFF.
> ---
>  tools/hcitool.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/hcitool.c b/tools/hcitool.c
> index 02c4ebe1b..945f675b0 100644
> --- a/tools/hcitool.c
> +++ b/tools/hcitool.c
> @@ -3351,7 +3351,7 @@ static void cmd_lecup(int dev_id, int argc, char **argv)
>                 timeout = strtoul(argv[4], NULL, 0);
>         }
>
> -       if (handle == 0) {
> +       if (handle > 0x0EFF) {
>                 printf("%s", lecup_help);
>                 return;
>         }
> --
> 2.13.6

Applied, thanks.

-- 
Luiz Augusto von Dentz
