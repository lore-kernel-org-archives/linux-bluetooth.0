Return-Path: <cyrus@holtmann.org>
Subject: RE: Does anyone know how to change the a2dp audio output stream
 between Speaker and bluetooth stereo headset?
From: Marcel Holtmann <marcel@holtmann.org>
To: Chan-Yeol Park <chanyeol.park@samsung.com>
Cc: linux-bluetooth@vger.kernel.org,
	=?UTF-8?Q?=27=EB=B0=95=EC=88=98=EC=A7=84/S/W?= Platform
	 =?UTF-8?Q?Lab=2E=28=ED=86=B5=EC=8B=A0=EC=97=B0=29/E5=28=EC=B1=85?=
	 =?UTF-8?Q?=EC=9E=84=29/=EC=82=BC=EC=84=B1=EC=A0=84=EC=9E=90=27?=
	<cooliceman@samsung.com>
In-Reply-To: <003a01c964f6$a8df7900$fa9e6b00$%park@samsung.com>
References: <003301c964ee$78dd8fb0$6a98af10$%park@samsung.com>
	 <1230032972.8047.35.camel@californication>
	 <003a01c964f6$a8df7900$fa9e6b00$%park@samsung.com>
Content-Type: text/plain
Date: Wed, 24 Dec 2008 00:06:24 +0100
Message-Id: <1230073584.4954.9.camel@californication>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

> Somebody said that Pulse audio needs a lot of resource.
> ( I don't know well pulse audio.. but in case of me I should check the performance )

I don't know how much resources PulseAudio actually consumes and you
better ask the Pulse guys directly.

> Do you think that this matter is solved only by pulse audio or like that..?

The BlueZ implementation for A2DP is not responsible for mixing or
anything else. It is just an audio transport. It is like _one_ audio
card with hotplug. Every mixing or stream switching must be done by the
audio system itself.

Regards

Marcel


