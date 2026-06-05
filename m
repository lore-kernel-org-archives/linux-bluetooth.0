Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77BF93F8229
	for <linux-bluetooth@vger.kernel.org>; Fri,  5 Jun 2026 09:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780651524; cv=none; b=ixP7HBFd/iiLDFuoDGrUM/xBpE8wAtlV/B3vwgxTupYK6T5+YWhxao+IQQGqfNHIc2OvcVl/3MMiOeCHqdwQwGzxUO4u8+3czG6d2vOeHQ6hOe6P/Lws6X33LSV8xaOROWNcNWL226idoXg9r++Nob6peKAte8EwCxjjaYRlTGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780651524; c=relaxed/simple;
	bh=a0ZXnG5o1upcZgu3wR6ZSkkAKFOJkbR/cWJkKmgoa7E=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=h62dS/TCp3qUGW4jGSA3hUBN6aocsi9Oj2ZrvxU26onil+dtXSiq0AofhNHy/9C/5Bh35ZvSVOkyJuZ/v/d3KzYQYP7IpFW+X3YYtZjCkunqbQL56G10vj/nLDMxABtq2Cuj+/sSzr1Avvvy2YNAr5WK4HBhJiD0xLhuNtst0Ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9D49A3EBFD;
	Fri,  5 Jun 2026 09:25:14 +0000 (UTC)
Message-ID: <94b26095b5963694f06364ebbf9e3d60888b086c.camel@hadess.net>
Subject: Re: Fwd: Correct contact people(s) and Linux branch for my HID
 driver?
From: Bastien Nocera <hadess@hadess.net>
To: Mikko Laanti <mikko.laanti@strokeplan.com>, 
	linux-bluetooth@vger.kernel.org
Date: Fri, 05 Jun 2026 11:25:14 +0200
In-Reply-To: <74db472595986d0dec795353ea5f1eed7a3bd8e2.camel@strokeplan.com>
References: <74db472595986d0dec795353ea5f1eed7a3bd8e2.camel@strokeplan.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-GND-Sasl: hadess@hadess.net
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: dmFkZTFMUORrbCGTH+b2nGp8EnNYn+OZnKVOIoF2UZk55IfkbmI9ZNsp/exL+o8Jmwdn95Q2wAuTcsHeycRuwbBK3sqwppyvV5bYZkuaTE7uhnFYKws4btn9QobKA3bM4kdQ3pdxKj7m/zbJnh4BrjqimUh1HwPUjPD+NlVbH4nhMMBoRRZCL7BxGb25KxSUOt/+7uVhOch1USQmz2KjUlNYp9d3YoeyP1Usf4ZD2QAI6gNAlXK7PTTzcLDPwvFGqK8RCD4xLvX8mLUs1Psogc/I6sgc+tRD7tx6x3S3679g8tAIv1XvxJyAM9Tu4Smz7gf4FJG9+MrVIhbSemoPuZEhGiDPDEWbsT0NSKzmHEMFzz2Whlu3jN/UH7urRXz/0NDAPpcwyGDjuDCo8TnFfbrPvCNxo0V8s+PFY8f22yo/aiFjUP1A7ahEpFCGJ8XLaD8c+1X1WsaNXNXACJolNMJ1fl/9mq2IywPKxog5G5eSnnd0je9tXFLFa6Qnu8uYM5CHnPo+NU0ma3K8bqJnkKTMFGFdpZ/EtADRnxCnt0dHkQzl3sMWqYEzEFSuLRgcpaJDEatDR5hzQVbTEqdgJZNXSFr1UW2roFRm7ag3sef3siXrWxSFb+XJp3hNyKj2AW4feOpalFU5HOk9/vNAnXeyvh/XbUDnaPxGyG9Jj984GpLEzw

Hello Mikko,

On Thu, 2026-05-28 at 21:38 +0300, Mikko Laanti wrote:
> Hi,
>=20
> I have witten following driver for bluetooth HID device iRig
> BlueTurn.
> To whom should I contact? If it is accepted, to what git Linux kernel
> branch should I it check-in?

The way to submit patches to the kernel is explained at:
https://www.kernel.org/doc/html/v7.0/process/submitting-patches.html

What you'll find, once you've put your patch in a commit, generated
that patch and ran the "scripts/get_maintainer.pl" is that all drivers
under drivers/hid get reviewed on the linux-input@ mailing-list.

You can find how to post to it at:
https://subspace.kernel.org/vger.kernel.org.html

Cheers

