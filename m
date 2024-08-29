Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE17D18C031;
	Thu, 29 Aug 2024 08:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724920818; cv=none; b=GCFleKV/alYr/qwQBO3hkK2qpgsjxU0/bEGmnkOHwnwKYoKITcfDAKnirbcQWx0zwk/LaoxlEpdD4f80bM248MdKTZuwuosrbasQz9ZQ0pr82eCrW+1RgiQ6NE18sBy/xu29BlLmCQwzUqKn/EKZ6Pu3tJ1Dz1PN59Fzmk/BbSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724920818; c=relaxed/simple;
	bh=wqUBko9nJux0cAwPOEfDcb1V9rZWqZbVILdjsy+nTgM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mhGFcHOi5aW8M640ofClV/M2AGMa8P/r9WG7qNZNWLesCYWJtgAmEo2lJfiwORuCEN6Y83PyXHCYkkLeoIj0Fd2qUVYpBR7D/jwi9+5dJkjPzfwJ/ExV5fCAmURS2VHpnUe6WzzxNEshGXb5NjUy7pwLNbMvF9awld41qqkZ0jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=Xy9SMGPR; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="Xy9SMGPR"
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 47T8eAq153355699, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1724920810; bh=wqUBko9nJux0cAwPOEfDcb1V9rZWqZbVILdjsy+nTgM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=Xy9SMGPRuv8+w56YcIXkGxhcM05aW5NrHBiiIbNZoj/xrGBRsaD65eiwSmQv1hypn
	 zS/8qHdEFevzMn1cclZ/J/h+DmxRpklXYqoStkoZlNyOzg7BBxcK9yEswl9pT7qoS3
	 RAkH1tSljoJ4gRRjLYjJbzj5hKoP9RO9kZYDvD6m5eyd/+Rf6hgb2W3HPdYLd1VHe7
	 gT5Gqh+mRjW3vE6EN5lhL7rmuxUdaNPvf/z6/2CS74phzhv2VMGepmkONNXRe38fXF
	 h7sv70ieJbDht59gAAxIWLoic8YRiHaxkubFIg3NqgX/VFpf0bInp70oQRoYeqlgrt
	 NWCpPCWxGn4uA==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 47T8eAq153355699
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Aug 2024 16:40:10 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 29 Aug 2024 16:40:10 +0800
Received: from localhost.localhost (172.21.132.53) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 29 Aug
 2024 16:40:09 +0800
From: Hilda Wu <hildawu@realtek.com>
To: <marcel@holtmann.org>
CC: <luiz.dentz@gmail.com>, <linux-bluetooth@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <alex_lu@realsil.com.cn>,
        <max.chou@realtek.com>, <kidman@realtek.com>
Subject: [PATCH v4] Bluetooth: btrtl: Set msft ext address filter quirk for RTL8852B
Date: Thu, 29 Aug 2024 16:40:05 +0800
Message-ID: <20240829084005.681732-1-hildawu@realtek.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: RTEXH36505.realtek.com.tw (172.21.6.25) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

For tracking multiple devices concurrently with a condition.
The patch enables the HCI_QUIRK_USE_MSFT_EXT_ADDRESS_FILTER quirk
on RTL8852B controller.

The quirk setting is based on commit 9e14606d8f38 ("Bluetooth: msft:
Extended monitor tracking by address filter")

With this setting, when a pattern monitor detects a device, this
feature issues an address monitor for tracking that device. Let the
original pattern monitor keep monitor new devices.

Signed-off-by: Hilda Wu <hildawu@realtek.com>
---
Change:
v4: edit commit log and summary
v3: edit commit log and title
v2: Add reference commit, update commit description
---
---
 drivers/bluetooth/btrtl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
index 4c0f551a9975..2d95b3ea046d 100644
--- a/drivers/bluetooth/btrtl.c
+++ b/drivers/bluetooth/btrtl.c
@@ -1308,6 +1308,7 @@ void btrtl_set_quirks(struct hci_dev *hdev, struct btrtl_device_info *btrtl_dev)
 			btrealtek_set_flag(hdev, REALTEK_ALT6_CONTINUOUS_TX_CHIP);
 
 		if (btrtl_dev->project_id == CHIP_ID_8852A ||
+		    btrtl_dev->project_id == CHIP_ID_8852B ||
 		    btrtl_dev->project_id == CHIP_ID_8852C)
 			set_bit(HCI_QUIRK_USE_MSFT_EXT_ADDRESS_FILTER, &hdev->quirks);
 
-- 
2.34.1

