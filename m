Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=windows-1252
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Subject: Re: [PATCH] bluetoothd: add option to automatically power on the first adapter found
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <553DFD48.8010200@ahsoftware.de>
Date: Mon, 27 Apr 2015 11:53:37 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <83A0A25D-0162-4EF1-9736-3C3B2F22940B@holtmann.org>
References: <1428685062-2911-1-git-send-email-holler@ahsoftware.de> <97E0530A-49BA-4776-BF4E-DF500F28116E@holtmann.org> <55280525.7040902@ahsoftware.de> <55289DD3.1080509@ahsoftware.de> <5528AC01.80804@ahsoftware.de> <55295063.2010106@ahsoftware.de> <72FEAB70-4102-4048-94E0-4AA0B4D67217@holtmann.org> <552A397D.50709@ahsoftware.de> <273C2B2C-FE29-4E28-8B50-7A9BE82C098D@holtmann.org> <552B87EE.5040800@ahsoftware.de> <B8F6B143-DA86-4F06-B4C8-FA2790AA33B3@holtmann.org> <552C1413.1000504@ahsoftware.de> <A619270B-434E-4F83-A3A3-21E25C1DC237@holtmann.org> <552CD0F2.7080605@ahsoftware.de> <35E686A5-9C85-421D-BB8B-DF14F7D1A276@holtmann.org> <552EA70F.9050706@ahsoftware.de> <553B6BC5.4060407@ahsoftware.de> <BBD84100-9DE9-4A7A-8DA3-4DD8B3458F25@holtmann.org> <553DFD48.8010200@ahsoftware.de>
To: Alexander Holler <holler@ahsoftware.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Alexander,

>>>>> Your race power on vs keys and known devices programmed into the
>>>>> kernel. It needs to be done in the right order.
>>>> 
>>>> Hmm, I still seem to function, no sign of races, besides that I'm
>>>> happily working without a Linux kernel.
>>>> 
>>>> But in regard to the patch. Maybe. No idea. It works for me (tm) and is
>>>> faster and more reliable here than other stuff.
>>> 
>>> To pick up that thread again, if you want that I remove a race in that patch I don't see by looking at it, you have to be a bit more verbose about the race.
>> 
>> it is pretty simple, you want to configure the list of known devices and its keys before you turn on your device for general operation. If you don't do that, you have a race condition.
>> 
>>> For me it currently reads like you're more talking about an existing problem in the kernel. If the kernel doesn't like it that a bt-device will be turned on before something like keys and known devices have been setup, then the kernel should throw an error back to userspace.
>> 
>> The kernel is not enforcing policy. We can not require to have keys loaded first. There might be no keys or you want to use the Bluetooth subsystem for something else. The kernel mgmt interface provides a flexible way into the general procedures that Bluetooth requires. With bluetoothd we enforce profiles and other behaviors to be consistent. That is not the kernel's job.
>> 
>> And even if we wanted to restrict this heavily, we can not easily do that without potentially breaking existing userspace.
>> 
>>> But that's just an assumption from me, I haven't read through all the source in bluetoothd or the kernel, but instead just turned on a knob like it would be turned on by issuing "power on" in bluetoothctl.
>> 
>> With bluetoothctl you talk over the D-Bus interface to bluetoothd. So when you turn power on there, then it is ensured that everything happens in the right order. That is what bluetoothd enforces. It is not the kernels job to do that.
> 
> For me this reads like kernel <-> userspace API is very fragile.
> 
> Also I haven't looked at the source for that, I would assume that it should be no problem to submit an empty list of keys and devices to the kernel. So a probably stable design of that part of the API would be:
> 
> - Require that userspace sets up various stuff
> - Require that userspace sends a list of keys (maybe empty)
> - Require that userspace sends a list of devices (maybe empty)
> - Turn on devices which are requested to be turned on and start operation.
> 
> I'm aware that this might involve problems with older userspace, but just trying to discuss a problem away (e.g. by murdering the messenger) is usually a bad solution.
> 
> Right now it looks like userspace can confuse the kernel quiet a lot which it should not be able to do.
> 
> For example you are calling it a race if my patch for bluetoothd is used. Which bad things might happen? Do I have to fear my machine blows up and will erase my storage? Or, as we are talking about wireless stuff, do I have to fear that security is absent and everyone might be able to connect to my machine?

the kernel is different from bluetoothd. You are changing code in bluetoothd and thus lets do it correctly. I really have no idea what you are arguing here for.

> Sorry that I don't understand your reasoning, but if I would translate that, it would mean the same like if it's a race to call unlink(2) on a non-existing file. Of course, it would be much easier for the kernel to not have to handle all the possible error conditions, but that's the dream of any sw-dev and will never become reality. Handling all the possible error conditions just has to be part of almost any sw, regardless if it's a kernel or not.
> 
> Anyway, to come back to the problem of easy and reliable turning on bt-devices at startup, I will look if I find the place in bluetoothd where the keys and devices are submitted to the kernel in order to put the requested power-on after that. But as I'm still happy with my current solution, I don't make any promises on a timeline. ;)

If you want the patch to get upstream, I clearly gave you instructions on what has to change to make it upstream acceptable. The work here is on you.

Regards

Marcel

