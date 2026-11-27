Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795785725;
	b=GDdFK+sn+CdkRbEWoBokB56xpqHcfAkNWKnstPuNswieSfkA8EUpNg1QxdKRr033LI0A
	 D2PQrD+o9aEYe2gF6oTdaeI6CxcHvu4BAaVqDVEC7nNqkHNPtNwfklGPhBNYnmig8vQmh
	 DYQkgZjFiSDhKi28iEybsR8ORvxoPVchds2Qm6f4NarfseY8l477edZQw3/jqOn6i6ycA
	 RZGkjXfX4ftbutEQh6yuyQc3wPYZMdfJXn872zyZRW5K58537CxMn1Cr0XWHErO9DMgeE
	 xlLzRZxQqW9TToQ30hvBoW5pjtUsd81Jw8jT4dV8y1XuWtcJo+bLt3Ks6Yybm+CSKhQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795785725;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=HGrPnkcGcOw1sMTBRUlaRfZdlCRGFmcR5uaQ67ca8dU=;
	b=LA+7Ceilz4xFNnI/xStco/7hAeqiUJJS96VuBmuZ2NBCvYJtCHLgaQ1d71O8rxneos0l
	 +D4f/f8tQxXbtwvO6Ezaw+5aI4Ffy1XbKvEM5GMDZyKkXEy+lrHkXko4N2t2V9LybdvPk
	 +ff0sc470ZHLOmYnlggbE7p1yeQeT1l0g7KSa2gkab9JwTnO1Eaer0/SdFIPly5IejKUw
	 ug/CXT3V/1NXfPtZuFvkg5tDBDZmAi03sBDsGxyUaWqS5S6TnUiBmq0TqKWsj2XRPb469
	 by2oCdmYbYCMkJF9BrGoFfB4+5DlKzvLZR9Ud9VmA5Eim3sZuZ5CGwm5VNDENGv9sPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=jSm7sUyv;
	arc=none smtp.remote-ip=198.175.65.9
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8C00606A31C
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Nov 2026 13:22:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E8C00606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=jSm7sUyv
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795785724; x=1827321724;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=V0v8l5AlrLhzAOv9A2UyKYljWCoWGU2NDKgkpwXiQyI=;
  b=jSm7sUyvX3XOW/14U6kQgvxWNX8urCTOYBz6RcBU4ToQPWgJmjbc/Dgp
   F8bE3YjCvkrOW3DNTlfTw/XRr2D7WoztMAqQ8T/Ly63dLUbzfGosW58ez
   ObuTf7K7KvVhP+MrwI4+C0zi5Nxe9GhhYwqUVdVCoFmpB531YYAAT/Zxl
   zdkLFpgL8BJKe10is/YZyrJZYXe1yClBYJVblCQLRRYS9PMJyynU9TCDC
   C0tgmYV5wUXIqZNdNn03jGK2QgFM+00gqTU/NlpbS934etPTVAaPpDoKk
   BN0cPhA4HkqgJZyIS1yojDmCiOeeKD7N5mVDIoNU2ucil2qhBxGMJMwBA
   Q==;
X-CSE-ConnectionGUID: y/Z73KL4RRqmHi/URGZjDw==
X-CSE-MsgGUID: UKazcMd8SWCmptcVg5YwDA==
X-IronPort-AV: E=McAfee;i="6800,10657,11979"; a="4606808"
X-IronPort-AV: E=Sophos;i="6.27,237,1787036400"; 
   d="scan'208";a="4606808"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2026 05:22:03 -0800
X-CSE-ConnectionGUID: lHTJOkdwTJK67fVPasDR6Q==
X-CSE-MsgGUID: nJ9zGDBxTB6Ghk9IlqaChg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,237,1787036400"; 
   d="scan'208";a="12180238"
Received: from weba0957.iind.intel.com (HELO WEBA0932.iind.intel.com) ([10.224.186.34])
  by orviesa008.jf.intel.com with ESMTP; 27 Nov 2026 05:22:02 -0800
