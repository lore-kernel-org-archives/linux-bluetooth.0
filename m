Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F7C155330
	for <linux-bluetooth@vger.kernel.org>; Tue, 22 Oct 2024 08:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729587420; cv=none; b=jbpsUd/ohN9ZHUFq5Dr3w9y2AHbcY7dAO4LvqyB50n58C+M7hdzRvRZM7n0Pd/g0/SKTK/qXiHvdwwnmnIiMKpRtxvSEO2yP33+21YAGWVZ1Quo67kTusLl6/ehm7zxZJ+e46wKWWNZDnmTcCouDI6a+601v5XO2C+sUHrrq/JQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729587420; c=relaxed/simple;
	bh=2W1ZxsePxU5bjrWvkagbbbQ6cTVCGr+W4Yzmfnf3dHo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XnF9cy/FAap3oco9x++pKXPz89jOnz8QCT+pUqHT4Oq7WHMsefOR948qC4a/fv1CQd8kgPP687lzWBeYpupFdTe+uGMOzKH0V3TZfnOq3wZuJaOcsyvLCR3fYwIL0U3T82j2F1ikLuOigCyO1DnlHWbHuKgSsRjPM8Pm/DeZBS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cYPjZQk/; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cYPjZQk/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729587418; x=1761123418;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=2W1ZxsePxU5bjrWvkagbbbQ6cTVCGr+W4Yzmfnf3dHo=;
  b=cYPjZQk/5OYuaPpOwfQVeF3p1Nr/bnkIVSXklXaIUwA0AW9mAtx2WY8r
   QQaL0E5a66PDW6JJzTECMSVhv0wlC10hGtvUbbINmtuNsRa1nPO2XGJwj
   /rYSTQlZX4/23HqkXuJ4QvHnIWJVGNHJnb/hor8GHEyNwjVgQ7hdOoihP
   vYZVxUFY8pMWzZJVKzPzeNgQxeeEIbsjjIf+WLgRe5sjcSnUCdfe3Vle2
   DL13oSxtqXysU0+0L71HdSFwbLGRbnAurCxAUa7oNu2Whj69XcpHbZjD4
   MDeWqvopyyHWIhqZCSadu7XfG8/OHCwNRhYK0NmtDoij7PSxK0pZR4m3Z
   Q==;
X-CSE-ConnectionGUID: hFTIZpfQQDCwbIFdORCU0g==
X-CSE-MsgGUID: Yie3GfluRtyL7aV5rUh+Hg==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="40230514"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="40230514"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2024 01:56:57 -0700
X-CSE-ConnectionGUID: bhBoAHPkRU26t2wR8h2ugg==
X-CSE-MsgGUID: c3oGQsd1T6WrU+bFtK12SA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,222,1725346800"; 
   d="scan'208";a="79968781"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by orviesa006.jf.intel.com with ESMTP; 22 Oct 2024 01:56:56 -0700
From: Kiran K <kiran.k@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: ravishankar.srivatsa@intel.com,
	chethan.tumkur.narayan@intel.com,
	chandrashekar.devegowda@intel.com,
	vijay.satija@intel.com,
	Kiran K <kiran.k@intel.com>
Subject: [PATCH v2] Bluetooth: btintel: Direct exception event to bluetooth stack
Date: Tue, 22 Oct 2024 14:41:34 +0530
Message-Id: <20241022091134.791527-1-kiran.k@intel.com>
X-Mailer: git-send-email 2.40.1
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

Fixes: af395330abed ("Bluetooth: btintel: Add Intel devcoredump support")
Signed-off-by: Kiran K <kiran.k@intel.com>
---
 drivers/bluetooth/btintel.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index e122dff855ba..d496cf2c3411 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -3361,13 +3361,12 @@ int btintel_diagnostics(struct hci_dev *hdev, struct sk_buff *skb)
 	case INTEL_TLV_TEST_EXCEPTION:
 		/* Generate devcoredump from exception */
 		if (!hci_devcd_init(hdev, skb->len)) {
-			hci_devcd_append(hdev, skb);
+			hci_devcd_append(hdev, skb_clone(skb, GFP_ATOMIC));
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
2.40.1

