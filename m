Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECAF41AE869
	for <linux-bluetooth@vger.kernel.org>; Thu, 20 Jun 2024 14:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718895136; cv=none; b=lU8RlqYKfue6nymhar17SmWGeUgTGHMwVLDn/6gZvqaD/9lsYHFjJrkH4GmnqSbblZnZcDdL/ISamtKRCUki9KGxa8UPJFsFcJrwITPFnhYzSfwgOIEX0GnSqm6nXFiQrB6LatNlFSU1TBRvvoOp1oDyOe+fatiWCZOQVef0d8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718895136; c=relaxed/simple;
	bh=R3VE8vdrAuyn/0OkeY8ZInSecUeKr44wwZO6xSBfJZU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SGbSKSqkwyRe9T0sleLXFY/3lNSUm7w1JqeyKcMe3wDPfWNFZumISdvz06YeW+N90mO+0neTt6eDJI4LIwFGnFpb+66l1B77iGUWla59xhNV0ZG1ZWZyUSvl1/kvMXW+0r5zqMclnYCo5sfUBAI7gZAytYrdGr6yiGT26AguGK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hTTlPXtK; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hTTlPXtK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718895135; x=1750431135;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=R3VE8vdrAuyn/0OkeY8ZInSecUeKr44wwZO6xSBfJZU=;
  b=hTTlPXtKcy51AtF9h8nqvG6WhCPND3qdD/2lvJEzwoRJf7xVIUJftKci
   i0gdi9zGk1v3+PDDXWUbre1V4IrMWzEUI2kmyWqM40Q6SjMK2jj+LPEO6
   GL90W9GwHYnN0w1nE/AyhXnZtJCSiR0CUTtUm1NTZ86C0zi1FvwxA0Z4S
   5WCQ9LmdVhAXGWgIrn/aJgKffJNWiKptwcpU1ZZU+lnGIGCOjv1qKP9YA
   mroMbt4hS2492x36HvRxl6SKLktrM5VB3uP0DdJIhOt8yq4tAcvyZTdzD
   oTfsXZ5N5wsToKjhAIShaLZZ0ctTfWGXdX0VYdPVifS7zI3b1Zp3jyNwz
   Q==;
X-CSE-ConnectionGUID: IJoDBijHTFiDBihHdFOlqw==
X-CSE-MsgGUID: 0TalmbvXQIe/XVuFMlSFYQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11108"; a="26565847"
X-IronPort-AV: E=Sophos;i="6.08,252,1712646000"; 
   d="scan'208";a="26565847"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2024 07:52:14 -0700
X-CSE-ConnectionGUID: 0wqUXeBRTZ6x5Pok06ai4Q==
X-CSE-MsgGUID: T5bO642uTXWvuJzac8eBOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,252,1712646000"; 
   d="scan'208";a="42353556"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by fmviesa009.fm.intel.com with ESMTP; 20 Jun 2024 07:52:12 -0700
From: Kiran K <kiran.k@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: ravishankar.srivatsa@intel.com,
	chethan.tumkur.narayan@intel.com,
	chandrashekar.devegowda@intel.com,
	vijay.satija@intel.com,
	Kiran K <kiran.k@intel.com>
Subject: [PATCH v1] Bluetooth: btintel: Allow lowering of drive strength of BRI
Date: Thu, 20 Jun 2024 20:36:35 +0530
Message-Id: <20240620150635.2119398-1-kiran.k@intel.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

BRI (Bluetooth Radio Interface) traffic from CNVr to CNVi was found
causing cross talk step errors to WiFi. As a workaround, driver needs to
reduce the drive strength of BRI. During *setup*, driver reads the drive
strength value from efi variable and passes it controller via vendor
specific command with opcode 0xfc0a.

Signed-off-by: Kiran K <kiran.k@intel.com>
---
 drivers/bluetooth/btintel.c | 115 ++++++++++++++++++++++++++++++++++++
 1 file changed, 115 insertions(+)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index 5d735391545a..1d6586b30c8d 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -12,6 +12,8 @@
 #include <linux/acpi.h>
 #include <acpi/acpi_bus.h>
 #include <asm/unaligned.h>
+#include <linux/efi.h>
+
 
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
@@ -49,6 +51,39 @@ static const guid_t btintel_guid_dsm =
 	GUID_INIT(0xaa10f4e0, 0x81ac, 0x4233,
 		  0xab, 0xf6, 0x3b, 0x2a, 0xc5, 0x0e, 0x28, 0xd9);
 
