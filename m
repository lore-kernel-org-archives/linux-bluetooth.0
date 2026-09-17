Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B1F370ADB
	for <linux-bluetooth@vger.kernel.org>; Thu, 17 Sep 2026 04:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789618111; cv=none; b=DkQVZA66dVLvblMALV8rmW2RzgoY/OfcPntXNlDRwJjK4f+CkX66d6O+bGxAoLHtx5YIkY1unJvfTNexyWHrw6pQ2d20IG8wAGmAbryHuYvyOpLyHjFOchqeMIiDvsOLqTARLn+LcGS5o7du9mnluMYDGqrK5H5U3rdyx2Vhi7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789618111; c=relaxed/simple;
	bh=K6Ok+VuyV1lVoRl6gUnQARkYCg8xo5CBN2mmAVjLGoE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=En50Op4duoORaoSqkU+p/Ol5YtET7iImI1SR4ScA7vLMxDTar3mHu0UUvMpQnQ0yfYenPmimZEb29srM4BGJSfAHMhHMUhw0H0HptEWpfkrxpqED3RzS/9txTuZl2QC6Yy5YFfMOVRoD6pQ3vYizpL+Hc9vrZ1wfZ5wFU7VxCGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=chEtn2nt; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="chEtn2nt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789618108; x=1821154108;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=K6Ok+VuyV1lVoRl6gUnQARkYCg8xo5CBN2mmAVjLGoE=;
  b=chEtn2ntng8Kg7EwWCcIWi9Bru1OPRtyhh5X53+bhnYh3HeVsvcrvOcH
   RPnkDDLbG7UkY4UA7cZx4/DxPxJtvjc6g4hVsTp9pzNWiAisKur9nz03a
   ROq2UbbVEyVIJTOJe07XWLGGfZCG2KxrX6v2EinEb+9WikmDeSklQ2zTT
   5Exl/X0iiTlHouCS/LN6YgZSo62tyqy6OIWczo1+TE0fxGMU/yGoX8H+W
   7ihWbZHzNazW5uYzxVGbgaZjUF5h+sQJt5b+us4Ia5fCP0vXqkdod2pFM
   FaOVaaJs4oH8JOTz8ZF0wA95huMXpk+3VH2xkMhromdesqTWWsZlyqcVt
   Q==;
X-CSE-ConnectionGUID: AuFeRhY6Sjaq+g/exfSiUA==
X-CSE-MsgGUID: SjEGs2jhRLC5MtCkTHC4YA==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="101343320"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="101343320"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2026 21:08:27 -0700
X-CSE-ConnectionGUID: f0wMu/j0REiqvIIToIECuQ==
X-CSE-MsgGUID: Nkn3eGxkRvGr5jJlRkGD0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="269274885"
Received: from unknown (HELO WEBA2062.iind.intel.com) ([10.66.228.2])
  by fmviesa006.fm.intel.com with ESMTP; 16 Sep 2026 21:06:25 -0700
From: Ravindra <ravindra@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: chethan.tumkur.narayan@intel.com,
	kiran.k@intel.com,
	Ravindra <ravindra@intel.com>
Subject: [PATCH v1] Bluetooth: btintel: read ROM debug registers on FW download failure
Date: Thu, 17 Sep 2026 09:38:53 +0530
Message-ID: <20260917040853.2719484-1-ravindra@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The bootloader records init sequence progress and debug information in
four core debug registers, which helps debugging FW download failures.

Add btintel_get_rom_debug_info() to issue the vendor-specific HCI
command BTINTEL_GET_ROM_DEBUG_INFO (0xfcde) and log these registers, and
invoke it from the error path in btintel_prepare_fw_download_tlv()
before resetting to the bootloader.

Signed-off-by: Ravindra <ravindra@intel.com>
---
 drivers/bluetooth/btintel.c | 40 +++++++++++++++++++++++++++++++++++++
 drivers/bluetooth/btintel.h |  9 +++++++++
 2 files changed, 49 insertions(+)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index 964d2de30e65..15366a6b54c6 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -963,6 +963,43 @@ int btintel_send_intel_reset(struct hci_dev *hdev, u32 boot_param)
 }
 EXPORT_SYMBOL_GPL(btintel_send_intel_reset);
 
+static void btintel_get_rom_debug_info(struct hci_dev *hdev)
+{
+	struct btintel_rp_get_rom_debug_info *rom_debug_info;
+	struct sk_buff *skb;
+
+	skb = __hci_cmd_sync(hdev, BTINTEL_GET_ROM_DEBUG_INFO, 0, NULL,
+			     HCI_CMD_TIMEOUT);
+	if (IS_ERR(skb)) {
+		bt_dev_err(hdev, "Failed to send intel get rom debug info command (%ld)",
+			   PTR_ERR(skb));
+		return;
+	}
+
+	if (skb->len != sizeof(*rom_debug_info)) {
+		bt_dev_err(hdev, "Intel get rom debug info command parameters size mismatch");
+		kfree_skb(skb);
+		return;
+	}
+
+	rom_debug_info = (struct btintel_rp_get_rom_debug_info *)skb->data;
+
+	if (rom_debug_info->status) {
+		bt_dev_err(hdev, "Intel get rom debug info command failed (%02x)",
+			   rom_debug_info->status);
+		kfree_skb(skb);
+		return;
+	}
+
+	bt_dev_info(hdev, "Intel get rom debug info: dr0:0x%08x dr1:0x%08x dr2:0x%08x dr3:0x%08x",
+		    le32_to_cpu(rom_debug_info->debug_reg0),
+		    le32_to_cpu(rom_debug_info->debug_reg1),
+		    le32_to_cpu(rom_debug_info->debug_reg2),
+		    le32_to_cpu(rom_debug_info->debug_reg3));
+
+	kfree_skb(skb);
+}
+
 int btintel_read_boot_params(struct hci_dev *hdev,
 			     struct intel_boot_params *params)
 {
@@ -2465,6 +2502,9 @@ static int btintel_prepare_fw_download_tlv(struct hci_dev *hdev,
 			goto done;
 		}
 
+		/* FW download failed, hence collecting rom debug info */
+		btintel_get_rom_debug_info(hdev);
+
 		/* When FW download fails, send Intel Reset to retry
 		 * FW download.
 		 */
diff --git a/drivers/bluetooth/btintel.h b/drivers/bluetooth/btintel.h
index c00f793d9dc8..dedda3e77487 100644
--- a/drivers/bluetooth/btintel.h
+++ b/drivers/bluetooth/btintel.h
@@ -178,6 +178,15 @@ struct hci_ppag_enable_cmd {
 	__le32	ppag_enable_flags;
 } __packed;
 
+#define BTINTEL_GET_ROM_DEBUG_INFO	0xFCDE
+struct btintel_rp_get_rom_debug_info {
+	__u8	status;
+	__le32	debug_reg0;
+	__le32	debug_reg1;
+	__le32	debug_reg2;
+	__le32	debug_reg3;
+} __packed;
+
 #define INTEL_TLV_TYPE_ID		0x01
 
 #define INTEL_TLV_SYSTEM_EXCEPTION	0x00
-- 
2.43.0

