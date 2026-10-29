Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793266420;
	b=vTb11LTAvA5k+m5IL0ByRSFjzkr9CSzKQGWJ4veE337FdTePdqFiOVc86PXzCdVAHoQZ
	 91jHTGM4m8A3wNit+KDNemHdI/JoC5R5yK0Bym3BAhZmD1yXW3OZJxXOA3NxbwnYtIYZ7
	 fk0ESCN8up9JseGWD8S/nQJb88oyCVmTJ5CfkoKwLfRUG9VIvvswnJh5beb60Vb7DR31T
	 QlswTOCLxY8XXFHt/ucOfv4gh94ox7tI7/6exzf29O2pC0J0SkJyDy/nMJXKLNCQrvVzr
	 1yYt0WO0pI6vRjip5InN/Bl4t5O9SXLcgOGZv4q5clrAaizneCMCIWmlmFBrJ3ggzMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793266420;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=z6BVbV/UonCktgh/pZT27Bva43SJcOQfuG5Lbyt0aZ4=;
	b=1f2J0U9aJJyxzvERKZNu1sRYJGm1Awmyfj8XEycIFvLela4sOM+PrAj5BVSn7piJ3XAM
	 QNHGv2J5jr2C1O1hSF9O0Ysj3G1M/FmMMRKX/wA82hF4qAwXK7WoOftRLIOf00IV16QnM
	 bUVy+7AOf2k+Yz4SyUW9oHOdDYKPNAmKgQM0GLiZepjar4WwQDHfmLDwwUkNaAwmcjpCF
	 3AgVdMMraDPekWHaowZu5/3LoDjG8oc/vkPAJrHmkRRHQ2jevXUvAS5vYUTdYNeqdrGv4
	 pwx6V0C68cXshkNs30sTL0PcXfgBaon5e9J/QSV1UFkdjbyesSfcgMTa/8Mq6Vi1EoA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=e+KjeVLb;
	arc=none smtp.remote-ip=198.175.65.11
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B1BA606A31A
	for <linux-bluetooth@vger.kernel.org>; Thu, 29 Oct 2026 09:33:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9B1BA606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=e+KjeVLb
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793266419; x=1824802419;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OFC9OvpXTqQuatS33Q26UXfwIo88vg2v4dSQAZM2rHA=;
  b=e+KjeVLbX+wrOSXLeljeRBOe4UIs5jj9z8jpGuuPGPgmDuyVhILikFUz
   PCXuVk+6lxoWkryM2B151lbkw2PdgEdpupUGEdRdiZ8cv1Yqk/GB+e8n+
   3bPd8siKWyxdfnXa5bTZKXSHdsedEJVLPVghxDCkl9EoWnZELHg/JKs2x
   LBmO8ZRKiXGjV1XXmXBA6vMyoTOJw2ZnU3TDQsckiVGgPOGie+s455hmZ
   qHTtUn6RYuZPw5/bk63IkOU+7dFSIhUAF4OtqURq3LHel0tH9lji/urgf
   uQeI3g1Ho1mBSSyMJuqgxuzEtSfAnJ2yWtXFNx/33UN1xTY2sjF2A8AN3
   A==;
X-CSE-ConnectionGUID: SRAUxXYxTPaa0c7/IRjXUg==
X-CSE-MsgGUID: o+flSq9OR1OT5+WGH2bIGw==
X-IronPort-AV: E=McAfee;i="6800,10657,11949"; a="1887601"
X-IronPort-AV: E=Sophos;i="6.27,184,1787036400"; 
   d="scan'208";a="1887601"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2026 02:33:39 -0700
X-CSE-ConnectionGUID: l1f9Ftr/RJuUFnjsq2a/jA==
X-CSE-MsgGUID: V9EGpNU6Re212OIlWc9QWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,184,1787036400"; 
   d="scan'208";a="5183767"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by fmviesa003.fm.intel.com with ESMTP; 29 Oct 2026 02:33:37 -0700
From: Kiran K <kiran.k@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: chethan.tumkur.narayan@intel.com,
	chandrashekar.devegowda@intel.com,
	Kiran K <kiran.k@intel.com>
Subject: [PATCH v1 4/7] Bluetooth: btintel_pcie: Add Sx transition logging under LOG_MASK
Date: Thu, 29 Oct 2026 15:23:41 +0530
Message-ID: <20261029095344.3989729-4-kiran.k@intel.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261029095344.3989729-1-kiran.k@intel.com>
References: <20261029095344.3989729-1-kiran.k@intel.com>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Log suspend and resume entry with the decoded PM event and target D
state, the time taken to enter D3, and IPC sleep control register
writes, all gated by BTINTEL_PCIE_LOG_SX (bit 3). Enable this category
by default alongside alive interrupt logging.

Assisted-by: Copilot:Claude Opus 4.7
Signed-off-by: Kiran K <kiran.k@intel.com>
---
 drivers/bluetooth/btintel_pcie.c | 51 ++++++++++++++++++++++++++++++--
 drivers/bluetooth/btintel_pcie.h |  2 +-
 2 files changed, 49 insertions(+), 4 deletions(-)

diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index 5088a9c39b3d..56c76e5fe473 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -35,6 +35,7 @@
 #define BTINTEL_PCIE_DUMP_TX		BIT(0)
 #define BTINTEL_PCIE_DUMP_RX		BIT(1)
 #define BTINTEL_PCIE_LOG_ALIVE_INTR	BIT(2)
+#define BTINTEL_PCIE_LOG_SX		BIT(3)
 
 #define BTINTEL_PCI_DEVICE(dev, subdev)	\
 	.vendor = PCI_VENDOR_ID_INTEL,	\
