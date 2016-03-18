Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Subject: Re: Questing regarding Broadcom Module
To: =?UTF-8?Q?Fr=c3=a9d=c3=a9ric_Danis?= <frederic.danis.oss@gmail.com>,
	Andreas Stahl <tcm.home@gmx.de>,
	Frederic Danis <frederic.danis@linux.intel.com>
References: <56DEA34C.5000909@gmx.de>
 <CAF7Mx6ozJ_GfhJqQn5VFWLXFpDKOhiDsTQc-mSHioH=-asyd8g@mail.gmail.com>
 <56E1197A.1050205@gmx.de> <56E13C80.70009@broadcom.com>
 <56E1932B.9030108@linux.intel.com> <56E1DFDF.1000405@gmx.de>
 <56EBAB95.5030101@gmail.com>
Cc: brcm80211-dev-list <brcm80211-dev-list@broadcom.com>,
	linux-bluetooth@vger.kernel.org
From: Arend Van Spriel <arend.vanspriel@broadcom.com>
Message-ID: <56EBCB6C.2040403@broadcom.com>
Date: Fri, 18 Mar 2016 10:33:32 +0100
MIME-Version: 1.0
In-Reply-To: <56EBAB95.5030101@gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

+ bt mailing list

On 18-3-2016 8:17, Frédéric Danis wrote:
> Hello Andreas,
> 
> Can you send kernel logs with debug info from hci_uart module (adding
> 'dyndbg="module hci_uart +pf"' to kernel command line, see
> Documentation/dynamic-debug-howto.txt) ?

Wondering whether this module does runtime pm. Could you try with rpm
disabled.

Regards,
Arend

