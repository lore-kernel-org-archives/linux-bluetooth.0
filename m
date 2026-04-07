Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B9D3A3E9A
	for <linux-bluetooth@vger.kernel.org>; Tue,  7 Apr 2026 09:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775555054; cv=none; b=DBbKs7XuONSGSVtn28OC1x+aCQDJl9hiX5DPCNDrP/BIjRrvHeR9/Evm6gyk0J+ep3YopOOC3wades8CAKWP0S50j4baCqu4A1kaPCjB+tUEW8T/C1lnjGoJ2y6PgKBafY924ztoQyACZbCjWxxKsXenVcHytuTrbXW/DlZssoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775555054; c=relaxed/simple;
	bh=7ajx81PtA+zlVd/nnu+xE8CVIKNwtPyqirS9Q4GGBtA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=C0lCwy+yfPdZ5VSFcqD5jqqCAJ7xnEwSkvMOl2YfeWG7w9eBQjkA4aghIQVAJgiuMe0FForK0J7uJsZQN7QECkmyFUkctXIP3g2mBY7e8pXhJVmxYAz9fzrzkzhq9uUNd/li40teR7hVW4ajJUsOjilp4hTOhpWBA8kNhYUvT9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cNGoJ5lm; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cNGoJ5lm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775555047; x=1807091047;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=7ajx81PtA+zlVd/nnu+xE8CVIKNwtPyqirS9Q4GGBtA=;
  b=cNGoJ5lmb/pgojKtvJN/18UCIQUwcVItJNfqz5qydWcuBNRH/+F1cpFY
   Wp/7TcCJHlV3rOsHYQ10OS7kPNA288/ommSHPcKB7cWUIQX8G1lqT94FU
   y3aYst4j1PAzuu64lM7nVH2hKkAGLgugHZ4okKO0VD/PmRlmHwdGpbIcL
   DQJjk6Jr77RZvymRaPlm5KaxuTsafPu4d+T7PGEaNKhszu50/1twsROVf
   NIQaWESNJwhrPgCGvLbFkMNBweqtFIleBd0QxLkU1kXBVHOy+CxroL7RO
   TwRn9UOE5dpFW6qHb8pGtmGFpWRzZDQzVPkHgIzju4phlLrdrbr/kyFWx
   g==;
X-CSE-ConnectionGUID: rEywMJBITxCQ9Zhz/ZyP+Q==
X-CSE-MsgGUID: wtVuoKqcSCSF2d4UTotuSQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11751"; a="76478764"
X-IronPort-AV: E=Sophos;i="6.23,165,1770624000"; 
   d="scan'208";a="76478764"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2026 02:44:05 -0700
X-CSE-ConnectionGUID: xmiZVJhaQgaFlxwl0oaGQQ==
X-CSE-MsgGUID: D4kgoOuFQ3yW5cfAUgCGSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,165,1770624000"; 
   d="scan'208";a="229798755"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by fmviesa004.fm.intel.com with ESMTP; 07 Apr 2026 02:44:04 -0700
From: Kiran K <kiran.k@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: ravishankar.srivatsa@intel.com,
	chethan.tumkur.narayan@intel.com,
	Kiran K <kiran.k@intel.com>
Subject: [PATCH RESEND v1] Bluetooth: btintel_pcie: Align shared DMA memory to 128 bytes
Date: Tue,  7 Apr 2026 15:32:40 +0530
Message-ID: <20260407100240.757910-1-kiran.k@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Align each descriptor/index/context region to 128 bytes before
calculating the total DMA pool size. This ensures the memory layout
shared with firmware meets the 128-byte alignment requirement.

The DMA pool alignment is also set to 128 bytes to match the firmware
expectation for all shared structures.

Signed-off-by: Kiran K <kiran.k@intel.com>
---
 drivers/bluetooth/btintel_pcie.c | 94 ++++++++++++++++++--------------
 drivers/bluetooth/btintel_pcie.h |  3 -
 2 files changed, 53 insertions(+), 44 deletions(-)

diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index 05f82bc3f0d7..8fb3ebe98146 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -37,6 +37,8 @@
 
 #define POLL_INTERVAL_US	10
 
