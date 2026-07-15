Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A07EB34F49F
	for <linux-bluetooth@vger.kernel.org>; Wed, 15 Jul 2026 15:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784130896; cv=none; b=WlSIK7OL0MDUqrvFnAeB+SuBrkrjpKzmdxzeY62gOMj5biO8jMGr8px2HXPsT+YpxOTaDwgHXfnMbX2zNQq2GWocIjUyyhkTdrAPKSBE1SdK0j8SoH1rF2j0QajgUvDTKKPXiAS2jfRrdlN6cKhEfYBzushs1ANPPvGfX8q6cos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784130896; c=relaxed/simple;
	bh=WYhd/6f9Rs0iaHNIhV9BKOS6icoyk7fc8/4H7WWEqo8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=p7isI+7JvmoLXmS7dFLqlA3rybExs2qOpkiqyahClmXeKt80EmHjERbbfHKOO72xxhrPkolRxYbIoX43jHiODFc9F8uYpiZ3OQAH29jc009RusGljf9Gt/v3whIhzZ2K2JM+lC44MthvFMm/DZM/fOY5brGEgfgvgea35OdI1GA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QpXJp+Vw; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QpXJp+Vw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784130893; x=1815666893;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=WYhd/6f9Rs0iaHNIhV9BKOS6icoyk7fc8/4H7WWEqo8=;
  b=QpXJp+VwxIVXMZY7f566sSktIPlltKcrdW4VpnH3Hm6dOjlBWx4DJux9
   mk1wAobuMMwknXje9Z2vjvg4VGNpmAlE6F814gmokSUdiHd9mEnpAzp2V
   lg1p1C4dO/NLXcpINskW+4OrhJJvjBU+gJKdaVI1oxa8bXwPUs3CtX63E
   3Ka0norGlt3TnSh5BG7h0K5hQhfC8IGwvuqekca16TQ4T02mo3swSJzaP
   99pXEC+Sz67lnUozgnCOLMbJmamaGk81o9RoS7zjGNwzBIFikrCNUr1Rp
   SaQ990Xl30JoBncjWszeIQApdkrZou1enZIh0BGhz4O53vUFFNIhnKRe6
   w==;
X-CSE-ConnectionGUID: 0m4UktMbRsG3ytBYb3lg6w==
X-CSE-MsgGUID: ftSADI1DT/OKvhjVpmXM5Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11847"; a="88450054"
X-IronPort-AV: E=Sophos;i="6.25,165,1779174000"; 
   d="scan'208";a="88450054"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2026 08:54:52 -0700
X-CSE-ConnectionGUID: OuZCld8kR2uwKHB1dh5R4Q==
X-CSE-MsgGUID: AJV87GAmSPSJwo9cJhz44w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,165,1779174000"; 
   d="scan'208";a="254473353"
Received: from weba0957.iind.intel.com (HELO WEBA0932.iind.intel.com) ([10.224.186.34])
  by orviesa006.jf.intel.com with ESMTP; 15 Jul 2026 08:54:50 -0700
From: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: bhelgaas@google.com,
	ravishankar.srivatsa@intel.com,
	chethan.tumkur.narayan@intel.com,
	Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>,
	Kiran K <kiran.k@intel.com>
Subject: [PATCH v1] Bluetooth: btintel_pcie: support unified decoder coredump format
Date: Wed, 15 Jul 2026 21:23:50 +0530
Message-ID: <20260715155401.605564-1-chandrashekar.devegowda@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Refactor the coredump collection to use a unified decoder format
that consolidates exception dump, DCCM, SDS, SDS IOSF, ECL, and
SMEM memory regions into a structured TLV-based dump. This enables
a single decoder tool to parse all dump types across different
Intel BT PCIe controller variants (BlazarI/W, ScP, ScP2/F, Draco).

Key changes:
- Parse dump memory region addresses from FW-provided TLV data
- Add per-variant DBGC register offsets for wrap counter and
  write pointer status
- Collect and emit coredump sections with proper headers for
  the unified decoder tool

Signed-off-by: Kiran K <kiran.k@intel.com>
Signed-off-by: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>
---
 drivers/bluetooth/btintel.c      |   12 +
 drivers/bluetooth/btintel.h      |    1 +
 drivers/bluetooth/btintel_pcie.c | 1193 +++++++++++++++++++++++++-----
 drivers/bluetooth/btintel_pcie.h |  267 ++++++-
 4 files changed, 1299 insertions(+), 174 deletions(-)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index 5e9cac090bd8..b0b8c38ae9e4 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -65,6 +65,7 @@ static struct {
 	const char *driver_name;
 	u8         hw_variant;
 	u32        fw_build_num;
+	u32        fw_git_sha1;
 } coredump_info;
 
 const guid_t btintel_guid_dsm =
@@ -559,6 +560,7 @@ int btintel_version_info_tlv(struct hci_dev *hdev,
 
 	coredump_info.hw_variant = INTEL_HW_VARIANT(version->cnvi_bt);
 	coredump_info.fw_build_num = version->build_num;
+	coredump_info.fw_git_sha1 = version->git_sha1;
 
 	bt_dev_info(hdev, "%s timestamp %u.%u buildtype %u build %u", variant,
 		    2000 + (version->timestamp >> 8), version->timestamp & 0xff,
@@ -2448,6 +2450,13 @@ static int btintel_prepare_fw_download_tlv(struct hci_dev *hdev,
 		btintel_reset_to_bootloader(hdev);
 
 done:
+	{
+		struct btintel_data *intel_data = hci_get_priv(hdev);
+
+		intel_data->cnvi_bt = ver->cnvi_bt;
+		bt_dev_dbg(hdev, "INTEL HW VARIANT is: 0x%2x",
+			   INTEL_HW_VARIANT(intel_data->cnvi_bt));
+	}
 	release_firmware(fw);
 	return err;
 }
@@ -3299,6 +3308,9 @@ int btintel_bootloader_setup_tlv(struct hci_dev *hdev,
 
 	btintel_version_info_tlv(hdev, &new_ver);
 
+	/* Update ver with the operational firmware version */
+	*ver = new_ver;
+
 finish:
 	/* Set the event mask for Intel specific vendor events. This enables
 	 * a few extra events that are useful during general operation. It
diff --git a/drivers/bluetooth/btintel.h b/drivers/bluetooth/btintel.h
index 37d93abdd5a3..02a37a3d459d 100644
--- a/drivers/bluetooth/btintel.h
+++ b/drivers/bluetooth/btintel.h
@@ -229,6 +229,7 @@ enum {
 struct btintel_data {
 	DECLARE_BITMAP(flags, __INTEL_NUM_FLAGS);
 	int (*acpi_reset_method)(struct hci_dev *hdev);
+	u32 cnvi_bt;
 };
 
 #define btintel_set_flag(hdev, nr)					\
diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index 013568197a39..3a714854ff50 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -19,6 +19,7 @@
 
 #include <linux/unaligned.h>
 #include <linux/devcoredump.h>
+#include <linux/scatterlist.h>
 
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
@@ -73,17 +74,6 @@ struct btintel_pcie_dev_recovery {
 #define BTINTEL_PCIE_HCI_EVT_PKT	0x00000004
 #define BTINTEL_PCIE_HCI_ISO_PKT	0x00000005
 
-#define BTINTEL_PCIE_MAGIC_NUM    0xA5A5A5A5
-
-#define BTINTEL_PCIE_BLZR_HWEXP_SIZE		1024
-#define BTINTEL_PCIE_BLZR_HWEXP_DMP_ADDR	0xB00A7C00
-
-#define BTINTEL_PCIE_SCP_HWEXP_SIZE		4096
-#define BTINTEL_PCIE_SCP_HWEXP_DMP_ADDR		0xB030F800
-
-#define BTINTEL_PCIE_SCP2_HWEXP_SIZE		4096
-#define BTINTEL_PCIE_SCP2_HWEXP_DMP_ADDR	0xB031D000
-
 #define BTINTEL_PCIE_MAGIC_NUM	0xA5A5A5A5
 
 #define BTINTEL_PCIE_TRIGGER_REASON_USER_TRIGGER	0x17A2
@@ -145,6 +135,20 @@ struct btintel_pcie_dbgc_ctxt {
 	struct btintel_pcie_dbgc_ctxt_buf bufs[BTINTEL_PCIE_DBGC_BUFFER_COUNT];
 };
 
+struct btintel_pcie_mdbgc_ctxt {
+	u32     magic_num;
+	u32     ver;
+	u32     buf1_index;
+	u32     buf1_count;
+	struct btintel_pcie_dbgc_ctxt_buf buf1[BTINTEL_PCIE_DBGC_BUFFER_COUNT];
+	u32     buf2_index;
+	u32     buf2_count;
+	struct btintel_pcie_dbgc_ctxt_buf buf2[BTINTEL_PCIE_DBGC_BUFFER_COUNT];
+	u32     buf3_index;
+	u32     buf3_count;
+	struct btintel_pcie_dbgc_ctxt_buf buf3[BTINTEL_PCIE_DBGC_BUFFER_COUNT];
+};
+
 struct btintel_pcie_trigger_evt {
 	u8 type;
 	u8 len;
@@ -186,6 +190,127 @@ static inline char *btintel_pcie_alivectxt_state2str(u32 alive_intr_ctxt)
 	}
 }
 
+/* Helper function to allocate and setup a debug buffer group
+ * @data: driver data structure
+ * @buf: pointer to data_buf array pointer
+ * @p_addr: pointer to physical DMA address
+ * @v_addr: pointer to virtual address
+ * @frag_buf: pointer to fragment buffer array
+ * @buf_index: buffer index (for error messages)
+ * @buf_count: number of buffers to allocate
+ */
+static int btintel_pcie_alloc_dbgc_buf(struct btintel_pcie_data *data,
+				       struct data_buf **buf,
+				       dma_addr_t *p_addr,
+				       void **v_addr,
+				       struct btintel_pcie_dbgc_ctxt_buf *frag_buf,
+				       u32 buf_index,
+				       u32 buf_count)
+{
+	struct data_buf *b;
+	int i;
+
+	*buf = devm_kcalloc(&data->pdev->dev, buf_count,
+			    sizeof(**buf), GFP_KERNEL);
+	if (!*buf) {
+		BT_ERR("Failed to allocate dbgc buf: %u", buf_index + 1);
+		return -ENOMEM;
+	}
+
+	*v_addr = dmam_alloc_coherent(&data->pdev->dev,
+				      buf_count *
+					BTINTEL_PCIE_DBGC_BUFFER_SIZE,
+					p_addr,
+					GFP_KERNEL | __GFP_NOWARN);
+	if (!*v_addr) {
+		BT_ERR("Failed to allocate dbgc buf: %u DMA", buf_index + 1);
+		return -ENOMEM;
+	}
+
+	for (i = 0; i < buf_count; i++) {
+		b = &(*buf)[i];
+		b->data_p_addr = *p_addr + i * BTINTEL_PCIE_DBGC_BUFFER_SIZE;
+		b->data = *v_addr + i * BTINTEL_PCIE_DBGC_BUFFER_SIZE;
+		frag_buf[i].buf_addr_lsb = lower_32_bits(b->data_p_addr);
+		frag_buf[i].buf_addr_msb = upper_32_bits(b->data_p_addr);
+		frag_buf[i].buf_size = BTINTEL_PCIE_DBGC_BUFFER_SIZE;
+	}
+
+	return 0;
+}
+
+/* This function initializes the memory for MDBGC buffers and formats the
+ * DBGC fragment which consists header info and DBGC buffer's LSB, MSB and
+ * size as the payload
+ */
+static int btintel_pcie_setup_mdbgc(struct btintel_pcie_data *data)
+{
+	struct btintel_pcie_mdbgc_ctxt db_frag;
+	int err;
+
+	data->mdbgc.count = BTINTEL_PCIE_DBGC_BUFFER_COUNT;
+
+	/* Allocate fragment context structure */
+	data->mdbgc.frag_v_addr = dmam_alloc_coherent(&data->pdev->dev,
+						      sizeof(struct btintel_pcie_mdbgc_ctxt),
+					&data->mdbgc.frag_p_addr,
+					GFP_KERNEL | __GFP_NOWARN);
+	if (!data->mdbgc.frag_v_addr) {
+		BT_ERR("Failed to allocate mdbgc context");
+		return -ENOMEM;
+	}
+
+	data->mdbgc.frag_size = sizeof(struct btintel_pcie_mdbgc_ctxt);
+
+	/* Initialize fragment header */
+	memset(&db_frag, 0, sizeof(db_frag));
+	db_frag.magic_num = BTINTEL_PCIE_MAGIC_NUM;
+	db_frag.ver = BTINTEL_PCIE_MDBGC_FRAG_VERSION;
+
+	/* Allocate DBGC buffer 1 */
+	db_frag.buf1_index = BTINTEL_PCIE_MDBGC_ALLOCATIONID_1;
+	db_frag.buf1_count = data->mdbgc.count;
+	err = btintel_pcie_alloc_dbgc_buf(data,
+					  &data->mdbgc.buf1,
+					  &data->mdbgc.buf1_p_addr,
+					  &data->mdbgc.buf1_v_addr,
+					  db_frag.buf1,
+					  0,
+					  data->mdbgc.count);
+	if (err)
+		return err;
+
+	/* Allocate DBGC buffer 2 */
+	db_frag.buf2_index = BTINTEL_PCIE_MDBGC_ALLOCATIONID_2;
+	db_frag.buf2_count = data->mdbgc.count;
+	err = btintel_pcie_alloc_dbgc_buf(data,
+					  &data->mdbgc.buf2,
+					  &data->mdbgc.buf2_p_addr,
+					  &data->mdbgc.buf2_v_addr,
+					  db_frag.buf2,
+					  1,
+					  data->mdbgc.count);
+	if (err)
+		return err;
+
+	/* Allocate DBGC buffer 3 */
+	db_frag.buf3_index = BTINTEL_PCIE_MDBGC_ALLOCATIONID_3;
+	db_frag.buf3_count = data->mdbgc.count;
+	err = btintel_pcie_alloc_dbgc_buf(data,
+					  &data->mdbgc.buf3,
+					  &data->mdbgc.buf3_p_addr,
+					  &data->mdbgc.buf3_v_addr,
+					  db_frag.buf3,
+					  2,
+					  data->mdbgc.count);
+	if (err)
+		return err;
+
+	/* Copy fragment to DMA coherent memory */
+	memcpy(data->mdbgc.frag_v_addr, &db_frag, sizeof(db_frag));
+	return 0;
+}
+
 /* This function initializes the memory for DBGC buffers and formats the
  * DBGC fragment which consists header info and DBGC buffer's LSB, MSB and
  * size as the payload
@@ -193,46 +318,41 @@ static inline char *btintel_pcie_alivectxt_state2str(u32 alive_intr_ctxt)
 static int btintel_pcie_setup_dbgc(struct btintel_pcie_data *data)
 {
 	struct btintel_pcie_dbgc_ctxt db_frag;
-	struct data_buf *buf;
-	int i;
+	int err;
 
 	data->dbgc.count = BTINTEL_PCIE_DBGC_BUFFER_COUNT;
-	data->dbgc.bufs = devm_kcalloc(&data->pdev->dev, data->dbgc.count,
-				       sizeof(*buf), GFP_KERNEL);
-	if (!data->dbgc.bufs)
-		return -ENOMEM;
-
-	data->dbgc.buf_v_addr = dmam_alloc_coherent(&data->pdev->dev,
-						    data->dbgc.count *
-						    BTINTEL_PCIE_DBGC_BUFFER_SIZE,
-						    &data->dbgc.buf_p_addr,
-						    GFP_KERNEL | __GFP_NOWARN);
-	if (!data->dbgc.buf_v_addr)
-		return -ENOMEM;
 
+	/* Allocate fragment context structure */
 	data->dbgc.frag_v_addr = dmam_alloc_coherent(&data->pdev->dev,
 						     sizeof(struct btintel_pcie_dbgc_ctxt),
 						     &data->dbgc.frag_p_addr,
 						     GFP_KERNEL | __GFP_NOWARN);
-	if (!data->dbgc.frag_v_addr)
+	if (!data->dbgc.frag_v_addr) {
+		BT_ERR("Failed to allocate dbgc context");
 		return -ENOMEM;
+	}
 
 	data->dbgc.frag_size = sizeof(struct btintel_pcie_dbgc_ctxt);
 
+	/* Initialize fragment header */
+	memset(&db_frag, 0, sizeof(db_frag));
 	db_frag.magic_num = BTINTEL_PCIE_MAGIC_NUM;
 	db_frag.ver = BTINTEL_PCIE_DBGC_FRAG_VERSION;
 	db_frag.total_size = BTINTEL_PCIE_DBGC_FRAG_PAYLOAD_SIZE;
 	db_frag.num_buf = BTINTEL_PCIE_DBGC_FRAG_BUFFER_COUNT;
 
-	for (i = 0; i < data->dbgc.count; i++) {
-		buf = &data->dbgc.bufs[i];
-		buf->data_p_addr = data->dbgc.buf_p_addr + i * BTINTEL_PCIE_DBGC_BUFFER_SIZE;
-		buf->data = data->dbgc.buf_v_addr + i * BTINTEL_PCIE_DBGC_BUFFER_SIZE;
-		db_frag.bufs[i].buf_addr_lsb = lower_32_bits(buf->data_p_addr);
-		db_frag.bufs[i].buf_addr_msb = upper_32_bits(buf->data_p_addr);
-		db_frag.bufs[i].buf_size = BTINTEL_PCIE_DBGC_BUFFER_SIZE;
-	}
+	/* Allocate DBGC buffers */
+	err = btintel_pcie_alloc_dbgc_buf(data,
+					  &data->dbgc.bufs,
+					  &data->dbgc.buf_p_addr,
+					  &data->dbgc.buf_v_addr,
+					  db_frag.bufs,
+					  0,
+					  data->dbgc.count);
+	if (err)
+		return err;
 
+	/* Copy fragment to DMA coherent memory */
 	memcpy(data->dbgc.frag_v_addr, &db_frag, sizeof(db_frag));
 	return 0;
 }
@@ -639,63 +759,440 @@ static void btintel_pcie_release_mac_access(struct btintel_pcie_data *data)
 	}
 }
 
