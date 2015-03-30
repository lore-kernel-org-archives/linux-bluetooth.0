Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1427705138-21398-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1427705138-21398-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Date: Mon, 30 Mar 2015 12:39:46 +0300
Message-ID: <CABBYNZKr3n1jqkZPuKcjopc-Lrp4CozaaHSykga-57=_6QhdQg@mail.gmail.com>
Subject: Re: [PATCH] lib/uuid: Fix 32 bit bt_uuid to le
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Grzegorz,

On Mon, Mar 30, 2015 at 11:45 AM, Grzegorz Kolodziejczyk
<grzegorz.kolodziejczyk@tieto.com> wrote:
> Conversion from be to le can be done using bluetooth funcion.
> ---
>  lib/uuid.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/lib/uuid.c b/lib/uuid.c
> index 15fbd66..2f598b8 100644
> --- a/lib/uuid.c
> +++ b/lib/uuid.c
> @@ -338,15 +338,13 @@ int bt_uuid_strcmp(const void *a, const void *b)
>
>  int bt_uuid_to_le(const bt_uuid_t *src, void *dst)
>  {
> -       bt_uuid_t uuid;
> -
>         switch (src->type) {
>         case BT_UUID16:
>                 bt_put_le16(src->value.u16, dst);
>                 return 0;
>         case BT_UUID32:
> -               bt_uuid_to_uuid128(src, &uuid);
> -               /* Fallthrough */
> +               bt_put_le32(src->value.u32, dst);
> +               return 0;

I think the idea is to either use 16 or 128 bits format and never 32
bits thus the reason why we convert to 32 to 128, btw 128 format is in
fact a byte arrays therefore endianess conversion per architecture
don't apply, we do have a convention to define the array in big endian
format, thus we always need to swap.

>         case BT_UUID128:
>                 /* Convert from 128-bit BE to LE */
>                 bswap_128(&src->value.u128, dst);
> --
> 2.1.0




-- 
Luiz Augusto von Dentz
