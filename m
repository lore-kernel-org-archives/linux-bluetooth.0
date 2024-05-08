Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 602817641D
	for <linux-bluetooth@vger.kernel.org>; Wed,  8 May 2024 09:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715161506; cv=none; b=NyGQU9eG7CLgUHTJlLnYoaj43ZmT9Iqy0Qz0yHncv/tIo/IfTp9+7rFJHzYWfNOd/qsWfuRfmoQAzcFU2H4SL649vbfZCAzud0x3Bf7VOUtzRk3xcIarQM8jVxM8K0KXYqKB8MRz7MGZL7nfEAyaqh1IXHwVOuSPKm4FJ/R6YAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715161506; c=relaxed/simple;
	bh=PFFV9Ctp/LRJteKIh2sMvi4vqPNVZ1Da+pJdeKDz4P0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Cxz/g0F3bY02veSn57wQXkwgHxGPK5qg6romq9TyjxuTfopXO5t3KwG1ZZB40BDgGFvgX3PrRxHuvYlX1MS5QZLt/YbkqdR0FpQtg9YdE4B53hRebk2VKdMG3TFJMli0EiOmht4CanYpd+uIEA2tVsU+EZCBNkrfiLAnkPrjyeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g7OCIpsp; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g7OCIpsp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715161504; x=1746697504;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PFFV9Ctp/LRJteKIh2sMvi4vqPNVZ1Da+pJdeKDz4P0=;
  b=g7OCIpspH+L+ufs7h8B9kpPg6kz0jQT5c2LSczSIwwWqh+64uyuNLm8r
   9WMTFAEDdZqmGqnGbZrZrbt2ak9EoZWQ8D1ItIPUqAEvDo4dfM0BVna7d
   s0DmWn3gN8StirotIyHEwjRMVSvqqezyaZncvR3VbdfBKdP/vZ+s9Cx/x
   I3foRZvIJMJfbriGdJ4FcOg26zm37lM0W7ivZItqn8AROGb2yTGnKuz6w
   qbYTNdsKW6+iXsmZtGUwt+DTIPg2MZ2TwanIwMZncHdRI2tfDd0ttKr+d
   0wDVEnC7mfSPqbYrsgD+UGbq5xCLIbrD9y+mFCS6optuLR2H1fDjQbYUI
   A==;
X-CSE-ConnectionGUID: vQPgMVqWQLGS9XP+IOfQmw==
X-CSE-MsgGUID: eYLNRle3SKyjMKIIyzckbQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11066"; a="22416903"
X-IronPort-AV: E=Sophos;i="6.08,144,1712646000"; 
   d="scan'208";a="22416903"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2024 02:45:04 -0700
X-CSE-ConnectionGUID: jt8erLPaTWqnEOssULQCaQ==
X-CSE-MsgGUID: aD4Tc+atT0uWPcCTik+3WQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,144,1712646000"; 
   d="scan'208";a="33384574"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by fmviesa004.fm.intel.com with ESMTP; 08 May 2024 02:45:03 -0700
From: Kiran K <kiran.k@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: ravishankar.srivatsa@intel.com,
	chethan.tumkur.narayan@intel.com,
	chandrashekar.devegowda@intel.com,
	Kiran K <kiran.k@intel.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH v1 2/2] Bluetooth: btintel: Fix compiler warning for multi_v7_defconfig config
Date: Wed,  8 May 2024 15:29:27 +0530
Message-Id: <20240508095927.155528-2-kiran.k@intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240508095927.155528-1-kiran.k@intel.com>
References: <20240508095927.155528-1-kiran.k@intel.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix the following compiler warning reported for ARCH=arm
multi_v7_defconfig.

In file included from drivers/bluetooth/hci_ldisc.c:34:
drivers/bluetooth/btintel.h:373:13: warning: 'btintel_hw_error' defined but not used [-Wunused-function]
  373 | static void btintel_hw_error(struct hci_dev *hdev, u8 code)
      |             ^~~~~~~~~~~~~~~~

cc: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Kiran K <kiran.k@intel.com>
---
 drivers/bluetooth/btintel.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btintel.h b/drivers/bluetooth/btintel.h
index 5d4685b5c1fa..b5fea735e260 100644
--- a/drivers/bluetooth/btintel.h
+++ b/drivers/bluetooth/btintel.h
@@ -370,7 +370,7 @@ static inline int btintel_shutdown_combined(struct hci_dev *hdev)
 	return -ENODEV;
 }
 
-static void btintel_hw_error(struct hci_dev *hdev, u8 code)
+static inline void btintel_hw_error(struct hci_dev *hdev, u8 code)
 {
 }
 #endif
-- 
2.40.1

