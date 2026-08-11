Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6908D33DEC8
	for <linux-bluetooth@vger.kernel.org>; Tue, 11 Aug 2026 15:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786461986; cv=none; b=dKsik+4RrGt4rl+Qx0GOGcrUrIaBkC6/i9e3mrYck62GHioWYuTqll3uFZT3CthOEcrPqzm0UEjruqtjzEKyKda9PIlx/Fo+IU4L3Q7A6xZvzNh7T7eccp0nvBAlFgDbafZT9bk0/8E8C06YjUjdk4g9gIIoKTWWhQJj5PHMsJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786461986; c=relaxed/simple;
	bh=G4vvgeRCV+r1lK71fpWEHOV1rJMWMY3PeJhqTP+v+oE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CHDPsfu7/R8yZvY+dqrBiq9jdn97CS1FHlhjY841yyG4xw7JShPMIgVLf0rwALANeRGTAHq2TtLnZXp3doLrnWatS+ST9w21pUa56ubTUmpKY/XgagkwywWqij+rgkiTzC2OWQk0feCSFdW8+hd0iJ02acpaN08T9R0U5hh3mGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eByDXZ0W; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eByDXZ0W"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786461985; x=1817997985;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=G4vvgeRCV+r1lK71fpWEHOV1rJMWMY3PeJhqTP+v+oE=;
  b=eByDXZ0WdBvrv/XatEMXLwFT9n3BcCdLQTZmxRprZhP/JG70Xzn8S7iB
   HncZ+Cqyh498D199er9fbbYeea7evX2YaJhliP1w8d/SOgMZnBgzwvcqG
   v2zFx3C5gUMefgrpAKMuogNBEjT8JrFLJxc6ZsyFAnlMbhNj9AfBJFwn/
   UUatweLy/TOWZffak+3/0ZRlEm2UjN+1qNZI9HyRf3rSsheIFKy5nOvCI
   6gSZcug+OwOrTc/QEbzH2Yk4xeiRU7KmxueE3CcSx6c6fwKLfjS1jJJ0L
   K0wOyhyVVoJXtJktXzXDugSF1NQh1ZcEXnBUv60qcmur7jt9U/TmTFZ6H
   g==;
X-CSE-ConnectionGUID: /9Uv4M1rT72T4SqFapQijA==
X-CSE-MsgGUID: t6gfpWnsRXm1L3PlPbW7dQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11872"; a="109786933"
X-IronPort-AV: E=Sophos;i="6.25,218,1779174000"; 
   d="scan'208";a="109786933"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2026 08:26:25 -0700
X-CSE-ConnectionGUID: 4OTlQAf1Sma36MrlbF0zLA==
X-CSE-MsgGUID: u0DrrIJmTU2p8V/mhBt+3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,218,1779174000"; 
   d="scan'208";a="268523900"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by fmviesa005.fm.intel.com with ESMTP; 11 Aug 2026 08:26:22 -0700
From: Kiran K <kiran.k@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: ravishankar.srivatsa@intel.com,
	chethan.tumkur.narayan@intel.com,
	Catherine L <catherine.l@intel.com>,
	Kiran K <kiran.k@intel.com>
Subject: [PATCH v1 3/3] Bluetooth: btintel_pcie: Route debug traces to WiFi DBGC by default
Date: Tue, 11 Aug 2026 21:15:53 +0530
Message-ID: <20260811154553.629211-3-kiran.k@intel.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260811154553.629211-1-kiran.k@intel.com>
References: <20260811154553.629211-1-kiran.k@intel.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Catherine L <catherine.l@intel.com>

Set dbg_output_mode to 0x06 (BTINTEL_PCIE_WIFI_DBGC) by default so
firmware debug traces are forwarded to the WiFi DBGC. In this mode:

  - Host DBGC fragment/data buffers are NOT allocated.
  - Context info publishes dbgc_addr/size as 0.

Add a small helper btintel_pcie_dbg_to_wifi() driven by a cached
dbg_path_cache field in struct btintel_pcie_data, initialized to
BTINTEL_PCIE_WIFI_DBGC in probe.

Signed-off-by: Kiran K <kiran.k@intel.com>
Signed-off-by: Catherine L <catherine.l@intel.com>
---
 drivers/bluetooth/btintel_pcie.c | 43 +++++++++++++++++++++++++++++---
 drivers/bluetooth/btintel_pcie.h | 16 ++++++++++++
 2 files changed, 55 insertions(+), 4 deletions(-)

diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index 93963450ea95..a98edfe81ab8 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -180,6 +180,15 @@ static inline char *btintel_pcie_alivectxt_state2str(u32 alive_intr_ctxt)
 	}
 }
 
