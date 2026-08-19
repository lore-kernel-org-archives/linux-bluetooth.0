Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC68130B514
	for <linux-bluetooth@vger.kernel.org>; Wed, 19 Aug 2026 14:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787148743; cv=none; b=uFOaBvlMyd/pZeWtxuqAj5NOkPZFhxIEO3KIvt84VHYjLnS24Tfoh9h1DIUEGu4qEbJ32lxvocFHurbg5Z6Yyp36xX9uh9PlnO7bcNST7vEJLY6Yn63YsCK3yB3gXpin2O9HleLYn32gK+4Y/HBJJKhP2hC69ibo4VB3AkAv1Q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787148743; c=relaxed/simple;
	bh=W6s7kMyasXsM1tqWAX1HjNgTWQqEEVI38cAUu9lJ/nE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ur6v90henCgzEtjv4u6Z1Wy5ZQ3ZRWTN1pzoNEg5EnIR6ZkknqBHko21tuksijnh9BTHIejai4w52ret9ubxdkQ68g03uHfP2GwPEMkixwzv8E8NyahoCP9XotdQ2u0KxFTDGcdmTc95QSnZ86Gx2DWMhWXHJYOK1b+D+2II7Pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fEUbDU4Q; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fEUbDU4Q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787148741; x=1818684741;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=W6s7kMyasXsM1tqWAX1HjNgTWQqEEVI38cAUu9lJ/nE=;
  b=fEUbDU4Q6K1oU9zCA4enk4SKRnuGxtjhUPQjYZWH6t0dINYN+hepTaR+
   4aDvWp+xIgDH6HdMIFynx7goPUABfUbAz4mLgta0iMt4/6tBT802hreyk
   5xPLecMNE3JYjYy+H/BLMppxbXefvmysfcMS4Q5qWHoX7HwcYz92DGWNs
   VxSV6lpLTfSsB/ZJoqwCYPpiWdmazGqhWYNTA70J986M0Bz8alqj89QTt
   NnuPwpMOT64gSwNOk0WHB9vKOKZr/uWw/5mAILeifQcWQup7MqUruLj41
   e36kHJ02bQiQUuzAm7pfFIo/+eI+k4/aU34RNcEh3SPBMY2sQZ9DkAuRG
   g==;
X-CSE-ConnectionGUID: ogV74MxBTJCrXDG33ZImkg==
X-CSE-MsgGUID: sCxfmhn7SIiTUbVVAli9zA==
X-IronPort-AV: E=McAfee;i="6800,10657,11880"; a="110450461"
X-IronPort-AV: E=Sophos;i="6.25,231,1779174000"; 
   d="scan'208";a="110450461"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2026 07:12:21 -0700
X-CSE-ConnectionGUID: UPB+7q5ZRFi8srhgW7jhPw==
X-CSE-MsgGUID: ZzyNDpA1S/mdYfjtYXR+Pw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,231,1779174000"; 
   d="scan'208";a="264240060"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by orviesa010.jf.intel.com with ESMTP; 19 Aug 2026 07:12:19 -0700
From: Kiran K <kiran.k@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: ravishankar.srivatsa@intel.com,
	chethan.tumkur.narayan@intel.com,
	Kiran K <kiran.k@intel.com>
Subject: [PATCH v2 2/3] Bluetooth: btintel_pcie: sync mbox tlv parsing with GP0 alive interrupt
Date: Wed, 19 Aug 2026 20:02:18 +0530
Message-ID: <20260819143219.22728-2-kiran.k@intel.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260819143219.22728-1-kiran.k@intel.com>
References: <20260819143219.22728-1-kiran.k@intel.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Performing a target access to read the mbox TLV table while the driver
is concurrently posting RX buffers to the firmware causes the hardware
to return 0 for the target address, resulting in an invalid/empty TLV
parse.

Add a synchronization handshake between the mbox TLV read operation
performed by the mbox worker and the GP0 (alive) MSI-X interrupt (which
signals completion of RX buffer posting). The worker now waits for the
alive interrupt before initiating the target access, ensuring the
hardware returns valid data.

Assisted-by: Gemini:gemini-3.1-pro-preview
Signed-off-by: Kiran K <kiran.k@intel.com>
---
changes in v2:
 - No code change

 drivers/bluetooth/btintel_pcie.c | 42 +++++++++++++++++++++++++++++---
 drivers/bluetooth/btintel_pcie.h | 10 +++++++-
 2 files changed, 48 insertions(+), 4 deletions(-)

diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index 4d1b6e9a2bdc..bbce41b5b376 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -987,6 +987,24 @@ static int btintel_parse_mbox_tlv(struct btintel_pcie_data *data)
 	struct mbox_tlv *tlv;
 	struct btintel_data *cnvi_data = hci_get_priv(data->hdev);
 	u8 hw_variant = INTEL_HW_VARIANT(cnvi_data->cnvi_bt);
