Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF1E6421A10
	for <linux-bluetooth@vger.kernel.org>; Tue,  3 Mar 2026 11:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772538160; cv=none; b=bpHCAPX/bfAMPYxmOjypC8GD293j1SVlMPkWTDbvqJa78C4kEnMN4ELujmOro8zgJe4pXMOvfF24T+B5Q5kCtVRtOxblLLcV+hDuQRW/WtbTcSlZsgwQaTmREzOW3sKN9N4TTk5oq810Pus0GmIECjUVXTBQJ1l1bgszinHXSPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772538160; c=relaxed/simple;
	bh=3PHloh1l+AwhHkiEVn8rGxjes82iFKEv89mIFKBttXU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EqrDmRo+zINjyFR6F5MLgVpguRRXjzJ8IrZKeT800KNYIQ0A3m99MlsmwAjGTNnaW0wQVLFEFIiVjhuKoqGFXJnonnaMIfiXLPCOaj0zE72OvLT1qJukUlLZw9w/UfSznALI4ER6mEe8UQwqZ3/4CUHC8a+Mvax6runCoA1yWaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cb+PIv9U; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cb+PIv9U"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772538159; x=1804074159;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=3PHloh1l+AwhHkiEVn8rGxjes82iFKEv89mIFKBttXU=;
  b=cb+PIv9U4WonKTepTpdAxVg6aG6tMRedZsjOE4cK16flNNPn8bucnEXr
   mhhtaqbrkJ0oj801x6yoPZCJtlkqYCh6eLbbRzLthO4jFNS4nDKyJUE9g
   rYRRVuuZyxQoZ1BFm+ybv5FyR9rm8uTLpuroCfdV9AhMF3wgTUkxH4KAa
   YNZi40NXgddZGNCcCAgLGE5XPFte4baUOnhU/6pFNA8kQq0Z7h0y1TExU
   X+mDlzjxg9y51RKD5jmI8HNeeyJb4ZWqj/IvofsX857QHMYmopwklMcvh
   WwcL8meYmVyd7xll1ZB0IXqRjAH5FIikEVhRrtFBjUGE9CWnnMh4CAQAS
   g==;
X-CSE-ConnectionGUID: 7UJ5rCnDToir16EhVpPx1Q==
X-CSE-MsgGUID: aHnsC4gGT/+G3bd3uIrm8w==
X-IronPort-AV: E=McAfee;i="6800,10657,11717"; a="73533665"
X-IronPort-AV: E=Sophos;i="6.21,321,1763452800"; 
   d="scan'208";a="73533665"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2026 03:42:38 -0800
X-CSE-ConnectionGUID: AYuavOrSQ42DNsDdVCv9cg==
X-CSE-MsgGUID: gQdKUAf7RlePVV5k99zL8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,321,1763452800"; 
   d="scan'208";a="216365324"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by fmviesa008.fm.intel.com with ESMTP; 03 Mar 2026 03:42:36 -0800
From: Kiran K <kiran.k@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: ravishankar.srivatsa@intel.com,
	chandrashekar.devegowda@intel.com,
	chethan.tumkur.narayan@intel.com,
	Kiran K <kiran.k@intel.com>
Subject: [PATCH v1] Bluetooth: btintel_pcie: Align shared DMA memory to 128 bytes
Date: Tue,  3 Mar 2026 17:31:02 +0530
Message-ID: <20260303120102.284396-1-kiran.k@intel.com>
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
index bd1c6116715e..c4c19a25157a 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -37,6 +37,8 @@
 
 #define POLL_INTERVAL_US	10
 
+#define BTINTEL_PCIE_DMA_ALIGN_128B	128 /* 128 byte aligned */
+
 /* Intel Bluetooth PCIe device id table */
 static const struct pci_device_id btintel_pcie_table[] = {
 	/* BlazarI, Wildcat Lake */
@@ -1756,27 +1758,6 @@ static int btintel_pcie_setup_rxq_bufs(struct btintel_pcie_data *data,
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
@@ -1794,13 +1775,16 @@ static int btintel_pcie_alloc(struct btintel_pcie_data *data)
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
@@ -1808,15 +1792,25 @@ static int btintel_pcie_alloc(struct btintel_pcie_data *data)
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
@@ -1841,29 +1835,29 @@ static int btintel_pcie_alloc(struct btintel_pcie_data *data)
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
@@ -1875,8 +1869,29 @@ static int btintel_pcie_alloc(struct btintel_pcie_data *data)
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
@@ -1884,9 +1899,6 @@ static int btintel_pcie_alloc(struct btintel_pcie_data *data)
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

