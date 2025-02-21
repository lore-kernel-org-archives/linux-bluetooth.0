Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D71120FA99
	for <linux-bluetooth@vger.kernel.org>; Fri, 21 Feb 2025 14:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740148988; cv=none; b=LBTZ8rZByZShYutPZ7A+bzAQNX9sx5722MO69nLVavjMWTGsG0cN66EgcYp7bk1eg+cTffWErvEGFLvnKODviK3bekbNC6U3hBXN+kx6kHM0FE0mv56kVjLu1S3iXtRIetkJZAP2+i/DSIe465HcAVe80XhpiOjb/J+hfuOGI7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740148988; c=relaxed/simple;
	bh=A5DFln0wEVSsfNZx8B/I/TXz1OWMiFWq/Gf7F4EPobQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W5yl0yXPaq1pclyq/pKPQp370OlE6M08i4qWbFuz2wx8X9j3875wYaIdkuPIP7e0Tyh38Gt0TCpZwF5KTZspRHmRwxVfG309/t8yRJjhjfkhHYcr1dYPklZAXd6GYp3sa9L6zI7VVtVCKnYfB+GLs19pOiXZhkGB9bY/W2fN1V0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Bj73yXgz; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Bj73yXgz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740148986; x=1771684986;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=A5DFln0wEVSsfNZx8B/I/TXz1OWMiFWq/Gf7F4EPobQ=;
  b=Bj73yXgz+R9/hyWTkReJq+Ux/wD6+Y3jvuxINQNryXtgKFDZ0X+KgoY+
   mN9C8KHghAOjswyGlprMoNxgBWZIaRWcdtIU/I3bYcjFrSqrG8Ni87gYU
   sHF5Sjyw8mVy9lz1n0xY/aOBEAUVAmbZypmRJ72flSoI6IdJ14B2qeyh4
   aNSpa+6vBuv0RI/pp4cFmx8q9MOJlwcdJVl1NMDBvvkVsTnmzPs/4Y80C
   yRoeBI9QnNh+ZHxE2Hoz8d9N4tgA1ob4GnPB4p4+RGbjMsSxa5iO2QZG2
   OxsZwQq0X2qJQMthUfcCHwRvCPvQlSs6CWXIHlNYctK2MYfAXK3crHLCw
   Q==;
X-CSE-ConnectionGUID: bqcP5n8RT8y2P22SRQdWFQ==
X-CSE-MsgGUID: tXM0aq+4RxO9MP2C5HNYRg==
X-IronPort-AV: E=McAfee;i="6700,10204,11352"; a="40159820"
X-IronPort-AV: E=Sophos;i="6.13,305,1732608000"; 
   d="scan'208";a="40159820"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2025 06:43:04 -0800
X-CSE-ConnectionGUID: KY8guTgwQ1e+rg291ZsppA==
X-CSE-MsgGUID: JbW8uSpUS+qe95JqG/9O9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,305,1732608000"; 
   d="scan'208";a="115914721"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by fmviesa010.fm.intel.com with ESMTP; 21 Feb 2025 06:43:02 -0800
From: Kiran K <kiran.k@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: ravishankar.srivatsa@intel.com,
	chethan.tumkur.narayan@intel.com,
	chandrashekar.devegowda@intel.com,
	vijay.satija@intel.com,
	Kiran K <kiran.k@intel.com>
Subject: [PATCH v2 3/4] Bluetooth: btintel_pcie: Add support for device coredump
Date: Fri, 21 Feb 2025 20:12:44 +0530
Message-ID: <20250221144245.1012686-3-kiran.k@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250221144245.1012686-1-kiran.k@intel.com>
References: <20250221144245.1012686-1-kiran.k@intel.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

1. Driver registers device coredump callback
2. Dumps firmware traces as part of coredump

