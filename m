Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <AANLkTin2rQKfqQS4fKx47XYieM9O8FgCWYBPCVVqJ-2n@mail.gmail.com>
References: <1297456626-22837-1-git-send-email-claudio.takahasi@openbossa.org>
	<1297456626-22837-3-git-send-email-claudio.takahasi@openbossa.org>
	<AANLkTin2rQKfqQS4fKx47XYieM9O8FgCWYBPCVVqJ-2n@mail.gmail.com>
Date: Thu, 17 Feb 2011 11:46:23 -0200
Message-ID: <AANLkTim5rV5YZnrcz9ECUSKTC6UWvFaf5V_ZO4dqwNiC@mail.gmail.com>
Subject: Re: [RFC 2/7] Use memcpy to convert from network to host order on BE hosts
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lizardo,

On Wed, Feb 16, 2011 at 3:02 PM, Anderson Lizardo
<anderson.lizardo@openbossa.org> wrote:
> Hi Claudio,
>
> On Fri, Feb 11, 2011 at 5:37 PM, Claudio Takahasi
> <claudio.takahasi@openbossa.org> wrote:
>> ---
>>  lib/bluetooth.h |    4 +---
>>  1 files changed, 1 insertions(+), 3 deletions(-)
>>
>> diff --git a/lib/bluetooth.h b/lib/bluetooth.h
>> index bc020ad..d8f36f8 100644
>> --- a/lib/bluetooth.h
>> +++ b/lib/bluetooth.h
>> @@ -127,9 +127,7 @@ static inline void btoh128(const uint128_t *src, uint128_t *dst)
>>  #define ntoh64(x) (x)
>>  static inline void ntoh128(const uint128_t *src, uint128_t *dst)
>>  {
>> -       int i;
>> -       for (i = 0; i < 16; i++)
>> -               dst->data[i] = src->data[i];
>> +       memcpy(dst, src, sizeof(uint128_t));
>>  }
>
> I believe this patch is harmless and can be already applied
> independently from other patches on this series, right?
>
> Regards,
> --
> Anderson Lizardo
> Instituto Nokia de Tecnologia - INdT
> Manaus - Brazil
>

Yes, it is harmless. I gonna remove this patch from this series and
also add extra comments to emphasize that it is not converting the
value, it just replace the for by a direct memory copy for BE hosts.

Br,
Claudio
