Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
From: Leif Liddy <leif.linux@gmail.com>
Date: Sat, 25 Feb 2017 04:48:45 +0100
Message-ID: <CAAbRKOupReCoUbrJA2_38aWGjZf+w4EZO6Lct8zHaGykkTLCqw@mail.gmail.com>
Subject: [Bug 193571] Request for assistance
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

https://bugzilla.kernel.org/show_bug.cgi?id=193571

I'd like to someone from the bluetooth community to just take a quick
at this bug report and help me identify the likely source of the issue.
btusb driver? usb subsystem?

The symptoms are --after I suspend my laptop (10 min or more) and then
resume, the bluetooth adaptor no longer functions. I have to reset the
bluetooth usb device to get it working again.

echo 0 > /sys/bus/usb/devices/1-4/authorized
echo 1 > /sys/bus/usb/devices/1-4/authorized

What's the likely cause of this? Is the bluetooth adaptor losing power
or it's firmware during a suspend cycle?

Looking at the btusb driver, I found this

---------------------------------------------------------------------
#ifdef CONFIG_BT_HCIBTUSB_RTL
if (id->driver_info & BTUSB_REALTEK) {
hdev->setup = btrtl_setup_realtek;


/* Realtek devices lose their updated firmware over suspend,
* but the USB hub doesn't notice any status change.
* Explicitly request a device reset on resume.
*/
set_bit(BTUSB_RESET_RESUME, &data->flags);
}
#endif
------------------------------------------------------------------------

I'm interested in trying this method for my bluetooth adaptor.
I'm not a kernel developer...but if someone could show me what changes need to
made to btusb driver so it would be work with my bluetooth adaptor (0cf3:e300)
I could compile the driver and test it out.


Thanks!

-Leif
