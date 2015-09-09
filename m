Return-Path: <cyrus@holtmann.org>
From: "Zheng, Wu" <wu.zheng@intel.com>
To: Marcel Holtmann <marcel@holtmann.org>
CC: "'linux-bluetooth@vger.kernel.org'" <linux-bluetooth@vger.kernel.org>
Subject: RE: "SMP security requested but not available" when BT_6lowpan
 connection
Date: Wed, 9 Sep 2015 06:46:27 +0000
Message-ID: <2CF57A644018A745B8FE029C7223E16E11A9522C@SHSMSX104.ccr.corp.intel.com>
References: <2CF57A644018A745B8FE029C7223E16E11A91C41@SHSMSX104.ccr.corp.intel.com>
 <8D7E2DC8-B9FE-45CD-A873-CC20DAE9769C@holtmann.org>
In-Reply-To: <8D7E2DC8-B9FE-45CD-A873-CC20DAE9769C@holtmann.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

I will try it. Thanks.

Best Regards
Zheng Wu

-----Original Message-----
From: Marcel Holtmann [mailto:marcel@holtmann.org]=20
Sent: Wednesday, September 9, 2015 1:59 PM
To: Zheng, Wu
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: "SMP security requested but not available" when BT_6lowpan con=
nection

Hi Wu,

> When I use kernel 4.1.6 to test BT 6lowpan, the error of "SMP security re=
quested but not available" is shown.
>=20
> 1. I use bluetoothctl power on
>=20
> 2. echo 1 > 6lowpan_enable
>=20
> 3. echo "connect 00:XX:XX:XX:XX:XX:XX 1" > 6lowpan_control.
>=20
> Then "SMP security requested but not available".
>=20
> I test kernel 4.1.3 and BT 6lowpan works well.
>=20
> Any suggestion? Thanks.

can try to boot a bluetooth-next kernel and see if the error is still prese=
nt. We included a fix for the warning.

Regards

Marcel
