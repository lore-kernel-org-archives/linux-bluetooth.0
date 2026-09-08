Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD7D75437C7
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Sep 2026 13:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788873267; cv=none; b=HxNL65ItrGl+zKmtnsEBhRRUNNqEUos3aWsRPiwGPqfJlYpY5ljICmuR9Yv8XO3aypbot7P4uKrLM29FH3kY2SN1k/f/o/kDOLDPW28DwTDLigKuyvfflfMBe4uh+PRGBxZ9G+AftQB5sm04K5JMZ3P0OYYGbtYsmw77eWiNNuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788873267; c=relaxed/simple;
	bh=T48Q6sHPW9Dlqghj9sjPN+lFvAnDiayi9le5cIWG53I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Is6bTB8VHXjFVEWksSRSt99LiCgwqMbYfHZ8sBCK+ASsp4OI6eJIFYTwtYQh/+4aqj8Ov39MvUifoI++jSAUCye64nVmxoMB6cZXcLe+qrFM5TD/fSuhQUGPWED/+UeVFFqoRlcfpVQK/iEwqT0qmb+/DIn/ZaR+/SvzT4RFp0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i8cleRhz; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i8cleRhz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788873261; x=1820409261;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=T48Q6sHPW9Dlqghj9sjPN+lFvAnDiayi9le5cIWG53I=;
  b=i8cleRhzQbyIudTYf5JspdVp0PUXWP7Q2mcVbCsWJGf7serU3Eh10Ng9
   og6Usudzze7AdArmM0IE83GGTah9+9Vr6j1BbdWvndvFFFvM7XGevuJfK
   4wG2WOlVhSAL0MUEL7fXZYfthJIHsN2IvyXmfAmvw9SeytfH7mbRyoc/P
   R0jMXKlHMNr+XXjJPJjInkxQPFFgr184iz3PMv8mAtzhtshNOqrCJf8l8
   3d+u98OsZjL5wSYuk4GMj0BRrL7Lj1SemwkCXbGOxwZ1Txjj0gosdKlF6
   k91tyKwzS3+e+W0/HNAu+hWAvljUv7TakVTa4UZ15jZIfUk3ZZwFhEuaZ
   A==;
X-CSE-ConnectionGUID: WPvA/O5dRzK3M90RDfVJQw==
X-CSE-MsgGUID: tKwe7WnvQVGS3dtpkhgTBA==
X-IronPort-AV: E=McAfee;i="6800,10657,11899"; a="99934615"
X-IronPort-AV: E=Sophos;i="6.25,268,1779174000"; 
   d="scan'208";a="99934615"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2026 06:14:14 -0700
X-CSE-ConnectionGUID: zOpMdSC9Tuq7nv/BMjO9Bw==
X-CSE-MsgGUID: 6Z28gHWBSzmM2y5uAJd6GQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,268,1779174000"; 
   d="scan'208";a="274795727"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by orviesa004.jf.intel.com with ESMTP; 08 Sep 2026 06:14:12 -0700
From: Kiran K <kiran.k@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: ravishankar.srivatsa@intel.com,
	chethan.tumkur.narayan@intel.com,
	chandrashekar.devegowda@intel.com,
	Kiran K <kiran.k@intel.com>
Subject: [PATCH v1] Bluetooth: btintel_pcie: cap device debug regions at 1 MB
Date: Tue,  8 Sep 2026 19:04:21 +0530
Message-ID: <20260908133421.163043-1-kiran.k@intel.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Validate device-supplied debug-region boundaries during mailbox TLV
parsing and convert start/end values to a validated region size. Cap
debug-region sizes to 1 MB to prevent out-of-bounds reads if firmware
reports oversized memory ranges. Skip invalid or oversized regions
prior to coredump capture.

This issue was reported by Claude Mythos.

Fixes: 755cf7adf8dd ("Bluetooth: btintel_pcie: unified decoder coredump format")
Assisted-by: Copilot:claude-opus-4.7
Signed-off-by: Kiran K <kiran.k@intel.com>
---
 drivers/bluetooth/btintel_pcie.c | 229 ++++++++++++++++---------------
 drivers/bluetooth/btintel_pcie.h |  16 +--
 2 files changed, 128 insertions(+), 117 deletions(-)

diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index 04f5b0273977..652777d1026f 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -960,13 +960,6 @@ static int btintel_pcie_dump_target_region(struct btintel_pcie_data *data,
 		return 1;
 	}
 
-	if (size > BTINTEL_PCIE_REGION_MAX_SIZE) {
-		bt_dev_warn(data->hdev,
-			    "Skipping dump region %s: size %u exceeds max %u",
-			    name, size, BTINTEL_PCIE_REGION_MAX_SIZE);
-		return 1;
-	}
-
 	if (addr_start > U32_MAX - size) {
 		bt_dev_warn(data->hdev,
 			    "Skipping dump region %s: addr_start 0x%08x + size %u would overflow",
@@ -1196,28 +1189,10 @@ static bool btintel_pcie_is_mdbgc_supported(struct btintel_pcie_data *data)
 static void btintel_pcie_dump_mem_range(struct btintel_pcie_data *data,
 					struct list_head *list, u32 region_id,
 					const char *name, u32 addr_start,
-					u32 addr_end, u64 *regions_mask)
+					u32 region_size, u64 *regions_mask)
 {
-	u32 region_size;
-
-	if (!addr_start || !addr_end || addr_end < addr_start)
-		return;
-
-	if (addr_end > U32_MAX - 0x04) {
-		bt_dev_warn(data->hdev,
-			    "Skipping dump region %s: addr_end 0x%08x would overflow",
-			    name, addr_end);
-		return;
-	}
-
-	region_size = (addr_end + 0x04) - addr_start;
-	if (region_size > BTINTEL_PCIE_REGION_MAX_SIZE) {
-		bt_dev_warn(data->hdev,
-			    "Skipping dump region %s: size %u exceeds max %u",
-			    name, region_size,
-			    BTINTEL_PCIE_REGION_MAX_SIZE);
+	if (!region_size)
 		return;
-	}
 
 	if (!btintel_pcie_dump_target_region(data, list, region_id, name,
 					     addr_start, region_size))
@@ -1228,16 +1203,14 @@ static int btintel_pcie_read_debug_regions(struct btintel_pcie_data *data)
 {
 	struct btintel_pcie_dbgc *dbgc = NULL;
 	struct btintel_pcie_mdbgc *mdbgc = NULL;
+	struct btintel_pcie_dump_mem_info *dump_info = &data->dump_info;
 	struct hci_dev *hdev = data->hdev;
 	struct btintel_pcie_dump_entry *entry;
 	struct btintel_pcie_dump_file_hdr *file_hdr;
 	struct scatterlist *sg_dump_data;
 	u32 status_reg, wrap_reg;
-	u32 exception_dump_len;
-	u32 exc_addr;
 	u64 regions_mask = 0;
 	u8 hw_variant;
-	u32 smem_rd_addr = 0, smem_rd_size = 0;
 	u32 file_len;
 	u8 count;
 	int ret;
@@ -1270,35 +1243,6 @@ static int btintel_pcie_read_debug_regions(struct btintel_pcie_data *data)
 		return -EINVAL;
 	}
 
-	smem_rd_addr = data->dump_info.smem_addr_start;
-	smem_rd_size = 0;
-
-	if (!smem_rd_addr && !data->dump_info.smem_addr_end) {
-		bt_dev_dbg(hdev, "smem region not advertised by firmware");
-	} else if (data->dump_info.smem_addr_end < smem_rd_addr ||
-		   data->dump_info.smem_addr_end > U32_MAX - 0x04) {
-		bt_dev_err(hdev,
-			   "Invalid smem region: start=0x%08x end=0x%08x",
-			   smem_rd_addr, data->dump_info.smem_addr_end);
-	} else {
-		smem_rd_size = (data->dump_info.smem_addr_end + 0x04) -
-			       smem_rd_addr;
-
-		bt_dev_dbg(hdev,
-			   "smem_region: smem_start_addr=0x%08x smem_end_addr=0x%08x smem_rd_size=%u",
-			   smem_rd_addr, data->dump_info.smem_addr_end,
-			   smem_rd_size);
-
-		if (smem_rd_size == 0 ||
-		    smem_rd_size > BTINTEL_PCIE_SMEM_MAX_SIZE) {
-			bt_dev_err(hdev,
-				   "Invalid smem region: smem_rd_addr 0x%08x size %u (max %u)",
-				   smem_rd_addr, smem_rd_size,
-				   BTINTEL_PCIE_SMEM_MAX_SIZE);
-			smem_rd_size = 0;
-		}
-	}
-
 	if (btintel_pcie_is_mdbgc_supported(data)) {
 		ret = btintel_pcie_dump_dram_monitor(data, &dump_list, count,
 						     mdbgc->buf1, status_reg,
@@ -1350,47 +1294,46 @@ static int btintel_pcie_read_debug_regions(struct btintel_pcie_data *data)
 				    "Failed to dump DRAM region: %d", ret);
 	}
 
-	if (smem_rd_size &&
+	if (dump_info->smem_size &&
 	    !btintel_pcie_dump_smem_monitor_region(data, &dump_list,
 						   BTINTEL_PCIE_INI_ID_SMEM,
 						   "monitor_smem",
-						   smem_rd_addr,
-						   smem_rd_size))
+						   dump_info->smem_addr_start,
+						   dump_info->smem_size))
 		regions_mask |= BIT_ULL(BTINTEL_PCIE_INI_ID_SMEM);
 
-	exc_addr = data->dump_info.exception_dump_addr;
-	exception_dump_len = data->dump_info.exception_dump_len;
-	if (exc_addr && exception_dump_len) {
+	if (dump_info->exception_dump_addr && dump_info->exception_dump_len) {
 		ret = btintel_pcie_dump_target_region(data, &dump_list,
 						      BTINTEL_PCIE_INI_ID_EXCEPTION_EVT,
-						      "EXCEPTION_EVT_BUFFER", exc_addr,
-						      exception_dump_len);
+						      "EXCEPTION_EVT_BUFFER",
+						      dump_info->exception_dump_addr,
+						      dump_info->exception_dump_len);
 		if (!ret)
 			regions_mask |= BIT_ULL(BTINTEL_PCIE_INI_ID_EXCEPTION_EVT);
 	}
 
 	btintel_pcie_dump_mem_range(data, &dump_list,
 				    BTINTEL_PCIE_INI_ID_DCCM, "DCCM",
-				    data->dump_info.dccm_addr_start,
-				    data->dump_info.dccm_addr_end,
+				    dump_info->dccm_addr_start,
+				    dump_info->dccm_size,
 				    &regions_mask);
 
 	btintel_pcie_dump_mem_range(data, &dump_list,
 				    BTINTEL_PCIE_INI_ID_SDS, "SDS",
-				    data->dump_info.sds_start_addr_start,
-				    data->dump_info.sds_start_addr_end,
+				    dump_info->sds_start_addr_start,
+				    dump_info->sds_start_size,
 				    &regions_mask);
 
 	btintel_pcie_dump_mem_range(data, &dump_list,
 				    BTINTEL_PCIE_INI_ID_SDS_IOSF, "SDS_IOSF",
-				    data->dump_info.sds_iosf_data_addr_start,
-				    data->dump_info.sds_iosf_data_addr_end,
+				    dump_info->sds_iosf_data_addr_start,
+				    dump_info->sds_iosf_data_size,
 				    &regions_mask);
 
 	btintel_pcie_dump_mem_range(data, &dump_list,
 				    BTINTEL_PCIE_INI_ID_ECL, "ECL_REGION",
-				    data->dump_info.ecl_addr_start,
-				    data->dump_info.ecl_addr_end,
+				    dump_info->ecl_addr_start,
+				    dump_info->ecl_size,
 				    &regions_mask);
 
 	ret = btintel_pcie_dump_info(data, &dump_list, regions_mask);
@@ -1593,6 +1536,34 @@ static inline bool btintel_pcie_in_error(struct btintel_pcie_data *data)
 	return	data->boot_stage_cache & BTINTEL_PCIE_CSR_BOOT_STAGE_ABORT_HANDLER;
 }
 