> Regards
> 
> Fred
> 
> Le 10/03/2016 21:58, Andreas Stahl a écrit :
>> Hi Fred,
>>
>> I am actually using BlueZ. It works pretty well. I have even debugged
>> the HCI commands being sent and the messages being received, however I
>> can't find a pattern what makes the module completely unresponsive.
>>
>> Especially the sudden interrupt when just performing A2DP Streaming
>> towards Bluetooth headphones. It just simply stops working.
>>
>> Regarding the other situation with pairing during A2DP streaming: This
>> doesn't always fail. It never fails when you don't A2DP stream. The
>> error shows itself at random and sometimes when you pair and then
>> remove the keyboard (which includes disconnecting it) while performing
>> A2DP streaming.
>>
>> I tried looking at the hci package with hcidump as well as debugging
>> the kernel module directly. I still think it is the module itself that
>> fails. Using another broadcom module from another project, which
>> doesn't integrate wifi (not the desired case), works in all cases with
>> the same software and kernel drivers. I need to look up which module
>> it is that works just fine. Sadly my task is to get this specific one
>> running.
>>
>> Some additional data about the system:
>>
>> * Linux kernel 3.4.36 (patched with backported bluetooth drivers from
>> 4.3.x kernel)
>> * ARM Platform
>> * Latest BlueZ 5.37
>>
>> I also have tested the old BCM Module as well as the Wifi/BT
>> Combination module in another system with similar setup, however a
>> newer kernel and I get the same results: The older Module works, the
>> one that needs to be implemented (BCM43569) does not.
>>
>> Are there any debug outputs you can get from the bluetooth side
>> somehow? UART pins maybe that would show if the module has some kind
>> of fault or crash in this situation? I just don't see this error in
>> user- or kernel space anymore.
>>
>> Any advice is welcome to tackle this one.
>>
>> Best Regards,
>> Andreas Stahl
>>
>>
>>
>> Am 10.03.2016 um 16:30 schrieb Frederic Danis:
>>> + Frederic's personal OSS email
>>>
>>> Do you use btattach or hciattach with your BT module ?
>>>
>>> Regards
>>>
>>> Fred
>>>
>>> On 10/03/2016 10:21, Arend Van Spriel wrote:
>>>> + Frederic
>>>>
>>>> On 10-3-2016 7:51, Andreas Stahl wrote:
>>>>> Hello,
>>>>>
>>>>> thank you for your response. That lets me hope a little since
>>>>> trying out
>>>>> different firmware didn't change in the behavior of the module.
>>>>>
>>>>> When the module doesn't react anymore, wifi still works. Reloading the
>>>>> kernel driver doesn't help at all. It also complains about timeouts
>>>>> when
>>>>> detecting the bluetooth part.
>>>> Let's get a bit more information:
>>>>
>>>> - what platform are you using?
>>>> - what kernel version are you using?
>>>> - what bluez user-space version are you using?
>>>>
>>>> I think Intel uses bcm43340 so maybe they can give you pointers as they
>>>> worked on bt part.
>>>>
>>>> Regards,
>>>> Arend
>>>>
>>>>> Is there a source where I could find and existing patch for the
>>>>> bluetooth rom? Maybe the bluetooth part of the chip is also
>>>>> available as
>>>>> a stand alone chip which might already have a patch?
>>>>>
>>>>> Best Regards,
>>>>> Andreas Stahl
>>>>>
>>>>>
>>>>>
>>>>> On 03/08/2016 03:16 PM, Arend Van Spriel wrote:
>>>>>> Op 8 mrt. 2016 11:02 schreef "Andreas Stahl"
>>>>>> <<mailto:tcm.home@gmx.de>tcm.home@gmx.de>:
>>>>>>> Hello,
>>>>>>>
>>>>>>> sorry to disturb you. I saw that you are active in the open source
>>>>>> projects regarding broadcom products, especially wireless drivers.
>>>>>>> I am using a BCM43569 chip in linux for a project, which integrates
>>>>>> wifi and bluetooth capabilities. The module replaces a previous
>>>>>> combination of two distinct modules providing wifi and bluetooth
>>>>>> capabilities.
>>>>>>> Despite initial problems, the drivers work fine now with the module.
>>>>>> However it seems like the module "crashes" in certain use cases. In
>>>>>> Detail the hci commands on bluetooth start timing out. Bluetooth is
>>>>>> without operation, however wifi seems to stay in tact.
>>>>>>> Only a reset of the devices revives the bluetooth capabilities.
>>>>>>>
>>>>>>> In my test case I start an A2DP-Sink session (connecting to
>>>>>> bluetooth headphones) and then pair a bluetooth keyboard. In a good
>>>>>> bit of cases, during pairing or removing the pairing halts all
>>>>>> bluetooth operations.
>>>>>>> Since I can only see the kernel driver complaining about hci
>>>>>> timeouts, I am grasping for straws here trying to find a solution.
>>>>>>
>>>>>> Admittedly my BT knowledge is very limited so I would be grasping
>>>>>> straws on a trimmed lawn.
>>>>>>
>>>>>>> The same situation doesn't seem to happen with another broadcom
>>>>>> bluetooth module (without wifi integration) with the same kernel
>>>>>> code,
>>>>>> however for this project I need the combination module.
>>>>>>> Sorry for the information overload, but do you know any way to help
>>>>>> or is there somebody who could assist in support?
>>>>>>
>>>>>> No idea. Will forward your email.
>>>>>>
>>>>>>> Is there a way to get debug output from the chip? Does the loaded
>>>>>> firmware also include the bluetooth implementation?
>>>>>>
>>>>>> BT runs from ROM, but that can be patched. It is not part of wifi
>>>>>> firmware.
>>>>>>
>>>>>>> Again, thank you in advance for any advice you can give and sorry
>>>>>> for disturbing you. If you are the wrong person to ask, let me know
>>>>>> and I won't contact you again.
>>>>>>
>>>>>> For wifi driver questions I am (one of) the right person(s).
>>>>>>
>>>>>> Gr. AvS
>>>>>>> Best Regards,
>>>>>>> Andreas Stahl
>>>
>>>
>>
> 