From: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: chethan.tumkur.narayan@intel.com,
	kiran.k@intel.com,
	Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>
Subject: [PATCH v3] Bluetooth: btintel_pcie: Add support for paging over DRAM
Date: Fri, 27 Nov 2026 18:51:14 +0530
Message-ID: <20261127132114.3481678-1-chandrashekar.devegowda@intel.com>
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

Configure the extended context info so that the controller can page
firmware code over host DRAM. Allocate DMA memory for the paging TLV, the
paged DRAM table and the pages it describes, and pass their address and
size to the controller through the extended context info address and size
fields of the context info. The extended context info is set in blocking
mode, in which the controller performs the DMA copy of the paged data
synchronously.

Paging needs a Scorpius Peak2 (SCP2) or newer controller, so the extended
context info is set up only for those device IDs. Other devices keep the
extended context info address and size at zero, as before.

All allocations are device managed, so no additional cleanup is needed in
the error or remove paths.

Tested on Nova Lake platform by downloading the firmware with the extended
context info configured. The download completes and the controller comes
up.

Signed-off-by: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>
---
Changes in v3:
- Set up the extended context info only for SCP2 and newer device IDs
  (Nova Lake, Draco, Titan Lake), so older controllers are unchanged.
- Explain the blocking mode in the commit message.
- Tested on Nova Lake; update the commit message to match.
- Rebase on bluetooth-next (f57f78086ab5).

