Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3858B1B86D0
	for <linux-bluetooth@vger.kernel.org>; Thu, 18 Jul 2024 13:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721310162; cv=none; b=BJQtYTgf1HL+lOfCNWJkMJ6aBg2aIVYaWVkhhYOpXipJqh009KWj9PVH+EjPqY83rSItt7709QkNBXDbMOeZCe51AN575BUjNaetoAi+kkNq+PQmhM4P9iTOmiXWiqrIKmUUtqgj3N2uuz7UhumTL43A/7b9/DcO+ebsGBnqZtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721310162; c=relaxed/simple;
	bh=ZSa9x/0TMd5XnTocepcP6jahK/vSAnGrqT2pvAw9bs8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=L6xscxQzIlRyuxURQjKjFGRQUgZjvq6T69CVy6s6FsgK+Oy5cN/X47kRY28GIYtmC2m4xU8fmuZMGmKHpN2ygKVcV+EKplFiVfj7JpdbhR0rWxTeLLYnrw4lTCRszd/bhjvLCmXw7xicT6mgeoYf0RaleNf+rXo6FOFUiQ5mHnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dieSFHmk; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dieSFHmk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721310159; x=1752846159;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ZSa9x/0TMd5XnTocepcP6jahK/vSAnGrqT2pvAw9bs8=;
  b=dieSFHmkdjZdaREMkZrOY3FooDGxp2D22c+8AjfWjCc9rT9H2J1aoAD0
   HDSgZ8Uc8sE/WrRNll7QMyUAF5wTxvaEbnq9sbA6HfuM+6+RlpQ7pBg9v
   HXogvizH4H8Ok2R4l93p2way0M6JHnF0F2kOZKLU/2AwQso1/6Yp2wBsO
   5BuCwGxsSsobeybCvoq20nEctQPrgkOQzMMiDuQzKD7aihF8YrxYYW641
   9rFpKThVSx4puKcl5x07JX2G666hHAMuYg+gt8F/DLwgbUNK8d57V7pWG
   NLaiRk1poor9IwIvH/9eCQJVemWvqRRTFZy2l4veWq8g1xY+9SsjNGpZj
   w==;
X-CSE-ConnectionGUID: GreD55woSjagPVxX5bH94A==
X-CSE-MsgGUID: IICUJZY6SqqNU3HPF6MEsw==
X-IronPort-AV: E=McAfee;i="6700,10204,11137"; a="18491591"
X-IronPort-AV: E=Sophos;i="6.09,218,1716274800"; 
   d="scan'208";a="18491591"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2024 06:42:38 -0700
X-CSE-ConnectionGUID: 9WwkA3DcTmK2SPeiaZJn0g==
X-CSE-MsgGUID: 8PI3DNsFSziDWlgNxETWjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,218,1716274800"; 
   d="scan'208";a="50804794"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by orviesa009.jf.intel.com with ESMTP; 18 Jul 2024 06:42:36 -0700
From: Kiran K <kiran.k@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: ravishankar.srivatsa@intel.com,
	chethan.tumkur.narayan@intel.com,
	chandrashekar.devegowda@intel.com,
	vijay.satija@intel.com,
	pmenzel@molgen.mpg.de,
	Kiran K <kiran.k@intel.com>
Subject: [PATCH v4] Bluetooth: btintel: Allow configuring drive strength of BRI
Date: Thu, 18 Jul 2024 19:26:55 +0530
Message-Id: <20240718135655.3948028-1-kiran.k@intel.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

BRI (Bluetooth Radio Interface) traffic from CNVr to CNVi was found causing
cross talk step errors to WiFi. To avoid this potential issue OEM platforms
can replace BRI resistor to adjust the BRI response line drive strength.
During the *setup*, driver reads the drive strength value from uefi
variable and passes it to the controller via vendor specific command with
opcode 0xfc0a.

dmesg:

..
[21.982720] Bluetooth: hci0: Bootloader timestamp 2023.33 buildtype 1 build 45995
[21.984250] Bluetooth: hci0: Found device firmware: intel/ibt-0190-0291-iml.sfi
[21.984255] Bluetooth: hci0: Boot Address: 0x30099000
[21.984256] Bluetooth: hci0: Firmware Version: 160-24.24
[22.011501] Bluetooth: hci0: Waiting for firmware download to complete
[22.011518] Bluetooth: hci0: Firmware loaded in 26624 usecs
[22.011584] Bluetooth: hci0: Waiting for device to boot
[22.013546] Bluetooth: hci0: Malformed MSFT vendor event: 0x02
[22.013552] Bluetooth: hci0: Device booted in 1967 usecs
...
[22.013792] Bluetooth: hci0: dsbr: enable: 0x01 value: 0x0b
...
[22.015027] Bluetooth: hci0: Found device firmware: intel/ibt-0190-0291.sfi
[22.015041] Bluetooth: hci0: Boot Address: 0x10000800
[22.015043] Bluetooth: hci0: Firmware Version: 160-24.24
[22.395821] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[22.395828] Bluetooth: BNEP filters: protocol multicast
...

Signed-off-by: Kiran K <kiran.k@intel.com>
Change-Id: Ia51d0d86b980fcca1b12247ed8fe9ae9d2b06307
Reviewed-on: https://gerritwcs.ir.intel.com/c/bcp_linux-bt_drv_kernel-5_3/+/117825
---
 drivers/bluetooth/btintel.c | 124 ++++++++++++++++++++++++++++++++++++
 1 file changed, 124 insertions(+)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index 2ebc970e6573..cef74fd1271d 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -12,6 +12,7 @@
 #include <linux/acpi.h>
 #include <acpi/acpi_bus.h>
 #include <asm/unaligned.h>
