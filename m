Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E68F7227EA4
	for <linux-bluetooth@vger.kernel.org>; Mon, 21 Sep 2026 13:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789996117; cv=none; b=dIY7aBUOS1o/lHVxhkJNWJSsM2F5kw3a/RYssO7eAzdm88n5A2AwPZv+Q3HQ9xMe8cB/8XrIvrb586q7WUD1jFM+q7pDIjBupeB0Z+fsmKaOYN657nzAE1K+zB6fWArRl3fI8bxVlEx9pE2424jr6bd5Yb/tHWyVAx8bD4UxnnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789996117; c=relaxed/simple;
	bh=LkKakujwcPUQR+XrosoWkAAi2FZIrwiqzGRftWukX4I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sBnDY6flC1UhbBk6mimbxDlCd9ZbRt0Ein3eO3CG+c5w8+A3PWIXzO3NCpyXou+Drz+uyc4AYZjTda7CPDHOoESAUoKQslGdWc++ZPrEjPm+PQeObI7o5gGSBoWLz+PyKxgdolqfURKVzWtoRbudSME6zfWFCpBP4HNEF0hOBT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KK5KnXk6; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KK5KnXk6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789996115; x=1821532115;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=LkKakujwcPUQR+XrosoWkAAi2FZIrwiqzGRftWukX4I=;
  b=KK5KnXk6q9dc3NxvOgH1C3GcT7LtaTgZgbDpz9oXqlnuAzCoB5YofqES
   QNQ/3Fjdg98O+BmsVFlV/WaYYG39QE7s5GVfHxk+KjH5mLw1sKuwk5enb
   crjAwKvom3BNVsf3yszRAFNCvqsLvjedZSvYAwbKB/huB/Feyo9Yd3Zef
   Nxn33HWGr3OUg13T4OC6wEvjmhisL+4Uxlg8rBAXx7LbpFoVhr/CACIpb
   2RdmkqdQ6fJ0SyUjPBlLbMdlHz6sERX6idviRLYp7VubeFMROe6hL/md6
   zttZGhZfv8Dtv6IFS4Gmg5c80/bvl743guO9O1Cxi13lbbuhIEwmfYEOC
   g==;
X-CSE-ConnectionGUID: cKOO4xXcTSmoqgI4/QKxEQ==
X-CSE-MsgGUID: VB1ob+UnShy7TKf5DZE0ww==
X-IronPort-AV: E=McAfee;i="6800,10657,11911"; a="101166528"
X-IronPort-AV: E=Sophos;i="6.27,114,1787036400"; 
   d="scan'208";a="101166528"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2026 06:08:17 -0700
X-CSE-ConnectionGUID: U5EWLFLIQ3iPmPGyBtkHHw==
X-CSE-MsgGUID: Fa9ckdGgQHaivjiCJrCcng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,114,1787036400"; 
   d="scan'208";a="300583028"
Received: from unknown (HELO WEBA2062.iind.intel.com) ([10.66.228.2])
  by fmviesa001.fm.intel.com with ESMTP; 21 Sep 2026 06:08:15 -0700
From: Ravindra <ravindra@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: chethan.tumkur.narayan@intel.com,
	kiran.k@intel.com,
	Ravindra <ravindra@intel.com>,
	Paul Menzel <pmenzel@molgen.mpg.de>
Subject: [PATCH v3] Bluetooth: btintel: read ROM debug registers on FW download failure
Date: Mon, 21 Sep 2026 18:40:47 +0530
Message-ID: <20260921131047.2780402-1-ravindra@intel.com>
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
  Bluetooth: Intel get rom debug info:
    dr0:0x80000001 dr1:0x00000000 dr2:0x00000001 dr3:0x00df0071

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

