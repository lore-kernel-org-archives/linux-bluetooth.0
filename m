Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C861CD30
	for <linux-bluetooth@vger.kernel.org>; Wed, 27 Mar 2024 13:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711547707; cv=none; b=DGOnw00jyEH9dexrXGipgHfc9sRJEI18bPanBSzpqJYElPQSa0kQqLU5ETZkw0gId2JQljW80Gl/xsXHtM7W/8AXNdWZLrj3H1eBX5XeptBJjm8YoC4Tap0mi3s0FmOIrAdDYnMduMEr1yvJmBKCGDEFqvSLDJaLcmxBsuMPpzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711547707; c=relaxed/simple;
	bh=BM5KpyEUXw0hr6DI2WYMrYPlnnQo9WUAcrO++oNY5H0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=l5Rz9dmsJ8vg5xG7AAvzO0wjTMmtFZJJI8uRF03/+C2wyK2/7h55/WusrRHnwgkkDUzyBBpdE2vgnqZIBqDkAhjovEf6gTQ9REaaPXNffzLOaxNPD9zQQMEkRlBxK9Xl0cqQHcuDyxSFlA2ipd/GJ/i6EUDerY8HhrT8B/vcNY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TmJ6j7qI; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TmJ6j7qI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711547705; x=1743083705;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=BM5KpyEUXw0hr6DI2WYMrYPlnnQo9WUAcrO++oNY5H0=;
  b=TmJ6j7qIEzfQ8cKAyQl524RvMuSgkS9uWwEwLNZA7QpfUqd7FYHihBX9
   Emf/uV/sDmFrH4/479JklQb7Uixp+shBSNbXWJd2s7aSn6+MHPvR5g7aW
   JGkPcltxlGBiE/cdweH8ffEGpxh4TtKdj89xKZ4zmHni1zkY+uTf1HMNy
   37UyUWbWs81IXuhpt1HmB68vfmwVZeO0/cEgVMEJSLbVUKO/aQlJij63h
   6/FHv84Xi0RcXRnE+BeN/wCPdPQ0YP+y73reEj+jEW2uJ94nNuqYHEZ5v
   JRE9OHxGHTNDSNd1KPbvMFCKksncBtV6psXPrPd+kKgtHSg5s1BIGCoHA
   w==;
X-CSE-ConnectionGUID: jupSRhaBQfutJWe/d8ibQA==
X-CSE-MsgGUID: txOIh937Tti2DMXCDL42BA==
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="18079689"
X-IronPort-AV: E=Sophos;i="6.07,159,1708416000"; 
   d="scan'208";a="18079689"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2024 06:55:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,159,1708416000"; 
   d="scan'208";a="16359790"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by fmviesa009.fm.intel.com with ESMTP; 27 Mar 2024 06:55:01 -0700
From: Kiran K <kiran.k@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: ravishankar.srivatsa@intel.com,
	chethan.tumkur.narayan@intel.com,
	Kiran K <kiran.k@intel.com>
Subject: [PATCH v1] Bluetooth: btintel: Fail *setup* if firmware download fails
Date: Wed, 27 Mar 2024 19:38:55 +0530
Message-Id: <20240327140855.896095-1-kiran.k@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If firmware download fails for any reason, *setup* shall return
immediately on error.

Fixes: af395330abed ("Bluetooth: btintel: Add Intel devcoredump support")
Signed-off-by: Kiran K <kiran.k@intel.com>
---
 drivers/bluetooth/btintel.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index a19ebe47bd95..2d9c06a61db5 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -2948,6 +2948,9 @@ static int btintel_setup_combined(struct hci_dev *hdev)
 			btintel_set_msft_opcode(hdev, ver.hw_variant);
 
 			err = btintel_bootloader_setup(hdev, &ver);
+			if (err)
+				goto exit_error;
+
 			btintel_register_devcoredump_support(hdev);
 			break;
 		default:
@@ -3025,6 +3028,9 @@ static int btintel_setup_combined(struct hci_dev *hdev)
 		btintel_set_msft_opcode(hdev, ver.hw_variant);
 
 		err = btintel_bootloader_setup(hdev, &ver);
+		if (err)
+			goto exit_error;
+
 		btintel_register_devcoredump_support(hdev);
 		break;
 	case 0x17:
@@ -3050,6 +3056,9 @@ static int btintel_setup_combined(struct hci_dev *hdev)
 		btintel_set_dsm_reset_method(hdev, &ver_tlv);
 
 		err = btintel_bootloader_setup_tlv(hdev, &ver_tlv);
+		if (err)
+			goto exit_error;
+
 		btintel_register_devcoredump_support(hdev);
 		btintel_print_fseq_info(hdev);
 		break;
-- 
2.34.1

