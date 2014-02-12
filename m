Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <2AA076F5-9C40-4449-84FB-FC68809197DF@codeaurora.org>
References: <1391772937-12802-1-git-send-email-lukasz.rymanowski@tieto.com>
	<CAMudyAsomuEjkpnj_2Dmqikx_t+nYsEcv_Ai0e6xzuFjG7vGbw@mail.gmail.com>
	<2AA076F5-9C40-4449-84FB-FC68809197DF@codeaurora.org>
Date: Wed, 12 Feb 2014 10:11:26 +0100
Message-ID: <CAMudyAtZ=yHvAq=2EhXFHFsJO7XySzsAt0F8P74U_B0JyH1TXg@mail.gmail.com>
Subject: Re: [RFC 0/2] Add hci_smd driver
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: Kumar Gala <galak@codeaurora.org>
Cc: linux-arm-msm@vger.kernel.org,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On 11 February 2014 21:00, Kumar Gala <galak@codeaurora.org> wrote:
>
> On Feb 11, 2014, at 10:23 AM, Lukasz Rymanowski <lukasz.rymanowski@tieto.com> wrote:
>
>> Hi
>>
>> On 7 February 2014 12:35, Lukasz Rymanowski <lukasz.rymanowski@tieto.com> wrote:
>>> Hello,
>>>
>>> This is a try (long shoot) to upstream hci shared memory driver (hci_smd)
>>> which is used on Qualcomm platforms and BT chips.
>>>
>>> To make it build with upstream tree I had to introduce some simple SMD API.
>>> The idea here is that since SMD channel is represented by platform device
>>> (as it is done in mach-msm),
>>> then platfrom_data contains smd_data which contains API for that channel.
>>>
>>> Writing this SMD API I was inspired with MSM-SMD and since I'm not an expert
>>> in this area I'm asking for comments here.
>>>
>>> Maybe instead of SMD API I made, I should expose functions like smd_open(), smd_write()
>>> etc. something similar how sdio does, and  just deliver to upstream dummy device
>>> implementing this SMD API?
>>>
>>> Other options I was considering is to implement  module inside mach-msm which
>>> would handle registering SMD BT Channels and when it is done, it would register
>>> new platform device like "smd-bt". Then I could move smd.h to some bluetooth includes
>>> (althought don't now where at the moment) and hci_smd would register driver for "smd-bt"
>>> In this case I would also could rid of one static variable I have now in hci_smd
>>>
>>> Comments on those options are welcome.
>>>
>>> Anyway, Hci_smd is based on one of the older version of this driver found in msm kernel
>>> branch, so there are no wakelocks as in new version and also workqueues are used
>>> instead of takslet.
>>>
>>> Since SMD expose two channels, one for CMD/EVENT and one for ACL Data I decide to
>>> do separate worqueues for this. This is to make sure that ACL data never blocks EVENT
>>> packages
>>>
>>
>> Adding linux-arm-msm group for comments on SMD API.
>>
>> BR
>> Lukasz
>
> What chip/SoC/board are you trying to get bluetooth support on?
>
I'm already running it on Nexus 4 and 7, but for this I have also more
changes in mach-msm (smd_tty.c, smd.c)  on top of msm kernel branch
for android.

\Lukasz
> - k
>

> --
> Employee of Qualcomm Innovation Center, Inc.
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
>
