Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1402301930-22304-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1402301930-22304-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Date: Mon, 9 Jun 2014 15:11:05 +0300
Message-ID: <CABBYNZL2y1EXRKp6bxN7zFpakP8o3+b+L7m3+7CusX3LzELiXw@mail.gmail.com>
Subject: Re: [PATCH] android/avrcp: Fix accessing pointer
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Mon, Jun 9, 2014 at 11:18 AM, Andrei Emeltchenko
<Andrei.Emeltchenko.news@gmail.com> wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
>
> ---
>  android/avrcp-lib.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/android/avrcp-lib.c b/android/avrcp-lib.c
> index 12b6183..1de313b 100644
> --- a/android/avrcp-lib.c
> +++ b/android/avrcp-lib.c
> @@ -1824,7 +1824,7 @@ static int parse_value(struct avrcp_header *pdu, uint8_t *number,
>          */
>         if (*number > AVRCP_ATTRIBUTE_LAST ||
>                                         1 + *number * 2 != pdu->params_len) {
> -               number = 0;
> +               *number = 0;
>                 return -EPROTO;
>         }
>
> --
> 1.8.3.2

Pushed, thanks.


-- 
Luiz Augusto von Dentz
