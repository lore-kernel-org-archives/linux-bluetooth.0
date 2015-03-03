Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CB23EFA5-1D60-4658-BAAE-8C666AE22052@holtmann.org>
References: <CAD0=r8wZdzJBVq3f9j9iJJOZw2T0JwNiKxto13p9MSR7uL_Ziw@mail.gmail.com>
	<EE319A64-C3DB-49C5-A87A-BAF245159907@holtmann.org>
	<CAD0=r8w9MhKKm8isLY0+3SH0kxBd91z3HiOwpPp_j8fQFnirgw@mail.gmail.com>
	<CB23EFA5-1D60-4658-BAAE-8C666AE22052@holtmann.org>
Date: Mon, 2 Mar 2015 17:27:35 -0800
Message-ID: <CAD0=r8xKaDgru1-5TUfE0Fy=dngAt3c0JeL8w2tX_n9Mx6fr5g@mail.gmail.com>
Subject: Re: Why is interleaved scan interleaved ? Can I fix that to do LE and
 classic at same time ?
From: Jakub Pawlowski <jpawlowski@google.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, Mar 2, 2015 at 4:25 PM, Marcel Holtmann <marcel@holtmann.org> wrote=
:
> Hi Jakub,
>
>>>> When I do interleaved scan on linux, it's doing LE first, for around
>>>> 10 seconds, and then Classic scan for another few seconds on kernel
>>>> level.
>>>>
>>>> I was playing with Bluetooth on macbook, and noticed that they do both
>>>> LE and Classic scan at once. So I tried modifying kernel, I triggered
>>>> both LE and classic scan at once by queuing both
>>>> HCI_OP_LE_SET_SCAN_ENABLE, and HCI_OP_INQUIRY and it just worked, both
>>>> LE and Classic devices were reported.
>>>>
>>>> I tested that with CSR, Broadcom and Atheros chips, and all behaved we=
ll.
>>>>
>>>> Is there any reason why we do interleave instead of both scans at once=
 ?
>>>
>>> actually there are chips that do not support BR/EDR inquiry and LE scan=
 at the same time. So for some chips we need this behavior. I think that al=
l chips in platforms running Windows 8 will actually support simultaneous B=
R/EDR inquiry and LE scan since Microsoft mandated it. However in the embed=
ded SoC world that might not be true actually.
>>>
>>> And in the early days of LE, there was almost no chip that was able to =
handle BR/EDR inquiry and LE scan at the same time. That is why the interle=
aved behavior exists in the first place.
>>>
>>>> I would be more than happy to modify 'interleaved' behaviour, to do
>>>> both LE and classic scan at same time.
>>>
>>> Introduce HCI_QUIRK_SIMULTAENOUS_DISCOVERY and allow for well know good=
 behaving controller to set it. That way we can slowly move into that direc=
tion and keep interleaved behavior as a fallback.
>>>
>>> Regards
>>>
>>> Marcel
>>>
>>
>> So I send my patches previous week, and I just uploaded new version.
>> The old version was just starting both scans at once. It was working
>> on Atheros, CSR, and Broadcom, but then I find out it doesn't work on
>> Intel controllers.
>
> I know for certain that there are some older Atheros controllers that did=
 not support simultaneous service discovery. And I think certain Qualcomm h=
ardware doesn't do either. That might be all fixed now and it might be supp=
orted starting certain controller or firmware version, but that is somethin=
g that should come from the vendor in the end.
>
>> The reason for that was LE scan window equal to LE scan interval. When
>> I doubled Scan Interval, Intel devices started working. Apparently
>> other controllers don't really care.
>
> Can you be more specific which Intel controllers. We have more than one a=
nd also different firmware patches for them. We might need to test this a b=
it more.
>

One was Intel Wilkins Peak 2, I'm not sure about the other, they said
hello in dmesg like this:

[ 1.373161] Bluetooth: hci0: read Intel version: 3707100180012d0d0d
[ 1.373170] Bluetooth: hci0: Intel device is already patched. patch num: 0d

and

[ 9.521272] Bluetooth: hci0: read Intel version: 370710018002030d00
[ 9.554952] Bluetooth: hci0: Intel Bluetooth firmware file:
intel/ibt-hw-37.7.10-fw-1.80.2.3.d.bseq
[ 9.735771] Bluetooth: hci0: Intel Bluetooth firmware patch completed
and activated

However those are built-in into chromebooks, and the patch file in
/lib/firmware/intel/ibt-hw-37.7.10-fw-1.80.2.3.d.bseq  have different
size than in i.e. Ubuntu distribution, so there might be somenthing
specially for chromebooks.

>> So now it works on all controllers I have tested with.
>>
>> I have however question about Broadcom:
>> Simultaenous scan work, when there is firmware patch in /lib/firmware
>> (ubuntu have it). If the patch is not present it's not working. Can I
>> somehow make this kind of check in btusb.c to set the quirk ?
>
> You can set this quirk from within hdev->setup(). However this is dangero=
us if it is a maybe thing. In these cases it might be better to keep off. O=
r actually tie it to firmware build numbers that have been tested to work. =
You can get the firmware build numbers from the HCI revision information. T=
hat it works on one Broadcom controllers does not mean it works on all of t=
hem.
>
>> I also have question about scan window and interval: right now I just
>> doubled scan interval. This gives more than 12ms of free time that
>> BR/EDR scan would use to do inquiry. I fund in spec (Version 4.2 [Vol
>> 2, Part E] 6.2 and 6.3) that default Inquiry_Scan_Window is 11.25ms,
>> so this should work good. Do you have any suggestions to tune those
>> parameters in other way ?
>
> Actually inside the kernel we can not just pick new values. They are driv=
en by the Set Scan Parameters management command. So we need to obey to wha=
t userspace gave us.

No, the interval value used during discovery is hard coded here:

http://git.kernel.org/cgit/linux/kernel/git/bluetooth/bluetooth-next.git/tr=
ee/include/net/bluetooth/hci_core.h#n1286

and used here:

http://git.kernel.org/cgit/linux/kernel/git/bluetooth/bluetooth-next.git/tr=
ee/net/bluetooth/mgmt.c#n3862

So it looks like values set by Set Scan Parameters are not used, and
we have to pick new ones. Or is that a bug ?

I will fix the patches that set the quirk for particular controllers.
But patches no 1 and 2 are still good, can you please take a look at
them ?

>
> Regards
>
> Marcel
>
