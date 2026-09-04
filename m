Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D83F427FB18
	for <linux-bluetooth@vger.kernel.org>; Fri,  4 Sep 2026 00:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788481835; cv=none; b=RVg1w52YD2gKl6JaG6iABCqNyJio7TvJ/MRF9IDjGQvHCi1P05D79c2jIJEGEmbvtq+MbW19to6P6J6fKLvYGYlZPv+Qzq2jrUhIrsEa9FNEWxrfGTSlrAHznA8s7pFA6f44fmc+aMGI/DEglfK1p7rVi//4Lf/nuLrLrzIK/tM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788481835; c=relaxed/simple;
	bh=9iPbSow856wKIFAUZnF7Q9YJThspIu1em8Fj0TQs31c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nt1doNaEnPRP6r9G10KuV0sNq7IVWa+ctgxztaXbVc3rDybDC+KSZvrXi9zcLYOx4n3NZ6roXs4Y2ferYrORXgAgfdMlMNurPHhBMuc+rhMDm8cvttstPw9dpR6Kr5NVGC8EQ3haOxHS4o/NkCl0g92LKYtpbMakSqrXOqoR/+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DpfmeaRu; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DpfmeaRu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788481834; x=1820017834;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9iPbSow856wKIFAUZnF7Q9YJThspIu1em8Fj0TQs31c=;
  b=DpfmeaRuSbJdHn/c0d+DHhddpaoV7U8dDiLXhjdj/Ecr7HA6jX+OvLgz
   fpXinmFFOQQA+EdI5oSIuGD/Kdhzwd61+HySOs56VA9guADD1DPp7GYoI
   S20Op711rowo+lKvQw0QRAlsO5LWvtkjWrArGV+SXWdTyumT8ccHhd6a+
   63mHDBb1FWzTX0Ku5a56B434QBfCoGnFF+uxFQ8ZkWLMgCJxeAPDwkiH0
   rsxeaubdo9mi9b0jESucH1kcBf60gvJ1dajhKNrutA2r3G6mMT2KYJ+fx
   ABma7OoljIDRp36XuF8Hy9Vw5QiMZ2A8bJxBC0dyBBtiGWs4nbNN/ddjR
   w==;
X-CSE-ConnectionGUID: TkL6mTfZSCW1oAPaul/hjw==
X-CSE-MsgGUID: eOS2Zh4hRzygrHdYX0s3jQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11895"; a="92851829"
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; 
   d="scan'208";a="92851829"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 17:30:34 -0700
X-CSE-ConnectionGUID: MmEHBhnUT9iyq7tsJ0CSdw==
X-CSE-MsgGUID: AM2raC6vTUioujunXxtLng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; 
   d="scan'208";a="274034612"
Received: from weba0957.iind.intel.com (HELO WEBA0932.iind.intel.com) ([10.224.186.34])
  by orviesa005.jf.intel.com with ESMTP; 03 Sep 2026 17:30:32 -0700
From: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: ravishankar.srivatsa@intel.com,
	chethan.tumkur.narayan@intel.com,
	kiran.k@intel.com,
	Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>
Subject: [PATCH v2 2/3] Bluetooth: btintel_pcie: add MDBGC multi-buffer DBGC allocation
Date: Fri,  4 Sep 2026 05:59:37 +0530
Message-ID: <20260904002939.622659-2-chandrashekar.devegowda@intel.com>
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

Newer Intel BT PCIe variants (Nova Lake SCP2 and PTL FMP2) require
three independent DRAM debug (DBGC) buffer pools instead of the
single pool used by existing controllers.

Factor the per-pool buffer allocation into a common helper and add
a multi-DBGC (MDBGC) setup path that allocates three pools using
the fragment context format. MDBGC is used when the device reports
an MDBGC-capable variant; otherwise the existing single-pool DBGC
path is retained.

Assisted-by: Copilot:claude-opus-4.7 sparse
Signed-off-by: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>
---
Changes in v2:
 - Reworded the commit message for brevity.
 - Skip coredump collection in btintel_pcie_coredump_worker() when
   the controller reports MDBGC support, since the MDBGC dump format
   is not handled by this patch. The unified decoder path added in
   patch 3/3 replaces this skip with proper multi-DBGC collection.

 drivers/bluetooth/btintel_pcie.c | 184 ++++++++++++++++++++++++++-----
 drivers/bluetooth/btintel_pcie.h |  30 +++++
 2 files changed, 186 insertions(+), 28 deletions(-)

diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index b90f87e8368d..233cb8a3cbd4 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -134,6 +134,20 @@ struct btintel_pcie_dbgc_ctxt {
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
@@ -184,57 +198,159 @@ static inline bool btintel_pcie_dbg_to_wifi(struct btintel_pcie_data *data)
 	return data->dbg_path_cache != BTINTEL_PCIE_DRAM;
 }
 
