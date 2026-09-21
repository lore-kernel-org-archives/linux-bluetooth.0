Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18009322C6D
	for <linux-bluetooth@vger.kernel.org>; Mon, 21 Sep 2026 05:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789969563; cv=none; b=D/fylXwWcpYGNyGcrLRwfrpzfy3YG78MZbrBA1ChAGyX4yFq1MGcREVzxd1bq5qO/bBAmtEJkoXDC8dde7aie/K5jzYsZQadpPEaM9uSgFuqUj7Ui982hzfevKNd7X/RDWirSnLxSV+E87rXBuFTH5CpmwwUP8g+NG8Waa8CDq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789969563; c=relaxed/simple;
	bh=gaCgaotaB83PkmtKcF1K2HZ0UBw3PUG1L0H+XZupjXk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KILY/C1tx4W9RbSjTCL7MiigcNOnbpPAUtOZyMCV0MXiwMUAViZ/vBhnI/HKf0Kv1cWcjP7v1MjMu26xSmOEQZ+MZj4L03fc5dccnYCEaMFT9z99REM232Z4ubFEFzHDBYpoXR7RcxAQLWQJCaqOvQmSI9HuXQ0IwuPL/5Gk+4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XkAZcVyd; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XkAZcVyd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789969561; x=1821505561;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=gaCgaotaB83PkmtKcF1K2HZ0UBw3PUG1L0H+XZupjXk=;
  b=XkAZcVydW/BthNsrjfrggRo3ed1tk1PAEdl08Bhs1z20Hhtfwemf+Pfg
   vM8rfrx648Wn/d8Mhz5oZGe1dRuYeP5t2UtZ0E9Hrj+3iP7MZHIMsMu93
   bAyqdgozRCueg/PyOsKuoSymt7x/JdydE7taHQAHZr84aVN8T75MJ0bBm
   PjoE0i4LrrCA30TdoyHVeBfAg4GFC8LzR4dnS6EP2GIJeFR3ap6m0OHuh
   jsaQ+pzQM8rn4nEQOgVOJT48rNGWD/UP7KtZ4hlHH8nj3kItB2un7iMSn
   FIxmqw5NZZ+gCiymzNLh+eyxJ1rqxmUbS5VndhpxqJsVvXma08vkeh7LN
   w==;
X-CSE-ConnectionGUID: OixBFdwfRbu8HvKRXkRl4w==
X-CSE-MsgGUID: 1O/WuHC0RmKJdwXmnFxBIA==
X-IronPort-AV: E=McAfee;i="6800,10657,11911"; a="89597940"
X-IronPort-AV: E=Sophos;i="6.27,114,1787036400"; 
   d="scan'208";a="89597940"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2026 22:46:01 -0700
X-CSE-ConnectionGUID: wlINagD5RiuKYXs5wFDmbg==
X-CSE-MsgGUID: RKaQZAJUTgKFL8UNeXFLug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,114,1787036400"; 
   d="scan'208";a="298761741"
Received: from unknown (HELO WEBA2062.iind.intel.com) ([10.66.228.2])
  by fmviesa002.fm.intel.com with ESMTP; 20 Sep 2026 22:45:59 -0700
From: Ravindra <ravindra@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: chethan.tumkur.narayan@intel.com,
	kiran.k@intel.com,
	Ravindra <ravindra@intel.com>,
	Paul Menzel <pmenzel@molgen.mpg.de>
Subject: [PATCH v3] Bluetooth: btintel: read ROM debug registers on FW download failure
Date: Mon, 21 Sep 2026 11:18:30 +0530
Message-ID: <20260921054830.2770046-1-ravindra@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The bootloader records init sequence progress and debug info in four
core debug registers, useful for debugging FW download failures.

Add btintel_get_rom_debug_info() to issue BTINTEL_GET_ROM_DEBUG_INFO
(0xfcde) and log these registers, and invoke it from every FW download
failure and timeout path: btintel_download_fw() (legacy .sfi flow) and
btintel_prepare_fw_download_tlv() (TLV flow), before resetting to the
bootloader.

Tested by corrupting the operational firmware file to force a
download timeout; the driver logged the debug registers on each
failure and retry, e.g.:

  Bluetooth: hci0: Firmware loading timeout
  Bluetooth: Intel get rom debug info: dr0:0x80000001 dr1:0x00000000 dr2:0x00000001 dr3:0x00df0071

