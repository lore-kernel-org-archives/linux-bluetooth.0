Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208FA2676F6
	for <linux-bluetooth@vger.kernel.org>; Tue, 25 Feb 2025 11:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740482822; cv=none; b=J+jj0rcKLl3DkEQfUvvrOGTdM9x1ekHl1cuSK7e54N5wfSV2o4pLTbnA4tOD4xG2dtYUN/1uZcCvtmpm9i2dkVRCBjjCcB+kGWTOSzDexxYCBySZE86T3O/6ODKjsentx289ogtK4qapBkSZwhx69b7fzORnferpxRgd0eZvZnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740482822; c=relaxed/simple;
	bh=h2zw9gju9/+dJu9qG6aTSIfsRL/Bd4PVcQjKcw11nMg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=M3zkAbv5MaVAMMGuyM5HiLgzcm1Cz6Meset4fnNi4Gy0K9H+36bVWygBnGbuB2I3pC2+EeQphB8Oq2b27tE1kUHASWeNyfh+CpuWC29sddduPICmaOFZqLsu9SUwJEXX5pYNn8gwiLB0OL+1+cOMXxkGarhG9Y7WGdwFfKZp+8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QETtxLSb; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QETtxLSb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740482820; x=1772018820;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=h2zw9gju9/+dJu9qG6aTSIfsRL/Bd4PVcQjKcw11nMg=;
  b=QETtxLSb4JQwO4ja+KZ6P/rP3n5JstXqLBWJvtPi/9fIjyyiiEHkqxp6
   u02t0uUwlnQFiyhpJShNyqi4ygEJ+pMF2gytUF0/AA1t+rXUdww7Is0oM
   litTwADEHpV/m99OkpvJgVbxGrutntrvBokTdaTFrkQlxDLUntvIWda8p
   pXvvs0ZznzxF52P3B+cc+nLg0QQJ8p3xExH3Ob6rCXjrheibE43oL9rpR
   l0s2K4JRWV5J0/XE8FdlsekulVyoEc7V7cQqNfKmwTSOZ0xsd+qis2EvP
   cwlqofWMkHDFglK786E8fiHKjsnFRtkEgiJ+XGXCUfeAaq5xWvte3f0oy
   Q==;
X-CSE-ConnectionGUID: G10iOPcyS32How0W0GWsXw==
X-CSE-MsgGUID: l/DsMhj/SdGGdW0HN8TYdA==
X-IronPort-AV: E=McAfee;i="6700,10204,11356"; a="41539116"
X-IronPort-AV: E=Sophos;i="6.13,314,1732608000"; 
   d="scan'208";a="41539116"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 03:26:59 -0800
X-CSE-ConnectionGUID: SlMLQ3IuT/upammktMJceg==
X-CSE-MsgGUID: kptXADhzRwan80Fl3RHEpg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,314,1732608000"; 
   d="scan'208";a="116848605"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by fmviesa010.fm.intel.com with ESMTP; 25 Feb 2025 03:26:57 -0800
From: Kiran K <kiran.k@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: ravishankar.srivatsa@intel.com,
	chethan.tumkur.narayan@intel.com,
	chandrashekar.devegowda@intel.com,
	vijay.satija@intel.com,
	Kiran K <kiran.k@intel.com>
Subject: [PATCH v3 1/2] Bluetooth: btintel_pcie: Setup buffers for firmware traces
Date: Tue, 25 Feb 2025 17:13:10 +0530
Message-ID: <20250225114311.9514-1-kiran.k@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch allocates the host memory which is used by controller to dump
the firmware traces. The memory needs to be shared with controller via
context information.

Co-developed-by: Vijay Satija <vijay.satija@intel.com>
Signed-off-by: Vijay Satija <vijay.satija@intel.com>
Signed-off-by: Kiran K <kiran.k@intel.com>
---
 drivers/bluetooth/btintel_pcie.c | 89 ++++++++++++++++++++++++++++++++
 drivers/bluetooth/btintel_pcie.h | 32 ++++++++++++
 2 files changed, 121 insertions(+)

diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index b8b241a92bf9..11e2b805c7cc 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -49,6 +49,8 @@ MODULE_DEVICE_TABLE(pci, btintel_pcie_table);
 #define BTINTEL_PCIE_HCI_EVT_PKT	0x00000004
 #define BTINTEL_PCIE_HCI_ISO_PKT	0x00000005
 
