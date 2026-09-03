Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662D74B66FC
	for <linux-bluetooth@vger.kernel.org>; Thu,  3 Sep 2026 14:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788445885; cv=none; b=oPqqVydqlgS1WmzOZaS2FOIvI1pMm19HUHmRDwzU0LhYNrWCqJoCaiAIP8kb80RSsDjeMtDDqN/IcKbB4o1SaN8soKnax9JB11L/FWX9tgGb0ojPBJLL0pECybetwU+EI7veKlTGScTIaLLOLBF1Lmuub6VuRfdWKx0v84jqxoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788445885; c=relaxed/simple;
	bh=ezox7jC2UJNC6ZNGrBn0pMaiso+SSF6/WJSYMJ+ZS7w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dv4vJq3dV66+U1EaxMSr7HqQlTkZTeBlOrfadU9TqdZKNvtfB6I9yMpyAHDsEbiTzYPziCHdUaTSsidknPV5Ry11u0EnDLZ+wfduswGXnILszFdDJLQ/bUyFB3vOzDwZbmygR0paQZZ4FL8ix5Aj2ewk/L0C3bwthDCDlYS55eU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aR3/yrew; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aR3/yrew"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788445880; x=1819981880;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ezox7jC2UJNC6ZNGrBn0pMaiso+SSF6/WJSYMJ+ZS7w=;
  b=aR3/yrewCEwLPPf12dvEV6eY0NaHMT5yReM4xwsiq9GnS5X+r/CRobFl
   ieiiwwTo9m++5nWhKTBb4GTnzHq4R7ANpIeeiNXIGT48BVxzmRzVbeVQj
   XgBmaV+ZNqgFKJqQi40yKx5JvKOfeUOr5p9PDNflOWZ5d2PMbsJwOlLWd
   RonHetk8FzN73IeUBzScfQqXlyOBLDMEalPch4HYdFqRamETbTPxJF2+h
   qdgHBQNwG6et41F5UZLsgJV9mYq1J0y3rK3vZNCOOmRJEaW+iuCp5i6vw
   /a1CX2UxASGpCTgVb1/c2aJujky/ZAcqYnsu8Ja44cWAXWc/IhFLghT7X
   w==;
X-CSE-ConnectionGUID: MPGOGVTmSUC6YDWmG3d/MA==
X-CSE-MsgGUID: CTA/1NAKSS+hg5Fh4iczQw==
X-IronPort-AV: E=McAfee;i="6800,10657,11895"; a="91439996"
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; 
   d="scan'208";a="91439996"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 07:31:01 -0700
X-CSE-ConnectionGUID: Wipviq2rS+GTD0hhMTHCbg==
X-CSE-MsgGUID: 5bQpPj8YRei843wOzJr8mQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; 
   d="scan'208";a="294617140"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by fmviesa001.fm.intel.com with ESMTP; 03 Sep 2026 07:31:00 -0700
From: Kiran K <kiran.k@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: ravishankar.srivatsa@intel.com,
	chethan.tumkur.narayan@intel.com,
	chandrashekar.devegowda@intel.com,
	Kiran K <kiran.k@intel.com>
Subject: [PATCH v2 2/2] Bluetooth: btintel_pcie: fix tx_handle bounds off-by-one
Date: Thu,  3 Sep 2026 20:21:02 +0530
Message-ID: <20260903145102.54675-2-kiran.k@intel.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260903145102.54675-1-kiran.k@intel.com>
References: <20260903145102.54675-1-kiran.k@intel.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Valid indices into txq->urbd0s/tfds/bufs are 0..txq->count-1, so
tfd_index == txq->count is already out of range. Change the guard in
btintel_pcie_msix_tx_handle() from '> txq->count' to '>= txq->count'.

This issue was reported by Claude Mythos.

Fixes: c2b636b3f788 ("Bluetooth: btintel_pcie: Add support for PCIe transport")
Signed-off-by: Kiran K <kiran.k@intel.com>
---
changes in v2:
- Update commit message

 drivers/bluetooth/btintel_pcie.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index 281dc5261c74..e02f8ae8d8d9 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -1423,7 +1423,7 @@ static void btintel_pcie_msix_tx_handle(struct btintel_pcie_data *data)
 
 		urbd0 = &txq->urbd0s[cr_tia];
 
-		if (urbd0->tfd_index > txq->count)
+		if (urbd0->tfd_index >= txq->count)
 			return;
 
 		cr_tia = (cr_tia + 1) % txq->count;
-- 
2.54.0

