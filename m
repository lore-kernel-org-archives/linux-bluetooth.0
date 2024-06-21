Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A51113C802
	for <linux-bluetooth@vger.kernel.org>; Fri, 21 Jun 2024 06:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718951399; cv=none; b=Z1eN65q3Jmwy/9IH0UFEsJzh0152trAHIos5QmQcQyD/vdFGx+7/IUDjkrINRfN4516KHOz22BOj/S3W5Zm1XVRy7lKIH+1Y2aCdToCbYsamxNXeWjVZfu7oT+F9rwn4sZJY8tM87OzHhmITOT8sne1BfdynO82nWcA01II/g5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718951399; c=relaxed/simple;
	bh=JEOnNDLu1Snv3EFXfmOQ1ofvWYFUITbbQ6/Z2C3iubg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Xox/SMmlc3KZlAC761EyhmrsXIzi98v4SmpLGJjsbn2r+oPW0UA1SAQijOHWREOlSJtj2PG8Ye2eDfzfjSO67QOcZuAjOwgDlJl0fQJIUp+OFQMD6WvdPkvED1Ri4NRxoOw/bYsCLpZdPTtfi6ui08TU16QFeYH/Mlo8h1Y7bUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Mdzq1UBR; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Mdzq1UBR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718951397; x=1750487397;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=JEOnNDLu1Snv3EFXfmOQ1ofvWYFUITbbQ6/Z2C3iubg=;
  b=Mdzq1UBRrTRQIDW6kduo4X/QRHtskP8chvLUNA8rdviBaKNPi2ZFBAvT
   CTG2x9/1SU+xQOG0In7/cF6PVbxnaHHk7fun28CfHG3axPmhnrwZtm+H7
   AaOLVB/nCKYDYHwCbGZdRrjGS1AeLR/hTjqk3kz9garzicjef2wk9pV/O
   1TvSn05KdalFWFoX0uK2g8j9axedVMGQ77uKIhPEWMdyG5/+1yViFy2fu
   y2Vu8FCSkRfiyGJ8fydoLcwI0W2cnXdD+7nf4hzVTXmi1m2tIvLXKM4Vv
   sM2aY9PIlFXCwveMlVKEU1PQRYhmPc/2xUYZlr+VRSswu1qtsaqeIQlhT
   g==;
X-CSE-ConnectionGUID: v1mJ3zpwQQycAequaPEJUg==
X-CSE-MsgGUID: GxvPhzFXSIKiWTRQ9j+Bug==
X-IronPort-AV: E=McAfee;i="6700,10204,11109"; a="27107106"
X-IronPort-AV: E=Sophos;i="6.08,253,1712646000"; 
   d="scan'208";a="27107106"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2024 23:29:56 -0700
X-CSE-ConnectionGUID: pXiYhUq1SfC0RaL9Vc/Mmw==
X-CSE-MsgGUID: 0XZZt00xRZy4HIc0ECmlYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,253,1712646000"; 
   d="scan'208";a="73712199"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by fmviesa001.fm.intel.com with ESMTP; 20 Jun 2024 23:29:53 -0700
From: Kiran K <kiran.k@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: ravishankar.srivatsa@intel.com,
	chethan.tumkur.narayan@intel.com,
	chandrashekar.devegowda@intel.com,
	vijay.satija@intel.com,
	Kiran K <kiran.k@intel.com>
Subject: [PATCH v2] Bluetooth: btintel: Allow lowering of drive strength of BRI
Date: Fri, 21 Jun 2024 12:14:19 +0530
Message-Id: <20240621064419.2185652-1-kiran.k@intel.com>
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
 drivers/bluetooth/btintel.c | 114 ++++++++++++++++++++++++++++++++++++
 1 file changed, 114 insertions(+)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index 5d735391545a..3dc557aac43d 100644
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
@@ -49,6 +51,38 @@ static const guid_t btintel_guid_dsm =
 	GUID_INIT(0xaa10f4e0, 0x81ac, 0x4233,
 		  0xab, 0xf6, 0x3b, 0x2a, 0xc5, 0x0e, 0x28, 0xd9);
 
+static void *btintel_uefi_get_variable(efi_char16_t *name, efi_guid_t *guid)
+{
+	void *data;
+	efi_status_t status;
+	size_t data_size = 0;
+
+	if (!IS_ENABLED(CONFIG_EFI))
+		return ERR_PTR(-EOPNOTSUPP);
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
+}
+
 int btintel_check_bdaddr(struct hci_dev *hdev)
 {
 	struct hci_rp_read_bd_addr *bda;
@@ -2615,6 +2649,80 @@ static u8 btintel_classify_pkt_type(struct hci_dev *hdev, struct sk_buff *skb)
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
@@ -2649,6 +2757,12 @@ int btintel_bootloader_setup_tlv(struct hci_dev *hdev,
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

