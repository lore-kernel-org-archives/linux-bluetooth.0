Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DAF254705D
	for <linux-bluetooth@vger.kernel.org>; Fri, 18 Sep 2026 08:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789720953; cv=none; b=e0botTP90fzN1+DR1MitP1pPBADBbKvsuRCjtBauTieM88s52Bnb9RxWM+V3TxAMGG5vvN99dKGpq8UFTQfT3subzg+5sUohP+PdLworQxF4lVNSjgLMxtt/FqyyD+W9DQeQgdtz4aN4LVPbAVULOMkGO7GCupONU0ev/BW3L/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789720953; c=relaxed/simple;
	bh=LwRGBigrQxWEgWscFUr57wFYM+5K/bXakPX/dLGfT0M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TU+UZxIc0Fk9bR1i5+0ssTKN9/KQCxzmmIIp2E2K+wTZS141d7q9Wz7ehrOtHY1suK3JAlzaqptD3ZMNri2fpxqK3xEJjGWUa8YwNsu3bV5Hg4cFXw58tjpaJKGveqKm2zwriMCuo6OmsBr3A3c/+ps9LJz8AIS3AWUFYpNAbls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n4BNn7+9; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n4BNn7+9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789720951; x=1821256951;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=LwRGBigrQxWEgWscFUr57wFYM+5K/bXakPX/dLGfT0M=;
  b=n4BNn7+98ckfc4REPxab5LLbBprR8By3hTKx8v7+fV7mkWsgNYaXzEq1
   opY29nIDl9owW8UkFeHCTfOqUnEiDbLssfl7QORQfslbMbs63DkI9EBtd
   zciAGIwczi+02xV8dmzm5+y5GcX1Ij0th3ZXqXxoDSuo4Ofy7sYgzCW+8
   62N9Pxow/3nl9bf56rocIu3yctT81zov8Dr7dE1HPDTztpUeqfEnsLov4
   lZ0frCcSod+7Cwbspe/sL904GKRsWo6AKP3AzjY7+ClFDokwHGI16lJAe
   aJT9ULKTLBAYE2MzQ3NVuilZtu3uTfVgJRRpU8N77LGQWUNzw9JlQvCVK
   g==;
X-CSE-ConnectionGUID: CLWaMOpwTsWBeMDBEl2CCw==
X-CSE-MsgGUID: L+zLKe2KRVmR1kwFf+98iA==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="89142785"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="89142785"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2026 01:42:30 -0700
X-CSE-ConnectionGUID: 7FJq5H7zQn2HKn9yda5loQ==
X-CSE-MsgGUID: m2KfEt1SR6a7sKRaZkov2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="271618505"
Received: from unknown (HELO WEBA2062.iind.intel.com) ([10.66.228.2])
  by fmviesa008.fm.intel.com with ESMTP; 18 Sep 2026 01:42:27 -0700
From: Ravindra <ravindra@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: chethan.tumkur.narayan@intel.com,
	kiran.k@intel.com,
	Ravindra <ravindra@intel.com>,
	Paul Menzel <pmenzel@molgen.mpg.de>
Subject: [PATCH v3] Bluetooth: btintel: read ROM debug registers on FW download failure
Date: Fri, 18 Sep 2026 14:14:57 +0530
Message-ID: <20260918084457.2746999-1-ravindra@intel.com>
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
 drivers/bluetooth/btintel.c | 51 +++++++++++++++++++++++++++++++++++--
 drivers/bluetooth/btintel.h |  9 +++++++
 2 files changed, 58 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index e998fd390ad2..fc204c708f35 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -983,6 +983,41 @@ int btintel_send_intel_reset(struct hci_dev *hdev, u32 boot_param)
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
@@ -2232,6 +2267,9 @@ download:
 			goto done;
 		}
 
+		/* Collect rom debug info on FW download failure */
+		btintel_get_rom_debug_info(hdev);
+
 		/* When FW download fails, send Intel Reset to retry
 		 * FW download.
 		 */
@@ -2251,8 +2289,11 @@ download:
 	 * of this device.
 	 */
 	err = btintel_download_wait(hdev, calltime, INTEL_SLE_MULTIPLIER * 5000);
-	if (err == -ETIMEDOUT)
+	if (err == -ETIMEDOUT) {
+		/* Collect rom debug info on FW download failure */
+		btintel_get_rom_debug_info(hdev);
 		btintel_reset_to_bootloader(hdev);
+	}
 
 done:
 	release_firmware(fw);
@@ -2492,6 +2533,9 @@ static int btintel_prepare_fw_download_tlv(struct hci_dev *hdev,
 			goto done;
 		}
 
+		/* Collect rom debug info on FW download failure */
+		btintel_get_rom_debug_info(hdev);
+
 		/* When FW download fails, send Intel Reset to retry
 		 * FW download.
 		 */
@@ -2511,8 +2555,11 @@ static int btintel_prepare_fw_download_tlv(struct hci_dev *hdev,
 	 * of this device.
 	 */
 	err = btintel_download_wait(hdev, calltime, INTEL_SLE_MULTIPLIER * 5000);
-	if (err == -ETIMEDOUT)
+	if (err == -ETIMEDOUT) {
+		/* Collect rom debug info on FW download failure */
+		btintel_get_rom_debug_info(hdev);
 		btintel_reset_to_bootloader(hdev);
+	}
 
 done:
 	{
diff --git a/drivers/bluetooth/btintel.h b/drivers/bluetooth/btintel.h
index 586be92b7690..0f7261c102b8 100644
--- a/drivers/bluetooth/btintel.h
+++ b/drivers/bluetooth/btintel.h
@@ -188,6 +188,15 @@ struct hci_ppag_enable_cmd {
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

