Return-Path: <cyrus@holtmann.org>
Message-ID: <55CA507F.9000205@gmail.com>
Date: Tue, 11 Aug 2015 22:43:59 +0300
From: Dmitry Tunin <hanipouspilot@gmail.com>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: "Gustavo F. Padovan" <gustavo@padovan.org>,
 Johan Hedberg <johan.hedberg@gmail.com>,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH] ath3k: Revert 7e730c7f3d1f39c25cf5f7cf70c0ff4c28d7bec7
References: <1439290229-6937-1-git-send-email-hanipouspilot@gmail.com> <96FCB7AC-6E4C-4ED1-8048-87843978A63B@holtmann.org>
In-Reply-To: <96FCB7AC-6E4C-4ED1-8048-87843978A63B@holtmann.org>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-bluetooth.vger.kernel.org>



11.08.2015 22:23, Marcel Holtmann пишет:
> Hi Dmitry,
> 
>> This patch causes infinite loop on loading firmware on Acer Aspire
>> V3è371-31KW and probably other laptops.
>>
>> This is a serious regression, because system becomes unresponsive.
>>
>> This should be reverted until the firmware loading issue is sorted out.
> 
> this needs a lot more explanation on why I am suppose to revert this now.
> 
> And now I am really reluctant to have any ath3k patches marked as stable. If things are not tested properly, then please refrain from adding stable tags since these are clearly more than just VID/PID additions.
> 
> Regards
> 
> Marcel
> 

Here is the explanation.

This is a report I got from a user. He tried to write you too, but did not get a response.

------------------------------quote-----------------------------

However, the same patch makes the same device enter a disconnect /
reconnect infinite loop in my specific laptop model (Acer Aspire
V3è371-31KW). The original poster of the duplicate, #1397885, also has
an Acer Aspire and might be affected by the same issue (not sure about
it). Sorry about commenting the duplicate if it was wrong.

On my laptop, the patch makes the firmware load into the device and it
begins an infinite disconnect/reconnect cycle. The boot makes ages,
lsusb freezes.

Under your kernel, the whole computer runs unstable. the login manager
and X won't always start, the system takes ages to start, lsusb feezes
and I get a log of the following with journalctl -xe.

  mai 02 19:21:00 white kernel: usb 1-5: new full-speed USB device
number 49 using xhci_hcd
mai 02 19:21:01 white kernel: usb 1-5: New USB device found,
idVendor=04ca, idProduct=300d
mai 02 19:21:01 white kernel: usb 1-5: New USB device strings: Mfr=0,
Product=0, SerialNumber=0
mai 02 19:21:01 white kernel: usb 1-5: USB disconnect, device number 49
mai 02 19:21:01 white kernel: usb 1-5: new full-speed USB device number
50 using xhci_hcd
mai 02 19:21:01 white kernel: usb 1-5: New USB device found,
idVendor=04ca, idProduct=300d
mai 02 19:21:01 white kernel: usb 1-5: New USB device strings: Mfr=0,
Product=0, SerialNumber=0
mai 02 19:21:01 white kernel: usb 1-5: USB disconnect, device number 50
mai 02 19:21:01 white kernel: usb 1-5: new full-speed USB device number
51 using xhci_hcd
mai 02 19:21:02 white kernel: usb 1-5: New USB device found,
idVendor=04ca, idProduct=300d
mai 02 19:21:02 white kernel: usb 1-5: New USB device strings: Mfr=0,
Product=0, SerialNumber=0
mai 02 19:21:02 white kernel: usb 1-5: USB disconnect, device number 51
mai 02 19:21:02 white kernel: usb 1-5: new full-speed USB device number
52 using xhci_hcd
mai 02 19:21:02 white kernel: usb 1-5: New USB device found,
idVendor=04ca, idProduct=300d
mai 02 19:21:02 white kernel: usb 1-5: New USB device strings: Mfr=0,
Product=0, SerialNumber=0
mai 02 19:21:02 white kernel: usb 1-5: USB disconnect, device number 52
mai 02 19:21:03 white kernel: usb 1-5: new full-speed USB device number
53 using xhci_hcd
mai 02 19:21:03 white kernel: usb 1-5: New USB device found,
idVendor=04ca, idProduct=300d
mai 02 19:21:03 white kernel: usb 1-5: New USB device strings: Mfr=0,
Product=0, SerialNumber=0
mai 02 19:21:03 white kernel: usb 1-5: USB disconnect, device number 53
mai 02 19:21:03 white kernel: usb 1-5: new full-speed USB device number
54 using xhci_hcd
mai 02 19:21:03 white kernel: usb 1-5: New USB device found,
idVendor=04ca, idProduct=300d
mai 02 19:21:03 white kernel: usb 1-5: New USB device strings: Mfr=0,
Product=0, SerialNumber=0"

I made a workaround which makes the device work by loading the patched
modules, unload them and load the unpatched ones. The firmware being
loaded, the unpatched modules are able to drive the device.

I sent a mail to the Bluetooth maintainer's mailing list last month, but
for some reasons, it might have been unnoticed, I didn't received any reply.

I'm concerned for unexperienced users of this computer getting trouble
with new kernels. If I can help, don't hesitate to ask me any
information about by laptop.

Cheers,
Raphaël.

----------------------end of quote----------------------------------

I told him to write directly to maintainers and it seem that he has done it.

Before I got responses that the patch worked well. I sent it to you when it was tested by two users.

This issue is really weird, because it appears only on some laptops.
Maybe it is related to the new Atheros firmware files, that can't be loaded properly in certain cases.

It's up to you to decide if marking for stable is appropriate, but before all AR devices ran smoothly and there seemed to be no 
reason not to add them for stable.

I suggest a compromise. Not to add those devices that require the new firmware, because its loading really is not tested well.
If some older devices are discovered, it is very unlikely that there may be any troubles.

I know that it is a pain in the ass to revert it from stable.

Another option is to leave it there, because probably if the firmware is not added, ath3k will just fail to find it and will not cause any trouble.
The new firmware has not been added to linux-firmware yet.

But in this case any time the regression may appear as soon as they add it there. It seems not to be a good idea either.

Regards,

Dmitry