-/* This function initializes the memory for DBGC buffers and formats the
- * DBGC fragment which consists header info and DBGC buffer's LSB, MSB and
- * size as the payload
- */
-static int btintel_pcie_setup_dbgc(struct btintel_pcie_data *data)
+/* Helper function to allocate and setup a debug buffer group */
+static int btintel_pcie_alloc_dbgc_buf(struct btintel_pcie_data *data,
+				       struct data_buf **buf,
+				       dma_addr_t *p_addr,
+				       void **v_addr,
+				       struct btintel_pcie_dbgc_ctxt_buf *frag,
+				       u32 buf_index,
+				       u32 buf_count)
 {
-	struct btintel_pcie_dbgc_ctxt db_frag;
-	struct data_buf *buf;
+	struct data_buf *b;
 	int i;
 
-	data->dbgc.count = BTINTEL_PCIE_DBGC_BUFFER_COUNT;
-	data->dbgc.bufs = devm_kcalloc(&data->pdev->dev, data->dbgc.count,
-				       sizeof(*buf), GFP_KERNEL);
-	if (!data->dbgc.bufs)
+	*buf = devm_kcalloc(&data->pdev->dev, buf_count,
+			    sizeof(**buf), GFP_KERNEL);
+	if (!*buf) {
+		BT_ERR("Failed to allocate dbgc buf: %u",
+		       buf_index + 1);
 		return -ENOMEM;
+	}
 
-	data->dbgc.buf_v_addr = dmam_alloc_coherent(&data->pdev->dev,
-						    data->dbgc.count *
-						    BTINTEL_PCIE_DBGC_BUFFER_SIZE,
-						    &data->dbgc.buf_p_addr,
-						    GFP_KERNEL | __GFP_NOWARN);
-	if (!data->dbgc.buf_v_addr)
+	*v_addr = dmam_alloc_coherent(&data->pdev->dev,
+				      buf_count *
+				      BTINTEL_PCIE_DBGC_BUFFER_SIZE,
+				      p_addr,
+				      GFP_KERNEL | __GFP_NOWARN);
+	if (!*v_addr) {
+		BT_ERR("Failed to allocate dbgc buf: %u DMA",
+		       buf_index + 1);
 		return -ENOMEM;
+	}
+
+	for (i = 0; i < buf_count; i++) {
+		b = &(*buf)[i];
+		b->data_p_addr = *p_addr +
+				 i * BTINTEL_PCIE_DBGC_BUFFER_SIZE;
+		b->data = *v_addr +
+			  i * BTINTEL_PCIE_DBGC_BUFFER_SIZE;
+		frag[i].buf_addr_lsb =
+			lower_32_bits(b->data_p_addr);
+		frag[i].buf_addr_msb =
+			upper_32_bits(b->data_p_addr);
+		frag[i].buf_size = BTINTEL_PCIE_DBGC_BUFFER_SIZE;
+	}
+
+	return 0;
+}
+
+/* This function initializes the memory for MDBGC buffers */
+static int btintel_pcie_setup_mdbgc(struct btintel_pcie_data *data)
+{
+	struct btintel_pcie_mdbgc_ctxt db_frag;
+	u32 frag_size = sizeof(db_frag);
+	void *frag_v_addr;
+	int err;
+
+	data->mdbgc.count = BTINTEL_PCIE_DBGC_BUFFER_COUNT;
+
+	frag_v_addr = dmam_alloc_coherent(&data->pdev->dev, frag_size,
+					  &data->mdbgc.frag_p_addr,
+					  GFP_KERNEL | __GFP_NOWARN);
+	if (!frag_v_addr)
+		return -ENOMEM;
+
+	data->mdbgc.frag_v_addr = frag_v_addr;
+	data->mdbgc.frag_size = frag_size;
+
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
+					  db_frag.buf1, 0,
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
+					  db_frag.buf2, 1,
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
+					  db_frag.buf3, 2,
+					  data->mdbgc.count);
+	if (err)
+		return err;
+
+	memcpy(data->mdbgc.frag_v_addr, &db_frag, sizeof(db_frag));
+	return 0;
+}
+
+/* This function initializes the memory for DBGC buffers */
+static int btintel_pcie_setup_dbgc(struct btintel_pcie_data *data)
+{
+	struct btintel_pcie_dbgc_ctxt db_frag;
+	int err;
+
+	data->dbgc.count = BTINTEL_PCIE_DBGC_BUFFER_COUNT;
 
 	data->dbgc.frag_v_addr = dmam_alloc_coherent(&data->pdev->dev,
-						     sizeof(struct btintel_pcie_dbgc_ctxt),
-						     &data->dbgc.frag_p_addr,
-						     GFP_KERNEL | __GFP_NOWARN);
+				sizeof(struct btintel_pcie_dbgc_ctxt),
+				&data->dbgc.frag_p_addr,
+				GFP_KERNEL | __GFP_NOWARN);
 	if (!data->dbgc.frag_v_addr)
 		return -ENOMEM;
 
 	data->dbgc.frag_size = sizeof(struct btintel_pcie_dbgc_ctxt);
 
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
+	err = btintel_pcie_alloc_dbgc_buf(data,
+					  &data->dbgc.bufs,
+					  &data->dbgc.buf_p_addr,
+					  &data->dbgc.buf_v_addr,
+					  db_frag.bufs, 0,
+					  data->dbgc.count);
+	if (err)
+		return err;
 
 	memcpy(data->dbgc.frag_v_addr, &db_frag, sizeof(db_frag));
 	return 0;
 }
 
