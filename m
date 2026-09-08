Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8870434F48F
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Sep 2026 09:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788861457; cv=none; b=ieUVkUSG+Ott4pRMZw20SjW58v3fcu3uBz2OZWR7mVulBtjSvaShf5StTOoewf79Ij8Jfgv2jhssPoh5PUSgOeDjcr4ob0KQFHQeVTVl52EMizZrx/13ZKd7rsTZDKPySmwK1DfFFY25s+cz5+AAJsLKS5MB920nll5Sl4bX63k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788861457; c=relaxed/simple;
	bh=vDAqrASwk4UaaeRrJzVaV+Z6f8Gw5BXfjjZ1Pn7ZolQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AUp1g78mUCseFrfyVXf7JU+OdX7F9Zt/NcSsqM+e3A1vbxLcmPVWpN0BLLsgcZ0O6DgFBI2ILpm6huGHL/BBJzcxi/AM3eGiR4vPHkCFimWpQePfzopw+9hCnPIqPLuzoqdEBFc8j39x9WTrKH048lgahSbCF4ddWqlaQrLg3nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Vk1OiXuH; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Vk1OiXuH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788861456; x=1820397456;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=vDAqrASwk4UaaeRrJzVaV+Z6f8Gw5BXfjjZ1Pn7ZolQ=;
  b=Vk1OiXuHCABthwwXDq/3yZUfS6t0QWruVlM9Y+UVT34bIayGQ/9V1HY2
   BHPRgbcqQXAqesG6EFGuUrcJ0bB8sLG1M7SntUu5gWMG8h/8zCrwfkSB4
   SLD8sDvDv+jZiQkctCrU8Irh1LI3jUv2p//YUxEUclqoCLJacO5XGGNOw
   GcxCHVzZO3JcCvFXrkw0nK0ZFGbdZlwOSzR2yztny/Yv1XXNeEP55a+Rw
   d+FbLrHCLG8Xa8eYEumC/F06hLurUtaaozO+uFyl4RK8frVgKMC6t9Q+1
   SD+PfQtl/9sEEjbMpxLtLaEM+ijPxupnKgDKlE1i69p7+Yf5sGpqlBod1
   g==;
X-CSE-ConnectionGUID: 6BRe//NDTB6yEbxh8L+BqA==
X-CSE-MsgGUID: Vc9MTvDESie3HN8MonHyWQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11899"; a="89014831"
X-IronPort-AV: E=Sophos;i="6.25,268,1779174000"; 
   d="scan'208";a="89014831"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2026 02:57:35 -0700
X-CSE-ConnectionGUID: OYFDx6NfTQ+fwim/fnJpeQ==
X-CSE-MsgGUID: fmUxD1ncT3msNmEkvjd7QQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,268,1779174000"; 
   d="scan'208";a="267701094"
Received: from weba0957.iind.intel.com (HELO WEBA0932.iind.intel.com) ([10.224.186.34])
  by fmviesa007.fm.intel.com with ESMTP; 08 Sep 2026 02:57:33 -0700
From: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: ravishankar.srivatsa@intel.com,
	chethan.tumkur.narayan@intel.com,
	Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>
Subject: [PATCH v1] Bluetooth: btintel_pcie: validate TX skb length in send_sync
Date: Tue,  8 Sep 2026 15:26:58 +0530
Message-ID: <20260908095658.729390-1-chandrashekar.devegowda@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

btintel_pcie_prepare_tx() copies skb->len bytes into a fixed
BTINTEL_PCIE_BUFFER_SIZE (4096) DMA slot via an unchecked memcpy.
Oversized packets are currently rejected only in
btintel_pcie_send_frame(); any future caller of
btintel_pcie_send_sync() would silently overflow the DMA buffer.

Add the bounds check in btintel_pcie_send_sync() itself, right
before skb_push() and the DMA copy.

Assisted-by: Copilot:claude-sonnet-5 code-review code-generation
Fixes: 6e65a09f9275 ("Bluetooth: btintel_pcie: Add *setup* function to download firmware")
Signed-off-by: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>
---
 drivers/bluetooth/btintel_pcie.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index 04f5b0273977..68d8e378ce7e 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -536,6 +536,12 @@ static int btintel_pcie_send_sync(struct btintel_pcie_data *data,
 	if (tfd_index > txq->count)
 		return -ERANGE;
 
+	if (skb->len > BTINTEL_PCIE_BUFFER_SIZE - BTINTEL_PCIE_HCI_TYPE_LEN) {
+		bt_dev_err(hdev, "TX skb too large (%u > %u)", skb->len,
+			   BTINTEL_PCIE_BUFFER_SIZE - BTINTEL_PCIE_HCI_TYPE_LEN);
+		return -EMSGSIZE;
+	}
+
 	/* Firmware raises alive interrupt on HCI_OP_RESET or
 	 * BTINTEL_HCI_OP_RESET
 	 */
-- 
2.43.0

