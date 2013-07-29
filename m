Return-Path: <cyrus@holtmann.org>
From: Bing Zhao <bzhao@marvell.com>
To: Marcel Holtmann <marcel@holtmann.org>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Gustavo Padovan <gustavo@padovan.org>, Johan Hedberg
	<johan.hedberg@gmail.com>, "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>, Amitkumar Karwar <akarwar@marvell.com>
Date: Mon, 29 Jul 2013 14:28:01 -0700
Subject: RE: [PATCH] Bluetooth: btmrvl: add calibration data download support
Message-ID: <477F20668A386D41ADCC57781B1F70430EA3215F2E@SC-VEXCH1.marvell.com>
References: <1375126147-28642-1-git-send-email-bzhao@marvell.com>
 <39BF90E7-8341-412E-A372-6039B703980D@holtmann.org>
In-Reply-To: <39BF90E7-8341-412E-A372-6039B703980D@holtmann.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

Thanks for your comments.

> Hi Bing,
>=20
> > A text file containing calibration data in hex format can
> > be provided while loading btmrvl module. The data will be
> > downloaded to firmware.
> > eg. insmod btmrvl.ko cal_data_cfg=3Dmrvl/bt_cal_data.conf
>=20
> why is this a module parameter and you do not just request a standard loc=
ation via request_firmware().

Not all devices need downloading the calibration data from host to firmware=
.
A module parameter seems more flexible than others.

The firmware_request() requires a relative file path under /lib/firmware/.
What is the standard location you are referring to?

> I do not like the module parameter approach.

I'm open to any other approaches. Do you have any suggestions?

Thanks,
Bing

>=20
> Regards
>=20
> Marcel