+#include <linux/efi.h>
 
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
@@ -26,6 +27,8 @@
 #define ECDSA_OFFSET		644
 #define ECDSA_HEADER_LEN	320
 
+#define BTINTEL_EFI_DSBR	L"UefiCnvCommonDSBR"
+
 enum {
 	DSM_SET_WDISABLE2_DELAY = 1,
 	DSM_SET_RESET_METHOD = 3,
@@ -2616,6 +2619,120 @@ static u8 btintel_classify_pkt_type(struct hci_dev *hdev, struct sk_buff *skb)
 	return hci_skb_pkt_type(skb);
 }
 
+/*
+ * UefiCnvCommonDSBR UEFI variable provides information from the OEM platforms
+ * if they have replaced the BRI (Bluetooth Radio Interface) resistor to
+ * overcome the potential STEP errors on their designs. Based on the
+ * configauration, bluetooth firmware shall adjust the BRI response line drive
+ * strength. The below structure represents DSBR data.
+ * struct {
+ *	u8 header;
+ *	u32 dsbr;
+ * } __packed;
+ *
+ * header - defines revision number of the structure
+ * dsbr - defines drive strength BRI response
+ *	bit0
+ *		0 - instructs bluetooth firmware to use default values
+ *		1 - instructs bluetooth firmware to override default values
+ *	bit3:1
+ *		Reserved
+ *	bit7:4
+ *		DSBR override values (only if bit0 is set. Default value is 0xF
+ *	bit31:7
+ *		Reserved
+ * Expected values for dsbr field:
+ *	1. 0xF1 - indicates that the resistor on board is 33 Ohm
+ *	2. 0x00 or 0xB1 - indicates that the resistor on board is 10 Ohm
+ *	3. Non existing UEFI variable or invalid (none of the above) - indicates
+ *	   that the resistor on board is 10 Ohm
+ * Even if uefi variable is not present, driver shall send 0xfc0a command to
+ * firmware to use default values.
+ *
+ */
+static int btintel_uefi_get_dsbr(u32 *dsbr_var)
+{
+	struct btintel_dsbr {
+		u8 header;
+		u32 dsbr;
+	} __packed data;
+
+	efi_status_t status;
+	unsigned long data_size = 0;
+	efi_guid_t guid = EFI_GUID(0xe65d8884, 0xd4af, 0x4b20, 0x8d, 0x03,
+				   0x77, 0x2e, 0xcc, 0x3d, 0xa5, 0x31);
+
+	if (!IS_ENABLED(CONFIG_EFI))
+		return -EOPNOTSUPP;
+
+	if (!efi_rt_services_supported(EFI_RT_SUPPORTED_GET_VARIABLE))
+		return -EOPNOTSUPP;
+
+	status = efi.get_variable(BTINTEL_EFI_DSBR, &guid, NULL, &data_size,
+				  NULL);
+
+	if (status != EFI_BUFFER_TOO_SMALL || !data_size)
+		return -EIO;
+
+	status = efi.get_variable(BTINTEL_EFI_DSBR, &guid, NULL, &data_size,
+				  &data);
+
+	if (status != EFI_SUCCESS)
+		return -ENXIO;
+
+	*dsbr_var = data.dsbr;
+	return 0;
+}
+
+static int btintel_set_dsbr(struct hci_dev *hdev, struct intel_version_tlv *ver)
+{
+	struct btintel_dsbr_cmd {
+		u8 enable;
+		u8 dsbr;
+	} __packed;
+
+	struct btintel_dsbr_cmd cmd;
+	struct sk_buff *skb;
+	u8 status;
+	u32 dsbr;
+	bool apply_dsbr;
+	int err;
+
+	/* DSBR command needs to be sent for BlazarI + B0 step product after
+	 * downloading IML image.
+	 */
+	apply_dsbr = (ver->img_type == BTINTEL_IMG_IML &&
+		((ver->cnvi_top & 0xfff) == BTINTEL_CNVI_BLAZARI) &&
+		INTEL_CNVX_TOP_STEP(ver->cnvi_top) == 0x01);
+
+	if (!apply_dsbr)
+		return 0;
+
+	dsbr = 0;
+	err = btintel_uefi_get_dsbr(&dsbr);
+	if (err < 0)
+		bt_dev_dbg(hdev, "Error reading efi: %ls  (%d)",
+			   BTINTEL_EFI_DSBR, err);
+
+	cmd.enable = dsbr & BIT(0);
+	cmd.dsbr = dsbr >> 4 & 0xF;
+
+	bt_dev_info(hdev, "dsbr: enable: 0x%2.2x value: 0x%2.2x", cmd.enable,
+		    cmd.dsbr);
+
+	skb = __hci_cmd_sync(hdev, 0xfc0a, sizeof(cmd), &cmd,  HCI_CMD_TIMEOUT);
+	if (IS_ERR(skb))
+		return -bt_to_errno(PTR_ERR(skb));
+
+	status = skb->data[0];
+	kfree_skb(skb);
+
+	if (status)
+		return -bt_to_errno(status);
+
+	return 0;
+}
+
 int btintel_bootloader_setup_tlv(struct hci_dev *hdev,
 				 struct intel_version_tlv *ver)
 {
@@ -2650,6 +2767,13 @@ int btintel_bootloader_setup_tlv(struct hci_dev *hdev,
 	if (err)
 		return err;
 
+	/* set drive strength of BRI response */
+	err = btintel_set_dsbr(hdev, ver);
+	if (err) {
+		bt_dev_err(hdev, "Failed to send dsbr command (%d)", err);
+		return err;
+	}
+
 	/* If image type returned is BTINTEL_IMG_IML, then controller supports
 	 * intermediate loader image
 	 */
-- 
2.40.1

