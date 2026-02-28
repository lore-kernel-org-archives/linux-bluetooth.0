Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A801CEACB
	for <linux-bluetooth@vger.kernel.org>; Sat, 28 Feb 2026 08:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772268849; cv=none; b=FwSGaIBke0JZ6WvkoePv7V/XWeSf0N1HmUaDDQoKMJPsV6POm0mUPVVJNe2zZQvBEnJUqelQijDzGK9NXOjvlqEZ69ABLtNAf/9JPH86nyQFevNFIiYHK9qVoo6oTNnHDlv8kzJNSNA0Hk/PE1oJI3lUN2K/EKZbAG0Ax4y0Wxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772268849; c=relaxed/simple;
	bh=TuQZcotRmGkHmEROF5Nzxh9oT6D1Zy/KmJR//aXqZQg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=luKG7uZgT22oW+TKRRhZZZ6eFSTfitCqeUe5VPCRcoi0u0ICdfSre69DFE5JX06HXy1I0bdlyZ4GkFDdVe6bO8wPdV5037XiaxwsgCvgytTUO1nB3B+Lan0f6n0h75P6rRKzzBhunDdnlUTyLnrBDvFBzo10EAFdkqEj4CTQvC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A4MWBX8z; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A4MWBX8z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772268849; x=1803804849;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TuQZcotRmGkHmEROF5Nzxh9oT6D1Zy/KmJR//aXqZQg=;
  b=A4MWBX8z8SQJ5NksjMuN4rDs2dQS/dhkBrr4NKpazsLOEcr69d837Vks
   //WDmSMJ82TodtNQPE62sRy23vd+8+sK2r9mzUrgLpXZHTZ6VeB2UHcUX
   m9u4tYuRv/9n5krbj83rv3RrupII9qY1HaVBAp5+dXhuRshysPr5rE0i1
   PHOcXxOYMV/MqUFc4hgnzKwZJN2p9QR9tLevEfaEIqRykaEQ/c5rc4QAi
   nRaPUXUE6yE0LovU+37YO41tnoaBhoy87TrqiwNi9MJn/QbovHsAyWNZR
   YYs/Zq4ndzHsh/72Z3orJhT9Ui1DuZxSgb3bVZmR6G+ZfSMowXf3LjBCj
   A==;
X-CSE-ConnectionGUID: aoVWv7iRR8uD2nou81AuGg==
X-CSE-MsgGUID: YHT6vsYrTemA7sgAffmqHg==
X-IronPort-AV: E=McAfee;i="6800,10657,11714"; a="77189241"
X-IronPort-AV: E=Sophos;i="6.21,315,1763452800"; 
   d="scan'208";a="77189241"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2026 00:54:09 -0800
X-CSE-ConnectionGUID: yQ9EC2lSS4atgsC3r8+qpA==
X-CSE-MsgGUID: SCwrddMRRbCj/cyc+l/2nA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,315,1763452800"; 
   d="scan'208";a="221630150"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by orviesa004.jf.intel.com with ESMTP; 28 Feb 2026 00:54:07 -0800
From: Kiran K <kiran.k@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: ravishankar.srivatsa@intel.com,
	chandrashekar.devegowda@intel.com,
	chethan.tumkur.narayan@intel.com,
	Kiran K <kiran.k@intel.com>
Subject: [PATCH v3 4/9] Bluetooth: btintel: Add DSBR support for ScP2 onwards
Date: Sat, 28 Feb 2026 14:42:34 +0530
Message-ID: <20260228091239.230284-4-kiran.k@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260228091239.230284-1-kiran.k@intel.com>
References: <20260228091239.230284-1-kiran.k@intel.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add DSBR support for Scorpious Peak2 cores onwards.

Refer commit eb9e749c0182 ("Bluetooth: btintel: Allow configuring drive
strength of BRI") for details about DSBR.

Signed-off-by: Kiran K <kiran.k@intel.com>
---
 drivers/bluetooth/btintel.c | 5 +++++
 drivers/bluetooth/btintel.h | 1 +
 2 files changed, 6 insertions(+)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index 26aa8ea7d33e..b3cbb61065d1 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -2823,6 +2823,7 @@ static int btintel_set_dsbr(struct hci_dev *hdev, struct intel_version_tlv *ver)
 	 * 1. BlazarI or BlazarIW + B0 step product in IML image.
 	 * 2. Gale Peak2 or BlazarU in OP image.
 	 * 3. Scorpious Peak in IML image.
+	 * 4. Scorpious Peak2 onwards + PCIe transport in IML image.
 	 */
 
 	switch (hw_variant) {
@@ -2843,6 +2844,10 @@ static int btintel_set_dsbr(struct hci_dev *hdev, struct intel_version_tlv *ver)
 			break;
 		return 0;
 	default:
+		/* Scorpius Peak2 onwards */
+		if (hw_variant >= BTINTEL_HWID_SCP2 && hdev->bus == HCI_PCI
+		    && ver->img_type == BTINTEL_IMG_IML)
+			break;
 		return 0;
 	}
 
diff --git a/drivers/bluetooth/btintel.h b/drivers/bluetooth/btintel.h
index b7ff183f8886..f16f852b83b8 100644
--- a/drivers/bluetooth/btintel.h
+++ b/drivers/bluetooth/btintel.h
@@ -74,6 +74,7 @@ struct intel_tlv {
 #define BTINTEL_HWID_BZRI	0x1e	/* BlazarI - Lunar Lake */
 #define BTINTEL_HWID_BZRU	0x1d	/* BlazarU - Meteor Lake */
 #define BTINTEL_HWID_SCP	0x1f	/* Scorpius Peak - Panther Lake */
+#define BTINTEL_HWID_SCP2	0x20	/* Scorpius Peak2 - Nova Lake */
 #define BTINTEL_HWID_BZRIW	0x22	/* BlazarIW - Wildcat Lake */
 
 struct intel_version_tlv {
-- 
2.43.0

