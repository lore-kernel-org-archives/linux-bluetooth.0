Return-Path: <hadess@hadess.net>
Message-ID: <1509632265.2869.65.camel@hadess.net>
Subject: Re: Enabling autosuspend for btusb by default
From: Bastien Nocera <hadess@hadess.net>
To: Hans de Goede <hdegoede@redhat.com>, Marcel Holtmann
 <marcel@holtmann.org>,  Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Thu, 02 Nov 2017 15:17:45 +0100
In-Reply-To: <9629d543-a8e2-27d2-21e5-7f6a21395e3c@redhat.com>
References: <9629d543-a8e2-27d2-21e5-7f6a21395e3c@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, 2017-11-01 at 15:31 +0100, Hans de Goede wrote:
> <resend with a bunch of To and Cc address added, sorry?
> 
> Hi All,
> 
> I'm working on trying to improve the OOTB power-consumption
> of Linux (Fedora Workstation) on laptops.
> 
> One of the easy wins here is enabling runtime-pm / autosuspend
> for btusb, since on many laptops the USB bluetooth device is
> the only USB device not using autosuspend, enabling this will
> not only allow suspending the USB bluetooth device but also to
> USB HCI, leading to a significant saving in power consumption
> of aprox. 0.4W.
> 
> So I would like to look into enabling runtime-pm / autosuspend
> for btusb by default.
> 
> Question, are there any known issues with enabling runtime-pm ?
> 
> I realize that simply enabling it for all btusb devices is a bit
> of a big hammer and might be a bad idea since there will probably
> be some devices out there which do not support this properly.
> 
> I was thinking that instead of enabling runtime-pm for all btusb
> devices, maybe this is something which we can do a vendor-id
> basis, starting with Intel and Broadcom devices ?

(Removed Gustavo from the CC:)

Is there any benefit doing this in the kernel rather than in user-
space?

Do you have a set test procedure that would allow checking whether the
device remains working?

I could see having this as a user-space toggle being useful if we ever
want to disable the runtime PM/autosuspend so Bluetooth keyboards can
wake up desktop machines from sleep. It's a long-standing RFE, which we
still haven't handled.

Cheers
