Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA2C22236E0
	for <linux-bluetooth@vger.kernel.org>; Fri, 16 Jan 2026 12:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768568313; cv=none; b=Jf/TGM7QWoECXoA57E41X+7UoRzAyBECADN35ozKZGNElfvDrSYSUodvKc2zaBHJZlfnGa4nh3y3ntfgzqXI2zDgH1uj9ISkIj3/cJfpR10IFLTTtU117pXMFXrg2Dda01o6vfXnzqC6U47lfguQZ16E6uMg+gadEDymmK3Z7Vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768568313; c=relaxed/simple;
	bh=SAYb7YSxG8LaPVFrVlBWms+9YMCKNP7EIb1K3TN6A6A=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=auT+AvrythxyEOA4BqXOSFGnQ2tzH7ZgMSmBlbKwpXTFYyK7noKFDropTTV7EDtxNKEhqtU9vzUoh0Kc0P5ZPCDTeew5+Re87MBQXz5hyHzbQQimq4bnbZ61YNPGBdk5sAVdTPvVhOrGhpG5kAoC/4xmO+cql3+WRI90+N4QJEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 719B8442EC
	for <linux-bluetooth@vger.kernel.org>; Fri, 16 Jan 2026 12:58:12 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/3] Bluetooth: btnxpuart: Remove unneeded CONFIG_PM ifdef
Date: Fri, 16 Jan 2026 13:50:43 +0100
Message-ID: <20260116125803.598552-3-hadess@hadess.net>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260116125803.598552-1-hadess@hadess.net>
References: <20260116125803.598552-1-hadess@hadess.net>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net
X-GND-State: clean
X-GND-Score: 0
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduvdekleelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeeurghsthhivghnucfpohgtvghrrgcuoehhrgguvghssheshhgruggvshhsrdhnvghtqeenucggtffrrghtthgvrhhnpeekteetgeettdehieduiedttdetffelleehtdejkeeluedvgfffvdevteetudfhkeenucfkphepvdgrtddumegvfeegmegvtgejfeemtghfvddtmegsrgegfeemrgeijeeimegtvdgufeemjegrheefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegvfeegmegvtgejfeemtghfvddtmegsrgegfeemrgeijeeimegtvdgufeemjegrheefpdhhvghlohepohhlihhmphhitgdpmhgrihhlfhhrohhmpehhrgguvghssheshhgruggvshhsrdhnvghtpdhqihgupeejudelueekgeegvdfgvedpmhhouggvpehsmhhtphhouhhtpdhnsggprhgtphhtthhopedupdhrtghpthhtoheplhhinhhugidqsghluhgvthhoohhthhesvhhgvghrrdhkvghrnhgvlhdrohhrgh

The functions are already disabled through the use of pm_ptr() when
CONFIG_PM is disabled, and won't be included in the final code if not
needed.

This increases build coverage and allows to drop an #ifdef.

Signed-off-by: Bastien Nocera <hadess@hadess.net>
---
 drivers/bluetooth/btnxpuart.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/bluetooth/btnxpuart.c b/drivers/bluetooth/btnxpuart.c
index 3b1e9224e965..13daa174aaaa 100644
--- a/drivers/bluetooth/btnxpuart.c
+++ b/drivers/bluetooth/btnxpuart.c
@@ -1947,7 +1947,6 @@ static void nxp_serdev_remove(struct serdev_device *serdev)
 	hci_free_dev(hdev);
 }
 
-#ifdef CONFIG_PM_SLEEP
 static int nxp_serdev_suspend(struct device *dev)
 {
 	struct btnxpuart_dev *nxpdev = dev_get_drvdata(dev);
@@ -1975,7 +1974,6 @@ static int nxp_serdev_resume(struct device *dev)
 	ps_control(psdata->hdev, PS_STATE_AWAKE);
 	return 0;
 }
-#endif
 
 #ifdef CONFIG_DEV_COREDUMP
 static void nxp_serdev_coredump(struct device *dev)
-- 
2.52.0