+static bool btintel_pcie_is_mdbgc_supported(struct btintel_pcie_data *data)
+{
+	return data->pdev->device == BTINTEL_PCIE_DEVICE_ID_NVL_S_SCP2 ||
+		data->pdev->device == BTINTEL_PCIE_DEVICE_ID_NVL_Hx_SCP2 ||
+		data->pdev->device == BTINTEL_PCIE_DEVICE_ID_PTL_FMP2;
+}
+
 static inline void ipc_print_ia_ring(struct hci_dev *hdev, struct ia *ia,
 				     u16 queue_num)
 {
@@ -1866,6 +1982,12 @@ static void btintel_pcie_coredump_worker(struct work_struct *work)
 		goto out;
 	}
 
+	if (btintel_pcie_is_mdbgc_supported(data)) {
+		bt_dev_info(data->hdev,
+			    "Skipping coredump: MDBGC dump format not supported yet");
+		goto out;
+	}
+
 	btintel_pcie_dump_traces(data->hdev);
 out:
 	/* Release guard last so a new trigger can run only after this
@@ -2247,10 +2369,14 @@ static void btintel_pcie_init_ci(struct btintel_pcie_data *data,
 		 */
 		ci->dbgc_addr = 0;
 		ci->dbgc_size = 0;
+	} else if (btintel_pcie_is_mdbgc_supported(data)) {
+		ci->dbgc_addr = data->mdbgc.frag_p_addr;
+		ci->dbgc_size = data->mdbgc.frag_size;
 	} else {
 		ci->dbgc_addr = data->dbgc.frag_p_addr;
 		ci->dbgc_size = data->dbgc.frag_size;
 	}
+
 	ci->dbg_preset = 0x00;
 }
 
@@ -2483,6 +2609,8 @@ static int btintel_pcie_alloc(struct btintel_pcie_data *data)
 		 * buffer allocation entirely.
 		 */
 		err = 0;
+	} else if (btintel_pcie_is_mdbgc_supported(data)) {
+		err = btintel_pcie_setup_mdbgc(data);
 	} else {
 		err = btintel_pcie_setup_dbgc(data);
 	}
diff --git a/drivers/bluetooth/btintel_pcie.h b/drivers/bluetooth/btintel_pcie.h
index 9baa214d9bbe..5c35e65d3e81 100644
--- a/drivers/bluetooth/btintel_pcie.h
+++ b/drivers/bluetooth/btintel_pcie.h
@@ -106,8 +106,19 @@
  *   Bits[2:3] DBGI O/P : 01 = WiFi DBGC
  */
 #define BTINTEL_PCIE_DRAM	0x01
+#define BTINTEL_PCIE_FW_MON_MODE_DRAM	0x02
 #define BTINTEL_PCIE_WIFI_DBGC	0x06
 
+#define BTINTEL_PCIE_MDBGC_FRAG_VERSION		2
+
+#define BTINTEL_PCIE_MDBGC_ALLOCATIONID_1		0
+#define BTINTEL_PCIE_MDBGC_ALLOCATIONID_2		1
+#define BTINTEL_PCIE_MDBGC_ALLOCATIONID_3		2
+
+#define BTINTEL_PCIE_DEVICE_ID_NVL_S_SCP2	0x6E74
+#define BTINTEL_PCIE_DEVICE_ID_NVL_Hx_SCP2	0xD346
+#define BTINTEL_PCIE_DEVICE_ID_PTL_FMP2		0xE476
+
 /* Causes for the FH register interrupts */
 enum msix_fh_int_causes {
 	BTINTEL_PCIE_MSIX_FH_INT_CAUSES_0	= BIT(0),	/* cause 0 */
@@ -459,6 +470,24 @@ struct btintel_pcie_dbgc {
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
 struct btintel_pcie_dump_mem_info {
 	u32	exception_dump_addr;
 	u32	exception_dump_len;
@@ -599,6 +628,7 @@ struct btintel_pcie_data {
 	u32	alive_intr_ctxt;
 	enum btintel_pcie_reset_type	reset_type;
 	struct btintel_pcie_dbgc	dbgc;
+	struct btintel_pcie_mdbgc	mdbgc;
 	struct btintel_pcie_dump_header dmp_hdr;
 	u8	pm_sx_event;
 	u32	debug_evt_addr;
-- 
2.43.0

