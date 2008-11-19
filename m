Return-Path: <cyrus@holtmann.org>
Message-ID: <4924548A.5020909@rjmx.net>
Date: Wed, 19 Nov 2008 13:01:46 -0500
From: Ron Murray <rjmx@rjmx.net>
MIME-Version: 1.0
To: marcel@holtmann.org, linux-bluetooth@vger.kernel.org
Subject: bcm203x bluetooth dongle still does not work in kernel 2.6.27.6
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi.

   I have a couple of boxes that I'm using with (admittedly fairly old)
Tecon bluetooth devices using the BCM-2033 chipset, and I've been having
trouble with them since you switched to the workqueue. For quite some
time I applied the patch referred to in the message below, and that
worked, but it wouldn't apply on kernel 2.6.27. Rather than fix it, I
decided to try the kernel driver as-is, with patchy results. Sometimes
it works, sometimes it doesn't. The symptoms are the same as below: my
syslog says

Nov 19 12:38:45 rjmx kernel: firmware: requesting BCM2033-MD.hex
Nov 19 12:38:45 rjmx kernel: firmware: requesting BCM2033-FW.bin

   but nothing seems to happen: an 'lsusb' still gives

Bus 001 Device 004: ID 0a5c:2033 Broadcom Corp. BCM2033 Bluetooth

   ... which is the wrong ID for a device that's had its firmware
properly loaded. The firmware files themselves seem to be readable, and
in fact an 'ls -lut' gives me a "last access time" similar to the actual
time I tried plugging in the device.

   Any suggestions?

Thanks,

 .....Ron Murray

> Subject	Re: [2.6.24] bcm203x bluetooth dongle does not work
> From	Marcel Holtmann <>
> Date	Wed, 30 Jan 2008 18:33:52 +0100
> 
> Hi Florian,
> 
>> after trying around with my ancient bcm2033 bluetooth dongle i found it
>> not working in 2.6.24 - I debugged udev and found it loading the
>> firmware correctly but the device seems to have problems disconnecting.
>> 
>> I found an Ubuntu bug which mentions a patch which supposed to be
>> 2.6.20 material. It still applies and fixes my problem:
>> 
>> Ubuntu Bug:
>> 	https://bugs.launchpad.net/ubuntu/+source/linux-source-2.6.20/+bug/85247
>> 
>> Patch:
>> 	http://launchpadlibrarian.net/7058766/bcm203x-2.6.20-backport.diff
>> 
>> So it seems this patch never went in but most likely should.
> 
> we moved away from using a timer and using a workqueue now. It wrote the
> patch to use a workqueue and tested that it works. Starting with 2.6.19
> we the usage of a workqueue is default. Can you verify that non of the
> kernels 2.6.19-2.6.23 are working. We might have missed a change inside
> the USB subsystem within the 2.6.24 timeframe.
> 
> Regards
> 
> Marcel


-- 
Ron Murray   (rjmx@rjmx.net)
http://www.rjmx.net/~ron
GPG Public Key Fingerprint:
  F2C1 FC47 5EF7 0317 133C  D66B 8ADA A3C4 D86C 74DE

Save energy: Drive a smaller shell.
