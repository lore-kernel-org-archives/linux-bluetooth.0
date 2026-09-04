Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA0B1A9F96
	for <linux-bluetooth@vger.kernel.org>; Fri,  4 Sep 2026 00:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788481842; cv=none; b=kzlQBBGOQvFinX0bwnaWhKIYeeBnPnLAljH0uKETTFrEUOlaufhVPi25P6TNJAV6qBQDlGtj+Z0CcATu3sDQW1XsoRD6lD1RyBKbte4aa0mrkzQXsRfMppFg9tFGuCGB6dbjFvMOXo2+M0a7yfdszpphpLRDn4n32Qp0ivUKhBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788481842; c=relaxed/simple;
	bh=kEO6Jd88qM3JiJldRGsf1LFxRPbOyfNduq5Z0ib7JZo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AuloYo3PZajuYaaJAmNDaXVJ1cOYWmUSp/DGuu0cojcgkoNWwS3YYruFNSYKnB6QF3uEA620HP4Ysp1OrS1JdyI6TMnVxxBdBM1FXrTF9LF9+LejCqn+KH2S3X4pcxR2bVNIkB/bwSfJ7nlnBpnJRNojhRQuHQ+CtgTrGndTmfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NzIUQ1PU; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NzIUQ1PU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788481839; x=1820017839;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kEO6Jd88qM3JiJldRGsf1LFxRPbOyfNduq5Z0ib7JZo=;
  b=NzIUQ1PUqswmeVLvF2Ps/H9ouN7oz8FlJUdAjxwD50VIPMx8oSEmC16C
   BzXXN6LDHhdxS9VzCqRhDxHEy7kswpmTASlzDBUNaNh5XSoQTDWlHbTLw
   Jn8/yWmUN7XTO6840SypwiiFE1FCpvMAmur1ugBsYiCuMyUJEYar6E03X
   Pn0pEJJrrNi1ddQhF4uLnRrgclKgqoNcNnStokv8u1ywWQaA4h8INVYUZ
   fbsHVZR78YHkIJ6w1MtgRTL3hGfCFiNW5OgZNqyz31uqt+nlhAWOS2lz8
   ql5eaSXnX87JP58iJbnMNIagNOfIdfoDB6l7ZJZS32njeHdqx2PSwFj9k
   w==;
X-CSE-ConnectionGUID: YeIvTk3zQ+SPOvUJ+c0CqQ==
X-CSE-MsgGUID: skef3nTRQJO8gWPmw/BmEA==
X-IronPort-AV: E=McAfee;i="6800,10657,11895"; a="92851840"
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; 
   d="scan'208";a="92851840"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 17:30:39 -0700
X-CSE-ConnectionGUID: fXlaakTMQj2H+8nrx75SCw==
X-CSE-MsgGUID: vA2IvzY8RP6fBkDFkG2zPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; 
   d="scan'208";a="274034615"
Received: from weba0957.iind.intel.com (HELO WEBA0932.iind.intel.com) ([10.224.186.34])
  by orviesa005.jf.intel.com with ESMTP; 03 Sep 2026 17:30:37 -0700
From: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: ravishankar.srivatsa@intel.com,
	chethan.tumkur.narayan@intel.com,
	kiran.k@intel.com,
	Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>
Subject: [PATCH v2 3/3] Bluetooth: btintel_pcie: unified decoder coredump format
Date: Fri,  4 Sep 2026 05:59:38 +0530
Message-ID: <20260904002939.622659-3-chandrashekar.devegowda@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260828142725.241243-1-chandrashekar.devegowda@intel.com>
References: <20260828142725.241243-1-chandrashekar.devegowda@intel.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the legacy TLV-based coredump with a unified INI-format dump
compatible with the iwlwifi decoder so a single decoder can parse
coredumps across all Intel BT PCIe controller variants.

The dump is emitted via dev_coredumpsg() as structured regions built
from firmware-advertised addresses: DRAM monitor buffers (single or
MDBGC multi-buffer), SMEM monitor, exception event buffer, DCCM, SDS,
SDS IOSF, ECL and dump info metadata. Regions are collected only when
firmware advertises a valid address and size, and only collected
regions are advertised in regions_mask.

Add INTEL_CNVX_TOP_DASH() and INTEL_CNVX_TOP_FLAVOR() helpers to
btintel.h for RfIdDash/RfIdFlavor extraction.

Assisted-by: Copilot:gemini-3.6-flash
Signed-off-by: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>
---
Changes in v2:
 - Reworded the commit message for brevity.
 - Add btintel_pcie_dump_dram_monitor() helper that reads the
   per-allocation status/wrap registers (0x100 * allocation_id
   offset) for each MDBGC pool, stores the per-fragment DWORD write
   offset in mon_dump->write_ptr, and stores the active fragment
   index in mon_dump->cur_frag, replacing the previously flattened
   write_ptr / hard-coded cur_frag = 0 encoding.
 - btintel_pcie_dump_target_region() now returns a skip indicator
   (leaving regions_mask untouched) when the firmware does not
   advertise a valid region, avoiding a spurious
   "Skipping empty dump region: EXCEPTION_EVT_BUFFER" warning when
   the exception dump TLV is absent. It also skips when the size
   rounded down to 4-byte alignment collapses to zero.
 - Log via bt_dev_dbg (instead of bt_dev_err) when firmware does
   not advertise an SMEM monitor region, so the absence of an
   optional TLV is not reported as an error.

 drivers/bluetooth/btintel.h      |   2 +
 drivers/bluetooth/btintel_pcie.c | 887 ++++++++++++++++++++++++-------
 drivers/bluetooth/btintel_pcie.h | 149 +++++-
 3 files changed, 846 insertions(+), 192 deletions(-)

