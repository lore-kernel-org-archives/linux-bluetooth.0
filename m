Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 244C53909A8
	for <linux-bluetooth@vger.kernel.org>; Sun, 27 Sep 2026 15:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790522483; cv=none; b=GXQN6Xssm1L7+1IFHmt/3s4amu3S4mvr++uNzShy/wFxgc3Y087Q7DjMMvuKsscjbAWzVfy0ED+jxlZ7AiWwJwKybbQYmfIyZ2SmyEJS9dsmXZmRn6BMUBqt9af7cviXainwcCWIEw0JAqjuf2LHpUbt2/5P7eUO2QGmA8nTya8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790522483; c=relaxed/simple;
	bh=FQM/ruADMOym6KGApNEvM7khVNFquULrNY/5y63Kevk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=p/mENYUggVDHiftzV4oJJ3SNYY9JLkHWnx2HZ/tZLrrDztHPff+HBLuGBRAsFvW3HPtlekDC7eKz0zsPLg8Xja+jqs04Mny2zXXeaoA58i8T9ERUsVMgGrcglatC50xSoIhcouYtUUFrTciQ0E7pcUpvDgh+X8iVhS8z52vOx/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MSCsv3+V; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MSCsv3+V"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790522482; x=1822058482;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=FQM/ruADMOym6KGApNEvM7khVNFquULrNY/5y63Kevk=;
  b=MSCsv3+VjZDDMB0pPZiv2zUFB15uhcFxpl8WWn4KL5BOHHc7ucNckl9B
   JH2VdyKseE7NclGRHZbG/EE7njRs+YSuUFPxdoU+2Qiqx2pGs+CRwouEn
   TJfQQ6P0a+Iq0OKgXcwGmOH3txkZazUQCyvm5L/tAMVwkxQ8QfHJt2oMN
   utNGVeSbck/zo62ZjM0qtOWHCfIACFx5mB9GAqgc4UhP3XizOjcp/hy+Z
   iShN4G8/TXtWf0qI29ObGN0WbE2rF7slDf2F/HJV4GQSM691DF6ZnaMyL
   /lvMGE9R1Hrd0dXBIky8xm/NdnTMKAcgO7whwRxJEJZeFH6otsidhemBB
   w==;
X-CSE-ConnectionGUID: 0jfv1tqKRki25coyC5Wrng==
X-CSE-MsgGUID: MJFsLX2BQf+cDHEWQuZb0Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11918"; a="93951041"
X-IronPort-AV: E=Sophos;i="6.27,126,1787036400"; 
   d="scan'208";a="93951041"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2026 08:21:21 -0700
X-CSE-ConnectionGUID: ebbFKuEHTAybyStj1InO1A==
X-CSE-MsgGUID: 6A1+T64UQgWEhnpcGKxKTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,126,1787036400"; 
   d="scan'208";a="302769629"
Received: from unknown (HELO WEBA2062.iind.intel.com) ([10.66.228.2])
  by fmviesa001.fm.intel.com with ESMTP; 27 Sep 2026 08:21:18 -0700
From: Ravindra <ravindra@intel.com>
To: linux-bluetooth@vger.kernel.org,
	lsa.uz@pm.me,
	vladimirkondratyev2@gmail.com
Cc: chethan.tumkur.narayan@intel.com,
	kiran.k@intel.com,
	pmenzel@molgen.mpg.de,
	Ravindra <ravindra@intel.com>
Subject: [PATCH v4 4/4] Bluetooth: btintel_pcie: clear the GP0 cause with a W1C write
Date: Sun, 27 Sep 2026 20:53:56 +0530
Message-ID: <20260927152356.2886291-1-ravindra@intel.com>
X-Mailer: git-send-email 2.43.0
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
Tested-by: Sergey Lebedev <lsa.uz@pm.me>
Reviewed-by: Sergey Lebedev <lsa.uz@pm.me>
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

