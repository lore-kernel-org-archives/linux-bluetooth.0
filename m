Return-Path: <cyrus@holtmann.org>
From: Bing Zhao <bzhao@marvell.com>
To: Marcel Holtmann <marcel@holtmann.org>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Gustavo Padovan <gustavo@padovan.org>, Johan Hedberg
	<johan.hedberg@gmail.com>, "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>, Amitkumar Karwar <akarwar@marvell.com>
Date: Mon, 29 Jul 2013 16:20:03 -0700
Subject: RE: [PATCH] Bluetooth: btmrvl: add calibration data download support
Message-ID: <477F20668A386D41ADCC57781B1F70430EA3215F9B@SC-VEXCH1.marvell.com>
References: <1375126147-28642-1-git-send-email-bzhao@marvell.com>
 <39BF90E7-8341-412E-A372-6039B703980D@holtmann.org>
 <477F20668A386D41ADCC57781B1F70430EA3215F2E@SC-VEXCH1.marvell.com>
 <791D5341-CA33-425C-BFB8-CB65F5451E39@holtmann.org>
In-Reply-To: <791D5341-CA33-425C-BFB8-CB65F5451E39@holtmann.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

> it is also way harder to use and things need to be manually configured. D=
on't know know when the
> device needs calibration information or not. And you can just request_fir=
mware() that file. If it is
> there, then load it, if not then skip the step.

Thanks for your suggestion. This approach should work for me.

>=20
> > The firmware_request() requires a relative file path under /lib/firmwar=
e/.
> > What is the standard location you are referring to?
>=20
> You have to create proper filenames for your hardware. Like mrvl/cal_data=
_v1.conf or similar.

Sure.

> As I said above, the device should know if it needs calibration or not. A=
nd just installing a file on
> disk is simpler than having to modify the module parameters somewhere.

This makes sense. I'll take your approach and re-spin the patch.

Thanks,
Bing