diff --git a/drivers/bluetooth/btintel.h b/drivers/bluetooth/btintel.h
index ef232820c31b..c00f793d9dc8 100644
--- a/drivers/bluetooth/btintel.h
+++ b/drivers/bluetooth/btintel.h
@@ -225,7 +225,9 @@ struct btintel_sar_rev2 {
 #define INTEL_HW_PLATFORM(cnvx_bt)	((u8)(((cnvx_bt) & 0x0000ff00) >> 8))
 #define INTEL_HW_VARIANT(cnvx_bt)	((u8)(((cnvx_bt) & 0x003f0000) >> 16))
 #define INTEL_CNVX_TOP_TYPE(cnvx_top)	((cnvx_top) & 0x00000fff)
+#define INTEL_CNVX_TOP_DASH(cnvx_top)	(((cnvx_top) & 0x00f00000) >> 20)
 #define INTEL_CNVX_TOP_STEP(cnvx_top)	(((cnvx_top) & 0x0f000000) >> 24)
+#define INTEL_CNVX_TOP_FLAVOR(cnvx_top)	(((cnvx_top) & 0xf0000000) >> 28)
 #define INTEL_CNVX_TOP_PACK_SWAB(t, s)	__swab16(((__u16)(((t) << 4) | (s))))
 
 enum {
diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index 233cb8a3cbd4..38a6dbd04dcf 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -19,6 +19,7 @@
 
 #include <linux/unaligned.h>
 #include <linux/devcoredump.h>
+#include <linux/scatterlist.h>
 
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
@@ -198,7 +199,15 @@ static inline bool btintel_pcie_dbg_to_wifi(struct btintel_pcie_data *data)
 	return data->dbg_path_cache != BTINTEL_PCIE_DRAM;
 }
 
-/* Helper function to allocate and setup a debug buffer group */
+/* Helper function to allocate and setup a debug buffer group
+ * @data: driver data structure
+ * @buf: pointer to data_buf array pointer
+ * @p_addr: pointer to physical DMA address
+ * @v_addr: pointer to virtual address
+ * @frag: pointer to fragment buffer array
+ * @buf_index: buffer index (for error messages)
+ * @buf_count: number of buffers to allocate
+ */
 static int btintel_pcie_alloc_dbgc_buf(struct btintel_pcie_data *data,
 				       struct data_buf **buf,
 				       dma_addr_t *p_addr,
@@ -213,39 +222,36 @@ static int btintel_pcie_alloc_dbgc_buf(struct btintel_pcie_data *data,
 	*buf = devm_kcalloc(&data->pdev->dev, buf_count,
 			    sizeof(**buf), GFP_KERNEL);
 	if (!*buf) {
-		BT_ERR("Failed to allocate dbgc buf: %u",
-		       buf_index + 1);
+		BT_ERR("Failed to allocate dbgc buf: %u", buf_index + 1);
 		return -ENOMEM;
 	}
 
 	*v_addr = dmam_alloc_coherent(&data->pdev->dev,
 				      buf_count *
-				      BTINTEL_PCIE_DBGC_BUFFER_SIZE,
-				      p_addr,
-				      GFP_KERNEL | __GFP_NOWARN);
+					BTINTEL_PCIE_DBGC_BUFFER_SIZE,
+					p_addr,
+					GFP_KERNEL | __GFP_NOWARN);
 	if (!*v_addr) {
-		BT_ERR("Failed to allocate dbgc buf: %u DMA",
-		       buf_index + 1);
+		BT_ERR("Failed to allocate dbgc buf: %u DMA", buf_index + 1);
 		return -ENOMEM;
 	}
 
 	for (i = 0; i < buf_count; i++) {
 		b = &(*buf)[i];
-		b->data_p_addr = *p_addr +
-				 i * BTINTEL_PCIE_DBGC_BUFFER_SIZE;
-		b->data = *v_addr +
-			  i * BTINTEL_PCIE_DBGC_BUFFER_SIZE;
-		frag[i].buf_addr_lsb =
-			lower_32_bits(b->data_p_addr);
-		frag[i].buf_addr_msb =
-			upper_32_bits(b->data_p_addr);
+		b->data_p_addr = *p_addr + i * BTINTEL_PCIE_DBGC_BUFFER_SIZE;
+		b->data = *v_addr + i * BTINTEL_PCIE_DBGC_BUFFER_SIZE;
+		frag[i].buf_addr_lsb = lower_32_bits(b->data_p_addr);
+		frag[i].buf_addr_msb = upper_32_bits(b->data_p_addr);
 		frag[i].buf_size = BTINTEL_PCIE_DBGC_BUFFER_SIZE;
 	}
 
 	return 0;
 }
 
-/* This function initializes the memory for MDBGC buffers */
+/* This function initializes the memory for MDBGC buffers and formats the
+ * DBGC fragment which consists header info and DBGC buffer's LSB, MSB and
+ * size as the payload
+ */
 static int btintel_pcie_setup_mdbgc(struct btintel_pcie_data *data)
 {
 	struct btintel_pcie_mdbgc_ctxt db_frag;
@@ -255,15 +261,19 @@ static int btintel_pcie_setup_mdbgc(struct btintel_pcie_data *data)
 
 	data->mdbgc.count = BTINTEL_PCIE_DBGC_BUFFER_COUNT;
 
+	/* Allocate fragment context structure */
 	frag_v_addr = dmam_alloc_coherent(&data->pdev->dev, frag_size,
 					  &data->mdbgc.frag_p_addr,
 					  GFP_KERNEL | __GFP_NOWARN);
-	if (!frag_v_addr)
+	if (!frag_v_addr) {
+		BT_ERR("Failed to allocate mdbgc context");
 		return -ENOMEM;
+	}
 
 	data->mdbgc.frag_v_addr = frag_v_addr;
 	data->mdbgc.frag_size = frag_size;
 
+	/* Initialize fragment header */
 	memset(&db_frag, 0, sizeof(db_frag));
 	db_frag.magic_num = BTINTEL_PCIE_MAGIC_NUM;
 	db_frag.ver = BTINTEL_PCIE_MDBGC_FRAG_VERSION;
@@ -275,7 +285,8 @@ static int btintel_pcie_setup_mdbgc(struct btintel_pcie_data *data)
 					  &data->mdbgc.buf1,
 					  &data->mdbgc.buf1_p_addr,
 					  &data->mdbgc.buf1_v_addr,
-					  db_frag.buf1, 0,
+					  db_frag.buf1,
+					  0,
 					  data->mdbgc.count);
 	if (err)
 		return err;
@@ -287,7 +298,8 @@ static int btintel_pcie_setup_mdbgc(struct btintel_pcie_data *data)
 					  &data->mdbgc.buf2,
 					  &data->mdbgc.buf2_p_addr,
 					  &data->mdbgc.buf2_v_addr,
-					  db_frag.buf2, 1,
+					  db_frag.buf2,
+					  1,
 					  data->mdbgc.count);
 	if (err)
 		return err;