Co-developed-by: Vijay Satija <vijay.satija@intel.com>
Signed-off-by: Vijay Satija <vijay.satija@intel.com>
Signed-off-by: Kiran K <kiran.k@intel.com>
---
v1->v2:
No change

 drivers/bluetooth/btintel.h      |   1 -
 drivers/bluetooth/btintel_pcie.c | 272 ++++++++++++++++++++++++++++++-
 drivers/bluetooth/btintel_pcie.h |  39 +++++
 3 files changed, 305 insertions(+), 7 deletions(-)

diff --git a/drivers/bluetooth/btintel.h b/drivers/bluetooth/btintel.h
index 4c21e69887a3..19530ea14905 100644
--- a/drivers/bluetooth/btintel.h
+++ b/drivers/bluetooth/btintel.h
@@ -190,7 +190,6 @@ enum {
 struct btintel_data {
 	DECLARE_BITMAP(flags, __INTEL_NUM_FLAGS);
 	int (*acpi_reset_method)(struct hci_dev *hdev);
-	u32	cnvi_top;
 };
 
 #define btintel_set_flag(hdev, nr)					\
diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index f93ddd2fdb01..3a46ad7ec0ee 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -59,6 +59,8 @@ MODULE_DEVICE_TABLE(pci, btintel_pcie_table);
 
 #define BTINTEL_PCIE_MAGIC_NUM	0xA5A5A5A5
 
+#define BTINTEL_PCIE_TRIGGER_REASON_USER_TRIGGER	0x17A2
+
 /* Alive interrupt context */
 enum {
 	BTINTEL_PCIE_ROM,
@@ -375,6 +377,25 @@ static void btintel_pcie_mac_init(struct btintel_pcie_data *data)
 	btintel_pcie_wr_reg32(data, BTINTEL_PCIE_CSR_FUNC_CTRL_REG, reg);
 }
 
+static int btintel_pcie_add_dmp_data(struct hci_dev *hdev, const void *data, int size)
+{
+	struct sk_buff *skb;
+	int err;
+
+	skb = alloc_skb(size, GFP_ATOMIC);
+	if (!skb)
+		return -ENOMEM;
+
+	skb_put_data(skb, data, size);
+	err = hci_devcd_append(hdev, skb);
+	if (err) {
+		bt_dev_err(hdev, "Failed to append data in the coredump");
+		return err;
+	}
+
+	return 0;
+}
+
 static int btintel_pcie_get_mac_access(struct btintel_pcie_data *data)
 {
 	u32 reg;
@@ -419,6 +440,194 @@ static void btintel_pcie_release_mac_access(struct btintel_pcie_data *data)
 	btintel_pcie_wr_reg32(data, BTINTEL_PCIE_CSR_FUNC_CTRL_REG, reg);
 }
 
+static void btintel_pcie_copy_tlv(struct sk_buff *skb, enum btintel_pcie_tlv_type type,
+				  void *data, int size)
+{
+	struct intel_tlv *tlv;
+
+	tlv = skb_put(skb, sizeof(*tlv) + size);
+	tlv->type = type;
+	tlv->len = size;
+	memcpy(tlv->val, data, tlv->len);
+}
+
+static int btintel_pcie_read_dram_buffers(struct btintel_pcie_data *data)
+{
+	u32 offset, prev_size, wr_ptr_status, dump_size, i;
+	struct btintel_pcie_dbgc *dbgc = &data->dbgc;
+	u8 buf_idx, dump_time_len, fw_build;
+	struct hci_dev *hdev = data->hdev;
+	struct intel_tlv *tlv;
+	struct timespec64 now;
+	struct sk_buff *skb;
+	struct tm tm_now;
+	char buf[100];
+	u16 hdr_len;
+	int ret;
+
+	wr_ptr_status = btintel_pcie_rd_dev_mem(data, BTINTEL_PCIE_DBGC_CUR_DBGBUFF_STATUS);
+	offset = wr_ptr_status & BTINTEL_PCIE_DBG_OFFSET_BIT_MASK;
+
+	buf_idx = BTINTEL_PCIE_DBGC_DBG_BUF_IDX(wr_ptr_status);
+	if (buf_idx > dbgc->count) {
+		bt_dev_warn(hdev, "Buffer index is invalid");
+		return -EINVAL;
+	}
+
+	prev_size = buf_idx * BTINTEL_PCIE_DBGC_BUFFER_SIZE;
+	if (prev_size + offset >= prev_size)
+		data->dmp_hdr.write_ptr = prev_size + offset;
+	else
+		return -EINVAL;
+
+	ktime_get_real_ts64(&now);
+	time64_to_tm(now.tv_sec, 0, &tm_now);
+	dump_time_len = snprintf(buf, sizeof(buf), "Dump Time: %02d-%02d-%04ld %02d:%02d:%02d",
+				 tm_now.tm_mday, tm_now.tm_mon + 1, tm_now.tm_year + 1900,
+				 tm_now.tm_hour, tm_now.tm_min, tm_now.tm_sec);
+
+	fw_build = snprintf(buf + dump_time_len, sizeof(buf),
+			    "Firmware Timestamp: Year %u WW %02u buildtype %u build %u",
+			    2000 + (data->dmp_hdr.fw_timestamp >> 8),
+			    data->dmp_hdr.fw_timestamp & 0xff, data->dmp_hdr.fw_build_type,
+			    data->dmp_hdr.fw_build_num);
+
+	hdr_len = sizeof(*tlv) + sizeof(data->dmp_hdr.cnvi_bt) +
+		  sizeof(*tlv) + sizeof(data->dmp_hdr.write_ptr) +
+		  sizeof(*tlv) + sizeof(data->dmp_hdr.wrap_ctr) +
+		  sizeof(*tlv) + sizeof(data->dmp_hdr.trigger_reason) +
+		  sizeof(*tlv) + sizeof(data->dmp_hdr.fw_git_sha1) +
+		  sizeof(*tlv) + sizeof(data->dmp_hdr.cnvr_top) +
+		  sizeof(*tlv) + sizeof(data->dmp_hdr.cnvi_top) +
+		  sizeof(*tlv) + dump_time_len +
+		  sizeof(*tlv) + fw_build;
+
+	dump_size = hdr_len + sizeof(hdr_len);
+
+	skb = alloc_skb(dump_size, GFP_KERNEL);
+	if (!skb)
+		return -ENOMEM;
+
+	/* Add debug buffers data length to dump size */
+	dump_size += BTINTEL_PCIE_DBGC_BUFFER_SIZE * dbgc->count;
+
+	ret = hci_devcd_init(hdev, dump_size);
+	if (ret) {
+		bt_dev_err(hdev, "Failed to init devcoredump, err %d", ret);
+		kfree_skb(skb);
+		return ret;
+	}
+
+	skb_put_data(skb, &hdr_len, sizeof(hdr_len));
+
+	btintel_pcie_copy_tlv(skb, BTINTEL_CNVI_BT, &data->dmp_hdr.cnvi_bt,
+			      sizeof(data->dmp_hdr.cnvi_bt));
+
+	btintel_pcie_copy_tlv(skb, BTINTEL_WRITE_PTR, &data->dmp_hdr.write_ptr,
+			      sizeof(data->dmp_hdr.write_ptr));
+
+	data->dmp_hdr.wrap_ctr = btintel_pcie_rd_dev_mem(data,
+							 BTINTEL_PCIE_DBGC_DBGBUFF_WRAP_ARND);
+
+	btintel_pcie_copy_tlv(skb, BTINTEL_WRAP_CTR, &data->dmp_hdr.wrap_ctr,
+			      sizeof(data->dmp_hdr.wrap_ctr));
+
+	btintel_pcie_copy_tlv(skb, BTINTEL_TRIGGER_REASON, &data->dmp_hdr.trigger_reason,
+			      sizeof(data->dmp_hdr.trigger_reason));
+
+	btintel_pcie_copy_tlv(skb, BTINTEL_FW_SHA, &data->dmp_hdr.fw_git_sha1,
+			      sizeof(data->dmp_hdr.fw_git_sha1));
+
+	btintel_pcie_copy_tlv(skb, BTINTEL_CNVR_TOP, &data->dmp_hdr.cnvr_top,
+			      sizeof(data->dmp_hdr.cnvr_top));
+
+	btintel_pcie_copy_tlv(skb, BTINTEL_CNVI_TOP, &data->dmp_hdr.cnvi_top,
+			      sizeof(data->dmp_hdr.cnvi_top));
+
+	btintel_pcie_copy_tlv(skb, BTINTEL_DUMP_TIME, buf, dump_time_len);
+
+	btintel_pcie_copy_tlv(skb, BTINTEL_FW_BUILD, buf + dump_time_len, fw_build);
+
+	ret = hci_devcd_append(hdev, skb);
+	if (ret)
+		goto exit_err;
+
+	for (i = 0; i < dbgc->count; i++) {
+		ret = btintel_pcie_add_dmp_data(hdev, dbgc->bufs[i].data,
+						BTINTEL_PCIE_DBGC_BUFFER_SIZE);
+		if (ret)
+			break;
+	}
+
+exit_err:
+	hci_devcd_complete(hdev);
+	return ret;
+}
+
+static void btintel_pcie_dump_traces(struct hci_dev *hdev)
+{
+	struct btintel_pcie_data *data = hci_get_drvdata(hdev);
+	int ret = 0;
+
+	ret = btintel_pcie_get_mac_access(data);
+	if (ret) {
+		bt_dev_err(hdev, "Failed to get mac access: (%d)", ret);
+		return;
+	}
+
+	ret = btintel_pcie_read_dram_buffers(data);
+
+	btintel_pcie_release_mac_access(data);
+
+	if (ret)
+		bt_dev_err(hdev, "Failed to dump traces: (%d)", ret);
+}
+
+static void btintel_pcie_dump_hdr(struct hci_dev *hdev, struct sk_buff *skb)
+{
+	struct btintel_pcie_data *data = hci_get_drvdata(hdev);
+	u16 len = skb->len;
+	u16 *hdrlen_ptr;
+	char buf[80];
+
+	hdrlen_ptr = skb_put_zero(skb, sizeof(len));
+
+	snprintf(buf, sizeof(buf), "Controller Name: 0x%X\n",
+		 INTEL_HW_VARIANT(data->dmp_hdr.cnvi_bt));
+	skb_put_data(skb, buf, strlen(buf));
+
+	snprintf(buf, sizeof(buf), "Firmware Build Number: %u\n",
+		 data->dmp_hdr.fw_build_num);
+	skb_put_data(skb, buf, strlen(buf));
+
+	snprintf(buf, sizeof(buf), "Driver: %s\n", data->dmp_hdr.driver_name);
+	skb_put_data(skb, buf, strlen(buf));
+
+	snprintf(buf, sizeof(buf), "Vendor: Intel\n");
+	skb_put_data(skb, buf, strlen(buf));
+
+	*hdrlen_ptr = skb->len - len;
+}
+
+static void btintel_pcie_dump_notify(struct hci_dev *hdev, int state)
+{
+	struct btintel_pcie_data *data = hci_get_drvdata(hdev);
+
+	switch (state) {
+	case HCI_DEVCOREDUMP_IDLE:
+		data->dmp_hdr.state = HCI_DEVCOREDUMP_IDLE;
+		break;
+	case HCI_DEVCOREDUMP_ACTIVE:
+		data->dmp_hdr.state = HCI_DEVCOREDUMP_ACTIVE;
+		break;
+	case HCI_DEVCOREDUMP_TIMEOUT:
+	case HCI_DEVCOREDUMP_ABORT:
+	case HCI_DEVCOREDUMP_DONE:
+		data->dmp_hdr.state = HCI_DEVCOREDUMP_IDLE;
+		break;
+	}
+}
+
 /* This function enables BT function by setting BTINTEL_PCIE_CSR_FUNC_CTRL_MAC_INIT bit in
  * BTINTEL_PCIE_CSR_FUNC_CTRL_REG register and wait for MSI-X with
  * BTINTEL_PCIE_MSIX_HW_INT_CAUSES_GP0.
@@ -562,7 +771,6 @@ static int btintel_pcie_read_device_mem(struct btintel_pcie_data *data,
 
 static void btintel_pcie_dump_hwexp(struct btintel_pcie_data *data)
 {
-	struct btintel_data *intel_data = hci_get_priv(data->hdev);
 	int len, err, offset, pending;
 	struct sk_buff *skb;
 	u8 *buf, prefix[64];
@@ -576,11 +784,11 @@ static void btintel_pcie_dump_hwexp(struct btintel_pcie_data *data)
 
 	struct tlv *tlv;
 
-	switch (intel_data->cnvi_top & 0xfff) {
+	switch (data->dmp_hdr.cnvi_top & 0xfff) {
 	case BTINTEL_CNVI_BLAZARI:
 	case BTINTEL_CNVI_BLAZARIW:
 		/* only from step B0 onwards */
-		if (INTEL_CNVX_TOP_STEP(intel_data->cnvi_top) != 0x01)
+		if (INTEL_CNVX_TOP_STEP(data->dmp_hdr.cnvi_top) != 0x01)
 			return;
 		len = BTINTEL_PCIE_BLZR_HWEXP_SIZE; /* exception data length */
 		addr = BTINTEL_PCIE_BLZR_HWEXP_DMP_ADDR;
@@ -590,7 +798,7 @@ static void btintel_pcie_dump_hwexp(struct btintel_pcie_data *data)
 		addr = BTINTEL_PCIE_SCP_HWEXP_DMP_ADDR;
 	break;
 	default:
-		bt_dev_err(data->hdev, "Unsupported cnvi 0x%8.8x", intel_data->cnvi_top);
+		bt_dev_err(data->hdev, "Unsupported cnvi 0x%8.8x", data->dmp_hdr.cnvi_top);
 		return;
 	}
 
