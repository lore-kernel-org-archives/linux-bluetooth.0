Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A889D111A5
	for <linux-bluetooth@vger.kernel.org>; Mon,  1 Apr 2024 11:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711970902; cv=none; b=ofthT2lXwx22e/dV+bJCMbYqRKWprqBmzNKke02yLSLlIl8ILUPgnw9nDvrdBXtURVodlg46h+7pzBNunZYRDKRD23S8r5BjlHfPvO+ccYxRhrd+0c8oWrzY6g2Fq/Cd2yGnHPkD1dD1NossMgre6zZ9JqqkroOoY/R4wo3hOIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711970902; c=relaxed/simple;
	bh=llNEoidTs1PGKoOcwTrgT8aCwAWovixcy+PS4U2sERs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qedCC48GlTA7MRbzBbGlftsiuOLhdjQX2UJ0QElA5CJaCIWNsvC8IbVD56znQw8hRjlSJvA/FVsgHIBO/FzvyQp1CmnriuCk+d9JCuKXihn78POink0m4Vu3ZVaqinhKycdMmgzUv1swExOUR0/kZt44BJcCprMwvD2yvWedi1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h5mpuy67; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h5mpuy67"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711970899; x=1743506899;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=llNEoidTs1PGKoOcwTrgT8aCwAWovixcy+PS4U2sERs=;
  b=h5mpuy67oTtSbKkST+Eonn7YAQhD+EyfglBWCdDtYWKYArYFBv5m/FLK
   d576i2+k4zCH8zpuNRzgcNPbpOzCtztIt4gG5Uf9M9qCyreFHvTeXnT9W
   Dbk+lEGpL/bJJmuOV8lYNIOgTM2EaXaQK2lbASh0J4tj9LfIJ3tuHI0mn
   +HC27UvrmgZrsnJhCrKOwpqvKO/PBlTGJasm2U11WsIPDv5CB3SECqKRw
   yIJqeyO1DMGfcB4rYXAWNEfQarDJeNKROC2WijhHUDGsvVIk1kvqKCyTy
   BhSTQfu4B1kPUjXhkWXteY2xxY21clK44MLFLKTq2MzNyMi+8zSfxeRPR
   A==;
X-CSE-ConnectionGUID: H9JUqtLwQ1CmFCIYKLDnKA==
X-CSE-MsgGUID: fpkZaZmYRvutWQRrZliFiQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11030"; a="6958016"
X-IronPort-AV: E=Sophos;i="6.07,171,1708416000"; 
   d="scan'208";a="6958016"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2024 04:28:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,171,1708416000"; 
   d="scan'208";a="18148534"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by orviesa006.jf.intel.com with ESMTP; 01 Apr 2024 04:28:17 -0700
From: Kiran K <kiran.k@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: ravishankar.srivatsa@intel.com,
	chethan.tumkur.narayan@intel.com,
	chandrashekar.devegowda@intel.com,
	Kiran K <kiran.k@intel.com>
Subject: [PATCH v1 1/2] Bluetooth: btintel: Direct exception event to bluetooth stack
Date: Mon,  1 Apr 2024 17:12:13 +0530
Message-Id: <20240401114214.1082870-1-kiran.k@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Have exception event part of HCI traces which helps for debug.

snoop traces:
> HCI Event: Vendor (0xff) plen 79
        Vendor Prefix (0x8780)
      Intel Extended Telemetry (0x03)
        Unknown extended telemetry event type (0xde)
        01 01 de
        Unknown extended subevent 0x07
        01 01 de 07 01 de 06 1c ef be ad de ef be ad de
        ef be ad de ef be ad de ef be ad de ef be ad de
        ef be ad de 05 14 ef be ad de ef be ad de ef be
        ad de ef be ad de ef be ad de 43 10 ef be ad de
        ef be ad de ef be ad de ef be ad de

Signed-off-by: Kiran K <kiran.k@intel.com>
---
 drivers/bluetooth/btintel.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index a19ebe47bd95..f2670bc2367c 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -3135,9 +3135,8 @@ static int btintel_diagnostics(struct hci_dev *hdev, struct sk_buff *skb)
 			hci_devcd_complete(hdev);
 		} else {
 			bt_dev_err(hdev, "Failed to generate devcoredump");
-			kfree_skb(skb);
 		}
-		return 0;
+	break;
 	default:
 		bt_dev_err(hdev, "Invalid exception type %02X", tlv->val[0]);
 	}
-- 
2.34.1

