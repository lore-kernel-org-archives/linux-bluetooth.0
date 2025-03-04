Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EDA9281518
	for <linux-bluetooth@vger.kernel.org>; Tue,  4 Mar 2025 16:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741105304; cv=none; b=eqXBSQ9LHouIPJrmehbt3oB2A+Ba8gi2SCXFbO4lJ0D9qxXd63Kr4Yghi3PRKxw/abo2QJqR3AG3XQR8Z5Hwr6I6KPTI/GTbbqToavzkh7WDVx+lkrgPtOZNiThXXGCPr5KpSSSXXtqrL3Y/0Oppq5mfuR2WkNpG1ZtNOedd24g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741105304; c=relaxed/simple;
	bh=n6hfMdCi5ZIz2s6aeQrPGi7x9PT8ks8VXB32/hBHpGA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kQvXJ4kleLVpMQdjNC7jVMgryRIhzFqurLRl3wVgVOBY/uZOeY/UQiyuUvfGNsyeskJeN2QeoU1IC0IuZ+3orxIbyOuYvD1MxeRsA5oWrmrxViJlXfEyzeSoF6N6okPJa90iSwUTGBmE71v66EcDSAzpWRul15HzAK9vo73vTTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W8KrOx+P; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W8KrOx+P"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741105302; x=1772641302;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=n6hfMdCi5ZIz2s6aeQrPGi7x9PT8ks8VXB32/hBHpGA=;
  b=W8KrOx+PQpAqJjwPymnJUKrHDSkpNWFl6u/VeBZbMbkdunu6U3XDNlkp
   eKYo07scO0z0zab6BLYRcE9Y9Jbc8JbWPAsOjCxkQu4zy166yJ1C2g27c
   bKsNI7U9HJpYCajhG0s6NuO/CvGJWF8o3/9MQyFngWMUpvC33cikFX2n2
   oEE87xthAnkbpxRoDytUpR9CtbK2c3kMjOObcJj0ijQ+GzCkksy1XgZab
   cfO3k+Z9OMY3KOdXSU2pqVnt14fi5bNUvQONCBf1dOcnPK9RmYF8uLXjh
   qPf8s17YFmhflhFwU8fp9VdD3RfJkJkGd3dDNTJq01xeB0/sJTyG78fiZ
   w==;
X-CSE-ConnectionGUID: DEQK9pBFQOaCXyB3lNgDNw==
X-CSE-MsgGUID: y4sxTD/zSO6sb8MUTEsXpA==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="53427569"
X-IronPort-AV: E=Sophos;i="6.14,220,1736841600"; 
   d="scan'208";a="53427569"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 08:21:42 -0800
X-CSE-ConnectionGUID: Zex8S8EgS+ersr7C2jGfZw==
X-CSE-MsgGUID: pxDbKr3eSiuhiAEVPWOA3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,220,1736841600"; 
   d="scan'208";a="141655132"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by fmviesa002.fm.intel.com with ESMTP; 04 Mar 2025 08:21:39 -0800
From: Kiran K <kiran.k@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: ravishankar.srivatsa@intel.com,
	chethan.tumkur.narayan@intel.com,
	chandrashekar.devegowda@intel.com,
	vijay.satija@intel.com,
	Kiran K <kiran.k@intel.com>
Subject: [PATCH v1] Bluetooth: btintel_pcie: Trigger device coredump on hardware exception
Date: Tue,  4 Mar 2025 21:51:35 +0530
Message-ID: <20250304162135.254530-1-kiran.k@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Driver dumps device core dump on firmware exception.

Signed-off-by: Kiran K <kiran.k@intel.com>
---
 drivers/bluetooth/btintel_pcie.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index a499bad58b53..3c3699250312 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -60,6 +60,7 @@ MODULE_DEVICE_TABLE(pci, btintel_pcie_table);
 #define BTINTEL_PCIE_MAGIC_NUM	0xA5A5A5A5
 
 #define BTINTEL_PCIE_TRIGGER_REASON_USER_TRIGGER	0x17A2
+#define BTINTEL_PCIE_TRIGGER_REASON_FW_ASSERT		0x1E61
 
 /* Alive interrupt context */
 enum {
@@ -1202,6 +1203,10 @@ static void btintel_pcie_msix_hw_exp_handler(struct btintel_pcie_data *data)
 
 	if (test_and_set_bit(BTINTEL_PCIE_HWEXP_INPROGRESS, &data->flags))
 		return;
+
+	/* Trigger device core dump when there is HW  exception */
+	if (!test_and_set_bit(BTINTEL_PCIE_COREDUMP_INPROGRESS, &data->flags))
+		data->dmp_hdr.trigger_reason  = BTINTEL_PCIE_TRIGGER_REASON_FW_ASSERT;
 	queue_work(data->workqueue, &data->rx_work);
 }
 
-- 
2.43.0

