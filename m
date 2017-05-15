Return-Path: <christopher.spinrath@rwth-aachen.de>
From: Christopher Spinrath <christopher.spinrath@rwth-aachen.de>
Subject: [RFC] btmrvl-sdio: FW failed to be active in time!
To: Marcel Holtmann <marcel@holtmann.org>, Gustavo Padovan
	<gustavo@padovan.org>, Johan Hedberg <johan.hedberg@gmail.com>
CC: <linux-bluetooth@vger.kernel.org>, <christopher.spinrath@rwth-aachen.de>,
	Uli Middelberg <uli@middelberg.de>
Date: Mon, 15 May 2017 22:00:18 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Message-ID: <f6a3862d156d4552b2c2a32769909ba3@rwthex-s1-b.rwth-ad.de>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi all,

I'm trying to get the on-board wifi/bt chip on my Utilite Pro (an ARM 
imx6q based device) working. It is an AW-NH387 chip which is based on 
Marvell's SD8787 chipset.

Unfortunately, the btmrvl{,-sdio} fails to probe with the following error:

	Bluetooth: FW failed to be active in time!
	Bluetooth: Downloading firmware failed!

The vendor kernel comes with a workaround which also works with recent 
mainline kernels (e.g. v4.12-rc1): It removes the SD8787 Bluetooth AMP 
device from the btmrvl_sdio_ids array in btmrvl_sdio.c (see below for a 
diff against v4.12-rc1). Note that only the AMP device is removed -- the 
plain SD8787 Bluetooth device entry is still there.

This coincides with the fact that the latest firmware for the sd8787 in 
linux-firmware does not support the Bluetooth AMP device [1]. So my 
guess is that the firmware gets messed up when probing for the 
unsupported AMP device.

Now to my actual question: how do I get this properly supported upstream?

I don't see how I could prevent Linux from probing the AMP device 
depending on the firmware version or some other condition (i.e. a module 
parameter). And removing the device entry from the btmrvl_sdio_ids array 
feels wrong because it is actually correct -- the device is on the sdio bus.

Any help would be very much appreciated!

Cheers,
Christopher

P.S.: I were also unable to find any other devicetree based board in the 
upstream tree that uses the sd8787 over sdio, although there is e.g. a 
dedicated sd8787 mmc-pwrseq driver...

[1] 
https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/commit/mrvl/sd8787_uapsta.bin?id=690541ee758104fc0e7f4c17af962fa669be1524

---

diff --git a/drivers/bluetooth/btmrvl_sdio.c 
b/drivers/bluetooth/btmrvl_sdio.c
index eb794f0..0635a3d 100644
--- a/drivers/bluetooth/btmrvl_sdio.c
+++ b/drivers/bluetooth/btmrvl_sdio.c
@@ -295,9 +295,11 @@ static const struct sdio_device_id 
btmrvl_sdio_ids[] = {
	/* Marvell SD8787 Bluetooth device */
	{ SDIO_DEVICE(SDIO_VENDOR_ID_MARVELL, 0x911A),
			.driver_data = (unsigned long)&btmrvl_sdio_sd8787 },
+#if 0
	/* Marvell SD8787 Bluetooth AMP device */
	{ SDIO_DEVICE(SDIO_VENDOR_ID_MARVELL, 0x911B),
			.driver_data = (unsigned long)&btmrvl_sdio_sd8787 },
+#endif
	/* Marvell SD8797 Bluetooth device */
	{ SDIO_DEVICE(SDIO_VENDOR_ID_MARVELL, 0x912A),
			.driver_data = (unsigned long)&btmrvl_sdio_sd8797 },
