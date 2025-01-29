Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3FE35968
	for <linux-bluetooth@vger.kernel.org>; Wed, 29 Jan 2025 02:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738118530; cv=none; b=ZmQ071yBGWeyElbmfl5Hb/ht1oc+fKNSKM71PoRH4uq9QAlu5lCL/zEH5cKfJGE6guYCpclzDqJq5OzlagWpqKAxlnq2CeMvH6ccEUDI9C693ZVX3/rmH8X71o/VAPzFgxOlqwVmau/mjYf3KETFXi8K0CT3XIsTUnvc3DKpsLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738118530; c=relaxed/simple;
	bh=el8Twg1NF0b42Wi1/J0xLCxG88CwqfB1LouTflid23I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=a1jWf/mwHFPPLG4ZcAFcud0HAMzXNforWUhq/DteI5U4lXLqt2k+JARv+kS3oZw2YunftFGYIvaE26Bx2Mu4gkLeqP50JqCjIXhh3O/LsynvbQWcqx9XuqY3xfBwj8rCljxn1f4QHPkScgYFqGOx/PcUWh8E1sH0bZ4WbGSr3EA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z3U6ABG6; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z3U6ABG6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738118527; x=1769654527;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=el8Twg1NF0b42Wi1/J0xLCxG88CwqfB1LouTflid23I=;
  b=Z3U6ABG6rCbOk0eJgndc95/pquNVA8WuB2kDYaWcdZMdneyVcGTl4aPM
   WZq6Nj+oVtX9uP1kXfUEXpiJzpj+NeWwUihls7NLwITcUKZ8UuOoORtjD
   DOIcveNdlmtktC6PhyjZ2xMaw6HAOWupMeQaBJRg1xSVriBreWOjmWe5J
   Q2Fm+AvFSnuTke1/tlCLlLljn7DykK5vAGxVpKzemkGUzy+58wyXEGMQ+
   +15AN4Nwl/JUdYmWOqEUhnoWeY6R84XYdDI4DI9QvMZpH9DG5ZFIL881g
   dMLHry9Nh4MEofRmp6dfMyAZaYjMu/Xr7EmONR2AljEcrcAsdgLZ2Z0eU
   A==;
X-CSE-ConnectionGUID: 5BkJhwLiSQWF2TS21t9mzg==
X-CSE-MsgGUID: bAKUTQ95Q3ODpMImroZ3HQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11329"; a="41462255"
X-IronPort-AV: E=Sophos;i="6.13,242,1732608000"; 
   d="scan'208";a="41462255"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2025 18:42:07 -0800
X-CSE-ConnectionGUID: fAON0hHNQd6mEb118Cxi5g==
X-CSE-MsgGUID: 6G//V6oqThGuQYtHawzmzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="139778767"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by fmviesa001.fm.intel.com with ESMTP; 28 Jan 2025 18:42:05 -0800
From: Kiran K <kiran.k@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: ravishankar.srivatsa@intel.com,
	chethan.tumkur.narayan@intel.com,
	chandrashekar.devegowda@intel.com,
	vijay.satija@intel.com,
	Kiran K <kiran.k@intel.com>
Subject: [PATCH v2] Bluetooth: btintel: Add DSBR support for ScP
Date: Wed, 29 Jan 2025 08:28:17 +0530
Message-ID: <20250129025817.65224-1-kiran.k@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add DSBR support for Scorpious Peak cores.

Refer commit eb9e749c0182 ("Bluetooth: btintel: Allow configuring drive
strength of BRI") for details about DSBR.

Signed-off-by: Kiran K <kiran.k@intel.com>
---
changes in v2:
Removed unnecessary blank line which is not relavnt to this patch.

 drivers/bluetooth/btintel.c | 5 +++++
 drivers/bluetooth/btintel.h | 1 +
 2 files changed, 6 insertions(+)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index 03bf96e2544f..ec5e2c7a56ae 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -2757,6 +2757,7 @@ static int btintel_set_dsbr(struct hci_dev *hdev, struct intel_version_tlv *ver)
 	/* DSBR command needs to be sent for,
 	 * 1. BlazarI or BlazarIW + B0 step product in IML image.
 	 * 2. Gale Peak2 or BlazarU in OP image.
+	 * 3. Scorpious Peak in IML image.
 	 */
 
 	switch (cnvi) {
@@ -2772,6 +2773,10 @@ static int btintel_set_dsbr(struct hci_dev *hdev, struct intel_version_tlv *ver)
 		    hdev->bus == HCI_USB)
 			break;
 		return 0;
+	case BTINTEL_CNVI_SCP:
+		if (ver->img_type == BTINTEL_IMG_IML)
+			break;
+		return 0;
 	default:
 		return 0;
 	}
diff --git a/drivers/bluetooth/btintel.h b/drivers/bluetooth/btintel.h
index fa43eb137821..19530ea14905 100644
--- a/drivers/bluetooth/btintel.h
+++ b/drivers/bluetooth/btintel.h
@@ -56,6 +56,7 @@ struct intel_tlv {
 #define BTINTEL_CNVI_BLAZARIW		0x901
 #define BTINTEL_CNVI_GAP		0x910
 #define BTINTEL_CNVI_BLAZARU		0x930
+ #define BTINTEL_CNVI_SCP		0xA00
 
 #define BTINTEL_IMG_BOOTLOADER		0x01	/* Bootloader image */
 #define BTINTEL_IMG_IML			0x02	/* Intermediate image */
-- 
2.43.0

