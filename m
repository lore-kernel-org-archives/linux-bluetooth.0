Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD0C134CB;
	Wed,  2 Jul 2025 03:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751427367; cv=none; b=Mw75REMijXUrOUEBbqeCNZZrHXZ0BtDd810CiiFOy1R6NkOQIiHFMb/Jx1s/5nvsSmcARQW78gBJ69iVI0MhTIY8kGwn+PwkvAqetm+iSMa5NLm9fkECLzCJPhiHVyZKN9EUcJmrCabN0MuIsH3vhg1zkj7a3CdCY+qR8/aMd8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751427367; c=relaxed/simple;
	bh=NBvlrK5XViRYhJdQx7zRW6r4tsqgY4IsuBGgrTdg2Rw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uB3+U2R2Sg1Hp4jljvKCjW6igttoCPWFEaNQ0RKyHCDruVZctX+b/GQ65Hnw9B/eAmtVd7s/pmT0KNkN3pxCK+9wi0/ZBzzA3TLj48WURMSXxtWY94GjQxKQ59E2qUyRkFRoxUZ1FMMNy529PhBhb69L1Vi+3NRWWGT5g9XNbSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=wXPsbTml; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="wXPsbTml"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5623ZsAbA099570, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1751427354; bh=6Gt2ptt6+QTAnvc5BVZgyzDfyb+SrE+epvKtkf3w98I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=wXPsbTmlcytklcdBnrjYZzyl1biB1ohRCTYkb3mC7EaiJOiRZJ86PrFmVvGzQHIT1
	 YwKhmul9SBIVRBVexb0TDXxGgimn4SgAkVswfL10BOysTDHo02ItF+VblG9qfhQg6r
	 38Tv9r9+bey9OYxJ5r1T2ey15HueGyYvE5n3EHa03+kNPAA+jVWBRWa0i9aJ2KtuYq
	 wqfxFHbpLloA2eIs8TWo2k87Ca1Bj1dCwu4sMn5RiT9ms6Iyc8rsu1+EWbn9Kp1B8B
	 950j6UCNesM1gHo5Cc/Irz2boHvVqsbm1dKghlzoNjNmBbFYg1K9fJsE+rGJuYUp8t
	 5QUS0vXbVBq2g==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 5623ZsAbA099570
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 2 Jul 2025 11:35:54 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 2 Jul 2025 11:36:17 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG02.realtek.com.tw (172.21.6.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 2 Jul 2025 11:36:16 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622]) by
 RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622%5]) with mapi id
 15.01.2507.035; Wed, 2 Jul 2025 11:36:16 +0800
From: Hilda Wu <hildawu@realtek.com>
To: "marcel@holtmann.org" <marcel@holtmann.org>
CC: "luiz.dentz@gmail.com" <luiz.dentz@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Max Chou
	<max.chou@realtek.com>,
        "alex_lu@realsil.com.cn" <alex_lu@realsil.com.cn>
Subject: RE: [PATCH v2 0/2] Bluetooth: Add support for RTK firmware version 3 and enhanced ACL-based download acceleration
Thread-Topic: [PATCH v2 0/2] Bluetooth: Add support for RTK firmware version 3
 and enhanced ACL-based download acceleration
Thread-Index: AQHb1sJPczRWSzumC0S0Fn0i59ihhbQeQOnQ
Date: Wed, 2 Jul 2025 03:36:16 +0000
Message-ID: <bb5d83c2efa24dd8ad271ce812581d02@realtek.com>
References: <20250606090559.896242-1-hildawu@realtek.com>
In-Reply-To: <20250606090559.896242-1-hildawu@realtek.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Marcel, Luiz and Maintainers,

I hope this message finds you well.

I submitted two patches for the Bluetooth subsystem recently and wanted to =
kindly follow up to see if you had a chance to review them:

- https://patchwork.kernel.org/project/bluetooth/patch/20250606090559.89624=
2-2-hildawu@realtek.com/
- https://patchwork.kernel.org/project/bluetooth/patch/20250606090559.89624=
2-3-hildawu@realtek.com/

These patches address the future chips firmware format enhancement and down=
load firmware improve.

Please let me know if you need any further info or changes from my side.
Thank you very much for your time and consideration.

Best regards, =20
Hilda

-----Original Message-----
From: Hilda Wu <hildawu@realtek.com>=20
Sent: Friday, June 6, 2025 5:06 PM
To: marcel@holtmann.org
Cc: luiz.dentz@gmail.com; linux-bluetooth@vger.kernel.org; linux-kernel@vge=
r.kernel.org; Max Chou <max.chou@realtek.com>; alex_lu@realsil.com.cn
Subject: [PATCH v2 0/2] Bluetooth: Add support for RTK firmware version 3 a=
nd enhanced ACL-based download acceleration

Dear Maintainers,

I am submitting a patch for the Bluetooth that introduces support for RTK f=
irmware version 3 and implements an enhanced download mechanism through ACL=
 to improve firmware loading times.

Patch Overview:

1. Bluetooth: btrtl: Firmware format v3 support
   - This addition ensures the latest RTK chipsets with firmware version 3
     are fully supported. It includes necessary modifications to
     accommodate new firmware structure changes.

2. Bluetooth: btrtl: Add enhanced download support
   - By leveraging ACL links for firmware transmission, the download
     process is significantly accelerated, reducing the overall time and
     enhancing performance.

Testing and Validation:

- The implementation has been tested on various RTK chipsets under Linux
  based distribution.

Impact and Benefits:

These enhancements are beneficial for future firmware v3 chips and compatib=
le with previous firmware versions. Users can expect shortened initializati=
on times.

Your feedback and suggestions are welcome to further refine these changes.
Thank you for considering these enhancements.

Best regards,
Hilda

---
Change in V2:
- Move structure to btrtl.h
- Fill in the missing symbols
- Fix build warnings

Hilda Wu (2):
  Bluetooth: btrtl: Firmware format v3 support
  Bluetooth: btrtl: Add enhanced download support

 drivers/bluetooth/btrtl.c | 857 +++++++++++++++++++++++++++++++++++++-
 drivers/bluetooth/btrtl.h | 122 ++++++
 drivers/bluetooth/btusb.c |   3 +
 3 files changed, 974 insertions(+), 8 deletions(-)

--
2.34.1

