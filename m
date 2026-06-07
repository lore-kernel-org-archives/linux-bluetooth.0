Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75B7233926
	for <linux-bluetooth@vger.kernel.org>; Sun,  7 Jun 2026 06:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780812111; cv=none; b=PhI2iw06Bi+TSfV5nS9U598UvDdMGya+PPHkwObQQq/ZSMTaS2t9DrMNQRfusfUj3V0Jl6AblqvS1m71tEPxToktFl1zzV3Eg6KpxyjmjUao0TRHhz7AQ9bmUXAeu87yqFLgodNTW8T55nDB4YEJe9kZccSVWOhxWnbVP41xUfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780812111; c=relaxed/simple;
	bh=E/9O9jKVFwZFskpeaMK/Re4xAEHMAw7zeuQh7ieV4iE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=T+VKiqnCjjUI7IWF7esE82Lj02inmCA/9dBR7VPvZcdMbC35gLfU68S/Pjwi0GTyngAMpxuCmrUJoMGWQK+9uwy/BD9khxGTDEikIQnpNPY4yG9onxHZVgtN7MKcfbY+YVmje1Pcpfz66Vd2ynkxidV5upeCR+N8047zLD9IM60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VROawccR; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VROawccR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780812109; x=1812348109;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=E/9O9jKVFwZFskpeaMK/Re4xAEHMAw7zeuQh7ieV4iE=;
  b=VROawccRtIqBVU9w8ysY6wR+ZnXhQzZX+RPl3lMpmhSmkol1ZT/Q/J0h
   sboNKa1FKu7cf8uzg5Lu+MH4MPP9aoIN0RxhuNI8XSPKHaYM/5YNmLs5u
   /56yfRJpGYiw80TC6R94qV0Qgm0JNzrlMqOO0tYNeTfNyjN3hj/2psMTs
   Us375OfZ+JHRQP1uzPEZ8zxMv2BqEcmTXu8oWdChcNWrdacWkKAuj+TQz
   e53tWYA/JHuJK19w23UELCBqIGLN5+FXtG9yCSNV0mtTGIlBIiKUbqCzV
   ZR3Tstm9nJCs/bHyAkEzoBQUy5QOWSLJGoyLMtJTHwlB+XC+EwUZD/mSu
   g==;
X-CSE-ConnectionGUID: Zu6/skLXQBmLgs4OOnpEpA==
X-CSE-MsgGUID: 0tDp4bnfQiy+XStoewBM8Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11809"; a="81491611"
X-IronPort-AV: E=Sophos;i="6.24,192,1774335600"; 
   d="scan'208";a="81491611"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2026 23:01:49 -0700
X-CSE-ConnectionGUID: GboNbmNnS+S+SJyzWIeieQ==
X-CSE-MsgGUID: TgRX9zu8QKSL+ikwS4/CAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,192,1774335600"; 
   d="scan'208";a="242758818"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by fmviesa008.fm.intel.com with ESMTP; 06 Jun 2026 23:01:46 -0700
From: Kiran K <kiran.k@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: ravishankar.srivatsa@intel.com,
	chethan.tumkur.narayan@intel.com,
	chandrashekar.devegowda@intel.com,
	aluvala.sai.teja@intel.com,
	Kiran K <kiran.k@intel.com>
Subject: [PATCH v1] Bluetooth: btintel_pcie: Load IOSF debug regs by controller variant
Date: Sun,  7 Jun 2026 11:51:17 +0530
Message-ID: <20260607062117.110893-1-kiran.k@intel.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sai Teja Aluvala <aluvala.sai.teja@intel.com>

Load the IOSF DBGC base address based on the controller hardware
variant when reading DRAM buffers during a trace dump. Scorpius
Peak family controllers (SCP/SCP2/SCP2F) use a different DBGC base
address (0xf0d5d500) than Blazar family controllers (BZRI/BZRIW,
0xf3800300).

Fixes: 07e6bddb54b4 ("Bluetooth: btintel_pcie: Add support for device coredump")
Signed-off-by: Sai Teja Aluvala <aluvala.sai.teja@intel.com>
Signed-off-by: Kiran K <kiran.k@intel.com>
---
 drivers/bluetooth/btintel.h      |  1 +
 drivers/bluetooth/btintel_pcie.c | 30 ++++++++++++++++++++++++------
 drivers/bluetooth/btintel_pcie.h |  4 ++++
 3 files changed, 29 insertions(+), 6 deletions(-)

