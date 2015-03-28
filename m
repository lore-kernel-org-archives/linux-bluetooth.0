Return-Path: <cyrus@holtmann.org>
Message-ID: <55164DEC.6070009@gmail.com>
Date: Sat, 28 Mar 2015 07:45:00 +0100
From: Florian Grandel <fgrandel@gmail.com>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: linux-bluetooth@vger.kernel.org
Subject: Multi-Advertising: implementation options, timing questions
References: <5515ECE9.9080101@gmail.com> <0B4D986A-2913-46C0-8EB2-53EE29C67739@holtmann.org>
In-Reply-To: <0B4D986A-2913-46C0-8EB2-53EE29C67739@holtmann.org>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

On 03/28/2015 01:01 AM, Marcel Holtmann wrote:
> the kernel side has currently only support for 1 advertising
> instance. That needs to be fixed or you need to do the rotation in
> the HAL and fake it that way. Ideally you do that in the kernel since
> it has better control over the hardware than userspace ever will be.
> However it would work by faking it in the HAL.

If I'm not mistaken then bluez kernel drivers rely exclusively on 
standard HCI commands in communicating with bluetooth hardware.

Multi-advertising doesn't seem to be a standard HCI procedure, though. 
It rather seems to be a (broadcom?) vendor-specific addition we cannot 
rely on in general. I didn't find any good documentation on vendor 
specific HCI command sets either. Do you have something there?

Please correct me if I'm on the wrong track, but doesn't that mean that 
we have to emulate multi-advertising in any case, even if it was in the 
kernel?

As the new advertising mgmt api already has been designed with multiple 
advertising instances in mind it seems a natural choice to implement the 
multi-advertising emulation in the mgmt layer. But as I'm a complete 
bluetooth/bluez newbie, I might be completely mistaken here.

What I'm wondering about are the implementation options we have for the 
emulation, especially when it comes to timing. How would we schedule 
advertisement data updates wrt min/max advertising intervals?

If we maintain the current advertising instance data structure with 
separate advertising interval settings per instance then I'd expect 
advertisement events to interleave somehow like this:

advEvt1
|xxx|................|---|xxx|................|---|xxx|...
  advInt1            advDelay

         advEvt2
....|---|xxx|................|---|xxx|................|---
          advInt2

                advEvt3
............|---|xxx|....................................|---|xxx|..
                  advInt3

Advertisement intervals would have to be multiples of a common factor to 
avoid event collisions. And the interval would have to be long enough to 
fit all instances into one cycle.

Alternatively we could schedule adv evts with a common adv interval like 
this:

advEvt1                 advEvt2                  advEvt3
|xxx|................|---|xxx|................|---|xxx|...
        advInt      advDelay

I'd be in favor of the first solution which more closely emulates the 
existence of independent peripheral devices sharing a common physical 
adv channel.

(compare BT Core Spec 4.x, Vol 6, Part B, 4.4.2.2)

What I really wonder about, though, is how we'd be able to implement 
such a timing scheme with nothing but the standard HCI API. How quickly 
and reliably does the hardware respond to a large number of HCI calls as 
would be required here? Does it really make sense to implement such a 
low-level aspect of the protocol in the mgmt api code? What other 
options do we have? I'm probably making things too complicated...

Florian
