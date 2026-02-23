Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC3063254A9
	for <linux-bluetooth@vger.kernel.org>; Mon, 23 Feb 2026 17:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771866151; cv=none; b=adcjhEPrO0hJUe1v3PzLO7PMxrRqbo+UBl/RKfjTdzse/ChaMNhir8qDcXPdOtC12U7dEo2DKasRI2DvKkNhe8ufY7vUVOWQU3w5UN0AYNvra0zO7OgrD9iXQYclL406yOKu/VktQs4zJLI+coTYxsERV9vtDnR6siq0zaNPtUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771866151; c=relaxed/simple;
	bh=NVl3ZOd+PZeKtjwjY702g84lATYXDN9a/RJPNZWfSXw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WyEsNHt1+nTh3fPb09/o2kJajV0EKkAz7+wLjYj9Eks7fb9S37L2zGC8cp0sW3OyTr/oxQuzmoTkCkAMD0N6ixj+6PpAVu7gohlC1/2AxPUbOQRZ2eVS2ChSgPe25pxBfQXYWEG+Nb01D0xhtEMGOxiAVy8Psqu+1rnW0D/L99Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=npiUqHtc; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="npiUqHtc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771866149; x=1803402149;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NVl3ZOd+PZeKtjwjY702g84lATYXDN9a/RJPNZWfSXw=;
  b=npiUqHtcmcm5Ucdfa5B/7SR3eYQqdObHNESsOb8mAsV8pN+v9WG1Zuim
   OxjSAU2i3vp+QH/gPFsyPS9dEyWsAN3nJEdbNfqjh64QggPqmyQVlFYrb
   JIxMrru3KQ9ZrxO5zhRZjvi6wNgJ/DdNoFsMWcKz32B5zNxCVCvavVB42
   MZdkQo2hFso+/Lpvhc6M4ZZ1n5rXPWJ9w6Cd/mMKVc/4PlJUdvNMjFH8L
   LZlmuDUMVmy5NckKX6eHb3iGPhGr38ExEuZd4Pxos6s7s/bvih9uzQV84
   KhziJjunfcu1PYlq8TbmXyUa91pwtwfCwHbT3ECxk1xjnuOkVXxGEaPE1
   Q==;
X-CSE-ConnectionGUID: lQqGOtcERhm7/bj3s9i+Rw==
X-CSE-MsgGUID: k5DM6cSES2W/2OiUjk/xdg==
X-IronPort-AV: E=McAfee;i="6800,10657,11710"; a="95484468"
X-IronPort-AV: E=Sophos;i="6.21,307,1763452800"; 
   d="scan'208";a="95484468"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2026 09:02:28 -0800
X-CSE-ConnectionGUID: Kn8fNgR8QOyZd8H+eoME4w==
X-CSE-MsgGUID: g8CrA8eeTKmMnuJPew5opA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,307,1763452800"; 
   d="scan'208";a="214698334"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by orviesa006.jf.intel.com with ESMTP; 23 Feb 2026 09:02:22 -0800
From: Kiran K <kiran.k@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: ravishankar.srivatsa@intel.com,
	chandrashekar.devegowda@intel.com,
	chethan.tumkur.narayan@intel.com,
	Kiran K <kiran.k@intel.com>
Subject: [PATCH v1 2/7] Bluetooth: btintel: Replace CNVi id with hardware variant
Date: Mon, 23 Feb 2026 22:50:58 +0530
Message-ID: <20260223172104.167471-2-kiran.k@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260223172104.167471-1-kiran.k@intel.com>
References: <20260223172104.167471-1-kiran.k@intel.com>
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
index 431998049e68..21c9a6c9eb9e 100644
--- a/drivers/bluetooth/btintel.h
+++ b/drivers/bluetooth/btintel.h
@@ -69,6 +69,13 @@ struct intel_tlv {
 
 #define BTINTEL_FWID_MAXLEN 64
 
+/* Hardware ID */
+#define BTINTEL_HWID_GAP	0x1c
+#define BTINTEL_HWID_BZRI	0x1e
+#define BTINTEL_HWID_BZRU	0x1d
+#define BTINTEL_HWID_SCP	0x1f
+#define BTINTEL_HWID_BZRIW	0x22
+
 struct intel_version_tlv {
 	u32	cnvi_top;
 	u32	cnvr_top;
-- 
2.43.0