diff --git a/drivers/bluetooth/btintel.h b/drivers/bluetooth/btintel.h
index 7cce1bdebae0..37d93abdd5a3 100644
--- a/drivers/bluetooth/btintel.h
+++ b/drivers/bluetooth/btintel.h
@@ -78,6 +78,7 @@ struct intel_tlv {
 #define BTINTEL_HWID_BZRU	0x1d	/* BlazarU - Meteor Lake */
 #define BTINTEL_HWID_SCP	0x1f	/* Scorpius Peak - Panther Lake */
 #define BTINTEL_HWID_SCP2	0x20	/* Scorpius Peak2 - Nova Lake */
+#define BTINTEL_HWID_SCP2F	0x21	/* Scorpius Peak2-F - Nova Lake */
 #define BTINTEL_HWID_BZRIW	0x22	/* BlazarIW - Wildcat Lake */
 
 extern const guid_t btintel_guid_dsm;
diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index 2baef130d101..845cfacd9294 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -654,9 +654,10 @@ static void *btintel_pcie_copy_tlv(void *dest, enum btintel_pcie_tlv_type type,
 static int btintel_pcie_read_dram_buffers(struct btintel_pcie_data *data)
 {
 	u32 offset, prev_size, wr_ptr_status, dump_size, data_len;
+	u32 status_reg, wrap_reg;
 	struct btintel_pcie_dbgc *dbgc = &data->dbgc;
 	struct hci_dev *hdev = data->hdev;
-	u8 *pdata, *p, buf_idx;
+	u8 *pdata, *p, buf_idx, hw_variant;
 	struct intel_tlv *tlv;
 	struct timespec64 now;
 	struct tm tm_now;
@@ -669,7 +670,28 @@ static int btintel_pcie_read_dram_buffers(struct btintel_pcie_data *data)
 		return -EOPNOTSUPP;
 
 
-	wr_ptr_status = btintel_pcie_rd_dev_mem(data, BTINTEL_PCIE_DBGC_CUR_DBGBUFF_STATUS);
+	hw_variant = INTEL_HW_VARIANT(data->cnvi);
+	switch (hw_variant) {
+	case BTINTEL_HWID_BZRI:
+	case BTINTEL_HWID_BZRIW:
+		status_reg = BTINTEL_PCIE_DBGC_CUR_DBGBUFF_STATUS;
+		wrap_reg = BTINTEL_PCIE_DBGC_DBGBUFF_WRAP_ARND;
+		break;
+	case BTINTEL_HWID_SCP:
+	case BTINTEL_HWID_SCP2:
+	case BTINTEL_HWID_SCP2F:
+		status_reg = BTINTEL_PCIE_DBGC_CUR_DBGBUFF_STATUS_SCP;
+		wrap_reg = BTINTEL_PCIE_DBGC_DBGBUFF_WRAP_ARND_SCP;
+		break;
+	default:
+		bt_dev_err(hdev, "Unsupported Intel hardware variant (0x%2.2x)",
+			   hw_variant);
+		return -EINVAL;
+	}
+
+	wr_ptr_status = btintel_pcie_rd_dev_mem(data, status_reg);
+	data->dmp_hdr.wrap_ctr = btintel_pcie_rd_dev_mem(data, wrap_reg);
+
 	offset = wr_ptr_status & BTINTEL_PCIE_DBG_OFFSET_BIT_MASK;
 
 	buf_idx = BTINTEL_PCIE_DBGC_DBG_BUF_IDX(wr_ptr_status);
@@ -751,10 +773,6 @@ static int btintel_pcie_read_dram_buffers(struct btintel_pcie_data *data)
 				  sizeof(data->dmp_hdr.write_ptr));
 	p = btintel_pcie_copy_tlv(p, BTINTEL_WRAP_CTR, &data->dmp_hdr.wrap_ctr,
 				  sizeof(data->dmp_hdr.wrap_ctr));
-
-	data->dmp_hdr.wrap_ctr = btintel_pcie_rd_dev_mem(data,
-							 BTINTEL_PCIE_DBGC_DBGBUFF_WRAP_ARND);
-
 	p = btintel_pcie_copy_tlv(p, BTINTEL_TRIGGER_REASON, &data->dmp_hdr.trigger_reason,
 				  sizeof(data->dmp_hdr.trigger_reason));
 	p = btintel_pcie_copy_tlv(p, BTINTEL_FW_SHA, &data->dmp_hdr.fw_git_sha1,
diff --git a/drivers/bluetooth/btintel_pcie.h b/drivers/bluetooth/btintel_pcie.h
index cae84b00a700..e4a8fa479188 100644
--- a/drivers/bluetooth/btintel_pcie.h
+++ b/drivers/bluetooth/btintel_pcie.h
@@ -68,6 +68,10 @@
 #define BTINTEL_PCIE_DBGC_CUR_DBGBUFF_STATUS		(BTINTEL_PCIE_DBGC_BASE_ADDR + 0x1C)
 #define BTINTEL_PCIE_DBGC_DBGBUFF_WRAP_ARND		(BTINTEL_PCIE_DBGC_BASE_ADDR + 0x2C)
 
+#define BTINTEL_PCIE_DBGC_BASE_ADDR_SCP			(0xf0d5d500)
+#define BTINTEL_PCIE_DBGC_CUR_DBGBUFF_STATUS_SCP	(BTINTEL_PCIE_DBGC_BASE_ADDR_SCP + 0x1C)
+#define BTINTEL_PCIE_DBGC_DBGBUFF_WRAP_ARND_SCP		(BTINTEL_PCIE_DBGC_BASE_ADDR_SCP + 0x2C)
+
 #define BTINTEL_PCIE_DBG_IDX_BIT_MASK		0x0F
 #define BTINTEL_PCIE_DBGC_DBG_BUF_IDX(data)	(((data) >> 24) & BTINTEL_PCIE_DBG_IDX_BIT_MASK)
 #define BTINTEL_PCIE_DBG_OFFSET_BIT_MASK	0xFFFFFF
-- 
2.54.0