+ #define BTINTEL_PCIE_MAGIC_NUM    0xA5A5A5A5
+
 /* Alive interrupt context */
 enum {
 	BTINTEL_PCIE_ROM,
@@ -60,6 +62,83 @@ enum {
 	BTINTEL_PCIE_D3
 };
 
+/* Structure for dbgc fragment buffer
+ * @buf_addr_lsb: LSB of the buffer's physical address
+ * @buf_addr_msb: MSB of the buffer's physical address
+ * @buf_size: Total size of the buffer
+ */
+struct btintel_pcie_dbgc_ctxt_buf {
+	u32	buf_addr_lsb;
+	u32	buf_addr_msb;
+	u32	buf_size;
+};
+
+/* Structure for dbgc fragment
+ * @magic_num: 0XA5A5A5A5
+ * @ver: For Driver-FW compatibility
+ * @total_size: Total size of the payload debug info
+ * @num_buf: Num of allocated debug bufs
+ * @bufs: All buffer's addresses and sizes
+ */
+struct btintel_pcie_dbgc_ctxt {
+	u32	magic_num;
+	u32     ver;
+	u32     total_size;
+	u32     num_buf;
+	struct btintel_pcie_dbgc_ctxt_buf bufs[BTINTEL_PCIE_DBGC_BUFFER_COUNT];
+};
+
+/* This function initializes the memory for DBGC buffers and formats the
+ * DBGC fragment which consists header info and DBGC buffer's LSB, MSB and
+ * size as the payload
+ */
+static int btintel_pcie_setup_dbgc(struct btintel_pcie_data *data)
+{
+	struct btintel_pcie_dbgc_ctxt db_frag;
+	struct data_buf *buf;
+	int i;
+
+	data->dbgc.count = BTINTEL_PCIE_DBGC_BUFFER_COUNT;
+	data->dbgc.bufs = devm_kcalloc(&data->pdev->dev, data->dbgc.count,
+				       sizeof(*buf), GFP_KERNEL);
+	if (!data->dbgc.bufs)
+		return -ENOMEM;
+
+	data->dbgc.buf_v_addr = dmam_alloc_coherent(&data->pdev->dev,
+						    data->dbgc.count *
+						    BTINTEL_PCIE_DBGC_BUFFER_SIZE,
+						    &data->dbgc.buf_p_addr,
+						    GFP_KERNEL | __GFP_NOWARN);
+	if (!data->dbgc.buf_v_addr)
+		return -ENOMEM;
+
+	data->dbgc.frag_v_addr = dmam_alloc_coherent(&data->pdev->dev,
+						     sizeof(struct btintel_pcie_dbgc_ctxt),
+						     &data->dbgc.frag_p_addr,
+						     GFP_KERNEL | __GFP_NOWARN);
+	if (!data->dbgc.frag_v_addr)
+		return -ENOMEM;
+
+	data->dbgc.frag_size = sizeof(struct btintel_pcie_dbgc_ctxt);
+
+	db_frag.magic_num = BTINTEL_PCIE_MAGIC_NUM;
+	db_frag.ver = BTINTEL_PCIE_DBGC_FRAG_VERSION;
+	db_frag.total_size = BTINTEL_PCIE_DBGC_FRAG_PAYLOAD_SIZE;
+	db_frag.num_buf = BTINTEL_PCIE_DBGC_FRAG_BUFFER_COUNT;
+
+	for (i = 0; i < data->dbgc.count; i++) {
+		buf = &data->dbgc.bufs[i];
+		buf->data_p_addr = data->dbgc.buf_p_addr + i * BTINTEL_PCIE_DBGC_BUFFER_SIZE;
+		buf->data = data->dbgc.buf_v_addr + i * BTINTEL_PCIE_DBGC_BUFFER_SIZE;
+		db_frag.bufs[i].buf_addr_lsb = (u32)(buf->data_p_addr & 0xffffffff);
+		db_frag.bufs[i].buf_addr_msb = (u32)((buf->data_p_addr >> 32) & 0xffffffff);
+		db_frag.bufs[i].buf_size = BTINTEL_PCIE_DBGC_BUFFER_SIZE;
+	}
+
+	memcpy(data->dbgc.frag_v_addr, &db_frag, sizeof(db_frag));
+	return 0;
+}
+
 static inline void ipc_print_ia_ring(struct hci_dev *hdev, struct ia *ia,
 				     u16 queue_num)
 {
@@ -1008,6 +1087,11 @@ static void btintel_pcie_init_ci(struct btintel_pcie_data *data,
 	ci->addr_urbdq1 = data->rxq.urbd1s_p_addr;
 	ci->num_urbdq1 = data->rxq.count;
 	ci->urbdq_db_vec = BTINTEL_PCIE_RXQ_NUM;
+
+	ci->dbg_output_mode = 0x01;
+	ci->dbgc_addr = data->dbgc.frag_p_addr;
+	ci->dbgc_size = data->dbgc.frag_size;
+	ci->dbg_preset = 0x00;
 }
 
 static void btintel_pcie_free_txq_bufs(struct btintel_pcie_data *data,
@@ -1220,6 +1304,11 @@ static int btintel_pcie_alloc(struct btintel_pcie_data *data)
 	/* Setup Index Array */
 	btintel_pcie_setup_ia(data, p_addr, v_addr, &data->ia);
 
+	/* Setup data buffers for dbgc */
+	err = btintel_pcie_setup_dbgc(data);
+	if (err)
+		goto exit_error_txq;
+
 	/* Setup Context Information */
 	p_addr += sizeof(u16) * BTINTEL_PCIE_NUM_QUEUES * 4;
 	v_addr += sizeof(u16) * BTINTEL_PCIE_NUM_QUEUES * 4;
diff --git a/drivers/bluetooth/btintel_pcie.h b/drivers/bluetooth/btintel_pcie.h
index f9aada0543c4..b9d32393002b 100644
--- a/drivers/bluetooth/btintel_pcie.h
+++ b/drivers/bluetooth/btintel_pcie.h
@@ -48,6 +48,21 @@
 #define BTINTEL_PCIE_CSR_MSIX_IVAR_BASE		(BTINTEL_PCIE_CSR_MSIX_BASE + 0x0880)
 #define BTINTEL_PCIE_CSR_MSIX_IVAR(cause)	(BTINTEL_PCIE_CSR_MSIX_IVAR_BASE + (cause))
 
+/* The DRAM buffer count, each buffer size, and
+ * fragment buffer size
+ */
+#define BTINTEL_PCIE_DBGC_BUFFER_COUNT		16
+#define BTINTEL_PCIE_DBGC_BUFFER_SIZE		(256 * 1024) /* 256 KB */
+
+#define BTINTEL_PCIE_DBGC_FRAG_VERSION		1
+#define BTINTEL_PCIE_DBGC_FRAG_BUFFER_COUNT	BTINTEL_PCIE_DBGC_BUFFER_COUNT
+
+/* Magic number(4), version(4), size of payload length(4) */
+#define BTINTEL_PCIE_DBGC_FRAG_HEADER_SIZE	12
+
+/* Num of alloc Dbg buff (4) + (LSB(4), MSB(4), Size(4)) for each buffer */
+#define BTINTEL_PCIE_DBGC_FRAG_PAYLOAD_SIZE	196
+
 /* Causes for the FH register interrupts */
 enum msix_fh_int_causes {
 	BTINTEL_PCIE_MSIX_FH_INT_CAUSES_0	= BIT(0),	/* cause 0 */
@@ -325,6 +340,22 @@ struct rxq {
 	struct data_buf	*bufs;
 };
 
+/* Structure for DRAM Buffer
+ * @count: Number of descriptors
+ * @buf: Array of data_buf structure
+ */
+struct btintel_pcie_dbgc {
+	u16		count;
+
+	void		*frag_v_addr;
+	dma_addr_t	frag_p_addr;
+	u16		frag_size;
+
+	dma_addr_t	buf_p_addr;
+	void		*buf_v_addr;
+	struct data_buf *bufs;
+};
+
 /* struct btintel_pcie_data
  * @pdev: pci device
  * @hdev: hdev device
@@ -405,6 +436,7 @@ struct btintel_pcie_data {
 	struct txq	txq;
 	struct rxq	rxq;
 	u32	alive_intr_ctxt;
+	struct btintel_pcie_dbgc	dbgc;
 };
 
 static inline u32 btintel_pcie_rd_reg32(struct btintel_pcie_data *data,
-- 
2.43.0

