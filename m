Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF55126AC1
	for <linux-bluetooth@vger.kernel.org>; Thu, 12 Sep 2024 03:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726110182; cv=none; b=CkpgzyAPXz5QUuLyLt9ZWPJY0xh9dMSfBrCbUZOzCGtyailS67HOyzswtSGI7g7Ij9zSraIUGO8koudjHTsGNxBqKK8kZoZwdrUpoqy/pZNrvHxl9GywZAOfHnlCCmMBVwLamRyK4ky/AIYJ8qMCP/eRYANzI49EGHwjn+WF/Fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726110182; c=relaxed/simple;
	bh=RbKiL6QDC2rOJOUAavmz6vKkUjxvP14tISZqVSG/4uQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=g9x2wg6XqHW0L5FkwrdRBLi356xC73Ed3BQYdTfWxzdiv5422g3B9knXMfx6kDpN+3Nf26ZTZQThaq6EtCH6soTJOG9xteLBUtzUiB09QHZDL5E3uHgzGZOJafWvDRjsh3vnMcTP5Yeu1yMc60rGsigucFkdHUtTGQ4TM2gkl9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4X42Kb554QzyRqy;
	Thu, 12 Sep 2024 11:02:11 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id 2E0DB18010B;
	Thu, 12 Sep 2024 11:02:58 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemh500013.china.huawei.com
 (7.202.181.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 12 Sep
 2024 11:02:57 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <marcel@holtmann.org>, <luiz.dentz@gmail.com>, <akarwar@marvell.com>,
	<huxm@marvell.com>, <linux-bluetooth@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH] Bluetooth: btmrvl: Use IRQF_NO_AUTOEN flag in request_irq()
Date: Thu, 12 Sep 2024 11:12:04 +0800
Message-ID: <20240912031204.2211567-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemh500013.china.huawei.com (7.202.181.146)

disable_irq() after request_irq() still has a time gap in which
interrupts can come. request_irq() with IRQF_NO_AUTOEN flag will
disable IRQ auto-enable when request IRQ.

Fixes: bb7f4f0bcee6 ("btmrvl: add platform specific wakeup interrupt support")
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 drivers/bluetooth/btmrvl_sdio.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/bluetooth/btmrvl_sdio.c b/drivers/bluetooth/btmrvl_sdio.c
index 85b7f2bb4259..07cd308f7abf 100644
--- a/drivers/bluetooth/btmrvl_sdio.c
+++ b/drivers/bluetooth/btmrvl_sdio.c
@@ -92,7 +92,7 @@ static int btmrvl_sdio_probe_of(struct device *dev,
 		} else {
 			ret = devm_request_irq(dev, cfg->irq_bt,
 					       btmrvl_wake_irq_bt,
-					       0, "bt_wake", card);
+					       IRQF_NO_AUTOEN, "bt_wake", card);
 			if (ret) {
 				dev_err(dev,
 					"Failed to request irq_bt %d (%d)\n",
@@ -101,7 +101,6 @@ static int btmrvl_sdio_probe_of(struct device *dev,
 
 			/* Configure wakeup (enabled by default) */
 			device_init_wakeup(dev, true);
-			disable_irq(cfg->irq_bt);
 		}
 	}
 
-- 
2.34.1

