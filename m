Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2103617BAC
	for <linux-bluetooth@vger.kernel.org>; Mon,  4 Mar 2024 08:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709541037; cv=none; b=mhitaFEho4RKa95QKRus4k6fcK9gefDnOllKtVAbyzDKuD6m1xYs9+wul9oVWcWo3xy9Fzp51IVWOjDI7KySvAg5h+McX317+SvUkAcbPXiJyLAYGfbQkmzieRj0yAJh4t/ofjzFlekidv0bnBjYXOcLDb97Yq/uAOoqnPSBnes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709541037; c=relaxed/simple;
	bh=oWrWDlA55QFseS5y6Af0gjUpMdjNtzh9LNR6rNQuWAM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=emJ19A5gKOkoMSUzq3tjEsLbA6YeIGinLEB/zjEIe7TItpFZ1SE9ra9Io5HYtXzxECqxwfCFL6TMqVgsdgyM+3UsrKmsTYg0heVK13zx+edW+WEuPFSlbVr/NGsFPzpIBeSTRnY4w9UE0eTuOl1OpJ5mT5pqHivRgjvZn3EmzNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hbpoLY6y; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hbpoLY6y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709541036; x=1741077036;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=oWrWDlA55QFseS5y6Af0gjUpMdjNtzh9LNR6rNQuWAM=;
  b=hbpoLY6yj5dQxm4NSWQWYfiIX+NurMcLKb/4LkQ3n6nRvhnTa0ivg7kY
   lj73IpF0tujWGYvaACLPVHr84mOQrsY6VjDR1yOIsEhk1xH9gCtIG/eYo
   IauF6Fx2ACzaxVyCqLBCbiN+yxqba8cSA0NbGbWg8B0oKZ5R3kwHYfFZS
   whgGCOjeEo3AjycN8RWAuGos7rfnEZtnYYFam6/8cQIuTIdjIdEl9rLxH
   uKaDxZkPedIRRaLSSKZ6FRg55AvPl7yWfy4P2ne42gqWD6f6UtwjzfHtV
   5Om9y29nvo3CYMpfUNFDHSMUJUicmexR7BjoEWuDecg1mZ+ae7IkVs4mI
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11002"; a="4186105"
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; 
   d="scan'208";a="4186105"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 00:30:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; 
   d="scan'208";a="9350796"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by orviesa006.jf.intel.com with ESMTP; 04 Mar 2024 00:30:33 -0800
From: Kiran K <kiran.k@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: ravishankar.srivatsa@intel.com,
	chethan.tumkur.narayan@intel.com,
	Kiran K <kiran.k@intel.com>
Subject: [PATCH v2] Bluetooth: btintel: Add support for downloading secondary boot loader image
Date: Mon,  4 Mar 2024 14:14:18 +0530
Message-Id: <20240304084418.32042-1-kiran.k@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some variants of Intel controllers like BlazarI supports downloading of
secondary bootloader. This patch adds the support to download secondary
boot loader image before downloading operational firmware image.

