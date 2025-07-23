Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B3E92E54A1
	for <linux-bluetooth@vger.kernel.org>; Wed, 23 Jul 2025 13:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753277305; cv=none; b=jm3pOGUxstD7P1Q9IsDHTrAJeuVj5W0fXE4v+/bB5HFyEbjHvfiJVpBuqtt3BchlwgAI1DsYWOxZm+0etvFCdmjcOsbVA+mawMUOletdUkK/AwHHqw/dZT1tedshXt0RtA/QJVk9PoA/0Voo6sChfutho6RhCJT1Zqx9n+HjJJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753277305; c=relaxed/simple;
	bh=n5vy/hhp7CzeLV/3ccdQ8VxFzjLwNwTv8pZnlMYwdxw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kDyRq8Mye/JL+uSHp1jzB0d6Vroeco0FTU4UhGi1H3Abc7zorQdLK0wGZAHkb6lcnZ7otatcxoUQ9d4rmPdvpLoeBoTR/Vqp8iflg/S/IsWGfmHa9NAA/llWNEu4bNJ/YdykYmtKJj/Xou8CJGYPOGYK3DbgJXKmEhdDYO+RpYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZHaWhvut; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZHaWhvut"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753277305; x=1784813305;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=n5vy/hhp7CzeLV/3ccdQ8VxFzjLwNwTv8pZnlMYwdxw=;
  b=ZHaWhvut6gYw9+19Fm9eTEouArttP46w8PF2ez6OJvYuLWC3EAPRqVMJ
   ZCilLjjQnMqkpV8mC3CVq2IZSdcT8oJIMlds1953xQRWTb/2PGFqVTrfU
   EdsXlXCx9rkJz1Qcckcg3wA2PlTC7/WvcgOUZDXt32W8QbLLvGb0wQ13l
   Yb3vxmZ9loeRiRJjWRbCQOwzqOCw4YksgmlcQP5JeG7jMve48XNOWmVCE
   9cFd/vR1YG4sT1Pc91W2i/IGf/CkONyf2TYm98CoEhxtrv3NphBXpBpmo
   IhSVxC2ZdFo9Ppi2lmcvcKj9i5lUaUT7ZN4vLlIAJMu6VPiPj6qL+t70b
   g==;
X-CSE-ConnectionGUID: l6z74623Qm+x1L82j1/DuQ==
X-CSE-MsgGUID: OVr1H/igQCiLUKpNOB/ljw==
X-IronPort-AV: E=McAfee;i="6800,10657,11501"; a="55667155"
X-IronPort-AV: E=Sophos;i="6.16,333,1744095600"; 
   d="scan'208";a="55667155"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2025 06:28:25 -0700
X-CSE-ConnectionGUID: 6TxRHsCtQPebEVf7Lmm72A==
X-CSE-MsgGUID: dt3137AVSViepVG0Lt0DiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,333,1744095600"; 
   d="scan'208";a="190464463"
Received: from unknown (HELO intel-Lenovo-Legion-Y540-15IRH-PG0.iind.intel.com) ([10.224.186.95])
  by orviesa002.jf.intel.com with ESMTP; 23 Jul 2025 06:28:23 -0700
From: Kiran K <kiran.k@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: ravishankar.srivatsa@intel.com,
	Kiran K <kiran.k@intel.com>,
	Vijay Satija <vijay.satija@intel.com>
Subject: [PATCH v1] Bluetooth: btintel: Add support for BlazarIW core
Date: Wed, 23 Jul 2025 19:14:53 +0530
Message-ID: <20250723134453.1301750-1-kiran.k@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for the BlazarIW Bluetooth core used in the Wildcat Lake
platform.