-static void *btintel_pcie_copy_tlv(void *dest, enum btintel_pcie_tlv_type type,
-				   void *data, size_t size)
+static const char *btintel_pcie_dumptype_to_str(struct hci_dev *hdev,
+						u8 dumptype)
 {
-	struct intel_tlv *tlv;
+	switch (dumptype) {
+	case BTINTEL_DRAM_REGION:
+		return "DRAM_DUMP";
+	case BTINTEL_SMEM_REGION:
+		return "MONITOR_SMEM";
+	case BTINTEL_DCCM_REGION:
+		return "DCCM_DUMP";
+	case BTINTEL_SDS_REGION:
+		return "SDS_DUMP";
+	case BTINTEL_SDS_IOSF_DATA_REGION:
+		return "SDS_IOSF_DATA_DUMP";
+	case BTINTEL_SDS_FIXED_ROM_REGION:
+		return "SDS_FIXED_ROM_DUMP";
+	case BTINTEL_EXCEPTION_EVT_DEBUG_REGION:
+		return "EXCEPTION_EVT_DEBUG_DATA";
+	case BTINTEL_ECL_REGION:
+		return "ECL_DUMP";
+	default:
+		bt_dev_dbg(hdev, "Unknown dump type: %d", dumptype);
+		return "UNKNOWN_DUMP_TYPE";
+	}
+}
+
+static struct scatterlist *btintel_pcie_alloc_sgtable(ssize_t size)
+{
+	int nents, i;
+	struct page *page;
+	struct scatterlist *sg, *result;
+
+	if (size <= 0)
+		return NULL;
 
-	tlv = dest;
-	tlv->type = type;
-	tlv->len = size;
-	memcpy(tlv->val, data, tlv->len);
-	return dest + sizeof(*tlv) + size;
+	nents = DIV_ROUND_UP(size, PAGE_SIZE);
+	result = kcalloc(nents + 1, sizeof(*result), GFP_KERNEL);
+	if (!result)
+		return NULL;
+
+	sg_init_table(result, nents + 1);
+	sg = result;
+
+	for (i = 0; size > 0; i++) {
+		ssize_t bytes = min_t(ssize_t, size, PAGE_SIZE);
+
+		page = alloc_page(GFP_KERNEL | __GFP_ZERO);
+		if (!page)
+			goto err_free;
+
+		sg_set_page(sg, page, bytes, 0);
+		sg = sg_next(sg);
+		size -= bytes;
+	}
+	sg_mark_end(sg - 1);
+	return result;
+
+err_free:
+	for (sg = result; sg; sg = sg_next(sg)) {
+		page = sg_page(sg);
+		if (page)
+			__free_page(page);
+	}
+	kfree(result);
+	return NULL;
+}
+
+static struct btintel_pcie_dump_entry *btintel_pcie_dump_entry_alloc(u32 data_size)
+{
+	struct btintel_pcie_dump_entry *entry;
+
+	entry = vzalloc(sizeof(*entry) + data_size);
+	if (!entry)
+		return NULL;
+
+	entry->size = data_size;
+	INIT_LIST_HEAD(&entry->list);
+	return entry;
+}
+
+static void btintel_pcie_dump_list_free(struct list_head *list)
+{
+	struct btintel_pcie_dump_entry *entry, *tmp;
+
+	list_for_each_entry_safe(entry, tmp, list, list) {
+		list_del(&entry->list);
+		vfree(entry);
+	}
+}
+
+static u32 btintel_pcie_dump_list_total_size(struct list_head *list)
+{
+	struct btintel_pcie_dump_entry *entry;
+	u32 total = 0;
+
+	list_for_each_entry(entry, list, list)
+		total += entry->size;
+
+	return total;
+}
+
+static int btintel_pcie_dump_dram(struct list_head *list,
+				  u8 count, struct data_buf *bufs,
+				  u8 buf_idx, u32 write_ptr, u32 wrap_ctr,
+				  u32 region_id, const char *name)
+{
+	struct btintel_pcie_dump_entry *entry;
+	struct btintel_pcie_ini_dump_data *dump_data;
+	struct btintel_pcie_ini_monitor_dump *mon_dump;
+	struct btintel_pcie_dump_range *range;
+	u32 mon_hdr_size, ranges_size, payload_size, total_size;
+	int i;
+
+	mon_hdr_size = sizeof(*mon_dump);
+	ranges_size = count * (sizeof(*range) + BTINTEL_PCIE_DBGC_BUFFER_SIZE);
+	payload_size = mon_hdr_size + ranges_size;
+	total_size = sizeof(*dump_data) + payload_size;
+
+	entry = btintel_pcie_dump_entry_alloc(total_size);
+	if (!entry)
+		return -ENOMEM;
+
+	dump_data = (void *)entry->data;
+	dump_data->type = BTINTEL_PCIE_INI_REGION_DRAM_BUFFER;
+	dump_data->sub_type = 0;
+	dump_data->sub_type_ver = 0;
+	dump_data->reserved = 0;
+	dump_data->len = cpu_to_le32(payload_size);
+
+	mon_dump = (void *)dump_data->data;
+	mon_dump->header.version = cpu_to_le32(BTINTEL_PCIE_INI_DUMP_VER);
+	mon_dump->header.region_id = cpu_to_le32(region_id);
+	mon_dump->header.num_of_ranges = cpu_to_le32(count);
+	mon_dump->header.name_len = cpu_to_le32(BTINTEL_PCIE_INI_MAX_NAME);
+	memset(mon_dump->header.name, 0, BTINTEL_PCIE_INI_MAX_NAME);
+	strscpy(mon_dump->header.name, name, BTINTEL_PCIE_INI_MAX_NAME);
+
+	mon_dump->write_ptr = cpu_to_le32(write_ptr);
+	mon_dump->cycle_cnt = cpu_to_le32(wrap_ctr);
+	mon_dump->cur_frag = cpu_to_le32(buf_idx);
+
+	range = (void *)mon_dump->data;
+	for (i = 0; i < count; i++) {
+		range->range_data_size = cpu_to_le32(BTINTEL_PCIE_DBGC_BUFFER_SIZE);
+		range->dram_base_addr = cpu_to_le64(bufs[i].data_p_addr);
+		memcpy(range->data, bufs[i].data, BTINTEL_PCIE_DBGC_BUFFER_SIZE);
+		range = (void *)range->data + BTINTEL_PCIE_DBGC_BUFFER_SIZE;
+	}
+
+	list_add_tail(&entry->list, list);
+	return 0;
 }
 
