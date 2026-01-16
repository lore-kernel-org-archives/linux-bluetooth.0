Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB1E122FDE6
	for <linux-bluetooth@vger.kernel.org>; Fri, 16 Jan 2026 12:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768568302; cv=none; b=tGU/N5omYh5nYQOx0YwsYebEa6lvkQ7hIRvK3ZzKMRRncVkmePPbOfdAp1az4lw5OBA5Embr+9HV40Xomp7Y0VYBJkTSr2h8Uga1D7GYr0oCbUy4meu3+Aa5cbyMdXg2NXv0XfGKwuB2nUEiZtyfxnGp+bCs+hjDzPzVuZOm5dI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768568302; c=relaxed/simple;
	bh=a5cTWRME5JZXx3zSa48Hm+L9ZXjatFhq4iExKGbgQeE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OHmhqcaIkzIQNWExOxaDwHszt21kMshmKPe8KsouOcUyDsDbE3XPzP7vr7Ps9co+LCgMU3jkb52Jz3/jmrL+1LqOwVbUxe2czu3B2Uni7Y3+yyctvTUVRQAq0zENmvLv6kqqH4wQTbI4xPe0yUxStYM/v2gY4AGh7mziEE89rPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 39E31442B9
	for <linux-bluetooth@vger.kernel.org>; Fri, 16 Jan 2026 12:58:12 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/3] Bluetooth: btmtksdio: Simplify dev_pm_ops usage
Date: Fri, 16 Jan 2026 13:50:42 +0100
Message-ID: <20260116125803.598552-2-hadess@hadess.net>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduvdekleelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeeurghsthhivghnucfpohgtvghrrgcuoehhrgguvghssheshhgruggvshhsrdhnvghtqeenucggtffrrghtthgvrhhnpeekteetgeettdehieduiedttdetffelleehtdejkeeluedvgfffvdevteetudfhkeenucfkphepvdgrtddumegvfeegmegvtgejfeemtghfvddtmegsrgegfeemrgeijeeimegtvdgufeemjegrheefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegvfeegmegvtgejfeemtghfvddtmegsrgegfeemrgeijeeimegtvdgufeemjegrheefpdhhvghlohepohhlihhmphhitgdpmhgrihhlfhhrohhmpehhrgguvghssheshhgruggvshhsrdhnvghtpdhqihgupeeflefgfedugeegvdeuledpmhhouggvpehsmhhtphhouhhtpdhnsggprhgtphhtthhopedupdhrtghpthhtoheplhhinhhugidqsghluhgvthhoohhthhesvhhgvghrrdhkvghrnhgvlhdrohhrgh

This increases build coverage and allows to drop a few #ifdef's.

Signed-off-by: Bastien Nocera <hadess@hadess.net>
---
 drivers/bluetooth/btmtksdio.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/bluetooth/btmtksdio.c b/drivers/bluetooth/btmtksdio.c
index fba3ab6d30a5..ec17521d5b9f 100644
--- a/drivers/bluetooth/btmtksdio.c
+++ b/drivers/bluetooth/btmtksdio.c
@@ -1472,7 +1472,6 @@ static void btmtksdio_remove(struct sdio_func *func)
 	hci_free_dev(hdev);
 }
 
-#ifdef CONFIG_PM
 static int btmtksdio_runtime_suspend(struct device *dev)
 {
 	struct sdio_func *func = dev_to_sdio_func(dev);
@@ -1538,22 +1537,17 @@ static int btmtksdio_system_resume(struct device *dev)
 }
 
 static const struct dev_pm_ops btmtksdio_pm_ops = {
-	SYSTEM_SLEEP_PM_OPS(btmtksdio_system_suspend, btmtksdio_system_resume)
-	RUNTIME_PM_OPS(btmtksdio_runtime_suspend, btmtksdio_runtime_resume, NULL)
+	SET_SYSTEM_SLEEP_PM_OPS(btmtksdio_system_suspend, btmtksdio_system_resume)
+	SET_RUNTIME_PM_OPS(btmtksdio_runtime_suspend, btmtksdio_runtime_resume, NULL)
 };
 
-#define BTMTKSDIO_PM_OPS (&btmtksdio_pm_ops)
-#else	/* CONFIG_PM */
-#define BTMTKSDIO_PM_OPS NULL
-#endif	/* CONFIG_PM */
-
 static struct sdio_driver btmtksdio_driver = {
 	.name		= "btmtksdio",
 	.probe		= btmtksdio_probe,
 	.remove		= btmtksdio_remove,
 	.id_table	= btmtksdio_table,
 	.drv = {
-		.pm = BTMTKSDIO_PM_OPS,
+		.pm = &btmtksdio_pm_ops,
 	}
 };
 
-- 
2.52.0