@@ -673,6 +881,17 @@ static void btintel_pcie_hwexp_work(struct work_struct *work)
 	clear_bit(BTINTEL_PCIE_HWEXP_INPROGRESS, &data->flags);
 }
 
+static void btintel_pcie_coredump_work(struct work_struct *work)
+{
+	struct btintel_pcie_data *data = container_of(work,
+					struct btintel_pcie_data, coredump_work);
+	struct hci_dev *hdev = data->hdev;
+
+	btintel_pcie_dump_traces(hdev);
+
+	clear_bit(BTINTEL_PCIE_COREDUMP_INPROGRESS, &data->flags);
+}
+
 /* This function handles the MSI-X interrupt for gp0 cause (bit 0 in
  * BTINTEL_PCIE_CSR_MSIX_HW_INT_CAUSES) which is sent for boot stage and image response.
  */
@@ -994,6 +1213,15 @@ static int btintel_pcie_recv_frame(struct btintel_pcie_data *data,
 	return ret;
 }
 
+static void btintel_pcie_do_firmware_dump(struct btintel_pcie_data *data, u16 trigger_reason)
+{
+	if (test_and_set_bit(BTINTEL_PCIE_COREDUMP_INPROGRESS, &data->flags))
+		return;
+
+	data->dmp_hdr.trigger_reason  = trigger_reason;
+	queue_work(data->workqueue, &data->coredump_work);
+}
+
 static void btintel_pcie_msix_hw_exp_handler(struct btintel_pcie_data *data)
 {
 	bt_dev_err(data->hdev, "Received hw exception interrupt");
@@ -1701,7 +1929,7 @@ static void btintel_pcie_release_hdev(struct btintel_pcie_data *data)
 
 static int btintel_pcie_setup_internal(struct hci_dev *hdev)
 {
-	struct btintel_data *data = hci_get_priv(hdev);
+	struct btintel_pcie_data *data = hci_get_drvdata(hdev);
 	const u8 param[1] = { 0xFF };
 	struct intel_version_tlv ver_tlv;
 	struct sk_buff *skb;
@@ -1740,7 +1968,6 @@ static int btintel_pcie_setup_internal(struct hci_dev *hdev)
 		goto exit_error;
 	}
 
-	data->cnvi_top = ver_tlv.cnvi_top;
 	switch (INTEL_HW_PLATFORM(ver_tlv.cnvi_bt)) {
 	case 0x37:
 		break;
@@ -1786,6 +2013,23 @@ static int btintel_pcie_setup_internal(struct hci_dev *hdev)
 		break;
 	}
 
+	data->dmp_hdr.cnvi_top = ver_tlv.cnvi_top;
+	data->dmp_hdr.cnvr_top = ver_tlv.cnvr_top;
+	data->dmp_hdr.fw_timestamp = ver_tlv.timestamp;
+	data->dmp_hdr.fw_build_type = ver_tlv.build_type;
+	data->dmp_hdr.fw_build_num = ver_tlv.build_num;
+	data->dmp_hdr.cnvi_bt = ver_tlv.cnvi_bt;
+
+	if (ver_tlv.img_type == 0x02 || ver_tlv.img_type == 0x03)
+		data->dmp_hdr.fw_git_sha1 = ver_tlv.git_sha1;
+
+	err = hci_devcd_register(hdev, btintel_pcie_dump_traces, btintel_pcie_dump_hdr,
+				 btintel_pcie_dump_notify);
+	if (err) {
+		bt_dev_err(hdev, "Failed to register coredump (%d)", err);
+		goto exit_error;
+	}
+
 	btintel_print_fseq_info(hdev);
 exit_error:
 	kfree_skb(skb);
@@ -1850,6 +2094,7 @@ static int btintel_pcie_setup_hdev(struct btintel_pcie_data *data)
 		goto exit_error;
 	}
 
