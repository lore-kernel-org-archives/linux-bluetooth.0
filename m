Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794547580;
	b=jJVYMvF9lO9K2Y6EAqcW57QRRT4dQt2/IvOVSXkCst497d82173xiN/1iVOSbkUi0qLo
	 acLQMQgzjhx6MQ+S/vcdquiGYBG0j1sBATuNaCGjjK6eVKz3+6VTd5gSfSFJxkTjP+Pcz
	 nsAjYDuM42aSy521/OmZDqwK+hwG3fOxl2zgDEGpD8JstVJwigRIMP251KA/dNZo+N67M
	 BegChNZfdNhyTH3wlPK8w2uBWyCNlML48QZmrOgMcmP1HKHPeBFELtxZk7lALTw+22ewn
	 by0hiq30jRm7BdarQl1NuAb9EVnIwHrpJnCYu/PSjkpqs6/pITTe6XM0ATshEHoTRxw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794547580;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=m9b9r8Icy9wOGboADbNfExqV6NVBARZ1l8I+QUUHUZE=;
	b=nUeuHcs4+C2PzOZCvXFNzIu+zCd2Ad0kQ/hOTvQJ6s302Bj/X6Gav77+vEg+PoSqH8iA
	 1V6dbXdUO+PBJczu3eY05iI9YqeuYUM59R0BRjoBgNnkWFCUPF5mmfoxMm5VU/+5d/2br
	 NLg3Lnsm09EebVn++rmrzPWaX1Yt/4TL6o7fiHCEKaaDUS7kqO/S3K8daqD5l1eRX9sw9
	 4CTnRtUgGjxQKNRiguInN/V1Z5RBzwXh0AKbT4WAaWSpDP04IZGv5kGCR9dEuxkk6YWU6
	 K4P4YyIwPabi9LZV3D94J+bHRqyHTjW0up2PRfdQiwnIfnfURyP29Iyv+ZjZaEQUxSA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=HgAP4B4e;
	arc=none smtp.remote-ip=192.198.163.18
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11AAF606A31C
	for <linux-bluetooth@vger.kernel.org>; Fri, 13 Nov 2026 05:26:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 11AAF606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=HgAP4B4e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794547579; x=1826083579;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Ae37wnOxksDSYnGHYtzxO6NNf1/PE52GZCVstvd/FyE=;
  b=HgAP4B4eSDc2VCa4lKjzJwUspDZePHK1Qt87BgOpKeGCq2Ks5jzf2cr5
   U1sIzdUNnc3t/eOuakc5u9GKtbxIqVDA24Oqn7DqKRet+us17x2H6q5Ex
   OYmVXo2t3mnPB2db/dJ+n59rsWpdXtXYh3QURZXIF4bEvaKuQ1gRM+5zo
   mili3wwTw7wkwfE6S3QoVLit4RAogVKcpzOPZoSR4AnJx5GlC4nk5uLPo
   aNI46STa/dSTC6fv/g/QoEFMcl3zgTGSws9G/1xI7JFfKKLM8K4NEoipM
   8xkw4vQnTb332K/8jQGFbdOqTU2IPMrTM1xkNnqYz/7uoEoL6k17YPGvv
   A==;
X-CSE-ConnectionGUID: uNFaB5p6Ti63Y0OX15vuuw==
X-CSE-MsgGUID: Jww5oVBZS2yIL41igdFV8Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11964"; a="3373412"
X-IronPort-AV: E=Sophos;i="6.27,211,1787036400"; 
   d="scan'208";a="3373412"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2026 21:26:18 -0800
X-CSE-ConnectionGUID: Hp3a5JHOQf6cIcJcHDBwGQ==
X-CSE-MsgGUID: K7+Y9r41TRKlo8+YtH8kYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,211,1787036400"; 
   d="scan'208";a="10740671"
Received: from weba0957.iind.intel.com (HELO WEBA0932.iind.intel.com) ([10.224.186.34])
  by fmviesa013.fm.intel.com with ESMTP; 12 Nov 2026 21:26:17 -0800
From: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: chethan.tumkur.narayan@intel.com,
	kiran.k@intel.com,
	Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>
Subject: [PATCH v6 1/2] Bluetooth: btintel: Add TOP silent reset hooks
Date: Fri, 13 Nov 2026 10:55:37 +0530
Message-ID: <20261113052538.3030771-1-chandrashekar.devegowda@intel.com>
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

