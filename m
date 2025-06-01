Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EAE8C13D
	for <linux-bluetooth@vger.kernel.org>; Sun,  1 Jun 2025 03:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748747516; cv=none; b=IeqLuLCBB4wwAg1pmbhdErxwZmD7dwKH4DBMIstpFnpnDvbrPqa/CEsqd0Ad5ySlWcdORxjRfkKgRnYoOUrImW7JDo9P2SCQ8IzwYghlhVPRCyac34xP7XzEm+08RZ60gyogGWmnJl5vBnRliSeZMDx273OWLA/4IdsQ4KLw93g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748747516; c=relaxed/simple;
	bh=e0wuV28L3P82AR2ul0F6X9oskWte8DS+zsJXbMIeDU4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SRlUEztpoUPCCxL3e7yubyMucQ/Ru020klSUWaenAKGkKm0Tppd68Qf+X+spti05Z48IzMCZmdUskzuT1PIzKN2yOE16NdGhwgD/RtPgkT32mz9+YPg0ceyJD2xHHowzQI4W1s2sKZDCVgq46q0wVhHQPsYq6V4auTpyoOunxzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gp/ee7Z2; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gp/ee7Z2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748747515; x=1780283515;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=e0wuV28L3P82AR2ul0F6X9oskWte8DS+zsJXbMIeDU4=;
  b=gp/ee7Z2SDqt7JjnvuzmyITX7rwZBkfJG2AXs0nnt/Iyyg0weXIUkjBT
   2q831cAddJR/ERMbwGuDdGBfKeSxsDZs3FZXwZt2SbWAg5IsqQizDwfHx
   b5WtnF6VO4R6fEG8pvkk7Fru8r4Ks83UINhWa6CjLzsqEi1xkILI0cLJT
   Ao3cNARsD93280/xt74ReSR4ZuEU3ucrTkNxt/TGBcniruB71MG3FD5HS
   WykBRyJ9msvYi5iv6QdH31hd9aaK35DLw6HVfRtEPq0HzmxNUQVpsj2Gk
   fjBaZjb3SkxgGECYuxPXmo/UmdChGUEDA1MjgNwaj98wfWdEoyAT36IHL
   g==;
X-CSE-ConnectionGUID: /9wKWWn7SiynNOMgf8EiQA==
X-CSE-MsgGUID: woiYtTIOQ8qFF5mgUhtgxQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11450"; a="50491219"
X-IronPort-AV: E=Sophos;i="6.16,200,1744095600"; 
   d="scan'208";a="50491219"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2025 20:11:54 -0700
X-CSE-ConnectionGUID: Z5LOi7RBSz2ujhaZAeHISQ==
X-CSE-MsgGUID: jNKlgx40Tf+O9BHi1XuLqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,200,1744095600"; 
   d="scan'208";a="145214770"
Received: from unknown (HELO intel-Lenovo-Legion-Y540-15IRH-PG0.iind.intel.com) ([10.224.186.95])
  by fmviesa009.fm.intel.com with ESMTP; 31 May 2025 20:11:53 -0700
From: Kiran K <kiran.k@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: ravishankar.srivatsa@intel.com,
	chethan.tumkur.narayan@intel.com,
	chandrashekar.devegowda@intel.com,
	vijay.satija@intel.com,
	Kiran K <kiran.k@intel.com>
Subject: [PATCH v2 3/3] Bluetooth: btintel_pcie: Reduce driver buffer posting to prevent race condition
Date: Sun,  1 Jun 2025 08:58:24 +0530
Message-ID: <20250601032824.572001-3-kiran.k@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250601032824.572001-1-kiran.k@intel.com>
References: <20250601032824.572001-1-kiran.k@intel.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>

Modify the driver to post 3 fewer buffers than the maximum rx buffers
(64) allowed for the firmware. This change mitigates a hardware issue
causing a race condition in the firmware, improving stability and data
handling.

Signed-off-by: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>
Signed-off-by: Kiran K <kiran.k@intel.com>
---
changes from v1->v2:
- Add errata details

 drivers/bluetooth/btintel_pcie.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index 03f13de4a723..780697880d59 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -398,7 +398,12 @@ static int btintel_pcie_start_rx(struct btintel_pcie_data *data)
 	int i, ret;
 	struct rxq *rxq = &data->rxq;
 
-	for (i = 0; i < rxq->count; i++) {
+	/* WREQ-198603 - Post (BTINTEL_PCIE_RX_DESCS_COUNT - 3) buffers to
+	 * overcome the hardware issues leading to race condition at the
+	 * firmware.
+	 */
+
+	for (i = 0; i < rxq->count - 3; i++) {
 		ret = btintel_pcie_submit_rx(data);
 		if (ret)
 			return ret;
-- 
2.43.0

