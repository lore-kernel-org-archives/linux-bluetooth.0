Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Subject: Re: Enabling autosuspend for btusb by default
To: Bastien Nocera <hadess@hadess.net>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
References: <9629d543-a8e2-27d2-21e5-7f6a21395e3c@redhat.com>
 <1509632265.2869.65.camel@hadess.net>
From: Hans de Goede <hdegoede@redhat.com>
Message-ID: <2314d6fb-2291-64ca-f06d-70658d73a19c@redhat.com>
Date: Thu, 2 Nov 2017 16:12:32 +0100
MIME-Version: 1.0
In-Reply-To: <1509632265.2869.65.camel@hadess.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On 02-11-17 15:17, Bastien Nocera wrote:
> On Wed, 2017-11-01 at 15:31 +0100, Hans de Goede wrote:
>> <resend with a bunch of To and Cc address added, sorry?
>>
>> Hi All,
>>
>> I'm working on trying to improve the OOTB power-consumption
>> of Linux (Fedora Workstation) on laptops.
>>
>> One of the easy wins here is enabling runtime-pm / autosuspend
>> for btusb, since on many laptops the USB bluetooth device is
>> the only USB device not using autosuspend, enabling this will
>> not only allow suspending the USB bluetooth device but also to
>> USB HCI, leading to a significant saving in power consumption
>> of aprox. 0.4W.
>>
>> So I would like to look into enabling runtime-pm / autosuspend
>> for btusb by default.
>>
>> Question, are there any known issues with enabling runtime-pm ?
>>
>> I realize that simply enabling it for all btusb devices is a bit
>> of a big hammer and might be a bad idea since there will probably
>> be some devices out there which do not support this properly.
>>
>> I was thinking that instead of enabling runtime-pm for all btusb
>> devices, maybe this is something which we can do a vendor-id
>> basis, starting with Intel and Broadcom devices ?
> 
> (Removed Gustavo from the CC:)
> 
> Is there any benefit doing this in the kernel rather than in user-
> space?

IMHO it is up to the kernel to set good defaults, so that people
don't need to use things like powertop --auto-tune or TLP, which
are userspace kludges which users currently revert to because of
the lack of good defaults in the kernel.

> Do you have a set test procedure that would allow checking whether the
> device remains working?

No not really I've tested that HID devices keep working, e.g. typing
something on a bt keyboard after the autosuspend timeout and that works
with Intel BT hosts at least. I've also ordered a BT headset to test
that.

> I could see having this as a user-space toggle being useful if we ever
> want to disable the runtime PM/autosuspend so Bluetooth keyboards can
> wake up desktop machines from sleep. It's a long-standing RFE, which we
> still haven't handled.

With USB remote-wakeup that should actually work, at least from a USB
pov. With regular USB keyboards wakeup works fine independent of
their /sys/bus/usb/devices/x-y/power/control setting being "on" or "auto",
at least on devices where wakeup works with the "on" state which is
not always the case AFAIK.

Besides that userspace can always override the default set by the driver
by writing "on" or "auto" to /sys/bus/usb/devices/x-y/power/control.

Regards,

Hans
