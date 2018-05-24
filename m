Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <6089f1f8-e4d9-3ac6-4ec4-82f171f512c1@flypig.co.uk>
References: <20180522095011.517-1-luiz.dentz@gmail.com> <9313e463-558a-57da-529e-0c463b8fbf24@flypig.co.uk>
 <CABBYNZ+YQVfJCfHUxkR5BEWenu4OpsukDycvGFFApeOTWiWbEA@mail.gmail.com> <6089f1f8-e4d9-3ac6-4ec4-82f171f512c1@flypig.co.uk>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 24 May 2018 14:05:23 +0300
Message-ID: <CABBYNZK4t-S0nJjrtA2qebAcZqNnuEj1wOSGJuxd5mX5YiMTaA@mail.gmail.com>
Subject: Re: [PATCH v3 1/8] doc/advertising-api: Add Discoverable property
To: David Llewellyn-Jones <david@flypig.co.uk>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Tue, May 22, 2018 at 1:52 PM, David Llewellyn-Jones
<david@flypig.co.uk> wrote:
> Hi Luiz,
>
> On 22/05/18 11:45, Luiz Augusto von Dentz wrote:
>> Hi David,
>>
>> On Tue, May 22, 2018 at 1:25 PM, David Llewellyn-Jones
>> <david@flypig.co.uk> wrote:
>>> On 22/05/18 10:50, Luiz Augusto von Dentz wrote:
>>>> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>>>>
>>>> This adds Discoverable which the application can use in case it want
>>>> to set the General Discoverable flag per instance.
>>>>
>>>> Note: This would allow for example an application to advertise as
>>>> discoverable even if the adapter is not discoverable which may be
>>>> required by dual-mode as it may not require BR/EDR to be discoverable.
>>>
>>> Thanks for these patches Luiz. I'm not sure whether it's useful for me
>>> to comment on them, or whether this is just part of the process of them
>>> winding their way towards a release.
>>>
>>> Is there anything helpful I can do with regards these?
>>
>> It is just the regular process, Marcel made some comments that this
>> set should fix, but feel free to comment if you find there is
>> something that we should address.
>
> Okay, thank you for clarifying. I'd hesitate to make comments without
> having tried it, so I'll give it a go and see if anything comes up.
>
> Thanks for all of your work on this. It'll be great to have this
> controllable.

Applied.

-- 
Luiz Augusto von Dentz
