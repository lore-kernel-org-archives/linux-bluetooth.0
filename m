Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 340FF2F12B3;
	Fri, 27 Mar 2026 15:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.3.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774625311; cv=none; b=OQ6Di5s+ILewmIf5io/Ra2KELtQDTa4cBw3mb8EyHw3CDickILvUuWiAMAetWncaPv3BHk64Iuqqgn4Xhgtz9NgcIp2kvb2PGLnN+EWRthcytkb5UEG2icT4B7qToNoCzjObtkn0xB+Lma1/xaI9ZtwSK6duh+Y9lBkrho+a+hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774625311; c=relaxed/simple;
	bh=B/1JAYXYY4LuMnqYziOc73TOItj4Vouv+cTxVflTE94=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dCZzbAmKFaBsThUlzORDmepxKO7a1r5+px7ezusZQRkMC3/6ONVOhhhDTY1a1cA6pWt4q91s9tpQqhPdMec5IbmSYid52XDb2/AjAdjRekCQZ1vcqIab4yvH91QPpTMRZdrOMCRjnJaPXplO8Nnb6u5kG/k9jtxIw9l4XWTUxN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=AHEs3h6h; arc=none smtp.client-ip=188.40.3.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="AHEs3h6h"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=ew.tq-group.com; s=default2602; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=9LyCXhL4PXXGsqUSfrzqv80p+RJWvAqbr4ncynTMwYk=; b=AHEs3h6h5Vn3yUNr+4I3JPgQ45
	DewNqeTP0736AC05z2wCl47o+kjuSlnsx3trCHYgxJlyasi1eSxxaCHQhWFCvbxYAvXL5VVMUFC3h
	Ij+XzQXKwbbWX54q0kCF/YHXE8mithlqaTyuOjolK05OyOJZe6MgsX1DRwPAo5Mw21cy+rJYyZFRY
	db8YDFzhkrRJt2qEkJkqjzRx3P/y09bnZGSKTwPr70heTopzhuUqpjaKzKH/xX7xorb+QG52XlJuT
	jRYFxS/H9q4v0xMfL7XBakXQ6Odt/55rNqVkPmes9ISIVAwUhr6HwTVQAqEKoAekkdTNL5HCgJ2mq
	1DWrFWcA==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
	by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <Alexander.Feilke@ew.tq-group.com>)
	id 1w696o-00092R-2q;
	Fri, 27 Mar 2026 16:28:26 +0100
Received: from localhost ([127.0.0.1])
	by sslproxy05.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <Alexander.Feilke@ew.tq-group.com>)
	id 1w696p-0002Mk-0E;
	Fri, 27 Mar 2026 16:28:26 +0100
From: Alexander Feilke <Alexander.Feilke@ew.tq-group.com>
To: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Alexander Feilke <Alexander.Feilke@ew.tq-group.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Subject: [PATCH] drivers: bluetooth: btti_main.c: replace quirks with new quirk_flags bitmap
Date: Fri, 27 Mar 2026 16:27:33 +0100
Message-ID: <20260327152735.148923-1-Alexander.Feilke@ew.tq-group.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/27953/Fri Mar 27 07:24:46 2026)

The integer was changed to a bitmask in [1], but wasnt applied in the latest
patch that integrated the btti driver.

[1] 6851a0c228fc ("Bluetooth: hci_dev: replace 'quirks' integer by 'quirk_flags' bitmap")

Fixes: d1ba06b645ef ("PENDING: bluetooth: add cc33xx BLE UART and SDIO drivers")
Signed-off-by: Alexander Feilke <Alexander.Feilke@ew.tq-group.com>
---
 drivers/bluetooth/btti_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btti_main.c b/drivers/bluetooth/btti_main.c
index d3ca09e99b818..d6e1c68277f2d 100644
--- a/drivers/bluetooth/btti_main.c
+++ b/drivers/bluetooth/btti_main.c
@@ -329,7 +329,7 @@ int btti_hci_register_hdev(struct btti_private *private_data)
 	hdev->setup = btti_hci_if_setup;
 	SET_HCIDEV_DEV(hdev, &sdiodev->func->dev);
 
-	set_bit(HCI_QUIRK_NON_PERSISTENT_SETUP, &hdev->quirks);
+	hci_set_quirk(hdev, HCI_QUIRK_NON_PERSISTENT_SETUP);
 
 	ret = hci_register_dev(hdev);
 	if (ret < 0) {
-- 
2.43.0

