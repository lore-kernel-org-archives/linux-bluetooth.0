Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769D21F8933
	for <linux-bluetooth@vger.kernel.org>; Tue, 15 Oct 2024 12:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728994327; cv=none; b=j10zNA/FObtTtOIyqC4BR8UkcarTC5txvyLPWjQ2YNjvHOVCuho3Yr3XmsrdV8Sxq1RypwA6y+D4sMGse6VLN44f8afAEAsHgq9nGqZfEjKoDX0K3ruHrInnfHr9oL0ILI57Yj5xJYtTnQsEWvBxjHp5KT0yoidpWCKVUktqrGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728994327; c=relaxed/simple;
	bh=jrLwG4L1tL+LsBtd7KL3rXV64iRbw8Ai5EwR3Nrfu3U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HnM1tZrR6f95Oep4qFIFiSTiYUI6LSuLNZJJeUtee02jjNAwApN22XEPqQ4hGgehI15bmliorlo/7hFgklKxlW/scQO3YBRbY1aGWoiXWtUN8VppYCR6BiACHhLnUJhKlyxZOPakyZcd4sADsOt7+7e2GJNesy9Pe3Fr8T5GpHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BzVHvKx+; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BzVHvKx+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728994325; x=1760530325;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=jrLwG4L1tL+LsBtd7KL3rXV64iRbw8Ai5EwR3Nrfu3U=;
  b=BzVHvKx+Mj/TsJXgjb+lA8lrPlxIdzrsLvWjRAySp4AT9ytvZ1LqdbRi
   b4s7RkFYfBMiWxDGXjHZ0LaYkLD/77+uiMZ9gUkHOSVWSZuvcpJujz24V
   zbtK0KTxSwBmpgjpmD7pmlMdyauaNO57G4PRRukORaKwVpK1mqWfN6BZa
   GbhXSIpNOGg7vuohWSiRO83WnfZkyHU0E+TewNf3HiZ6lQZI/DHRPOaxb
   2fr0uqe6hbGGhQZpXT4vI9bZL7NXPubJmMKpxi3xY83NTbRGWrsosaovi
   oOhHR/c+UZu1ZgJtKb9TviI5P6oI06rFcGQeofAgZ7QZqTIaKSa8R4vdk
   w==;
X-CSE-ConnectionGUID: Pft2F7nWQqC0T4/CSzyW9A==
X-CSE-MsgGUID: SPxWxKaeSgubG2H+vlm+kA==
X-IronPort-AV: E=McAfee;i="6700,10204,11225"; a="32182321"
X-IronPort-AV: E=Sophos;i="6.11,205,1725346800"; 
   d="scan'208";a="32182321"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2024 05:12:05 -0700
X-CSE-ConnectionGUID: U1AXQ4BdQMWRAG4Yv1Kv6w==
X-CSE-MsgGUID: WBQEK4naQEqZXy7toGUCrg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,205,1725346800"; 
   d="scan'208";a="77544104"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by fmviesa007.fm.intel.com with ESMTP; 15 Oct 2024 05:12:03 -0700
From: Kiran K <kiran.k@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: ravishankar.srivatsa@intel.com,
	chethan.tumkur.narayan@intel.com,
	chandrashekar.devegowda@intel.com,
	Kiran K <kiran.k@intel.com>
Subject: [PATCH v1] Bluetooth: btintel: Add DSBR support for BlazarIW, BlazarU and GaP
Date: Tue, 15 Oct 2024 17:57:07 +0530
Message-Id: <20241015122707.720187-1-kiran.k@intel.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add DSBR support for BlazarIW, BlazarU and Gale Peak2 cores.

Refer commit eb9e749c0182 ("Bluetooth: btintel: Allow configuring drive
strength of BRI") for details about DSBR.

Signed-off-by: Kiran K <kiran.k@intel.com>
---
 drivers/bluetooth/btintel.c | 28 ++++++++++++++++++++--------
 drivers/bluetooth/btintel.h |  3 +++
 2 files changed, 23 insertions(+), 8 deletions(-)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index 432f723e3869..1828d3453688 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -2747,20 +2747,32 @@ static int btintel_set_dsbr(struct hci_dev *hdev, struct intel_version_tlv *ver)
 
 	struct btintel_dsbr_cmd cmd;
 	struct sk_buff *skb;
+	u32 dsbr, cnvi;
 	u8 status;
-	u32 dsbr;
-	bool apply_dsbr;
 	int err;
 
-	/* DSBR command needs to be sent for BlazarI + B0 step product after
-	 * downloading IML image.
+	cnvi = ver->cnvi_top & 0xfff;
+	/* DSBR command needs to be sent for,
+	 * 1. BlazarI or BlazarIW + B0 step product in IML image.
+	 * 2. Gale Peak2 or BlazarU in OP image.
 	 */
-	apply_dsbr = (ver->img_type == BTINTEL_IMG_IML &&
-		((ver->cnvi_top & 0xfff) == BTINTEL_CNVI_BLAZARI) &&
-		INTEL_CNVX_TOP_STEP(ver->cnvi_top) == 0x01);
 
-	if (!apply_dsbr)
+	switch (cnvi) {
+	case BTINTEL_CNVI_BLAZARI:
+	case BTINTEL_CNVI_BLAZARIW:
+		if (ver->img_type == BTINTEL_IMG_IML &&
+		    INTEL_CNVX_TOP_STEP(ver->cnvi_top) == 0x01)
+			break;
+		return 0;
+	case BTINTEL_CNVI_GAP:
+	case BTINTEL_CNVI_BLAZARU:
+		if (ver->img_type == BTINTEL_IMG_OP &&
+		    hdev->bus == HCI_USB)
+			break;
 		return 0;
+	default:
+		return 0;
+	}
 
 	dsbr = 0;
 	err = btintel_uefi_get_dsbr(&dsbr);
diff --git a/drivers/bluetooth/btintel.h b/drivers/bluetooth/btintel.h
index b448c67e8ed9..fa43eb137821 100644
--- a/drivers/bluetooth/btintel.h
+++ b/drivers/bluetooth/btintel.h
@@ -53,6 +53,9 @@ struct intel_tlv {
 } __packed;
 
 #define BTINTEL_CNVI_BLAZARI		0x900
+#define BTINTEL_CNVI_BLAZARIW		0x901
+#define BTINTEL_CNVI_GAP		0x910
+#define BTINTEL_CNVI_BLAZARU		0x930
 
 #define BTINTEL_IMG_BOOTLOADER		0x01	/* Bootloader image */
 #define BTINTEL_IMG_IML			0x02	/* Intermediate image */
-- 
2.40.1

