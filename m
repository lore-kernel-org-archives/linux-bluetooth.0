Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E377F1F4289
	for <linux-bluetooth@vger.kernel.org>; Tue, 12 Aug 2025 11:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754998236; cv=none; b=ZZCZghwJzCredi2S4qApJM+ZSKLjDeKcjpemPS03Wme5KAkJfI6aQktl+sd9v1fnJT6ODNvMHg60cVLxdtAYq0ZxXzUqOCYvkciK7gnnNk4YAgTM9ilmdqDqMnunw3/81MzSLYFzCLQSLWA3C4JWjU/dVozKD2YT4k3vvJY+jeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754998236; c=relaxed/simple;
	bh=YIGhS8Z3BQl+MNYrJv7gVppyt1Fcl9l1SRPJ3tKSmco=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dC6N4H5oiIMH7oV01vmJ29x63+M9px3EuEy1bWdXgUX/BX6ATMhmeyUuDcjC5Ee25wbPa8xaUfByDKrtpi+PGj03kTJU3oK3I8OF3bNfKyIiYSRutVNxc3ak+ahBGLMOlJV3QWOG39/MQziSmOg4rLJPj5fkZVPixsZtCHpY9nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C+YGbVxk; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C+YGbVxk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754998234; x=1786534234;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=YIGhS8Z3BQl+MNYrJv7gVppyt1Fcl9l1SRPJ3tKSmco=;
  b=C+YGbVxkrZLJOshRhD+frG/BBkkWoD6nKD7BRbwg3a9ImAompXcbwsuM
   kenAKb9Wtrb2acST7EizGYznFGTrH5nZwzUhm5o04NWB85LelpgwQ+b3y
   dtmJRWoLKPrt2QDN29E2wE7xL6rYPVxwomGU5w1sGKRRJMLcMnfVHdXlA
   3pldzDllhw1PkTzoE5Ak2QuIMhExE45CVGxEQrrZ0Y3JjwTYWUfxK2MX4
   FOKOVHU60szs8Cin7rcKR/FH5t7tsaCAQ3nVjWxsq1GFZYITPs55FKmFD
   oFM5VzEvksxuLpmAON892pDYU6j0qEYGLcddOR6ITSttdIQ/FYeVoTMHj
   g==;
X-CSE-ConnectionGUID: xT2ADYrEQquzrBq4eY4U3w==
X-CSE-MsgGUID: 7nDYAmfMRGagfqHeIQIHGA==
X-IronPort-AV: E=McAfee;i="6800,10657,11518"; a="68724677"
X-IronPort-AV: E=Sophos;i="6.17,284,1747724400"; 
   d="scan'208";a="68724677"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2025 04:30:33 -0700
X-CSE-ConnectionGUID: TcJH40CoQ/2JAxBw2dLocA==
X-CSE-MsgGUID: SWbZXPnCQPml1inoKQw56w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,284,1747724400"; 
   d="scan'208";a="171422310"
Received: from unknown (HELO intel-Lenovo-Legion-Y540-15IRH-PG0.iind.intel.com) ([10.224.186.95])
  by fmviesa004.fm.intel.com with ESMTP; 12 Aug 2025 04:30:30 -0700
From: Kiran K <kiran.k@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: ravishankar.srivatsa@intel.com,
	chandrashekar.devegowda@intel.com,
	chethan.tumkur.narayan@intel.com,
	Kiran K <kiran.k@intel.com>,
	Paul Menzel <pmenzel@molgen.mpg.de>
Subject: [PATCH v3 1/2] Bluetooth: btintel_pcie: Refactor Device Coredump
Date: Tue, 12 Aug 2025 17:17:03 +0530
Message-ID: <20250812114704.1596969-1-kiran.k@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Device coredumps do not include HCI traces, so the dependency on
hdev_devcd*() for generating device coredumps has been removed. In the
current implementation, firmware traces are embedded in skb and sent to
the host for coredump processing. This refactor updates the driver to
use devcore_dumpv() to generate coredumps directly, streamlining the
process.

Test:
1. cd /sys/bus/pci/devices/0000:00:14.7/
2. echo 1 > coredump
3. check /sys/class/devcoredump/ to device coredump folder

Fixes: 07e6bddb54b4 ("Bluetooth: btintel_pcie: Add support for device coredump")
Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
Signed-off-by: Kiran K <kiran.k@intel.com>
---
changes in v3:
  - Make a seperate patch to include vendor and driver name in device coredump

