Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <fadd3646-89fa-aac8-a6f3-f65b99b4ea4a@felipetonello.com>
References: <20170216180315.30531-1-eu@felipetonello.com> <CABBYNZL7W15pdvZLezBO146RXw8ADNXcatiuU2XhEA9A0tzSMA@mail.gmail.com>
 <cdefb429-7549-5454-b53f-b4cd3628fbae@felipetonello.com> <CABBYNZKG_dieHOT017EPCCzMmbeHtBwcWY_1GMxXq6HUigKpTw@mail.gmail.com>
 <fadd3646-89fa-aac8-a6f3-f65b99b4ea4a@felipetonello.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 8 Mar 2017 13:19:56 +0200
Message-ID: <CABBYNZLBrW=Y3n+kodWS_A-_0bxyMZP_7qpiR5GpCgdzkPqXEQ@mail.gmail.com>
Subject: Re: [PATCH v2 BlueZ 0/7] Improvements on connection parameters update
To: Felipe Ferreri Tonello <eu@felipetonello.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Felipe,

On Wed, Mar 8, 2017 at 12:48 PM, Felipe Ferreri Tonello
<eu@felipetonello.com> wrote:
> Hi Luiz,
>
> Sorry for the late reply, I was unwell this last week.
>
> On 07/03/17 09:15, Luiz Augusto von Dentz wrote:
>> Hi Felipe,
>>
>> On Tue, Feb 21, 2017 at 11:40 AM, Felipe Ferreri Tonello
>> <eu@felipetonello.com> wrote:
>>> Hi Luiz,
>>>
>>> On 20/02/17 15:21, Luiz Augusto von Dentz wrote:
>>>> Hi Felipe,
>>>>
>>>> On Thu, Feb 16, 2017 at 8:03 PM, Felipe F. Tonello <eu@felipetonello.com> wrote:
>>>>> This is one of the parts of a series of patches related to connection
>>>>> parameters update.
>>>>>
>>>>> This initial implementation adds supports to GAP Peripheral Preferred
>>>>> Connection Parameters (PPCP) characteristic and the Slave Connection Interval
>>>>> Range Advertising Data (AD).
>>>>
>>>>
>>>> Are there any devices implementing these? Id like to do a some testing
>>>> but haven't find anything implementing this, or well I can generate
>>>> the PPCP but the SCRAD is probably a waste of AD since that is pretty
>>>> limited in size.
>>>
>>> PPCP not that I know of. But the AD there are devices, including in the
>>> unit-eir there is one.
>>>
>>> The PPCP and AD is important specially for MIDI devices who require
>>> low-latency.
>>>
>>> I did test it here, it will be nice if you could as well.
>>
>> Lets try to get some points resolved here, Ive briefly chatted with
>> Johan regarding this last week and he said that we might have to
>> introduce a new command to add new parameters to the kernel, as oppose
>> to reuse load.
>>
>> We might have to choose between these 2 options:
>>
>> 1. Reload all the settings, and then move on to implement the new command.
>
> Reload all settings as in bluetoothd reloading all settings?
>
> What new command?
>
>> 2. Don't bother with old kernels and just make it work with newer one
>> with proper support.
>
> New command to update the settings for one device only?

Yep, the reason for that is that changing the existing logic of load
may break the API for older kernels as it would no longer remove
existing settings but just update.

>>
>>>>
>>>>> There is a problem described in #4 that due to a limitation of the BlueZ API
>>>>> it is not possible to update the current connection with specific parameters.
>>>>> I am working on a socket option API to allow something similar. Hopefully I
>>>>> will be able to write something that covers this use-case as well. This
>>>>> problem also applies to patch #6.
>>>>>
>>>>> Changes from v1:
>>>>>  * Added Slave Connection Interval Range AD support;
>>>>>  * Unit tests for connection interval.
>>>>>
>>>>> Felipe F. Tonello (7):
>>>>>   profiles/gap: Some code cleanup
>>>>>   src/adapter: Added connection parameter load/store functions
>>>>>   src/device: Added function to set connection parameters
>>>>>   profiles/gap: Added support for PPCP characteristic
>>>>>   src/eir: Added support for Slave Connection Interval Range AD
>>>>>   src/adapter: Store Slave Connection Interval Range
>>>>>   unit/test-eir: Added tests for connection interval
>>>>>
>>>>>  profiles/gap/gas.c | 111 +++++++++++++++++++++++++++++++++++++++++++----------
>>>>>  src/adapter.c      |  46 +++++++++++++++++++++-
>>>>>  src/adapter.h      |   9 +++++
>>>>>  src/device.c       |  16 ++++++++
>>>>>  src/device.h       |   4 ++
>>>>>  src/eir.c          |   7 ++++
>>>>>  src/eir.h          |   3 ++
>>>>>  unit/test-eir.c    |  26 +++++++++++--
>>>>>  8 files changed, 196 insertions(+), 26 deletions(-)
>>>>>
>>>>> --
>>>>> 2.11.1
>>>>>
>
> --
> Felipe



-- 
Luiz Augusto von Dentz
