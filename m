Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D6AE33B96B
	for <linux-bluetooth@vger.kernel.org>; Mon, 19 Jan 2026 10:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768818571; cv=none; b=t90crLdrMmmC/sIiEu8vVuKFXedlz+t14lv1ZzgW80Q+nFMUr0mo2iN1zYz/8uxaGcfQEsl+xJ9OPF+xMp0Vzzek2qVeFG0SHh13WINCYHp5T8SE6JFeuDWzLrG7JO71yNYL+zjisCgnxFLjTN9ufMuPvhcGXt9o86bIZ/99mk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768818571; c=relaxed/simple;
	bh=HvkGq825hwcwppDQHGtxpq2J2zeuU78yFEhNMGXLAQ4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C62EuuswGhoHF5dIVgI/z7MOh7ipSSgPNcnKpvOxv9/8MxGZcZNl30Ll/HkKllyZt+4NEw1dQxAM6JH14cvN5DTNpUODU6nJdWlSrNn/bE3KPsFHm7pWrIi6ZYm1U0A28NwvOEXjLsBIizGGBFolqVnpxmFji/wlS0jFgpsu7SA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6F89643B3B
	for <linux-bluetooth@vger.kernel.org>; Mon, 19 Jan 2026 10:29:20 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 1/3] Bluetooth: btmtksdio: Simplify dev_pm_ops usage
Date: Mon, 19 Jan 2026 11:27:40 +0100
Message-ID: <20260119102911.2465464-2-hadess@hadess.net>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260119102911.2465464-1-hadess@hadess.net>
References: <20260119102911.2465464-1-hadess@hadess.net>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddufeejfeefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeeurghsthhivghnucfpohgtvghrrgcuoehhrgguvghssheshhgruggvshhsrdhnvghtqeenucggtffrrghtthgvrhhnpeekteetgeettdehieduiedttdetffelleehtdejkeeluedvgfffvdevteetudfhkeenucfkphepvdgrtddumegvfeegmegvtgejfeemtghfvddtmegsrgegfeemrgeijeeimegtvdgufeemjegrheefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegvfeegmegvtgejfeemtghfvddtmegsrgegfeemrgeijeeimegtvdgufeemjegrheefpdhhvghlohepohhlihhmphhitgdpmhgrihhlfhhrohhmpehhrgguvghssheshhgruggvshhsrdhnvghtpdhqihgupeeihfekleeigeefueefuedpmhhouggvpehsmhhtphhouhhtpdhnsggprhgtphhtthhopedupdhrtghpthhtoheplhhinhhugidqsghluhgvthhoohhthhesvhhgvghrrdhkvghrnhgvlhdrohhrgh

This increases build coverage and allows to drop a few #ifdef's.

SET_SYSTEM_SLEEP_PM_OPS() and SET_RUNTIME_PM_OPS() become no-ops if
CONFIG_PM_SLEEP or CONFIG_PM are disabled.

Signed-off-by: Bastien Nocera <hadess@hadess.net>
---
 drivers/bluetooth/btmtksdio.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/drivers/bluetooth/btmtksdio.c b/drivers/bluetooth/btmtksdio.c
index fba3ab6d30a5..3f941081ae6b 100644
--- a/drivers/bluetooth/btmtksdio.c
+++ b/drivers/bluetooth/btmtksdio.c
@@ -1472,7 +1472,6 @@ static void btmtksdio_remove(struct sdio_func *func)
 	hci_free_dev(hdev);
 }
 
-#ifdef CONFIG_PM
 static int btmtksdio_runtime_suspend(struct device *dev)
 {
 	struct sdio_func *func = dev_to_sdio_func(dev);
@@ -1495,7 +1494,7 @@ static int btmtksdio_runtime_suspend(struct device *dev)
 	return err;
 }
 
-static int btmtksdio_system_suspend(struct device *dev)
+static int __maybe_unused btmtksdio_system_suspend(struct device *dev)
 {
 	struct sdio_func *func = dev_to_sdio_func(dev);
 	struct btmtksdio_dev *bdev;
@@ -1532,28 +1531,23 @@ static int btmtksdio_runtime_resume(struct device *dev)
 	return err;
 }
 
-static int btmtksdio_system_resume(struct device *dev)
+static int __maybe_unused btmtksdio_system_resume(struct device *dev)
 {
 	return btmtksdio_runtime_resume(dev);
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

