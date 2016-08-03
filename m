Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CABi8O6YW-wmG8xF5V7vkGJ8_3Wp98-b57L+1jJK_DxWjz=couQ@mail.gmail.com>
References: <CABi8O6YW-wmG8xF5V7vkGJ8_3Wp98-b57L+1jJK_DxWjz=couQ@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 3 Aug 2016 13:21:35 +0300
Message-ID: <CABBYNZ++wDB=Hy6YNXo-UU2xiVEazSHGKd60+=1XNk8yTWKcfw@mail.gmail.com>
Subject: Re: [PATCH SBC] Fix for build on windows mingw
To: Ilya Averyanov <averyanovin@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ilya,

On Tue, Aug 2, 2016 at 6:14 PM, Ilya Averyanov <averyanovin@gmail.com> wrote:

Please add some description, perhaps with the error caused by the lack
of this include.

> ---
>  sbc/sbc_math.h | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/sbc/sbc_math.h b/sbc/sbc_math.h
> index 5476860..25b08ea 100644
> --- a/sbc/sbc_math.h
> +++ b/sbc/sbc_math.h
> @@ -24,6 +24,8 @@
>   *
>   */
>
> +#include <stdint.h>
> +
>  #define fabs(x) ((x) < 0 ? -(x) : (x))
>  /* C does not provide an explicit arithmetic shift right but this will
>     always be correct and every compiler *should* generate optimal code */
> --
> 2.7.4
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Luiz Augusto von Dentz