Signed-off-by: Ravindra <ravindra@intel.com>
Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
---
 drivers/bluetooth/btintel.c | 47 +++++++++++++++++++++++++++++++++++--
 drivers/bluetooth/btintel.h |  9 +++++++
 2 files changed, 54 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index 964d2de30e65..5e6d1ddc99c6 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -963,6 +963,41 @@ int btintel_send_intel_reset(struct hci_dev *hdev, u32 boot_param)
 }
 EXPORT_SYMBOL_GPL(btintel_send_intel_reset);
 
+static void btintel_get_rom_debug_info(struct hci_dev *hdev)
+{
+	struct btintel_rp_get_rom_debug_info *rom_debug_info;
+	struct sk_buff *skb;
+
+	skb = __hci_cmd_sync(hdev, BTINTEL_GET_ROM_DEBUG_INFO, 0, NULL,
+			     HCI_CMD_TIMEOUT);
+	if (IS_ERR(skb)) {
+		bt_dev_err(hdev, "Failed to send Intel get rom debug info command (%ld)",
+			   PTR_ERR(skb));
+		return;
+	}
+
+	if (skb->len != sizeof(*rom_debug_info)) {
+		bt_dev_err(hdev,
+			   "Intel get rom debug info size mismatch (%u != %zu)",
+			   skb->len, sizeof(*rom_debug_info));
+		kfree_skb(skb);
+		return;
+	}
+
+	rom_debug_info = (struct btintel_rp_get_rom_debug_info *)skb->data;
+
+	/* A non-zero status here would have already been turned into an
+	 * error by the HCI core and reported via the IS_ERR(skb) check above.
+	 */
+	bt_dev_info(hdev, "Intel get rom debug info: dr0:0x%08x dr1:0x%08x dr2:0x%08x dr3:0x%08x",
+		    le32_to_cpu(rom_debug_info->debug_reg0),
+		    le32_to_cpu(rom_debug_info->debug_reg1),
+		    le32_to_cpu(rom_debug_info->debug_reg2),
+		    le32_to_cpu(rom_debug_info->debug_reg3));
+
+	kfree_skb(skb);
+}
+
 int btintel_read_boot_params(struct hci_dev *hdev,
 			     struct intel_boot_params *params)
 {
@@ -2212,6 +2247,8 @@ static int btintel_download_fw(struct hci_dev *hdev,
 			goto done;
 		}
 
+		btintel_get_rom_debug_info(hdev);
+
 		/* When FW download fails, send Intel Reset to retry
 		 * FW download.
 		 */
@@ -2231,8 +2268,10 @@ static int btintel_download_fw(struct hci_dev *hdev,
 	 * of this device.
 	 */
 	err = btintel_download_wait(hdev, calltime, 5000);
-	if (err == -ETIMEDOUT)
+	if (err == -ETIMEDOUT) {
+		btintel_get_rom_debug_info(hdev);
 		btintel_reset_to_bootloader(hdev);
+	}
 
 done:
 	release_firmware(fw);
@@ -2465,6 +2504,8 @@ static int btintel_prepare_fw_download_tlv(struct hci_dev *hdev,
 			goto done;
 		}
 
+		btintel_get_rom_debug_info(hdev);
+
 		/* When FW download fails, send Intel Reset to retry
 		 * FW download.
 		 */
@@ -2484,8 +2525,10 @@ static int btintel_prepare_fw_download_tlv(struct hci_dev *hdev,
 	 * of this device.
 	 */
 	err = btintel_download_wait(hdev, calltime, 5000);
-	if (err == -ETIMEDOUT)
+	if (err == -ETIMEDOUT) {
+		btintel_get_rom_debug_info(hdev);
 		btintel_reset_to_bootloader(hdev);
+	}
 
 done:
 	intel_data->cnvi_bt = ver->cnvi_bt;
diff --git a/drivers/bluetooth/btintel.h b/drivers/bluetooth/btintel.h
index c00f793d9dc8..b3c4c6f87424 100644
--- a/drivers/bluetooth/btintel.h
+++ b/drivers/bluetooth/btintel.h
@@ -178,6 +178,15 @@ struct hci_ppag_enable_cmd {
 	__le32	ppag_enable_flags;
 } __packed;
 
+#define BTINTEL_GET_ROM_DEBUG_INFO	0xfcde
+struct btintel_rp_get_rom_debug_info {
+	__u8	status;
+	__le32	debug_reg0;
+	__le32	debug_reg1;
+	__le32	debug_reg2;
+	__le32	debug_reg3;
+} __packed;
+
 #define INTEL_TLV_TYPE_ID		0x01
 
 #define INTEL_TLV_SYSTEM_EXCEPTION	0x00
-- 
2.43.0

