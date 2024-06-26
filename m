Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B8B3170859
	for <linux-bluetooth@vger.kernel.org>; Wed, 26 Jun 2024 09:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719393217; cv=none; b=VGsoxQ/vjEwy2PX0zS/nB4FSvcQ965jyNH4Q6CzRnteeookglxdLDR0ZiMHr94qWazsscedLG2BUsFUwe16jd40plf2vABb+PBru9KYtfxmNMjZof59zpPtRYbNNIVKNeyvAFjruEE8KEFacnAHJD6OTgctaQ01kYTyXzB3fQjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719393217; c=relaxed/simple;
	bh=KXkxf1O5aCrOk5mSB9jTOa9ISWrYHjNvBI8sGRLPEMk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FI6OFr/xM80kyi//1tYXwlfJomI6v2wU1RqR6YJjw7Nmcm5+NekL2iqVm6naAvWhZUYU3If0v/G0Z+3/UT+xACV+NIkv41ecezFPEWOY40dPDuLphMzFOhc2CEDpa9sFkipKLZGEmQupKZz5W5VYQGpWFAXD9ncb7pSv1jVR0BM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kABdRKxU; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kABdRKxU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719393215; x=1750929215;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=KXkxf1O5aCrOk5mSB9jTOa9ISWrYHjNvBI8sGRLPEMk=;
  b=kABdRKxUSvPns4BAAiucF8fMqPYaF4ZdBO66BAqGgNePBssfVVk6RhoB
   EqGB9eIvUPXnEStGtLy1MnOajOrVxbWQXAyuHrLBTk/pE+g3YJqYWRJNx
   TH6FFMem8ZFK/OUUMoKha88o/q5i7N3NmfThZ7GnGNOHTgTvrP7h0dyzM
   tmJWD+FAPq4uEhebuEolOyShLhVVaVzPN2z+BWh40x975CRb9pBnk/v5p
   9kE4yaY41ydq19Lqwd4nmY1el1jNSTLK3XS3Phr2sSSQviEGgCqVJ+2YN
   YpYnJ3NzTA5T+27kGjySC9NePG0rFvdVyAVHvu13mgkOYlmujD+FArKgH
   A==;
X-CSE-ConnectionGUID: jrsCU/L1TLSq4jN4xZMqNw==
X-CSE-MsgGUID: 7MtXxye6SYmMMkG0grl7oQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11114"; a="16678196"
X-IronPort-AV: E=Sophos;i="6.08,266,1712646000"; 
   d="scan'208";a="16678196"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2024 02:13:35 -0700
X-CSE-ConnectionGUID: Z/6E51H5QAqqAnfQZ9NXhA==
X-CSE-MsgGUID: 0nrD5mlUTDWUqCO1rHMdZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,266,1712646000"; 
   d="scan'208";a="44029962"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by fmviesa010.fm.intel.com with ESMTP; 26 Jun 2024 02:13:33 -0700
From: Kiran K <kiran.k@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: ravishankar.srivatsa@intel.com,
	chethan.tumkur.narayan@intel.com,
	chandrashekar.devegowda@intel.com,
	vijay.satija@intel.com,
	Kiran K <kiran.k@intel.com>
Subject: [PATCH v3] Bluetooth: btintel: Allow lowering of drive strength of BRI
Date: Wed, 26 Jun 2024 14:58:01 +0530
Message-Id: <20240626092801.2343844-1-kiran.k@intel.com>
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
strength value from efi variable and passes it to the controller via vendor
specific command with opcode 0xfc0a.

