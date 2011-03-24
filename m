Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <4D7FBA0F.7070208@codeaurora.org>
References: <cover.1298307667.git.vinicius.gomes@openbossa.org>
	<02fa778ab4292dffba1330e829b0d4029517a21e.1298307667.git.vinicius.gomes@openbossa.org>
	<20110227202041.GG2166@joana>
	<AANLkTi=j3REcNM4bXfFJPamPwqazS5k4eGAJf3BpB_Ya@mail.gmail.com>
	<20110228172801.GB2165@joana>
	<20110303174501.GA10733@piper>
	<20110309225246.GA3009@piper>
	<AANLkTinQh-oM+Dn-j8Rt8s99edozbXFjC-MUwiOLd_y1@mail.gmail.com>
	<4D7FBA0F.7070208@codeaurora.org>
Date: Thu, 24 Mar 2011 11:14:51 -0300
Message-ID: <AANLkTin_yLAyWjLjqk-5Z-gerWeVxQhk4ONtngqt1zKT@mail.gmail.com>
Subject: Re: [bluetooth-next 04/15] Bluetooth: Add support for using the
 crypto subsystem
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: Brian Gix <bgix@codeaurora.org>
Cc: Anderson Briglia <anderson.briglia@openbossa.org>,
	Vinicius Costa Gomes <vinicius.gomes@openbossa.org>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi all developers interested on LE,

On Tue, Mar 15, 2011 at 4:12 PM, Brian Gix <bgix@codeaurora.org> wrote:
> On 3/15/2011 12:03 PM, Anderson Briglia wrote:
>>
>> Hi all,
>>
>> On Wed, Mar 9, 2011 at 6:52 PM, Vinicius Costa Gomes
>> <vinicius.gomes@openbossa.org>  wrote:
>>>
>>> On 14:45 Thu 03 Mar, Vinicius Costa Gomes wrote:
>>>>
>>>> Hi Marcel,
>>>>
>>>> On 14:28 Mon 28 Feb, Gustavo F. Padovan wrote:
>>>>>
>>>>> Hi Vinicius,
>>>>>
>>>>> * Vinicius Gomes<vinicius.gomes@openbossa.org>  [2011-02-27 21:49:39
>>>>> -0300]:
>>>>>
>>>>>> Hi Gustavo,
>>>>>>
>>>>>> On Sun, Feb 27, 2011 at 5:20 PM, Gustavo F. Padovan
>>>>>> <padovan@profusion.mobi>  wrote:
>>>>>>>
>>>>>>> Hi Vinicius,
>>>>>>>
>>>>>>> * Vinicius Costa Gomes<vinicius.gomes@openbossa.org>  [2011-02-21
>>>>>>> 14:23:51 -0300]:
>>>>>>>
>
> [...]
>
>>>>
>>>> Any ideas?
>>>
>>> Still no ideas?
>>>
>>
>> We at INdT have some patches based on top of this series. What is the
>> maintainer's opinion about this series? I'm asking it because should
>> be great to know if we are doing the right stuff or we need to change
>> our approach. The number of features and patches that have this series
>> as dependency is growing.
>
> I am also developing patches off of this series and have signed off on their
> baseline functionality.
>
>> Regards,
>>
>> Anderson Briglia
>
>
> --
> Brian Gix
> bgix@codeaurora.org
> Employee of Qualcomm Innovation Center, Inc.
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

Patches not upstream(bluetooth-next) are available here:
git://gitorious.org/bluetooth-next/for-upstream.git

Contains patches for SM just works method, advertising cache and MTU.

BR,
Claudio