+static void *btintel_uefi_get_variable(efi_char16_t *name, efi_guid_t *guid)
+{
+#if defined(CONFIG_EFI)
+	void *data;
+	efi_status_t status;
+	size_t data_size = 0;
+
+	if (!efi_rt_services_supported(EFI_RT_SUPPORTED_GET_VARIABLE))
+		return ERR_PTR(-EOPNOTSUPP);
+
+	status = efi.get_variable(name, guid, NULL, &data_size, NULL);
+
+	if (status != EFI_BUFFER_TOO_SMALL || !data_size)
+		return ERR_PTR(-EIO);
+
+	data = kmalloc(data_size, GFP_KERNEL);
+
+	if (!data)
+		return ERR_PTR(-ENOMEM);
+
+	status = efi.get_variable(name, guid, NULL, &data_size, data);
+
+	if (status != EFI_SUCCESS) {
+		kfree(data);
+		return ERR_PTR(-ENXIO);
+	}
+
+	return data;
+#else
+	return ERR_PTR(-EOPNOTSUPP);
+#endif
+}
+
 int btintel_check_bdaddr(struct hci_dev *hdev)
 {
 	struct hci_rp_read_bd_addr *bda;
@@ -2615,6 +2650,80 @@ static u8 btintel_classify_pkt_type(struct hci_dev *hdev, struct sk_buff *skb)
 	return hci_skb_pkt_type(skb);
 }
 
+static int btintel_set_dsbr(struct hci_dev *hdev, struct intel_version_tlv *ver)
+{
+	struct btintel_dsbr_cmd {
+		u8 enable;
+		u8 dsbr;
+	} __packed;
+
+	struct btintel_dsbr {
+		u8 header;
+		u32 dsbr;
+	} __packed;
+
+	struct btintel_dsbr *dsbr;
+	struct btintel_dsbr_cmd cmd;
+	struct sk_buff *skb;
+	u8 status;
+	efi_guid_t guid = EFI_GUID(0xe65d8884, 0xd4af, 0x4b20, 0x8d, 0x03,
+				   0x77, 0x2e, 0xcc, 0x3d, 0xa5, 0x31);
+
+	memset(&cmd, 0, sizeof(cmd));
+	dsbr = btintel_uefi_get_variable(L"UefiCnvCommonDSBR", &guid);
+	if (IS_ERR(dsbr)) {
+		/* If efi variable is not present, driver still needs to send
+		 * 0xfc0a command with default values
+		 */
+		bt_dev_dbg(hdev, "Error reading efi DSBR (%ld)",
+			   PTR_ERR(dsbr));
+		dsbr = NULL;
+	}
+
+	if (dsbr) {
+		/* bit0: 0 - Use firmware default value
+		 *       1 - Override firmware value
+		 * bit3:1 - Reserved
+		 * bit7:4 - DSBR override values
+		 * bt31:7 - Reserved
+		 */
+		cmd.enable = dsbr->dsbr & BIT(0);
+		if (cmd.enable)
+			cmd.dsbr = dsbr->dsbr >> 4 & 0xF;
+		kfree(dsbr);
+	}
+
+	bt_dev_info(hdev, "dsbr: enabled: 0x%2.2x value: 0x%2.2x", cmd.enable,
+		    cmd.dsbr);
+
+	skb = __hci_cmd_sync(hdev, 0xfc0a, sizeof(cmd), &cmd,  HCI_CMD_TIMEOUT);
+	if (IS_ERR(skb)) {
+		bt_dev_err(hdev, "Failed to send Intel DSBR command (%ld)",
+			   PTR_ERR(skb));
+		return -bt_to_errno(PTR_ERR(skb));
+	}
+
+	status = skb->data[0];
+	kfree_skb(skb);
+
+	if (status) {
+		bt_dev_err(hdev, "Set DSBR failed 0x%2.2x", status);
+		return -bt_to_errno(status);
+	}
+	return 0;
+}
+
+static int btintel_apply_dsbr(struct hci_dev *hdev,
+			      struct intel_version_tlv *ver)
+{
+	/* For BlazarI + B0 step, DSBR command needs to be sent just after
+	 * downloading IML firmware
+	 */
+	return ver->img_type == BTINTEL_IMG_IML &&
+		((ver->cnvi_top & 0xfff) == BTINTEL_CNVI_BLAZARI) &&
+		INTEL_CNVX_TOP_STEP(ver->cnvi_top) == 0x01;
+}
+
 int btintel_bootloader_setup_tlv(struct hci_dev *hdev,
 				 struct intel_version_tlv *ver)
 {
@@ -2649,6 +2758,12 @@ int btintel_bootloader_setup_tlv(struct hci_dev *hdev,
 	if (err)
 		return err;
 
+	if (btintel_apply_dsbr(hdev, ver)) {
+		err = btintel_set_dsbr(hdev, ver);
+		if (err)
+			return err;
+	}
+
 	/* If image type returned is BTINTEL_IMG_IML, then controller supports
 	 * intermediae loader image
 	 */
-- 
2.40.1