changes in v2:
  - Fix compiler warning reported by android toolchain

 drivers/bluetooth/btintel_pcie.c | 211 ++++++++++---------------------
 1 file changed, 65 insertions(+), 146 deletions(-)

diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index 22a2953adbd6..a78e24aa5e38 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -15,6 +15,7 @@
 #include <linux/interrupt.h>
 
 #include <linux/unaligned.h>
+#include <linux/devcoredump.h>
 
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
@@ -559,25 +560,6 @@ static void btintel_pcie_mac_init(struct btintel_pcie_data *data)
 	btintel_pcie_wr_reg32(data, BTINTEL_PCIE_CSR_FUNC_CTRL_REG, reg);
 }
 
-static int btintel_pcie_add_dmp_data(struct hci_dev *hdev, const void *data, int size)
-{
-	struct sk_buff *skb;
-	int err;
-
-	skb = alloc_skb(size, GFP_ATOMIC);
-	if (!skb)
-		return -ENOMEM;
-
-	skb_put_data(skb, data, size);
-	err = hci_devcd_append(hdev, skb);
-	if (err) {
-		bt_dev_err(hdev, "Failed to append data in the coredump");
-		return err;
-	}
-
-	return 0;
-}
-
 static int btintel_pcie_get_mac_access(struct btintel_pcie_data *data)
 {
 	u32 reg;
@@ -622,30 +604,33 @@ static void btintel_pcie_release_mac_access(struct btintel_pcie_data *data)
 	btintel_pcie_wr_reg32(data, BTINTEL_PCIE_CSR_FUNC_CTRL_REG, reg);
 }
 
