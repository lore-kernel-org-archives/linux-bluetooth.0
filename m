Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA354354AC0
	for <linux-bluetooth@vger.kernel.org>; Mon, 19 Jan 2026 10:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768818570; cv=none; b=uhDspcUNOpnEN+dyoZo7o0EPgwtOhIkuw+K8Y38lAdzwAWx6h3uS1xUIYLTQx4hIBMh+PlMkcM+d2Nnanehv/PdsBojzQ18oLGDcrQXFwcbiiqfSDgbH30SOcVsacAS9sJtB7bguLKUzZxayfdOJ+aC5S7rA16W1fCs/1VLsYnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768818570; c=relaxed/simple;
	bh=7ePBXAGx10mDF4aWMp3qHx9yDeBaVQhWyho9yO3REVU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ir1TFeGPgj2g3xUGBP43NwVWT9TuM+XUXHzxdHV1SImIc3Rpr93+cAzBZcMQ3UItVYM8VrU4gxfs6EahVo/TUUv7Ms83a8zpwFvTNlid16FnrM8n36f0SYCXFQAsk0p9RpgPvPyFzRvTnx9xv76g+a8WUDJ+TvPDlqbkUHEfgoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id DC14243B3C
	for <linux-bluetooth@vger.kernel.org>; Mon, 19 Jan 2026 10:29:20 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 3/3] Bluetooth: btintel: Remove unneeded CONFIG_PM* #ifdef's
Date: Mon, 19 Jan 2026 11:27:42 +0100
Message-ID: <20260119102911.2465464-4-hadess@hadess.net>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddufeejfeefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeeurghsthhivghnucfpohgtvghrrgcuoehhrgguvghssheshhgruggvshhsrdhnvghtqeenucggtffrrghtthgvrhhnpeekteetgeettdehieduiedttdetffelleehtdejkeeluedvgfffvdevteetudfhkeenucfkphepvdgrtddumegvfeegmegvtgejfeemtghfvddtmegsrgegfeemrgeijeeimegtvdgufeemjegrheefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegvfeegmegvtgejfeemtghfvddtmegsrgegfeemrgeijeeimegtvdgufeemjegrheefpdhhvghlohepohhlihhmphhitgdpmhgrihhlfhhrohhmpehhrgguvghssheshhgruggvshhsrdhnvghtpdhqihgupeffvedugedvgeefueefvedpmhhouggvpehsmhhtphhouhhtpdhnsggprhgtphhtthhopedupdhrtghpthhtoheplhhinhhugidqsghluhgvthhoohhthhesvhhgvghrrdhkvghrnhgvlhdrohhrgh

The functions are already disabled if CONFIG_PM or CONFIG_PM_SLEEP are
disabled through the use of SET_SYSTEM_SLEEP_PM_OPS() and
SET_RUNTIME_PM_OPS().

This increases build coverage and allows to drop a few #ifdef's.

Signed-off-by: Bastien Nocera <hadess@hadess.net>
---
 drivers/bluetooth/hci_intel.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/bluetooth/hci_intel.c b/drivers/bluetooth/hci_intel.c
index 20baf2895dec..f7570c2eaa46 100644
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
@@ -1090,10 +1087,8 @@ static int intel_resume_device(struct device *dev)
 
 	return 0;
 }
-#endif
 
-#ifdef CONFIG_PM_SLEEP
-static int intel_suspend(struct device *dev)
+static int __maybe_unused intel_suspend(struct device *dev)
 {
 	struct intel_device *idev = dev_get_drvdata(dev);
 
@@ -1103,7 +1098,7 @@ static int intel_suspend(struct device *dev)
 	return intel_suspend_device(dev);
 }
 
-static int intel_resume(struct device *dev)
+static int __maybe_unused intel_resume(struct device *dev)
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

