Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F1FD23B0
	for <linux-bluetooth@vger.kernel.org>; Fri, 22 Nov 2024 05:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732252838; cv=none; b=USNQcnKDlaJlenymd8AabPBsiNzURRJlElHoPHgW96I9wfkO2VMti5oxMWdjLe2+p3OFF2Y6Dmg8RN6BS9vPXNkewBuKG/YRvx8yBz0Czgxqxp4bTscnXORZ9wovlfQEEJbsPvP/e5r1nQPs7XzOczMoE37ZYxI/hk8DBX8KrFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732252838; c=relaxed/simple;
	bh=mDxCQq60UycEX907PH+ROmBNQFNsNo0FwLkB+Dcb120=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iBsvusZwlNh8glmIx25pijdcSjiPVbeJWO2z7JLVZPPrvBHpJxAPpSIL2TlgHe8p7XCSkUUo+VbKHZTonlCoLSrF6mY01FzOKLbhkcvv0HGMYSPADm/XANbvkYEYk+4BkSI1vFj9qhpQyUX291Hb/7+/UW6WNS2RLduaYK6PRgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=DRTMfqdM; arc=none smtp.client-ip=185.70.40.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="DRTMfqdM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1732252833; x=1732512033;
	bh=mDxCQq60UycEX907PH+ROmBNQFNsNo0FwLkB+Dcb120=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=DRTMfqdMfv0pN/LRSdfjCsrIvXLXOp1r5vMRY4JuOJQrcfR22apVtTabT58XaWPZC
	 4cErcug8EHAnpazDRDJHeBGhJLq3vflRRxD93XytsfcRHU83IBovbkvJg0bI7caloS
	 uMb9Jv36IgDjgh7vi+xlKlmMO1bQ5hUv6eMEdA+r4lLvFi+9ZofnPbtaxDekFO7RpC
	 rT3b0xRagD+tiY2Nl9JLNaoTuag7zFiK3uiXrJNyh49s7mYjanbD56tyeySxSztsbc
	 bVal2ExZy+YEUt/U4eBJR6Vx7AGwqZyzqGjhEHvgNCyz4pJy8zdBJIRR9km7rqvA6n
	 Gv+JX1iA03FjA==
Date: Fri, 22 Nov 2024 05:20:27 +0000
To: j.alan.jones@pm.me
From: Alan Jones <j.alan.jones@pm.me>
Cc: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: btusb: Ignore Nintendo Wii module
Message-ID: <20241122051947.716313-1-j.alan.jones@pm.me>
In-Reply-To: <HMjPEtiPDMAaCAIwvxGbpGc-F-pWc_xtxbsY_c8hA6_BLJjW8UJYvD2Znd2q8P21P3O2C4kkrei1ISdn4wBT5FIxf6tO1lr3EVcaFmZJjv4=@pm.me>
References: <HMjPEtiPDMAaCAIwvxGbpGc-F-pWc_xtxbsY_c8hA6_BLJjW8UJYvD2Znd2q8P21P3O2C4kkrei1ISdn4wBT5FIxf6tO1lr3EVcaFmZJjv4=@pm.me>
Feedback-ID: 106914784:user:proton
X-Pm-Message-ID: f0c0c8887885b57d63c2d36756557675fd1eb695
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
 drivers/bluetooth/btusb.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index e9534fbc92e3..11c9ea182ea4 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -185,6 +185,9 @@ static const struct usb_device_id quirks_table[] =3D {
 =09/* Broadcom BCM2045 devices */
 =09{ USB_DEVICE(0x0a5c, 0x2045), .driver_info =3D BTUSB_BCM2045 },
=20
+=09/* Broadcom BCM2045 with Nintendo Wii firmware */
+=09{ USB_DEVICE(0x057E, 0x0305), .driver_info =3D BTUSB_IGNORE },
+
 =09/* Atheros 3011 with sflash firmware */
 =09{ USB_DEVICE(0x0489, 0xe027), .driver_info =3D BTUSB_IGNORE },
 =09{ USB_DEVICE(0x0489, 0xe03d), .driver_info =3D BTUSB_IGNORE },
--=20
2.43.0