+/* Returns true when firmware traces are routed to the WiFi DBGC. In that
+ * mode the host must not allocate DBGC buffers and must not publish their
+ * addresses in the context info.
+ */
+static inline bool btintel_pcie_dbg_to_wifi(struct btintel_pcie_data *data)
+{
+	return data->dbg_path_cache != BTINTEL_PCIE_DRAM;
+}
+
 /* This function initializes the memory for DBGC buffers and formats the
  * DBGC fragment which consists header info and DBGC buffer's LSB, MSB and
  * size as the payload
@@ -1847,6 +1856,15 @@ static void btintel_pcie_coredump_worker(struct work_struct *work)
 	if (!data->hdev)
 		goto out;
 
+	/* When firmware routes debug traces to the WiFi DBGC, no host
+	 * DBGC buffers were allocated, so there is nothing to dump here.
+	 */
+	if (btintel_pcie_dbg_to_wifi(data)) {
+		bt_dev_info(data->hdev,
+			    "Skipping coredump: debug traces routed to WiFi DBGC");
+		goto out;
+	}
+
 	btintel_pcie_dump_traces(data->hdev);
 out:
 	/* Release guard last so a new trigger can run only after this
@@ -2217,9 +2235,18 @@ static void btintel_pcie_init_ci(struct btintel_pcie_data *data,
 	ci->num_urbdq1 = data->rxq.count;
 	ci->urbdq_db_vec = BTINTEL_PCIE_RXQ_NUM;
 
-	ci->dbg_output_mode = 0x01;
-	ci->dbgc_addr = data->dbgc.frag_p_addr;
-	ci->dbgc_size = data->dbgc.frag_size;
+	ci->dbg_output_mode = btintel_pcie_dbg_to_wifi(data) ?
+			      BTINTEL_PCIE_WIFI_DBGC : BTINTEL_PCIE_DRAM;
+	if (btintel_pcie_dbg_to_wifi(data)) {
+		/* Firmware forwards debug traces to the WiFi DBGC, so no
+		 * host DBGC buffer is needed; leave dbgc_addr/size as 0.
+		 */
+		ci->dbgc_addr = 0;
+		ci->dbgc_size = 0;
+	} else {
+		ci->dbgc_addr = data->dbgc.frag_p_addr;
+		ci->dbgc_size = data->dbgc.frag_size;
+	}
 	ci->dbg_preset = 0x00;
 }
 
@@ -2447,7 +2474,14 @@ static int btintel_pcie_alloc(struct btintel_pcie_data *data)
 	v_addr += ci_size;
 
 	/* Setup data buffers for dbgc */
-	err = btintel_pcie_setup_dbgc(data);
+	if (btintel_pcie_dbg_to_wifi(data)) {
+		/* Firmware routes traces to the WiFi DBGC; skip host DBGC
+		 * buffer allocation entirely.
+		 */
+		err = 0;
+	} else {
+		err = btintel_pcie_setup_dbgc(data);
+	}
 	if (err)
 		goto exit_error_txq;
 
@@ -3351,6 +3385,7 @@ static int btintel_pcie_probe(struct pci_dev *pdev,
 
 	data->boot_stage_cache = 0x00;
 	data->img_resp_cache = 0x00;
+	data->dbg_path_cache = BTINTEL_PCIE_WIFI_DBGC;
 	/* FLR can be invoked by echoing to debugfs path, so explicitly
 	 * initialized
 	 */
diff --git a/drivers/bluetooth/btintel_pcie.h b/drivers/bluetooth/btintel_pcie.h
index 5aff1dfa888f..9baa214d9bbe 100644
--- a/drivers/bluetooth/btintel_pcie.h
+++ b/drivers/bluetooth/btintel_pcie.h
@@ -94,6 +94,20 @@
 /* Num of alloc Dbg buff (4) + (LSB(4), MSB(4), Size(4)) for each buffer */
 #define BTINTEL_PCIE_DBGC_FRAG_PAYLOAD_SIZE	196
 
+/* dbg_output_mode values for the context info.
+ *   BTINTEL_PCIE_DRAM: firmware writes traces to host DRAM DBGC buffers.
+ *   BTINTEL_PCIE_WIFI_DBGC: firmware forwards traces to the WiFi DBGC; the
+ *   host does NOT need to allocate DBGC fragment/data buffers and must
+ *   publish dbgc_addr/size as 0 in the context info.
+ *
+ * Encoding of BTINTEL_PCIE_WIFI_DBGC (0x06):
+ *   Bit[0] DBGC O/P  : 0 = SRAM (don't care, DBGI selected)
+ *   Bit[1] DBGC I/P  : 1 = DBGI
+ *   Bits[2:3] DBGI O/P : 01 = WiFi DBGC
+ */
+#define BTINTEL_PCIE_DRAM	0x01
+#define BTINTEL_PCIE_WIFI_DBGC	0x06
+
 /* Causes for the FH register interrupts */
 enum msix_fh_int_causes {
 	BTINTEL_PCIE_MSIX_FH_INT_CAUSES_0	= BIT(0),	/* cause 0 */
@@ -503,6 +517,7 @@ struct btintel_pcie_dump_header {
  * @hw_init_mask: initial unmaksed hw causes
  * @boot_stage_cache: cached value of boot stage register
  * @img_resp_cache: cached value of image response register
+ * @dbg_path_cache: cached debug output routing mode (BT DRAM or WiFi DBGC)
  * @cnvi: CNVi register value
  * @cnvr: CNVr register value
  * @gp0_received: condition for gp0 interrupt
@@ -550,6 +565,7 @@ struct btintel_pcie_data {
 
 	u32	boot_stage_cache;
 	u32	img_resp_cache;
+	u32	dbg_path_cache;
 
 	u32	cnvi;
 	u32	cnvr;
-- 
2.54.0

