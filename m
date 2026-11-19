Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795110059;
	b=hwhgVUEzK7TVvVIjS8x5WChQQ5u+Es4GP/K1FWIiqc9pSYUue5llLiMy1JVktpQWnLBt
	 aECJOC3X+HYBehA9ZCGR2xcBcBV9Oq+UOjxgoaUVllmp3S3XGUagXHLZrzC7nLy3vU40g
	 WxNA/tk0VqSO8dMGlbmsGXmeNBt7vxzC7XnD58Vgj2X2KG3e98OP/f+s1IGcfB3eWL8al
	 ybV7y/jd+x+6yEWOwNDcG+dJCUe9tq8zaUxAmd00rYUfcKyxiHBEGqUZdkiGny+TBReLp
	 s71ER9+Vbt19aAvurhXbu8xHzuUxHnVG4yug3Df15w3pF3Ac5USpgGKP7BK8rqIB1mw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795110059;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=Jc65HYYVpcVCP6bEIxGRv1EQZVgbxXkJFNoTQor6tQY=;
	b=GFWRAKPFaWM5mG2M/tUp2UYvEDhh3TIAm8c5sCmLrcXsafmvsmpvoWhz+3uhRZDX5jpB
	 t0E8vPP709E38CasEowRFMFgMc8UfJkKixiAlL6RgI56gg3HlK3KcyBPi3vNbtoYu1Q/k
	 smpsq9k1LNZxJT8tQzz5EsmlD+aSh6mscElB/sEkILpf2j2NdKk1sDqZhmRueH27B+S68
	 m78N7sOYDmnQo01C9Wjt2FtFujAIaxwJ7SYrtbo+PIMKXXmyvjE17YKdlL1T0+BSYyvU0
	 unReSCTIrxDkZhTsdvU8/GQy9GJVC7LctuwFY28gCc2akPR8hWArzh3unoVDRxIiCzA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=IF8lwhh8;
	arc=none smtp.remote-ip=198.175.65.9
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 663FB606A331
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Nov 2026 17:40:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 663FB606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=IF8lwhh8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795110058; x=1826646058;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=j93Z+eMlc/xmvw5eUjDrqzBwzELkcUsOrQZjfY3+Ppw=;
  b=IF8lwhh8ZbYcf4Ym5jOF5PSS0xdtg+rSaW2O37AlcTvd84zFfkVd5Tia
   VYIprV//wmV/yRsJBClEAXLiaC4gZelTMv5hOUzrRouqhg2FpVNWVB6eY
   azXjB/s/UX/mNFtPtVQMdwzro+FbhnGGfVuF+u9wDlLKuU5ZWdMOgHgXv
   w0PsNW8uupbThZLseV+di0hZRBySBLoGl68iEgFWlOksMCWf4lXfxKeQb
   3jyZWEm4u9/MtRwNVDHlXPiBY+ikXAScnzFBPgjGQT1T2mQlDS55ERP87
   MwDYuDttNhPt+ENhDzHdMljcQM+BGAg0doM9+Zf6kBru3f3XRtKzi5wxL
   A==;
X-CSE-ConnectionGUID: KrDhZb+rSWKfLZ0bNaU+Jg==
X-CSE-MsgGUID: yZ5bJfhuRRWxKGujXRTMeQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11971"; a="3818636"
X-IronPort-AV: E=Sophos;i="6.27,221,1787036400"; 
   d="scan'208";a="3818636"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2026 09:40:58 -0800
X-CSE-ConnectionGUID: I5edCf7YTwWhUBEM3jVaUQ==
X-CSE-MsgGUID: jIUMwZHUT5ikwN297lGpGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,221,1787036400"; 
   d="scan'208";a="12453014"
Received: from weba0957.iind.intel.com (HELO WEBA0932.iind.intel.com) ([10.224.186.34])
  by fmviesa013.fm.intel.com with ESMTP; 19 Nov 2026 09:40:57 -0800
From: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: chethan.tumkur.narayan@intel.com,
	kiran.k@intel.com,
	Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>
Subject: [PATCH v7 1/2] Bluetooth: btintel: Add TOP silent reset hooks
Date: Thu, 19 Nov 2026 23:10:12 +0530
Message-ID: <20261119174014.3355314-1-chandrashekar.devegowda@intel.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add an INTEL_TOP_RESET flag so btintel_boot() returns -ECANCELED and
the transport can run its own TOP silent reset instead of the Intel
soft reset. Cache boot_addr in struct btintel_data for the replay.

