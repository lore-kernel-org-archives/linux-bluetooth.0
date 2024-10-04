Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37BA5146A93
	for <linux-bluetooth@vger.kernel.org>; Fri,  4 Oct 2024 09:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728034877; cv=none; b=PopFHxE+PjiENQazoj1e5jZXpM0dAPOilVaOR4hKet3AZXBpK7aZw4DI8bI6ZFDv+Fdm58Ax8aDwc/KsGQqUS3ziRp5+5mzXcjTb/myKLFDRnx3wxYnBNGtRQOELdh5EkIsOMjU7jaCpQN+/RrBeQNJs8c8QiPgBqZipQm+GiKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728034877; c=relaxed/simple;
	bh=EM9zumFJoOST7/SdF92c8Bupz5WHsR5wTo/sOmN4jPs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pJDFO4yCstjHoCKXfa7rVorQnhduMmBS6+ypMdUxj28880tXwrZduj++zSzuJmScNdRZohBcl8C6ucaSL87gWG2V1jxJtnwd3kTt0wyYpXbaQbQ/w814kX++7SVrTKlYRVC5F4D0PBvAQqogGQPh3ryvyh1/YuEyCbZolq0PsJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FX3itCda; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FX3itCda"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728034875; x=1759570875;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EM9zumFJoOST7/SdF92c8Bupz5WHsR5wTo/sOmN4jPs=;
  b=FX3itCdaYe+eoPAtksPhhExZr5WRaGk2syhJ5jN6hVv3APbQjDtgGGIS
   vzS8qoGdw2AMy4buFN2GwpCtQnHV98o81GcuA1WYfplivf6AQ01iU1RwZ
   2wGSkADuRQjcRyANoL9rjbhIOvKzsY0eXPtRtZfblTZcTDO11URBBbsc1
   tsv/RixQhbXppNI0VHkGkK6fXR4InUp/Olo1k2ipvjf5BidEIg8hcsiiP
   zGE1Su6FA+u1ImjQ+ZHZoiY5B1jV+C6Dsy5VyalWRPQJLdOWyD6yVaY0V
   ZJH62V5w2HyOJrydOMdYOiF9OwA5NDkIG7V26Go6N0MDWC5tMCzZ1EHvi
   A==;
X-CSE-ConnectionGUID: bXqhK02LT4O0qRl5td9mYw==
X-CSE-MsgGUID: lkDZ4ipgQgCNGQZl7Kd/Og==
X-IronPort-AV: E=McAfee;i="6700,10204,11214"; a="37856169"
X-IronPort-AV: E=Sophos;i="6.11,177,1725346800"; 
   d="scan'208";a="37856169"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2024 02:41:15 -0700
X-CSE-ConnectionGUID: FLKxLKHcTfOkzzbVxclGcQ==
X-CSE-MsgGUID: pCruQFirRMi81vZQqe92MA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,177,1725346800"; 
   d="scan'208";a="74331916"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2024 02:41:13 -0700
Received: from punajuuri.localdomain (punajuuri.localdomain [192.168.240.130])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id A55E511FA28;
	Fri,  4 Oct 2024 12:41:11 +0300 (EEST)
Received: from sailus by punajuuri.localdomain with local (Exim 4.96)
	(envelope-from <sakari.ailus@linux.intel.com>)
	id 1sweoB-000TV1-27;
	Fri, 04 Oct 2024 12:41:11 +0300
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: [PATCH 02/51] bluetooth: Switch to __pm_runtime_put_autosuspend()
Date: Fri,  4 Oct 2024 12:41:11 +0300
Message-Id: <20241004094111.113385-1-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241004094101.113349-1-sakari.ailus@linux.intel.com>
References: <20241004094101.113349-1-sakari.ailus@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pm_runtime_put_autosuspend() will soon be changed to include a call to
pm_runtime_mark_last_busy(). This patch switches the current users to
__pm_runtime_put_autosuspend() which will continue to have the
functionality of old pm_runtime_put_autosuspend().

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/bluetooth/btmtksdio.c | 2 +-
 drivers/bluetooth/hci_bcm.c   | 6 +++---
 drivers/bluetooth/hci_h5.c    | 4 ++--
 drivers/bluetooth/hci_intel.c | 6 +++---
 4 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/bluetooth/btmtksdio.c b/drivers/bluetooth/btmtksdio.c
index cc097aedc1e1..a3bab78a5b1b 100644
--- a/drivers/bluetooth/btmtksdio.c
+++ b/drivers/bluetooth/btmtksdio.c
@@ -615,7 +615,7 @@ static void btmtksdio_txrx_work(struct work_struct *work)
 	sdio_release_host(bdev->func);
 
 	pm_runtime_mark_last_busy(bdev->dev);