+static u32 btintel_pcie_region_size(struct hci_dev *hdev, const char *name,
+				    u32 start, u32 end)
+{
+	u64 size;
+
+	if (!start || !end)
+		return 0;
+
+	if (end < start) {
+		bt_dev_warn(hdev, "%s region invalid: start=0x%08x end=0x%08x",
+			    name, start, end);
+		return 0;
+	}
+
+	size = (u64)end + 0x04 - start;
+	if (size % sizeof(u32))
+		bt_dev_warn(hdev, "%s region size %llu is not 4-byte aligned",
+			    name, size);
+
+	if (size > BTINTEL_PCIE_REGION_MAX_SIZE) {
+		bt_dev_warn(hdev, "%s region size %llu exceeds cap %u, ignoring",
+			    name, size, BTINTEL_PCIE_REGION_MAX_SIZE);
+		return 0;
+	}
+
+	return (u32)size;
+}
+
 static const char *btintel_pcie_tlv_str(u8 tlv_type)
 {
 	switch (tlv_type) {
@@ -1720,6 +1691,15 @@ static int btintel_parse_mbox_tlv(struct btintel_pcie_data *data)
 				get_unaligned_le32(&tlv->val[0]);
 			data->dump_info.exception_dump_len =
 				get_unaligned_le32(&tlv->val[4]);
+			if (data->dump_info.exception_dump_len >
+			    BTINTEL_PCIE_REGION_MAX_SIZE) {
+				bt_dev_warn(data->hdev,
+					    "EXCEPTION_EVT_BUFFER size %u exceeds cap %u, ignoring",
+					    data->dump_info.exception_dump_len,
+					    BTINTEL_PCIE_REGION_MAX_SIZE);
+				data->dump_info.exception_dump_addr = 0;
+				data->dump_info.exception_dump_len = 0;
+			}
 			break;
 		case BTINTEL_PCIE_TLV_TYPE_DCCM_MEM_ADDRESS:
 			if (tlv_len < 8) {
@@ -1731,10 +1711,16 @@ static int btintel_parse_mbox_tlv(struct btintel_pcie_data *data)
 			}
 			data->dump_info.dccm_addr_start =
 				get_unaligned_le32(&tlv->val[0]);
-			data->dump_info.dccm_addr_end =
-				get_unaligned_le32(&tlv->val[4]);
+			data->dump_info.dccm_size =
+				btintel_pcie_region_size(data->hdev, "DCCM",
+							 data->dump_info.dccm_addr_start,
+							 get_unaligned_le32(&tlv->val[4]));
+			if (!data->dump_info.dccm_size)
+				data->dump_info.dccm_addr_start = 0;
 			break;
-		case BTINTEL_PCIE_TLV_TYPE_SDS_MEM_ADDRESS:
+		case BTINTEL_PCIE_TLV_TYPE_SDS_MEM_ADDRESS: {
+			struct btintel_pcie_dump_mem_info *di = &data->dump_info;
+
 			/* hw_variant comes from cnvi_bt which is set during
 			 * setup. If mailbox fires before setup completes,
 			 * hw_variant is 0. Skip SDS parsing in that case.
@@ -1744,35 +1730,52 @@ static int btintel_parse_mbox_tlv(struct btintel_pcie_data *data)
 				break;
 			}
 			if (tlv_len == 16 && hw_variant > BTINTEL_HWID_BZRI) {
-				data->dump_info.sds_start_addr_start =
+				di->sds_start_addr_start =
 					get_unaligned_le32(&tlv->val[0]);
-				data->dump_info.sds_start_addr_end =
-					get_unaligned_le32(&tlv->val[4]);
-				data->dump_info.sds_iosf_data_addr_start =
+				di->sds_start_size =
+					btintel_pcie_region_size(data->hdev, "SDS",
+								 di->sds_start_addr_start,
+								 get_unaligned_le32(&tlv->val[4]));
+				di->sds_iosf_data_addr_start =
 					get_unaligned_le32(&tlv->val[8]);
-				data->dump_info.sds_iosf_data_addr_end =
-					get_unaligned_le32(&tlv->val[12]);
+				di->sds_iosf_data_size =
+					btintel_pcie_region_size(data->hdev, "SDS_IOSF",
+								 di->sds_iosf_data_addr_start,
+								 get_unaligned_le32(&tlv->val[12]));
 			} else if (tlv_len == 24 &&
 				   (hw_variant == BTINTEL_HWID_BZRI ||
 				    hw_variant == BTINTEL_HWID_BZRIW)) {
-				data->dump_info.sds_fixed_rom_addr_start =
+				di->sds_fixed_rom_addr_start =
 					get_unaligned_le32(&tlv->val[0]);
-				data->dump_info.sds_fixed_rom_addr_end =
-					get_unaligned_le32(&tlv->val[4]);
-				data->dump_info.sds_start_addr_start =
+				di->sds_fixed_rom_size =
+					btintel_pcie_region_size(data->hdev, "SDS_FIXED_ROM",
+								 di->sds_fixed_rom_addr_start,
+								 get_unaligned_le32(&tlv->val[4]));
+				di->sds_start_addr_start =
 					get_unaligned_le32(&tlv->val[8]);
-				data->dump_info.sds_start_addr_end =
-					get_unaligned_le32(&tlv->val[12]);
-				data->dump_info.sds_iosf_data_addr_start =
+				di->sds_start_size =
+					btintel_pcie_region_size(data->hdev, "SDS",
+								 di->sds_start_addr_start,
+								 get_unaligned_le32(&tlv->val[12]));
+				di->sds_iosf_data_addr_start =
 					get_unaligned_le32(&tlv->val[16]);
-				data->dump_info.sds_iosf_data_addr_end =
-					get_unaligned_le32(&tlv->val[20]);
+				di->sds_iosf_data_size =
+					btintel_pcie_region_size(data->hdev, "SDS_IOSF",
+								 di->sds_iosf_data_addr_start,
+								 get_unaligned_le32(&tlv->val[20]));
 			} else {
 				bt_dev_err(data->hdev,
 					   "SDS TLV: hw=0x%2.2x len=%u",
 					   hw_variant, tlv_len);
 			}
+			if (!di->sds_start_size)
+				di->sds_start_addr_start = 0;
+			if (!di->sds_iosf_data_size)
+				di->sds_iosf_data_addr_start = 0;
+			if (!di->sds_fixed_rom_size)
+				di->sds_fixed_rom_addr_start = 0;
 			break;
+		}
 		case BTINTEL_PCIE_TLV_TYPE_ECL_MEM_ADDRESS:
 			if (tlv_len < 8) {
 				bt_dev_err(data->hdev,
@@ -1783,8 +1786,12 @@ static int btintel_parse_mbox_tlv(struct btintel_pcie_data *data)
 			}
 			data->dump_info.ecl_addr_start =
 				get_unaligned_le32(&tlv->val[0]);
-			data->dump_info.ecl_addr_end =
-				get_unaligned_le32(&tlv->val[4]);
+			data->dump_info.ecl_size =
+				btintel_pcie_region_size(data->hdev, "ECL",
+							 data->dump_info.ecl_addr_start,
+							 get_unaligned_le32(&tlv->val[4]));
+			if (!data->dump_info.ecl_size)
+				data->dump_info.ecl_addr_start = 0;
 			break;
 		case BTINTEL_PCIE_TLV_TYPE_SMEM_ADDRESS:
 			if (tlv_len < 8) {
@@ -1796,8 +1803,12 @@ static int btintel_parse_mbox_tlv(struct btintel_pcie_data *data)
 			}
 			data->dump_info.smem_addr_start =
 				get_unaligned_le32(&tlv->val[0]);
-			data->dump_info.smem_addr_end =
-				get_unaligned_le32(&tlv->val[4]);
+			data->dump_info.smem_size =
+				btintel_pcie_region_size(data->hdev, "SMEM",
+							 data->dump_info.smem_addr_start,
+							 get_unaligned_le32(&tlv->val[4]));
+			if (!data->dump_info.smem_size)
+				data->dump_info.smem_addr_start = 0;
 			break;
 		default:
 			bt_dev_dbg(data->hdev, "Unknown TLV type: %u length: %u",
@@ -1815,29 +1826,29 @@ static int btintel_parse_mbox_tlv(struct btintel_pcie_data *data)
 		   data->dump_info.exception_dump_addr,
 		   data->dump_info.exception_dump_len);
 	bt_dev_info(data->hdev,
-		   "dccm: start:0x%08x end:0x%08x",
+		   "dccm: start:0x%8.8x size:%u",
 		   data->dump_info.dccm_addr_start,
-		   data->dump_info.dccm_addr_end);
+		   data->dump_info.dccm_size);
 	bt_dev_info(data->hdev,
-		   "sds_fixed_rom: start:0x%08x end:0x%08x",
+		   "sds_fixed_rom: start:0x%8.8x size:%u",
 		   data->dump_info.sds_fixed_rom_addr_start,
-		   data->dump_info.sds_fixed_rom_addr_end);
+		   data->dump_info.sds_fixed_rom_size);
 	bt_dev_info(data->hdev,
-		   "sds: start:0x%08x end:0x%08x",
+		   "sds: start:0x%8.8x size:%u",
 		   data->dump_info.sds_start_addr_start,
-		   data->dump_info.sds_start_addr_end);
+		   data->dump_info.sds_start_size);
 	bt_dev_info(data->hdev,
-		   "sds_iosf: start:0x%08x end:0x%08x",
+		   "sds_iosf: start:0x%8.8x size:%u",
 		   data->dump_info.sds_iosf_data_addr_start,
-		   data->dump_info.sds_iosf_data_addr_end);
+		   data->dump_info.sds_iosf_data_size);
 	bt_dev_info(data->hdev,
-		   "ecl: start:0x%08x end:0x%08x",
+		   "ecl: start:0x%8.8x size:%u",
 		   data->dump_info.ecl_addr_start,
-		   data->dump_info.ecl_addr_end);
+		   data->dump_info.ecl_size);
 	bt_dev_info(data->hdev,
-		   "smem: start:0x%08x end:0x%08x",
+		   "smem: start:0x%8.8x size:%u",
 		   data->dump_info.smem_addr_start,
-		   data->dump_info.smem_addr_end);
+		   data->dump_info.smem_size);
 
 	vfree(buffer);
 	return 0;
diff --git a/drivers/bluetooth/btintel_pcie.h b/drivers/bluetooth/btintel_pcie.h
index 9d84db48a8e5..f35f80f800ed 100644
--- a/drivers/bluetooth/btintel_pcie.h
+++ b/drivers/bluetooth/btintel_pcie.h
@@ -76,8 +76,8 @@
 #define BTINTEL_PCIE_DBGC_DBGBUFF_WRAP_ARND_SCP		(BTINTEL_PCIE_DBGC_BASE_ADDR_SCP + 0x2C)
 #define BTINTEL_PCIE_DBGC_ALLOCATION_OFFSET		0x100
 
-#define BTINTEL_PCIE_SMEM_MAX_SIZE		(16 * 1024)
-#define BTINTEL_PCIE_REGION_MAX_SIZE		(16 * 1024 * 1024)
+/* Upper bound for device-supplied debug-region sizes. */
+#define BTINTEL_PCIE_REGION_MAX_SIZE		(1 * 1024 * 1024)
 #define BTINTEL_PCIE_DBG_IDX_BIT_MASK		0x0F
 #define BTINTEL_PCIE_DBGC_DBG_BUF_IDX(data)	(((data) >> 24) & BTINTEL_PCIE_DBG_IDX_BIT_MASK)
 #define BTINTEL_PCIE_DBG_OFFSET_BIT_MASK	0xFFFFFF
@@ -497,17 +497,17 @@ struct btintel_pcie_dump_mem_info {
 	u32	exception_dump_addr;
 	u32	exception_dump_len;
 	u32	dccm_addr_start;
-	u32	dccm_addr_end;
+	u32	dccm_size;
 	u32	sds_fixed_rom_addr_start;
-	u32	sds_fixed_rom_addr_end;
+	u32	sds_fixed_rom_size;
 	u32	sds_start_addr_start;
-	u32	sds_start_addr_end;
+	u32	sds_start_size;
 	u32	sds_iosf_data_addr_start;
-	u32	sds_iosf_data_addr_end;
+	u32	sds_iosf_data_size;
 	u32	ecl_addr_start;
-	u32	ecl_addr_end;
+	u32	ecl_size;
 	u32	smem_addr_start;
-	u32	smem_addr_end;
+	u32	smem_size;
 };
 
 struct btintel_pcie_mbox {
-- 
2.54.0

