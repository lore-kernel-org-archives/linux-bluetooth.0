Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E61E182C5
	for <linux-bluetooth@vger.kernel.org>; Sat, 23 Nov 2024 17:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732381474; cv=none; b=s+DYxzkR0NL7b03BWQtE8KZzlWDxWNdO9ukFS+0QL+XiaOGC0DL17dK+/VFxG4Ov/ro+8inaKD5enuqwBkrB7mxXwvBoado6vAzH+z+MHC+e5qJkYMHxFtW5z2LrIZh0ainD71w8QP6wVBHjPBGd0HKE3r5Tt7e2vYHnEgNetC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732381474; c=relaxed/simple;
	bh=aN/aMiDNZc23PeogScgpRzr7SvaV1GG9v6qG1k0Ivls=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U6fWjkDct7ia6Xub5QtlENj83Wn2ehRNd0ywpMoseqAuaocw29Egsh3b7tEAF2d+a/FQ1k9I6C6BCsQYbCNIvYhnNJMjLQGAta+XFGvRirFjwSKzaV5Utl5qEBFg8G8vMqohKNIBwzTLP3bHYxODdY6WMQlyVYAKkG+NVi4/I2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=XrcxZDpH; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="XrcxZDpH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1732381471; x=1732640671;
	bh=jEfLC5q+y4KCYlCedXjQlKSycb7UpnQ8CZAvNkplZM4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=XrcxZDpHeW4ot3FPeF+0FHQW8Jvh78PeTh9jBi3QcUI1VIam+yV7+UDfsI2ecbhak
	 kzPc3M2H9G4W0QC1bOimSBZovUIMUQwcxxLDnQmvjKfQVUXz5y4JWuTH7S8YEZFXUn
	 wQD1UCgih+7ne8TK3Ms9wDmvqrFX5DRxDYKgXQGpDqohtAqgXUjxWabvR2FjHW4fFC
	 dU6zAT/7BpmonmKPjR1jVorlmy7M8Q0Fp1+SZFD5XjdD+HEnmXXv84W1FvaV4fxq+j
	 T0Hn4HrNxk4o7MnGc/ebiarj0jwAAC2fg6XnFZKAVXpzIIf2YC3r2gBC6N6FD1s6o8
	 n52cZ2o82JIOw==
Date: Sat, 23 Nov 2024 17:04:28 +0000
To: j.alan.jones@pm.me
From: Alan Jones <j.alan.jones@pm.me>
Cc: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: btusb: Ignore Nintendo Wii module
Message-ID: <mAaTd8WUa8rEKmRjJCFc5PohACS9Xdx5NSBRdEIFQIkVisnPvpByHXSOGV9hiIpz4BfIknYY6rWr-5LroHjeAIsova4ytmci3cvfqk6FiZE=@pm.me>
In-Reply-To: <20241122051947.716313-1-j.alan.jones@pm.me>
References: <HMjPEtiPDMAaCAIwvxGbpGc-F-pWc_xtxbsY_c8hA6_BLJjW8UJYvD2Znd2q8P21P3O2C4kkrei1ISdn4wBT5FIxf6tO1lr3EVcaFmZJjv4=@pm.me> <20241122051947.716313-1-j.alan.jones@pm.me>
Feedback-ID: 106914784:user:proton
X-Pm-Message-ID: c1728c7f3f72261597045e801da20b9958e83dc6
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
        /* Broadcom BCM2033 without firmware */
        { USB_DEVICE(0x0a5c, 0x2033), .driver_info =3D BTUSB_IGNORE },
=20
-       /* Broadcom BCM2045 devices */
+       /* Broadcom BCM2045 devices with Nintendo Wii firmware */
+       { USB_DEVICE(0x057e, 0x0305), .driver_info =3D BTUSB_IGNORE },
+
+       /* Broadcom BCM2045 devices with common firmware */
        { USB_DEVICE(0x0a5c, 0x2045), .driver_info =3D BTUSB_BCM2045 },
=20
        /* Atheros 3011 with sflash firmware */
--=20
2.43.0