>=20
> Regards,
>=20
> Mikko Laanti
>=20
>=20
> // SPDX-License-Identifier: GPL-2.0+
> /*
> =C2=A0*=C2=A0 HID driver for IK Multimedia iRig BlueTurn devices
> =C2=A0*
> =C2=A0*=C2=A0 Copyright (c) 2026 Mikko Laanti <strokeplan@gmail.com>
> =C2=A0*/
>=20
> #include <linux/hid.h>
> #include <linux/module.h>
>=20
> #include "hid-ids.h"
>=20
> MODULE_AUTHOR("Mikko Laanti <strokeplan@gmail.com");
> MODULE_DESCRIPTION("iRig BlueTurn devices");
> MODULE_LICENSE("GPL");
>=20
> /* Changes in Makefile
> obj-$(CONFIG_HID_IRIG_BLUETURN)	+=3D hid-irig-blueturn.o
>=20
> =C2=A0* Changes in Kconfig
> config HID_IRIG_BLUETURN
> 	tristate "iRig BlueTurn devices"
> 	help
> 	Support for iRig BlueTurn devices, which are not fully
> compliant with the
> 	HID standard.
> 	hid-irig-blueturn
>=20
> 	To compile this driver as a module, choose M here: the
> module
> 	will be called hid-irig-blueturn.ko.
>=20
> =C2=A0* Changes in hid-ids.h
> #define USB_VENDOR_ID_IK_MULTIMEDIA	0x0214
> #define USB_VENDOR_ID_IK_MULTIMEDIA_IRIG_BLUETURN	0x0002
> */
>=20
> /*
> =C2=A0* The iRig BlueTurn (Page turner) foot controlled bluetooth keyboar=
d
> uses unnumbered keyboard messages
> =C2=A0* iRig BlueTurn can be configured to three possible configurations
> for
> its two buttons:
> =C2=A0*=C2=A0	1. ARROW_UP/ARROW_DOWN
> =C2=A0*	2. PAGE_UP/PAGE_DOWN
> =C2=A0*	3. ARROW_LEFT/ARROW_RIGHT
> =C2=A0* E.g. A compliant bluetooth keyboard sends Up Arrow:=C2=A0 01 00 0=
0 52
> 00
> 00 00 00 00 (first data byte means it is "numbered")
> =C2=A0*=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 IK multimedia iRig BlueTurn sends U=
p Arrow:=C2=A0=C2=A0=C2=A0=C2=A0 00 00 00 52
> 00
> 00 00 00
> =C2=A0* Without this driver and iRig BlueTurn connected, you'll get syste=
m
> log dmesg error:
> =C2=A0* "Event data for report 0 was too short (8 vs 7)"=C2=A0=C2=A0 (hid=
-core.c:
> hid_report_raw_event)
> =C2=A0*/
>=20
> static int irig_blueturn_raw_event(struct hid_device *hdev, struct
> hid_report *report,
> 	u8 *data, int size)
> {
> 	/* iRig Blueturn always sends unnumbered 8 bytes i.e. 64
> bits
> data reports.
> 	 * hid-core.c: hid_report_raw_event() decreases data size by
> one because keyboard messages should be numbered.
> 	 * We decrease report size here so that it will pass data
> size
> test in hid-core.c:hid_report_raw_event()
> 	 * Right way would be to adjust data so that it looks
> exactly
> like compliant keyboard, but we cannot set
> 	 * the size because it has been passed to this
> irig_blueturn_raw_event as a value, not as a reference.
> 	 * So we have to decrease report size here so that it will
> pass data size test in hid-core.c:hid_report_raw_event()
> 	*/
> 	int ret =3D 0;
>=20
> 	if (report->size =3D=3D 64)=C2=A0	// 64 bits length
> 	{
> 		report->size =3D 56;	// decrease it to 56 bit
> 	}
>=20
> 	return ret;
> }
>=20
> static const struct hid_device_id irig_blueturn_id_table[] =3D {
> 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_IK_MULTIMEDIA,
> 			 USB_VENDOR_ID_IK_MULTIMEDIA_IRIG_BLUETURN)
> },
> 	{ }
> };
> MODULE_DEVICE_TABLE(hid, irig_blueturn_id_table);
>=20
> static struct hid_driver irig_blueturn_driver =3D {
> 	.name			=3D "irig blueturn",
> 	.id_table		=3D irig_blueturn_id_table,
> 	.raw_event=C2=A0		=3D irig_blueturn_raw_event,
> };
>=20
> module_hid_driver(irig_blueturn_driver);