+	long t;
+
+	/* Wait for GP0 alive interrupt to post RX buffers */
+	t = wait_event_timeout(data->mbox_parse_wait_q,
+			       test_bit(BTINTEL_PCIE_MBOX_PARSE_READY, &data->flags),
+			       msecs_to_jiffies(BTINTEL_PCIE_MBOX_INTR_TIMEOUT_MS));
+	if (!t) {
+		bt_dev_warn(data->hdev,
+			    "Timeout (%u ms) waiting for alive interrupt before mbox TLV parse; skipping",
+			    BTINTEL_PCIE_MBOX_INTR_TIMEOUT_MS);
+		return 0;
+	}
+	clear_bit(BTINTEL_PCIE_MBOX_PARSE_READY, &data->flags);
+
+	bt_dev_info(data->hdev,
+		    "mbox TLV parse started at %lld ns (%lld us after mbox interrupt)",
+		    ktime_to_ns(ktime_get()),
+		    ktime_to_us(ktime_sub(ktime_get(), data->mbox_intr_ts)));
 
 	memset(&data->dump_info, 0, sizeof(data->dump_info));
 
@@ -1230,12 +1248,22 @@ static void btintel_pcie_msix_gp1_handler(struct btintel_pcie_data *data)
 	if (target_access &&
 	    !test_and_set_bit(BTINTEL_PCIE_MAIL_BOX_INTR,
 				   &data->flags)) {
+		/* Arm the mbox<->alive handshake */
+		clear_bit(BTINTEL_PCIE_MBOX_PARSE_READY, &data->flags);
+		set_bit(BTINTEL_PCIE_MBOX_PARSE_PENDING, &data->flags);
+		data->mbox_intr_ts = ktime_get();
+
+		bt_dev_info(data->hdev,
+			    "mbox interrupt received at %lld ns; queuing mbox_work",
+			    ktime_to_ns(data->mbox_intr_ts));
+
 		WRITE_ONCE(data->debug_table_addr, addr);
 		WRITE_ONCE(data->debug_table_size, size);
 		if (!queue_work(data->dump_workqueue,
-				&data->mbox_work))
-			clear_bit(BTINTEL_PCIE_MAIL_BOX_INTR,
-				  &data->flags);
+				&data->mbox_work)) {
+			clear_bit(BTINTEL_PCIE_MAIL_BOX_INTR, &data->flags);
+			clear_bit(BTINTEL_PCIE_MBOX_PARSE_PENDING, &data->flags);
+		}
 	}
 
 	/* Mailbox is read, ack to FW */
@@ -1345,6 +1373,12 @@ static void btintel_pcie_msix_gp0_handler(struct btintel_pcie_data *data)
 	if (submit_rx) {
 		btintel_pcie_reset_ia(data);
 		btintel_pcie_start_rx(data);
+
+		/* Complete the mbox<->alive handshake */
+		if (test_and_clear_bit(BTINTEL_PCIE_MBOX_PARSE_PENDING, &data->flags)) {
+			set_bit(BTINTEL_PCIE_MBOX_PARSE_READY, &data->flags);
+			wake_up(&data->mbox_parse_wait_q);
+		}
 	}
 
 	if (signal_waitq) {
@@ -3301,6 +3335,8 @@ static int btintel_pcie_probe(struct pci_dev *pdev,
 	init_waitqueue_head(&data->tx_wait_q);
 	data->tx_wait_done = false;
 
+	init_waitqueue_head(&data->mbox_parse_wait_q);
+
 	data->workqueue = alloc_ordered_workqueue(KBUILD_MODNAME, WQ_HIGHPRI);
 	if (!data->workqueue)
 		return -ENOMEM;
diff --git a/drivers/bluetooth/btintel_pcie.h b/drivers/bluetooth/btintel_pcie.h
index 5ceb2ba1276f..5aff1dfa888f 100644
--- a/drivers/bluetooth/btintel_pcie.h
+++ b/drivers/bluetooth/btintel_pcie.h
@@ -125,7 +125,9 @@ enum {
 	BTINTEL_PCIE_FWTRIGGER_DUMP_INPROGRESS,
 	BTINTEL_PCIE_RECOVERY_IN_PROGRESS,
 	BTINTEL_PCIE_SETUP_DONE,
-	BTINTEL_PCIE_MAIL_BOX_INTR
+	BTINTEL_PCIE_MAIL_BOX_INTR,
+	BTINTEL_PCIE_MBOX_PARSE_PENDING,
+	BTINTEL_PCIE_MBOX_PARSE_READY
 };
 
 enum btintel_pcie_tlv_type {
@@ -178,6 +180,7 @@ enum btintel_pcie_mbox_msg {
 
 /* Default interrupt timeout in msec */
 #define BTINTEL_DEFAULT_INTR_TIMEOUT_MS	3000
+#define BTINTEL_PCIE_MBOX_INTR_TIMEOUT_MS	500
 
 #define BTINTEL_PCIE_DX_TRANSITION_MAX_RETRIES	3
 
@@ -588,6 +591,11 @@ struct btintel_pcie_data {
 	u32	debug_table_size;
 	struct btintel_pcie_dump_mem_info	dump_info;
 	struct btintel_pcie_mbox	mbox;
+
+	/* Wait queue for mbox_worker to wait for GP0 alive interrupt */
+	wait_queue_head_t	mbox_parse_wait_q;
+	/* Timestamp captured in GP1 handler when mbox interrupt is received */
+	ktime_t	mbox_intr_ts;
 };
 
 static inline u32 btintel_pcie_rd_reg32(struct btintel_pcie_data *data,
-- 
2.54.0

