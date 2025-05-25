Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D69B208CA
	for <linux-bluetooth@vger.kernel.org>; Sun, 25 May 2025 05:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748150595; cv=none; b=T0QhfKNcNeqACa0dU4Y2/eeDKQ7n6xmjsRpsDGzEP+MosW/wFgLUvxc5irZcU1uXPpxUFUit8GbXIAufibjqPw9YwqxY56It/tOwo1Spa++q4OhPQkJstlD5hYrCrIqpHPamglqYQ2UKgZmqUHeMKmOvibda8PYL3CNsT37sy/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748150595; c=relaxed/simple;
	bh=lnnrjuBUBBNiXjj5NiuFHbHbdooEDMAX6mzfSyhXIhU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OGuhAaHZsT7atAaZzFx/HQ4RQvjK5/fvV6AhtHHnVad1o+px7CCQy1klX2kIK3Q+Wo8TE3oTGbPjjLwwCiGOHVHMzt17VErHQi3bjAEHLWIbUQf9r1T4Bfi46LiWFpH8hAboB4d0VWLgCEoDwYNiVNI/uG/iJJ/XERbrHCNH3pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MlaNOw83; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MlaNOw83"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748150593; x=1779686593;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=lnnrjuBUBBNiXjj5NiuFHbHbdooEDMAX6mzfSyhXIhU=;
  b=MlaNOw83/BhT++1mVKG9WJbHCOs5WLDT5d7Pm9KJk07NZFfpx1rpyKqR
   HRsB/EBvo9XT9xegxL7BaKAbFCkjJ0QxCQ44nKI+Qe2JqQhe0C+sr/AqN
   FJtbphGJgJuY3l3yXHMdnb8kQNl0YZqU75gbhofGyNcw6mAywPCVX7pSl
   KsTqtcBlPqtzdT3By/FQu8aYU/9eWrDBN8/PHowV7fzC2Vg2/qJG/Mb5C
   l99Trpl31OU/h+bgqA0wI2ln2SK/2YlZWCxhvFn4IfRJ31Vj5bjeqmPda
   iQTBFg2Bmw/5MfR/DBJjDcPcno0ccd8ODpgYd0iNqgjZiRmn6tuEzFbYv
   g==;
X-CSE-ConnectionGUID: KQjY1RaRS4ihaDXa9YX/hA==
X-CSE-MsgGUID: kOr7wfHSRoG/owzJwhKzEw==
X-IronPort-AV: E=McAfee;i="6700,10204,11443"; a="61208327"
X-IronPort-AV: E=Sophos;i="6.15,312,1739865600"; 
   d="scan'208";a="61208327"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2025 22:23:11 -0700
X-CSE-ConnectionGUID: 6ujmUrKASb2w2XTPKIJmTA==
X-CSE-MsgGUID: MJVNdyWfRrOXLIcShAVecw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,312,1739865600"; 
   d="scan'208";a="146656270"
Received: from unknown (HELO intel-Lenovo-Legion-Y540-15IRH-PG0.iind.intel.com) ([10.224.186.95])
  by fmviesa005.fm.intel.com with ESMTP; 24 May 2025 22:23:09 -0700
From: Kiran K <kiran.k@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: ravishankar.srivatsa@intel.com,
	chethan.tumkur.narayan@intel.com,
	chandrashekar.devegowda@intel.com,
	vijay.satija@intel.com,
	Kiran K <kiran.k@intel.com>
Subject: [PATCH v1 1/3] Bluetooth: btintel_pcie: Fix driver not posting maximum rx buffers
Date: Sun, 25 May 2025 11:09:38 +0530
Message-ID: <20250525053940.520283-1-kiran.k@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The driver was posting only 6 rx buffers, despite the maximum rx buffers
being defined as 16. Update the driver to post the full 16 Rx buffers to
utilize the maximum capacity and improve performance.

Signed-off-by: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>
Signed-off-by: Kiran K <kiran.k@intel.com>
Fixes: c2b636b3f788 ("Bluetooth: btintel_pcie: Add support for PCIe transport")
---
 drivers/bluetooth/btintel_pcie.c | 3 ++-
 drivers/bluetooth/btintel_pcie.h | 3 ---
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index 50fe17f1e1d1..2c7731803c9f 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -396,8 +396,9 @@ static int btintel_pcie_submit_rx(struct btintel_pcie_data *data)
 static int btintel_pcie_start_rx(struct btintel_pcie_data *data)
 {
 	int i, ret;
+	struct rxq *rxq = &data->rxq;
 
-	for (i = 0; i < BTINTEL_PCIE_RX_MAX_QUEUE; i++) {
+	for (i = 0; i < rxq->count; i++) {
 		ret = btintel_pcie_submit_rx(data);
 		if (ret)
 			return ret;
diff --git a/drivers/bluetooth/btintel_pcie.h b/drivers/bluetooth/btintel_pcie.h
index 21b964b15c1c..5ddd6d7d8d45 100644
--- a/drivers/bluetooth/btintel_pcie.h
+++ b/drivers/bluetooth/btintel_pcie.h
@@ -177,9 +177,6 @@ enum {
 /* Doorbell vector for TFD */
 #define BTINTEL_PCIE_TX_DB_VEC	0
 
-/* Number of pending RX requests for downlink */
-#define BTINTEL_PCIE_RX_MAX_QUEUE	6
-
 /* Doorbell vector for FRBD */
 #define BTINTEL_PCIE_RX_DB_VEC	513
 
-- 
2.43.0

