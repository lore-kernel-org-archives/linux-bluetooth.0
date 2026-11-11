Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.13
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794425510;
	b=sjFEQJKwjqwmhvMNdk8tVuUiO/vLaebOmeMj4IfbscRdioD73zfe2ITcrdoD+/3fIL6o
	 6cliR8kvImDfXMetx5VAAmYFBTdxJEgdUsa6nJuqqyNu3Kh1yCGIC6OnjCOY+SDwVFaPk
	 n7TxTXDXnJnkmZmdq153+JIe6Ie/l4EgNqL8u5LttbFKfC5BxeDK/7W4p4DkhmW8/0hyP
	 3fugK0NmKunZcylZWxrv4g7uY/igU6A0dnnXyj2eN6hAFUZA2687bl6b8Ui1XczG2QT5U
	 rceX0nvLb/uWoLuNlO/qGkZjKkVbd11IqEfrDu8UmMqAQervl926m5Eh51tYsNrJr6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794425510;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=m9b9r8Icy9wOGboADbNfExqV6NVBARZ1l8I+QUUHUZE=;
	b=XUo7KLDEgN/51v39plp1i2/vzLT8adGm5i6QCiLqP0koOAKSgDnvHdvogSjbGSJOnm+t
	 UmsIq/dLoUKBaizVWvmsJCCSMZbv6MGrnq0FE84AoBOXH1pqpoArPZEqYRCAS2qj96CnC
	 jOr63ZVIgS9ChNg6AIwc5gT9Be21FtHCvtFNoW9CyYWXGbnTKkxrGKYrvEEh55C9rDh4D
	 NO2fRtDTq3sXKS6acL5+zM8TyFAgi0zzDa8O3UpcbDsIUC7hoPq/X3ZI+DffLzBwgwCcM
	 noADx/qk3fCIW9kSLLqUjf/5bGW4ecia+QRUEZQPkO3MdudOzTehRllJpxaeV+0EHPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=VDbC0BYQ;
	arc=none smtp.remote-ip=198.175.65.13
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E74F606A31C
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2026 19:31:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9E74F606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=VDbC0BYQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794425509; x=1825961509;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Ae37wnOxksDSYnGHYtzxO6NNf1/PE52GZCVstvd/FyE=;
  b=VDbC0BYQ1+205F8hIwNdbQAAp1ShjR+6iUyjUHcu1ZrWPd0zZrE0xg/D
   RlxVzcyFD0z6JW2LPAQ7lzp8JHjnvLBRxy9T0OBGkA7aPEj2UqXYJspAw
   Jh8BpWpnekvE3IMnqggtaDkQqw9MTZ/0XA8akz5hxvaBGLpp7MFcdgwiX
   SHMXg81PvXsw5xXXvP6V+GgvZSWFkZX3dO5manmSG61ceuqkXhnd4Nqfj
   EeZdf+xqYCGfOd0/nEMb5z2oQKrU4iHtslZliDGt5/fhluW4i30B62I76
   7VTd/c+meI9qYYRSY0qgJDhixRT4Pjv7VPtooatxxFE0XmebIqUHC0eBQ
   w==;
X-CSE-ConnectionGUID: OzrPJwRBR1qD/2XmbxdW8g==
X-CSE-MsgGUID: cHOBxEqxSVyY+Jes6O1ESA==
X-IronPort-AV: E=McAfee;i="6800,10657,11963"; a="3086895"
X-IronPort-AV: E=Sophos;i="6.27,208,1787036400"; 
   d="scan'208";a="3086895"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2026 11:31:43 -0800
X-CSE-ConnectionGUID: MChSJWuVRgG7KSihyq1sJA==
X-CSE-MsgGUID: j0PAKWjfTOqtLoY2g6RFmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,208,1787036400"; 
   d="scan'208";a="8529027"
Received: from weba0957.iind.intel.com (HELO WEBA0932.iind.intel.com) ([10.224.186.34])
  by orviesa006.jf.intel.com with ESMTP; 11 Nov 2026 11:31:41 -0800
From: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: chethan.tumkur.narayan@intel.com,
	kiran.k@intel.com,
	Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>
Subject: [PATCH v5 1/2] Bluetooth: btintel: Add TOP silent reset hooks
Date: Thu, 12 Nov 2026 01:01:02 +0530
Message-ID: <20261111193103.2992252-1-chandrashekar.devegowda@intel.com>
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
 drivers/bluetooth/btintel.c | 28 ++++++++++++++++++++++++++++
 drivers/bluetooth/btintel.h |  2 ++
 2 files changed, 30 insertions(+)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index a0aa110f4cdd..de0868504fbe 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -1281,6 +1281,12 @@ static bool btintel_firmware_version(struct hci_dev *hdev,
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
@@ -1298,6 +1304,12 @@ static bool btintel_firmware_version(struct hci_dev *hdev,
 
 			*boot_addr = le32_to_cpu(params->boot_addr);
 
+			if (hdev->bus == HCI_PCI) {
+				struct btintel_data *data = hci_get_priv(hdev);
+
+				data->boot_addr = *boot_addr;
+			}
+
 			bt_dev_info(hdev, "Boot Address: 0x%x", *boot_addr);
 
 			bt_dev_info(hdev, "Firmware Version: %u-%u.%u",
@@ -2107,6 +2119,13 @@ static int btintel_boot(struct hci_dev *hdev, u32 boot_addr)
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
@@ -3595,6 +3614,7 @@ int btintel_bootloader_setup_tlv(struct hci_dev *hdev,
 	struct intel_version_tlv new_ver;
 	struct btintel_data *data = hci_get_priv(hdev);
 	u8 hw_variant = INTEL_HW_VARIANT(ver->cnvi_bt);
+	bool top_reset = btintel_test_flag(hdev, INTEL_TOP_RESET);
 
 	bt_dev_dbg(hdev, "");
 
@@ -3611,10 +3631,18 @@ int btintel_bootloader_setup_tlv(struct hci_dev *hdev,
 	for (int i = 0; i < __INTEL_NUM_FLAGS; i++)
 		btintel_clear_flag(hdev, i);
 
+	if (top_reset)
+		btintel_set_flag(hdev, INTEL_TOP_RESET);
+
 	btintel_set_flag(hdev, INTEL_BOOTLOADER);
 
 	data->unlocker = false;
 
+	if (top_reset && ver->img_type == BTINTEL_IMG_OP) {
+		bt_dev_err(hdev, "TOP reset requested on operational image");
+		return -EALREADY;
+	}
+
 	/* Legacy unlocker flow (BlazarI / BlazarIW / BlazarU / Gale Peak):
 	 * Boot ROM -> unlocker.sfi -> IML -> OPFW
 	 *
diff --git a/drivers/bluetooth/btintel.h b/drivers/bluetooth/btintel.h
index 372c6d7d8cbe..a59d642f096e 100644
--- a/drivers/bluetooth/btintel.h
+++ b/drivers/bluetooth/btintel.h
@@ -260,6 +260,7 @@ enum {
 	INTEL_ACPI_RESET_ACTIVE,
 	INTEL_WAIT_FOR_D0,
 	INTEL_UNLOCKER_LOADED,
+	INTEL_TOP_RESET,
 
 	__INTEL_NUM_FLAGS,
 };
@@ -268,6 +269,7 @@ struct btintel_data {
 	DECLARE_BITMAP(flags, __INTEL_NUM_FLAGS);
 	int (*acpi_reset_method)(struct hci_dev *hdev);
 	u32 cnvi_bt;
+	u32 boot_addr;
 	bool	unlocker;
 };
 
-- 
2.43.0

