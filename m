Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795447572;
	b=Rilittbsr8tBpllLvcesaH5QEUybyPw5xGnvcpJEm9ahA8Q+sUQz9TuGouKKWPYD7iQV
	 BiZC+V1a7Zq6UcBl0hKBK0FZTSDisPtIPLWEe4IFvyD+pAhfw6pOlUxSNAGWPLmkPLaXf
	 8GIx3HVo+qGBlse7RoB/aRy5tR09BgFI5be+cfdYqCECChtvk8LxvpGNyp4a5QgXf7rYe
	 usBToQq7MugSjr97Y0TOgVPiuUCFagaAXqndHG/3wqHGEpKdlVCC3YCX8WDTuVsu9HRpG
	 3VQXhzU9aHzSC66ddA/aeMUtozFfbfK4I5/HOZeILKxE/3SDmdkP1jEjWfIIsfElNFw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795447572;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=XCVRdtAn8+sPhL1jaOiK/31RudeeT1bTXt0qBhF8G0w=;
	b=vh4L6OzBiUBBXYisvFstPiKZaG9o8P4/rDPSNCBbiwRgRpv0rR3QKsnjwG4ecC1R5AhG
	 N42vHuXkW+vqSRkkt0R8jLlNP2mElbieEIWibUvGh/Ld1NafDI4pNC4mfMACMF9TYqebY
	 g4b8kF8QfgbCjHlto37PuAkhPcstrUhsXVqXvs6TiquXNqjGP7x16vdfQn+ARmKFPddNG
	 uCCei5z+zUG6eNjRtXj0gJVs19XB0Sq8GVeabQkvA/ux3kKtzGnfsEgt6sn37yj7m9wcz
	 P3T6zVcXS4q6Kh2XfOYI7LvZKRdC3qDBlW0ovlHKl2N4LPC3QVx6U4lmnlT1uPLzXHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=WDW1vy2Y;
	arc=none smtp.remote-ip=198.175.65.15
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DE19606A31E
	for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2026 15:26:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1DE19606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=WDW1vy2Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795447571; x=1826983571;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=kNbha7M7Au2xjwUEJPBZDKTvUJys94o8R4fHro1Y0ZQ=;
  b=WDW1vy2YnnbfBi/HSik17CpbwJ6TdCwSkA+BqC9V+gL5uN/C88OQe5zX
   qggYG0SE4fktrMBdxFr6BJ3QA/7lgoyH+Lc8lnU2kBZFcM5J2YBSUn4ME
   GoIGIvMkNC+4KKi+fqS0Y1WQ6XW8d7ybyClfaWT5Nv9IRVzA+fZv+31ZD
   +srzXjgYsFEP2/lfUu2Lgsynp2usuajI9GZ2kzcc3ZGqkS656kVNsYxXO
   erRI76QO557167wA5dKd1sOw+1ng5uKMHXbGd7TwUUTbrluWdwttjoMoX
   cKI6eqZJQ9lDg48dwEuNMwz4CpxqqocfIzdVXTJIcnGHaNZlZNHYlfwiw
   A==;
X-CSE-ConnectionGUID: 87szYxfaTHWTo60+ENqmmw==
X-CSE-MsgGUID: 80ycrSvDS1SpRUqbjtb6iQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11975"; a="4271210"
X-IronPort-AV: E=Sophos;i="6.27,229,1787036400"; 
   d="scan'208";a="4271210"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2026 07:26:11 -0800
X-CSE-ConnectionGUID: UGa2I1cIR1yZCEQKsbIA1Q==
X-CSE-MsgGUID: 6W696fYNRWWqv10ohTrdDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,229,1787036400"; 
   d="scan'208";a="13023905"
Received: from weba0957.iind.intel.com (HELO WEBA0932.iind.intel.com) ([10.224.186.34])
  by fmviesa012.fm.intel.com with ESMTP; 23 Nov 2026 07:26:09 -0800
From: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: chethan.tumkur.narayan@intel.com,
	kiran.k@intel.com,
	Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>
