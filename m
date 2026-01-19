Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B50E35B13C
	for <linux-bluetooth@vger.kernel.org>; Mon, 19 Jan 2026 12:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768826156; cv=none; b=nrEjvm4JHxNCCRHY76V1d+zuBqtOr5rkjtOweq8qaZ52zU//pJ6X12BLVp/qhLQlsTXhmo12IVWrTz18ABeGxeeRswBYjBpbQdVwToifmr6WrjGZq+EtOlzHNgDrHMcEqe3JJfyNt0WC/fehFSCB5SwuzYC6LUhZhulYHJttaTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768826156; c=relaxed/simple;
	bh=7ePBXAGx10mDF4aWMp3qHx9yDeBaVQhWyho9yO3REVU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q6DDB2SBnmyZ5NNTRtisIO3ANS7skeYr9niQ+Xwrp54oHLDMjBTCjUpODs7RbF69u8Shktt0kOzAez5bcsEbGS+PrvavuyBrMiuyhYgMZ67OQas1de3H9YoO4jjow4LrBs+0LJpg0iWWAbPj2+dCRscYPIZIwEA/qVhp6bSV7ZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2F1A2442BA
	for <linux-bluetooth@vger.kernel.org>; Mon, 19 Jan 2026 12:35:46 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 2/2] Bluetooth: btintel: Remove unneeded CONFIG_PM* #ifdef's
Date: Mon, 19 Jan 2026 13:35:00 +0100
Message-ID: <20260119123537.2611794-3-hadess@hadess.net>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddufeejheelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeeurghsthhivghnucfpohgtvghrrgcuoehhrgguvghssheshhgruggvshhsrdhnvghtqeenucggtffrrghtthgvrhhnpeekteetgeettdehieduiedttdetffelleehtdejkeeluedvgfffvdevteetudfhkeenucfkphepvdgrtddumegvfeegmegvtgejfeemtghfvddtmegsrgegfeemrgeijeeimegtvdgufeemjegrheefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegvfeegmegvtgejfeemtghfvddtmegsrgegfeemrgeijeeimegtvdgufeemjegrheefpdhhvghlohepohhlihhmphhitgdpmhgrihhlfhhrohhmpehhrgguvghssheshhgruggvshhsrdhnvghtpdhqihgupedvhfdutedvgeegvdeutedpmhhouggvpehsmhhtphhouhhtpdhnsggprhgtphhtthhopedupdhrtghpthhtoheplhhinhhugidqsghluhgvthhoohhthhesvhhgvghrrdhkvghrnhgvlhdrohhrgh

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

