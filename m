Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B62435B149
	for <linux-bluetooth@vger.kernel.org>; Mon, 19 Jan 2026 12:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768826157; cv=none; b=rUx0DnbbbBtTC5p3USKUctXIpMYp2RbQqTcLXxstC5Q1O1/eaaI3VyYG7AnWoEvNRVEfbG7rKNQkCUfX3Sljyo7Zj64B0MKL5ZQAiPdc8pqCNPu1FmzlOgeCKOic/xkYSO7jVMxHL5vL4rUB39ZEG/RU13popWK0/PEaM+0hLfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768826157; c=relaxed/simple;
	bh=er9XHFZJG9ZM03ugVigNLCcB/1uvFwguJUo1y3KB+ds=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bCcEvISA0xt68EkPclBhDWM44SJUKc7NJKfU5BrHZDSg9Y4Z17VoqPiyK2SAOAi2JAiVzZiB8w2mr95kiZFRS9RB97QxlkwJt7cAPlOAE/mflZmZxtx9L5fjRoHvqPFxmqrbWuzbc6eX58JHOPpaTYa4vC6XqQ7QTiO6oOZHfUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id E8C4E442B9
	for <linux-bluetooth@vger.kernel.org>; Mon, 19 Jan 2026 12:35:45 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 1/2] Bluetooth: btnxpuart: Remove unneeded CONFIG_PM ifdef
Date: Mon, 19 Jan 2026 13:34:59 +0100
Message-ID: <20260119123537.2611794-2-hadess@hadess.net>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260119123537.2611794-1-hadess@hadess.net>
References: <20260119123537.2611794-1-hadess@hadess.net>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddufeejheelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeeurghsthhivghnucfpohgtvghrrgcuoehhrgguvghssheshhgruggvshhsrdhnvghtqeenucggtffrrghtthgvrhhnpeekteetgeettdehieduiedttdetffelleehtdejkeeluedvgfffvdevteetudfhkeenucfkphepvdgrtddumegvfeegmegvtgejfeemtghfvddtmegsrgegfeemrgeijeeimegtvdgufeemjegrheefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegvfeegmegvtgejfeemtghfvddtmegsrgegfeemrgeijeeimegtvdgufeemjegrheefpdhhvghlohepohhlihhmphhitgdpmhgrihhlfhhrohhmpehhrgguvghssheshhgruggvshhsrdhnvghtpdhqihgupefgkeevgefggeegvdeuledpmhhouggvpehsmhhtphhouhhtpdhnsggprhgtphhtthhopedupdhrtghpthhtoheplhhinhhugidqsghluhgvthhoohhthhesvhhgvghrrdhkvghrnhgvlhdrohhrgh

The functions are already disabled through the use of pm_ptr() when
CONFIG_PM is disabled, and will be removed from the final linked code
as not needed.

This increases build coverage and allows to drop an #ifdef.

Signed-off-by: Bastien Nocera <hadess@hadess.net>
---
 drivers/bluetooth/btnxpuart.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/bluetooth/btnxpuart.c b/drivers/bluetooth/btnxpuart.c
index 3b1e9224e965..e7036a48ce48 100644
--- a/drivers/bluetooth/btnxpuart.c
+++ b/drivers/bluetooth/btnxpuart.c
@@ -1947,8 +1947,7 @@ static void nxp_serdev_remove(struct serdev_device *serdev)
 	hci_free_dev(hdev);
 }
 
-#ifdef CONFIG_PM_SLEEP
-static int nxp_serdev_suspend(struct device *dev)
+static int __maybe_unused nxp_serdev_suspend(struct device *dev)
 {
 	struct btnxpuart_dev *nxpdev = dev_get_drvdata(dev);
 	struct ps_data *psdata = &nxpdev->psdata;
@@ -1962,7 +1961,7 @@ static int nxp_serdev_suspend(struct device *dev)
 	return 0;
 }
 
-static int nxp_serdev_resume(struct device *dev)
+static int __maybe_unused nxp_serdev_resume(struct device *dev)
 {
 	struct btnxpuart_dev *nxpdev = dev_get_drvdata(dev);
 	struct ps_data *psdata = &nxpdev->psdata;
@@ -1975,7 +1974,6 @@ static int nxp_serdev_resume(struct device *dev)
 	ps_control(psdata->hdev, PS_STATE_AWAKE);
 	return 0;
 }
-#endif
 
 #ifdef CONFIG_DEV_COREDUMP
 static void nxp_serdev_coredump(struct device *dev)
-- 
2.52.0

