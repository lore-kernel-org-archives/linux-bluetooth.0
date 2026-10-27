Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793079883;
	b=T3xMuo4+M+3YtIFAAcWmY3+LZFGg2T3IVht+5LqDUqX5XgQ8WkbTqKV0l+PHKg1ZSHq/
	 QbgB8CCoEimD5zSqMNnrxzivQ4BSvbXLy1LCNHTfAiOSd3q47Bx99FJEYE9FIa8QwGrJs
	 q5jOVEaheyZWdabiP8ujf291Bzy00KBRICaESO/2ZU6MB1PQzZPSLRpoClLGv+eTY0h4T
	 cROG7aaytv03M2+ZH3YwalqTY179F9qehX0XcVyO0o4wbisvzmcpZ0MHKpOD4fxpn3NZK
	 N8ulosCbsgPlUcGYaRLH7epIdq0CpQuUVRfpwNRTXHLJt8gtOskS11MKt09BWXjL4ZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793079883;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=7ta212U/g8gwqHDmGcYaShLLHe+pGsZ8xbuHgSknCW8=;
	b=sd7V1Nt1ibq13ISRVVdsc7ATwLxjlSz3nDIvo0ieEiIknWuZjEsyLrVO73s2X50Bibfy
	 owS0r7CqUIsbBqL0gE3WM/JjiY2DuCj0MirF9D3AGPsT0CtT5LIAOXfA2sT4V79vTZdo1
	 TuXeADgT+Y8XlbI/5lp0GNrBAgL2XrMG8MF6CSSJVcIIy2jyJgIx9emTnJT8iB8txslhE
	 LeFBtRLFE9wb0TBOU7PTASqYc9rk1zUMxALPZJzIIU/7pQhtIqzJKdkMohg42MB4En5Zc
	 EWGVqC+a89pEo16vsZMpyz24PRLXy1QBI2XDZq5OHx3RMZqRTc3FBv/Z5MMOzz8uNaA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=DV1tPYMy;
	arc=none smtp.remote-ip=192.198.163.12
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 745B3606A31E
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Oct 2026 05:44:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 745B3606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=DV1tPYMy
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793079882; x=1824615882;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=M4oOOFuK+2T8GUYUbhEO+rk6H7uANLLOnSUVkEq+8XU=;
  b=DV1tPYMy8gLDA6Yii7GWP3da9ttV/NcNfks2ohGZkklH2XBp2CkxNFZq
   Cg9BvCpjN4AsiMmMKczGwsT/vFpqLOd1wCbJNerI2+JK2MDYwOCMy9scS
   3FdkeE+QhgRhnz7SRqYbKJawDqSCMccOlvrik20z2pYIl8c+gpij4beHW
   YREp8IyfiQa7ygGQ7ZriN0yryjCyqnXc5asFFfPaacfIn8hnYGhybTYWv
   wTPfe9zC+zDMAskaW3pJzJHEOJeYOmwDXFaAC9A4cPilB4B3TAoxf1iSy
   0fZiiiK3X5Ksy3FnocMZC06I3Ic/d8AMzpQSO624An15p92urDm3k+d/W
   g==;
X-CSE-ConnectionGUID: yw8QG6QPSnSpGcaafcrcKw==
X-CSE-MsgGUID: ILM02Z4nQ8Gq8kS7pLa8qw==
X-IronPort-AV: E=McAfee;i="6800,10657,11947"; a="1672593"
X-IronPort-AV: E=Sophos;i="6.27,180,1787036400"; 
   d="scan'208";a="1672593"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 22:44:41 -0700
X-CSE-ConnectionGUID: xgyV0RsbR7a8vPB0y1l/XQ==
X-CSE-MsgGUID: X+oBwquxRnydSInHifTUWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,180,1787036400"; 
   d="scan'208";a="4495595"
Received: from weba0957.iind.intel.com (HELO WEBA0932.iind.intel.com) ([10.224.186.34])
  by fmviesa004.fm.intel.com with ESMTP; 26 Oct 2026 22:44:40 -0700
From: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: chethan.tumkur.narayan@intel.com,
	kiran.k@intel.com,
	Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>
Subject: [PATCH v3 1/2] Bluetooth: btintel: Add TOP silent reset hooks
Date: Tue, 27 Oct 2026 11:14:07 +0530
Message-ID: <20261027054408.318002-1-chandrashekar.devegowda@intel.com>
X-Mailer: git-send-email 2.43.0
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

Add an INTEL_TOP_RESET flag so btintel_boot() returns -ECANCELED and
the transport can run its own TOP silent reset instead of the Intel
soft reset. Cache boot_addr in struct btintel_data for the replay.

No functional change on its own.

