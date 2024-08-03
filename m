Received: from nuclearsunshine.com (nuclearsunshine.com [81.187.79.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CAC1101EC
	for <linux-bluetooth@vger.kernel.org>; Sat,  3 Aug 2024 21:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.187.79.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722721814; cv=none; b=NQeqsAQkzWy3hoJQ7uXZc0AX79aLuyJ9paSG9ZCB6+WuXui6LYZaMAJpKQcqLpWh0MurIXlPnmwMGvehOnY7sJfmX7Yi72Q8TxJfz4K33m7zdj1Fq6FjsORPsVhYkxuLRJmfbDFPonPw5ICyKVB8Fe/qipIzzujwHcDWm2DNhuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722721814; c=relaxed/simple;
	bh=YsMxTve02Pdsve2FO+JNP7kgVwVrQvXBg4hfrCHG/8w=;
	h=Message-ID:Subject:From:To:Date:Content-Type:MIME-Version; b=gBlBtvvcthJ5dPA7HcayhWhVRI/6hg6bvo7kVnuI2d0ebTaUiMUBM14w5LRD9bzIERevPRQf1mleBCbBQpmiWvljXemTdw9j1fca47F6DUaVcS1h4uZ4aM5gb47YLcnTjKFe54ndK3Vw+05cWC7OVl7uS8k6UVtchAZ8e/k9ROY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuclearsunshine.com; spf=pass smtp.mailfrom=nuclearsunshine.com; arc=none smtp.client-ip=81.187.79.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nuclearsunshine.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuclearsunshine.com
Received: from desktop.internal.chaoschild.com (desktop.internal.chaoschild.com [192.168.1.2])
	by chaoschild.com (Postfix) with ESMTPSA id BC0A817631DC
	for <linux-bluetooth@vger.kernel.org>; Sat,  3 Aug 2024 22:44:50 +0100 (BST)
Message-ID: <a2cd95d91354168876eab963bb7e1cfa1b31e985.camel@nuclearsunshine.com>
Subject: [PATCH 1/1] Bluetooth: btusb: add 13d3/3608 VID/PID for MT7925
From: Nuclear Sunshine <kernel-2024-q3@nuclearsunshine.com>
To: linux-bluetooth@vger.kernel.org
Date: Sat, 03 Aug 2024 22:44:50 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3 (3.52.3-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

The VID/PID are as seen for this chipset in the Asus Zenbook S 16
(UM5606), and have been successfully tested with the mt7925e driver.

Signed-off-by: Nuclear Sunshine <kernel-2024-q3@nuclearsunshine.com>
---
 drivers/bluetooth/btusb.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index acdba5d77694..fccefa57506a 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -696,6 +696,9 @@ static const struct usb_device_id quirks_table[] =3D {
 	{ USB_DEVICE(0x13d3, 0x3603), .driver_info =3D BTUSB_MEDIATEK |
 						     BTUSB_WIDEBAND_SPEECH |
 						     BTUSB_VALID_LE_STATES },
+	{ USB_DEVICE(0x13d3, 0x3608), .driver_info =3D BTUSB_MEDIATEK |
+						     BTUSB_WIDEBAND_SPEECH |
+						     BTUSB_VALID_LE_STATES },
=20
 	/* Additional Realtek 8723AE Bluetooth devices */
 	{ USB_DEVICE(0x0930, 0x021d), .driver_info =3D BTUSB_REALTEK },
--=20
2.45.2