+	data->dmp_hdr.driver_name = KBUILD_MODNAME;
 	return 0;
 
 exit_error:
@@ -1889,6 +2134,7 @@ static int btintel_pcie_probe(struct pci_dev *pdev,
 	INIT_WORK(&data->rx_work, btintel_pcie_rx_work);
 
 	INIT_WORK(&data->hwexp_work, btintel_pcie_hwexp_work);
+	INIT_WORK(&data->coredump_work, btintel_pcie_coredump_work);
 
 	data->boot_stage_cache = 0x00;
 	data->img_resp_cache = 0x00;
@@ -1955,6 +2201,7 @@ static void btintel_pcie_remove(struct pci_dev *pdev)
 
 	flush_work(&data->rx_work);
 	flush_work(&data->hwexp_work);
+	flush_work(&data->coredump_work);
 
 	destroy_workqueue(data->workqueue);
 
@@ -1965,11 +2212,24 @@ static void btintel_pcie_remove(struct pci_dev *pdev)
 	pci_set_drvdata(pdev, NULL);
 }
 
+#ifdef CONFIG_DEV_COREDUMP
+static void btintel_pcie_coredump(struct device *dev)
+{
+	struct  pci_dev *pdev = to_pci_dev(dev);
+	struct btintel_pcie_data *data = pci_get_drvdata(pdev);
+
+	btintel_pcie_do_firmware_dump(data, BTINTEL_PCIE_TRIGGER_REASON_USER_TRIGGER);
+}
+#endif
+
 static struct pci_driver btintel_pcie_driver = {
 	.name = KBUILD_MODNAME,
 	.id_table = btintel_pcie_table,
 	.probe = btintel_pcie_probe,
 	.remove = btintel_pcie_remove,
+#ifdef CONFIG_DEV_COREDUMP
+	.driver.coredump = btintel_pcie_coredump
+#endif
 };
 module_pci_driver(btintel_pcie_driver);
 
