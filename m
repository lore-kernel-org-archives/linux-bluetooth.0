Return-Path: <cyrus@holtmann.org>
From: Mike Tsai <Mike.Tsai@Atheros.com>
To: nirav rabara <niravrabara@gmail.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Wed, 10 Mar 2010 13:40:33 -0800
Subject: RE: Bluetooth Dongle version mismatch Confusion
Message-ID: <35B17FE5076C7040809188FBE7913F983A1CC4443E@SC1EXMB-MBCL.global.atheros.com>
References: <912bb79a1003100144g7d14c3daj9560dc0ae0dc8e31@mail.gmail.com>
In-Reply-To: <912bb79a1003100144g7d14c3daj9560dc0ae0dc8e31@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Nirav,

	2.1 HS shall be able to operate with 2.0 dongle and vise versa. The major difference between 2.0 and 2.1 devices is the pairing method.

	I think the issue most likely is due to the compatibility between different vendors, not the version miss match issue.

	BTW, do you know what are the SCO parameters negotiated? Also, is sniff running at the same time?

Thanks,

Mike
 	

-----Original Message-----
From: linux-bluetooth-owner@vger.kernel.org [mailto:linux-bluetooth-owner@vger.kernel.org] On Behalf Of nirav rabara
Sent: Wednesday, March 10, 2010 1:44 AM
To: linux-bluetooth@vger.kernel.org
Subject: Bluetooth Dongle version mismatch Confusion

Hi,

I have been using bluez 4.58 with 2.6.30 on ARM platform , I am newbie
and found problem with Headset & Dongle version mismatch.

I can use v2.0 Dongle with v2.0 Headset & v2.1 Dongle with v2.1
Headset.( result is good I can hear voice on HS)

But if I use v2.0 Dongle with v2.1 HS & v2.1 Dongle with v2.0 HS
result is unpredictable some time noise or No voice).

I am doing anything wrong with SCO implementation? OR Bluetooth have
limitation with version mismatch. OR I must use same version Dongle &
HS(why ?).

Thanks in Advance


--
With Regards,
Nirav Rabara
--
To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
