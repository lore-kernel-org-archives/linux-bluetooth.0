Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26CF95C613
	for <linux-bluetooth@vger.kernel.org>; Fri, 18 Sep 2026 06:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789711273; cv=none; b=o61AWGWZ842aKBdWueHbpjiKNzOla3F1URFHryyRvy2W/LZsAq0GFOtDLR56T/iA+eCnTry0qgwFqXo8/1tTVjjljlOVJIyQjY5BzTPdnNKd1SwrC61yA7ZTFbx+1V/x0GoRdeR/LLrySxwKLXQkxtbFjhiyXSomzHSzdlXItuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789711273; c=relaxed/simple;
	bh=L1hyg7PvBcrXGVvoJZhZ3USMgc8rFLrkKrlawhh4E0Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=t1AkaTvwHNz5vrKtDE/PehlsQ42bKXMhCaVO/O+cl5EyWBZGD706mW0xZWw1RpVl4KYEQRFRab0hYsI5y1rB9b2jI9GXpEtPCaQleDWhj7QcFxCQm3OoHa3jz60xhyH6Ww4ThzicLCQCfaT7S2hGv1v62iMY4JbSjpW7JpcZgAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mauv18sn; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mauv18sn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789711272; x=1821247272;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=L1hyg7PvBcrXGVvoJZhZ3USMgc8rFLrkKrlawhh4E0Y=;
  b=mauv18snAXW0KtOq8pGszZCesYRQ7BS8ZsAcwFS7mMqMobujjTcAW6S8
   sZ3EVXa+UVX1U0VJ2MNhnIjOBZOVyLOG0s3Ch0JzDYld4eN8B93dhxEXZ
   0b4OsOAY4qWqYFt01FsMtp47luvgxav/38EF3qom/YhSRqUy67cQgUZ+T
   udTMuaV66jxbB/zKLY4gBC4hD8DGrTXv0bLO7mmLmvLxPUPFNJuIdZ5vQ
   yghYkDuNXAi0WFakKIWS+zIlEcHrIX2k2eWobK6nxsy2yWvJ13pzHoQYz
   trZG1yittLpMAqwGBpMYPwF/mzY+mZfRcESQKIuoMwjYhuXKLZN1Ueg6p
   A==;
X-CSE-ConnectionGUID: d6Wjp/9FQC+pZHHxJWMaDQ==
X-CSE-MsgGUID: TUX/dWwWS7CcfbmfFu0Lbw==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="90327162"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="90327162"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2026 23:01:08 -0700
X-CSE-ConnectionGUID: AEEzu3CDQ8aFv5Eqyi+AUQ==
X-CSE-MsgGUID: qIY3O+HmTXq2tykkp8rYvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="2411835"
Received: from unknown (HELO WEBA2062.iind.intel.com) ([10.66.228.2])
  by fmviesa012.fm.intel.com with ESMTP; 17 Sep 2026 23:01:07 -0700
From: Ravindra <ravindra@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: chethan.tumkur.narayan@intel.com,
	kiran.k@intel.com,
	Ravindra <ravindra@intel.com>,
	Paul Menzel <pmenzel@molgen.mpg.de>
Subject: [PATCH v2] Bluetooth: btintel: read ROM debug registers on FW download failure
Date: Fri, 18 Sep 2026 11:33:36 +0530
Message-ID: <20260918060336.2740434-1-ravindra@intel.com>
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
(0xfcde) and log these registers, invoked from the error path in
btintel_prepare_fw_download_tlv() before resetting to the bootloader.

Tested by corrupting the operational firmware file to force a
download timeout; the driver logged the debug registers on each
failure and retry, e.g.:

  Bluetooth: hci0: Firmware loading timeout
  Bluetooth: Intel get rom debug info: dr0:0x80000001 dr1:0x00000000 dr2:0x00000001 dr3:0x00df0071

Signed-off-by: Ravindra <ravindra@intel.com>
Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
---
 drivers/bluetooth/btintel.c | 42 ++++++++++++++++++++++++++++++++++++-
 drivers/bluetooth/btintel.h |  9 ++++++++
 2 files changed, 50 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index 964d2de30e65..c78d507f4380 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -963,6 +963,40 @@ int btintel_send_intel_reset(struct hci_dev *hdev, u32 boot_param)
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
+		bt_dev_err(hdev, "Failed to send intel get rom debug info command (%ld)",
+			   PTR_ERR(skb));
+		return;
+	}
+
+	if (skb->len != sizeof(*rom_debug_info)) {
+		bt_dev_err(hdev, "Intel get rom debug info command parameters size mismatch (%u != %zu)",
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
@@ -2231,8 +2265,11 @@ static int btintel_download_fw(struct hci_dev *hdev,
 	 * of this device.
 	 */
 	err = btintel_download_wait(hdev, calltime, 5000);
-	if (err == -ETIMEDOUT)
+	if (err == -ETIMEDOUT) {
+		/* FW download timed out, collect rom debug info */
+		btintel_get_rom_debug_info(hdev);
 		btintel_reset_to_bootloader(hdev);
+	}
 
 done:
 	release_firmware(fw);
@@ -2465,6 +2502,9 @@ static int btintel_prepare_fw_download_tlv(struct hci_dev *hdev,
 			goto done;
 		}
 
+		/* FW download failed, collect rom debug info */
+		btintel_get_rom_debug_info(hdev);
+
 		/* When FW download fails, send Intel Reset to retry
 		 * FW download.
 		 */
diff --git a/drivers/bluetooth/btintel.h b/drivers/bluetooth/btintel.h
index c00f793d9dc8..dedda3e77487 100644
--- a/drivers/bluetooth/btintel.h
+++ b/drivers/bluetooth/btintel.h
@@ -178,6 +178,15 @@ struct hci_ppag_enable_cmd {
 	__le32	ppag_enable_flags;
 } __packed;
 
+#define BTINTEL_GET_ROM_DEBUG_INFO	0xFCDE
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