-	pm_runtime_put_autosuspend(bdev->dev);
+	__pm_runtime_put_autosuspend(bdev->dev);
 }
 
 static void btmtksdio_interrupt(struct sdio_func *func)
diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index 89d4c2224546..5e3760c475b4 100644
--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -327,7 +327,7 @@ static irqreturn_t bcm_host_wake(int irq, void *data)
 
 	pm_runtime_get(bdev->dev);
 	pm_runtime_mark_last_busy(bdev->dev);
-	pm_runtime_put_autosuspend(bdev->dev);
+	__pm_runtime_put_autosuspend(bdev->dev);
 
 	return IRQ_HANDLED;
 }
@@ -711,7 +711,7 @@ static int bcm_recv(struct hci_uart *hu, const void *data, int count)
 		if (bcm->dev && bcm_device_exists(bcm->dev)) {
 			pm_runtime_get(bcm->dev->dev);
 			pm_runtime_mark_last_busy(bcm->dev->dev);
-			pm_runtime_put_autosuspend(bcm->dev->dev);
+			__pm_runtime_put_autosuspend(bcm->dev->dev);
 		}
 		mutex_unlock(&bcm_device_lock);
 	}
@@ -750,7 +750,7 @@ static struct sk_buff *bcm_dequeue(struct hci_uart *hu)
 
 	if (bdev) {
 		pm_runtime_mark_last_busy(bdev->dev);
-		pm_runtime_put_autosuspend(bdev->dev);
+		__pm_runtime_put_autosuspend(bdev->dev);
 	}
 
 	mutex_unlock(&bcm_device_lock);
diff --git a/drivers/bluetooth/hci_h5.c b/drivers/bluetooth/hci_h5.c
index c0436881a533..4b1c978c57e7 100644
--- a/drivers/bluetooth/hci_h5.c
+++ b/drivers/bluetooth/hci_h5.c
@@ -593,7 +593,7 @@ static int h5_recv(struct hci_uart *hu, const void *data, int count)
 	if (hu->serdev) {
 		pm_runtime_get(&hu->serdev->dev);
 		pm_runtime_mark_last_busy(&hu->serdev->dev);
-		pm_runtime_put_autosuspend(&hu->serdev->dev);
+		__pm_runtime_put_autosuspend(&hu->serdev->dev);
 	}
 
 	return 0;
@@ -635,7 +635,7 @@ static int h5_enqueue(struct hci_uart *hu, struct sk_buff *skb)
 	if (hu->serdev) {
 		pm_runtime_get_sync(&hu->serdev->dev);
 		pm_runtime_mark_last_busy(&hu->serdev->dev);
-		pm_runtime_put_autosuspend(&hu->serdev->dev);
+		__pm_runtime_put_autosuspend(&hu->serdev->dev);
 	}
 
 	return 0;
diff --git a/drivers/bluetooth/hci_intel.c b/drivers/bluetooth/hci_intel.c
index 999ccd5bb4f2..373813717130 100644
--- a/drivers/bluetooth/hci_intel.c
+++ b/drivers/bluetooth/hci_intel.c
@@ -281,7 +281,7 @@ static irqreturn_t intel_irq(int irq, void *dev_id)
 	/* Host/Controller are now LPM resumed, trigger a new delayed suspend */
 	pm_runtime_get(&idev->pdev->dev);
 	pm_runtime_mark_last_busy(&idev->pdev->dev);
-	pm_runtime_put_autosuspend(&idev->pdev->dev);
+	__pm_runtime_put_autosuspend(&idev->pdev->dev);
 
 	return IRQ_HANDLED;
 }
@@ -372,7 +372,7 @@ static void intel_busy_work(struct work_struct *work)
 		if (intel->hu->tty->dev->parent == idev->pdev->dev.parent) {
 			pm_runtime_get(&idev->pdev->dev);
 			pm_runtime_mark_last_busy(&idev->pdev->dev);
-			pm_runtime_put_autosuspend(&idev->pdev->dev);
+			__pm_runtime_put_autosuspend(&idev->pdev->dev);
 			break;
 		}
 	}
@@ -1004,7 +1004,7 @@ static int intel_enqueue(struct hci_uart *hu, struct sk_buff *skb)
 		if (hu->tty->dev->parent == idev->pdev->dev.parent) {
 			pm_runtime_get_sync(&idev->pdev->dev);
 			pm_runtime_mark_last_busy(&idev->pdev->dev);
-			pm_runtime_put_autosuspend(&idev->pdev->dev);
+			__pm_runtime_put_autosuspend(&idev->pdev->dev);
 			break;
 		}
 	}
-- 
2.39.5

