Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA991378822
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Feb 2026 15:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771946183; cv=none; b=HO5m+tYRwMv4YGUcnchfekP3oEPONT2EHLjizICD84twy6pmJU95P4ZcExk7Ol09ClYRFwBPc9tx/50MmFOhlN1Uc9CYcdByx6efIZa05K0UVIv3hcIKPl+x4DA7E1rYfj9s/mQZ5MSNYRCTgJoc0LI5EotV2cuTSwIBrsgaayg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771946183; c=relaxed/simple;
	bh=L9GFXmEmoCxOeI79kznZfRoSiix1+mCpyLXpTbixpPA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JF7Dy+KgwLz3oiKbhIRpeWWpiidSrHRwQGps9HRb4/RIN5/KFtGQmZ0bXtyiXu/DeM+o4VdjSj0yIqkof3WfGjZQP9OJJgLBbr4v9lNtD9wmbktWcjCABKnkRpmCdpXUIqX5fQH7ms5QGE8H7dTabXP1IpRF1gyvJxLUN6ZNHvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Hp6nOgHM; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Hp6nOgHM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771946182; x=1803482182;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=L9GFXmEmoCxOeI79kznZfRoSiix1+mCpyLXpTbixpPA=;
  b=Hp6nOgHMwM6NexLruz+D4HmckSlelcR0Hw2mkIe8bsCWy13iV5FFWETF
   YG6FNJPQNDvqUT9L6S6d2yM9YwttnShuoX2EsZN3Pa74xFYplSj/dje77
   fIG26HWssZ1jwKyvcD5+UgnNKbmRfa3HLCC/icq9eLGZb4MXUiwqFpJQE
   hKU0Ui5oMdo/mmq9XWkmU8sMT2vyHnpkwZJztmM8Mh/zV6lflXBmYern8
   hnCO/uzbhPFE3l4GaWq7g8D8s/jDura+s9UW0cO+o1I1X3Ds3fEnTk1rA
   wl+JbfMFhBT9FheRFCT2d3KM1UU96JXkco3yyO8hYKNvixWFIlYIENWqO
   g==;
X-CSE-ConnectionGUID: vPzS+5JuQ9Sj7VCYZBM5Lw==
X-CSE-MsgGUID: Q3JQensUT8qcNFBXZyYVvw==
X-IronPort-AV: E=McAfee;i="6800,10657,11711"; a="72874694"
X-IronPort-AV: E=Sophos;i="6.21,308,1763452800"; 
   d="scan'208";a="72874694"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2026 07:16:22 -0800
X-CSE-ConnectionGUID: 8oLl0kIhRhud6GqpOC+X6g==
X-CSE-MsgGUID: feVCe3wURNK1TWNZhaUOGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,308,1763452800"; 
   d="scan'208";a="253676495"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by orviesa001.jf.intel.com with ESMTP; 24 Feb 2026 07:16:20 -0800
From: Kiran K <kiran.k@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: ravishankar.srivatsa@intel.com,
	chandrashekar.devegowda@intel.com,
	chethan.tumkur.narayan@intel.com,
	Kiran K <kiran.k@intel.com>
Subject: [PATCH v2 5/9] btintel_pcie: Add support for exception dump for ScP2
Date: Tue, 24 Feb 2026 21:04:44 +0530
Message-ID: <20260224153449.193551-5-kiran.k@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260224153449.193551-1-kiran.k@intel.com>
References: <20260224153449.193551-1-kiran.k@intel.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add device coredump support for Scorpious Peak2 product.

Signed-off-by: Kiran K <kiran.k@intel.com>
---
 drivers/bluetooth/btintel.h      | 11 ++++++-----
 drivers/bluetooth/btintel_pcie.c |  7 +++++++
 2 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/bluetooth/btintel.h b/drivers/bluetooth/btintel.h
index f16f852b83b8..b5c00be8277a 100644
--- a/drivers/bluetooth/btintel.h
+++ b/drivers/bluetooth/btintel.h
@@ -54,11 +54,12 @@ struct intel_tlv {
 
 #define BTINTEL_HCI_OP_RESET	0xfc01
 
-#define BTINTEL_CNVI_BLAZARI		0x900
-#define BTINTEL_CNVI_BLAZARIW		0x901
-#define BTINTEL_CNVI_GAP		0x910
-#define BTINTEL_CNVI_BLAZARU		0x930
-#define BTINTEL_CNVI_SCP		0xA00
+#define BTINTEL_CNVI_BLAZARI		0x900	/* BlazarI - Lunar Lake */
+#define BTINTEL_CNVI_BLAZARIW		0x901	/* BlazarIW - Wildcat Lake */
+#define BTINTEL_CNVI_GAP		0x910	/* Gale Peak2 - Meteor Lake */
+#define BTINTEL_CNVI_BLAZARU		0x930	/* BlazarU - Meteor Lake */
+#define BTINTEL_CNVI_SCP		0xA00	/* Scorpius Peak - Panther Lake */
+#define BTINTEL_CNVI_SCP2		0xA10	/* Scorpius Peak2 - Nova Lake */
 
 /* CNVR */
 #define BTINTEL_CNVR_FMP2		0x910
diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index 19abffca209f..bf71817b1cc6 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -73,6 +73,9 @@ struct btintel_pcie_dev_recovery {
 #define BTINTEL_PCIE_SCP_HWEXP_SIZE		4096
 #define BTINTEL_PCIE_SCP_HWEXP_DMP_ADDR		0xB030F800
 
+#define BTINTEL_PCIE_SCP2_HWEXP_SIZE		4096
+#define BTINTEL_PCIE_SCP2_HWEXP_DMP_ADDR	0xB031D000
+
 #define BTINTEL_PCIE_MAGIC_NUM	0xA5A5A5A5
 
 #define BTINTEL_PCIE_TRIGGER_REASON_USER_TRIGGER	0x17A2
@@ -1230,6 +1233,10 @@ static void btintel_pcie_read_hwexp(struct btintel_pcie_data *data)
 		len = BTINTEL_PCIE_SCP_HWEXP_SIZE;
 		addr = BTINTEL_PCIE_SCP_HWEXP_DMP_ADDR;
 	break;
+	case BTINTEL_CNVI_SCP2:
+		len = BTINTEL_PCIE_SCP2_HWEXP_SIZE;
+		addr = BTINTEL_PCIE_SCP2_HWEXP_DMP_ADDR;
+	break;
 	default:
 		bt_dev_err(data->hdev, "Unsupported cnvi 0x%8.8x", data->dmp_hdr.cnvi_top);
 		return;
-- 
2.43.0

