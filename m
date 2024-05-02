Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5220112E75
	for <linux-bluetooth@vger.kernel.org>; Thu,  2 May 2024 05:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714626600; cv=none; b=YcWQo6o0rVbym/1aqjnjwN/hS79wy9+RxIZjXGWYpeEk7PoPh03hpqE9gB0+/aLKYeyYFwYxTxl25Iko+cWxz6/Fadtb7CEO+iqr6Vbyb9Ifhzwau0Ds+xpHq+BwUzYSQa654f429vMYYXJ3naiSLYCuuxKYE6wrLHEmMoxaHuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714626600; c=relaxed/simple;
	bh=mG7QM22YndkX9CaRPeg2bJbYLOCSzfzA6VT7mTMEees=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mx3hPybVIuQlThKmFav1QTet9JedmTiGdA3vMi+EvYmA9TYvkVu4JEDlh9LG4ICJQGmK8ZXvHOyVcWFLXCDPNBlyN9ygbaYWo344GLnEosWqt/u7g/JpMbB82uZ7fTuYFpHZ2oa4sEt6B5OGXKyx2aXubSmMJ4i3JeKRhRWd7S8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MI+5F4Lj; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MI+5F4Lj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714626599; x=1746162599;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=mG7QM22YndkX9CaRPeg2bJbYLOCSzfzA6VT7mTMEees=;
  b=MI+5F4Ljj5OTCyyJnup9xOr5TzQDw/6l/4ft7JuXQxehpN6eTlVS9ovT
   38sQIFXG5fXRkKYRoNaxXkPxYHkFvWKJ4VyoHfWZ6i/0znc7JKldL5vcf
   dlgz2PURHTD7GEoveEBaoRQx7dE51WZusWcCUr8zEnVYWQIAkCriYKy+M
   xTIEP9Xht5uaHptmoOxrwAKalzb9uoibZQsaz/nMXvFSEN8Vhmf2bkFna
   XtJl6Zd71hRQsjqj6NxaKy+gWRANn3QSKntLp2W1nkw2Q/jC89oO8wWdb
   zpBHwwET7+PQlwjRLIdB74J26h2BClqfJ0/PFkQ9kK65Ut3cUyRMNYt5T
   Q==;
X-CSE-ConnectionGUID: xrQsFtbzQ1yJTRd5OE9jHw==
X-CSE-MsgGUID: +X6duUvVThe8FnGkjwV6IA==
X-IronPort-AV: E=McAfee;i="6600,9927,11061"; a="14181897"
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="14181897"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2024 22:09:58 -0700
X-CSE-ConnectionGUID: rjJpaBmSS5um9w0jtG9Ujw==
X-CSE-MsgGUID: QuUSBgO0Tw6i10ZsT5xSGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="27410526"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by orviesa006.jf.intel.com with ESMTP; 01 May 2024 22:09:57 -0700
From: Kiran K <kiran.k@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: ravishankar.srivatsa@intel.com,
	chethan.tumkur.narayan@intel.com,
	chandrashekar.devegowda@intel.com,
	Kiran K <kiran.k@intel.com>
Subject: [PATCH v1 1/2] Bluetooth: btintel: Add support for BlazarI
Date: Thu,  2 May 2024 10:53:55 +0530
Message-Id: <20240502052356.2630798-1-kiran.k@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for BlazarI (cnvi) bluetooth core.

Signed-off-by: Kiran K <kiran.k@intel.com>
---
 drivers/bluetooth/btintel.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index dc48352166a5..4f4bd5538b6e 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -481,6 +481,7 @@ static int btintel_version_info_tlv(struct hci_dev *hdev,
 	case 0x19:	/* Slr-F */
 	case 0x1b:      /* Mgr */
 	case 0x1c:	/* Gale Peak (GaP) */
+	case 0x1e:	/* BlazarI (Bzr) */
 		break;
 	default:
 		bt_dev_err(hdev, "Unsupported Intel hardware variant (0x%x)",
@@ -2698,6 +2699,7 @@ static void btintel_set_msft_opcode(struct hci_dev *hdev, u8 hw_variant)
 	case 0x19:
 	case 0x1b:
 	case 0x1c:
+	case 0x1e:
 		hci_set_msft_opcode(hdev, 0xFC1E);
 		break;
 	default:
@@ -3037,6 +3039,7 @@ static int btintel_setup_combined(struct hci_dev *hdev)
 	case 0x19:
 	case 0x1b:
 	case 0x1c:
+	case 0x1e:
 		/* Display version information of TLV type */
 		btintel_version_info_tlv(hdev, &ver_tlv);
 
-- 
2.34.1