@@ -237,6 +238,30 @@ static const char *btintel_pcie_pkt_type_str(u8 pkt_type)
 	return "UNK";
 }
 
+static const char *btintel_pcie_pm_event_str(u32 event)
+{
+	switch (event) {
+	case PM_EVENT_ON:
+		return "ON";
+	case PM_EVENT_FREEZE:
+		return "FREEZE(S4/hibernation prep)";
+	case PM_EVENT_SUSPEND:
+		return "SUSPEND(S3/S0ix)";
+	case PM_EVENT_HIBERNATE:
+		return "HIBERNATE(S4)";
+	case PM_EVENT_THAW:
+		return "THAW";
+	case PM_EVENT_RESTORE:
+		return "RESTORE";
+	case PM_EVENT_RESUME:
+		return "RESUME";
+	case PM_EVENT_RECOVER:
+		return "RECOVER";
+	default:
+		return "UNKNOWN";
+	}
+}
+
 /* Returns true when firmware traces are routed to the WiFi DBGC. In that
  * mode the host must not allocate DBGC buffers and must not publish their
  * addresses in the context info.
@@ -263,7 +288,8 @@ static inline bool btintel_pcie_dbg_to_wifi(struct btintel_pcie_data *data)
  * entry leaves data->enable_ini unchanged.
  *
  * LOG_MASK accepts any u32 bitmask (see BTINTEL_PCIE_DUMP_TX and friends).
- * An invalid or missing entry leaves data->log_mask unchanged.
+ * The default enables alive interrupt and Sx logging; an invalid or missing
+ * entry leaves data->log_mask unchanged.
  */
 static void btintel_pcie_load_dbg_path_from_ini(struct btintel_pcie_data *data)
 {
@@ -1750,7 +1776,9 @@ static inline bool btintel_pcie_in_device_halt(struct btintel_pcie_data *data)
 static void btintel_pcie_wr_sleep_cntrl(struct btintel_pcie_data *data,
 					u32 dxstate)
 {
-	bt_dev_dbg(data->hdev, "writing sleep_ctl_reg: 0x%8.8x", dxstate);
+	if (data->log_mask & BTINTEL_PCIE_LOG_SX)
+		BT_INFO("%s: writing sleep_ctl_reg: 0x%8.8x",
+			btintel_pcie_dev_name(data), dxstate);
 	btintel_pcie_wr_reg32(data, BTINTEL_PCIE_CSR_IPC_SLEEP_CTL_REG, dxstate);
 }
 
@@ -4636,7 +4664,7 @@ static int btintel_pcie_probe(struct pci_dev *pdev,
 	data->boot_stage_cache = 0x00;
 	data->img_resp_cache = 0x00;
 	data->dbg_path_cache = BTINTEL_PCIE_WIFI_DBGC;
-	data->log_mask = BTINTEL_PCIE_LOG_ALIVE_INTR;
+	data->log_mask = BTINTEL_PCIE_LOG_ALIVE_INTR | BTINTEL_PCIE_LOG_SX;
 	data->pcie_alloc_init = false;
 	data->enable_ini = false;
 	btintel_pcie_yoyo_init(&data->yoyo);
@@ -4894,6 +4922,12 @@ static int btintel_pcie_suspend_late(struct device *dev, pm_message_t mesg)
 	else
 		dxstate = BTINTEL_PCIE_STATE_D3_COLD;
 
+	if (data->log_mask & BTINTEL_PCIE_LOG_SX)
+		bt_dev_info(data->hdev,
+			    "Sx suspend: event=%s(0x%x) dxstate=%u",
+			    btintel_pcie_pm_event_str(mesg.event),
+			    mesg.event, dxstate);
+
 	start = ktime_get();
 
 	/* Refer: 6.4.11.7 -> Platform power management */
@@ -4911,6 +4945,12 @@ static int btintel_pcie_suspend_late(struct device *dev, pm_message_t mesg)
 	bt_dev_dbg(data->hdev,
 		   "device entered into d3 state from d0 in %lld us",
 		   ktime_to_us(ktime_get() - start));
+
+	if (data->log_mask & BTINTEL_PCIE_LOG_SX)
+		bt_dev_info(data->hdev,
+			    "Sx suspend complete: d3 entry took %lld us",
+			    ktime_to_us(ktime_get() - start));
+
 	return err;
 }
 
@@ -4938,6 +4978,11 @@ static int btintel_pcie_resume_event(struct device *dev, pm_message_t mesg)
 
 	data = pci_get_drvdata(pdev);
 
+	if (data->log_mask & BTINTEL_PCIE_LOG_SX)
+		bt_dev_info(data->hdev, "Sx resume: event=%s(0x%x)",
+			    btintel_pcie_pm_event_str(mesg.event),
+			    mesg.event);
+
 	start = ktime_get();
 
 	/* S3 and S4 may cut power, erasing the firmware. Force FLR to recover
diff --git a/drivers/bluetooth/btintel_pcie.h b/drivers/bluetooth/btintel_pcie.h
index 3e662c34cd02..f04dfb0b30fa 100644
--- a/drivers/bluetooth/btintel_pcie.h
+++ b/drivers/bluetooth/btintel_pcie.h
@@ -718,7 +718,7 @@ struct btintel_pcie_ini_dump_info {
  * @img_resp_cache: cached value of image response register
  * @dbg_path_cache: cached debug output routing mode (BT DRAM or WiFi DBGC)
  * @log_mask: runtime diagnostic logging mask loaded from LOG_MASK in the
- *	debug INI file
+ *	debug INI file (alive interrupt and Sx logging are enabled by default)
  * @cnvi: CNVi register value
  * @cnvr: CNVr register value
  * @gp0_received: condition for gp0 interrupt
-- 
2.54.0

