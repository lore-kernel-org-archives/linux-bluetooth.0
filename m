Return-Path: <cyrus@holtmann.org>
Date: Fri, 14 Mar 2014 15:54:53 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ v4 05/20] shared: Add put_le128()
Message-ID: <20140314135453.GA21071@localhost.P-661HNU-F1>
References: <1394742168-31073-1-git-send-email-claudio.takahasi@openbossa.org>
 <1394802800-8424-1-git-send-email-claudio.takahasi@openbossa.org>
 <1394802800-8424-6-git-send-email-claudio.takahasi@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1394802800-8424-6-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Claudio,

On Fri, Mar 14, 2014, Claudio Takahasi wrote:
> Add helper to put uint128 values to the given pointer using little-endian
> representation. This helper is only a wrapper of cpu_to_le128().
> ---
>  src/shared/util.h | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)

I've applied patches 1-4, but had to stop with this one.

> diff --git a/src/shared/util.h b/src/shared/util.h
> index cc2dbcd..f3db8fb 100644
> --- a/src/shared/util.h
> +++ b/src/shared/util.h
> @@ -26,6 +26,8 @@
>  #include <alloca.h>
>  #include <byteswap.h>
>  
> +#include <bluetooth/bluetooth.h>

I don't think we want shared/util.h (an LGPL header) depending on
lib/bluetooth.h (a GPL header).

> +static inline void cpu_to_le128(const uint128_t *src, uint128_t *dst)
> +{
> +	int i;
> +
> +	for (i = 0; i < 16; i++)
> +		dst->data[15 - i] = src->data[i];
> +}
> +
> +#else
> +
> +static inline void cpu_to_le128(const uint128_t *src, uint128_t *dst)
> +{
> +	*dst = *src;
> +}

What would probably work is to completely avoid the uint128_t type and
instead do something like:

static inline void cpu_to_le128(const void *src, void *dst)
{
	const uint8_t *src_data = src;
	uint8_t *dst_data = dst;

	for (...)
	...
}

That way you could still pass uint128_t pointers to the function and it
would still work (and it would also work with any other 128-bit type we
come up with).

This all said, are you sure this is the correct way of converting a UUID
from host endianness to LE? Looking at the UUID specification[1], mainly
section 12.1, it seems the various components should be converted
independently. So basically what you have is a generic 128-bit byte
order converter, but it's not necessarily usable for UUIDs (which seems
to be the only/main thing you're using it for).

Johan

[1] http://www.itu.int/ITU-T/studygroups/com17/oid/X.667-E.pdf
