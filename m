Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Subject: Re: [RFC] btmrvl-sdio: FW failed to be active in time!
To: Marcel Holtmann <marcel@holtmann.org>
CC: "Gustavo F. Padovan" <gustavo@padovan.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
        Uli Middelberg <uli@middelberg.de>,
        <christopher.spinrath@rwth-aachen.de>
References: <f6a3862d156d4552b2c2a32769909ba3@rwthex-s1-b.rwth-ad.de>
 <c25b677f2c5b434eba9cf59bf4592eb6@rwthex-s1-a.rwth-ad.de>
From: Christopher Spinrath <christopher.spinrath@rwth-aachen.de>
Date: Thu, 18 May 2017 21:08:17 +0200
MIME-Version: 1.0
In-Reply-To: <c25b677f2c5b434eba9cf59bf4592eb6@rwthex-s1-a.rwth-ad.de>
Content-Type: multipart/mixed;
        boundary="------------8847DA5A7F844094642FA62C"
Message-ID: <8d22d5206a3341b7b067140f7ff8e88d@rwthex-s1-b.rwth-ad.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

--------------8847DA5A7F844094642FA62C
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit

Hi Marcel,

On 05/18/2017 04:52 PM, Marcel Holtmann wrote:
> Hi Christopher,
> 
>> I'm trying to get the on-board wifi/bt chip on my Utilite Pro (an ARM imx6q based device) working. It is an AW-NH387 chip which is based on Marvell's SD8787 chipset.
>>
>> Unfortunately, the btmrvl{,-sdio} fails to probe with the following error:
>>
>> 	Bluetooth: FW failed to be active in time!
>> 	Bluetooth: Downloading firmware failed!
>>
>> The vendor kernel comes with a workaround which also works with recent mainline kernels (e.g. v4.12-rc1): It removes the SD8787 Bluetooth AMP device from the btmrvl_sdio_ids array in btmrvl_sdio.c (see below for a diff against v4.12-rc1). Note that only the AMP device is removed -- the plain SD8787 Bluetooth device entry is still there.
>>
>> This coincides with the fact that the latest firmware for the sd8787 in linux-firmware does not support the Bluetooth AMP device [1]. So my guess is that the firmware gets messed up when probing for the unsupported AMP device.
>>
>> Now to my actual question: how do I get this properly supported upstream?
>>
>> I don't see how I could prevent Linux from probing the AMP device depending on the firmware version or some other condition (i.e. a module parameter). And removing the device entry from the btmrvl_sdio_ids array feels wrong because it is actually correct -- the device is on the sdio bus.
>>
>> Any help would be very much appreciated!
>>
>> Cheers,
>> Christopher
>>
>> P.S.: I were also unable to find any other devicetree based board in the upstream tree that uses the sd8787 over sdio, although there is e.g. a dedicated sd8787 mmc-pwrseq driver...
>>
>> [1] https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/commit/mrvl/sd8787_uapsta.bin?id=690541ee758104fc0e7f4c17af962fa669be1524
>>
>> ---
>>
>> diff --git a/drivers/bluetooth/btmrvl_sdio.c b/drivers/bluetooth/btmrvl_sdio.c
>> index eb794f0..0635a3d 100644
>> --- a/drivers/bluetooth/btmrvl_sdio.c
>> +++ b/drivers/bluetooth/btmrvl_sdio.c
>> @@ -295,9 +295,11 @@ static const struct sdio_device_id btmrvl_sdio_ids[] = {
>> 	/* Marvell SD8787 Bluetooth device */
>> 	{ SDIO_DEVICE(SDIO_VENDOR_ID_MARVELL, 0x911A),
>> 			.driver_data = (unsigned long)&btmrvl_sdio_sd8787 },
>> +#if 0
>> 	/* Marvell SD8787 Bluetooth AMP device */
>> 	{ SDIO_DEVICE(SDIO_VENDOR_ID_MARVELL, 0x911B),
>> 			.driver_data = (unsigned long)&btmrvl_sdio_sd8787 },
>> +#endif
>> 	/* Marvell SD8797 Bluetooth device */
>> 	{ SDIO_DEVICE(SDIO_VENDOR_ID_MARVELL, 0x912A),
>> 			.driver_data = (unsigned long)&btmrvl_sdio_sd8797 },
> 
> fundamentally Marvell has to tell us how to probe this SDIO function and not crashing. If they expose the SDIO function, we should be able to probe it and check support for it.

Yes, that would be optimal. But I don't have a support contract with 
them, so, unfortunately, they don't "have to"...

> Also any chance you can run btmon -w trace.log and then load the kernel module. Maybe it is something in the HCI init phase that we could work out.

Sure. I appended the trace.log but I doubt it will be useful. The 
corresponding dmesg entries are:

[   60.226519] Bluetooth: Core ver 2.22
[   60.230280] NET: Registered protocol family 31
[   60.234887] Bluetooth: HCI device and connection manager initialized
[   60.241312] Bluetooth: HCI socket layer initialized
[   60.246273] Bluetooth: L2CAP socket layer initialized
[   60.251430] Bluetooth: SCO socket layer initialized
[   76.285858] Bluetooth: vendor=0x2df, device=0x911a, class=255, fn=2
[   76.296607] sdio platform data not available
[   76.303925] Bluetooth: vendor=0x2df, device=0x911b, class=255, fn=3
[  196.434318] Bluetooth: FW failed to be active in time!
[  196.439520] Bluetooth: Downloading firmware failed!

Note that the firmware has already been downloaded by the mwifiex driver 
at this point and is running fine -- the wifi part still works (it does 
not work if btmrvl "wins the race" and has to download the firmware).

I would be happy to provide more debug outputs/test more stuff if it 
helps to find the underlying problem but be aware that I have no clue 
about the bluetooth and mmc subsystems.

Say we cannot find or fix the problem itself, is there any chance to 
work around it with a kernel parameter (deactivating the AMP device) or 
something like that?

Thanks,
Christopher

> Regards
> 
> Marcel
> 

--------------8847DA5A7F844094642FA62C
Content-Type: text/x-log; name="trace.log"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="trace.log"

YnRzbm9vcAAAAAABAAAH0QAAACgAAAAo//8ADAAAAAAA4i2DQ3WvZkxpbnV4IHZlcnNpb24g
NC4xMi4wLXJjMS1BUkNIKyAoYXJtdjdsKQAAAAAhAAAAIf//AAwAAAAAAOItg0N1r3VCbHVl
dG9vdGggc3Vic3lzdGVtIHZlcnNpb24gMi4yMgAAAAAeAAAAHv//AA4AAAAAAOItg0N1sAMB
AAAAAgABDgABAAAAEGJ0bW9uAAAAAAAAAAAAAAAAAAAQAAAAEAAAAAAAAAAAAOItg0RqbLcA
BgAAAAAAAGhjaTAAAAAAAAAAAAAAAAAAAAAIAAAAAADiLYNEam7aAAAAAwAAAAMAAAACAAAA
AADiLYNEavKIAwwAAAAAAAAAAAAAAAAJAAAAAADiLYNFC88C
--------------8847DA5A7F844094642FA62C--
