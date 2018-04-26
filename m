Return-Path: <hdegoede@redhat.com>
Subject: Re: [4.15 stable regression] "Bluetooth: btusb: Fix quirk for Atheros
 1525/QCA6174" breaks bluetooth on some devices
To: Takashi Iwai <tiwai@suse.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Marcel Holtmann <marcel@holtmann.org>, "M. Kristall" <mkpdev@gmail.com>,
 linux-bluetooth@vger.kernel.org
References: <6c97cffb-751f-466d-cd7b-42624fdb18c7@redhat.com>
 <9a752bfc-74bf-25e7-8820-91d1e3163b75@redhat.com>
 <20180425124757.GA29829@kroah.com>
 <e5cbd297-f8b1-2fd0-cd99-cfd39ea55b62@redhat.com>
 <s5hmuxrjusq.wl-tiwai@suse.de>
From: Hans de Goede <hdegoede@redhat.com>
Message-ID: <9b2d31fc-be06-cc05-1ec1-3d0f6f1e21bf@redhat.com>
Date: Thu, 26 Apr 2018 14:18:23 +0200
MIME-Version: 1.0
In-Reply-To: <s5hmuxrjusq.wl-tiwai@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On 25-04-18 15:10, Takashi Iwai wrote:
> On Wed, 25 Apr 2018 14:49:59 +0200,
> Hans de Goede wrote:
>>
>> Hi,
>>
>> On 25-04-18 14:47, Greg Kroah-Hartman wrote:
>>> On Wed, Apr 25, 2018 at 02:40:37PM +0200, Hans de Goede wrote:
>>>> Hi,
>>>>
>>>> On 18-04-18 15:18, Hans de Goede wrote:
>>>>> Hi Takashi, Marcel,
>>>>>
>>>>> It seems that this commit:
>>>>> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git/commit/?h=linux-4.15.y&id=7ec32f585fefd7c154453aa29ccf8fa2a11cc865
>>>>>
>>>>> Is breaking bluetooth on some devices, see:
>>>>>
>>>>> https://bugzilla.redhat.com/show_bug.cgi?id=1568911
>>>>>
>>>>> The problem is the following error now being thrown:
>>>>>
>>>>> [   28.466248] Bluetooth: hci0: don't support firmware rome 0x1020200
>>>>>
>>>>> Looking at the code I wonder if maybe we need to mask the ver_rom
>>>>> with & 0xfff when comparing it to the qca_devices_table[i].rom_version
>>>>> filed ?
>>>>>
>>>>> Or maybe the commit is actually wrong, or maybe devices with the
>>>>> 0cf3:3004 USB id need either the BTUSB_QCA_ROM or BTUSB_ATH3012
>>>>> quirk depending on the device and we need to probe this somehow?
>>>>
>>>> I've been receiving more complaints from users about this on
>>>> various devices, so I think that the 7ec32f585fefd7c154453aa29ccf8fa2a11cc865
>>>> commit should be reverted from 4.15.x while we figure this out.
>>>>
>>>> Does anyone have any idea how we cam distinguish between the 2
>>>> different versions which seem to be hiding between the same USB-id ?
>>>
>>> 4.15.y is end-of-life, so there is no more releases being made for it,
>>> sorry.
>>
>> Ah, right, no problem, Fedora should be moving to 4.16.x soon then
>> anyways.
>>
>>> But, this commit is in 4.4.y, 4.9.y, 4.14.y, and 4.16.  Can you revert
>>> it in Linus's tree and I can revert it everywhere else as well?
>>
>> Takashi, do you agree that reverting this for now is best? And if so
>> can you please send a revert?
> 
> The best would be to fix it properly :)
> 
> But I agree that it needs a quick resolution, and the revert is
> appropriate in this case.  Since you've confirmed that the revert
> worked, feel free to submit the revert patch from your side.

Done.

> Back to the original issue: now I'm wondering what made such
> inconsistent behavior.  My current suspect is the racy driver loading
> between btusb and ath3k.  Both have the same USB ID, and the driver
> loading order may interfere the behavior with each other?
> 
> Or might it be a WiFi/BT combo chip that may have a racy firmware
> initialization?

I've no idea I'm afraid.

Regards,

Hans
