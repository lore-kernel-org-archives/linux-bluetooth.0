Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F82EC4
	for <linux-bluetooth@vger.kernel.org>; Fri, 22 Nov 2024 04:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732248742; cv=none; b=A1WjdMQ7BdIQRRbNvEicNXhZeoKXmSw96IQYJ3Z4FbJ9OK1y2bH3D/A39be7GYPG/5vEqj0BBdJpbxofs/bg1WyhfKSDXl4/wwWNL9wWDRUZjKA1ckpKML3/asVE7OP78DHYrqaacRwngS41o+4/WwtxekwTuCZ5bQjeJhD/WUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732248742; c=relaxed/simple;
	bh=rEjmP1cHTi0pvboFJhd7UmK5Rjgk7jznONHfwwHAgQ4=;
	h=Date:To:From:Subject:Message-ID:MIME-Version:Content-Type; b=KbFPzkJxAhfm4mDk/rXFY+KtceFiKE9zvCdwwQbySuSQ2DAeRRUv+ZDI6AG2RGWUBv38pbwzsG6jvGRKIzjSInN2OdkSiqcLOc8hDkOb0CIoQY+nGNo8q/KfL66gvyIHOKWgdGWzrFOb/90f7gDSHIwHv3CC+ruUJMux8M4DyaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=AELVOxTi; arc=none smtp.client-ip=185.70.40.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="AELVOxTi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1732248737; x=1732507937;
	bh=Sg39l2lqITpA5qXwLB9kUdAtEH0iGllJrerW2vZwv34=;
	h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector:
	 List-Unsubscribe:List-Unsubscribe-Post;
	b=AELVOxTizbtHuyth/dDwRPaYgpW29k3opdw5+lgGaqS645K2dFUMbi5HciZXwREgD
	 JOYmwt7UhNszW0jWOLEMXyr/bzPDpQqCIRb0jZJrtZJ8JNqGzKON89YKxjbvoiTsLn
	 Ia1xZXfFqZlzFI4j8KV6ui5/CRxMtYA29VUzbSW6ddQSpg38JEgggudWQs5g4Fhr9o
	 mhXgX891uKbH5h140gQUMQ2em5uKdlp7sLascrlliTCzb3fLkb4bbuMDSQEebPvEvk
	 ti2WvJZTGBISNvnx9RZx1kV4nAtGg6FPwq3E+t6bOK6HHww/A7/ayP2UfvVO40HCV4
	 usaFIZZ+yQ6rQ==
Date: Fri, 22 Nov 2024 04:12:13 +0000
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
From: Alan Jones <j.alan.jones@pm.me>
Subject: [PATCH] Bluetooth: btusb: Ignore Nintendo Wii module
Message-ID: <HMjPEtiPDMAaCAIwvxGbpGc-F-pWc_xtxbsY_c8hA6_BLJjW8UJYvD2Znd2q8P21P3O2C4kkrei1ISdn4wBT5FIxf6tO1lr3EVcaFmZJjv4=@pm.me>
Feedback-ID: 106914784:user:proton
X-Pm-Message-ID: 1381b4dc91c536f3d079cb1e45bfb0d6e81b281b
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
index 279fe6c115fa..b85b98a40a87 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -185,6 +185,9 @@ static const struct usb_device_id quirks_table[] =3D {
        /* Broadcom BCM2045 devices */
        { USB_DEVICE(0x0a5c, 0x2045), .driver_info =3D BTUSB_BCM2045 },
=20
+       /* Broadcom BCM2045 with Nintendo Wii firmware */
+       { USB_DEVICE(0x057E, 0x0305), .driver_info =3D BTUSB_IGNORE },
+
        /* Atheros 3011 with sflash firmware */
        { USB_DEVICE(0x0489, 0xe027), .driver_info =3D BTUSB_IGNORE },
        { USB_DEVICE(0x0489, 0xe03d), .driver_info =3D BTUSB_IGNORE },
--=20
2.43.0

