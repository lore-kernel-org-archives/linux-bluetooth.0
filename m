Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1297456626-22837-3-git-send-email-claudio.takahasi@openbossa.org>
References: <1297456626-22837-1-git-send-email-claudio.takahasi@openbossa.org>
	<1297456626-22837-3-git-send-email-claudio.takahasi@openbossa.org>
Date: Wed, 16 Feb 2011 14:02:57 -0300
Message-ID: <AANLkTin2rQKfqQS4fKx47XYieM9O8FgCWYBPCVVqJ-2n@mail.gmail.com>
Subject: Re: [RFC 2/7] Use memcpy to convert from network to host order on BE hosts
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Claudio,

On Fri, Feb 11, 2011 at 5:37 PM, Claudio Takahasi
<claudio.takahasi@openbossa.org> wrote:
> ---
>  lib/bluetooth.h |    4 +---
>  1 files changed, 1 insertions(+), 3 deletions(-)
>
> diff --git a/lib/bluetooth.h b/lib/bluetooth.h
> index bc020ad..d8f36f8 100644
> --- a/lib/bluetooth.h
> +++ b/lib/bluetooth.h
> @@ -127,9 +127,7 @@ static inline void btoh128(const uint128_t *src, uint128_t *dst)
>  #define ntoh64(x) (x)
>  static inline void ntoh128(const uint128_t *src, uint128_t *dst)
>  {
> -       int i;
> -       for (i = 0; i < 16; i++)
> -               dst->data[i] = src->data[i];
> +       memcpy(dst, src, sizeof(uint128_t));
>  }

I believe this patch is harmless and can be already applied
independently from other patches on this series, right?

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
