Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1442945350-24346-1-git-send-email-szymon.janc@gmail.com>
References: <1442945350-24346-1-git-send-email-szymon.janc@gmail.com>
Date: Wed, 23 Sep 2015 10:55:55 +0300
Message-ID: <CABBYNZL4BkHO_Mz7UvROBD0V5qYu7oHaUfMKW7OPNcME06oowA@mail.gmail.com>
Subject: Re: [PATCH] shared/gatt-helpers: Fix reporting discovery failure
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Szymon Janc <szymon.janc@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Tue, Sep 22, 2015 at 9:09 PM, Szymon Janc <szymon.janc@gmail.com> wrote:
> If sending ATT request failed discovery should be reported as failed.
> Due to missing goto success was overwritten with true value.
> This regression was introduced in db24bf09d66325a.
> ---
>  src/shared/gatt-helpers.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/src/shared/gatt-helpers.c b/src/shared/gatt-helpers.c
> index c773df7..008b8bc 100644
> --- a/src/shared/gatt-helpers.c
> +++ b/src/shared/gatt-helpers.c
> @@ -1490,6 +1490,7 @@ static void discover_descs_cb(uint8_t opcode, const void *pdu,
>                         return;
>
>                 success = false;
> +               goto done;
>         }
>
>         success = true;
> --
> 2.5.0

Applied, thanks.


-- 
Luiz Augusto von Dentz