+#define BTINTEL_PCIE_DMA_ALIGN_128B	128 /* 128 byte aligned */
+
 /* Intel Bluetooth PCIe device id table */
 static const struct pci_device_id btintel_pcie_table[] = {
 	/* BlazarI, Wildcat Lake */
@@ -1751,27 +1753,6 @@ static int btintel_pcie_setup_rxq_bufs(struct btintel_pcie_data *data,
 	return 0;
 }
 
-static void btintel_pcie_setup_ia(struct btintel_pcie_data *data,
-				  dma_addr_t p_addr, void *v_addr,
-				  struct ia *ia)
-{
-	/* TR Head Index Array */
-	ia->tr_hia_p_addr = p_addr;
-	ia->tr_hia = v_addr;
-
-	/* TR Tail Index Array */
-	ia->tr_tia_p_addr = p_addr + sizeof(u16) * BTINTEL_PCIE_NUM_QUEUES;
-	ia->tr_tia = v_addr + sizeof(u16) * BTINTEL_PCIE_NUM_QUEUES;
-
-	/* CR Head index Array */
-	ia->cr_hia_p_addr = p_addr + (sizeof(u16) * BTINTEL_PCIE_NUM_QUEUES * 2);
-	ia->cr_hia = v_addr + (sizeof(u16) * BTINTEL_PCIE_NUM_QUEUES * 2);
-
-	/* CR Tail Index Array */
-	ia->cr_tia_p_addr = p_addr + (sizeof(u16) * BTINTEL_PCIE_NUM_QUEUES * 3);
-	ia->cr_tia = v_addr + (sizeof(u16) * BTINTEL_PCIE_NUM_QUEUES * 3);
-}
-
 static void btintel_pcie_free(struct btintel_pcie_data *data)
 {
 	btintel_pcie_free_rxq_bufs(data, &data->rxq);
@@ -1789,13 +1770,16 @@ static int btintel_pcie_alloc(struct btintel_pcie_data *data)
 	size_t total;
 	dma_addr_t p_addr;
 	void *v_addr;
+	size_t tfd_size, frbd_size, ctx_size, ci_size, urbd0_size, urbd1_size;
 
 	/* Allocate the chunk of DMA memory for descriptors, index array, and
 	 * context information, instead of allocating individually.
 	 * The DMA memory for data buffer is allocated while setting up the
 	 * each queue.
 	 *
-	 * Total size is sum of the following
+	 * Total size is sum of the following and each of the individual sizes
+	 * are aligned to 128 bytes before adding up.
+	 *
 	 *  + size of TFD * Number of descriptors in queue
 	 *  + size of URBD0 * Number of descriptors in queue
 	 *  + size of FRBD * Number of descriptors in queue
@@ -1803,15 +1787,25 @@ static int btintel_pcie_alloc(struct btintel_pcie_data *data)
 	 *  + size of index * Number of queues(2) * type of index array(4)
 	 *  + size of context information
 	 */
-	total = (sizeof(struct tfd) + sizeof(struct urbd0)) * BTINTEL_PCIE_TX_DESCS_COUNT;
-	total += (sizeof(struct frbd) + sizeof(struct urbd1)) * BTINTEL_PCIE_RX_DESCS_COUNT;
+	tfd_size = ALIGN(sizeof(struct tfd) * BTINTEL_PCIE_TX_DESCS_COUNT,
+			 BTINTEL_PCIE_DMA_ALIGN_128B);
+	urbd0_size = ALIGN(sizeof(struct urbd0) * BTINTEL_PCIE_TX_DESCS_COUNT,
+			   BTINTEL_PCIE_DMA_ALIGN_128B);
 
-	/* Add the sum of size of index array and size of ci struct */
-	total += (sizeof(u16) * BTINTEL_PCIE_NUM_QUEUES * 4) + sizeof(struct ctx_info);
+	frbd_size = ALIGN(sizeof(struct frbd) * BTINTEL_PCIE_RX_DESCS_COUNT,
+			  BTINTEL_PCIE_DMA_ALIGN_128B);
+	urbd1_size = ALIGN(sizeof(struct urbd1) * BTINTEL_PCIE_RX_DESCS_COUNT,
+			   BTINTEL_PCIE_DMA_ALIGN_128B);
+
+	ci_size = ALIGN(sizeof(u16) * BTINTEL_PCIE_NUM_QUEUES,
+			BTINTEL_PCIE_DMA_ALIGN_128B);
+
+	ctx_size = ALIGN(sizeof(struct ctx_info), BTINTEL_PCIE_DMA_ALIGN_128B);
+
+	total = tfd_size + urbd0_size + frbd_size + urbd1_size + ctx_size + ci_size * 4;
 
-	/* Allocate DMA Pool */
 	data->dma_pool = dma_pool_create(KBUILD_MODNAME, &data->pdev->dev,
-					 total, BTINTEL_PCIE_DMA_POOL_ALIGNMENT, 0);
+					 total, BTINTEL_PCIE_DMA_ALIGN_128B, 0);
 	if (!data->dma_pool) {
 		err = -ENOMEM;
 		goto exit_error;
@@ -1836,29 +1830,29 @@ static int btintel_pcie_alloc(struct btintel_pcie_data *data)
 	data->txq.tfds_p_addr = p_addr;
 	data->txq.tfds = v_addr;
 
-	p_addr += (sizeof(struct tfd) * BTINTEL_PCIE_TX_DESCS_COUNT);
-	v_addr += (sizeof(struct tfd) * BTINTEL_PCIE_TX_DESCS_COUNT);
+	p_addr += tfd_size;
+	v_addr += tfd_size;
 
 	/* Setup urbd0 */
 	data->txq.urbd0s_p_addr = p_addr;
 	data->txq.urbd0s = v_addr;
 
-	p_addr += (sizeof(struct urbd0) * BTINTEL_PCIE_TX_DESCS_COUNT);
-	v_addr += (sizeof(struct urbd0) * BTINTEL_PCIE_TX_DESCS_COUNT);
+	p_addr += urbd0_size;
+	v_addr += urbd0_size;
 
 	/* Setup FRBD*/
 	data->rxq.frbds_p_addr = p_addr;
 	data->rxq.frbds = v_addr;
 
-	p_addr += (sizeof(struct frbd) * BTINTEL_PCIE_RX_DESCS_COUNT);
-	v_addr += (sizeof(struct frbd) * BTINTEL_PCIE_RX_DESCS_COUNT);
+	p_addr += frbd_size;
+	v_addr += frbd_size;
 
 	/* Setup urbd1 */
 	data->rxq.urbd1s_p_addr = p_addr;
 	data->rxq.urbd1s = v_addr;
 
-	p_addr += (sizeof(struct urbd1) * BTINTEL_PCIE_RX_DESCS_COUNT);
-	v_addr += (sizeof(struct urbd1) * BTINTEL_PCIE_RX_DESCS_COUNT);
+	p_addr += urbd1_size;
+	v_addr += urbd1_size;
 
 	/* Setup data buffers for txq */
 	err = btintel_pcie_setup_txq_bufs(data, &data->txq);
@@ -1870,8 +1864,29 @@ static int btintel_pcie_alloc(struct btintel_pcie_data *data)
 	if (err)
 		goto exit_error_txq;
 
-	/* Setup Index Array */
-	btintel_pcie_setup_ia(data, p_addr, v_addr, &data->ia);
+	/* TR Head Index Array */
+	data->ia.tr_hia_p_addr = p_addr;
+	data->ia.tr_hia = v_addr;
+	p_addr += ci_size;
+	v_addr += ci_size;
+
+	/* TR Tail Index Array */
+	data->ia.tr_tia_p_addr = p_addr;
+	data->ia.tr_tia = v_addr;
+	p_addr += ci_size;
+	v_addr += ci_size;
+
+	/* CR Head index Array */
+	data->ia.cr_hia_p_addr = p_addr;
+	data->ia.cr_hia = v_addr;
+	p_addr += ci_size;
+	v_addr += ci_size;
+
+	/* CR Tail Index Array */
+	data->ia.cr_tia_p_addr = p_addr;
+	data->ia.cr_tia = v_addr;
+	p_addr += ci_size;
+	v_addr += ci_size;
 
 	/* Setup data buffers for dbgc */
 	err = btintel_pcie_setup_dbgc(data);
@@ -1879,9 +1894,6 @@ static int btintel_pcie_alloc(struct btintel_pcie_data *data)
 		goto exit_error_txq;
 
 	/* Setup Context Information */
-	p_addr += sizeof(u16) * BTINTEL_PCIE_NUM_QUEUES * 4;
-	v_addr += sizeof(u16) * BTINTEL_PCIE_NUM_QUEUES * 4;
-
 	data->ci = v_addr;
 	data->ci_p_addr = p_addr;
 
diff --git a/drivers/bluetooth/btintel_pcie.h b/drivers/bluetooth/btintel_pcie.h
index e3d941ffef4a..3c7bb708362d 100644
--- a/drivers/bluetooth/btintel_pcie.h
+++ b/drivers/bluetooth/btintel_pcie.h
@@ -178,9 +178,6 @@ enum {
 /* The size of DMA buffer for TX and RX in bytes */
 #define BTINTEL_PCIE_BUFFER_SIZE	4096
 
-/* DMA allocation alignment */
-#define BTINTEL_PCIE_DMA_POOL_ALIGNMENT	256
-
 #define BTINTEL_PCIE_TX_WAIT_TIMEOUT_MS		500
 
 /* Doorbell vector for TFD */
-- 
2.43.0

