Return-Path: <hdegoede@redhat.com>
Subject: Re: [PATCH] Bluetooth: btusb: Restore QCA Rome suspend/resume fix
 with a "rewritten" version
To: Brian Norris <briannorris@chromium.org>
Cc: Marcel Holtmann <marcel@holtmann.org>,
 "Gustavo F. Padovan" <gustavo@padovan.org>,
 Johan Hedberg <johan.hedberg@gmail.com>,
 Bluez mailing list <linux-bluetooth@vger.kernel.org>,
 linux-serial@vger.kernel.org,
 ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
 stable <stable@vger.kernel.org>, Leif Liddy <leif.linux@gmail.com>,
 Matthias Kaehlcke <mka@chromium.org>, Daniel Drake <drake@endlessm.com>,
 Kai-Heng Feng <kai.heng.feng@canonical.com>, matadeen@qti.qualcomm.com,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Guenter Roeck <linux@roeck-us.net>
References: <20180108094416.4789-1-hdegoede@redhat.com>
 <20180213022455.GA151190@rodete-desktop-imager.corp.google.com>
 <8cd918fd-bf6f-70ac-e561-e7deffa695f0@redhat.com>
 <20180216022721.GA69988@rodete-desktop-imager.corp.google.com>
 <345b0de8-1a23-d2f8-bc56-507eadf7faa7@redhat.com>
 <6B37F6AC-1103-4FCF-A5DC-4BA236A7B11B@holtmann.org>
 <1a08612e-2531-3711-ec0f-a867e86d0009@redhat.com>
 <20180216175955.GA80944@rodete-desktop-imager.corp.google.com>
 <a846c1ac-7dea-a30a-4133-32eac606d101@redhat.com>
 <20180223031216.GA230265@rodete-desktop-imager.corp.google.com>
From: Hans de Goede <hdegoede@redhat.com>
Message-ID: <a6090910-7941-b194-c094-7ce3ef047974@redhat.com>
Date: Fri, 23 Feb 2018 08:14:28 +0100
MIME-Version: 1.0
In-Reply-To: <20180223031216.GA230265@rodete-desktop-imager.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On 23-02-18 04:12, Brian Norris wrote:
> Hi Hans,
> 
> Sorry if I'm a little slow to follow up here. This hasn't been my
> top priority...
> 
> On Mon, Feb 19, 2018 at 11:17:24AM +0100, Hans de Goede wrote:
>> On 16-02-18 18:59, Brian Norris wrote:
>>> On Fri, Feb 16, 2018 at 01:10:20PM +0100, Hans de Goede wrote:
>>>> Ok, I've asked the reporter of:
>>>>
>>>> https://bugzilla.redhat.com/show_bug.cgi?id=1514836
>>>
>>> Are you even sure that this reporter is seeing the original symptom at
>>> all (BT loses power, and therefore firmware)? Their report shows them
>>> running 4.15, which had this commit:
>>>
>>> fd865802c66b Bluetooth: btusb: fix QCA Rome suspend/resume
>>>
>>> which is admittedly completely broken. It breaks even perfectly working
>>> BT/USB devices, like mine. That's where I first complained, and we got
>>> this into 4.16-rc1:
>>>
>>> 7d06d5895c15 Revert "Bluetooth: btusb: fix QCA Rome suspend/resume"
>>>
>>> Isn't it possible your reporter has no further problem, and none if this
>>> is actually important to them? I'd just caution you to be careful before
>>> assuming you need to add blacklist info for their DMI...
>>
>> Thanks, that is a good question. His problems only started when I
>> enabled usb-autosuspend by default for btusb devices and he got things
>> working by adding "btusb.enable_autosuspend=n" on the kernel commandline,
>> so he was not hitting the firmware loading race introduced by
>> fd865802c66b and runtime suspend/resume is really broken for him.
> 
> Hmm? I'm not sure I completely follow here when you say "he was not
> hitting the firmware loading race". If things were functioning fine with
> system suspend (but not with autosuspend), then he's not seeing the
> controller (quoting commit fd865802c66b) "losing power during suspend".

He was running a kernel with the original "fd865802c66b Bluetooth: btusb:
fix QCA Rome suspend/resume" commit, which fixes regular suspend for
devices which are "losing power during suspend", but does nothing for
runtime-suspend.

He ran tests both with and without runtime-pm enabled with that same kernel
and he needed to disable runtime-pm to get working bluetooth.

> So, that would suggest he could only be seeing the race (as I was), and
> that his machine does not deserve a RESET_RESUME quirk?

I hope my above answer helps to clarify why I believe the quirk is
necessary on his machine.

Regards,

Hans


> 
> Or maybe I'm really misunderstanding.
> 
>>> As I read it, you need to investigate who are the "numerous reported
>>> instances" that generated commit fd865802c66b in the first place. That's
>>> where this mess started, IIUC. >
>>> But otherwise, yes, option 3 sounds OK. FWIW, my systems are ARM based
>>> and don't have DMI data, so option 2 wouldn't work.
>>
>> Right I think we all agree that the new plan now is to go back to
>> QCA behaving normally wrt (runtime) suspend/resume and then set the
>> USB-core RESET_RESUME quirk (which does not have the firmware
>> loading race) based on a DMI blacklist.
>>
>> I only have the one report for which I will write a patch implementing
>> this new policy soonish. And Kai-Heng Feng has another report which
>> might even be the machine. I certainly would not be surprised if it
>> is another Lenovo machine.
> 
> It seems like you folks moved forward on that one. Thanks.
> 
> Brian
> 
