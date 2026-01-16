Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE49233D9E
	for <linux-bluetooth@vger.kernel.org>; Fri, 16 Jan 2026 12:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768568302; cv=none; b=agm2bTnwLDqOLNmuLsVXEIcPmRQyC5Aen0f4QtzNHFhWN803Rm7rfq1vfvsJnRIpenQlvhVMr+OCJnHCGnvlS/QJnA3UVcQPoIWEut6YSR0bcEO3uv74amaGRuV4DeSY+TBvvQcYalWf++0cP+njIPwrBPaq89bvMnFuX6QTKDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768568302; c=relaxed/simple;
	bh=HtJO0WVruMZ2gWYRhK+6roHzPX33cEPrK19IlY5+D6Y=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jHpfgfQ8CeI2BQJJwysIBCEWPnhnIZ5IgZkvf4QSKidjnvlyeJHQ1s7FbW7rsXXlf39u0X3X/WS4FE+FogpOLxj0gpLMBO6K3KcPEXFwV8Op8gKohY/OVgH386jWYMGgvwDfdvlJhEEtZDnVxO4Z/Cx0Uw28V1ul+p2Z4UpwDjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9F280442F8
	for <linux-bluetooth@vger.kernel.org>; Fri, 16 Jan 2026 12:58:12 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/3] Bluetooth: btintel: Remove unneeded CONFIG_PM* #ifdef's
Date: Fri, 16 Jan 2026 13:50:44 +0100
Message-ID: <20260116125803.598552-4-hadess@hadess.net>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduvdekleelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeeurghsthhivghnucfpohgtvghrrgcuoehhrgguvghssheshhgruggvshhsrdhnvghtqeenucggtffrrghtthgvrhhnpeekteetgeettdehieduiedttdetffelleehtdejkeeluedvgfffvdevteetudfhkeenucfkphepvdgrtddumegvfeegmegvtgejfeemtghfvddtmegsrgegfeemrgeijeeimegtvdgufeemjegrheefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegvfeegmegvtgejfeemtghfvddtmegsrgegfeemrgeijeeimegtvdgufeemjegrheefpdhhvghlohepohhlihhmphhitgdpmhgrihhlfhhrohhmpehhrgguvghssheshhgruggvshhsrdhnvghtpdhqihgupeelhfdvkedtgeegvdfhkedpmhhouggvpehsmhhtphhouhhtpdhnsggprhgtphhtthhopedupdhrtghpthhtoheplhhinhhugidqsghluhgvthhoohhthhesvhhgvghrrdhkvghrnhgvlhdrohhrgh

The functions are already disabled if CONFIG_PM or CONFIG_PM_SLEEP are
disabled through the use of SET_SYSTEM_SLEEP_PM_OPS() and
SET_RUNTIME_PM_OPS().

This increases build coverage and allows to drop a few #ifdef's.

Signed-off-by: Bastien Nocera <hadess@hadess.net>
---
 drivers/bluetooth/hci_intel.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/bluetooth/hci_intel.c b/drivers/bluetooth/hci_intel.c
index 20baf2895dec..52dca7520fa0 100644
--- a/drivers/bluetooth/hci_intel.c
+++ b/drivers/bluetooth/hci_intel.c
@@ -126,7 +126,6 @@ static int intel_wait_booting(struct hci_uart *hu)
 	return err;
 }
 
-#ifdef CONFIG_PM
 static int intel_wait_lpm_transaction(struct hci_uart *hu)
 {
 	struct intel_data *intel = hu->priv;
@@ -237,7 +236,6 @@ static int intel_lpm_resume(struct hci_uart *hu)
 
 	return 0;
 }
-#endif /* CONFIG_PM */
 
 static int intel_lpm_host_wake(struct hci_uart *hu)
 {
@@ -1066,7 +1064,6 @@ static const struct acpi_device_id intel_acpi_match[] = {
 MODULE_DEVICE_TABLE(acpi, intel_acpi_match);
 #endif
 
-#ifdef CONFIG_PM
 static int intel_suspend_device(struct device *dev)
 {
 	struct intel_device *idev = dev_get_drvdata(dev);
@@ -1090,9 +1087,7 @@ static int intel_resume_device(struct device *dev)
 
 	return 0;
 }
-#endif
 
-#ifdef CONFIG_PM_SLEEP
 static int intel_suspend(struct device *dev)
 {
 	struct intel_device *idev = dev_get_drvdata(dev);
@@ -1112,7 +1107,6 @@ static int intel_resume(struct device *dev)
 
 	return intel_resume_device(dev);
 }
-#endif
 
 static const struct dev_pm_ops intel_pm_ops = {
 	SET_SYSTEM_SLEEP_PM_OPS(intel_suspend, intel_resume)
-- 
2.52.0

