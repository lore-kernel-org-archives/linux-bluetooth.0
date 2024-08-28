Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6872415B57A;
	Wed, 28 Aug 2024 09:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724838997; cv=none; b=RT/As+AHpSDpbHni+ATSnwvmMbhhAAXdzkvv3NqurxyprECUHFo2U8tL1b7a74VKtbVQwOXElsw1DPS7dLraC3COQaojOoWBfu6UBhgPNH7MYRAwiMsrJGSAusxmmYfaEa/KiF+pVKG+WRB0hgfUlWWQEDyEufJ5wIShBStNR2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724838997; c=relaxed/simple;
	bh=f7KMAHk1SB6+PtXqQ/OFDoN8SVHtWKuIrn/8JhJY3Vc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=me6QZu2XyPT7+SnOOm9ze5oKdiSJu9U7j6I0dlbmMk4pap2LDiHPf/WYvedbyIYNMNM2S1biz1n1qHR+z7QZ/5W6ZMsdwgCoIrpO1at6xKAZQyGdYT7cLHncVMCLTCyuPFpdd7qVoAioP6mZsL6XT7kZ5rVUlhsXJ8wXMhyz19k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=trPBvWmi; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="trPBvWmi"
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 47S9uOA912130977, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1724838984; bh=f7KMAHk1SB6+PtXqQ/OFDoN8SVHtWKuIrn/8JhJY3Vc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=trPBvWmiO2XzHItPy2gRXTzXPWi0bEBkKI7SKvW3CwyyZX8rTOOnzTTKaAhdMj0tZ
	 wDQKJXqsMkQC5Cbpqe/LudZ9XGg2+E297cXMnPKDR/PlTTnYJKH7QQjWVmR2ry01mg
	 pjPUJB6VTtx7oey8gicCvkarB/MGVO3iGX0OKqvC3DvsUYY0E2UsK4gpUOw/z5YRn7
	 xZQHBN4tiJN4+j0IWLmjqoUY85qYR6/ryxWsXMwvnEEAvZkfdSqSdp/o9LbG6gCKbU
	 CFTjW2ldHWRkbAzjquiY2aBna4e340oO51425xmEtd4fCZ8LicyC3fqli5MiBBl/nS
	 Ou6F9n8XwFoZA==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 47S9uOA912130977
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 Aug 2024 17:56:24 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 28 Aug 2024 17:56:25 +0800
Received: from localhost.localhost (172.21.132.53) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 28 Aug
 2024 17:56:24 +0800
From: Hilda Wu <hildawu@realtek.com>
To: <marcel@holtmann.org>
CC: <luiz.dentz@gmail.com>, <linux-bluetooth@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <alex_lu@realsil.com.cn>,
        <max.chou@realtek.com>, <kidman@realtek.com>
Subject: [PATCH V2 RESEND] Bluetooth: btrtl: Set MSFT_EXT_ADDRESS_FILTER quirk for RTL8852B
Date: Wed, 28 Aug 2024 17:56:20 +0800
Message-ID: <20240828095620.663466-1-hildawu@realtek.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: RTEXH36506.realtek.com.tw (172.21.6.27) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Set HCI_QUIRK_USE_MSFT_EXT_ADDRESS_FILTER quirk for RTL8852B.

The quirk to support tracking multiple devices concurrently.
Commit 9e14606d8f38 ("Bluetooth: msft: Extended monitor tracking by
address filter")

With this setting, when a pattern monitor detects the device, this
feature issues an address monitor for tracking that device. Let
pattern monitor can keep monitor new devices.

Signed-off-by: Hilda Wu <hildawu@realtek.com>
---
Change in v2:
 - Add reference commit, update commit description
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

