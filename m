Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B0BF149C4D
	for <linux-bluetooth@vger.kernel.org>; Sun, 25 May 2025 05:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748150595; cv=none; b=qRAPqRsptAMhVrVchniCme9DM6TmWqduuYpGxAaAA9ZhCTANdvlrchylpZip560f81mh1kgjlwTuI/VX8REvqkTzx+wGg5g8T71MXVKGsgVDqKWH5luUrLv8O/3CJKS7FzhGXlhXyykryCFj+qk5QSQdN7akhn0QwA/kPy8FtSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748150595; c=relaxed/simple;
	bh=lYBo94Xo2bpWjux4JX9arPShTTWJLPpbtaCncIv9qMU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d7psMgaXqEBfUsE9dB95KwSIVyTavhFCtF5HMKie/DKaVCREa6jhouHZC7d2NgQb+yGi6ZS/HulnzOm1l8suc0kkWtKFs+N6cCaDWYq7pLeUfulobqT4z5BmxliCjiAYD6HNu1a4ytMsbMYIPT60hKCteFftWzRSjFrxq6yMuXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VY5p0uXr; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VY5p0uXr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748150594; x=1779686594;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lYBo94Xo2bpWjux4JX9arPShTTWJLPpbtaCncIv9qMU=;
  b=VY5p0uXrCQFRiZWe7l1gwjVlnZfm2UgFTIPJ/KK6vWIvVevRIC/KGBMr
   0OcMQFLh7oSthjxHG8um1w2nlCZUJHCB4Ko2DNLTfVwLEteP7/kfFIKC6
   hki1Bk8txfvjLTrJKdcZTCQPbccBpPLobIWW7MiS8SM2AI1KmCJvofMsO
   orvZgePtIKWgffnIiuGzf8edYHScJcDEXpGj9EUZNO8JLWw0VU6GDCM8t
   J0suWeefNeS4CUwZrVP+mQpdDeSLb4mv0AUqiblbRYY4E00uwokVCCe66
   2AgiTfWgLsss3koyZvBqbIOD9jBnXd2crUWjKpNfbMsi/DMqd7kK3Iwqm
   g==;
X-CSE-ConnectionGUID: JnsX1Vh9RQWGS+f3LRlRxA==
X-CSE-MsgGUID: iaHkGmvDQ52IypQAwpXwQQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11443"; a="61208328"
X-IronPort-AV: E=Sophos;i="6.15,312,1739865600"; 
   d="scan'208";a="61208328"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2025 22:23:13 -0700
X-CSE-ConnectionGUID: pRhYGFi9SOCZV7dTgNrxbw==
X-CSE-MsgGUID: C9W1IL/gSxiMhY39SjDvfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,312,1739865600"; 
   d="scan'208";a="146656304"
Received: from unknown (HELO intel-Lenovo-Legion-Y540-15IRH-PG0.iind.intel.com) ([10.224.186.95])
  by fmviesa005.fm.intel.com with ESMTP; 24 May 2025 22:23:11 -0700
From: Kiran K <kiran.k@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: ravishankar.srivatsa@intel.com,
	chethan.tumkur.narayan@intel.com,
	chandrashekar.devegowda@intel.com,
	vijay.satija@intel.com,
	Kiran K <kiran.k@intel.com>
Subject: [PATCH v1 2/3] Bluetooth: btintel_pcie: Increase the tx and rx descriptor count
Date: Sun, 25 May 2025 11:09:39 +0530
Message-ID: <20250525053940.520283-2-kiran.k@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250525053940.520283-1-kiran.k@intel.com>
References: <20250525053940.520283-1-kiran.k@intel.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>

This change addresses latency issues observed in HID use cases where
events arrive in bursts. By increasing the Rx descriptor count to 64,
the firmware can handle bursty data more effectively, reducing latency
and preventing buffer overflows.

Signed-off-by: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>
Signed-off-by: Kiran K <kiran.k@intel.com>
---
 drivers/bluetooth/btintel_pcie.c | 24 ++++++++++++------------
 drivers/bluetooth/btintel_pcie.h |  7 +++++--
 2 files changed, 17 insertions(+), 14 deletions(-)

diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index 2c7731803c9f..03f13de4a723 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -1783,8 +1783,8 @@ static int btintel_pcie_alloc(struct btintel_pcie_data *data)
 	 *  + size of index * Number of queues(2) * type of index array(4)
 	 *  + size of context information
 	 */
