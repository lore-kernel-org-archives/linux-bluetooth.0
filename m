Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D0AF288C32;
	Fri,  4 Jul 2025 07:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751615644; cv=none; b=O87kaozHsZE6mTLVPozUaGtqi156lVtvMgkJFw5myDh+vCaGvcFds6XhwVKaXwrb0xqyV8rVpiwmFpXMD1IqI3SDsUf6njhxUCE2FJalplwCmChokkJeP90F/BLdAlUdojW34yMwEFuofLnMtVM5OqDemoZddOTW36Ubwubs7s4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751615644; c=relaxed/simple;
	bh=CWpHJt0mAGlZmpQFo1TAIOu+B6eRgVjwmndVF9RzlEU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZdzRK6JtT6rW2kAxzK179hWb3zA2ugfTe7u2Thoz5U0CY3T3CiR0l8pAFB4mMebFlj5pqgQEQdhx/ukKzu6WXbqR7NXdwQ75wJYHm7zVMgkWpLxVhtU0XwcfvxKYaKM1rsQwAbWm/tyBgdayHqGHc4TFucrMbx9hCiUFFoAlv0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UoJSx5gn; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UoJSx5gn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751615643; x=1783151643;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CWpHJt0mAGlZmpQFo1TAIOu+B6eRgVjwmndVF9RzlEU=;
  b=UoJSx5gn4DLSS6OE0AcrJwjNMmRSFf9BnqCDbi6SxXl4KpWFAh2iEsgG
   o0VdAAvqQK6CmA37K/7z4wl2pkA8KZrb9KW0C4uj4prFb6q4H4oWItx2V
   kFhs1O1Ixf6cTAJQguCBg5KhP93yZKXmmDNHEuIV1/VBlMZNlEDeUFDq2
   +7o25/6hetRz//K5CkSTqy0BfFPNVfINtmAZcHBlMzoNXRkw2u/QwogAB
   lFoVjTTnMgK372geXbULU5dGzpBWemUguj1gNj9o0W3LGsv96mgXKvfYp
   QlOjolNq9NC8PfzcSsEuAk9KzT2dJTMvJxYvyz+wzxEoCShc/Vx++qPLq
   g==;
X-CSE-ConnectionGUID: GyoexHqiRd+ShRk4gGZUjw==
X-CSE-MsgGUID: yUgqgsLfTWmLaO+YHR3HNA==
X-IronPort-AV: E=McAfee;i="6800,10657,11483"; a="76494452"
X-IronPort-AV: E=Sophos;i="6.16,286,1744095600"; 
   d="scan'208";a="76494452"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2025 00:54:02 -0700
X-CSE-ConnectionGUID: uzep9yVhRC2bPONuEIo4wQ==
X-CSE-MsgGUID: XbAEsj6mSMenUt/c5Hz3CQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,286,1744095600"; 
   d="scan'208";a="158924157"
Received: from jkrzyszt-mobl2.ger.corp.intel.com (HELO svinhufvud.fi.intel.com) ([10.245.244.244])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2025 00:54:00 -0700
Received: from svinhufvud.lan (localhost [IPv6:::1])
	by svinhufvud.fi.intel.com (Postfix) with ESMTP id 648B844424;
	Fri,  4 Jul 2025 10:53:58 +0300 (EEST)
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH 03/80] Bluetooth: Remove redundant pm_runtime_mark_last_busy() calls
Date: Fri,  4 Jul 2025 10:53:58 +0300
Message-Id: <20250704075358.3216833-1-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250704075225.3212486-1-sakari.ailus@linux.intel.com>
References: <20250704075225.3212486-1-sakari.ailus@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pm_runtime_put_autosuspend(), pm_runtime_put_sync_autosuspend(),
pm_runtime_autosuspend() and pm_request_autosuspend() now include a call
to pm_runtime_mark_last_busy(). Remove the now-reduntant explicit call to
pm_runtime_mark_last_busy().

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
The cover letter of the set can be found here
<URL:https://lore.kernel.org/linux-pm/20250704075225.3212486-1-sakari.ailus@linux.intel.com>.

In brief, this patch depends on PM runtime patches adding marking the last
busy timestamp in autosuspend related functions. The patches are here, on
rc2:

        git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
                pm-runtime-6.17-rc1

 drivers/bluetooth/btmtksdio.c | 1 -
 drivers/bluetooth/hci_bcm.c   | 3 ---
 drivers/bluetooth/hci_h5.c    | 2 --
 drivers/bluetooth/hci_intel.c | 3 ---
 4 files changed, 9 deletions(-)

