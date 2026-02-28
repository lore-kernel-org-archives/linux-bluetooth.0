Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C8D41CEACB
	for <linux-bluetooth@vger.kernel.org>; Sat, 28 Feb 2026 08:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772268847; cv=none; b=t/wthxSO1VkS7rf5SCBboPXlOnx3AZjCPMi/NVcl16kC4Rp/sgDNBRE06dNDGAPErA9f817dMXXVvuva/AcyEQzDxwyrGIjlxmWx2fNb500IkrM5HbhUWmpL5Hdu0Vl664ZdiuJ7C4T2QDxzXWNWqjP8hDE2Z0OWYWP45lFlWbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772268847; c=relaxed/simple;
	bh=v6sdt6KqCsa9pSpcbRXQ6sdkkZu+XjoKZx2rgNDfFTQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OUSwPFH3+8gAsAz48BvAhMRFvS/iZZGBQhRxQ22/ENS0diI3QI7nLgct25vvvsUB93VYMrL/pf4Xvp8NGYCfsE0+o9dfad7D3Uy0HL0jf7ii8u1s0yqc3V8B4+mDTsL5UxY00gKOpj6Z8AaNx3axe8pNWkcEr5ACrfj+z75L7QU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PU/90NIn; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PU/90NIn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772268846; x=1803804846;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=v6sdt6KqCsa9pSpcbRXQ6sdkkZu+XjoKZx2rgNDfFTQ=;
  b=PU/90NInLor5yBUroGKoXolS3l+0A8dT40MNtZ4WOrLF7Sjr0fS/MfNc
   0KD0/7dVsJsNR7FKPJSlVklS5d9O+XgaE5joXoJD4OqUcErNqfbwSqkF0
   fz+AdbaSmfFlWJkrtCOLrcFZMV62sCZ20j6/u1THMEkwN1O66H5YFGjFC
   SFWctNmEdWBMetli8l/RXuc/9WUtv8b/p7hdQZZRMbKagT2fpd51BSf3t
   0XFRI4N9IiYRSG8kqAw6kfrBfR2VeEWUg5c19V7nhtXtBxjd8o1Nw5fSx
   P8z497UmD070+SwAI/0ZDIy4tFIUjG18PiU22OKseq/HPi1/qimHazVr5
   g==;
X-CSE-ConnectionGUID: K/TldFN/Rxu6TdWpqqnWjQ==
X-CSE-MsgGUID: xTRhhKxJQ/SO+IWNO4wonw==
X-IronPort-AV: E=McAfee;i="6800,10657,11714"; a="77189235"
X-IronPort-AV: E=Sophos;i="6.21,315,1763452800"; 
   d="scan'208";a="77189235"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2026 00:54:05 -0800
X-CSE-ConnectionGUID: rod6OnnTQ7Cy4/T3iZTPHA==
X-CSE-MsgGUID: rwhgTIGwSaqGDaFUKzFmzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,315,1763452800"; 
   d="scan'208";a="221630142"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by orviesa004.jf.intel.com with ESMTP; 28 Feb 2026 00:54:03 -0800
From: Kiran K <kiran.k@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: ravishankar.srivatsa@intel.com,
	chandrashekar.devegowda@intel.com,
	chethan.tumkur.narayan@intel.com,
	Kiran K <kiran.k@intel.com>
Subject: [PATCH v3 2/9] Bluetooth: btintel: Replace CNVi id with hardware variant
Date: Sat, 28 Feb 2026 14:42:32 +0530
Message-ID: <20260228091239.230284-2-kiran.k@intel.com>
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

Use hardware variant instead of CNVi to send dsbr command.

Signed-off-by: Kiran K <kiran.k@intel.com>
---
 drivers/bluetooth/btintel.c | 18 +++++++++---------
 drivers/bluetooth/btintel.h |  7 +++++++
 2 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index 5999be2efef8..2547b590f87a 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -2813,31 +2813,31 @@ static int btintel_set_dsbr(struct hci_dev *hdev, struct intel_version_tlv *ver)
 
 	struct btintel_dsbr_cmd cmd;
 	struct sk_buff *skb;
-	u32 dsbr, cnvi;
-	u8 status;
+	u32 dsbr;
+	u8 status, hw_variant;
 	int err;
 
-	cnvi = ver->cnvi_top & 0xfff;
+	hw_variant = INTEL_HW_VARIANT(ver->cnvi_bt);
 	/* DSBR command needs to be sent for,
 	 * 1. BlazarI or BlazarIW + B0 step product in IML image.
 	 * 2. Gale Peak2 or BlazarU in OP image.
 	 * 3. Scorpious Peak in IML image.
 	 */
 
-	switch (cnvi) {
-	case BTINTEL_CNVI_BLAZARI:
-	case BTINTEL_CNVI_BLAZARIW:
+	switch (hw_variant) {
+	case BTINTEL_HWID_BZRI:
+	case BTINTEL_HWID_BZRIW:
 		if (ver->img_type == BTINTEL_IMG_IML &&
 		    INTEL_CNVX_TOP_STEP(ver->cnvi_top) == 0x01)
 			break;
 		return 0;
-	case BTINTEL_CNVI_GAP:
-	case BTINTEL_CNVI_BLAZARU:
+	case BTINTEL_HWID_GAP:
+	case BTINTEL_HWID_BZRU:
 		if (ver->img_type == BTINTEL_IMG_OP &&
 		    hdev->bus == HCI_USB)
 			break;
 		return 0;
-	case BTINTEL_CNVI_SCP:
+	case BTINTEL_HWID_SCP:
 		if (ver->img_type == BTINTEL_IMG_IML)
 			break;
 		return 0;
diff --git a/drivers/bluetooth/btintel.h b/drivers/bluetooth/btintel.h
index 431998049e68..b7ff183f8886 100644
--- a/drivers/bluetooth/btintel.h
+++ b/drivers/bluetooth/btintel.h
@@ -69,6 +69,13 @@ struct intel_tlv {
 
 #define BTINTEL_FWID_MAXLEN 64
 
+/* CNVi Hardware variant */
+#define BTINTEL_HWID_GAP	0x1c	/* Gale Peak2 - Meteor Lake */
+#define BTINTEL_HWID_BZRI	0x1e	/* BlazarI - Lunar Lake */
+#define BTINTEL_HWID_BZRU	0x1d	/* BlazarU - Meteor Lake */
+#define BTINTEL_HWID_SCP	0x1f	/* Scorpius Peak - Panther Lake */
+#define BTINTEL_HWID_BZRIW	0x22	/* BlazarIW - Wildcat Lake */
+
 struct intel_version_tlv {
 	u32	cnvi_top;
 	u32	cnvr_top;
-- 
2.43.0

