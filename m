Received: from mail-106120.protonmail.ch (mail-106120.protonmail.ch [79.135.106.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9952B41F7D8;
	Thu,  3 Sep 2026 08:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788423332; cv=none; b=ETxao9Lxtb9rm2zLJQ/qcUHvUP5Fh2E0Fr3wt2L+oAbjYP84j5kgyX+UQsfseLt1j4q81Ntuy4a443IkzRBMM01+yLvbYwoFjkaxaJeaM3M/nCB8kFiti1+bfdh+x6D3y+tOFDROWk5Q2YPmCqqeNKy1JgsCL1ZcxXp4chE4HqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788423332; c=relaxed/simple;
	bh=CBl5koq5Va6StuHpZC3D9u2ugJ1Ypvnv7DdPybkE87Y=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=YZhygsh1uU3qgecfTtaeUfGuG0NhjeQv7Paz8hjNatigrG/wl4pJPrhmZ3o2Wbv6i2rtEtQqkZrie3eyODrB/3mimsxPWKDE1kcXqINULH4Pa2mY69H3CCOLw+d2nVE8JbrNIKoP8I5OK/hmq0sa61krcim3UU6xLDCYmntaAwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=IL3gSLnt; arc=none smtp.client-ip=79.135.106.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="IL3gSLnt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1788423327; x=1788682527;
	bh=8qohHOGR74M5gv9cKBc+1NOuQewETcRpNogEKQIaiSE=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=IL3gSLntXk7GELJIcBHSy9pf2gRH/LlGLGWHqOrtlu0s0CkKdrlyagu3/PR3CSyI4
	 3hB+k7lfT4rf0zDsV+Yoe67rxTfwMO9qBmgbeJpPxaSlauCWx2ra11KX9+6yYiWwpO
	 exjWE/9B7NPepsNrW3rXz3TgwwY61YNPxw4FH1afawGDNVkHHHDre6mPXFgaTfRKeh
	 3ru3fEKcxmQ0jpzZOAHmAa8Y2jAa5Q85XAijolGckl2lveZojr3AF2qvtRZQj+X6NA
	 yw8TzfN0z1IyCfw7ycg55h790LanzStS4CzIwFobW7BujqJOuLSXs3pJbuUDlbKdEf
	 n7y2SMAx9wGdA==
Date: Thu, 03 Sep 2026 08:15:23 +0000
To: "marcel@holtmann.org" <marcel@holtmann.org>, "luiz.dentz@gmail.com" <luiz.dentz@gmail.com>
From: Samuel Alhovuori <samuel.alhovuori@pm.me>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] Bluetooth: btusb: Add device ID for MediaTek MT7925 (13d3:3631)
Message-ID: <7Lm0MbvHvV4KTuQVikJfyHTljM3ozGSBICPx7mcV3jvMSuZw8zx_jHkWn2wuhpZnaUhJgEpgHG22crnJMxLVX_1TRzBT4ME5WPZVtcDpBJg=@pm.me>
Feedback-ID: 178867618:user:proton
X-Pm-Message-ID: 9a64cf64177d10c7b0ba2006cb4602bbce6c756e
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

From a4e37604a8a8e7e282739a72d1a34b9477449df0 Mon Sep 17 00:00:00 2001
From: Samuel Alhovuori <samuel.alhovuori@pm.me>
Date: Thu, 3 Sep 2026 11:00:27 +0300
Subject: [PATCH] Bluetooth: btusb: Add device ID for Mediatek MT7925
 (13d3:3631)

Add the USB ID 13d3:3631 for the MediaTek MT7925 Bluetooth module
found on AzureWave / Mercusys MA37BE PCIe Wi-Fi 7 cards.

Signed-off-by: Samuel Alhovuori <samuel.alhovuori@pm.me>
---
 drivers/bluetooth/btusb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 03039ceaa..11c62ef1f 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -816,6 +816,8 @@ static const struct usb_device_id quirks_table[] =3D {
 =09=09=09=09=09=09     BTUSB_WIDEBAND_SPEECH },
 =09{ USB_DEVICE(0x13d3, 0x3630), .driver_info =3D BTUSB_MEDIATEK |
 =09=09=09=09=09=09     BTUSB_WIDEBAND_SPEECH },
+=09{ USB_DEVICE(0x13d3, 0x3631), .driver_info =3D BTUSB_MEDIATEK |
+=09=09=09=09=09=09     BTUSB_WIDEBAND_SPEECH },
 =09{ USB_DEVICE(0x2c7c, 0x7009), .driver_info =3D BTUSB_MEDIATEK |
 =09=09=09=09=09=09     BTUSB_WIDEBAND_SPEECH },

--
2.55.0
