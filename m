Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9FF51E5708;
	Fri,  8 Nov 2024 15:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731080041; cv=none; b=NRMtwnMEzTlsEtuWuBIu1Lrqqat+UWwrWzWRrijLUcEZO1jWuA3ZqtGqJLK/omzfQmTgoUSoP6KWoOpptIR2BKA4WDC92//gxC7/pX5wLn//NVCm5IsKuT4HWiKyIxQdmvCWhMgiGUbiGJzsHD/lbvrfflAQXItOe9yEZyqg/HA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731080041; c=relaxed/simple;
	bh=1/fCInMFBmHHR3za66V/ZX+QZXbhM4wb/26mnQ6YU9o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rt+GTl+XsJFmaYrCleJgZa8DhNWsqlTDNv0mhDCNtwzqTKVFiLzhn5LhLIqOql1+u+PgBafDZxCUeEpMDh6RrkRa8FdoRb+SxeoI1Y3JbR1jXhxXRb/Bu9wXdZc802cRqRQz0ebNELnBcrf8YU3bPE0wUa9Yphx4DZ1HDM6rG3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S9iKwsrl; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S9iKwsrl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731080040; x=1762616040;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=1/fCInMFBmHHR3za66V/ZX+QZXbhM4wb/26mnQ6YU9o=;
  b=S9iKwsrlgc20vWl+6Y31mKSDTtIcntkVMSBImh7WDhSR/F08gLaaBdLC
   F/SenWijZfuRDL+cIvrzL9p3FAizeTRt9in8oX7aRzqTBgR5ZqjyHlOhq
   7TcM21SkU61YyVHY3zl2YF0ToibaIgF2Mr5HP9MiLt0SPEIuz0k1botkX
   cem4EKnuwk4KfsWOWARIdrIyFFP/CaXNYkaqQ5byrtUgBRStvER5qKjNT
   oDIg7jptmYAL7kzMnNsjZGNEeDo15Rz3ZrKPTrjSn2bt5PgF+kpdoW0Xn
   fUq9RLiREs1k8+emskQksljN/hFBc9THWDRQ4PBENidwsAX7YBHFwdi2O
   A==;
X-CSE-ConnectionGUID: H+hWecOCSDSXjiXxK9vXkQ==
X-CSE-MsgGUID: u+3QfJHiQXOcBumbyGBK9w==
X-IronPort-AV: E=McAfee;i="6700,10204,11250"; a="42353850"
X-IronPort-AV: E=Sophos;i="6.12,138,1728975600"; 
   d="scan'208";a="42353850"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2024 07:33:59 -0800
X-CSE-ConnectionGUID: yIQdoykWRhiGZvhtJ6HFRg==
X-CSE-MsgGUID: clZMkSQoSQmgc45Ix65DIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,138,1728975600"; 
   d="scan'208";a="85592470"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa010.jf.intel.com with ESMTP; 08 Nov 2024 07:33:58 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 235D920F; Fri, 08 Nov 2024 17:33:56 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] Bluetooth: hci_bcm: Use the devm_clk_get_optional() helper
Date: Fri,  8 Nov 2024 17:33:49 +0200
Message-ID: <20241108153349.1589499-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use devm_clk_get_optional() instead of hand writing it.
This saves some LoC and improves the semantic.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/bluetooth/hci_bcm.c | 25 ++++++++-----------------
 1 file changed, 8 insertions(+), 17 deletions(-)

diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index 89d4c2224546..521b785f2908 100644
--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -1068,17 +1068,17 @@ static struct clk *bcm_get_txco(struct device *dev)
 	struct clk *clk;
 
 	/* New explicit name */
-	clk = devm_clk_get(dev, "txco");
-	if (!IS_ERR(clk) || PTR_ERR(clk) == -EPROBE_DEFER)
+	clk = devm_clk_get_optional(dev, "txco");
+	if (clk)
 		return clk;
 
 	/* Deprecated name */
-	clk = devm_clk_get(dev, "extclk");
-	if (!IS_ERR(clk) || PTR_ERR(clk) == -EPROBE_DEFER)
+	clk = devm_clk_get_optional(dev, "extclk");
+	if (clk)
 		return clk;
 
 	/* Original code used no name at all */
-	return devm_clk_get(dev, NULL);
+	return devm_clk_get_optional(dev, NULL);
 }
 
 static int bcm_get_resources(struct bcm_device *dev)
@@ -1093,21 +1093,12 @@ static int bcm_get_resources(struct bcm_device *dev)
 		return 0;
 
 	dev->txco_clk = bcm_get_txco(dev->dev);
-
-	/* Handle deferred probing */
-	if (dev->txco_clk == ERR_PTR(-EPROBE_DEFER))
+	if (IS_ERR(dev->txco_clk))
 		return PTR_ERR(dev->txco_clk);
 
-	/* Ignore all other errors as before */
-	if (IS_ERR(dev->txco_clk))
-		dev->txco_clk = NULL;
-
-	dev->lpo_clk = devm_clk_get(dev->dev, "lpo");
-	if (dev->lpo_clk == ERR_PTR(-EPROBE_DEFER))
-		return PTR_ERR(dev->lpo_clk);
-
+	dev->lpo_clk = devm_clk_get_optional(dev->dev, "lpo");
 	if (IS_ERR(dev->lpo_clk))
-		dev->lpo_clk = NULL;
+		return PTR_ERR(dev->lpo_clk);
 
 	/* Check if we accidentally fetched the lpo clock twice */
 	if (dev->lpo_clk && clk_is_match(dev->lpo_clk, dev->txco_clk)) {
-- 
2.43.0.rc1.1336.g36b5255a03ac

