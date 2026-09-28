Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 682544F052D;
	Mon, 28 Sep 2026 17:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790615263; cv=none; b=ZhD7TYwHtKy/uBgbOBwA5fpHaPnn3zr/ExYOsC8EJgGfFz8WcHlNQhbMFL9tkbpeIyrtC/T7OJE8B4YY1t7pVEa09Gb1PvStgW6oxPGydAuQBlq8Xe5y+qYsHk7pX6oGz6fqjqYETVX21mxcQ+t2LIyuumGmcr6+2ePMmFgOEcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790615263; c=relaxed/simple;
	bh=MvhBFi87CpNeXIBn7wUX6/IqO0umWyXvM20TVoC2Wv4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p1fbyJG+sJj7VVhozMusjEZ/lJm4biZ+UM3+gApwx8TxB+aUSnPM11gC2QmsjBiHu7LDBseD6PUEaJE17i0ZepDS3B7lhWoksjYfLkwHSlHxJOrLAoHQFxYcG2++RIeHCcJvSgvyFifVUnA20m//sBNqy9R7/DPKFOnsdLyCGiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MGKAkjp/; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MGKAkjp/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790615262; x=1822151262;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MvhBFi87CpNeXIBn7wUX6/IqO0umWyXvM20TVoC2Wv4=;
  b=MGKAkjp/t7+bxITkQMihpMMv0i0xXKwAjeorNclChVmq4n2yl6CnkfYq
   7obUzLiu3CPp61CLXaXjhU0LmLYxmccaqFQQHwq8saMwjaagxXU3hGeuu
   4NBvikJM8oa/pw5ANejDvSw+5WNGCbsBEGbFJVNWYBnW88uh1bSPzwXNa
   2FJQf/OGymsUzma9o30g6yyAmjKTNbTqxiXt2JEbVQSxZj9UxRGcwOjz4
   1p8K+UYoNofuG35lpRZ9LCnrWpypvR9xD9aBKnWM0up5cwk5nLBM89h0H
   t4vfSAJS1AnyKcRaLUTXKMjRWzCN8b+9BEL3/dZOvBHsyHBmL5a9WssHI
   Q==;
X-CSE-ConnectionGUID: OhW6IWtOQqiIbutwDOqotA==
X-CSE-MsgGUID: BrRoh7QSQx+5X13CxlYS6Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11919"; a="116847888"
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; 
   d="scan'208";a="116847888"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 10:07:42 -0700
X-CSE-ConnectionGUID: fyzVlbXmRoauWq+ikRZztg==
X-CSE-MsgGUID: RjKxCgEsRdqUjbuVKr1NHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; 
   d="scan'208";a="275222348"
Received: from unknown (HELO WEBA2062.iind.intel.com) ([10.66.228.2])
  by fmviesa008.fm.intel.com with ESMTP; 28 Sep 2026 10:07:39 -0700
From: Ravindra <ravindra@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: lsa.uz@pm.me,
	pmenzel@molgen.mpg.de,
	marcel@holtmann.org,
	luiz.dentz@gmail.com,
	kiran.k@intel.com,
	chethan.tumkur.narayan@intel.com,
	linux-kernel@vger.kernel.org,
	Ravindra <ravindra@intel.com>
Subject: [PATCH v6 4/4] Bluetooth: btintel_pcie: clear the GP0 cause with a W1C write
Date: Mon, 28 Sep 2026 22:40:03 +0530
Message-ID: <20260928171003.2925480-5-ravindra@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260928171003.2925480-1-ravindra@intel.com>
References: <20260928171003.2925480-1-ravindra@intel.com>
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
index a5b0576e922c..9d3b5adfa847 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -4222,10 +4222,12 @@ static int btintel_pcie_set_dxstate(struct btintel_pcie_data *data, u32 dxstate)
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

