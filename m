Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB01802
	for <linux-bluetooth@vger.kernel.org>; Sat, 11 May 2024 05:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715405195; cv=none; b=BUBWDxMh9YVZs08OxAN3/jMfDno6fXIsWKGxNmf2WIQ6tRP8JRLVLKmgnbVl3xlMveuOH5ORX3hbNdUHxvbrRmPIFLXKCDzgA8Km/0zr9iHpfzm+BJdnCEMYU6my/vNUTCHPJbT/NXcDEcpqbtONlGLqhx7VuWK2rbWbLvrPS5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715405195; c=relaxed/simple;
	bh=wMB3Yyue7FJp1DnViiuNlGyK6qxTJvZbbzjf8laO12g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=X144P1f0OSsj6ZtUbAX0Z6pUGYw2iqtpg0elHrQ12hJG7ohAEUZg1qgVeY2AH6taxxJl2/a7tOt0qIRLF8jlADo2IMmrCHxyiWL/Wf2wpsPT51+xBI8rzmhA5sOVY/4oUGJz16wNUzP5zH+jTxsLVjcrKeXygAKLfedbVloZ9C0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QKvfpK5e; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QKvfpK5e"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715405194; x=1746941194;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=wMB3Yyue7FJp1DnViiuNlGyK6qxTJvZbbzjf8laO12g=;
  b=QKvfpK5eh7++2FNUOEc1V4IkeB5Fqfha7MXDQdziould8xjkOofaMk7M
   0Vbp/saqJv5SvagN8IpvaEOGLMIxP4bR8pM8orvZIDStSGYPQjlLT7ryU
   6kvtVeID/lb4kd1B/aR+mZa+RwLak4vDP/fRRe4g9HhFo/j6bCynBIwWC
   0jJ440lmE1JqTekcRLMhzHcyk+9iDRUdi6bistgSZOhzeGLlZwmj0rp1q
   xGdfw9LMkFPwzEM9NmBJOqp/26QQC98Ln7rRqJwfp/Fn6+EgLExK5CRGx
   2D2ilmK2b5fOg0aBS+t2U+9217w02lZvb0wZie692vKiEerFF0evZnFc5
   A==;
X-CSE-ConnectionGUID: ahM+o3f7QHqMBfHQ9qkyOA==
X-CSE-MsgGUID: eu8Eo8DxRCKJtTbWC7jF1Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11069"; a="33917271"
X-IronPort-AV: E=Sophos;i="6.08,153,1712646000"; 
   d="scan'208";a="33917271"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 22:26:34 -0700
X-CSE-ConnectionGUID: 0VGjzD7CT/uNperZFqFsYg==
X-CSE-MsgGUID: OqXXcG4ASEeqP4vbVzNoDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,153,1712646000"; 
   d="scan'208";a="29790237"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by fmviesa007.fm.intel.com with ESMTP; 10 May 2024 22:26:31 -0700
From: Kiran K <kiran.k@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: ravishankar.srivatsa@intel.com,
	chethan.tumkur.narayan@intel.com,
	chandrashekar.devegowda@intel.com,
	Kiran K <kiran.k@intel.com>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH v1 1/2] Bluetooth: btintel_pcie: Fix warning reported by sparse
Date: Sat, 11 May 2024 11:10:58 +0530
Message-Id: <20240511054059.349729-1-kiran.k@intel.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix sparse error.

Fixes: a6c49bbb0b72 ("Bluetooth: btintel_pcie: Add support for PCIe transport")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202405100654.0djvoryZ-lkp@intel.com/
Signed-off-by: Kiran K <kiran.k@intel.com>
---
 drivers/bluetooth/btintel_pcie.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index 2853ab80079d..030a75e5d2a3 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -670,7 +670,7 @@ struct btintel_pcie_causes_list {
 	u8 cause_num;
 };
 
-struct btintel_pcie_causes_list causes_list[] = {
+static struct btintel_pcie_causes_list causes_list[] = {
 	{ BTINTEL_PCIE_MSIX_FH_INT_CAUSES_0,	BTINTEL_PCIE_CSR_MSIX_FH_INT_MASK,	0x00 },
 	{ BTINTEL_PCIE_MSIX_FH_INT_CAUSES_1,	BTINTEL_PCIE_CSR_MSIX_FH_INT_MASK,	0x01 },
 	{ BTINTEL_PCIE_MSIX_HW_INT_CAUSES_GP0, BTINTEL_PCIE_CSR_MSIX_HW_INT_MASK,	0x20 },
-- 
2.40.1