No functional change on its own.

Signed-off-by: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>
---
 drivers/bluetooth/btintel.c | 28 ++++++++++++++++++++++++++++
 drivers/bluetooth/btintel.h |  2 ++
 2 files changed, 30 insertions(+)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index 15c00d833f27..ea8ca4b95d95 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -1313,6 +1313,12 @@ static bool btintel_firmware_version(struct hci_dev *hdev,
 {
 	const u8 *fw_ptr;
 
+	if (hdev->bus == HCI_PCI) {
+		struct btintel_data *data = hci_get_priv(hdev);
+
+		data->boot_addr = 0;
+	}
+
 	fw_ptr = fw->data;
 
 	while (fw_ptr - fw->data < fw->size) {
@@ -1330,6 +1336,12 @@ static bool btintel_firmware_version(struct hci_dev *hdev,
 
 			*boot_addr = le32_to_cpu(params->boot_addr);
 
+			if (hdev->bus == HCI_PCI) {
+				struct btintel_data *data = hci_get_priv(hdev);
+
+				data->boot_addr = *boot_addr;
+			}
+
 			bt_dev_info(hdev, "Boot Address: 0x%x", *boot_addr);
 
 			bt_dev_info(hdev, "Firmware Version: %u-%u.%u",
@@ -2138,6 +2150,13 @@ static int btintel_boot(struct hci_dev *hdev, u32 boot_addr)
 	ktime_t calltime;
 	int err;
 
+	/* Let the transport replace the Intel soft reset for a TOP reset */
+	if (hdev->bus == HCI_PCI &&
+	    btintel_test_flag(hdev, INTEL_TOP_RESET)) {
+		bt_dev_info(hdev, "TOP reset pending, skipping Intel soft reset");
+		return -ECANCELED;
+	}
+
 	calltime = ktime_get();
 
 	btintel_set_flag(hdev, INTEL_BOOTING);
@@ -3908,6 +3927,7 @@ int btintel_bootloader_setup_tlv(struct hci_dev *hdev,
 	struct intel_version_tlv new_ver;
 	struct btintel_data *data = hci_get_priv(hdev);
 	u8 hw_variant = INTEL_HW_VARIANT(ver->cnvi_bt);
+	bool top_reset = btintel_test_flag(hdev, INTEL_TOP_RESET);
 
 	bt_dev_dbg(hdev, "");
 
@@ -3924,10 +3944,18 @@ int btintel_bootloader_setup_tlv(struct hci_dev *hdev,
 	for (int i = 0; i < __INTEL_NUM_FLAGS; i++)
 		btintel_clear_flag(hdev, i);
 
+	if (top_reset)
+		btintel_set_flag(hdev, INTEL_TOP_RESET);
+
 	btintel_set_flag(hdev, INTEL_BOOTLOADER);
 
 	data->unlocker = false;
 
+	if (top_reset && ver->img_type == BTINTEL_IMG_OP) {
+		bt_dev_err(hdev, "TOP reset requested on operational image");
+		return -EALREADY;
+	}
+
 	/* Legacy unlocker flow (BlazarI / BlazarIW / BlazarU / Gale Peak):
 	 * Boot ROM -> unlocker.sfi -> IML -> OPFW
 	 *
diff --git a/drivers/bluetooth/btintel.h b/drivers/bluetooth/btintel.h
index 372c6d7d8cbe..a59d642f096e 100644
--- a/drivers/bluetooth/btintel.h
+++ b/drivers/bluetooth/btintel.h
@@ -260,6 +260,7 @@ enum {
 	INTEL_ACPI_RESET_ACTIVE,
 	INTEL_WAIT_FOR_D0,
 	INTEL_UNLOCKER_LOADED,
+	INTEL_TOP_RESET,
 
 	__INTEL_NUM_FLAGS,
 };
@@ -268,6 +269,7 @@ struct btintel_data {
 	DECLARE_BITMAP(flags, __INTEL_NUM_FLAGS);
 	int (*acpi_reset_method)(struct hci_dev *hdev);
 	u32 cnvi_bt;
+	u32 boot_addr;
 	bool	unlocker;
 };
 
-- 
2.43.0

