Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZJzzm6UyN_xMrv96Ni42JJ5ymdEUp969Z=s-QOOToOSDA@mail.gmail.com>
References: <1479519172-32499-1-git-send-email-mcchou@chromium.org> <CABBYNZJzzm6UyN_xMrv96Ni42JJ5ymdEUp969Z=s-QOOToOSDA@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 21 Nov 2016 12:18:39 +0200
Message-ID: <CABBYNZ+_=ihEO+sVwUV-w5eNOs2FB=7OpjMPTdik_jLHCR29Jw@mail.gmail.com>
Subject: Re: [PATCH] monitor/rfcomm: Fix a potential memory access issue
To: mcchou@chromium.org
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto Von Dentz <luiz.von.dentz@intel.com>,
        josephsih@chromium.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Mon, Nov 21, 2016 at 12:06 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Hi,
>
> On Sat, Nov 19, 2016 at 3:32 AM,  <mcchou@chromium.org> wrote:
>> From: Miao-chen Chou <mcchou@chromium.org>
>>
>> Packed structs have a default alignment of 1. If address of a member
>> is taken, the pointer value could be unaligned. Unaligned memory accesses
>> can result in a crash in some architectures.
>
> Afaik if it is byte aligned it shall never cause unaligned memory
> accesses as the members are loaded byte a byte. which is what we want
> here since it is a network PDU we don't want padding.

Actually just to correct myself, packed can cause unaligned access,
but the solution is to use proper unaligned operation and not align
the struct which may introduce padding.

>> ---
>>  monitor/rfcomm.c | 2 +-
>>  monitor/rfcomm.h | 2 +-
>>  2 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/monitor/rfcomm.c b/monitor/rfcomm.c
>> index b32ad40..7c688af 100644
>> --- a/monitor/rfcomm.c
>> +++ b/monitor/rfcomm.c
>> @@ -106,7 +106,7 @@ struct rfcomm_rpn {
>>         uint8_t xon;
>>         uint8_t xoff;
>>         uint16_t pm;
>> -} __attribute__ ((packed));
>> +} __attribute__ ((packed, aligned(2)));
>>
>>  struct rfcomm_rls {
>>         uint8_t dlci;
>> diff --git a/monitor/rfcomm.h b/monitor/rfcomm.h
>> index c157352..a8af484 100644
>> --- a/monitor/rfcomm.h
>> +++ b/monitor/rfcomm.h
>> @@ -77,4 +77,4 @@ struct rfcomm_pn {
>>         uint16_t mtu;
>>         uint8_t  max_retrans;
>>         uint8_t  credits;
>> -} __attribute__((packed));
>> +} __attribute__((packed, aligned(2)));
>> --
>> 2.8.0.rc3.226.g39d4020
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
>
> --
> Luiz Augusto von Dentz



-- 
Luiz Augusto von Dentz
