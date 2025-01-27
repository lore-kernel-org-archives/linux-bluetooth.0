Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA2BF7603F
	for <linux-bluetooth@vger.kernel.org>; Mon, 27 Jan 2025 11:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737976041; cv=none; b=nm2kR9X8oei9Gi7K7fD6EcrQrRA5L84i6oILOrmYf9jnhmmVDouhUOnDqgIJOui0Pu6He2xTY4fRw4nXjkDvlZfsxTGT2pP7eDmr10lVUst4KGyk0UTdKi6922G/DKzOVl5uQ4zjsCyDG4BHQFTPa6piQ/8MYPXLFp2orxRgejM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737976041; c=relaxed/simple;
	bh=UfIXQ8ax1bRyGWsaqkfMVCP8WyNqNTRLZayWQXjYGKE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=przTQYX5xzIoeMdjxhFt+kBlXXdcTgRKDs+eClKQeHUNcHrW3RG/ccBZfyH4UsUsa501mzdGKnZQeFK2JvKQX50xjrX6+hlkwwAPpKlN1eOYfCa7L1K8koZj5qi9ff/HnTeqRcG4jInak3Sp9r8JVlksCFaEiANEtkqHO6jHyuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KGMQ8KZK; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KGMQ8KZK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737976040; x=1769512040;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=UfIXQ8ax1bRyGWsaqkfMVCP8WyNqNTRLZayWQXjYGKE=;
  b=KGMQ8KZK5QfUpCRG2MSG7Ty2zi459FiH0J7M/ExRAZKLFqLYI05uGmlM
   VSlxPmxWujW12Q/EOiNqdnVeJ0WlfQNKKqXLTqp0mAxaJgqWdyYzUYaOH
   rqwe89VAYWYQG6i/PPsV0Wh7uO7/PN0Rzp+qKCqjG7OcksTzgM47hhypT
   E5iON8FDWer48bZRpouIOhLUuWG6qzoNwzqLBfQfovmFxl6BS+nCFpwKv
   At6sJlns+Qmn0tJcMq8pRiza591z9XCEaa1ORWBDqtsR5RiCkCMEnfgZw
   4YDhSEao/WInIcSFZnYbYT0tssJtD0rTAB9cT5M9rsFkqvpR0oxQv3GlZ
   A==;
X-CSE-ConnectionGUID: 3tXmI8w/R7iwPnq+2u7Vrw==
X-CSE-MsgGUID: DL38N1p2ThKhlRQpFx6QMg==
X-IronPort-AV: E=McAfee;i="6700,10204,11327"; a="48934533"
X-IronPort-AV: E=Sophos;i="6.13,238,1732608000"; 
   d="scan'208";a="48934533"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2025 03:07:19 -0800
X-CSE-ConnectionGUID: MMCeVg1dRHyk+5q9ISsQgQ==
X-CSE-MsgGUID: qxDTe9y/ShyiCK01k8vBpw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="145621836"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by orviesa001.jf.intel.com with ESMTP; 27 Jan 2025 03:07:17 -0800
From: Kiran K <kiran.k@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: ravishankar.srivatsa@intel.com,
	chethan.tumkur.narayan@intel.com,
	chandrashekar.devegowda@intel.com,
	vijay.satija@intel.com,
	Kiran K <kiran.k@intel.com>
Subject: [PATCH v1] Bluetooth: btintel: Add DSBR support for ScP
Date: Mon, 27 Jan 2025 16:53:28 +0530
Message-ID: <20250127112328.48145-1-kiran.k@intel.com>
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
 drivers/bluetooth/btintel.c | 6 ++++++
 drivers/bluetooth/btintel.h | 1 +
 2 files changed, 7 insertions(+)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index 03bf96e2544f..fd1b2c0c26c5 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -2754,9 +2754,11 @@ static int btintel_set_dsbr(struct hci_dev *hdev, struct intel_version_tlv *ver)
 	int err;
 
 	cnvi = ver->cnvi_top & 0xfff;
+
 	/* DSBR command needs to be sent for,
 	 * 1. BlazarI or BlazarIW + B0 step product in IML image.
 	 * 2. Gale Peak2 or BlazarU in OP image.
+	 * 3. Scorpious Peak in IML image.
 	 */
 
 	switch (cnvi) {
@@ -2772,6 +2774,10 @@ static int btintel_set_dsbr(struct hci_dev *hdev, struct intel_version_tlv *ver)
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

