Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A2D378822
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Feb 2026 15:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771946178; cv=none; b=HvBOqBIRuxoKAtbRAlxuP1o5l2DU2/FHwrAO5vnMfxAXthPPbv4ByCWPdSjjJkxc8seTpe2yejj3DvtqaAzcv7u1Z2IP9xZZ3n3jbJRE5Bs2GQ1kRnTxiCBa98Or9YZ1Bo0TfC/sjGwSyV2h9o3dJfwfYIO30YVHobBaaV/UqGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771946178; c=relaxed/simple;
	bh=v6sdt6KqCsa9pSpcbRXQ6sdkkZu+XjoKZx2rgNDfFTQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IFec5c1D/hEwLe+QmWwYMbnEqlq0MsvA/ymV73qO4O5tdKZ/fi8ivTBEAt98FhYPiNg0qZafO75jBvV93Um+O0DZAEj/+F3JWnCijBdPruZ4h/IAIaXvm43rs7Zp8NesA4yZtouRCB/Z9xw1xyRscwfyGe2Y6I9+d1GEK0ISd4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Gomod7PQ; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Gomod7PQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771946177; x=1803482177;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=v6sdt6KqCsa9pSpcbRXQ6sdkkZu+XjoKZx2rgNDfFTQ=;
  b=Gomod7PQoRAKGX//rNfYnTse7j1lCbMBMUoO4i211XH+jHXVFfdrmBHy
   3xrVO9+XSHIqbl5n0uMGCO6NUPi2Qei1A14ESXQK0wiEuxpKgn0rn7mA8
   91PVctTJUuLiZ++iqv/Mcta0ZytoJKCC45W4qb1Pl8hcBL68ARl+Jhafn
   o1vhyCvVkIV+ie+Kj+/P7/e6u7awNYMWRsfYB3Mn29HPYKjaIq0jt0wMo
   BsP0+531CdGAg5AD9PvFzc2yeUfb2yqIQsYHnrB/LefJ0sZvCr63HKHd8
   EuCVqH3rwLHbelh2i637v/fvAvDxZ2laZl39k4LB5m8D1e2q3gd8NYPh5
   w==;
X-CSE-ConnectionGUID: qh7WASTnSFO8POlgh3W5uQ==
X-CSE-MsgGUID: TRVPi1xpSeuaD4yBsD4/MA==
X-IronPort-AV: E=McAfee;i="6800,10657,11711"; a="72874684"
X-IronPort-AV: E=Sophos;i="6.21,308,1763452800"; 
   d="scan'208";a="72874684"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2026 07:16:16 -0800
X-CSE-ConnectionGUID: 4BB1ipvrS2+co2sGFryuow==
X-CSE-MsgGUID: cAruubafTiezM7aF1M6AMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,308,1763452800"; 
   d="scan'208";a="253676467"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by orviesa001.jf.intel.com with ESMTP; 24 Feb 2026 07:16:14 -0800
From: Kiran K <kiran.k@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: ravishankar.srivatsa@intel.com,
	chandrashekar.devegowda@intel.com,
	chethan.tumkur.narayan@intel.com,
	Kiran K <kiran.k@intel.com>
Subject: [PATCH v2 2/9] Bluetooth: btintel: Replace CNVi id with hardware variant
Date: Tue, 24 Feb 2026 21:04:41 +0530
Message-ID: <20260224153449.193551-2-kiran.k@intel.com>
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

