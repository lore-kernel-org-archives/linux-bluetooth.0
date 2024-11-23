Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5E092770B
	for <linux-bluetooth@vger.kernel.org>; Sat, 23 Nov 2024 16:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732380343; cv=none; b=GWZ1w9z6mQ/V1xKoB5bGuZKM4zp82BYQLGl3LD2JeyUzTSegJsTa6GeBx44FOZkes5hPGAeKO1RU5qUDmmKJH2KDQtVHbQvDrFLQzBGghfkXNWN6T3O8y46fVc8NQGlLh+/29LezyFlyfmQwen+Xqg7GzfPDpbW7QlU8lK6JjIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732380343; c=relaxed/simple;
	bh=upT1FzebVVnK1Lqo1bklpOSbS5Qr9vb9Rt9Z3jISvIw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q50lsme4vjOzaSVCK3Kb8APAskboMSLIVVaArBxZjARoNpm6SiyS1gJf6yCspzBHbyEW7WtJthAesp3TVrKs4DuPIm/fjTcUFroxUflh0KSoV0U5R3lsS7m5mIT9CaZ5mXobj96pPmiKhym2I8QccME5ii7facNOb6NjLRytDIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=fNbelB4H; arc=none smtp.client-ip=185.70.40.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="fNbelB4H"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1732380339; x=1732639539;
	bh=upT1FzebVVnK1Lqo1bklpOSbS5Qr9vb9Rt9Z3jISvIw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=fNbelB4HAUYfYB2FM9ED1jAaMR3nraQuRiS1N5jxK7gkNYnRmX2ZU3FTMVtv6aUf7
	 xpCF1670gQv05Nrm3qjbXKtald6KBMFwLhgrbwxLlwgJWf94NRoBewa6rVmbpLiCtM
	 i+Lze5pKoXljDsDYtzR/F2QldvNkgEtP/XQNgKrsYgOSYDONMPRLexKnLtuuEInLy8
	 AQ1yz+MvGp+CH1DvhW54a388AhL5/wDYr44xiusDhoWHJj+4cdweCEeGttS4Lii7NK
	 26UckPuKMzg96xSNTOOs3KTLVzs+ke0Ki+znuYdV4tOtk9xpvVUd5iO3R/Gp4aX1FZ
	 v8CVOsO5OkV3Q==
Date: Sat, 23 Nov 2024 16:45:34 +0000
To: j.alan.jones@pm.me
From: Alan Jones <j.alan.jones@pm.me>
Cc: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: btusb: Ignore Nintendo Wii module
Message-ID: <20241123164510.879109-1-j.alan.jones@pm.me>
In-Reply-To: <20241122051947.716313-1-j.alan.jones@pm.me>
References: <HMjPEtiPDMAaCAIwvxGbpGc-F-pWc_xtxbsY_c8hA6_BLJjW8UJYvD2Znd2q8P21P3O2C4kkrei1ISdn4wBT5FIxf6tO1lr3EVcaFmZJjv4=@pm.me> <20241122051947.716313-1-j.alan.jones@pm.me>
Feedback-ID: 106914784:user:proton
X-Pm-Message-ID: eb224aef55f5dc24a6619dc6ca7ad4c77e66ada0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

The Nintendo Wii uses a BCM2045 module running proprietary firmware.
This adapter is typically managed by emulation software via the raw
interface, and is incompatible with standard Bluetooth devices.

Attempting to initialize this adapter breaks synchronization with all
previously connected Wii Remotes, requiring applications to
re-synchronize the remotes on each usage.

Fix Wii Remote re-synchronization issues with the official Nintendo Wii
Bluetooth module by ignoring this adapter.

Signed-off-by: Alan Jones <j.alan.jones@pm.me>
---
 drivers/bluetooth/btusb.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index e9534fbc92e3..be8c009b8ab6 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -182,7 +182,10 @@ static const struct usb_device_id quirks_table[] =3D {
 =09/* Broadcom BCM2033 without firmware */
 =09{ USB_DEVICE(0x0a5c, 0x2033), .driver_info =3D BTUSB_IGNORE },
=20
-=09/* Broadcom BCM2045 devices */
+=09/* Broadcom BCM2045 devices with Nintendo Wii firmware */
+=09{ USB_DEVICE(0x057e, 0x0305), .driver_info =3D BTUSB_IGNORE },
+
+=09/* Broadcom BCM2045 devices with common firmware */
 =09{ USB_DEVICE(0x0a5c, 0x2045), .driver_info =3D BTUSB_BCM2045 },
=20
 =09/* Atheros 3011 with sflash firmware */
--=20
2.43.0


