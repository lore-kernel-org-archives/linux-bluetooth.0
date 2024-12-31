Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD03145A0B;
	Tue, 31 Dec 2024 06:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735628256; cv=none; b=fpSr24F8ILDDf7k28l6VGYIjSirhAt/qO/RzSAP3m2XHe/cQnpvvqEEBW57e5gehROg3AA16Q8RulSuvnxH/3LaVJ/p76OQHZZI4YFI5hZdi1HGEt5rEqeB0ZPdVnVvXPInrPT2TMAW2C2K03rGYmNLUJ4uco3AF9poVLXqaYGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735628256; c=relaxed/simple;
	bh=ExMzh2voNEYN2jo947+jd6MznarEXwzLRnsZJVuALDs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mYPZF+oTKXmo5h46m5h8iQ2aT2iaNAuWE1UATyB8CYYSmfT2W/oIbaBSWK3M28xdrWX6K8r3nGiRJX0PZWucfL54gpMo62+UjPxqKW7l+/ZpIa4nLQ8bmLRz6e9WN+rmbSQzZVWEnamsTZ74rmuOMnLDghbjIA0XZKgIeukBbsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=wGy9hMCU; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="wGy9hMCU"
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4BV6vPskD1230746, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1735628245; bh=ExMzh2voNEYN2jo947+jd6MznarEXwzLRnsZJVuALDs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=wGy9hMCUOKL2INXKkvibZsxOgsmbXjH7T0EYeuuwdB0YI6qkD0Mve39goUvwTLliQ
	 RDrEirXQIc1OK66woLygncOjC7kZdXCBEVVTrCKdM2Yyyy58SwWp16UtGQk3cLuYBt
	 pwqjmeUdXnMmgxjTZ3PFxE/xsPJ5c1ww/wiZ90MPTn1Mm/lyLLu1qDSNAas+4wqaVI
	 aU7HGXQqePUVbvNxEDYfi0wUmdxMPIbpuqAutTa0oIxeDB/Z5zPN2WH/cVV62yKWwh
	 06hTF2mUOWaouMjl7tyrjC5w66UXdUOllbRc8mFNR2iGIn1v7IzvpN82Cy8cyURMAC
	 DZlBGAhLiC8pA==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 4BV6vPskD1230746
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 31 Dec 2024 14:57:25 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 31 Dec 2024 14:57:26 +0800
Received: from localhost.localhost (172.21.132.123) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 31 Dec 2024 14:57:25 +0800
From: <max.chou@realtek.com>
To: Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz
	<luiz.dentz@gmail.com>,
        <linux-bluetooth@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Hilda Wu <hildawu@realtek.com>, alex_lu <alex_lu@realsil.com.cn>,
        Max Chou
	<max.chou@realtek.com>
Subject: [PATCH] Bluetooth: btrtl: check for NULL in btrtl_setup_realtek()
Date: Tue, 31 Dec 2024 14:57:19 +0800
Message-ID: <20241231065719.4840-1-max.chou@realtek.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: RTEXH36505.realtek.com.tw (172.21.6.25) To
 RTEXMBS03.realtek.com.tw (172.21.6.96)
X-KSE-ServerInfo: RTEXMBS03.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback

From: Max Chou <max.chou@realtek.com>

If insert an USB dongle which chip is not maintained in ic_id_table, it
will hit the NULL point accessed. Add a null point check to avoid the
Kernel Oops.

Fixes: b39910bb54d9 ("Bluetooth: Populate hci_set_hw_info for Intel and Realtek")
Reviewed-by: Alex Lu <alex_lu@realsil.com.cn>
Signed-off-by: Max Chou <max.chou@realtek.com>
---
 drivers/bluetooth/btrtl.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
index 83025f457ca0..d3eba0d4a57d 100644
--- a/drivers/bluetooth/btrtl.c
+++ b/drivers/bluetooth/btrtl.c
@@ -1351,12 +1351,14 @@ int btrtl_setup_realtek(struct hci_dev *hdev)
 
 	btrtl_set_quirks(hdev, btrtl_dev);
 
-	hci_set_hw_info(hdev,
+	if (btrtl_dev->ic_info) {
+		hci_set_hw_info(hdev,
 			"RTL lmp_subver=%u hci_rev=%u hci_ver=%u hci_bus=%u",
 			btrtl_dev->ic_info->lmp_subver,
 			btrtl_dev->ic_info->hci_rev,
 			btrtl_dev->ic_info->hci_ver,
 			btrtl_dev->ic_info->hci_bus);
+	}
 
 	btrtl_free(btrtl_dev);
 	return ret;
-- 
2.43.0

