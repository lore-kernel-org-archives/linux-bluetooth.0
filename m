Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 216281482E4
	for <linux-bluetooth@vger.kernel.org>; Fri,  5 Jul 2024 10:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720174505; cv=none; b=Po5UkhCivj6SgjbUVUWXSlY6dXSqgVAfhEcWIuMewcrRCYcG4f2t3Fcq2ocwa5sg9g9n9Dj7NFU+jo9hGj/csPXd8sY4U5+rj9uh+c4LFTu/1n5fUZjNlyLVNAq02QuH5YxXZsrnRDuWso7k73DQoyI3zZcQZztjOfUNqVcBVyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720174505; c=relaxed/simple;
	bh=fOLMnX/L+VJiMhGOrZalmRILcxMWvY1UCyDMl2MU/FE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uPspaNmgc7nsGWVXD/iRhvH/3BqwrkGfWeio/noLn6CBGUINOAkEgjKfvxfT33XKS+Rz4kjWZTt19TY3SAdSV28jVSduhNm/jMXuYujfxJGCxkh1qTOdsbffpiqWHpg2lMtfcDdVC1zAud98b/SWCyJ/C2NwAEPPshK140aWAtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EWCKcoCY; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EWCKcoCY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720174504; x=1751710504;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=fOLMnX/L+VJiMhGOrZalmRILcxMWvY1UCyDMl2MU/FE=;
  b=EWCKcoCY1mPQEkezudDNru/yci3EOhp1DWA3J/Gg3cDOj1qU2O6KgHa9
   2sXnMbW7E5u9mwNUi6lsV0Y4Fu0hTkqCS3aX5czYpJxm7TWOi6t/k0daw
   EtkAoJg7viH+6hd4WGh8T1DthHWzagx/bgUppppcgzVwJiUaKnP+Tha4/
   R5f1SOz0kDpQegZsETlUq8y0arTUVEXGrRnjNHV6+DYUugYeFTs0HTpsR
   Fb2JcOmS3zicp2XXmZR9SW8tj9nHvQYkEZYyoqr2aOLO0q1MGY4V+WVmM
   Og1OKEpza2+9yGJ8t2uWvnxaP65TJVo3TeUSbA8yqdUa3UE01sbNl2R7M
   w==;
X-CSE-ConnectionGUID: Koz1nraYQB+mtnZsjXfNVw==
X-CSE-MsgGUID: ifsRPaClQVayDi0a2P6NBA==
X-IronPort-AV: E=McAfee;i="6700,10204,11123"; a="17415122"
X-IronPort-AV: E=Sophos;i="6.09,184,1716274800"; 
   d="scan'208";a="17415122"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2024 03:15:03 -0700
X-CSE-ConnectionGUID: JynmyeAST9S5b/3EpQrdUg==
X-CSE-MsgGUID: wY0vFnOlQeaeeO25/L4Mdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,184,1716274800"; 
   d="scan'208";a="84389883"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by orviesa001.jf.intel.com with ESMTP; 05 Jul 2024 03:15:01 -0700
From: Kiran K <kiran.k@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: ravishankar.srivatsa@intel.com,
	chethan.tumkur.narayan@intel.com,
	Kiran K <kiran.k@intel.com>
Subject: [PATCH v1 1/2] Bluetooth: btintel: Add support for BlazarU core
Date: Fri,  5 Jul 2024 15:59:22 +0530
Message-Id: <20240705102923.3512817-1-kiran.k@intel.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for BlazarU core (CNVi).

Signed-off-by: Kiran K <kiran.k@intel.com>
---
 drivers/bluetooth/btintel.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index 54bfe2ffe1d2..e7a612504ab1 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -472,6 +472,7 @@ int btintel_version_info_tlv(struct hci_dev *hdev,
 	case 0x19:	/* Slr-F */
 	case 0x1b:      /* Mgr */
 	case 0x1c:	/* Gale Peak (GaP) */
+	case 0x1d:	/* BlazarU (BzrU) */
 	case 0x1e:	/* BlazarI (Bzr) */
 		break;
 	default:
@@ -2718,6 +2719,7 @@ void btintel_set_msft_opcode(struct hci_dev *hdev, u8 hw_variant)
 	case 0x19:
 	case 0x1b:
 	case 0x1c:
+	case 0x1d:
 	case 0x1e:
 		hci_set_msft_opcode(hdev, 0xFC1E);
 		break;
@@ -3063,6 +3065,7 @@ static int btintel_setup_combined(struct hci_dev *hdev)
 	case 0x17:
 	case 0x19:
 	case 0x1b:
+	case 0x1d:
 	case 0x1e:
 		/* Display version information of TLV type */
 		btintel_version_info_tlv(hdev, &ver_tlv);
-- 
2.40.1