dmesg:
Bluetooth: Core ver 2.22
Bluetooth: HCI device and connection manager initialized
Bluetooth: HCI socket layer initialized
Bluetooth: L2CAP socket layer initialized
Bluetooth: SCO socket layer initialized
Bluetooth: hci0: Device revision is 0
Bluetooth: hci0: Secure boot is enabled
Bluetooth: hci0: OTP lock is disabled
Bluetooth: hci0: API lock is disabled
Bluetooth: hci0: Debug lock is disabled
Bluetooth: hci0: Minimum firmware build 1 week 10 2014
Bluetooth: hci0: Bootloader timestamp 2023.33 buildtype 1 build 45995
Bluetooth: hci0: Found device firmware: intel/ibt-1190-00a1-iml.sfi
Bluetooth: hci0: Boot Address: 0x30098800
Bluetooth: hci0: Firmware Version: 184-28.25
Bluetooth: hci0: Waiting for firmware download to complete
Bluetooth: hci0: Firmware loaded in 67426 usecs
Bluetooth: hci0: Waiting for device to boot
Bluetooth: hci0: Device booted in 2248 usecs
Bluetooth: hci0: Waiting for device transition to d0
Bluetooth: hci0: Device moved to D0 in 0 usecs
Bluetooth: hci0: dsbr: enable: 0x01 value: 0x0f
Bluetooth: hci0: Found device firmware: intel/ibt-1190-00a1-pci.sfi
Bluetooth: hci0: Boot Address: 0x10000800
Bluetooth: hci0: Firmware Version: 184-28.25
Bluetooth: hci0: Waiting for firmware download to complete
Bluetooth: hci0: Firmware loaded in 510990 usecs
Bluetooth: hci0: Waiting for device to boot
Bluetooth: hci0: Device booted in 39057 usecs
Bluetooth: hci0: Waiting for device transition to d0
Bluetooth: hci0: Device moved to D0 in 88 usecs
Bluetooth: hci0: Found Intel DDC parameters: intel/ibt-1190-00a1-pci.ddc
Bluetooth: hci0: Applying Intel DDC parameters completed
Bluetooth: hci0: Firmware timestamp 2025.28 buildtype 1 build 96440
Bluetooth: hci0: Firmware SHA1: 0x34b85c16
Bluetooth: hci0: Fseq status: Success (0x00)
Bluetooth: hci0: Fseq executed: 00.98.00.05
Bluetooth: hci0: Fseq BT Top: 00.98.00.05
Bluetooth: BNEP (Ethernet Emulation) ver 1.3
Bluetooth: BNEP filters: protocol multicast
Bluetooth: BNEP socket layer initialized
Bluetooth: MGMT ver 1.23
Bluetooth: RFCOMM TTY layer initialized
Bluetooth: RFCOMM socket layer initialized
Bluetooth: RFCOMM ver 1.11

Signed-off-by: Vijay Satija <vijay.satija@intel.com>
Signed-off-by: Kiran K <kiran.k@intel.com>
---
 drivers/bluetooth/btintel.c      | 3 +++
 drivers/bluetooth/btintel_pcie.c | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index be69d21c9aa7..9d29ab811f80 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -484,6 +484,7 @@ int btintel_version_info_tlv(struct hci_dev *hdev,
 	case 0x1d:	/* BlazarU (BzrU) */
 	case 0x1e:	/* BlazarI (Bzr) */
 	case 0x1f:      /* Scorpious Peak */
+	case 0x22:	/* BlazarIW (BzrIW) */
 		break;
 	default:
 		bt_dev_err(hdev, "Unsupported Intel hardware variant (0x%x)",
@@ -3253,6 +3254,7 @@ void btintel_set_msft_opcode(struct hci_dev *hdev, u8 hw_variant)
 	case 0x1d:
 	case 0x1e:
 	case 0x1f:
+	case 0x22:
 		hci_set_msft_opcode(hdev, 0xFC1E);
 		break;
 	default:
@@ -3593,6 +3595,7 @@ static int btintel_setup_combined(struct hci_dev *hdev)
 	case 0x1d:
 	case 0x1e:
 	case 0x1f:
+	case 0x22:
 		/* Display version information of TLV type */
 		btintel_version_info_tlv(hdev, &ver_tlv);
 
diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index 6e7bbbd35279..d08f59ae7720 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -2149,6 +2149,7 @@ static int btintel_pcie_setup_internal(struct hci_dev *hdev)
 	switch (INTEL_HW_VARIANT(ver_tlv.cnvi_bt)) {
 	case 0x1e:	/* BzrI */
 	case 0x1f:	/* ScP  */
+	case 0x22:	/* BzrIW */
 		/* Display version information of TLV type */
 		btintel_version_info_tlv(hdev, &ver_tlv);
 
-- 
2.43.0

