Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 095E43A5E88
	for <linux-bluetooth@vger.kernel.org>; Sat, 26 Sep 2026 08:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790412642; cv=none; b=buGtG0PQhdo5vEdIZGiFbDeNeW1gGf+9WFNLm6B7BdeaKTn67bEdkCc9BOta04kvjByB4FwJVpshN8m4WnRTboTrCOPayHDo97+SAVNjCpuisffsrIEFoVDXJsxQFtTe+cOvhwKlJYXB8WUK3wohKhaFIv7KY+lCc+fkPvOtxlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790412642; c=relaxed/simple;
	bh=CncuAoSlhl7MyQxMOiNY7VNA3nioTl2WbHaMi8F2HyI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jqGR8afusd8aj2hf/QCCgS2KgEv3nHPGa6mkRbWGgX9khoVGINap2WlQ7Tj8ZKiKfDjPLjdChssOMqmBmZ2QIzbB44v/DjXFnVus7pIp1c+1tm3bObdO7vdrFBhnInFjd2CvsIfcePRQIkjhGKhXSzpfQCltYMw77ZSMXDDRUCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EHOD9WwR; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EHOD9WwR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790412640; x=1821948640;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CncuAoSlhl7MyQxMOiNY7VNA3nioTl2WbHaMi8F2HyI=;
  b=EHOD9WwRlZ2+XofF6iSB900scN7g2GLlIPG67ldV0U+6VycGgRrn7nno
   06hyZPQxuXjp7G2MwHAQ5cGgYIpRe4BLTky2mHWi+ObGqsutLKcQDGRMI
   YHqX0NW4qe7G2nonr4IVwnam8epvKGJKMXBuitUDlDb7I1GY9N917nG6h
   ptMF0Fpkr6KDred9nyLEH1wJ7KUZ0z4klBwTXif1JWONEBZ+e1xae13e8
   8nuYFgtb6r03ub2bUw4SGu60/+o9YLqd835ZzuP6s7qB93J6KwGxXnq09
   ZlUU0t4JhS5yDgNga5cBX6jtYjdnTdCNOlb74qVvzsiPwwVuDgbGS7Wry
   Q==;
X-CSE-ConnectionGUID: KPUzCsrAQA+1kNN/GPALAg==
X-CSE-MsgGUID: sEoRnmO8R0SZdp6NF9SMXg==
X-IronPort-AV: E=McAfee;i="6800,10657,11916"; a="89952819"
X-IronPort-AV: E=Sophos;i="6.27,124,1787036400"; 
   d="scan'208";a="89952819"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2026 01:50:40 -0700
X-CSE-ConnectionGUID: IL5Utm1zSeCGb/xucgN2Zw==
X-CSE-MsgGUID: mJgm49uWTbyBtKDSWYHMhA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,124,1787036400"; 
   d="scan'208";a="279264773"
Received: from unknown (HELO WEBA2062.iind.intel.com) ([10.66.228.2])
  by fmviesa004.fm.intel.com with ESMTP; 26 Sep 2026 01:50:38 -0700
From: Ravindra <ravindra@intel.com>
To: linux-bluetooth@vger.kernel.org,
	lsa.uz@pm.me,
	vladimirkondratyev2@gmail.com
Cc: chethan.tumkur.narayan@intel.com,
	kiran.k@intel.com,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	Ravindra <ravindra@intel.com>
Subject: [PATCH v4 4/4] Bluetooth: btintel_pcie: clear the GP0 cause with a W1C write
Date: Sat, 26 Sep 2026 14:23:02 +0530
Message-ID: <20260926085302.2879093-4-ravindra@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260926085302.2879093-1-ravindra@intel.com>
References: <20260926085302.2879093-1-ravindra@intel.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

MSIX_HW_INT_CAUSES is a write-one-to-clear register. Using a
read-modify-write helper writes zero to GP0, leaving the cause uncleared,
and can acknowledge unrelated pending causes through the read value.

Write only the GP0 bit directly, matching the interrupt handler's W1C
acknowledgment convention.

Fixes: 88c6216a52ea ("Bluetooth: btintel_pcie: Suspend/Resume: Controller doorbell interrupt handling")
Signed-off-by: Ravindra <ravindra@intel.com>
---
 drivers/bluetooth/btintel_pcie.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index 553fa927cf0a..9fda057ca9a1 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -4217,10 +4217,12 @@ static int btintel_pcie_set_dxstate(struct btintel_pcie_data *data, u32 dxstate)
 				    "Timeout (%u ms) on alive interrupt for D%d entry, retry count %d",
 				    dx_intr_timeout_ms, dxstate, retry);
 
-			/* clear gp0 cause */
-			btintel_pcie_clr_reg_bits(data,
-						  BTINTEL_PCIE_CSR_MSIX_HW_INT_CAUSES,
-						  BTINTEL_PCIE_MSIX_HW_INT_CAUSES_GP0);
+			/* MSIX_HW_INT_CAUSES is W1C. Write only GP0 so other
+			 * pending causes are not acknowledged here.
+			 */
+			btintel_pcie_wr_reg32(data,
+					      BTINTEL_PCIE_CSR_MSIX_HW_INT_CAUSES,
+					      BTINTEL_PCIE_MSIX_HW_INT_CAUSES_GP0);
 		}
 
 		/* gp0_received is set at the top of the handler, before the switch on
-- 
2.43.0

