Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7385E13B297
	for <linux-bluetooth@vger.kernel.org>; Wed,  3 Jul 2024 08:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719995898; cv=none; b=cBWW0sgHZveE2JWUs8hIS77filRE+9+FBCs8fEVR2JuBCeVPN1Ljzfk6Ts6AcMjMME62n8Lv6cU74ql/Wp4e9ebmqK2zxc4nPBxX7T4VP2g4Xe1ohS7I9NmS5mqQCO63FOuPRA8VsZ/3NILVazbKkZBpTvNjKL90968oDydgP+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719995898; c=relaxed/simple;
	bh=fBXoVyDjSAOdFyoKJ6Oxj4QyUSBnOPhMZwSMUs5PWjU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tWZK+c0Do796E9LFHIUjxSCnxA+J67BokGKaygyjZkR5LsMN5jCkud5rzwEdv+KmYSy0SO/hFx5E12jZ1T+hDHGt8AIHXUkaM6sr55Phne3S6pmrRQD82engkeNxwZstyQJ8+XofFBqp/54fOenqgwmC4zejRpi9ZS1UV697GXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QAApI5RI; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QAApI5RI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719995897; x=1751531897;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=fBXoVyDjSAOdFyoKJ6Oxj4QyUSBnOPhMZwSMUs5PWjU=;
  b=QAApI5RIWRi2y1dhDkE5x8ACycC+N3jYPt2TKZPmke8Qbs7L+cnyCf2B
   gffzLehqIDfLkD3uN1Vw7JJ6k6AJ9hqSXKIqB4SJ3SEZfUJ85blEc43iy
   x3zrCv986/Gh9DLxaUxEaU4dgfZciGZbHixFtfbVpiWhVkiTOp1COYexg
   R3FZp1hrvqSVsHTU5IJRoWU3TT+Sd8mFyeVIkLbAWIGIXmp151Vm2PIkS
   dp6IUTEwpJnjrHbR1BdHDehZRtX3G9rBnkJFZPHLJ8JB/mB108oNkplHV
   8wRPKrFuXU2OQ4dNUAAA91ABNt0BLjE9zX7yPDo0j27+5wc/ZRc4nYWIZ
   Q==;
X-CSE-ConnectionGUID: MgkUCGBRQG+rVKt9q7v7Lg==
X-CSE-MsgGUID: 1lGJ2fTiS5uUrsCI105rGg==
X-IronPort-AV: E=McAfee;i="6700,10204,11121"; a="28606938"
X-IronPort-AV: E=Sophos;i="6.09,181,1716274800"; 
   d="scan'208";a="28606938"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2024 01:38:16 -0700
X-CSE-ConnectionGUID: rgohVOGRRVm8W7Xr/wVdww==
X-CSE-MsgGUID: LbouojSIRe2amtOHvejFIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,181,1716274800"; 
   d="scan'208";a="51128817"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by orviesa005.jf.intel.com with ESMTP; 03 Jul 2024 01:38:15 -0700
From: Kiran K <kiran.k@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: ravishankar.srivatsa@intel.com,
	chethan.tumkur.narayan@intel.com,
	Kiran K <kiran.k@intel.com>
Subject: [PATCH v1] Bluetooth: btintel: Fail setup on error
Date: Wed,  3 Jul 2024 14:22:42 +0530
Message-Id: <20240703085242.3218277-1-kiran.k@intel.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Do not attempt to send any hci command to controller if *setup* function
fails.

Signed-off-by: Kiran K <kiran.k@intel.com>
---
 drivers/bluetooth/btintel.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index 54bfe2ffe1d2..661699258566 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -3082,6 +3082,9 @@ static int btintel_setup_combined(struct hci_dev *hdev)
 		btintel_set_dsm_reset_method(hdev, &ver_tlv);
 
 		err = btintel_bootloader_setup_tlv(hdev, &ver_tlv);
+		if (err)
+			goto exit_error;
+
 		btintel_register_devcoredump_support(hdev);
 		btintel_print_fseq_info(hdev);
 		break;
-- 
2.40.1

