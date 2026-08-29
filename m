Received: from aposti.net (aposti.net [185.119.170.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD734125A0;
	Sat, 29 Aug 2026 10:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.119.170.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787997740; cv=none; b=V0z6jQq0iEkzuak4vvd3qcbP+ANffc5Ij7YWHT1kC04KE8ro5I1q5WM2KfVs6bShSy2qbKI1gB7tlNFZngdNfqP+8MzH81DWh0zi1Zc451O+4kaknrZfmml+E169oa2q1lNDrIQw1anqE1PltLBoTpsOZvNXzXd34e6XeS7nkNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787997740; c=relaxed/simple;
	bh=yw4bGtMXtktOznhLEvuTvUohIiJWcpcA2OORlnJBvg4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LqLZH3QRxb+UY5RvcajEE3YchppCcl1fBTUuKWhv9qtcsRIRUn9tgQ+/8CfFQKAs4MRup7dxdK8oXGx1UxRTJ8d5jD6hmD1ZGnL/XN/6pYpYQ46d6o8apyA1tAd4PTwXLioSW83XnrlalkeN5Tv21MKVvqxvIrJEZESi2HQqPss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=crapouillou.net; spf=pass smtp.mailfrom=crapouillou.net; dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b=oT1V1rzW; arc=none smtp.client-ip=185.119.170.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=crapouillou.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crapouillou.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="oT1V1rzW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crapouillou.net;
	s=mail; t=1787997735;
	bh=yw4bGtMXtktOznhLEvuTvUohIiJWcpcA2OORlnJBvg4=;
	h=From:To:Cc:Subject:Date:From;
	b=oT1V1rzWEJXMaZ0zm0A2tsKC/7wzZW2tfr2hRTY/xLb0+AuFIk8Vg1nl06I2aseSm
	 HbPkMuSc6Oplw+Kk7Bqm3yFVbJOsdIOA7t72B1VNyAVhNIXT15ue6KQ5xzsTyja2gc
	 DfMe8SS8P4s1l7CyJPaG8HrD3MkewxV+RiI9F9Pg=
From: Paul Cercueil <paul@crapouillou.net>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH] Bluetooth: hci_bcm: Default to 4 Mbps
Date: Sat, 29 Aug 2026 12:02:05 +0200
Message-ID: <20260829100205.113655-1-paul@crapouillou.net>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ACPI path already did default to 4000000 baud, while the OF path did
not, for some reason. This meant that unless overridden with the
'max-speed' OF property, the serial port would stay at the init speed of
115200 bps, making it unsuitable with high-speed Bluetooth devices like
audio equipment.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/bluetooth/hci_bcm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index 9a103db7e355..c44d552f9ad5 100644
--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -1224,6 +1224,7 @@ static int bcm_acpi_probe(struct bcm_device *dev)
 
 static int bcm_of_probe(struct bcm_device *bdev)
 {
+	bdev->oper_speed = 4000000;
 	bdev->use_autobaud_mode = device_property_read_bool(bdev->dev,
 							    "brcm,requires-autobaud-mode");
 	device_property_read_u32(bdev->dev, "max-speed", &bdev->oper_speed);
-- 
2.53.0

