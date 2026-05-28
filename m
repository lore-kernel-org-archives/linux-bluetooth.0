Received: from mail.f-solutions.fi (mail.f-solutions.fi [178.213.234.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D0240912B
	for <linux-bluetooth@vger.kernel.org>; Thu, 28 May 2026 18:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.213.234.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779993504; cv=none; b=pCljD1bPDSvw5R1JZpxqNkTUBiODr0wi1Y2Znv79wWVDQJEJ3k+1XJFGBLr1kt9bAgyFxOfkpBnHrcSVk0cMkTXc8whNqEBTauYF2qkMKXi52aBOi2TeRBaq/CMwbBErW86mqYzb+zTyG2osaeTUvM7jJcc4zviNCojEp4aGkWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779993504; c=relaxed/simple;
	bh=5jUrnyfihoXDU7Z8FOoNFg341HBr8e/hMd0eVqprV9o=;
	h=Message-ID:Subject:From:To:Date:Content-Type:MIME-Version; b=A5RkJtHybrKqYhxXm/OSoX0UbHoRvBUdxEdK3VFcwBDDwBrpj4LylDDJvfzK/FJewUuGiRFI/YtmTTwxJZgBxzBQ/8FJfUmE0Fzi4LPenGCHTECYxqFCSNUl47oYknxOOHZehQ0HEBgVRRjGtcpNVfN7HoorvPEwdMZ56cKjsOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=strokeplan.com; spf=pass smtp.mailfrom=strokeplan.com; dkim=pass (2048-bit key) header.d=strokeplan.com header.i=@strokeplan.com header.b=nTZWSJye; arc=none smtp.client-ip=178.213.234.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=strokeplan.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strokeplan.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=strokeplan.com header.i=@strokeplan.com header.b="nTZWSJye"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=strokeplan.com;
 i=@strokeplan.com; q=dns/txt; s=fsolrsa; t=1779993499; h=message-id :
 subject : from : to : date : content-type : content-transfer-encoding
 : mime-version : from;
 bh=5jUrnyfihoXDU7Z8FOoNFg341HBr8e/hMd0eVqprV9o=;
 b=nTZWSJyeOdgbTKKtzy1iBvF3lxCb2JMcADgTONwpSiK0k6Wj8VjY03SOAuEeHQeQYFCX/
 l6WI2pnZxcoNgIMZ54HRk9tivPOEXaceO7nKBNRwgFQwZaIBOPqQ/sKaclp6VDxr5z2cpIj
 IE1s+u4flKoEbTmzANPBL4coA5b65khVc/kwi3aDXB+EbcSoLnz4Qc0u7yGr6B9VoSMK6Tb
 IwJAJ7oKMQsoeMwpsbulsbj8JZQngVCExef7IOivgkHRXBS5mt8sLkldtLYIylQ+La0B2Ov
 rXezHxk1p4c0DzYgJfzpRMjaauaNjRXdI/BjAg1SNgHWK8U4LWOhfeOjsGUA==
Received: from [10.49.194.39] (mobile-access-567367-100.dhcp.inet.fi [86.115.103.100])
 by mail.f-solutions.fi (Postfix) with ESMTPSA id 31AFC30BCCDE
	for <linux-bluetooth@vger.kernel.org>; Thu, 28 May 2026 21:38:19 +0300 (EEST)
Message-ID: <74db472595986d0dec795353ea5f1eed7a3bd8e2.camel@strokeplan.com>
Subject: Fwd: Correct contact people(s) and Linux branch for my HID driver?
From: Mikko Laanti <mikko.laanti@strokeplan.com>
To: linux-bluetooth@vger.kernel.org
Date: Thu, 28 May 2026 21:38:18 +0300
Autocrypt: addr=mikko.laanti@strokeplan.com; prefer-encrypt=mutual;
 keydata=mQENBFnrH9wBCADiV0G0VVA/qs9rr9DqG2xvlcRzMVrtdP5Fw+rRdb6dUJq68aPcSNcQ4
 NtyosYX/w+NoTH3LrdjkiFno+4EBbnqnYDfA+U1UU1NSt6WnciMauAJkYVyJFtb41wUPJizAMFyuo
 8/75tD54jSz3JjxnMinYZ8x86UON8jCeAOET7L1KxbRC4tQeSABn7MebTOKUIBntVJnfA+ieqFOXf
 R4wW5RnjBBbIjjDmaS2XlulzdxqZSgp9DVijwKkM/pONFdP+7f0W6LDkPvpJriVXvjuNuNwt+LrBp
 r8tmPmSocr69Ju9S55Kt9uuymxGTzqtFtKt/6V0AAw/LEv8+XCxh/JLpABEBAAG0Kk1pa2tvIExhY
 W50aSA8bWlra28ubGFhbnRpQHN0cm9rZXBsYW4uY29tPokBTgQTAQgAOBYhBO9qaRpgftuPkzg3l3
 VWKEbXWIs3BQJZ6x/cAhsDBQsJCAcCBhUICQoLAgQWAgMBAh4BAheAAAoJEHVWKEbXWIs3nHMIAKr
 U9JEWP9/PblxyX4kC3dE+td+Zw3BuOlUvj44yDIai6/zrjuYeOCf6/M6p/ZqjQlXpl0UKbtZA2bzs
 cf7GIMM/hX2R7xk24CDm0g3ecQdzCDsNrYFXY9AMIkkgJKgnV3NSI1p0GxPkce9W9UyYkmSc07x9X
 gLkKRlyTAnRctsyppmvnCjqfgMRoYBVFy0Wu0ocLY2RZT7YIAMgZV/sbrb6eeoChxN8QHIpnHhSKh
 djWBBuLAm0YISJ9K+yWfk6ORIBUHppezjF71gjbw202931JI08adQYPNTSj82ricCfzf4zAkHgA9/
 9PDLQ+LOm8E8aTAKKip7fMcu5Je0HusU=
Organization: Strokeplan Oy
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

I have witten following driver for bluetooth HID device iRig BlueTurn.
To whom should I contact? If it is accepted, to what git Linux kernel
branch should I it check-in?

Regards,

Mikko Laanti


// SPDX-License-Identifier: GPL-2.0+
/*
 *  HID driver for IK Multimedia iRig BlueTurn devices
 *
 *  Copyright (c) 2026 Mikko Laanti <strokeplan@gmail.com>
 */

#include <linux/hid.h>
#include <linux/module.h>

#include "hid-ids.h"

MODULE_AUTHOR("Mikko Laanti <strokeplan@gmail.com");
MODULE_DESCRIPTION("iRig BlueTurn devices");
MODULE_LICENSE("GPL");

/* Changes in Makefile
obj-$(CONFIG_HID_IRIG_BLUETURN)	+=3D hid-irig-blueturn.o

 * Changes in Kconfig
config HID_IRIG_BLUETURN
	tristate "iRig BlueTurn devices"
	help
	Support for iRig BlueTurn devices, which are not fully
compliant with the
	HID standard.
	hid-irig-blueturn

	To compile this driver as a module, choose M here: the module
	will be called hid-irig-blueturn.ko.

 * Changes in hid-ids.h
#define USB_VENDOR_ID_IK_MULTIMEDIA	0x0214
#define USB_VENDOR_ID_IK_MULTIMEDIA_IRIG_BLUETURN	0x0002
*/

/*
 * The iRig BlueTurn (Page turner) foot controlled bluetooth keyboard
uses unnumbered keyboard messages
 * iRig BlueTurn can be configured to three possible configurations for
its two buttons:
 * 	1. ARROW_UP/ARROW_DOWN
 *	2. PAGE_UP/PAGE_DOWN
 *	3. ARROW_LEFT/ARROW_RIGHT
 * E.g. A compliant bluetooth keyboard sends Up Arrow:  01 00 00 52 00
00 00 00 00 (first data byte means it is "numbered")
 *      IK multimedia iRig BlueTurn sends Up Arrow:     00 00 00 52 00
00 00 00
 * Without this driver and iRig BlueTurn connected, you'll get system
log dmesg error:
 * "Event data for report 0 was too short (8 vs 7)"   (hid-core.c:
hid_report_raw_event)
 */

static int irig_blueturn_raw_event(struct hid_device *hdev, struct
hid_report *report,
	u8 *data, int size)
{
	/* iRig Blueturn always sends unnumbered 8 bytes i.e. 64 bits
data reports.
	 * hid-core.c: hid_report_raw_event() decreases data size by
one because keyboard messages should be numbered.
	 * We decrease report size here so that it will pass data size
test in hid-core.c:hid_report_raw_event()
	 * Right way would be to adjust data so that it looks exactly
like compliant keyboard, but we cannot set
	 * the size because it has been passed to this
irig_blueturn_raw_event as a value, not as a reference.
	 * So we have to decrease report size here so that it will
pass data size test in hid-core.c:hid_report_raw_event()
	*/
	int ret =3D 0;

	if (report->size =3D=3D 64) 	// 64 bits length
	{
		report->size =3D 56;	// decrease it to 56 bit
	}

	return ret;
}

static const struct hid_device_id irig_blueturn_id_table[] =3D {
	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_IK_MULTIMEDIA,
			 USB_VENDOR_ID_IK_MULTIMEDIA_IRIG_BLUETURN) },
	{ }
};
MODULE_DEVICE_TABLE(hid, irig_blueturn_id_table);

static struct hid_driver irig_blueturn_driver =3D {
	.name			=3D "irig blueturn",
	.id_table		=3D irig_blueturn_id_table,
	.raw_event 		=3D irig_blueturn_raw_event,
};

module_hid_driver(irig_blueturn_driver);