Subject: [PATCH v2] Bluetooth: btintel_pcie: Add support for paging over DRAM
Date: Mon, 23 Nov 2026 20:55:03 +0530
Message-ID: <20261123152504.3413550-1-chandrashekar.devegowda@intel.com>
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
fields of the context info.

Paging is not specific to a controller generation, so the extended context
info is set up for every supported device.

All allocations are device managed, so no additional cleanup is needed in
the error or remove paths.

Tested on PTL platform by downloading the firmware with the extended
context info configured. The download completes and the controller comes
up.

Signed-off-by: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>
---
Changes in v2:
- Rebase on bluetooth-next (cf357cfc025e); the exit_error_rxq label used
  by this patch comes from 19a13d870f04 ("Bluetooth: btintel_pcie:
  Configure YoYo DBGC buffer allocations"), which is in bluetooth-next
- Update the kernel-doc of ctx_info.ext_size for the blocking mode and
  valid bits
- State in the commit message that paging is not device specific

v1: https://lore.kernel.org/linux-bluetooth/20261119174149.3355356-1-chandrashekar.devegowda@intel.com/

 drivers/bluetooth/btintel_pcie.c | 71 ++++++++++++++++++++++++++++++++
 drivers/bluetooth/btintel_pcie.h | 60 ++++++++++++++++++++++++++-
 2 files changed, 130 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index 55454900322b..64cc8d0e4041 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -7,6 +7,7 @@
  */
 
 #include <linux/kernel.h>
+#include <linux/bitfield.h>
 #include <linux/module.h>
 #include <linux/firmware.h>
 #include <linux/overflow.h>
@@ -3558,6 +3559,72 @@ static int btintel_pcie_config_pcie(struct pci_dev *pdev,
 	return 0;
 }
 
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
@@ -3844,6 +3911,10 @@ static int btintel_pcie_alloc(struct btintel_pcie_data *data)
 	data->ci = v_addr;
 	data->ci_p_addr = p_addr;
 
+	err = btintel_pcie_alloc_ext_ctxt_info(data);
+	if (err)
+		goto exit_error_rxq;
+
 	/* Initialize the CI */
 	btintel_pcie_init_ci(data, data->ci);
 
diff --git a/drivers/bluetooth/btintel_pcie.h b/drivers/bluetooth/btintel_pcie.h
index 28acc20eefdf..12a85939b55e 100644
--- a/drivers/bluetooth/btintel_pcie.h
+++ b/drivers/bluetooth/btintel_pcie.h
@@ -137,6 +137,12 @@
 #define BTINTEL_PCIE_DEVICE_ID_NVL_Hx_SCP2	0xD346
 #define BTINTEL_PCIE_DEVICE_ID_PTL_FMP2		0xE476
 
+/* Extended context information */
+#define BTINTEL_PCIE_EXTCTXT_INFO_VER		0xA00A
+#define BTINTEL_PCIE_PAGING_TYPE		0x0081
+#define BTINTEL_PCIE_PAGING_NUM_PAGES		256
+#define BTINTEL_PCIE_PAGING_PAGE_SIZE		(4 * 1024)
+
 /* Causes for the FH register interrupts */
 enum msix_fh_int_causes {
 	BTINTEL_PCIE_MSIX_FH_INT_CAUSES_0	= BIT(0),	/* cause 0 */
@@ -282,6 +288,17 @@ enum {
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
@@ -322,7 +339,8 @@ enum {
  *	 0=BT DBGC, 1=WiFi DBGC, 2=NPK }
  * @dbg_preset: Debug preset
  * @ext_addr: Address of context information extension
- * @ext_size: Size of context information part
+ * @ext_size: Size of context information extension, with the blocking
+ *	mode and valid bits (see BTINTEL_PCIE_EXT_CI_*)
  *
  * Total 38 DWords
  */
@@ -712,6 +730,46 @@ struct btintel_pcie_ini_dump_info {
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

base-commit: cf357cfc025e7f72851479ed3fb60d5f16413c1b
-- 
2.43.0