diff --git a/drivers/bluetooth/btintel_pcie.h b/drivers/bluetooth/btintel_pcie.h
index 98902fd4fc96..c13f17100a74 100644
--- a/drivers/bluetooth/btintel_pcie.h
+++ b/drivers/bluetooth/btintel_pcie.h
@@ -56,6 +56,15 @@
 #define BTINTEL_PCIE_CSR_MSIX_IVAR_BASE		(BTINTEL_PCIE_CSR_MSIX_BASE + 0x0880)
 #define BTINTEL_PCIE_CSR_MSIX_IVAR(cause)	(BTINTEL_PCIE_CSR_MSIX_IVAR_BASE + (cause))
 
+/* IOSF Debug Register */
+#define BTINTEL_PCIE_DBGC_BASE_ADDR			(0xf3800300)
+#define BTINTEL_PCIE_DBGC_CUR_DBGBUFF_STATUS		(BTINTEL_PCIE_DBGC_BASE_ADDR + 0x1C)
+#define BTINTEL_PCIE_DBGC_DBGBUFF_WRAP_ARND		(BTINTEL_PCIE_DBGC_BASE_ADDR + 0x2C)
+
+#define BTINTEL_PCIE_DBG_IDX_BIT_MASK		0x0F
+#define BTINTEL_PCIE_DBGC_DBG_BUF_IDX(data)	(((data) >> 24) & BTINTEL_PCIE_DBG_IDX_BIT_MASK)
+#define BTINTEL_PCIE_DBG_OFFSET_BIT_MASK	0xFFFFFF
+
 /* The DRAM buffer count, each buffer size, and
  * fragment buffer size
  */