Changes in v2:
- Rebase on bluetooth-next (cf357cfc025e); the exit_error_rxq label used
  by this patch comes from 19a13d870f04 ("Bluetooth: btintel_pcie:
  Configure YoYo DBGC buffer allocations"), which is in bluetooth-next
- Update the kernel-doc of ctx_info.ext_size for the blocking mode and
  valid bits
- State in the commit message that paging is not device specific

v2: https://lore.kernel.org/linux-bluetooth/20261123152504.3413550-1-chandrashekar.devegowda@intel.com/
v1: https://lore.kernel.org/linux-bluetooth/20261119174149.3355356-1-chandrashekar.devegowda@intel.com/
 drivers/bluetooth/btintel_pcie.c | 88 ++++++++++++++++++++++++++++++++
 drivers/bluetooth/btintel_pcie.h | 63 ++++++++++++++++++++++-
 2 files changed, 150 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index 3b2c8bbb36e9..f894b46e19a5 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -7,6 +7,7 @@
  */
 
 #include <linux/kernel.h>
+#include <linux/bitfield.h>
 #include <linux/module.h>
 #include <linux/firmware.h>
 #include <linux/overflow.h>
@@ -3532,6 +3533,87 @@ static int btintel_pcie_config_pcie(struct pci_dev *pdev,
 	return 0;
 }
 
+/* Paging needs a Scorpius Peak2 (SCP2) or newer controller */
+static bool btintel_pcie_is_paging_supported(struct btintel_pcie_data *data)
+{
+	switch (data->pdev->device) {
+	case BTINTEL_PCIE_DEVICE_ID_NVL_S_SCP2:
+	case BTINTEL_PCIE_DEVICE_ID_NVL_Hx_SCP2:
+	case BTINTEL_PCIE_DEVICE_ID_DRACO_0:
+	case BTINTEL_PCIE_DEVICE_ID_DRACO_1:
+	case BTINTEL_PCIE_DEVICE_ID_TTL_SCP2:
+		return true;
+	default:
+		return false;
+	}
+}
+
+/* Set up the extended context info with the paging TLV and the DRAM pages
+ * the controller can use for paging. All memory is device managed and is
+ * released when the driver is unbound.
+ */
+static int btintel_pcie_alloc_ext_ctxt_info(struct btintel_pcie_data *data)
+{
+	struct device *dev = &data->pdev->dev;
+	struct btintel_pcie_page_table *page_table;
+	struct btintel_pcie_paging_tlv *paging;
+	struct btintel_pcie_ext_ctxt *ext_ci;
+	u32 ext_ci_size;
+	size_t info_size, total_size;
+	dma_addr_t p_addr, page_p_addr;
+	void *v_addr;
+	int i;
+
+	info_size = ALIGN(sizeof(*ext_ci), BTINTEL_PCIE_DMA_ALIGN_128B);
+	total_size = info_size + ALIGN(sizeof(*page_table),
+				       BTINTEL_PCIE_DMA_ALIGN_128B);
+
+	v_addr = dmam_alloc_coherent(dev, total_size, &p_addr,
+				     GFP_KERNEL | __GFP_NOWARN);
+	if (!v_addr)
+		return -ENOMEM;
+
+	ext_ci = v_addr;
+	page_table = v_addr + info_size;
+
+	ext_ci->version = cpu_to_le16(BTINTEL_PCIE_EXTCTXT_INFO_VER);
+	ext_ci->size_dw = cpu_to_le16(sizeof(*paging) / sizeof(u32));
+
+	paging = &ext_ci->paging;
+	paging->type = cpu_to_le16(BTINTEL_PCIE_PAGING_TYPE);
+	paging->len_dw = cpu_to_le16((sizeof(*paging) -
+				      offsetof(struct btintel_pcie_paging_tlv,
+					       high)) / sizeof(u32));
+	paging->high = cpu_to_le32(upper_32_bits(p_addr + info_size));
+	paging->low = cpu_to_le32(lower_32_bits(p_addr + info_size));
+	paging->size = cpu_to_le32(sizeof(*page_table));
+
+	page_table->num_of_pages = cpu_to_le32(BTINTEL_PCIE_PAGING_NUM_PAGES);
+	page_table->bytes_per_page = cpu_to_le32(BTINTEL_PCIE_PAGING_PAGE_SIZE);
+
+	for (i = 0; i < BTINTEL_PCIE_PAGING_NUM_PAGES; i++) {
+		if (!dmam_alloc_coherent(dev, BTINTEL_PCIE_PAGING_PAGE_SIZE,
+					 &page_p_addr,
+					 GFP_KERNEL | __GFP_NOWARN))
+			return -ENOMEM;
+
+		page_table->pages[i].addr_high =
+			cpu_to_le32(upper_32_bits(page_p_addr));
+		page_table->pages[i].addr_low =
+			cpu_to_le32(lower_32_bits(page_p_addr));
+	}
+
+	ext_ci_size = FIELD_PREP(BTINTEL_PCIE_EXT_CI_SIZE_MASK,
+				 sizeof(*ext_ci)) |
+		      BTINTEL_PCIE_EXT_CI_BLOCKING_MODE |
+		      BTINTEL_PCIE_EXT_CI_VALID;
+
+	data->ci->ext_addr = p_addr;
+	data->ci->ext_size = ext_ci_size;
+
+	return 0;
+}
+
 static void btintel_pcie_init_ci(struct btintel_pcie_data *data,
 				 struct ctx_info *ci)
 {
@@ -3818,6 +3900,12 @@ static int btintel_pcie_alloc(struct btintel_pcie_data *data)
 	data->ci = v_addr;
 	data->ci_p_addr = p_addr;
 
+	if (btintel_pcie_is_paging_supported(data)) {
+		err = btintel_pcie_alloc_ext_ctxt_info(data);
+		if (err)
+			goto exit_error_rxq;
+	}
+
 	/* Initialize the CI */
 	btintel_pcie_init_ci(data, data->ci);
 
diff --git a/drivers/bluetooth/btintel_pcie.h b/drivers/bluetooth/btintel_pcie.h
index 97267a7e9762..fedbf5b0bf32 100644
--- a/drivers/bluetooth/btintel_pcie.h
+++ b/drivers/bluetooth/btintel_pcie.h
@@ -136,6 +136,15 @@
 #define BTINTEL_PCIE_DEVICE_ID_NVL_S_SCP2	0x6E74
 #define BTINTEL_PCIE_DEVICE_ID_NVL_Hx_SCP2	0xD346
 #define BTINTEL_PCIE_DEVICE_ID_PTL_FMP2		0xE476
+#define BTINTEL_PCIE_DEVICE_ID_DRACO_0		0x2731
+#define BTINTEL_PCIE_DEVICE_ID_DRACO_1		0x2732
+#define BTINTEL_PCIE_DEVICE_ID_TTL_SCP2		0x9329
+
+/* Extended context information */
+#define BTINTEL_PCIE_EXTCTXT_INFO_VER		0xA00A
+#define BTINTEL_PCIE_PAGING_TYPE		0x0081
+#define BTINTEL_PCIE_PAGING_NUM_PAGES		256
+#define BTINTEL_PCIE_PAGING_PAGE_SIZE		(4 * 1024)
 
 /* Causes for the FH register interrupts */
 enum msix_fh_int_causes {
@@ -279,6 +288,17 @@ enum {
 #define BTINTEL_PCIE_TLV_TYPE_ECL_MEM_ADDRESS         0x07
 #define BTINTEL_PCIE_TLV_TYPE_SMEM_ADDRESS	      0x08
 
+/*
+ * Extended context info size, written to ctx_info.ext_size
+ * bits[0:15] - extended context info size in bytes
+ * bits[16:29] - reserved
+ * bit[30] - blocking_mode
+ * bit[31] - valid
+ */
+#define BTINTEL_PCIE_EXT_CI_SIZE_MASK		GENMASK(15, 0)
+#define BTINTEL_PCIE_EXT_CI_BLOCKING_MODE	BIT(30)
+#define BTINTEL_PCIE_EXT_CI_VALID		BIT(31)
+
 /*
  * Struct for Context Information (v2)
  *
@@ -319,7 +339,8 @@ enum {
  *	 0=BT DBGC, 1=WiFi DBGC, 2=NPK }
  * @dbg_preset: Debug preset
  * @ext_addr: Address of context information extension
- * @ext_size: Size of context information part
+ * @ext_size: Size of context information extension, with the blocking
+ *	mode and valid bits (see BTINTEL_PCIE_EXT_CI_*)
  *
  * Total 38 DWords
  */
@@ -709,6 +730,46 @@ struct btintel_pcie_ini_dump_info {
 	/* no cfg_names for BT - keep zero-length */
 } __packed;
 
+/* TLV describing the paged DRAM table
+ * @type: The TLV id
+ * @len_dw: The TLV payload length in dwords
+ * @high: The MSB of the paged DRAM table address
+ * @low: The LSB of the paged DRAM table address
+ * @size: The size of the paged DRAM table in bytes
+ */
+struct btintel_pcie_paging_tlv {
+	__le16	type;
+	__le16	len_dw;
+	__le32	high;
+	__le32	low;
+	__le32	size;
+} __packed;
+
+/* Extended context info, pointed to by ctx_info.ext_addr
+ * @version: The extended context info version
+ * @size_dw: The size of all the TLVs that follow in dwords
+ * @paging: The paging TLV
+ */
+struct btintel_pcie_ext_ctxt {
+	__le16	version;
+	__le16	size_dw;
+	struct btintel_pcie_paging_tlv paging;
+} __packed;
+
+/* Paged DRAM table
+ * @num_of_pages: Total number of pages allocated in host DRAM
+ * @bytes_per_page: Size of each page in bytes
+ * @pages: DMA address of each page
+ */
+struct btintel_pcie_page_table {
+	__le32 num_of_pages;
+	__le32 bytes_per_page;
+	struct {
+		__le32 addr_high;
+		__le32 addr_low;
+	} pages[BTINTEL_PCIE_PAGING_NUM_PAGES];
+} __packed;
+
 /* struct btintel_pcie_data
  * @pdev: pci device
  * @hdev: hdev device

base-commit: f57f78086ab54f3b3122fbaeba2c842ba7bb6d00
-- 
2.43.0