-static void btintel_pcie_copy_tlv(struct sk_buff *skb, enum btintel_pcie_tlv_type type,
-				  void *data, int size)
+static void *btintel_pcie_copy_tlv(void *dest, enum btintel_pcie_tlv_type type,
+				   void *data, size_t size)
 {
 	struct intel_tlv *tlv;
 
-	tlv = skb_put(skb, sizeof(*tlv) + size);
+	tlv = dest;
 	tlv->type = type;
 	tlv->len = size;
 	memcpy(tlv->val, data, tlv->len);
+	return dest + sizeof(*tlv) + size;
 }
 
 static int btintel_pcie_read_dram_buffers(struct btintel_pcie_data *data)
 {
-	u32 offset, prev_size, wr_ptr_status, dump_size, i;
+	u32 offset, prev_size, wr_ptr_status, dump_size, data_len;
 	struct btintel_pcie_dbgc *dbgc = &data->dbgc;
-	u8 buf_idx, dump_time_len, fw_build;
 	struct hci_dev *hdev = data->hdev;
+	u8 *pdata, *p, buf_idx;
 	struct intel_tlv *tlv;
 	struct timespec64 now;
-	struct sk_buff *skb;
 	struct tm tm_now;
-	char buf[256];
-	u16 hdr_len;
-	int ret;
+	char fw_build[128];
+	char ts[128];
+
+	if (!IS_ENABLED(CONFIG_DEV_COREDUMP))
+		return -EOPNOTSUPP;
+
 
 	wr_ptr_status = btintel_pcie_rd_dev_mem(data, BTINTEL_PCIE_DBGC_CUR_DBGBUFF_STATUS);
 	offset = wr_ptr_status & BTINTEL_PCIE_DBG_OFFSET_BIT_MASK;
@@ -664,92 +649,79 @@ static int btintel_pcie_read_dram_buffers(struct btintel_pcie_data *data)
 
 	ktime_get_real_ts64(&now);
 	time64_to_tm(now.tv_sec, 0, &tm_now);
-	dump_time_len = snprintf(buf, sizeof(buf), "Dump Time: %02d-%02d-%04ld %02d:%02d:%02d",
+	snprintf(ts, sizeof(ts), "Dump Time: %02d-%02d-%04ld %02d:%02d:%02d",
 				 tm_now.tm_mday, tm_now.tm_mon + 1, tm_now.tm_year + 1900,
 				 tm_now.tm_hour, tm_now.tm_min, tm_now.tm_sec);
 
-	fw_build = snprintf(buf + dump_time_len, sizeof(buf) - dump_time_len,
+	snprintf(fw_build, sizeof(fw_build),
 			    "Firmware Timestamp: Year %u WW %02u buildtype %u build %u",
 			    2000 + (data->dmp_hdr.fw_timestamp >> 8),
 			    data->dmp_hdr.fw_timestamp & 0xff, data->dmp_hdr.fw_build_type,
 			    data->dmp_hdr.fw_build_num);
 
-	hdr_len = sizeof(*tlv) + sizeof(data->dmp_hdr.cnvi_bt) +
-		  sizeof(*tlv) + sizeof(data->dmp_hdr.write_ptr) +
-		  sizeof(*tlv) + sizeof(data->dmp_hdr.wrap_ctr) +
-		  sizeof(*tlv) + sizeof(data->dmp_hdr.trigger_reason) +
-		  sizeof(*tlv) + sizeof(data->dmp_hdr.fw_git_sha1) +
-		  sizeof(*tlv) + sizeof(data->dmp_hdr.cnvr_top) +
-		  sizeof(*tlv) + sizeof(data->dmp_hdr.cnvi_top) +
-		  sizeof(*tlv) + dump_time_len +
-		  sizeof(*tlv) + fw_build;
+	data_len = sizeof(*tlv) + sizeof(data->dmp_hdr.cnvi_bt) +
+		sizeof(*tlv) + sizeof(data->dmp_hdr.write_ptr) +
+		sizeof(*tlv) + sizeof(data->dmp_hdr.wrap_ctr) +
+		sizeof(*tlv) + sizeof(data->dmp_hdr.trigger_reason) +
+		sizeof(*tlv) + sizeof(data->dmp_hdr.fw_git_sha1) +
+		sizeof(*tlv) + sizeof(data->dmp_hdr.cnvr_top) +
+		sizeof(*tlv) + sizeof(data->dmp_hdr.cnvi_top) +
+		sizeof(*tlv) + strlen(ts) +
+		sizeof(*tlv) + strlen(fw_build);
 
-	dump_size = hdr_len + sizeof(hdr_len);
+	/*
+	 * sizeof(u32) - signature
+	 * sizeof(data_len) - to store tlv data size
+	 * data_len - TLV data
+	 */
+	dump_size = sizeof(u32) + sizeof(data_len) + data_len;
 
-	skb = alloc_skb(dump_size, GFP_KERNEL);
-	if (!skb)
-		return -ENOMEM;
 
 	/* Add debug buffers data length to dump size */
 	dump_size += BTINTEL_PCIE_DBGC_BUFFER_SIZE * dbgc->count;
 
-	ret = hci_devcd_init(hdev, dump_size);
-	if (ret) {
-		bt_dev_err(hdev, "Failed to init devcoredump, err %d", ret);
-		kfree_skb(skb);
-		return ret;
-	}
+	pdata = vmalloc(dump_size);
+	if (!pdata)
+		return -ENOMEM;
+	p = pdata;
 
-	skb_put_data(skb, &hdr_len, sizeof(hdr_len));
+	*(u32 *)p = BTINTEL_PCIE_MAGIC_NUM;
+	p += sizeof(u32);
 
-	btintel_pcie_copy_tlv(skb, BTINTEL_CNVI_BT, &data->dmp_hdr.cnvi_bt,
-			      sizeof(data->dmp_hdr.cnvi_bt));
+	*(u32 *)p = data_len;
+	p += sizeof(u32);
 
-	btintel_pcie_copy_tlv(skb, BTINTEL_WRITE_PTR, &data->dmp_hdr.write_ptr,
-			      sizeof(data->dmp_hdr.write_ptr));
+	p = btintel_pcie_copy_tlv(p, BTINTEL_DUMP_TIME, ts, strlen(ts));
+	p = btintel_pcie_copy_tlv(p, BTINTEL_FW_BUILD, fw_build,
+				  strlen(fw_build));
+	p = btintel_pcie_copy_tlv(p, BTINTEL_CNVI_BT, &data->dmp_hdr.cnvi_bt,
+				  sizeof(data->dmp_hdr.cnvi_bt));
+	p = btintel_pcie_copy_tlv(p, BTINTEL_WRITE_PTR, &data->dmp_hdr.write_ptr,
+				  sizeof(data->dmp_hdr.write_ptr));
+	p = btintel_pcie_copy_tlv(p, BTINTEL_WRAP_CTR, &data->dmp_hdr.wrap_ctr,
+				  sizeof(data->dmp_hdr.wrap_ctr));
 
 	data->dmp_hdr.wrap_ctr = btintel_pcie_rd_dev_mem(data,
 							 BTINTEL_PCIE_DBGC_DBGBUFF_WRAP_ARND);
 
-	btintel_pcie_copy_tlv(skb, BTINTEL_WRAP_CTR, &data->dmp_hdr.wrap_ctr,
-			      sizeof(data->dmp_hdr.wrap_ctr));
-
-	btintel_pcie_copy_tlv(skb, BTINTEL_TRIGGER_REASON, &data->dmp_hdr.trigger_reason,
-			      sizeof(data->dmp_hdr.trigger_reason));
-
-	btintel_pcie_copy_tlv(skb, BTINTEL_FW_SHA, &data->dmp_hdr.fw_git_sha1,
-			      sizeof(data->dmp_hdr.fw_git_sha1));
-
-	btintel_pcie_copy_tlv(skb, BTINTEL_CNVR_TOP, &data->dmp_hdr.cnvr_top,
-			      sizeof(data->dmp_hdr.cnvr_top));
-
-	btintel_pcie_copy_tlv(skb, BTINTEL_CNVI_TOP, &data->dmp_hdr.cnvi_top,
-			      sizeof(data->dmp_hdr.cnvi_top));
-
-	btintel_pcie_copy_tlv(skb, BTINTEL_DUMP_TIME, buf, dump_time_len);
-
-	btintel_pcie_copy_tlv(skb, BTINTEL_FW_BUILD, buf + dump_time_len, fw_build);
-
-	ret = hci_devcd_append(hdev, skb);
-	if (ret)
-		goto exit_err;
-
-	for (i = 0; i < dbgc->count; i++) {
-		ret = btintel_pcie_add_dmp_data(hdev, dbgc->bufs[i].data,
-						BTINTEL_PCIE_DBGC_BUFFER_SIZE);
-		if (ret)
-			break;
-	}
-
-exit_err:
-	hci_devcd_complete(hdev);
-	return ret;
+	p = btintel_pcie_copy_tlv(p, BTINTEL_TRIGGER_REASON, &data->dmp_hdr.trigger_reason,
+				  sizeof(data->dmp_hdr.trigger_reason));
+	p = btintel_pcie_copy_tlv(p, BTINTEL_FW_SHA, &data->dmp_hdr.fw_git_sha1,
+				  sizeof(data->dmp_hdr.fw_git_sha1));
+	p = btintel_pcie_copy_tlv(p, BTINTEL_CNVR_TOP, &data->dmp_hdr.cnvr_top,
+				  sizeof(data->dmp_hdr.cnvr_top));
+	p = btintel_pcie_copy_tlv(p, BTINTEL_CNVI_TOP, &data->dmp_hdr.cnvi_top,
+				  sizeof(data->dmp_hdr.cnvi_top));
+
+	memcpy(p, dbgc->bufs[0].data, dbgc->count * BTINTEL_PCIE_DBGC_BUFFER_SIZE);
+	dev_coredumpv(&hdev->dev, pdata, dump_size, GFP_KERNEL);
+	return 0;
 }
 
 static void btintel_pcie_dump_traces(struct hci_dev *hdev)
 {
 	struct btintel_pcie_data *data = hci_get_drvdata(hdev);
-	int ret = 0;
+	int ret;
 
 	ret = btintel_pcie_get_mac_access(data);
 	if (ret) {
@@ -765,51 +737,6 @@ static void btintel_pcie_dump_traces(struct hci_dev *hdev)
 		bt_dev_err(hdev, "Failed to dump traces: (%d)", ret);
 }
 
-static void btintel_pcie_dump_hdr(struct hci_dev *hdev, struct sk_buff *skb)
-{
-	struct btintel_pcie_data *data = hci_get_drvdata(hdev);
-	u16 len = skb->len;
-	u16 *hdrlen_ptr;
-	char buf[80];
-
-	hdrlen_ptr = skb_put_zero(skb, sizeof(len));
-
-	snprintf(buf, sizeof(buf), "Controller Name: 0x%X\n",
-		 INTEL_HW_VARIANT(data->dmp_hdr.cnvi_bt));
-	skb_put_data(skb, buf, strlen(buf));
-
-	snprintf(buf, sizeof(buf), "Firmware Build Number: %u\n",
-		 data->dmp_hdr.fw_build_num);
-	skb_put_data(skb, buf, strlen(buf));
-
-	snprintf(buf, sizeof(buf), "Driver: %s\n", data->dmp_hdr.driver_name);
-	skb_put_data(skb, buf, strlen(buf));
-
-	snprintf(buf, sizeof(buf), "Vendor: Intel\n");
-	skb_put_data(skb, buf, strlen(buf));
-
-	*hdrlen_ptr = skb->len - len;
-}
-
-static void btintel_pcie_dump_notify(struct hci_dev *hdev, int state)
-{
-	struct btintel_pcie_data *data = hci_get_drvdata(hdev);
-
-	switch (state) {
-	case HCI_DEVCOREDUMP_IDLE:
-		data->dmp_hdr.state = HCI_DEVCOREDUMP_IDLE;
-		break;
-	case HCI_DEVCOREDUMP_ACTIVE:
-		data->dmp_hdr.state = HCI_DEVCOREDUMP_ACTIVE;
-		break;
-	case HCI_DEVCOREDUMP_TIMEOUT:
-	case HCI_DEVCOREDUMP_ABORT:
-	case HCI_DEVCOREDUMP_DONE:
-		data->dmp_hdr.state = HCI_DEVCOREDUMP_IDLE;
-		break;
-	}
-}
-
 /* This function enables BT function by setting BTINTEL_PCIE_CSR_FUNC_CTRL_MAC_INIT bit in
  * BTINTEL_PCIE_CSR_FUNC_CTRL_REG register and wait for MSI-X with
  * BTINTEL_PCIE_MSIX_HW_INT_CAUSES_GP0.
@@ -1383,6 +1310,11 @@ static void btintel_pcie_rx_work(struct work_struct *work)
 					struct btintel_pcie_data, rx_work);
 	struct sk_buff *skb;
 
+	if (test_bit(BTINTEL_PCIE_COREDUMP_INPROGRESS, &data->flags)) {
+		btintel_pcie_dump_traces(data->hdev);
+		clear_bit(BTINTEL_PCIE_COREDUMP_INPROGRESS, &data->flags);
+	}
+
 	if (test_bit(BTINTEL_PCIE_HWEXP_INPROGRESS, &data->flags)) {
 		/* Unlike usb products, controller will not send hardware
 		 * exception event on exception. Instead controller writes the
@@ -1395,11 +1327,6 @@ static void btintel_pcie_rx_work(struct work_struct *work)
 		clear_bit(BTINTEL_PCIE_HWEXP_INPROGRESS, &data->flags);
 	}
 
-	if (test_bit(BTINTEL_PCIE_COREDUMP_INPROGRESS, &data->flags)) {
-		btintel_pcie_dump_traces(data->hdev);
-		clear_bit(BTINTEL_PCIE_COREDUMP_INPROGRESS, &data->flags);
-	}
-
 	/* Process the sk_buf in queue and send to the HCI layer */
 	while ((skb = skb_dequeue(&data->rx_skb_q))) {
 		btintel_pcie_recv_frame(data, skb);
@@ -2190,13 +2117,6 @@ static int btintel_pcie_setup_internal(struct hci_dev *hdev)
 	if (ver_tlv.img_type == 0x02 || ver_tlv.img_type == 0x03)
 		data->dmp_hdr.fw_git_sha1 = ver_tlv.git_sha1;
 
-	err = hci_devcd_register(hdev, btintel_pcie_dump_traces, btintel_pcie_dump_hdr,
-				 btintel_pcie_dump_notify);
-	if (err) {
-		bt_dev_err(hdev, "Failed to register coredump (%d)", err);
-		goto exit_error;
-	}
-
 	btintel_print_fseq_info(hdev);
 exit_error:
 	kfree_skb(skb);
@@ -2325,7 +2245,6 @@ static void btintel_pcie_removal_work(struct work_struct *wk)
 	btintel_pcie_synchronize_irqs(data);
 
 	flush_work(&data->rx_work);
-	flush_work(&data->hdev->dump.dump_rx);
 
 	bt_dev_dbg(data->hdev, "Release bluetooth interface");
 	btintel_pcie_release_hdev(data);
-- 
2.43.0