@@ -299,58 +311,64 @@ static int btintel_pcie_setup_mdbgc(struct btintel_pcie_data *data)
 					  &data->mdbgc.buf3,
 					  &data->mdbgc.buf3_p_addr,
 					  &data->mdbgc.buf3_v_addr,
-					  db_frag.buf3, 2,
+					  db_frag.buf3,
+					  2,
 					  data->mdbgc.count);
 	if (err)
 		return err;
 
+	/* Copy fragment to DMA coherent memory */
 	memcpy(data->mdbgc.frag_v_addr, &db_frag, sizeof(db_frag));
 	return 0;
 }
 
-/* This function initializes the memory for DBGC buffers */
+/* This function initializes the memory for DBGC buffers and formats the
+ * DBGC fragment which consists header info and DBGC buffer's LSB, MSB and
+ * size as the payload
+ */
 static int btintel_pcie_setup_dbgc(struct btintel_pcie_data *data)
 {
 	struct btintel_pcie_dbgc_ctxt db_frag;
+	u32 frag_size = sizeof(db_frag);
 	int err;
 
 	data->dbgc.count = BTINTEL_PCIE_DBGC_BUFFER_COUNT;
 
+	/* Allocate fragment context structure */
 	data->dbgc.frag_v_addr = dmam_alloc_coherent(&data->pdev->dev,
-				sizeof(struct btintel_pcie_dbgc_ctxt),
-				&data->dbgc.frag_p_addr,
-				GFP_KERNEL | __GFP_NOWARN);
-	if (!data->dbgc.frag_v_addr)
+						     frag_size,
+						     &data->dbgc.frag_p_addr,
+						     GFP_KERNEL | __GFP_NOWARN);
+	if (!data->dbgc.frag_v_addr) {
+		BT_ERR("Failed to allocate dbgc context");
 		return -ENOMEM;
+	}
 
 	data->dbgc.frag_size = sizeof(struct btintel_pcie_dbgc_ctxt);
 
+	/* Initialize fragment header */
 	memset(&db_frag, 0, sizeof(db_frag));
 	db_frag.magic_num = BTINTEL_PCIE_MAGIC_NUM;
 	db_frag.ver = BTINTEL_PCIE_DBGC_FRAG_VERSION;
 	db_frag.total_size = BTINTEL_PCIE_DBGC_FRAG_PAYLOAD_SIZE;
 	db_frag.num_buf = BTINTEL_PCIE_DBGC_FRAG_BUFFER_COUNT;
 
+	/* Allocate DBGC buffers */
 	err = btintel_pcie_alloc_dbgc_buf(data,
 					  &data->dbgc.bufs,
 					  &data->dbgc.buf_p_addr,
 					  &data->dbgc.buf_v_addr,
-					  db_frag.bufs, 0,
+					  db_frag.bufs,
+					  0,
 					  data->dbgc.count);
 	if (err)
 		return err;
 
+	/* Copy fragment to DMA coherent memory */
 	memcpy(data->dbgc.frag_v_addr, &db_frag, sizeof(db_frag));
 	return 0;
 }
 
-static bool btintel_pcie_is_mdbgc_supported(struct btintel_pcie_data *data)
-{
-	return data->pdev->device == BTINTEL_PCIE_DEVICE_ID_NVL_S_SCP2 ||
-		data->pdev->device == BTINTEL_PCIE_DEVICE_ID_NVL_Hx_SCP2 ||
-		data->pdev->device == BTINTEL_PCIE_DEVICE_ID_PTL_FMP2;
-}
-
 static inline void ipc_print_ia_ring(struct hci_dev *hdev, struct ia *ia,
 				     u16 queue_num)
 {
@@ -753,169 +771,673 @@ static void btintel_pcie_release_mac_access(struct btintel_pcie_data *data)
 	}
 }
 
-static void *btintel_pcie_copy_tlv(void *dest, enum btintel_pcie_tlv_type type,
-				   void *data, size_t size)
+static struct scatterlist *btintel_pcie_alloc_sgtable(ssize_t size)
 {
-	struct intel_tlv *tlv;
+	int nents, i;
+	struct page *page;
+	struct scatterlist *sg, *result;
+
+	if (size <= 0)
+		return NULL;
+
+	nents = DIV_ROUND_UP(size, PAGE_SIZE);
+	result = kcalloc(nents, sizeof(*result), GFP_KERNEL);
+	if (!result)
+		return NULL;
+
+	sg_init_table(result, nents);
+	sg = result;
 
-	tlv = dest;
-	tlv->type = type;
-	tlv->len = size;
-	memcpy(tlv->val, data, tlv->len);
-	return dest + sizeof(*tlv) + size;
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
 }
 
