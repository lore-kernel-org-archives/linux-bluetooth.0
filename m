Return-Path: <ryanphilips19@googlemail.com>
MIME-Version: 1.0
In-Reply-To: <D33F5F42-68EC-4DCA-B4DB-E2A9F482629E@holtmann.org>
References: <CANMsd02AgbF75N9tHckym-vBWP5daFqVd363yaFRZM84vX4gQQ@mail.gmail.com>
 <69551ED2-6F91-4011-9F78-9AB21C27F596@holtmann.org> <CANMsd01O4s=g-B3i+Z-w4LY52CzfOKhGPhfHxD29sVn0JR245A@mail.gmail.com>
 <D33F5F42-68EC-4DCA-B4DB-E2A9F482629E@holtmann.org>
From: Ryan <ryanphilips19@googlemail.com>
Date: Tue, 9 Aug 2016 18:12:52 +0530
Message-ID: <CANMsd03gwuttLRzDdXf1sEmUHJ=jJvGNtLt3yD2dFsLtD2ajEw@mail.gmail.com>
Subject: Re: btbcm issue
To: Marcel Holtmann <marcel@holtmann.org>
Cc: "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

Is this what you are referring to?

http://www.spinics.net/lists/linux-bluetooth/msg61742.html

In this patchset, bcm tried to create new functionality/files for uart and =
bcm.

If not, can you point me to the right set of patches?

Regards,
ryan

On Tue, Aug 9, 2016 at 1:07 PM, Marcel Holtmann <marcel@holtmann.org> wrote=
:
> Hi Ryan,
>
>> I wanted to check whats the best way of going about adding
>> suspend-resume support for bcm bt chip
>>
>> Should one have a separate driver
>> (https://android.googlesource.com/kernel/bcm/+/3d6d35972004824a9111f1392=
6bed2a4a495b668/drivers/misc/bcm-bt-lpm.c)
>>
>> or should i use the existing hci_bcm.c driver & add dt support or use
>> a platform device to pass the gpiod_desc for wakeup/sleep?
>
> no separate driver please. As soon as btattach links the UART and we enab=
le the device, everything should be done in background by the driver. The B=
roadcom LPM driver is just a hack for Android since they still haven't swit=
ched to using HCI User Channel for Android (like Intel for example).
>
> In general DT and ACPI are the same. They describe the hardware and there=
 are methods to read these descriptions from them and then use them. The on=
ly problem with DT was that Broadcom never got the definition acked by the =
DT maintainer. Otherwise all the functionality should be already in hci_bcm=
.c right now.
>
> Regards
>
> Marcel
>
