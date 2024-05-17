Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D0A123758
	for <linux-bluetooth@vger.kernel.org>; Fri, 17 May 2024 09:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715938830; cv=none; b=HTXQpsp3pYS7AoGi3g+sR3Jb58tWKf7jOv+RDG1mMBPLCB9zQUSnFhouQ/TG9AkXuvewgqGFDKK5Wqzl+JaK1vSB8AwyxrmfFoPo+YJetJbdk4ygxp2aFD8hdwJsCIT4ywH2gGDgyhNAdZ+iVjqwWyYca1Wz95tlDfsYbX1sudo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715938830; c=relaxed/simple;
	bh=rB3jjjd3wldD/dxe9C5N3XXEIQUUHdWt3HUXovE9s98=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nM73cJtqyRIErJ/06EDhnM/7QsewVVyhDm/GTjSL5tn6Q8uhPH8vbCZ2u7bpg6t0woGOjP9cSjhc1bjJ8+JC+ltpYGDjCandusNX4hZ+QdYig5e3srERJ4Hj1vyDiLzEUPFUHsvATUso/A6t4GpkDv3+xIY7t8gKI/FIQ7ADWXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kclLoSld; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kclLoSld"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715938828; x=1747474828;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=rB3jjjd3wldD/dxe9C5N3XXEIQUUHdWt3HUXovE9s98=;
  b=kclLoSldVJz+CLR7rLWfBn4UVOxu0fARqe0Xus+7sA+TvRn3MfKOoc7r
   71Vfrb8h9lZ05DmuNOeE1rCnXTvnUXDQxs5bHv4jyTuTV3Bh3z/iWlupG
   XJ/i5O3TEro7PGyw6ymDy7XL6832zTgBkCpSQ5eHJjgwVPy/HMyNfyTHH
   gfudLlcdM7mRXkoQHytrYmq1pcxihGWeyopGBFnJ3EPxiHKkYuGdede+Q
   GiH2gDMbfYhQb6QdY/MhvcBU2y5IOaad+nGFLLfAzCn19lQ6jQy+bDvPP
   Jh/hRk3tMLJKncJfPKlzDJhzNDWRjUyn+9QEZhfsRWuMDgKFavc//hbXs
   Q==;
X-CSE-ConnectionGUID: PiNxpDyIQBCxcgjYFPehyw==
X-CSE-MsgGUID: 7rjk8hfzTv6Xa3nZ7IN7Mg==
X-IronPort-AV: E=McAfee;i="6600,9927,11074"; a="11976642"
X-IronPort-AV: E=Sophos;i="6.08,167,1712646000"; 
   d="scan'208";a="11976642"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2024 02:40:27 -0700
X-CSE-ConnectionGUID: U256kLRGRS6iGGW5VsnhBg==
X-CSE-MsgGUID: SB9gOoetTgSblljhOauDYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,167,1712646000"; 
   d="scan'208";a="31676419"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by fmviesa007.fm.intel.com with ESMTP; 17 May 2024 02:40:23 -0700
From: Kiran K <kiran.k@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: ravishankar.srivatsa@intel.com,
	chethan.tumkur.narayan@intel.com,
	chandrashekar.devegowda@intel.com,
	vijay.satija@intel.com,
	Kiran K <kiran.k@intel.com>
Subject: [PATCH v3 1/3] Bluetooth: btintel_pcie: Print Firmware Sequencer information
Date: Fri, 17 May 2024 15:24:45 +0530
Message-Id: <20240517095447.956132-1-kiran.k@intel.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Firmware sequencer (FSEQ) is a common code shared across Bluetooth
and Wifi. Printing FSEQ will help to debug if there is any mismatch
between Bluetooth and Wifi FSEQ.

Make 'btintel_print_fseq_info' public and use it in btintel_pcie.c.

dmesg:

....

[ 5335.695740] Bluetooth: hci0: Device booted in 33872 usecs
[ 5335.695918] Bluetooth: hci0: Found Intel DDC parameters: intel/ibt-0190-0291.ddc
[ 5335.697011] Bluetooth: hci0: Applying Intel DDC parameters completed
[ 5335.697837] Bluetooth: hci0: Firmware timestamp 2024.20 buildtype 0 build 62871
[ 5335.697848] Bluetooth: hci0: Firmware SHA1: 0xeffdce06
[ 5335.698655] Bluetooth: hci0: Fseq status: Success (0x00)
[ 5335.698666] Bluetooth: hci0: Fseq executed: 00.00.04.176
[ 5335.698670] Bluetooth: hci0: Fseq BT Top: 00.00.04.176
[ 5335.750204] Bluetooth: MGMT ver 1.22

Signed-off-by: Kiran <kiran.k@intel.com>
---
 drivers/bluetooth/btintel.c      | 3 ++-
 drivers/bluetooth/btintel.h      | 5 +++++
 drivers/bluetooth/btintel_pcie.c | 2 ++
 3 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index 0c855c3ee1c1..2c434ff9c47c 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -2713,7 +2713,7 @@ void btintel_set_msft_opcode(struct hci_dev *hdev, u8 hw_variant)
 }
 EXPORT_SYMBOL_GPL(btintel_set_msft_opcode);
 
-static void btintel_print_fseq_info(struct hci_dev *hdev)
+void btintel_print_fseq_info(struct hci_dev *hdev)
 {
 	struct sk_buff *skb;
 	u8 *p;
@@ -2825,6 +2825,7 @@ static void btintel_print_fseq_info(struct hci_dev *hdev)
 
 	kfree_skb(skb);
 }
+EXPORT_SYMBOL_GPL(btintel_print_fseq_info);
 
 static int btintel_setup_combined(struct hci_dev *hdev)
 {
diff --git a/drivers/bluetooth/btintel.h b/drivers/bluetooth/btintel.h
index b5fea735e260..9dbad1a7c47c 100644
--- a/drivers/bluetooth/btintel.h
+++ b/drivers/bluetooth/btintel.h
@@ -244,6 +244,7 @@ int btintel_bootloader_setup_tlv(struct hci_dev *hdev,
 				 struct intel_version_tlv *ver);
 int btintel_shutdown_combined(struct hci_dev *hdev);
 void btintel_hw_error(struct hci_dev *hdev, u8 code);
+void btintel_print_fseq_info(struct hci_dev *hdev);
 #else
 
 static inline int btintel_check_bdaddr(struct hci_dev *hdev)
@@ -373,4 +374,8 @@ static inline int btintel_shutdown_combined(struct hci_dev *hdev)
 static inline void btintel_hw_error(struct hci_dev *hdev, u8 code)
 {
 }
+
+static inline void btintel_print_fseq_info(struct hci_dev *hdev)
+{
+}
 #endif
diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index 5b6805d87fcf..8d282ee2322c 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -1197,9 +1197,11 @@ static int btintel_pcie_setup(struct hci_dev *hdev)
 		bt_dev_err(hdev, "Unsupported Intel hw variant (%u)",
 			   INTEL_HW_VARIANT(ver_tlv.cnvi_bt));
 		err = -EINVAL;
+		goto exit_error;
 		break;
 	}
 
+	btintel_print_fseq_info(hdev);
 exit_error:
 	kfree_skb(skb);
 
-- 
2.40.1