Signed-off-by: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>
---
Changes in v3:
- Rebase onto current bluetooth-next; fail TOP reset setup if the
  device is already in the operational image, falling back to PLDR.

Changes in v2:
- Check INTEL_TOP_RESET directly in btintel_boot() instead of a
  separate pending helper; clear the cached boot_addr on version read.

v2: https://lore.kernel.org/linux-bluetooth/20261023094033.212251-1-chandrashekar.devegowda@intel.com/
v1: https://lore.kernel.org/linux-bluetooth/20261014114752.174669-1-chandrashekar.devegowda@intel.com/

 drivers/bluetooth/btintel.c | 30 +++++++++++++++++++++++++++++-
 drivers/bluetooth/btintel.h |  2 ++
 2 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index 929018428c19..912cb025b76c 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -1260,6 +1260,12 @@ static bool btintel_firmware_version(struct hci_dev *hdev,
 {
 	const u8 *fw_ptr;
 
+	if (hdev->bus == HCI_PCI) {
+		struct btintel_data *data = hci_get_priv(hdev);
+
+		data->boot_addr = 0;
+	}
+
 	fw_ptr = fw->data;
 
 	while (fw_ptr - fw->data < fw->size) {
@@ -1277,6 +1283,12 @@ static bool btintel_firmware_version(struct hci_dev *hdev,
 
 			*boot_addr = le32_to_cpu(params->boot_addr);
 
+			if (hdev->bus == HCI_PCI) {
+				struct btintel_data *data = hci_get_priv(hdev);
+
+				data->boot_addr = *boot_addr;
+			}
+
 			bt_dev_info(hdev, "Boot Address: 0x%x", *boot_addr);
 
 			bt_dev_info(hdev, "Firmware Version: %u-%u.%u",
@@ -2086,6 +2098,13 @@ static int btintel_boot(struct hci_dev *hdev, u32 boot_addr)
 	ktime_t calltime;
 	int err;
 
+	/* Let the transport replace the Intel soft reset for a TOP reset */
+	if (hdev->bus == HCI_PCI &&
+	    btintel_test_flag(hdev, INTEL_TOP_RESET)) {
+		bt_dev_info(hdev, "TOP reset pending, skipping Intel soft reset");
+		return -ECANCELED;
+	}
+
 	calltime = ktime_get();
 
 	btintel_set_flag(hdev, INTEL_BOOTING);
@@ -3571,6 +3590,7 @@ int btintel_bootloader_setup_tlv(struct hci_dev *hdev,
 	struct intel_version_tlv new_ver;
 	struct btintel_data *data = hci_get_priv(hdev);
 	u8 hw_variant = INTEL_HW_VARIANT(ver->cnvi_bt);
+	bool top_reset = btintel_test_flag(hdev, INTEL_TOP_RESET);
 
 	bt_dev_dbg(hdev, "");
 
@@ -3587,6 +3607,9 @@ int btintel_bootloader_setup_tlv(struct hci_dev *hdev,
 	for (int i = 0; i < __INTEL_NUM_FLAGS; i++)
 		btintel_clear_flag(hdev, i);
 
+	if (top_reset)
+		btintel_set_flag(hdev, INTEL_TOP_RESET);
+
 	btintel_set_flag(hdev, INTEL_BOOTLOADER);
 
 	data->unlocker = false;
@@ -3619,8 +3642,13 @@ int btintel_bootloader_setup_tlv(struct hci_dev *hdev,
 		return err;
 
 	/* check if controller is already having an operational firmware */
-	if (ver->img_type == BTINTEL_IMG_OP)
+	if (ver->img_type == BTINTEL_IMG_OP) {
+		if (top_reset) {
+			bt_dev_err(hdev, "TOP reset requested on operational image");
+			return -EALREADY;
+		}
 		goto finish;
+	}
 
 	err = btintel_boot(hdev, boot_param);
 	if (err)
diff --git a/drivers/bluetooth/btintel.h b/drivers/bluetooth/btintel.h
index 9526acf65959..97fbe0ddf2d3 100644
--- a/drivers/bluetooth/btintel.h
+++ b/drivers/bluetooth/btintel.h
@@ -257,6 +257,7 @@ enum {
 	INTEL_ROM_LEGACY_NO_WBS_SUPPORT,
 	INTEL_ACPI_RESET_ACTIVE,
 	INTEL_WAIT_FOR_D0,
+	INTEL_TOP_RESET,
 
 	__INTEL_NUM_FLAGS,
 };
@@ -265,6 +266,7 @@ struct btintel_data {
 	DECLARE_BITMAP(flags, __INTEL_NUM_FLAGS);
 	int (*acpi_reset_method)(struct hci_dev *hdev);
 	u32 cnvi_bt;
+	u32 boot_addr;
 	bool	unlocker;
 };
 
-- 
2.43.0

