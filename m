Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZL+gir-CE5Loa6xK=s7+wSkRKV+R2-U940+17mwXczb6g@mail.gmail.com>
References: <1418910367-19792-1-git-send-email-lukasz.rymanowski@tieto.com>
	<CABBYNZL+gir-CE5Loa6xK=s7+wSkRKV+R2-U940+17mwXczb6g@mail.gmail.com>
Date: Fri, 19 Dec 2014 11:05:26 +0100
Message-ID: <CAMudyAu0aaJD8JhCXg7TBC+49eaWG0Stwtv7u9LtgSZj1xePVA@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] attrib/gattrib: Add tracking request id
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On 19 December 2014 at 01:13, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Hi Lukasz,
>
> On Thu, Dec 18, 2014 at 11:46 AM, Lukasz Rymanowski
> <lukasz.rymanowski@tieto.com> wrote:
>> With this set, gattrib is tracking it's internal request id.
>> This is important for the user of gattrib, as now user is sure that request id
>> he has is valid during whole gattrib operation. Even gattrib is doing more then one
>> ATT request.
>>
>> v1: Track only user defined request id's.
>> v2: Handle Marcel's comments to patch 01 and added patch 03\03 which add
>> support to track all the gattrib requests. So now if gattrib user does cancel_all
>> only gattrib request will be canceled. This is needed as bt_att is shared.
>>
>> First two patches help us to solve issues in Android, third one is not needed by
>> Android but for normal BlueZ.
>>
>>
>> Lukasz Rymanowski (2):
>>   attrib/gattrib: Add track for internal request id
>>   attrib/gatt: Fix for search services
>>
>> *** BLURB HERE ***
>>
>> Lukasz Rymanowski (3):
>>   attrib/gattrib: Add track for request ids
>>   attrib/gatt: Fix for search services
>>   attrib/gattrib: Add tracking all the internal request id
>>
>>  attrib/gatt.c    | 43 ++++++++++++++++++-------
>>  attrib/gattrib.c | 95 ++++++++++++++++++++++++++++++++++++++++++++++++++++++--
>>  2 files changed, 124 insertions(+), 14 deletions(-)
>>
>> --
>> 1.8.4
>
> Applied, please make sure you run make check next time patch 3/3 had a
> few problem that I had to fix before pushing.

Ah damn, sorry about that. I just check and indeed make check is very
convenient. I see the issue and your fix is good.

Thanks
\Łukasz
>
>
> --
> Luiz Augusto von Dentz