-static int btintel_pcie_read_dram_buffers(struct btintel_pcie_data *data)
+static int btintel_pcie_dump_target_region(struct btintel_pcie_data *data,
+					   struct list_head *list,
+					   u8 region_type, u32 region_id,
+					   const char *name,
+					   u32 addr_start, u32 size)
 {
-	u32 offset, prev_size, wr_ptr_status, dump_size, data_len;
-	u32 status_reg, wrap_reg;
-	struct btintel_pcie_dbgc *dbgc = &data->dbgc;
+	struct btintel_pcie_dump_entry *entry;
+	struct btintel_pcie_ini_dump_data *dump_data;
+	struct btintel_pcie_ini_dump_header *hdr;
+	struct btintel_pcie_dump_range *range;
+	u32 payload_size, total_size, target_mem_offset, tempdata;
+	u8 *dest;
+	int i;
+
+	if (!size) {
+		bt_dev_warn(data->hdev, "Skipping empty dump region: %s", name);
+		return 0;
+	}
+
+	if (!addr_start) {
+		bt_dev_warn(data->hdev, "Skipping dump region with zero address: %s", name);
+		return 0;
+	}
+
+	/* Align to 4 bytes - target access reads 32-bit words */
+	size = round_down(size, sizeof(u32));
+
+	bt_dev_info(data->hdev,
+		    "Target access: region=%s start=0x%08x size=%u",
+		    name, addr_start, size);
+
+	payload_size = sizeof(*hdr) + sizeof(*range) + size;
+	total_size = sizeof(*dump_data) + payload_size;
+	entry = btintel_pcie_dump_entry_alloc(total_size);
+	if (!entry)
+		return -ENOMEM;
+
+	dump_data = (void *)entry->data;
+	dump_data->type = region_type;
+	dump_data->sub_type = 0;
+	dump_data->sub_type_ver = 0;
+	dump_data->reserved = 0;
+	dump_data->len = cpu_to_le32(payload_size);
+
+	hdr = (void *)dump_data->data;
+	hdr->version = cpu_to_le32(BTINTEL_PCIE_INI_DUMP_VER);
+	hdr->region_id = cpu_to_le32(region_id);
+	hdr->num_of_ranges = cpu_to_le32(1);
+	hdr->name_len = cpu_to_le32(BTINTEL_PCIE_INI_MAX_NAME);
+	memset(hdr->name, 0, BTINTEL_PCIE_INI_MAX_NAME);
+	strscpy(hdr->name, name, BTINTEL_PCIE_INI_MAX_NAME);
+
+	range = (void *)(hdr + 1);
+	range->range_data_size = cpu_to_le32(size);
+	range->internal_base_addr = cpu_to_le32(addr_start);
+
+	dest = (u8 *)range->data;
+	target_mem_offset = size / sizeof(u32);
+	for (i = 0; i < target_mem_offset; i++) {
+		u32 offset = BTINTEL_PCIE_TARGET_ACCESS_FRAG_OFFSET * i;
+
+		tempdata = btintel_pcie_rd_dev_mem(data,
+						   addr_start + offset);
+		memcpy(dest, &tempdata, sizeof(tempdata));
+		dest += sizeof(tempdata);
+	}
+
+	list_add_tail(&entry->list, list);
+	return 0;
+}
+
+static int btintel_pcie_dump_smem_monitor_region(struct btintel_pcie_data *data,
+						 struct list_head *list,
+						 u32 region_id,
+						 const char *name,
+						 u32 addr_start, u32 size)
+{
+	struct btintel_pcie_dump_entry *entry;
+	struct btintel_pcie_ini_dump_data *dump_data;
+	struct btintel_pcie_ini_monitor_dump *mon;
+	struct btintel_pcie_dump_range *range;
+	u32 payload_size, total_size, target_mem_offset, tempdata;
+	u8 *dest;
+	int i;
+
+	if (!size || !addr_start) {
+		bt_dev_err(data->hdev, "Skipping smem dump: size = %u addr = %8.8x",
+			   size, addr_start);
+		return -EINVAL;
+	}
+
+	payload_size = sizeof(*mon) + sizeof(*range) + size;
+	total_size = sizeof(*dump_data) + payload_size;
+	entry = btintel_pcie_dump_entry_alloc(total_size);
+	if (!entry)
+		return -ENOMEM;
+
+	dump_data = (void *)entry->data;
+	dump_data->type = BTINTEL_PCIE_INI_REGION_INTERNAL_BUFFER;
+	dump_data->sub_type = 0;
+	dump_data->sub_type_ver = 0;
+	dump_data->reserved = 0;
+	dump_data->len = cpu_to_le32(payload_size);
+
+	mon = (void *)dump_data->data;
+	mon->header.version = cpu_to_le32(BTINTEL_PCIE_INI_DUMP_VER);
+	mon->header.region_id = cpu_to_le32(region_id);
+	mon->header.num_of_ranges = cpu_to_le32(1);
+	mon->header.name_len = cpu_to_le32(BTINTEL_PCIE_INI_MAX_NAME);
+	memset(mon->header.name, 0, BTINTEL_PCIE_INI_MAX_NAME);
+	strscpy(mon->header.name, name, BTINTEL_PCIE_INI_MAX_NAME);
+
+	mon->write_ptr = cpu_to_le32(0);
+	mon->cycle_cnt = cpu_to_le32(0);
+	mon->cur_frag = cpu_to_le32(0);
+
+	range = (void *)mon->data;
+	range->range_data_size = cpu_to_le32(size);
+	range->internal_base_addr = cpu_to_le32(addr_start);
+
+	dest = (u8 *)range->data;
+	target_mem_offset = size / sizeof(u32);
+	for (i = 0; i < target_mem_offset; i++) {
+		u32 offset = BTINTEL_PCIE_TARGET_ACCESS_FRAG_OFFSET * i;
+
+		tempdata = btintel_pcie_rd_dev_mem(data,
+						   addr_start + offset);
+		memcpy(dest, &tempdata, sizeof(tempdata));
+		dest += sizeof(tempdata);
+	}
+
+	list_add_tail(&entry->list, list);
+	return 0;
+}
+
+static int btintel_pcie_dump_info(struct btintel_pcie_data *data,
+				  struct list_head *list,
+				  u64 regions_mask)
+{
+	struct btintel_pcie_dump_entry *entry;
+	struct btintel_pcie_error_dump_data *tlv;
+	struct btintel_pcie_ini_dump_info *dump;
+	u32 size = sizeof(*tlv) + sizeof(*dump);
+	char build_tag[64];
+
+	entry = btintel_pcie_dump_entry_alloc(size);
+	if (!entry)
+		return -ENOMEM;
+
+	tlv = (void *)entry->data;
+	tlv->type = cpu_to_le32(BTINTEL_PCIE_INI_DUMP_INFO_TYPE);
+	tlv->len = cpu_to_le32(sizeof(*dump));
+
+	dump = (void *)tlv->data;
+	memset(dump, 0, sizeof(*dump));
+
+	dump->version = cpu_to_le32(BTINTEL_PCIE_INI_DUMP_VER);
+	dump->trigger_reason = cpu_to_le32(data->dmp_hdr.trigger_reason);
+
+	if (data->dmp_hdr.trigger_reason == BTINTEL_PCIE_TRIGGER_REASON_FW_ASSERT)
+		dump->time_point = cpu_to_le32(BTINTEL_PCIE_TIME_POINT_FW_ASSERT);
+	else if (data->dmp_hdr.trigger_reason == BTINTEL_PCIE_TRIGGER_REASON_USER_TRIGGER)
+		dump->time_point = cpu_to_le32(BTINTEL_PCIE_TIME_POINT_USER_TRIGGER);
+
+	dump->hw_type = cpu_to_le32(data->dmp_hdr.cnvi_top & 0xFFFF);
+	bt_dev_dbg(data->hdev, "hw_type=0x%x (cnvi_top=0x%x)",
+		   data->dmp_hdr.cnvi_top & 0xFFFF,
+		   data->dmp_hdr.cnvi_top);
+
+	dump->ver_type = cpu_to_le32(data->dmp_hdr.cnvi_bt);
+	dump->ver_subtype = cpu_to_le32(data->dmp_hdr.fw_git_sha1);
+	dump->hw_step = cpu_to_le32(data->cnvr);
+	dump->rf_id_type = cpu_to_le32(data->dmp_hdr.cnvr_top & 0xFFF);
+	dump->rf_id_flavor = cpu_to_le32(data->dmp_hdr.cnvr_top);
+	bt_dev_dbg(data->hdev, "rf_id_type=0x%x (cnvr_top=0x%x)",
+		   data->dmp_hdr.cnvr_top & 0xFFF,
+		   data->dmp_hdr.cnvr_top);
+	dump->lmac_major = cpu_to_le32(0);
+	dump->lmac_minor = cpu_to_le32(0);
+	dump->umac_major = cpu_to_le32(0);
+	dump->umac_minor = cpu_to_le32(0);
+	dump->fw_mon_mode = cpu_to_le32(BTINTEL_PCIE_FW_MON_MODE_DRAM);
+
+	dump->regions_mask = cpu_to_le64(regions_mask);
+
+	bt_dev_dbg(data->hdev, "ExpectedRegionIDs regions_mask=0x%016llx",
+		   le64_to_cpu(dump->regions_mask));
+
+	snprintf(build_tag, sizeof(build_tag), "%08X", data->dmp_hdr.fw_git_sha1);
+
+	dump->build_tag_len = cpu_to_le32(strlen(build_tag));
+	memcpy(dump->build_tag, build_tag, min(strlen(build_tag),
+					       sizeof(dump->build_tag)));
+
+	dump->num_of_cfg_names = cpu_to_le32(0);
+
+	bt_dev_dbg(data->hdev, "HwType=0x%08x HwStep=0x%08x RfIdType=0x%08x RfIdFlavor=0x%08x",
+		   le32_to_cpu(dump->hw_type), le32_to_cpu(dump->hw_step),
+		   le32_to_cpu(dump->rf_id_type), le32_to_cpu(dump->rf_id_flavor));
+	bt_dev_dbg(data->hdev, "VerType=0x%08x VerSubType=0x%08x",
+		   le32_to_cpu(dump->ver_type), le32_to_cpu(dump->ver_subtype));
+	bt_dev_dbg(data->hdev, "LmacMajor=0x%08x LmacMinor=0x%08x UmacMajor=0x%08x UmacMinor=0x%08x",
+		   le32_to_cpu(dump->lmac_major), le32_to_cpu(dump->lmac_minor),
+		   le32_to_cpu(dump->umac_major), le32_to_cpu(dump->umac_minor));
+	bt_dev_dbg(data->hdev, "TriggerReason=0x%04x MonMode=%u BuildTag=%.64s",
+		   le32_to_cpu(dump->trigger_reason),
+		   le32_to_cpu(dump->fw_mon_mode),
+		   dump->build_tag);
+
+	list_add(&entry->list, list);
+
+	return 0;
+}
+
+static bool btintel_pcie_is_mdbgc_supported(struct btintel_pcie_data *data)
+{
+	return data->pdev->device == BTINTEL_PCIE_DEVICE_ID_NVL_S_SCP2 ||
+		data->pdev->device == BTINTEL_PCIE_DEVICE_ID_NVL_Hx_SCP2 ||
+		data->pdev->device == BTINTEL_PCIE_DEVICE_ID_PTL_FMP2;
+}
+
+static int btintel_pcie_read_debug_regions(struct btintel_pcie_data *data)
+{
+	struct btintel_pcie_dbgc *dbgc = NULL;
+	struct btintel_pcie_mdbgc *mdbgc = NULL;
 	struct hci_dev *hdev = data->hdev;
-	u8 *pdata, *p, buf_idx, hw_variant;
-	struct intel_tlv *tlv;
-	struct timespec64 now;
-	struct tm tm_now;
-	char fw_build[128];
-	char ts[128];
-	char vendor[64];
-	char driver[64];
+	struct btintel_pcie_dump_entry *entry;
+	struct btintel_pcie_dump_file_hdr *file_hdr;
+	struct scatterlist *sg_dump_data;
+	u32 offset, prev_size, wr_ptr_status;
+	u32 region_size;
+	u32 exception_dump_len;
+	u64 regions_mask = 0;
+	u8 buf_idx, hw_variant;
+	u32 smem_rd_addr = 0, smem_rd_size = 0;
+	u32 file_len;
+	u8 count;
+	int ret;
+	LIST_HEAD(dump_list);
 
 	if (!IS_ENABLED(CONFIG_DEV_COREDUMP))
 		return -EOPNOTSUPP;
 
+	bt_dev_info(data->hdev, "%s: WRT dump triggered",
+		    data->dmp_hdr.trigger_reason == BTINTEL_PCIE_TRIGGER_REASON_FW_ASSERT ?
+			"Firmware" : "User");
+
+	if (btintel_pcie_is_mdbgc_supported(data)) {
+		mdbgc = &data->mdbgc;
+		count = mdbgc->count;
+	} else {
+		dbgc = &data->dbgc;
+		count = dbgc->count;
+	}
 
 	hw_variant = INTEL_HW_VARIANT(data->cnvi);
-	switch (hw_variant) {
-	case BTINTEL_HWID_BZRI:
-	case BTINTEL_HWID_BZRIW:
-		status_reg = BTINTEL_PCIE_DBGC_CUR_DBGBUFF_STATUS;
-		wrap_reg = BTINTEL_PCIE_DBGC_DBGBUFF_WRAP_ARND;
-		break;
-	case BTINTEL_HWID_SCP:
-	case BTINTEL_HWID_SCP2:
-	case BTINTEL_HWID_SCP2F:
-		status_reg = BTINTEL_PCIE_DBGC_CUR_DBGBUFF_STATUS_SCP;
-		wrap_reg = BTINTEL_PCIE_DBGC_DBGBUFF_WRAP_ARND_SCP;
-		break;
-	default:
-		bt_dev_err(hdev, "Unsupported Intel hardware variant (0x%2.2x)",
-			   hw_variant);
+
+	if (hw_variant == BTINTEL_HWID_BZRI ||
+	    hw_variant == BTINTEL_HWID_BZRIW) {
+		wr_ptr_status =
+			btintel_pcie_rd_dev_mem(data,
+					       BTINTEL_PCIE_DBGC_CUR_DBGBUFF_STATUS);
+		data->dmp_hdr.wrap_ctr =
+			btintel_pcie_rd_dev_mem(data,
+					       BTINTEL_PCIE_DBGC_DBGBUFF_WRAP_ARND);
+	} else if (hw_variant >= BTINTEL_HWID_SCP) {
+		wr_ptr_status =
+			btintel_pcie_rd_dev_mem(data,
+					       BTINTEL_PCIE_DBGC_CUR_DBGBUFF_STATUS_SCP);
+		data->dmp_hdr.wrap_ctr =
+			btintel_pcie_rd_dev_mem(data,
+					       BTINTEL_PCIE_DBGC_DBGBUFF_WRAP_ARND_SCP);
+	} else {
+		bt_dev_err(hdev, "Unsupported Intel hardware variant (0x%2.2x)", hw_variant);
 		return -EINVAL;
 	}
 
-	wr_ptr_status = btintel_pcie_rd_dev_mem(data, status_reg);
-	data->dmp_hdr.wrap_ctr = btintel_pcie_rd_dev_mem(data, wrap_reg);
-
 	offset = wr_ptr_status & BTINTEL_PCIE_DBG_OFFSET_BIT_MASK;
 
 	buf_idx = BTINTEL_PCIE_DBGC_DBG_BUF_IDX(wr_ptr_status);
-	if (buf_idx > dbgc->count) {
+	if (buf_idx > count) {
 		bt_dev_warn(hdev, "Buffer index is invalid");
 		return -EINVAL;
 	}
@@ -706,102 +1203,193 @@ static int btintel_pcie_read_dram_buffers(struct btintel_pcie_data *data)
 	else
 		return -EINVAL;
 
-	strscpy(vendor, "Vendor: Intel\n");
-	snprintf(driver, sizeof(driver), "Driver: %s\n",
-		 data->dmp_hdr.driver_name);
-
-	ktime_get_real_ts64(&now);
-	time64_to_tm(now.tv_sec, 0, &tm_now);
-	snprintf(ts, sizeof(ts), "Dump Time: %02d-%02d-%04ld %02d:%02d:%02d",
-				 tm_now.tm_mday, tm_now.tm_mon + 1, tm_now.tm_year + 1900,
-				 tm_now.tm_hour, tm_now.tm_min, tm_now.tm_sec);
-
-	snprintf(fw_build, sizeof(fw_build),
-			    "Firmware Timestamp: Year %u WW %02u buildtype %u build %u",
-			    2000 + (data->dmp_hdr.fw_timestamp >> 8),
-			    data->dmp_hdr.fw_timestamp & 0xff, data->dmp_hdr.fw_build_type,
-			    data->dmp_hdr.fw_build_num);
-
-	data_len = sizeof(*tlv) + sizeof(data->dmp_hdr.cnvi_bt) +
-		sizeof(*tlv) + sizeof(data->dmp_hdr.write_ptr) +
-		sizeof(*tlv) + sizeof(data->dmp_hdr.wrap_ctr) +
-		sizeof(*tlv) + sizeof(data->dmp_hdr.trigger_reason) +
-		sizeof(*tlv) + sizeof(data->dmp_hdr.fw_git_sha1) +
-		sizeof(*tlv) + sizeof(data->dmp_hdr.cnvr_top) +
-		sizeof(*tlv) + sizeof(data->dmp_hdr.cnvi_top) +
-		sizeof(*tlv) + strlen(ts) +
-		sizeof(*tlv) + strlen(fw_build) +
-		sizeof(*tlv) + strlen(vendor) +
-		sizeof(*tlv) + strlen(driver);
-
-	if (data->dmp_hdr.event_type && data->dmp_hdr.event_id) {
-		data_len += sizeof(*tlv) + sizeof(data->dmp_hdr.event_type);
-		data_len += sizeof(*tlv) + sizeof(data->dmp_hdr.event_id);
+	bt_dev_dbg(hdev, "wr_ptr_status=0x%08x buf_idx=%u offset=0x%06x",
+		   wr_ptr_status, buf_idx, offset);
+	bt_dev_dbg(hdev, "write_ptr=0x%08x wrap_ctr=0x%08x",
+		   data->dmp_hdr.write_ptr, data->dmp_hdr.wrap_ctr);
+
+	smem_rd_addr = data->dump_info.smem_addr_start;
+	smem_rd_size = (data->dump_info.smem_addr_end + 0x04) -
+		       data->dump_info.smem_addr_start;
+
+	bt_dev_info(hdev, "smem_region: smem_start_addr=0x%08x smem_end_addr=0x%08x smem_rd_size=%u",
+		    smem_rd_addr, data->dump_info.smem_addr_end, smem_rd_size);
+
+	if (smem_rd_size == 0 ||
+	    smem_rd_size > BTINTEL_PCIE_SMEM_MAX_SIZE) {
+		bt_dev_err(hdev, "Invalid smem region: smem_rd_addr 0x%08x size %u (max %u)",
+			   smem_rd_addr, smem_rd_size, BTINTEL_PCIE_SMEM_MAX_SIZE);
+		smem_rd_size = 0;
 	}
 
-	/*
-	 * sizeof(u32) - signature
-	 * sizeof(data_len) - to store tlv data size
-	 * data_len - TLV data
-	 */
-	dump_size = sizeof(u32) + sizeof(data_len) + data_len;
+	if (btintel_pcie_is_mdbgc_supported(data)) {
+		ret = btintel_pcie_dump_dram(&dump_list, count,
+					     mdbgc->buf1, 0,
+					     data->dmp_hdr.write_ptr,
+					     data->dmp_hdr.wrap_ctr,
+					     BTINTEL_PCIE_INI_ID_DRAM_MONITOR1,
+					     "monitor");
+		if (!ret)
+			regions_mask |= BIT_ULL(BTINTEL_PCIE_INI_ID_DRAM_MONITOR1);
+		else
+			bt_dev_warn(hdev, "Failed to dump DRAM buf1: %d", ret);
+
+		ret = btintel_pcie_dump_dram(&dump_list, count,
+					     mdbgc->buf2, 0,
+					     data->dmp_hdr.write_ptr,
+					     data->dmp_hdr.wrap_ctr,
+					     BTINTEL_PCIE_INI_ID_DRAM_MONITOR2,
+					     "monitor2");
+		if (!ret)
+			regions_mask |= BIT_ULL(BTINTEL_PCIE_INI_ID_DRAM_MONITOR2);
+		else
+			bt_dev_warn(hdev, "Failed to dump DRAM buf2: %d", ret);
+
+		ret = btintel_pcie_dump_dram(&dump_list, count,
+					     mdbgc->buf3, 0,
+					     data->dmp_hdr.write_ptr,
+					     data->dmp_hdr.wrap_ctr,
+					     BTINTEL_PCIE_INI_ID_DRAM_MONITOR3,
+					     "monitor3");
+		if (!ret)
+			regions_mask |= BIT_ULL(BTINTEL_PCIE_INI_ID_DRAM_MONITOR3);
+		else
+			bt_dev_warn(hdev, "Failed to dump DRAM buf3: %d", ret);
+	} else {
+		ret = btintel_pcie_dump_dram(&dump_list, count,
+					     dbgc->bufs, 0,
+					     data->dmp_hdr.write_ptr,
+					     data->dmp_hdr.wrap_ctr,
+					     BTINTEL_PCIE_INI_ID_DRAM_MONITOR1,
+					     "monitor");
+		if (!ret)
+			regions_mask |= BIT_ULL(BTINTEL_PCIE_INI_ID_DRAM_MONITOR1);
+		else
+			bt_dev_warn(hdev, "Failed to dump DRAM region: %d", ret);
+	}
+
+	if (smem_rd_size) {
+		ret = btintel_pcie_dump_smem_monitor_region(data, &dump_list,
+							    BTINTEL_PCIE_INI_ID_SMEM,
+							    "monitor_smem",
+							    smem_rd_addr, smem_rd_size);
+		if (!ret)
+			regions_mask |= BIT_ULL(BTINTEL_PCIE_INI_ID_SMEM);
+	}
+
+	exception_dump_len = data->dump_info.exception_dump_len;
+	ret = btintel_pcie_dump_target_region(data, &dump_list,
+					      BTINTEL_PCIE_INI_REGION_DEVICE_MEMORY,
+					      BTINTEL_PCIE_INI_ID_EXCEPTION_EVT,
+					      "EXCEPTION_EVT_BUFFER",
+					      data->dump_info.exception_dump_addr,
+					      exception_dump_len);
+	if (!ret && exception_dump_len)
+		regions_mask |= BIT_ULL(BTINTEL_PCIE_INI_ID_EXCEPTION_EVT);
+
+	if (data->dump_info.dccm_addr_start &&
+	    data->dump_info.dccm_addr_end &&
+	    data->dump_info.dccm_addr_end >= data->dump_info.dccm_addr_start) {
+		region_size = (data->dump_info.dccm_addr_end + 0x04) -
+			      data->dump_info.dccm_addr_start;
+		ret = btintel_pcie_dump_target_region(data, &dump_list,
+						      BTINTEL_PCIE_INI_REGION_DEVICE_MEMORY,
+						      BTINTEL_PCIE_INI_ID_DCCM,
+						      "DCCM",
+						      data->dump_info.dccm_addr_start,
+						      region_size);
+		if (!ret)
+			regions_mask |= BIT_ULL(BTINTEL_PCIE_INI_ID_DCCM);
+	}
+
+	if (data->dump_info.sds_start_addr_start &&
+	    data->dump_info.sds_start_addr_end &&
+	    data->dump_info.sds_start_addr_end >= data->dump_info.sds_start_addr_start) {
+		region_size = (data->dump_info.sds_start_addr_end + 0x04) -
+			      data->dump_info.sds_start_addr_start;
+		ret = btintel_pcie_dump_target_region(data, &dump_list,
+						      BTINTEL_PCIE_INI_REGION_DEVICE_MEMORY,
+						      BTINTEL_PCIE_INI_ID_SDS,
+						      "SDS",
+						      data->dump_info.sds_start_addr_start,
+						      region_size);
+		if (!ret)
+			regions_mask |= BIT_ULL(BTINTEL_PCIE_INI_ID_SDS);
+	}
+
+	if (data->dump_info.sds_iosf_data_addr_start &&
+	    data->dump_info.sds_iosf_data_addr_end &&
+	    data->dump_info.sds_iosf_data_addr_end >= data->dump_info.sds_iosf_data_addr_start) {
+		region_size = (data->dump_info.sds_iosf_data_addr_end + 0x04) -
+			      data->dump_info.sds_iosf_data_addr_start;
+		ret = btintel_pcie_dump_target_region(data, &dump_list,
+						      BTINTEL_PCIE_INI_REGION_DEVICE_MEMORY,
+						      BTINTEL_PCIE_INI_ID_SDS_IOSF,
+						      "SDS_IOSF",
+						      data->dump_info.sds_iosf_data_addr_start,
+						      region_size);
+		if (!ret)
+			regions_mask |= BIT_ULL(BTINTEL_PCIE_INI_ID_SDS_IOSF);
+	}
 
+	if (data->dump_info.ecl_addr_start &&
+	    data->dump_info.ecl_addr_end &&
+	    data->dump_info.ecl_addr_end >= data->dump_info.ecl_addr_start) {
+		region_size = (data->dump_info.ecl_addr_end + 0x04) -
+			      data->dump_info.ecl_addr_start;
+		ret = btintel_pcie_dump_target_region(data, &dump_list,
+						      BTINTEL_PCIE_INI_REGION_DEVICE_MEMORY,
+						      BTINTEL_PCIE_INI_ID_ECL,
+						      "ECL_REGION",
+						      data->dump_info.ecl_addr_start,
+						      region_size);
+		if (!ret)
+			regions_mask |= BIT_ULL(BTINTEL_PCIE_INI_ID_ECL);
+	}
 
-	/* Add debug buffers data length to dump size */
-	dump_size += BTINTEL_PCIE_DBGC_BUFFER_SIZE * dbgc->count;
+	ret = btintel_pcie_dump_info(data, &dump_list, regions_mask);
+	if (ret) {
+		btintel_pcie_dump_list_free(&dump_list);
+		return ret;
+	}
 
-	pdata = vmalloc(dump_size);
-	if (!pdata)
+	file_len = sizeof(*file_hdr) + btintel_pcie_dump_list_total_size(&dump_list);
+	entry = btintel_pcie_dump_entry_alloc(sizeof(*file_hdr));
+	if (!entry) {
+		btintel_pcie_dump_list_free(&dump_list);
 		return -ENOMEM;
-	p = pdata;
-
-	*(u32 *)p = BTINTEL_PCIE_MAGIC_NUM;
-	p += sizeof(u32);
-
-	*(u32 *)p = data_len;
-	p += sizeof(u32);
-
-
-	p = btintel_pcie_copy_tlv(p, BTINTEL_VENDOR, vendor, strlen(vendor));
-	p = btintel_pcie_copy_tlv(p, BTINTEL_DRIVER, driver, strlen(driver));
-	p = btintel_pcie_copy_tlv(p, BTINTEL_DUMP_TIME, ts, strlen(ts));
-	p = btintel_pcie_copy_tlv(p, BTINTEL_FW_BUILD, fw_build,
-				  strlen(fw_build));
-	p = btintel_pcie_copy_tlv(p, BTINTEL_CNVI_BT, &data->dmp_hdr.cnvi_bt,
-				  sizeof(data->dmp_hdr.cnvi_bt));
-	p = btintel_pcie_copy_tlv(p, BTINTEL_WRITE_PTR, &data->dmp_hdr.write_ptr,
-				  sizeof(data->dmp_hdr.write_ptr));
-	p = btintel_pcie_copy_tlv(p, BTINTEL_WRAP_CTR, &data->dmp_hdr.wrap_ctr,
-				  sizeof(data->dmp_hdr.wrap_ctr));
-	p = btintel_pcie_copy_tlv(p, BTINTEL_TRIGGER_REASON, &data->dmp_hdr.trigger_reason,
-				  sizeof(data->dmp_hdr.trigger_reason));
-	p = btintel_pcie_copy_tlv(p, BTINTEL_FW_SHA, &data->dmp_hdr.fw_git_sha1,
-				  sizeof(data->dmp_hdr.fw_git_sha1));
-	p = btintel_pcie_copy_tlv(p, BTINTEL_CNVR_TOP, &data->dmp_hdr.cnvr_top,
-				  sizeof(data->dmp_hdr.cnvr_top));
-	p = btintel_pcie_copy_tlv(p, BTINTEL_CNVI_TOP, &data->dmp_hdr.cnvi_top,
-				  sizeof(data->dmp_hdr.cnvi_top));
-
-	if (data->dmp_hdr.event_type && data->dmp_hdr.event_id) {
-		p = btintel_pcie_copy_tlv(p, BTINTEL_EVENT_TYPE,
-					  &data->dmp_hdr.event_type,
-					  sizeof(data->dmp_hdr.event_type));
-		p = btintel_pcie_copy_tlv(p, BTINTEL_EVENT_ID,
-					  &data->dmp_hdr.event_id,
-					  sizeof(data->dmp_hdr.event_id));
-		data->dmp_hdr.event_type = 0;
-		data->dmp_hdr.event_id = 0;
-	}
-
-	memcpy(p, dbgc->bufs[0].data, dbgc->count * BTINTEL_PCIE_DBGC_BUFFER_SIZE);
-	dev_coredumpv(&hdev->dev, pdata, dump_size, GFP_KERNEL);
+	}
+
+	file_hdr = (void *)entry->data;
+	file_hdr->barker = cpu_to_le32(BTINTEL_PCIE_INI_ERROR_DUMP_BARKER);
+	file_hdr->file_len = cpu_to_le32(file_len);
+	list_add(&entry->list, &dump_list);
+
+	sg_dump_data = btintel_pcie_alloc_sgtable(file_len);
+	if (sg_dump_data) {
+		int sg_entries = sg_nents(sg_dump_data);
+		u32 offs = 0;
+
+		list_for_each_entry(entry, &dump_list, list) {
+			sg_pcopy_from_buffer(sg_dump_data, sg_entries,
+					     entry->data, entry->size, offs);
+			offs += entry->size;
+		}
+
+		bt_dev_info(hdev, "triggering dev_coredumpsg()");
+		dev_coredumpsg(&hdev->dev, sg_dump_data, file_len, GFP_KERNEL);
+	} else {
+		bt_dev_err(hdev, "Failed to allocate scatter-gather table for coredump");
+	}
+
+	btintel_pcie_dump_list_free(&dump_list);
 	return 0;
 }
 
 static void btintel_pcie_dump_traces(struct hci_dev *hdev)
 {
 	struct btintel_pcie_data *data = hci_get_drvdata(hdev);
-	int ret = 0;
+	int ret;
 
 	ret = btintel_pcie_get_mac_access(data);
 	if (ret) {
@@ -809,7 +1397,7 @@ static void btintel_pcie_dump_traces(struct hci_dev *hdev)
 		return;
 	}
 
-	ret = btintel_pcie_read_dram_buffers(data);
+	ret = btintel_pcie_read_debug_regions(data);
 
 	btintel_pcie_release_mac_access(data);
 
@@ -957,10 +1545,241 @@ static inline bool btintel_pcie_in_error(struct btintel_pcie_data *data)
 	return	data->boot_stage_cache & BTINTEL_PCIE_CSR_BOOT_STAGE_ABORT_HANDLER;
 }
 
+static int btintel_parse_mbox_tlv(struct btintel_pcie_data *data)
+{
+	/* Custom TLV structure for mailbox parsing
+	 * len is __le16 as per agreemnt with FW
+	 */
+	struct mbox_tlv {
+		u8 type;
+		__le16 len;
+		u8 val[];
+	} __packed;
+
+	u8 *buffer, *ptr;
+	u32 buffer_len, err, remaining;
+	struct mbox_tlv *tlv;
+	struct btintel_data *cnvi_data = hci_get_priv(data->hdev);
+	u8 hw_variant = INTEL_HW_VARIANT(cnvi_data->cnvi_bt);
+
+	if (!data->debug_table_size || !data->debug_table_addr)
+		return -EINVAL;
+
+	buffer_len = data->debug_table_size;
+
+	buffer = vmalloc(buffer_len);
+	if (!buffer)
+		return -ENOMEM;
+
+	btintel_pcie_mac_init(data);
+
+	err = btintel_pcie_read_device_mem(data, buffer, data->debug_table_addr,
+					   buffer_len);
+	if (err)
+		goto exit_on_error;
+
+	print_hex_dump_debug("dump_info: ", DUMP_PREFIX_OFFSET, 16, 1,
+			     buffer, buffer_len, false);
+
+	ptr = buffer;
+	remaining = buffer_len;
+
+	/* Parse TLV structures: 1 byte type + 2 bytes length + variable value */
+	while (remaining >= sizeof(struct mbox_tlv)) {
+		u16 tlv_len;
+		u32 tlv_total;
+
+		tlv = (struct mbox_tlv *)ptr;
+		tlv_len = le16_to_cpu(tlv->len);
+		tlv_total = sizeof(tlv->type) + sizeof(tlv->len) + tlv_len;
+
+		if (tlv_total > remaining) {
+			bt_dev_err(data->hdev, "TLV parse error: not enough data for TLV value (type=%u, len=%u)",
+				   tlv->type, tlv_len);
+			break;
+		}
+
+		switch (tlv->type) {
+		case BTINTEL_PCIE_TLV_TYPE_EXCEPTION_DUMP_ADDRESS:
+			if (tlv_len < 8) {
+				bt_dev_err(data->hdev,
+					   "TLV %s too short: len=%u (need 8)",
+					   btintel_pcie_dumptype_to_str(data->hdev,
+									tlv->type),
+					   tlv_len);
+				break;
+			}
+			data->dump_info.exception_dump_addr = get_unaligned_le32(&tlv->val[0]);
+			data->dump_info.exception_dump_len = get_unaligned_le32(&tlv->val[4]);
+			break;
+		case BTINTEL_PCIE_TLV_TYPE_DCCM_MEM_ADDRESS:
+			if (tlv_len < 8) {
+				bt_dev_err(data->hdev,
+					   "TLV %s too short: len=%u (need 8)",
+					   btintel_pcie_dumptype_to_str(data->hdev,
+									tlv->type),
+					   tlv_len);
+				break;
+			}
+			data->dump_info.dccm_addr_start = get_unaligned_le32(&tlv->val[0]);
+			data->dump_info.dccm_addr_end = get_unaligned_le32(&tlv->val[4]);
+			break;
+		case BTINTEL_PCIE_TLV_TYPE_SDS_MEM_ADDRESS:
+			if (tlv_len == 16 && hw_variant > BTINTEL_HWID_BZRI) {
+				data->dump_info.sds_start_addr_start =
+					get_unaligned_le32(&tlv->val[0]);
+				data->dump_info.sds_start_addr_end =
+					get_unaligned_le32(&tlv->val[4]);
+				data->dump_info.sds_iosf_data_addr_start =
+					get_unaligned_le32(&tlv->val[8]);
+				data->dump_info.sds_iosf_data_addr_end =
+					get_unaligned_le32(&tlv->val[12]);
+			} else if (tlv_len == 24 && (hw_variant == BTINTEL_HWID_BZRI ||
+						     hw_variant == BTINTEL_HWID_BZRIW)) {
+				data->dump_info.sds_fixed_rom_addr_start =
+					get_unaligned_le32(&tlv->val[0]);
+				data->dump_info.sds_fixed_rom_addr_end =
+					get_unaligned_le32(&tlv->val[4]);
+				data->dump_info.sds_start_addr_start =
+					get_unaligned_le32(&tlv->val[8]);
+				data->dump_info.sds_start_addr_end =
+					get_unaligned_le32(&tlv->val[12]);
+				data->dump_info.sds_iosf_data_addr_start =
+					get_unaligned_le32(&tlv->val[16]);
+				data->dump_info.sds_iosf_data_addr_end =
+					get_unaligned_le32(&tlv->val[20]);
+			} else {
+				bt_dev_err(data->hdev, "SDS TLV: unsupported hw_variant=0x%02x len=%u",
+					   hw_variant, tlv_len);
+			}
+			break;
+		case BTINTEL_PCIE_TLV_TYPE_ECL_MEM_ADDRESS:
+			if (tlv_len < 8) {
+				bt_dev_err(data->hdev,
+					   "TLV %s too short: len=%u (need 8)",
+					   btintel_pcie_dumptype_to_str(data->hdev,
+									tlv->type),
+					   tlv_len);
+				break;
+			}
+			data->dump_info.ecl_addr_start = get_unaligned_le32(&tlv->val[0]);
+			data->dump_info.ecl_addr_end = get_unaligned_le32(&tlv->val[4]);
+			break;
+		case BTINTEL_PCIE_TLV_TYPE_SMEM_ADDRESS:
+			if (tlv_len < 8) {
+				bt_dev_err(data->hdev,
+					   "TLV %s too short: len=%u (need 8)",
+					   btintel_pcie_dumptype_to_str(data->hdev,
+									tlv->type),
+					   tlv_len);
+				break;
+			}
+			data->dump_info.smem_addr_start = get_unaligned_le32(&tlv->val[0]);
+			data->dump_info.smem_addr_end = get_unaligned_le32(&tlv->val[4]);
+			break;
+		default:
+			bt_dev_dbg(data->hdev, "Unknown TLV type: %u length: %u",
+				   tlv->type, tlv_len);
+			break;
+		}
+
+		/* Move to next TLV */
+		ptr += tlv_total;
+		remaining -= tlv_total;
+	}
+
+	bt_dev_info(data->hdev,
+		    "exception_dump: addr:0x%08x len:0x%08x",
+		    data->dump_info.exception_dump_addr,
+		    data->dump_info.exception_dump_len);
+	bt_dev_info(data->hdev,
+		    "dccm: start:0x%08x end:0x%08x",
+		    data->dump_info.dccm_addr_start,
+		    data->dump_info.dccm_addr_end);
+	bt_dev_info(data->hdev,
+		    "sds_fixed_rom: start:0x%08x end:0x%08x",
+		    data->dump_info.sds_fixed_rom_addr_start,
+		    data->dump_info.sds_fixed_rom_addr_end);
+	bt_dev_info(data->hdev,
+		    "sds: start:0x%08x end:0x%08x",
+		    data->dump_info.sds_start_addr_start,
+		    data->dump_info.sds_start_addr_end);
+	bt_dev_info(data->hdev,
+		    "sds_iosf: start:0x%08x end:0x%08x",
+		    data->dump_info.sds_iosf_data_addr_start,
+		    data->dump_info.sds_iosf_data_addr_end);
+	bt_dev_info(data->hdev,
+		    "ecl: start:0x%08x end:0x%08x",
+		    data->dump_info.ecl_addr_start,
+		    data->dump_info.ecl_addr_end);
+	bt_dev_info(data->hdev,
+		    "smem: start:0x%08x end:0x%08x",
+		    data->dump_info.smem_addr_start,
+		    data->dump_info.smem_addr_end);
+
+	vfree(buffer);
+	return 0;
+
+exit_on_error:
+	vfree(buffer);
+	return err;
+}
+
 static void btintel_pcie_msix_gp1_handler(struct btintel_pcie_data *data)
 {
-	bt_dev_err(data->hdev, "Received gp1 mailbox interrupt");
-	btintel_pcie_dump_debug_registers(data->hdev);
+	bool target_access = false;
+	ktime_t calltime, delta, rettime;
+	unsigned long long duration;
+
+	calltime = ktime_get();
+
+	/* Read the Mail box status and registers */
+	data->mbox.mbox_status = btintel_pcie_rd_reg32(data, BTINTEL_PCIE_CSR_MBOX_STATUS_REG);
+	if (data->mbox.mbox_status & BTINTEL_PCIE_CSR_MBOX_STATUS_MBOX1) {
+		data->mbox.mbox1 = btintel_pcie_rd_reg32(data,
+							 BTINTEL_PCIE_CSR_MBOX_1_REG);
+		if (data->mbox.mbox1 == BTINTEL_PCIE_BUILD_SPECIFIC_RESOURCES_MAPPING) {
+			bt_dev_info(data->hdev, "mailbox for target access");
+			target_access = true;
+		}
+	}
+
+	if (data->mbox.mbox_status & BTINTEL_PCIE_CSR_MBOX_STATUS_MBOX2) {
+		data->mbox.mbox2 = btintel_pcie_rd_reg32(data,
+							 BTINTEL_PCIE_CSR_MBOX_2_REG);
+		if (target_access)
+			data->debug_table_addr = data->mbox.mbox2;
+	}
+
+	if (data->mbox.mbox_status & BTINTEL_PCIE_CSR_MBOX_STATUS_MBOX3) {
+		data->mbox.mbox3 = btintel_pcie_rd_reg32(data,
+							 BTINTEL_PCIE_CSR_MBOX_3_REG);
+		if (target_access)
+			data->debug_table_size = data->mbox.mbox3;
+	}
+
+	if (data->mbox.mbox_status & BTINTEL_PCIE_CSR_MBOX_STATUS_MBOX4) {
+		data->mbox.mbox4 = btintel_pcie_rd_reg32(data,
+							 BTINTEL_PCIE_CSR_MBOX_4_REG);
+	}
+
+	bt_dev_err(data->hdev, "GP1_handler: mbox status: 0x%8.8x mbox_1: 0x%8.8x mbox_2: 0x%8.8x mbox_3: 0x%8.8x mbox_4: 0x%8.8x",
+		   data->mbox.mbox_status, data->mbox.mbox1, data->mbox.mbox2,
+		   data->mbox.mbox3, data->mbox.mbox4);
+
+	if (target_access && !test_and_set_bit(BTINTEL_PCIE_MAIL_BOX_INTR, &data->flags)) {
+		if (!queue_work(data->dump_workqueue, &data->mbox_work))
+			clear_bit(BTINTEL_PCIE_MAIL_BOX_INTR, &data->flags);
+	}
+
+	/* Mailbox is read, ack to FW */
+	btintel_pcie_set_reg_bits(data, BTINTEL_PCIE_CSR_IPC_DOORBELL_VEC_REG,
+				  BTINTEL_PCIE_CSR_DOORBELL_MBOX_READ_CONFIRM);
+
+	rettime = ktime_get();
+	delta = ktime_sub(rettime, calltime);
+	duration = (unsigned long long)ktime_to_ns(delta) >> 10;
+	bt_dev_info(data->hdev, "Mailbox acked in %llu usecs", duration);
 }
 
 /* This function handles the MSI-X interrupt for gp0 cause (bit 0 in
@@ -1307,23 +2126,25 @@ static void btintel_pcie_read_hwexp(struct btintel_pcie_data *data)
 		/* only from step B0 onwards */
 		if (INTEL_CNVX_TOP_STEP(data->dmp_hdr.cnvi_top) != 0x01)
 			return;
-		len = BTINTEL_PCIE_BLZR_HWEXP_SIZE; /* exception data length */
-		addr = BTINTEL_PCIE_BLZR_HWEXP_DMP_ADDR;
 		break;
 	case BTINTEL_CNVI_SCP:
-		len = BTINTEL_PCIE_SCP_HWEXP_SIZE;
-		addr = BTINTEL_PCIE_SCP_HWEXP_DMP_ADDR;
-		break;
 	case BTINTEL_CNVI_SCP2:
 	case BTINTEL_CNVI_SCP2F:
-		len = BTINTEL_PCIE_SCP2_HWEXP_SIZE;
-		addr = BTINTEL_PCIE_SCP2_HWEXP_DMP_ADDR;
 		break;
 	default:
 		bt_dev_err(data->hdev, "Unsupported cnvi 0x%8.8x", data->dmp_hdr.cnvi_top);
 		return;
 	}
 
+	len = data->dump_info.exception_dump_len;
+	addr = data->dump_info.exception_dump_addr;
+
+	if (!addr || !len) {
+		bt_dev_err(data->hdev, "Invalid exception address: 0x%8.8x or length: %d",
+			   addr, len);
+		return;
+	}
+
 	buf = kzalloc(len, GFP_KERNEL);
 	if (!buf)
 		goto exit_on_error;
@@ -1576,6 +2397,20 @@ static void btintel_pcie_fwtrigger_worker(struct work_struct *work)
 	clear_bit(BTINTEL_PCIE_FWTRIGGER_DUMP_INPROGRESS, &data->flags);
 }
 
+static void btintel_pcie_mbox_worker(struct work_struct *work)
+{
+	struct btintel_pcie_data *data = container_of(work,
+					struct btintel_pcie_data, mbox_work);
+
+	if (!data->hdev)
+		goto out;
+
+	btintel_parse_mbox_tlv(data);
+out:
+	/* Release guard last; matches set in gp1 handler. */
+	clear_bit(BTINTEL_PCIE_MAIL_BOX_INTR, &data->flags);
+}
+
 static void btintel_pcie_rx_work(struct work_struct *work)
 {
 	struct btintel_pcie_data *data = container_of(work,
@@ -1886,9 +2721,16 @@ static void btintel_pcie_init_ci(struct btintel_pcie_data *data,
 	ci->num_urbdq1 = data->rxq.count;
 	ci->urbdq_db_vec = BTINTEL_PCIE_RXQ_NUM;
 
-	ci->dbg_output_mode = 0x01;
-	ci->dbgc_addr = data->dbgc.frag_p_addr;
-	ci->dbgc_size = data->dbgc.frag_size;
+	ci->dbg_output_mode = BTINTEL_PCIE_DRAM;
+
+	if (btintel_pcie_is_mdbgc_supported(data)) {
+		ci->dbgc_addr = data->mdbgc.frag_p_addr;
+		ci->dbgc_size = data->mdbgc.frag_size;
+	} else {
+		ci->dbgc_addr = data->dbgc.frag_p_addr;
+		ci->dbgc_size = data->dbgc.frag_size;
+	}
+
 	ci->dbg_preset = 0x00;
 }
 
@@ -2116,7 +2958,10 @@ static int btintel_pcie_alloc(struct btintel_pcie_data *data)
 	v_addr += ci_size;
 
 	/* Setup data buffers for dbgc */
-	err = btintel_pcie_setup_dbgc(data);
+	if (btintel_pcie_is_mdbgc_supported(data))
+		err = btintel_pcie_setup_mdbgc(data);
+	else
+		err = btintel_pcie_setup_dbgc(data);
 	if (err)
 		goto exit_error_txq;
 
@@ -2380,6 +3225,7 @@ static int btintel_pcie_setup_internal(struct hci_dev *hdev)
 		goto exit_error;
 	}
 
+	data->dmp_hdr.cnvi_bt = ver_tlv.cnvi_bt;
 	switch (INTEL_HW_PLATFORM(ver_tlv.cnvi_bt)) {
 	case 0x37:
 		break;
@@ -2433,7 +3279,6 @@ static int btintel_pcie_setup_internal(struct hci_dev *hdev)
 	data->dmp_hdr.fw_timestamp = ver_tlv.timestamp;
 	data->dmp_hdr.fw_build_type = ver_tlv.build_type;
 	data->dmp_hdr.fw_build_num = ver_tlv.build_num;
-	data->dmp_hdr.cnvi_bt = ver_tlv.cnvi_bt;
 
 	if (ver_tlv.img_type == 0x02 || ver_tlv.img_type == 0x03)
 		data->dmp_hdr.fw_git_sha1 = ver_tlv.git_sha1;
@@ -2718,6 +3563,7 @@ static void btintel_pcie_reset_work(struct work_struct *wk)
 	disable_work_sync(&data->coredump_work);
 	disable_work_sync(&data->hwexp_work);
 	disable_work_sync(&data->fwtrigger_work);
+	disable_work_sync(&data->mbox_work);
 
 	bt_dev_dbg(data->hdev, "Release bluetooth interface");
 
@@ -2742,6 +3588,7 @@ static void btintel_pcie_reset_work(struct work_struct *wk)
 		enable_work(&data->coredump_work);
 		enable_work(&data->hwexp_work);
 		enable_work(&data->fwtrigger_work);
+		enable_work(&data->mbox_work);
 	}
 
 out:
@@ -2948,6 +3795,7 @@ static int btintel_pcie_probe(struct pci_dev *pdev,
 	INIT_WORK(&data->coredump_work, btintel_pcie_coredump_worker);
 	INIT_WORK(&data->hwexp_work, btintel_pcie_hwexp_worker);
 	INIT_WORK(&data->fwtrigger_work, btintel_pcie_fwtrigger_worker);
+	INIT_WORK(&data->mbox_work, btintel_pcie_mbox_worker);
 
 	data->boot_stage_cache = 0x00;
 	data->img_resp_cache = 0x00;
@@ -3017,6 +3865,7 @@ static void btintel_pcie_remove(struct pci_dev *pdev)
 	disable_work_sync(&data->coredump_work);
 	disable_work_sync(&data->hwexp_work);
 	disable_work_sync(&data->fwtrigger_work);
+	disable_work_sync(&data->mbox_work);
 
 	/* Cancel pending reset work. Skip only when remove() is called from
 	 * within the reset work itself (PLDR device_reprobe path) to avoid
diff --git a/drivers/bluetooth/btintel_pcie.h b/drivers/bluetooth/btintel_pcie.h
index 749369b24031..93aaa1d1e187 100644
--- a/drivers/bluetooth/btintel_pcie.h
+++ b/drivers/bluetooth/btintel_pcie.h
@@ -23,6 +23,8 @@
 #define BTINTEL_PCIE_CSR_MBOX_3_REG		(BTINTEL_PCIE_CSR_BASE + 0x178)
 #define BTINTEL_PCIE_CSR_MBOX_4_REG		(BTINTEL_PCIE_CSR_BASE + 0x17C)
 #define BTINTEL_PCIE_CSR_MBOX_STATUS_REG	(BTINTEL_PCIE_CSR_BASE + 0x180)
+#define BTINTEL_PCIE_CSR_IPC_DOORBELL_VEC_REG	(BTINTEL_PCIE_CSR_BASE + 0x130)
+#define BTINTEL_PCIE_CSR_DOORBELL_MBOX_READ_CONFIRM	(BIT(4))
 #define BTINTEL_PCIE_PRPH_DEV_ADDR_REG		(BTINTEL_PCIE_CSR_BASE + 0x440)
 #define BTINTEL_PCIE_PRPH_DEV_RD_REG		(BTINTEL_PCIE_CSR_BASE + 0x458)
 #define BTINTEL_PCIE_CSR_HBUS_TARG_WRPTR	(BTINTEL_PCIE_CSR_BASE + 0x460)
@@ -67,15 +69,26 @@
 #define BTINTEL_PCIE_DBGC_BASE_ADDR			(0xf3800300)
 #define BTINTEL_PCIE_DBGC_CUR_DBGBUFF_STATUS		(BTINTEL_PCIE_DBGC_BASE_ADDR + 0x1C)
 #define BTINTEL_PCIE_DBGC_DBGBUFF_WRAP_ARND		(BTINTEL_PCIE_DBGC_BASE_ADDR + 0x2C)
+#define BTINTEL_PCIE_DBGC_IF_BASE_ADDR			(BTINTEL_PCIE_DBGC_BASE_ADDR + 0x30)
+#define BTINTEL_PCIE_DBGC_IF_SIZE			(BTINTEL_PCIE_DBGC_BASE_ADDR + 0x34)
+
+#define BTINTEL_PCIE_SMEM_BASE_ADDR			(0xf4000000)
+#define BTINTEL_PCIE_SMEM_END_ADDR			(BTINTEL_PCIE_SMEM_BASE_ADDR + 0x4000)
+
+#define BTINTEL_PCIE_DBGC_BASE_ADDR_BZRI	(0xf3800300)
 
 #define BTINTEL_PCIE_DBGC_BASE_ADDR_SCP			(0xf0d5d500)
 #define BTINTEL_PCIE_DBGC_CUR_DBGBUFF_STATUS_SCP	(BTINTEL_PCIE_DBGC_BASE_ADDR_SCP + 0x1C)
 #define BTINTEL_PCIE_DBGC_DBGBUFF_WRAP_ARND_SCP		(BTINTEL_PCIE_DBGC_BASE_ADDR_SCP + 0x2C)
 
+#define BTINTEL_PCIE_SMEM_FRAGMENT_OFFSET	4
+#define BTINTEL_PCIE_SMEM_MAX_SIZE		(16 * 1024)
 #define BTINTEL_PCIE_DBG_IDX_BIT_MASK		0x0F
 #define BTINTEL_PCIE_DBGC_DBG_BUF_IDX(data)	(((data) >> 24) & BTINTEL_PCIE_DBG_IDX_BIT_MASK)
 #define BTINTEL_PCIE_DBG_OFFSET_BIT_MASK	0xFFFFFF
 
+#define BTINTEL_PCIE_TARGET_ACCESS_FRAG_OFFSET	4
+
 /* The DRAM buffer count, each buffer size, and
  * fragment buffer size
  */
@@ -91,6 +104,27 @@
 /* Num of alloc Dbg buff (4) + (LSB(4), MSB(4), Size(4)) for each buffer */
 #define BTINTEL_PCIE_DBGC_FRAG_PAYLOAD_SIZE	196
 
+#define BTINTEL_PCIE_MDBGC_FRAG_VERSION		2
+#define BTINTEL_PCIE_MDBGC_TOTAL_BUFFER_COUNT	(16 * 3)
+
+#define BTINTEL_PCIE_MDBGC_ALLOCATIONID_1		0
+#define BTINTEL_PCIE_MDBGC_ALLOCATIONID_2		1
+#define BTINTEL_PCIE_MDBGC_ALLOCATIONID_3		2
+
+/* Magic number(4), version(4), size of payload length(4) */
+#define BTINTEL_PCIE_MDBGC_FRAG_HEADER_SIZE		12
+
+/* Num of alloc Dbg buff (4) + (LSB(4), MSB(4), Size(4)) for each buffer */
+#define BTINTEL_PCIE_MDBGC_FRAG_PAYLOAD_SIZE	196
+
+#define BTINTEL_PCIE_DEVICE_ID_NVL_S_SCP2	0x6E74
+#define BTINTEL_PCIE_DEVICE_ID_NVL_Hx_SCP2	0xD346
+#define BTINTEL_PCIE_DEVICE_ID_PTL_FMP2		0xE476
+
+#define BTINTEL_PCIE_SMEM	0x00
+#define BTINTEL_PCIE_DRAM	0x01
+#define BTINTEL_PCIE_FW_MON_MODE_DRAM	0x02
+
 /* Causes for the FH register interrupts */
 enum msix_fh_int_causes {
 	BTINTEL_PCIE_MSIX_FH_INT_CAUSES_0	= BIT(0),	/* cause 0 */
@@ -121,7 +155,8 @@ enum {
 	BTINTEL_PCIE_COREDUMP_INPROGRESS,
 	BTINTEL_PCIE_FWTRIGGER_DUMP_INPROGRESS,
 	BTINTEL_PCIE_RECOVERY_IN_PROGRESS,
-	BTINTEL_PCIE_SETUP_DONE
+	BTINTEL_PCIE_SETUP_DONE,
+	BTINTEL_PCIE_MAIL_BOX_INTR
 };
 
 enum btintel_pcie_tlv_type {
@@ -137,7 +172,20 @@ enum btintel_pcie_tlv_type {
 	BTINTEL_VENDOR,
 	BTINTEL_DRIVER,
 	BTINTEL_EVENT_TYPE,
-	BTINTEL_EVENT_ID
+	BTINTEL_EVENT_ID,
+	BTINTEL_DRAM_REGION,
+	BTINTEL_SMEM_REGION,
+	BTINTEL_DCCM_BASE_ADDR,
+	BTINTEL_DCCM_REGION,
+	BTINTEL_SDS_BASE_ADDR,
+	BTINTEL_SDS_REGION,
+	BTINTEL_SDS_IOSF_BASE_ADDR,
+	BTINTEL_SDS_IOSF_DATA_REGION,
+	BTINTEL_SDS_FIXED_ROM_BASE_ADDR,
+	BTINTEL_SDS_FIXED_ROM_REGION,
+	BTINTEL_EXCEPTION_EVT_DEBUG_REGION,
+	BTINTEL_ECL_BASE_ADDR,
+	BTINTEL_ECL_REGION
 };
 
 /* causes for the MBOX interrupts */
@@ -153,6 +201,14 @@ enum btintel_pcie_reset_type {
 	BTINTEL_PCIE_IOSF_PRR_PLDR = 1,
 };
 
+enum btintel_pcie_mbox_msg {
+	BTINTEL_PCIE_NO_USE = 0,
+	BTINTEL_PCIE_TOP_SILENT_RESET,
+	BTINTEL_PCIE_SB_AUDIO_DEVICE_REPORT,
+	BTINTEL_PCIE_BUILD_SPECIFIC_RESOURCES_MAPPING,
+	BTINTEL_PCIE_LAST_MESSAGE = 4095 /* 0xFFF= 0x100-0x1 */
+};
+
 #define BTINTEL_PCIE_MSIX_NON_AUTO_CLEAR_CAUSE	BIT(7)
 
 /* Minimum and Maximum number of MSI-X Vector
@@ -198,6 +254,12 @@ enum {
 /* RBD buffer size mapping */
 #define BTINTEL_PCIE_RBD_SIZE_4K	0x04
 
+#define BTINTEL_PCIE_TLV_TYPE_EXCEPTION_DUMP_ADDRESS  0x04
+#define BTINTEL_PCIE_TLV_TYPE_DCCM_MEM_ADDRESS        0x05
+#define BTINTEL_PCIE_TLV_TYPE_SDS_MEM_ADDRESS         0x06
+#define BTINTEL_PCIE_TLV_TYPE_ECL_MEM_ADDRESS         0x07
+#define BTINTEL_PCIE_TLV_TYPE_SMEM_ADDRESS	      0x08
+
 /*
  * Struct for Context Information (v2)
  *
@@ -424,6 +486,62 @@ struct btintel_pcie_dbgc {
 	struct data_buf *bufs;
 };
 
+struct btintel_pcie_mdbgc {
+	u32		count;
+
+	void		*frag_v_addr;
+	dma_addr_t	frag_p_addr;
+	u32		frag_size;
+
+	dma_addr_t	buf1_p_addr;
+	void		*buf1_v_addr;
+	dma_addr_t	buf2_p_addr;
+	void		*buf2_v_addr;
+	dma_addr_t	buf3_p_addr;
+	void		*buf3_v_addr;
+	struct data_buf *buf1;
+	struct data_buf *buf2;
+	struct data_buf *buf3;
+};
+
+/* Structure for packing dump to decoder
+ * @type: TLV type
+ * @len: The length of TLV is u32 as agreed with decoder to accomadate larger
+ * dumps
+ * @val: TLV value
+ */
+struct intel_pcie_tlv {
+	u8 type;
+	u32 len;
+	u8 val[];
+} __packed;
+
+struct btintel_pcie_dump_mem_info {
+	u32	exception_dump_addr;
+	u32	exception_dump_len;
+	u32	dccm_addr_start;
+	u32	dccm_addr_end;
+	u32	sds_fixed_rom_addr_start;
+	u32	sds_fixed_rom_addr_end;
+	u32	sds_start_addr_start;
+	u32	sds_start_addr_end;
+	u32	sds_iosf_data_addr_start;
+	u32	sds_iosf_data_addr_end;
+	u32	ecl_addr_start;
+	u32	ecl_addr_end;
+	u32	smem_addr_start;
+	u32	smem_addr_end;
+};
+
+struct btintel_pcie_mbox {
+	u32 mbox_flags;
+	u32 mbox_status;
+	u32 mbox1;
+	u32 mbox2;
+	u32 mbox3;
+	u32 mbox4;
+};
+
 struct btintel_pcie_dump_header {
 	const char	*driver_name;
 	u32		cnvi_top;
@@ -441,6 +559,145 @@ struct btintel_pcie_dump_header {
 	u16		event_id;
 };
 
+/* Per-fragment range descriptor for dump regions.
+ * Binary-compatible with iwl_fw_ini_error_dump_range.
+ */
+struct btintel_pcie_dump_range {
+	__le32	range_data_size;
+	union {
+		__le32	internal_base_addr;
+		__le64	dram_base_addr;
+		__le32	page_num;
+	};
+	__le32	data[];
+} __packed;
+
+/*
+ * INI region types for ini_dump_data.type field.
+ * The unified decoder dispatches parsing logic based on these values.
+ */
+#define BTINTEL_PCIE_INI_REGION_INTERNAL_BUFFER	2
+#define BTINTEL_PCIE_INI_REGION_DRAM_BUFFER	3
+#define BTINTEL_PCIE_INI_REGION_DEVICE_MEMORY	9
+
+/* INI region IDs - used in dump header region_id field and regions_mask */
+#define BTINTEL_PCIE_INI_ID_EXCEPTION_EVT	7
+#define BTINTEL_PCIE_INI_ID_SMEM		15
+#define BTINTEL_PCIE_INI_ID_DCCM		39
+#define BTINTEL_PCIE_INI_ID_SDS			40
+#define BTINTEL_PCIE_INI_ID_SDS_IOSF		41
+#define BTINTEL_PCIE_INI_ID_ECL			42
+#define BTINTEL_PCIE_INI_ID_DRAM_MONITOR3	61
+#define BTINTEL_PCIE_INI_ID_DRAM_MONITOR2	62
+#define BTINTEL_PCIE_INI_ID_DRAM_MONITOR1	63
+
+/*
+ * INI (Intel INI debug infrastructure) style dump data TLV - wraps each dump
+ * region. INI is the iwlwifi firmware debug format used by the unified decoder.
+ * Compatible with iwl_fw_ini_error_dump_data.
+ */
+struct btintel_pcie_ini_dump_data {
+	u8	type;
+	u8	sub_type;
+	u8	sub_type_ver;
+	u8	reserved;
+	__le32	len;
+	u8	data[];
+} __packed;
+
+/*
+ * INI-style region dump header.
+ * Compatible with iwl_fw_ini_error_dump_header.
+ */
+#define BTINTEL_PCIE_INI_MAX_NAME	32
+#define BTINTEL_PCIE_INI_DUMP_VER	1
+
+struct btintel_pcie_ini_dump_header {
+	__le32	version;
+	__le32	region_id;
+	__le32	num_of_ranges;
+	__le32	name_len;
+	u8	name[BTINTEL_PCIE_INI_MAX_NAME];
+};
+
+/*
+ * INI-style monitor dump - region header + monitor state.
+ * Compatible with iwl_fw_ini_monitor_dump.
+ */
+struct btintel_pcie_ini_monitor_dump {
+	struct btintel_pcie_ini_dump_header header;
+	__le32	write_ptr;
+	__le32	cycle_cnt;
+	__le32	cur_frag;
+	u8	data[];
+} __packed;
+
+/* Linked list entry for modular dump collection */
+struct btintel_pcie_dump_entry {
+	struct list_head	list;
+	u32			size;
+	u8			data[];
+};
+
+/* File-level header for coredump output.
+ * Compatible with iwl_fw_ini_dump_file_hdr.
+ * Uses IWL_FW_INI_ERROR_DUMP_BARKER (0x14789633) for decoder compatibility.
+ */
+#define BTINTEL_PCIE_INI_ERROR_DUMP_BARKER	0x14789633
+
+struct btintel_pcie_dump_file_hdr {
+	__le32	barker;
+	__le32	file_len;
+} __packed;
+
+/*
+ * Legacy-style dump data wrapper for dump info TLV.
+ * Compatible with iwl_fw_error_dump_data.
+ * Used only for the dump info entry (type=BTINTEL_PCIE_INI_DUMP_INFO_TYPE).
+ */
+struct btintel_pcie_error_dump_data {
+	__le32	type;
+	__le32	len;
+	u8	data[];
+} __packed;
+
+/* Use bit 31 as dump info type, matching IWL_INI_DUMP_INFO_TYPE */
+#define BTINTEL_PCIE_INI_DUMP_INFO_TYPE	BIT(31)
+
+/* Time point values matching iwl_fw_ini_time_point for fwdump parser */
+#define BTINTEL_PCIE_TIME_POINT_FW_ASSERT	4
+#define BTINTEL_PCIE_TIME_POINT_USER_TRIGGER	9
+
+/*
+ * Dump info struct - single TLV containing all metadata.
+ * Compatible with iwl_fw_ini_dump_info.
+ * Packs all device/firmware info that the decoder needs.
+ */
+struct btintel_pcie_ini_dump_info {
+	__le32	version;
+	__le32	time_point;
+	__le32	trigger_reason;
+	__le32	external_cfg_state;
+	__le32	ver_type;
+	__le32	ver_subtype;
+	__le32	hw_step;
+	__le32	hw_type;
+	__le32	rf_id_flavor;
+	__le32	rf_id_dash;
+	__le32	rf_id_step;
+	__le32	rf_id_type;
+	__le32	lmac_major;
+	__le32	lmac_minor;
+	__le32	umac_major;
+	__le32	umac_minor;
+	__le32	fw_mon_mode;
+	__le64	regions_mask;
+	__le32	build_tag_len;
+	u8	build_tag[64];
+	__le32	num_of_cfg_names;
+	/* no cfg_names for BT - keep zero-length */
+} __packed;
+
 /* struct btintel_pcie_data
  * @pdev: pci device
  * @hdev: hdev device
@@ -522,6 +779,7 @@ struct btintel_pcie_data {
 	struct work_struct	coredump_work;
 	struct work_struct	hwexp_work;
 	struct work_struct	fwtrigger_work;
+	struct work_struct	mbox_work;
 
 	struct dma_pool	*dma_pool;
 	dma_addr_t	dma_p_addr;
@@ -535,10 +793,15 @@ struct btintel_pcie_data {
 	u32	alive_intr_ctxt;
 	enum btintel_pcie_reset_type	reset_type;
 	struct btintel_pcie_dbgc	dbgc;
+	struct btintel_pcie_mdbgc	mdbgc;
 	struct btintel_pcie_dump_header dmp_hdr;
 	u8	pm_sx_event;
 	u32	debug_evt_addr;
 	u32	debug_evt_size;
+	dma_addr_t	debug_table_addr;
+	u32	debug_table_size;
+	struct btintel_pcie_dump_mem_info	dump_info;
+	struct btintel_pcie_mbox	mbox;
 };
 
 static inline u32 btintel_pcie_rd_reg32(struct btintel_pcie_data *data,
-- 
2.43.0