dmesg logs:
[16.537130] Bluetooth: Core ver 2.22
[16.537135] Bluetooth: Starting self testing
[16.540021] Bluetooth: ECDH test passed in 2818 usecs
[16.560666] Bluetooth: SMP test passed in 602 usecs
[16.560674] Bluetooth: Finished self testing
[16.560690] Bluetooth: HCI device and connection manager initialized
[16.560695] Bluetooth: HCI socket layer initialized
[16.560697] Bluetooth: L2CAP socket layer initialized
[16.560700] Bluetooth: SCO socket layer initialized
[16.571934] Bluetooth: hci0: Device revision is 0
[16.571940] Bluetooth: hci0: Secure boot is disabled
[16.571941] Bluetooth: hci0: OTP lock is disabled
[16.571942] Bluetooth: hci0: API lock is enabled
[16.571943] Bluetooth: hci0: Debug lock is disabled
[16.571943] Bluetooth: hci0: Minimum firmware build 1 week 10 2014
[16.571945] Bluetooth: hci0: Bootloader timestamp 2022.46 buildtype 1 build 26590
[16.572189] Bluetooth: hci0: DSM reset method type: 0x00
[16.575002] Bluetooth: hci0: Found device firmware: intel/ibt-0090-0291-02.sfi
[16.575007] Bluetooth: hci0: Boot Address: 0x30099000
[16.575008] Bluetooth: hci0: Firmware Version: 200-10.24
[16.705698] Bluetooth: hci0: Waiting for firmware download to complete
[16.705927] Bluetooth: hci0: Firmware loaded in 127852 usecs
[16.705952] Bluetooth: hci0: Waiting for device to boot
[16.708519] Bluetooth: hci0: Device booted in 2522 usecs
[16.708538] Bluetooth: hci0: Malformed MSFT vendor event: 0x02
[16.710296] Bluetooth: hci0: No device address configured
[16.712483] Bluetooth: hci0: Found device firmware: intel/ibt-0090-0291.sfi
[16.712497] Bluetooth: hci0: Boot Address: 0x10000800
[16.712498] Bluetooth: hci0: Firmware Version: 211-10.24
[16.930834] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[16.930840] Bluetooth: BNEP filters: protocol multicast
[16.930844] Bluetooth: BNEP socket layer initialized
[18.494137] Bluetooth: hci0: Waiting for firmware download to complete
[18.494897] Bluetooth: hci0: Firmware loaded in 1740634 usecs
[18.494972] Bluetooth: hci0: Waiting for device to boot
[18.529089] Bluetooth: hci0: Device booted in 33371 usecs
[18.529121] Bluetooth: hci0: Malformed MSFT vendor event: 0x02
[18.529914] Bluetooth: hci0: Found Intel DDC parameters: intel/ibt-0090-0291.ddc
[18.532158] Bluetooth: hci0: Applying Intel DDC parameters completed
[18.532582] Bluetooth: hci0: Found Intel DDC parameters: intel/bdaddress.cfg
[18.534109] Bluetooth: hci0: Applying Intel DDC parameters completed
[18.537170] Bluetooth: hci0: Firmware timestamp 2024.9 buildtype 0 build 58067
[18.537177] Bluetooth: hci0: Firmware SHA1: 0x81abf1ea
[18.540985] Bluetooth: hci0: Fseq status: Success (0x00)
[18.540992] Bluetooth: hci0: Fseq executed: 00.00.00.00
[18.540993] Bluetooth: hci0: Fseq BT Top: 00.00.00.00
[18.631360] Bluetooth: MGMT ver 1.22
[18.673023] Bluetooth: RFCOMM TTY layer initialized
[18.673031] Bluetooth: RFCOMM socket layer initialized
[18.673039] Bluetooth: RFCOMM ver 1.11

Signed-off-by: Kiran K <kiran.k@intel.com>
---
 drivers/bluetooth/btintel.c | 38 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 37 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index 6ba7f5d1b837..6fb65f5344e4 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -521,6 +521,9 @@ static int btintel_version_info_tlv(struct hci_dev *hdev,
 			    version->min_fw_build_nn, version->min_fw_build_cw,
 			    2000 + version->min_fw_build_yy);
 		break;
+	case 0x02:
+		variant = "IML";
+		break;
 	case 0x03:
 		variant = "Firmware";
 		break;
@@ -2194,10 +2197,26 @@ static void btintel_get_fw_name_tlv(const struct intel_version_tlv *ver,
 				    char *fw_name, size_t len,
 				    const char *suffix)
 {
+	const char *format;
 	/* The firmware file name for new generation controllers will be
 	 * ibt-<cnvi_top type+cnvi_top step>-<cnvr_top type+cnvr_top step>
 	 */
-	snprintf(fw_name, len, "intel/ibt-%04x-%04x.%s",
+	switch (INTEL_HW_VARIANT(ver->cnvi_bt)) {
+	/* Only Blazar(0x1e) product supports downloading of secondary boot
+	 * loader image
+	 */
+	case 0x1e:
+		if (ver->img_type == 1)
+			format = "intel/ibt-%04x-%04x-02.%s";
+		else
+			format = "intel/ibt-%04x-%04x.%s";
+		break;
+	default:
+			format = "intel/ibt-%04x-%04x.%s";
+		break;
+	}
+
+	snprintf(fw_name, len, format,
 		 INTEL_CNVX_TOP_PACK_SWAB(INTEL_CNVX_TOP_TYPE(ver->cnvi_top),
 					  INTEL_CNVX_TOP_STEP(ver->cnvi_top)),
 		 INTEL_CNVX_TOP_PACK_SWAB(INTEL_CNVX_TOP_TYPE(ver->cnvr_top),
@@ -2607,6 +2626,23 @@ static int btintel_bootloader_setup_tlv(struct hci_dev *hdev,
 	if (err)
 		return err;
 
+	err = btintel_read_version_tlv(hdev, ver);
+	if (err)
+		return err;
+
+    /* If image type returned is 0x02, then controller supports secondary
+     * boot loader image
+     */
+	if (ver->img_type == 0x02) {
+		err = btintel_prepare_fw_download_tlv(hdev, ver, &boot_param);
+		if (err)
+			return err;
+
+		err = btintel_boot(hdev, boot_param);
+		if (err)
+			return err;
+	}
+
 	btintel_clear_flag(hdev, INTEL_BOOTLOADER);
 
 	btintel_get_fw_name_tlv(ver, ddcname, sizeof(ddcname), "ddc");
-- 
2.34.1

