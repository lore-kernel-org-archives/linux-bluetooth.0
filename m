Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 973CB187552
	for <linux-bluetooth@vger.kernel.org>; Thu, 12 Sep 2024 10:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726137363; cv=none; b=YKAIFM0VKt7KEuX2ILctslZGDeuSZ0OkYDFRe1vQtYuIyko0n4HRfuBtV9y8jQQgdCSsXXjkTe+o9sv2vkQjxJW/iVpW/c1wt3NSel1xsXBBoEAomlLXc198bmLdYICz2Xw5aJBMMP/C/S8KI3gDBBSnYmtBybpTAMe3Ws7UXxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726137363; c=relaxed/simple;
	bh=ujn2FRvhWf3TDMx/LQRDUKK8fFVgbSQI00OCD2psH+E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VfVriHiRjEQjZMXSVJxPEq73MliUsFOoFPgFppxlnJTXnauaiVwLyhGlBTQyTMDJHFScK5jyK6Rn9gS6ubJHis/shAwPS+078E5JTN4fZU4a7LiherQlv0HALCnIpPCaNLc1/22R/ftLp+IjxDTBW4Y2JeZvRlOZhgrZy2i0Jv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KFw656+U; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KFw656+U"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726137362; x=1757673362;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ujn2FRvhWf3TDMx/LQRDUKK8fFVgbSQI00OCD2psH+E=;
  b=KFw656+UVjJBz/rN6xq9Ej5yuYVDX1HVAjLgN+YotecHDh3AyfdyWyi1
   fCLMOjQ+70l5ZGtwXVaAxPY3YMqg7aNdnLc3oJO3g6VH8hOUZ5s1kfkzs
   NqMA2ubUbL7KnnRDVIfqp4VWS1XDwMAN/gQ3rq7gHEZxPhWa0CyM3qyEn
   FMl9FtA0kgQNi1JWIh7C3QyfiIAhpnvzsy5EIJGGC4ULdYuz1JTnAgkGh
   gf7EbXA1SKXFJbf2iYFui/TdOL7CBIyfv2s50KoSF2Wp4OxDAjwU/rwAg
   TeIw1oVc4/+sFYFf00UvyA+BZQYiaDEGJhWfdKx+ansNpF7xQxjak1NXF
   w==;
X-CSE-ConnectionGUID: gAv0rM2PSoyLWINhwO6M5w==
X-CSE-MsgGUID: RaY96FLdR+GhrZYN9RX2LA==
X-IronPort-AV: E=McAfee;i="6700,10204,11192"; a="35569311"
X-IronPort-AV: E=Sophos;i="6.10,222,1719903600"; 
   d="scan'208";a="35569311"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2024 03:35:59 -0700
X-CSE-ConnectionGUID: YaPk9aobRq+A/Re0mdxW6A==
X-CSE-MsgGUID: fLBsOrcCS4eVeiTKhkU6/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,222,1719903600"; 
   d="scan'208";a="67656446"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by fmviesa009.fm.intel.com with ESMTP; 12 Sep 2024 03:35:57 -0700
From: Kiran K <kiran.k@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: ravishankar.srivatsa@intel.com,
	chethan.tumkur.narayan@intel.com,
	chandrashekar.devegowda@intel.com,
	Kiran K <kiran.k@intel.com>
Subject: [PATCH v1] Bluetooth: btintel_pcie: Allocate memory for driver private data
Date: Thu, 12 Sep 2024 16:21:00 +0530
Message-Id: <20240912105100.46534-1-kiran.k@intel.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix driver not allocating memory for struct btintel_data which is used
to store internal data.

Fixes: 6e65a09f9275 ("Bluetooth: btintel_pcie: Add *setup* function to download firmware")
Signed-off-by: Kiran K <kiran.k@intel.com>
---
 drivers/bluetooth/btintel_pcie.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index d255bdf777b4..fda47948c35d 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -1224,7 +1224,7 @@ static int btintel_pcie_setup_hdev(struct btintel_pcie_data *data)
 	int err;
 	struct hci_dev *hdev;
 
-	hdev = hci_alloc_dev();
+	hdev = hci_alloc_dev_priv(sizeof(struct btintel_data));
 	if (!hdev)
 		return -ENOMEM;
 
-- 
2.40.1

