Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9216620B34;
	Wed, 19 Jun 2024 12:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718799577; cv=none; b=qs2UQ8KIXc+h/h9+oObPGggY53yiIJ6uhAkn7hycDw888IlkgCM2oo/3PABStl8CESEFk1hcLk13565Iqtb8sc9T9qQ97Frq0o5BKNbZBqQndvCTUiKkAPWdnphtcw+hu6EzX9u7vx4GoCYOIS0QqAGLc05hlHxqD39HuX9pn9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718799577; c=relaxed/simple;
	bh=C19NRnBVmI5ItD3+g3/xEnxerKXG3ag9MUgJp67rJH4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=T5CL7oj+jJQtOVeXa7mLzYxJWKgO3XHBoQ/eskb2BdL6slnqmbzzWOc8uR5AClzeVHcRVKYLR3fMZ/kBMZt0NEdizA511CaKZtTDOmMvsX4gLgkeXlKeVXi+JIOn+rBB8hs4XvRu9sAAruo+hD0asBjIrfnHwTJxxEQs6oVRByU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 45JCJNVE01676424, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 45JCJNVE01676424
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Jun 2024 20:19:23 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 19 Jun 2024 20:19:23 +0800
Received: from localhost.localhost (172.21.132.53) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 19 Jun
 2024 20:19:22 +0800
From: Hilda Wu <hildawu@realtek.com>
To: <marcel@holtmann.org>
CC: <luiz.dentz@gmail.com>, <linux-bluetooth@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <alex_lu@realsil.com.cn>,
        <max.chou@realtek.com>, <kidman@realtek.com>
Subject: [PATCH v2] Bluetooth: btrtl: Set MSFT_EXT_ADDRESS_FILTER quirk for RTL8852B
Date: Wed, 19 Jun 2024 20:19:18 +0800
Message-ID: <20240619121918.3273270-1-hildawu@realtek.com>
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

Set HCI_QUIRK_USE_MSFT_EXT_ADDRESS_FILTER quirk for RTL8852B.

The quirk to support tracking multiple devices concurrently.
Commit 9e14606d8f38 ("Bluetooth: msft: Extended monitor tracking by
address filter")

With this setting, when a pattern monitor detects the device, this
feature issues an address monitor for tracking that device. Let
pattern monitor can keep monitor new devices.

Verified by Chromebook and Raspberry Pis.

Signed-off-by: Hilda Wu <hildawu@realtek.com>
---
Change in v2:
 - Add reference commit, commit description and verification devices.
---
---
 drivers/bluetooth/btrtl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
index f2f37143c454..baa0c6119b51 100644
--- a/drivers/bluetooth/btrtl.c
+++ b/drivers/bluetooth/btrtl.c
@@ -1297,6 +1297,7 @@ void btrtl_set_quirks(struct hci_dev *hdev, struct btrtl_device_info *btrtl_dev)
 			btrealtek_set_flag(hdev, REALTEK_ALT6_CONTINUOUS_TX_CHIP);
 
 		if (btrtl_dev->project_id == CHIP_ID_8852A ||
+		    btrtl_dev->project_id == CHIP_ID_8852B ||
 		    btrtl_dev->project_id == CHIP_ID_8852C)
 			set_bit(HCI_QUIRK_USE_MSFT_EXT_ADDRESS_FILTER, &hdev->quirks);
 
-- 
2.34.1

