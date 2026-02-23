Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA3D62E7635
	for <linux-bluetooth@vger.kernel.org>; Mon, 23 Feb 2026 17:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771866152; cv=none; b=VKHGA2+5X2jjL8l+7PoU/RbgNVww0vHeiv8DfgXG0HKOVZWtfAXhM9MUOqTQJ6KhZMmiAdHkh6CxUWfRcD2Om8Fz7JJmYndHwyV7PtySvD2PDISGCL3jG3H6NAIWffq0cvhYvoKTj3xJcuxtX1Rf9O74wi4bJv7FFmTKNcZmIIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771866152; c=relaxed/simple;
	bh=2gvfjKYAwwd6SbAs/lbiamR5Jz/CDJz7nIgEWK3JBZA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QQHWqTo205VN+Avn3QaFM0gTOuGqJXUptw68BEjYVhgefwBCggZqeZXZjMqZT13wY9hT4LAKuDxUxwT758yWCipQXU/v6p5XqqZVVQIekIJgInYc43so3pSrkUxCgce5VpVT4zgWG9DNRMDKB7lOIvolDkpCIhuI3CyjhVYgRbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RcBxYKNs; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RcBxYKNs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771866151; x=1803402151;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2gvfjKYAwwd6SbAs/lbiamR5Jz/CDJz7nIgEWK3JBZA=;
  b=RcBxYKNsroXH7sIdwvGoKxM/FfsmmjEPnjW4Pvk/m2bwLzDizKL59Jot
   MmhNGANkeu1+4Q20f3h2cPe387lVF0SU+qiGUdM7inmaHUpf4LRs638kC
   Dj6ugFI7oEfJ6ZwF+e8TNvHbSOApjt8BKRvUvAn10p+dMbYnMyUbflsw1
   d4EBucyBzrhSfNtDc254EVwNZrDwunsl5pCO1QMu82+JfK2rgc6hhh/go
   neVwfNuq2vlStJVq+Umv1lb2tjTSttvZM7iwibmzGK6WxeJwpLm2nVFQc
   eS8Bpc94bN7xOsaTnzsu0hDdrvr5Wfk5BucjJSlNJfA+B+tL8aUOaNLfz
   A==;
X-CSE-ConnectionGUID: Equp+/PkSV+00qsaF+EpBQ==
X-CSE-MsgGUID: zMTnilcsS02WGiKn5EPowg==
X-IronPort-AV: E=McAfee;i="6800,10657,11710"; a="95484471"
X-IronPort-AV: E=Sophos;i="6.21,307,1763452800"; 
   d="scan'208";a="95484471"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2026 09:02:28 -0800
X-CSE-ConnectionGUID: RYqIFQrORUyNUOj0sXQAfw==
X-CSE-MsgGUID: 1uQoS+CDSyu4yHhWi8UBqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,307,1763452800"; 
   d="scan'208";a="214698372"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by orviesa006.jf.intel.com with ESMTP; 23 Feb 2026 09:02:26 -0800
From: Kiran K <kiran.k@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: ravishankar.srivatsa@intel.com,
	chandrashekar.devegowda@intel.com,
	chethan.tumkur.narayan@intel.com,
	Kiran K <kiran.k@intel.com>
Subject: [PATCH v1 4/7] Bluetooth: btintel: Add DSBR support for ScP2 onwards
Date: Mon, 23 Feb 2026 22:51:00 +0530
Message-ID: <20260223172104.167471-4-kiran.k@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260223172104.167471-1-kiran.k@intel.com>
References: <20260223172104.167471-1-kiran.k@intel.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add DSBR support for Scorpious Peak2 cores onwards.

Refer commit eb9e749c0182 ("Bluetooth: btintel: Allow configuring drive
strength of BRI") for details about DSBR.

Signed-off-by: Kiran K <kiran.k@intel.com>
---
 drivers/bluetooth/btintel.c | 5 +++++
 drivers/bluetooth/btintel.h | 1 +
 2 files changed, 6 insertions(+)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index 26aa8ea7d33e..b3cbb61065d1 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -2823,6 +2823,7 @@ static int btintel_set_dsbr(struct hci_dev *hdev, struct intel_version_tlv *ver)
 	 * 1. BlazarI or BlazarIW + B0 step product in IML image.
 	 * 2. Gale Peak2 or BlazarU in OP image.
 	 * 3. Scorpious Peak in IML image.
+	 * 4. Scorpious Peak2 onwards + PCIe transport in IML image.
 	 */
 
 	switch (hw_variant) {
@@ -2843,6 +2844,10 @@ static int btintel_set_dsbr(struct hci_dev *hdev, struct intel_version_tlv *ver)
 			break;
 		return 0;
 	default:
+		/* Scorpius Peak2 onwards */
+		if (hw_variant >= BTINTEL_HWID_SCP2 && hdev->bus == HCI_PCI
+		    && ver->img_type == BTINTEL_IMG_IML)
+			break;
 		return 0;
 	}
 
diff --git a/drivers/bluetooth/btintel.h b/drivers/bluetooth/btintel.h
index 21c9a6c9eb9e..1d9dde3c7874 100644
--- a/drivers/bluetooth/btintel.h
+++ b/drivers/bluetooth/btintel.h
@@ -74,6 +74,7 @@ struct intel_tlv {
 #define BTINTEL_HWID_BZRI	0x1e
 #define BTINTEL_HWID_BZRU	0x1d
 #define BTINTEL_HWID_SCP	0x1f
+#define BTINTEL_HWID_SCP2	0x20
 #define BTINTEL_HWID_BZRIW	0x22
 
 struct intel_version_tlv {
-- 
2.43.0