dmesg:
.....
[16.767459] Bluetooth: hci0: Found device firmware: intel/ibt-0190-0291-iml.sfi
[16.767464] Bluetooth: hci0: Boot Address: 0x30099000
[16.767464] Bluetooth: hci0: Firmware Version: 9-25.24
[16.825418] Bluetooth: hci0: Waiting for firmware download to complete
[16.825421] Bluetooth: hci0: Firmware loaded in 56600 usecs
[16.825463] Bluetooth: hci0: Waiting for device to boot
[16.827510] Bluetooth: hci0: Malformed MSFT vendor event: 0x02
[16.827529] Bluetooth: hci0: Device booted in 2053 usecs
[16.827707] Bluetooth: hci0: dsbr: enabled: 0x01 value: 0x0f
[16.830179] Bluetooth: hci0: Found device firmware: intel/ibt-0190-0291-pci.sfi
[16.830188] Bluetooth: hci0: Boot Address: 0x10000800
[16.830189] Bluetooth: hci0: Firmware Version: 9-25.24
[16.928308] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[16.928311] Bluetooth: BNEP filters: protocol multicast
[16.928315] Bluetooth: BNEP socket layer initialized
[17.333292] Bluetooth: hci0: Waiting for firmware download to complete
[17.333313] Bluetooth: hci0: Firmware loaded in 491339 usecs
[17.333353] Bluetooth: hci0: Waiting for device to boot
[17.368741] Bluetooth: hci0: Device booted in 34585 usecs
[17.368742] Bluetooth: hci0: Malformed MSFT vendor event: 0x02
[17.368942] Bluetooth: hci0: Found Intel DDC parameters: intel/ibt-0190-0291-pci.ddc
[17.369199] Bluetooth: hci0: Applying Intel DDC parameters completed
[17.369447] Bluetooth: hci0: Firmware timestamp 2024.25 buildtype 3 build 64777
[17.369448] Bluetooth: hci0: Firmware SHA1: 0xc33eb15f
[17.369648] Bluetooth: hci0: Fseq status: Success (0x00)
[17.369649] Bluetooth: hci0: Fseq executed: 00.00.04.183
[17.369650] Bluetooth: hci0: Fseq BT Top: 00.00.04.183
[17.408366] Bluetooth: MGMT ver 1.23
[17.408415] Bluetooth: ISO socket layer initialized
[17.434375] Bluetooth: RFCOMM TTY layer initialized
[17.434385] Bluetooth: RFCOMM socket layer initialized
[17.434389] Bluetooth: RFCOMM ver 1.11

Signed-off-by: Kiran K <kiran.k@intel.com>
---
 drivers/bluetooth/btintel.c | 117 ++++++++++++++++++++++++++++++++++++
 1 file changed, 117 insertions(+)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index 5d735391545a..fb9d4221ccd6 100644
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
@@ -26,6 +28,8 @@
 #define ECDSA_OFFSET		644
 #define ECDSA_HEADER_LEN	320
 
+#define BTINTEL_EFI_DRBR	L"UefiCnvCommonDSBR"
+
 enum {
 	DSM_SET_WDISABLE2_DELAY = 1,
 	DSM_SET_RESET_METHOD = 3,
@@ -49,6 +53,38 @@ static const guid_t btintel_guid_dsm =
 	GUID_INIT(0xaa10f4e0, 0x81ac, 0x4233,
 		  0xab, 0xf6, 0x3b, 0x2a, 0xc5, 0x0e, 0x28, 0xd9);
 
+static void *btintel_uefi_get_variable(efi_char16_t *name, efi_guid_t *guid)
+{
+	void *data;
+	efi_status_t status;
+	unsigned long data_size = 0;
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
@@ -2615,6 +2651,80 @@ static u8 btintel_classify_pkt_type(struct hci_dev *hdev, struct sk_buff *skb)
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
+	dsbr = btintel_uefi_get_variable(BTINTEL_EFI_DRBR, &guid);
+	if (IS_ERR(dsbr)) {
+		/* If efi variable is not present, driver still needs to send
+		 * 0xfc0a command with default values
+		 */
+		bt_dev_dbg(hdev, "Error reading efi: %ls DSBR (%ld)",
+			   BTINTEL_EFI_DRBR, PTR_ERR(dsbr));
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
@@ -2649,6 +2759,13 @@ int btintel_bootloader_setup_tlv(struct hci_dev *hdev,
 	if (err)
 		return err;
 
+	if (btintel_apply_dsbr(hdev, ver)) {
+		/* set drive strength BRI response */
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