diff --git a/drivers/bluetooth/btmtksdio.c b/drivers/bluetooth/btmtksdio.c
index c16a3518b8ff..83aee551a848 100644
--- a/drivers/bluetooth/btmtksdio.c
+++ b/drivers/bluetooth/btmtksdio.c
@@ -615,7 +615,6 @@ static void btmtksdio_txrx_work(struct work_struct *work)
 
 	sdio_release_host(bdev->func);
 
-	pm_runtime_mark_last_busy(bdev->dev);
 	pm_runtime_put_autosuspend(bdev->dev);
 }
 
diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index 9684eb16059b..08f9a232e375 100644
--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -326,7 +326,6 @@ static irqreturn_t bcm_host_wake(int irq, void *data)
 	bt_dev_dbg(bdev, "Host wake IRQ");
 
 	pm_runtime_get(bdev->dev);
-	pm_runtime_mark_last_busy(bdev->dev);
 	pm_runtime_put_autosuspend(bdev->dev);
 
 	return IRQ_HANDLED;
@@ -710,7 +709,6 @@ static int bcm_recv(struct hci_uart *hu, const void *data, int count)
 		mutex_lock(&bcm_device_lock);
 		if (bcm->dev && bcm_device_exists(bcm->dev)) {
 			pm_runtime_get(bcm->dev->dev);
-			pm_runtime_mark_last_busy(bcm->dev->dev);
 			pm_runtime_put_autosuspend(bcm->dev->dev);
 		}
 		mutex_unlock(&bcm_device_lock);
@@ -749,7 +747,6 @@ static struct sk_buff *bcm_dequeue(struct hci_uart *hu)
 	skb = skb_dequeue(&bcm->txq);
 
 	if (bdev) {
-		pm_runtime_mark_last_busy(bdev->dev);
 		pm_runtime_put_autosuspend(bdev->dev);
 	}
 
diff --git a/drivers/bluetooth/hci_h5.c b/drivers/bluetooth/hci_h5.c
index d0d4420c1a0f..e932d66a1cc0 100644
--- a/drivers/bluetooth/hci_h5.c
+++ b/drivers/bluetooth/hci_h5.c
@@ -592,7 +592,6 @@ static int h5_recv(struct hci_uart *hu, const void *data, int count)
 
 	if (hu->serdev) {
 		pm_runtime_get(&hu->serdev->dev);
-		pm_runtime_mark_last_busy(&hu->serdev->dev);
 		pm_runtime_put_autosuspend(&hu->serdev->dev);
 	}
 
@@ -634,7 +633,6 @@ static int h5_enqueue(struct hci_uart *hu, struct sk_buff *skb)
 
 	if (hu->serdev) {
 		pm_runtime_get_sync(&hu->serdev->dev);
-		pm_runtime_mark_last_busy(&hu->serdev->dev);
 		pm_runtime_put_autosuspend(&hu->serdev->dev);
 	}
 
diff --git a/drivers/bluetooth/hci_intel.c b/drivers/bluetooth/hci_intel.c
index 811f33701f84..6240ee23e030 100644
--- a/drivers/bluetooth/hci_intel.c
+++ b/drivers/bluetooth/hci_intel.c
@@ -280,7 +280,6 @@ static irqreturn_t intel_irq(int irq, void *dev_id)
 
 	/* Host/Controller are now LPM resumed, trigger a new delayed suspend */
 	pm_runtime_get(&idev->pdev->dev);
-	pm_runtime_mark_last_busy(&idev->pdev->dev);
 	pm_runtime_put_autosuspend(&idev->pdev->dev);
 
 	return IRQ_HANDLED;
@@ -371,7 +370,6 @@ static void intel_busy_work(struct work_struct *work)
 	list_for_each_entry(idev, &intel_device_list, list) {
 		if (intel->hu->tty->dev->parent == idev->pdev->dev.parent) {
 			pm_runtime_get(&idev->pdev->dev);
-			pm_runtime_mark_last_busy(&idev->pdev->dev);
 			pm_runtime_put_autosuspend(&idev->pdev->dev);
 			break;
 		}
@@ -1003,7 +1001,6 @@ static int intel_enqueue(struct hci_uart *hu, struct sk_buff *skb)
 	list_for_each_entry(idev, &intel_device_list, list) {
 		if (hu->tty->dev->parent == idev->pdev->dev.parent) {
 			pm_runtime_get_sync(&idev->pdev->dev);
-			pm_runtime_mark_last_busy(&idev->pdev->dev);
 			pm_runtime_put_autosuspend(&idev->pdev->dev);
 			break;
 		}
-- 
2.39.5