-static int btintel_pcie_read_dram_buffers(struct btintel_pcie_data *data)
+static struct btintel_pcie_dump_entry *
+btintel_pcie_dump_entry_alloc(u32 data_size)
 {
-	u32 offset, prev_size, wr_ptr_status, dump_size, data_len;
-	u32 status_reg, wrap_reg;
-	struct btintel_pcie_dbgc *dbgc = &data->dbgc;
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
+				  u32 write_ptr, u32 wrap_ctr, u32 cur_frag,
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
+	mon_dump->cur_frag = cpu_to_le32(cur_frag);
+
+	range = (void *)mon_dump->data;
+	for (i = 0; i < count; i++) {
+		range->range_data_size =
+			cpu_to_le32(BTINTEL_PCIE_DBGC_BUFFER_SIZE);
+		range->dram_base_addr = cpu_to_le64(bufs[i].data_p_addr);
+		memcpy(range->data, bufs[i].data,
+		       BTINTEL_PCIE_DBGC_BUFFER_SIZE);
+		range = (void *)range->data + BTINTEL_PCIE_DBGC_BUFFER_SIZE;
+	}
+
+	list_add_tail(&entry->list, list);
+	return 0;
+}
+
+static int
+btintel_pcie_dump_dram_monitor(struct btintel_pcie_data *data,
+			       struct list_head *list, u8 count,
+			       struct data_buf *bufs, u32 status_reg,
+			       u32 wrap_reg, u8 allocation_id, u32 region_id,
+			       const char *name)
+{
+	u32 allocation_offset, write_ptr, wrap_ctr, wr_ptr_status;
+	u8 cur_frag;
+
+	allocation_offset = allocation_id *
+			    BTINTEL_PCIE_DBGC_ALLOCATION_OFFSET;
+	wr_ptr_status = btintel_pcie_rd_dev_mem(data, status_reg +
+						allocation_offset);
+	wrap_ctr = btintel_pcie_rd_dev_mem(data, wrap_reg +
+					  allocation_offset);
+
+	write_ptr = wr_ptr_status & BTINTEL_PCIE_DBG_OFFSET_BIT_MASK;
+	write_ptr >>= 2;
+	cur_frag = BTINTEL_PCIE_DBGC_DBG_BUF_IDX(wr_ptr_status);
+	if (cur_frag >= count) {
+		bt_dev_warn(data->hdev,
+			    "Invalid DRAM monitor fragment %u for allocation %u",
+			    cur_frag, allocation_id);
+		return -EINVAL;
+	}
+
+	bt_dev_dbg(data->hdev,
+		   "allocation=%u wr_ptr_status=0x%08x write_ptr=0x%06x cur_frag=%u wrap_ctr=0x%08x",
+		   allocation_id, wr_ptr_status, write_ptr, cur_frag, wrap_ctr);
+
+	return btintel_pcie_dump_dram(list, count, bufs, write_ptr, wrap_ctr,
+				      cur_frag, region_id, name);
+}
+
+static int btintel_pcie_dump_target_region(struct btintel_pcie_data *data,
+					   struct list_head *list,
+					   u32 region_id, const char *name,
+					   u32 addr_start, u32 size)
+{
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
+		return 1;
+	}
+
+	if (!addr_start) {
+		bt_dev_warn(data->hdev,
+			    "Skipping dump region with zero address: %s",
+			    name);
+		return 1;
+	}
+
+	if (size > BTINTEL_PCIE_REGION_MAX_SIZE) {
+		bt_dev_warn(data->hdev,
+			    "Skipping dump region %s: size %u exceeds max %u",
+			    name, size, BTINTEL_PCIE_REGION_MAX_SIZE);
+		return 1;
+	}
+
+	if (addr_start > U32_MAX - size) {
+		bt_dev_warn(data->hdev,
+			    "Skipping dump region %s: addr_start 0x%08x + size %u would overflow",
+			    name, addr_start, size);
+		return 1;
+	}
+
+	/* Align to 4 bytes - target access reads 32-bit words */
+	size = round_down(size, sizeof(u32));
+	if (!size) {
+		bt_dev_warn(data->hdev,
+			    "Skipping dump region %s: size is smaller than 4-byte access",
+			    name);
+		return 1;
+	}
+
+	bt_dev_dbg(data->hdev,
+		   "Target access: region=%s start=0x%08x size=%u",
+		   name, addr_start, size);
+
+	payload_size = sizeof(*hdr) + sizeof(*range) + size;
+	total_size = sizeof(*dump_data) + payload_size;
+	entry = btintel_pcie_dump_entry_alloc(total_size);
+	if (!entry)
+		return -ENOMEM;
+
+	dump_data = (void *)entry->data;
+	dump_data->type = BTINTEL_PCIE_INI_REGION_DEVICE_MEMORY;
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
+	if (data->dmp_hdr.trigger_reason ==
+	    BTINTEL_PCIE_TRIGGER_REASON_FW_ASSERT)
+		dump->time_point =
+			cpu_to_le32(BTINTEL_PCIE_TIME_POINT_FW_ASSERT);
+	else if (data->dmp_hdr.trigger_reason ==
+		 BTINTEL_PCIE_TRIGGER_REASON_USER_TRIGGER)
+		dump->time_point =
+			cpu_to_le32(BTINTEL_PCIE_TIME_POINT_USER_TRIGGER);
+
+	dump->hw_type = cpu_to_le32(INTEL_CNVX_TOP_TYPE(data->dmp_hdr.cnvi_top));
+	dump->hw_step = cpu_to_le32(INTEL_CNVX_TOP_STEP(data->dmp_hdr.cnvi_top));
+	bt_dev_dbg(data->hdev, "hw_type=0x%x hw_step=0x%x (cnvi_top=0x%x)",
+		   le32_to_cpu(dump->hw_type), le32_to_cpu(dump->hw_step),
+		   data->dmp_hdr.cnvi_top);
+
+	dump->ver_type = cpu_to_le32(data->dmp_hdr.cnvi_bt);
+	dump->ver_subtype = cpu_to_le32(data->dmp_hdr.fw_sha);
+	dump->rf_id_type = cpu_to_le32(INTEL_CNVX_TOP_TYPE(data->dmp_hdr.cnvr_top));
+	dump->rf_id_dash = cpu_to_le32(INTEL_CNVX_TOP_DASH(data->dmp_hdr.cnvr_top));
+	dump->rf_id_step = cpu_to_le32(INTEL_CNVX_TOP_STEP(data->dmp_hdr.cnvr_top));
+	dump->rf_id_flavor = cpu_to_le32(INTEL_CNVX_TOP_FLAVOR(data->dmp_hdr.cnvr_top));
+	bt_dev_dbg(data->hdev,
+		   "rf_id_type=0x%x rf_id_dash=0x%x rf_id_step=0x%x rf_id_flavor=0x%x (cnvr_top=0x%x)",
+		   le32_to_cpu(dump->rf_id_type),
+		   le32_to_cpu(dump->rf_id_dash),
+		   le32_to_cpu(dump->rf_id_step),
+		   le32_to_cpu(dump->rf_id_flavor),
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
+	snprintf(build_tag, sizeof(build_tag), "%08X", data->dmp_hdr.fw_sha);
+
+	dump->build_tag_len = cpu_to_le32(strlen(build_tag));
+	memcpy(dump->build_tag, build_tag, min(strlen(build_tag),
+					       sizeof(dump->build_tag)));
+
+	dump->num_of_cfg_names = cpu_to_le32(0);
+
+	bt_dev_dbg(data->hdev,
+		   "HwType=0x%08x HwStep=0x%08x RfIdType=0x%08x RfIdDash=0x%08x RfIdStep=0x%08x RfIdFlavor=0x%08x",
+		   le32_to_cpu(dump->hw_type), le32_to_cpu(dump->hw_step),
+		   le32_to_cpu(dump->rf_id_type),
+		   le32_to_cpu(dump->rf_id_dash),
+		   le32_to_cpu(dump->rf_id_step),
+		   le32_to_cpu(dump->rf_id_flavor));
+	bt_dev_dbg(data->hdev, "VerType=0x%08x VerSubType=0x%08x",
+		   le32_to_cpu(dump->ver_type), le32_to_cpu(dump->ver_subtype));
+	bt_dev_dbg(data->hdev,
+		   "LmacMajor=0x%08x LmacMinor=0x%08x UmacMajor=0x%08x UmacMinor=0x%08x",
+		   le32_to_cpu(dump->lmac_major), le32_to_cpu(dump->lmac_minor),
+		   le32_to_cpu(dump->umac_major),
+		   le32_to_cpu(dump->umac_minor));
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
+static void btintel_pcie_dump_mem_range(struct btintel_pcie_data *data,
+					struct list_head *list, u32 region_id,
+					const char *name, u32 addr_start,
+					u32 addr_end, u64 *regions_mask)
+{
+	u32 region_size;
+
+	if (!addr_start || !addr_end || addr_end < addr_start)
+		return;
+
+	if (addr_end > U32_MAX - 0x04) {
+		bt_dev_warn(data->hdev,
+			    "Skipping dump region %s: addr_end 0x%08x would overflow",
+			    name, addr_end);
+		return;
+	}
+
+	region_size = (addr_end + 0x04) - addr_start;
+	if (region_size > BTINTEL_PCIE_REGION_MAX_SIZE) {
+		bt_dev_warn(data->hdev,
+			    "Skipping dump region %s: size %u exceeds max %u",
+			    name, region_size,
+			    BTINTEL_PCIE_REGION_MAX_SIZE);
+		return;
+	}
+
+	if (!btintel_pcie_dump_target_region(data, list, region_id, name,
+					     addr_start, region_size))
+		*regions_mask |= BIT_ULL(region_id);
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
+	u32 status_reg, wrap_reg;
+	u32 exception_dump_len;
+	u32 exc_addr;
+	u64 regions_mask = 0;
+	u8 hw_variant;
+	u32 smem_rd_addr = 0, smem_rd_size = 0;
+	u32 file_len;
+	u8 count;
+	int ret;
+	LIST_HEAD(dump_list);
 
 	if (!IS_ENABLED(CONFIG_DEV_COREDUMP))
 		return -EOPNOTSUPP;
 
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
+
+	if (hw_variant == BTINTEL_HWID_BZRI ||
+	    hw_variant == BTINTEL_HWID_BZRIW) {
 		status_reg = BTINTEL_PCIE_DBGC_CUR_DBGBUFF_STATUS;
 		wrap_reg = BTINTEL_PCIE_DBGC_DBGBUFF_WRAP_ARND;
-		break;
-	case BTINTEL_HWID_SCP:
-	case BTINTEL_HWID_SCP2:
-	case BTINTEL_HWID_SCP2F:
+	} else if (hw_variant >= BTINTEL_HWID_SCP) {
 		status_reg = BTINTEL_PCIE_DBGC_CUR_DBGBUFF_STATUS_SCP;
 		wrap_reg = BTINTEL_PCIE_DBGC_DBGBUFF_WRAP_ARND_SCP;
-		break;
-	default:
-		bt_dev_err(hdev, "Unsupported Intel hardware variant (0x%2.2x)",
+	} else {
+		bt_dev_err(hdev,
+			   "Unsupported Intel hardware variant (0x%2.2x)",
 			   hw_variant);
 		return -EINVAL;
 	}
 
-	wr_ptr_status = btintel_pcie_rd_dev_mem(data, status_reg);
-	data->dmp_hdr.wrap_ctr = btintel_pcie_rd_dev_mem(data, wrap_reg);
+	smem_rd_addr = data->dump_info.smem_addr_start;
+	smem_rd_size = 0;
 
-	offset = wr_ptr_status & BTINTEL_PCIE_DBG_OFFSET_BIT_MASK;
+	if (!smem_rd_addr && !data->dump_info.smem_addr_end) {
+		bt_dev_dbg(hdev, "smem region not advertised by firmware");
+	} else if (data->dump_info.smem_addr_end < smem_rd_addr ||
+		   data->dump_info.smem_addr_end > U32_MAX - 0x04) {
+		bt_dev_err(hdev,
+			   "Invalid smem region: start=0x%08x end=0x%08x",
+			   smem_rd_addr, data->dump_info.smem_addr_end);
+	} else {
+		smem_rd_size = (data->dump_info.smem_addr_end + 0x04) -
+			       smem_rd_addr;
 
-	buf_idx = BTINTEL_PCIE_DBGC_DBG_BUF_IDX(wr_ptr_status);
-	if (buf_idx > dbgc->count) {
-		bt_dev_warn(hdev, "Buffer index is invalid");
-		return -EINVAL;
+		bt_dev_dbg(hdev,
+			   "smem_region: smem_start_addr=0x%08x smem_end_addr=0x%08x smem_rd_size=%u",
+			   smem_rd_addr, data->dump_info.smem_addr_end,
+			   smem_rd_size);
+
+		if (smem_rd_size == 0 ||
+		    smem_rd_size > BTINTEL_PCIE_SMEM_MAX_SIZE) {
+			bt_dev_err(hdev,
+				   "Invalid smem region: smem_rd_addr 0x%08x size %u (max %u)",
+				   smem_rd_addr, smem_rd_size,
+				   BTINTEL_PCIE_SMEM_MAX_SIZE);
+			smem_rd_size = 0;
+		}
 	}
 
-	prev_size = buf_idx * BTINTEL_PCIE_DBGC_BUFFER_SIZE;
-	if (prev_size + offset >= prev_size)
-		data->dmp_hdr.write_ptr = prev_size + offset;
-	else
-		return -EINVAL;
+	if (btintel_pcie_is_mdbgc_supported(data)) {
+		ret = btintel_pcie_dump_dram_monitor(data, &dump_list, count,
+						     mdbgc->buf1, status_reg,
+						     wrap_reg,
+						     BTINTEL_PCIE_MDBGC_ALLOCATIONID_1,
+						     BTINTEL_PCIE_INI_ID_DRAM_MONITOR1,
+						     "monitor");
+		if (!ret)
+			regions_mask |=
+				BIT_ULL(BTINTEL_PCIE_INI_ID_DRAM_MONITOR1);
+		else
+			bt_dev_warn(hdev, "Failed to dump DRAM buf1: %d", ret);
+
+		ret = btintel_pcie_dump_dram_monitor(data, &dump_list, count,
+						     mdbgc->buf2, status_reg,
+						     wrap_reg,
+						     BTINTEL_PCIE_MDBGC_ALLOCATIONID_2,
+						     BTINTEL_PCIE_INI_ID_DRAM_MONITOR2,
+						     "monitor2");
+		if (!ret)
+			regions_mask |=
+				BIT_ULL(BTINTEL_PCIE_INI_ID_DRAM_MONITOR2);
+		else
+			bt_dev_warn(hdev, "Failed to dump DRAM buf2: %d", ret);
+
+		ret = btintel_pcie_dump_dram_monitor(data, &dump_list, count,
+						     mdbgc->buf3, status_reg,
+						     wrap_reg,
+						     BTINTEL_PCIE_MDBGC_ALLOCATIONID_3,
+						     BTINTEL_PCIE_INI_ID_DRAM_MONITOR3,
+						     "monitor3");
+		if (!ret)
+			regions_mask |=
+				BIT_ULL(BTINTEL_PCIE_INI_ID_DRAM_MONITOR3);
+		else
+			bt_dev_warn(hdev, "Failed to dump DRAM buf3: %d", ret);
+	} else {
+		ret = btintel_pcie_dump_dram_monitor(data, &dump_list, count,
+						     dbgc->bufs, status_reg,
+						     wrap_reg,
+						     BTINTEL_PCIE_MDBGC_ALLOCATIONID_1,
+						     BTINTEL_PCIE_INI_ID_DRAM_MONITOR1,
+						     "monitor");
+		if (!ret)
+			regions_mask |=
+				BIT_ULL(BTINTEL_PCIE_INI_ID_DRAM_MONITOR1);
+		else
+			bt_dev_warn(hdev,
+				    "Failed to dump DRAM region: %d", ret);
+	}
 
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
-		sizeof(*tlv) + sizeof(data->dmp_hdr.fw_sha) +
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
+	if (smem_rd_size &&
+	    !btintel_pcie_dump_smem_monitor_region(data, &dump_list,
+						   BTINTEL_PCIE_INI_ID_SMEM,
+						   "monitor_smem",
+						   smem_rd_addr,
+						   smem_rd_size))
+		regions_mask |= BIT_ULL(BTINTEL_PCIE_INI_ID_SMEM);
+
+	exc_addr = data->dump_info.exception_dump_addr;
+	exception_dump_len = data->dump_info.exception_dump_len;
+	if (exc_addr && exception_dump_len) {
+		ret = btintel_pcie_dump_target_region(data, &dump_list,
+						      BTINTEL_PCIE_INI_ID_EXCEPTION_EVT,
+						      "EXCEPTION_EVT_BUFFER", exc_addr,
+						      exception_dump_len);
+		if (!ret)
+			regions_mask |= BIT_ULL(BTINTEL_PCIE_INI_ID_EXCEPTION_EVT);
 	}
 
-	/*
-	 * sizeof(u32) - signature
-	 * sizeof(data_len) - to store tlv data size
-	 * data_len - TLV data
-	 */
-	dump_size = sizeof(u32) + sizeof(data_len) + data_len;
+	btintel_pcie_dump_mem_range(data, &dump_list,
+				    BTINTEL_PCIE_INI_ID_DCCM, "DCCM",
+				    data->dump_info.dccm_addr_start,
+				    data->dump_info.dccm_addr_end,
+				    &regions_mask);
+
+	btintel_pcie_dump_mem_range(data, &dump_list,
+				    BTINTEL_PCIE_INI_ID_SDS, "SDS",
+				    data->dump_info.sds_start_addr_start,
+				    data->dump_info.sds_start_addr_end,
+				    &regions_mask);
+
+	btintel_pcie_dump_mem_range(data, &dump_list,
+				    BTINTEL_PCIE_INI_ID_SDS_IOSF, "SDS_IOSF",
+				    data->dump_info.sds_iosf_data_addr_start,
+				    data->dump_info.sds_iosf_data_addr_end,
+				    &regions_mask);
+
+	btintel_pcie_dump_mem_range(data, &dump_list,
+				    BTINTEL_PCIE_INI_ID_ECL, "ECL_REGION",
+				    data->dump_info.ecl_addr_start,
+				    data->dump_info.ecl_addr_end,
+				    &regions_mask);
+
+	ret = btintel_pcie_dump_info(data, &dump_list, regions_mask);
+	if (ret) {
+		btintel_pcie_dump_list_free(&dump_list);
+		return ret;
+	}
 
+	file_len = sizeof(*file_hdr) +
+		   btintel_pcie_dump_list_total_size(&dump_list);
+	entry = btintel_pcie_dump_entry_alloc(sizeof(*file_hdr));
+	if (!entry) {
+		btintel_pcie_dump_list_free(&dump_list);
+		return -ENOMEM;
+	}
 
-	/* Add debug buffers data length to dump size */
-	dump_size += BTINTEL_PCIE_DBGC_BUFFER_SIZE * dbgc->count;
+	file_hdr = (void *)entry->data;
+	file_hdr->barker = cpu_to_le32(BTINTEL_PCIE_INI_ERROR_DUMP_BARKER);
+	file_hdr->file_len = cpu_to_le32(file_len);
+	list_add(&entry->list, &dump_list);
 
-	pdata = vmalloc(dump_size);
-	if (!pdata)
-		return -ENOMEM;
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
-	p = btintel_pcie_copy_tlv(p, BTINTEL_FW_SHA, &data->dmp_hdr.fw_sha,
-				  sizeof(data->dmp_hdr.fw_sha));
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
-	return 0;
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
+		bt_dev_dbg(hdev, "triggering dev_coredumpsg()");
+		dev_coredumpsg(&hdev->dev, sg_dump_data, file_len, GFP_KERNEL);
+	} else {
+		bt_dev_err(hdev, "Failed to allocate scatter-gather table for coredump");
+		ret = -ENOMEM;
+	}
+
+	btintel_pcie_dump_list_free(&dump_list);
+	return ret;
 }
 
 static void btintel_pcie_dump_traces(struct hci_dev *hdev)
 {
 	struct btintel_pcie_data *data = hci_get_drvdata(hdev);
-	int ret = 0;
+	int ret;
 
 	ret = btintel_pcie_get_mac_access(data);
 	if (ret) {
@@ -923,7 +1445,7 @@ static void btintel_pcie_dump_traces(struct hci_dev *hdev)
 		return;
 	}
 
-	ret = btintel_pcie_read_dram_buffers(data);
+	ret = btintel_pcie_read_debug_regions(data);
 
 	btintel_pcie_release_mac_access(data);
 
@@ -1168,19 +1690,19 @@ static int btintel_parse_mbox_tlv(struct btintel_pcie_data *data)
 	ptr = buffer;
 	remaining = buffer_len;
 
-	/* Parse TLV structures: type(1) + length(2) + value */
+	/* Parse TLV structures: 1 byte type + 2 bytes length +
+	 * variable value
+	 */
 	while (remaining >= sizeof(struct mbox_tlv)) {
 		u16 tlv_len;
 		u32 tlv_total;
 
 		tlv = (struct mbox_tlv *)ptr;
 		tlv_len = le16_to_cpu(tlv->len);
-		tlv_total = sizeof(tlv->type) +
-			    sizeof(tlv->len) + tlv_len;
+		tlv_total = sizeof(tlv->type) + sizeof(tlv->len) + tlv_len;
 
 		if (tlv_total > remaining) {
-			bt_dev_err(data->hdev,
-				   "TLV parse error: type=%u, len=%u",
+			bt_dev_err(data->hdev, "TLV parse error: not enough data for TLV value (type=%u, len=%u)",
 				   tlv->type, tlv_len);
 			break;
 		}
@@ -1189,7 +1711,7 @@ static int btintel_parse_mbox_tlv(struct btintel_pcie_data *data)
 		case BTINTEL_PCIE_TLV_TYPE_EXCEPTION_DUMP_ADDRESS:
 			if (tlv_len < 8) {
 				bt_dev_err(data->hdev,
-					   "TLV %s too short: %u",
+					   "TLV %s too short: len=%u (need 8)",
 					   btintel_pcie_tlv_str(tlv->type),
 					   tlv_len);
 				break;
@@ -1202,7 +1724,7 @@ static int btintel_parse_mbox_tlv(struct btintel_pcie_data *data)
 		case BTINTEL_PCIE_TLV_TYPE_DCCM_MEM_ADDRESS:
 			if (tlv_len < 8) {
 				bt_dev_err(data->hdev,
-					   "TLV %s too short: %u",
+					   "TLV %s too short: len=%u (need 8)",
 					   btintel_pcie_tlv_str(tlv->type),
 					   tlv_len);
 				break;
@@ -1221,8 +1743,7 @@ static int btintel_parse_mbox_tlv(struct btintel_pcie_data *data)
 				bt_dev_dbg(data->hdev, "SDS TLV: skipped, hw_variant not yet known");
 				break;
 			}
-			if (tlv_len == 16 &&
-			    hw_variant > BTINTEL_HWID_BZRI) {
+			if (tlv_len == 16 && hw_variant > BTINTEL_HWID_BZRI) {
 				data->dump_info.sds_start_addr_start =
 					get_unaligned_le32(&tlv->val[0]);
 				data->dump_info.sds_start_addr_end =
@@ -1255,7 +1776,7 @@ static int btintel_parse_mbox_tlv(struct btintel_pcie_data *data)
 		case BTINTEL_PCIE_TLV_TYPE_ECL_MEM_ADDRESS:
 			if (tlv_len < 8) {
 				bt_dev_err(data->hdev,
-					   "TLV %s too short: %u",
+					   "TLV %s too short: len=%u (need 8)",
 					   btintel_pcie_tlv_str(tlv->type),
 					   tlv_len);
 				break;
@@ -1268,7 +1789,7 @@ static int btintel_parse_mbox_tlv(struct btintel_pcie_data *data)
 		case BTINTEL_PCIE_TLV_TYPE_SMEM_ADDRESS:
 			if (tlv_len < 8) {
 				bt_dev_err(data->hdev,
-					   "TLV %s too short: %u",
+					   "TLV %s too short: len=%u (need 8)",
 					   btintel_pcie_tlv_str(tlv->type),
 					   tlv_len);
 				break;
@@ -1279,8 +1800,7 @@ static int btintel_parse_mbox_tlv(struct btintel_pcie_data *data)
 				get_unaligned_le32(&tlv->val[4]);
 			break;
 		default:
-			bt_dev_dbg(data->hdev,
-				   "Unknown TLV type: %u length: %u",
+			bt_dev_dbg(data->hdev, "Unknown TLV type: %u length: %u",
 				   tlv->type, tlv_len);
 			break;
 		}
@@ -1868,11 +2388,8 @@ static int btintel_pcie_dump_fwtrigger_event(struct btintel_pcie_data *data)
 		goto exit_on_error;
 
 	evt = (void *)buf;
-	data->dmp_hdr.event_type = evt->event_type;
-	data->dmp_hdr.event_id = le16_to_cpu(evt->event_id);
-
 	bt_dev_dbg(data->hdev, "event type: 0x%2.2x event id: 0x%4.4x len: %u",
-		   data->dmp_hdr.event_type, data->dmp_hdr.event_id, len);
+		   evt->event_type, le16_to_cpu(evt->event_id), len);
 
 	skb = bt_skb_alloc(len, GFP_KERNEL);
 	if (!skb) {
@@ -1898,8 +2415,8 @@ static int btintel_pcie_dump_fwtrigger_event(struct btintel_pcie_data *data)
  *
  * Always queue this AFTER any companion event-reader work (hwexp /
  * fwtrigger) so that, on the ordered @dump_workqueue, the event reader
- * runs first and populates dmp_hdr.event_type / event_id before
- * dump_traces consumes them.
+ * runs first and the trigger metadata is populated before dump_traces
+ * consumes it.
  */
 static bool btintel_pcie_queue_coredump(struct btintel_pcie_data *data,
 					u16 trigger_reason)
@@ -1982,12 +2499,6 @@ static void btintel_pcie_coredump_worker(struct work_struct *work)
 		goto out;
 	}
 
-	if (btintel_pcie_is_mdbgc_supported(data)) {
-		bt_dev_info(data->hdev,
-			    "Skipping coredump: MDBGC dump format not supported yet");
-		goto out;
-	}
-
 	btintel_pcie_dump_traces(data->hdev);
 out:
 	/* Release guard last so a new trigger can run only after this
diff --git a/drivers/bluetooth/btintel_pcie.h b/drivers/bluetooth/btintel_pcie.h
index 5c35e65d3e81..9d84db48a8e5 100644
--- a/drivers/bluetooth/btintel_pcie.h
+++ b/drivers/bluetooth/btintel_pcie.h
@@ -74,11 +74,16 @@
 #define BTINTEL_PCIE_DBGC_BASE_ADDR_SCP			(0xf0d5d500)
 #define BTINTEL_PCIE_DBGC_CUR_DBGBUFF_STATUS_SCP	(BTINTEL_PCIE_DBGC_BASE_ADDR_SCP + 0x1C)
 #define BTINTEL_PCIE_DBGC_DBGBUFF_WRAP_ARND_SCP		(BTINTEL_PCIE_DBGC_BASE_ADDR_SCP + 0x2C)
+#define BTINTEL_PCIE_DBGC_ALLOCATION_OFFSET		0x100
 
+#define BTINTEL_PCIE_SMEM_MAX_SIZE		(16 * 1024)
+#define BTINTEL_PCIE_REGION_MAX_SIZE		(16 * 1024 * 1024)
 #define BTINTEL_PCIE_DBG_IDX_BIT_MASK		0x0F
 #define BTINTEL_PCIE_DBGC_DBG_BUF_IDX(data)	(((data) >> 24) & BTINTEL_PCIE_DBG_IDX_BIT_MASK)
 #define BTINTEL_PCIE_DBG_OFFSET_BIT_MASK	0xFFFFFF
 
+#define BTINTEL_PCIE_TARGET_ACCESS_FRAG_OFFSET	4
+
 /* The DRAM buffer count, each buffer size, and
  * fragment buffer size
  */
@@ -242,7 +247,7 @@ enum {
 #define BTINTEL_PCIE_TLV_TYPE_DCCM_MEM_ADDRESS        0x05
 #define BTINTEL_PCIE_TLV_TYPE_SDS_MEM_ADDRESS         0x06
 #define BTINTEL_PCIE_TLV_TYPE_ECL_MEM_ADDRESS         0x07
-#define BTINTEL_PCIE_TLV_TYPE_SMEM_ADDRESS           0x08
+#define BTINTEL_PCIE_TLV_TYPE_SMEM_ADDRESS	      0x08
 
 /*
  * Struct for Context Information (v2)
@@ -527,10 +532,147 @@ struct btintel_pcie_dump_header {
 	u32		wrap_ctr;
 	u16		trigger_reason;
 	int		state;
-	u8		event_type;
-	u16		event_id;
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
@@ -688,4 +830,3 @@ static inline u32 btintel_pcie_rd_dev_mem(struct btintel_pcie_data *data,
 	btintel_pcie_wr_reg32(data, BTINTEL_PCIE_PRPH_DEV_ADDR_REG, addr);
 	return btintel_pcie_rd_reg32(data, BTINTEL_PCIE_PRPH_DEV_RD_REG);
 }
-
-- 
2.43.0