-	total = (sizeof(struct tfd) + sizeof(struct urbd0) + sizeof(struct frbd)
-		+ sizeof(struct urbd1)) * BTINTEL_DESCS_COUNT;
+	total = (sizeof(struct tfd) + sizeof(struct urbd0)) * BTINTEL_PCIE_TX_DESCS_COUNT;
+	total += (sizeof(struct frbd) + sizeof(struct urbd1)) * BTINTEL_PCIE_RX_DESCS_COUNT;
 
 	/* Add the sum of size of index array and size of ci struct */
 	total += (sizeof(u16) * BTINTEL_PCIE_NUM_QUEUES * 4) + sizeof(struct ctx_info);
@@ -1809,36 +1809,36 @@ static int btintel_pcie_alloc(struct btintel_pcie_data *data)
 	data->dma_v_addr = v_addr;
 
 	/* Setup descriptor count */
-	data->txq.count = BTINTEL_DESCS_COUNT;
-	data->rxq.count = BTINTEL_DESCS_COUNT;
+	data->txq.count = BTINTEL_PCIE_TX_DESCS_COUNT;
+	data->rxq.count = BTINTEL_PCIE_RX_DESCS_COUNT;
 
 	/* Setup tfds */
 	data->txq.tfds_p_addr = p_addr;
 	data->txq.tfds = v_addr;
 
-	p_addr += (sizeof(struct tfd) * BTINTEL_DESCS_COUNT);
-	v_addr += (sizeof(struct tfd) * BTINTEL_DESCS_COUNT);
+	p_addr += (sizeof(struct tfd) * BTINTEL_PCIE_TX_DESCS_COUNT);
+	v_addr += (sizeof(struct tfd) * BTINTEL_PCIE_TX_DESCS_COUNT);
 
 	/* Setup urbd0 */
 	data->txq.urbd0s_p_addr = p_addr;
 	data->txq.urbd0s = v_addr;
 
-	p_addr += (sizeof(struct urbd0) * BTINTEL_DESCS_COUNT);
-	v_addr += (sizeof(struct urbd0) * BTINTEL_DESCS_COUNT);
+	p_addr += (sizeof(struct urbd0) * BTINTEL_PCIE_TX_DESCS_COUNT);
+	v_addr += (sizeof(struct urbd0) * BTINTEL_PCIE_TX_DESCS_COUNT);
 
 	/* Setup FRBD*/
 	data->rxq.frbds_p_addr = p_addr;
 	data->rxq.frbds = v_addr;
 
-	p_addr += (sizeof(struct frbd) * BTINTEL_DESCS_COUNT);
-	v_addr += (sizeof(struct frbd) * BTINTEL_DESCS_COUNT);
+	p_addr += (sizeof(struct frbd) * BTINTEL_PCIE_RX_DESCS_COUNT);
+	v_addr += (sizeof(struct frbd) * BTINTEL_PCIE_RX_DESCS_COUNT);
 
 	/* Setup urbd1 */
 	data->rxq.urbd1s_p_addr = p_addr;
 	data->rxq.urbd1s = v_addr;
 
-	p_addr += (sizeof(struct urbd1) * BTINTEL_DESCS_COUNT);
-	v_addr += (sizeof(struct urbd1) * BTINTEL_DESCS_COUNT);
+	p_addr += (sizeof(struct urbd1) * BTINTEL_PCIE_RX_DESCS_COUNT);
+	v_addr += (sizeof(struct urbd1) * BTINTEL_PCIE_RX_DESCS_COUNT);
 
 	/* Setup data buffers for txq */
 	err = btintel_pcie_setup_txq_bufs(data, &data->txq);
diff --git a/drivers/bluetooth/btintel_pcie.h b/drivers/bluetooth/btintel_pcie.h
index 5ddd6d7d8d45..7dad4523236c 100644
--- a/drivers/bluetooth/btintel_pcie.h
+++ b/drivers/bluetooth/btintel_pcie.h
@@ -154,8 +154,11 @@ enum msix_mbox_int_causes {
 /* Default interrupt timeout in msec */
 #define BTINTEL_DEFAULT_INTR_TIMEOUT_MS	3000
 
-/* The number of descriptors in TX/RX queues */
-#define BTINTEL_DESCS_COUNT	16
+/* The number of descriptors in TX queues */
+#define BTINTEL_PCIE_TX_DESCS_COUNT	32
+
+/* The number of descriptors in RX queues */
+#define BTINTEL_PCIE_RX_DESCS_COUNT	64
 
 /* Number of Queue for TX and RX
  * It indicates the index of the IA(Index Array)
-- 
2.43.0