@@ -96,6 +105,19 @@ enum {
 
 enum {
 	BTINTEL_PCIE_HWEXP_INPROGRESS,
+	BTINTEL_PCIE_COREDUMP_INPROGRESS
+};
+
+enum btintel_pcie_tlv_type {
+	BTINTEL_CNVI_BT,
+	BTINTEL_WRITE_PTR,
+	BTINTEL_WRAP_CTR,
+	BTINTEL_TRIGGER_REASON,
+	BTINTEL_FW_SHA,
+	BTINTEL_CNVR_TOP,
+	BTINTEL_CNVI_TOP,
+	BTINTEL_DUMP_TIME,
+	BTINTEL_FW_BUILD,
 };
 
 #define BTINTEL_PCIE_MSIX_NON_AUTO_CLEAR_CAUSE	BIT(7)
@@ -370,6 +392,21 @@ struct btintel_pcie_dbgc {
 	struct data_buf *bufs;
 };
 
+struct btintel_pcie_dump_header {
+	const char	*driver_name;
+	u32		cnvi_top;
+	u32		cnvr_top;
+	u16		fw_timestamp;
+	u8		fw_build_type;
+	u32		fw_build_num;
+	u32		fw_git_sha1;
+	u32		cnvi_bt;
+	u32		write_ptr;
+	u32		wrap_ctr;
+	u16		trigger_reason;
+	int		state;
+};
+
 /* struct btintel_pcie_data
  * @pdev: pci device
  * @hdev: hdev device
@@ -452,6 +489,8 @@ struct btintel_pcie_data {
 	u32	alive_intr_ctxt;
 	struct btintel_pcie_dbgc	dbgc;
 	struct work_struct	hwexp_work;
+	struct work_struct	coredump_work;
+	struct btintel_pcie_dump_header dmp_hdr;
 };
 
 static inline u32 btintel_pcie_rd_reg32(struct btintel_pcie_data *data,
-- 
2.43.0

