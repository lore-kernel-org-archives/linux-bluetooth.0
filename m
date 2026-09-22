Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 773914A0936
	for <linux-bluetooth@vger.kernel.org>; Tue, 22 Sep 2026 06:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790058403; cv=none; b=t/ukit9ywK1aSV65PTSAI/BIuZy/qMShkSnkAdFn11CVcYU2pzptZbe7xmg7p/kfoU1LbEU4SBe3wynvSuv9ujdFaJs3L9iOqNeAEX9ZTx7BL5UTCjRfw1mAnudBd1pbAW6f1gYE+IeMU2zoep6SZqQDw5+ubrE6hRTqJge+i4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790058403; c=relaxed/simple;
	bh=4TXNc6eEgvJhlDfgmLUU2GVVrZjyJFNuea+J29pSeII=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h/xBPNsM86fCLV5AVo0nrpcLYakp1hEd6T0yIHGvvxx8psMwEGBDpufLoLGBahAQ2ifmOjKVJ9k5QNpNyKAFynnENxodJ2YeqrWGM3fdDK8ixxFSTDCsRE9LSU2JwsfbU5EZ4NbbcBBKRH4rOTuhkapx3uFTiCK/LDRsa8i/csw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=itbFDLWN; arc=none smtp.client-ip=192.198.163.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="itbFDLWN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790058400; x=1821594400;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=4TXNc6eEgvJhlDfgmLUU2GVVrZjyJFNuea+J29pSeII=;
  b=itbFDLWNVJPclOz1XjnHQumoGEAwG2sMMT2HAtXd1f+Tf3e8l8N4Vvid
   udZlExB5Xf9IjRVai1IxDCz7X8+0VMJslqKVKtPnmssztViuaayfHjgj7
   57oTye248c935iyI89ZLtsfR8BhC0LmG3UwqcjvVI7R/R4K085gVxXY+6
   IJ5h7Ao6kHqtBA0FGUbmJgbZ5LxOwt8i9LtIOeZ5Y/Hb5xKA2gKUS9g1m
   zsxvK+fnUGC3E02z0mMdl+bqFq9v4HFb/eCo+j9ajwmgOyweaSxyu57hj
   R4E5EaNWl0zclAXXQzjq2U1zuSilwXtSIF59AalCX/cQxWBN1wwWDoyDr
   g==;
X-CSE-ConnectionGUID: x9f9Zp36QdCCNnGYmakaxg==
X-CSE-MsgGUID: VhGePI1/Rn2tRLJzpZ4mEw==
X-IronPort-AV: E=McAfee;i="6800,10657,11912"; a="1138304"
X-IronPort-AV: E=Sophos;i="6.27,115,1787036400"; 
   d="scan'208";a="1138304"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa114.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2026 23:26:38 -0700
X-CSE-ConnectionGUID: sOPk17SuSZeqPECsfu/m8A==
X-CSE-MsgGUID: kAuKAbOmS9GyFsifyB4pBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,115,1787036400"; 
   d="scan'208";a="272189823"
Received: from weba0534.iind.intel.com ([10.66.226.131])
  by fmviesa010.fm.intel.com with ESMTP; 21 Sep 2026 23:26:36 -0700
From: Sai Teja Aluvala <aluvala.sai.teja@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: kiran.k@intel.com,
	chethan.tumkur.narayan@intel.com,
	Sai Teja Aluvala <aluvala.sai.teja@intel.com>
Subject: [PATCH v1 3/3] Bluetooth: Add support for Intel DRACO
Date: Tue, 22 Sep 2026 11:48:21 +0530
Message-ID: <20260922061821.20218-1-aluvala.sai.teja@intel.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for the Draco Bluetooth core (hardware variant 0x23,
CNVi 0xA30) recognizing the new variant in btintel's version
info TLV parsing, MSFT vendor opcode setup, and combined setup
path, as well as in btintel_pcie hardware exception handling
and PCIe setup path.

Signed-off-by: Sai Teja Aluvala <aluvala.sai.teja@intel.com>
---
 drivers/bluetooth/btintel.c      | 3 +++
 drivers/bluetooth/btintel.h      | 1 +
 drivers/bluetooth/btintel_pcie.c | 2 ++
 3 files changed, 6 insertions(+)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index 5e6d1ddc99c6..112cbadc2733 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -508,6 +508,7 @@ int btintel_version_info_tlv(struct hci_dev *hdev,
 	case 0x20:	/* Scorpious Peak2 */
 	case 0x21:	/* Scorpious Peak2 F */
 	case 0x22:	/* BlazarIW (BzrIW) */
+	case 0x23:	/* Draco */
 		break;
 	default:
 		bt_dev_err(hdev, "Unsupported Intel hardware variant (0x%x)",
@@ -3608,6 +3609,7 @@ void btintel_set_msft_opcode(struct hci_dev *hdev, u8 hw_variant)
 	case 0x20:
 	case 0x21:
 	case 0x22:
+	case 0x23:
 		hci_set_msft_opcode(hdev, 0xFC1E);
 		break;
 	default:
@@ -3951,6 +3953,7 @@ static int btintel_setup_combined(struct hci_dev *hdev)
 	case 0x20:
 	case 0x21:
 	case 0x22:
+	case 0x23:
 		/* Display version information of TLV type */
 		btintel_version_info_tlv(hdev, &ver_tlv);
 
diff --git a/drivers/bluetooth/btintel.h b/drivers/bluetooth/btintel.h
index b3c4c6f87424..9cf136c6c716 100644
--- a/drivers/bluetooth/btintel.h
+++ b/drivers/bluetooth/btintel.h
@@ -62,6 +62,7 @@ struct intel_tlv {
 #define BTINTEL_CNVI_SCP		0xA00	/* Scorpius Peak - Panther Lake */
 #define BTINTEL_CNVI_SCP2		0xA10	/* Scorpius Peak2 - Nova Lake */
 #define BTINTEL_CNVI_SCP2F		0xA20	/* Scorpius Peak2F - Nova Lake */
+#define BTINTEL_CNVI_DRACO		0xA30	/* Draco */
 
 /* CNVR */
 #define BTINTEL_CNVR_FMP2		0x910
diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index cfa437e76ad5..075a502fec26 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -2292,6 +2292,7 @@ static void btintel_pcie_read_hwexp(struct btintel_pcie_data *data)
 	case BTINTEL_CNVI_SCP:
 	case BTINTEL_CNVI_SCP2:
 	case BTINTEL_CNVI_SCP2F:
+	case BTINTEL_CNVI_DRACO:
 		break;
 	default:
 		bt_dev_err(data->hdev, "Unsupported cnvi 0x%8.8x", data->dmp_hdr.cnvi_top);
@@ -3450,6 +3451,7 @@ static int btintel_pcie_setup_internal(struct hci_dev *hdev)
 	case 0x20:	/* ScP2 */
 	case 0x21:	/* ScP2 F */
 	case 0x22:	/* BzrIW */
+	case 0x23:	/* DrC */
 		/* Display version information of TLV type */
 		btintel_version_info_tlv(hdev, &ver_tlv);
 
-- 
2.53.0

