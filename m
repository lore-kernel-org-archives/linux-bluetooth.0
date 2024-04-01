Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A3038DD8
	for <linux-bluetooth@vger.kernel.org>; Mon,  1 Apr 2024 12:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711973537; cv=none; b=poiCWKsyg8WLtxMXsOhos7GLd3yZp/MbO0kJKfKcIhiesBTS5AQsrZtZJdyOw5OUjviMf6NRqmU1pXJr+iytnATuZovB36nCqhO7nGM5DWRMdMRO4H5H4xRiRyRQlTAx/iAnAiGrWnuJJn2vnnfQSTiy+OmeL7U59rCLgyXoTdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711973537; c=relaxed/simple;
	bh=WFZuHYkyA0WtZFhWiqwtz3AAlvhc0O0TbeufMDXS6o8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=d0I5WlTYLuHroVdcN41WKe4B2d41GzwqI+lon+3oB39P/44WF24QssRFVyj9fgFPuZxVlRU5UWjwC8CwSCNSNx+m9uIhINYtaDg+u7GQ89qKUYcAvYa3W6ZLT3MYB2WJd71w/nRfGEBDK86NyDXUFOGHYnAgZxTIgzurp3vyVRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=azNuCFQI; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="azNuCFQI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711973535; x=1743509535;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WFZuHYkyA0WtZFhWiqwtz3AAlvhc0O0TbeufMDXS6o8=;
  b=azNuCFQIGy5hB2J5uvFKTux4f01MhAKQOwcD/hWMxMfhJynJzNE8egIY
   Jn2VJ1y3IzpPoghejtXURP3/eaBGLCg78Ah0B08CXVcodo3Z1i00dz6eE
   LJY6un55/fClh1o7PzZnjBeQ5oVlP0Gt3XYjCMbRWdSy9r6UqSLm3ze1H
   9eOLXH1LccnbdYl4J+FUPUqzvET1LwqRE4pY2zdA0EVv+sg0MBOJ1IyOX
   Ps4e4oVfNwusDAMH1R95H9F758XyxDzWzhdmqpigImut4BMRoCZHo9Dss
   D5nlNwgzxScwSjNIC3rDmUQ1o8+51jRPu3Qxsp3BHInPRF+gtyyoS5I41
   w==;
X-CSE-ConnectionGUID: KeIZ+OPUSfelb20DoJ/JCA==
X-CSE-MsgGUID: ntjTRpJtTaiZaJOlMi9CAg==
X-IronPort-AV: E=McAfee;i="6600,9927,11030"; a="17668342"
X-IronPort-AV: E=Sophos;i="6.07,172,1708416000"; 
   d="scan'208";a="17668342"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2024 05:12:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,172,1708416000"; 
   d="scan'208";a="22362869"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by fmviesa004.fm.intel.com with ESMTP; 01 Apr 2024 05:12:12 -0700
From: Kiran K <kiran.k@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: ravishankar.srivatsa@intel.com,
	chethan.tumkur.narayan@intel.com,
	Kiran K <kiran.k@intel.com>
Subject: [PATCH v2 2/2] Bluetooth: btintel: Direct exception event to bluetooth stack
Date: Mon,  1 Apr 2024 17:55:59 +0530
Message-Id: <20240401122559.1097489-2-kiran.k@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240401122559.1097489-1-kiran.k@intel.com>
References: <20240401122559.1097489-1-kiran.k@intel.com>
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
 drivers/bluetooth/btintel.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index c0dbbd1a2032..dde1dc45df9c 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -3138,13 +3138,12 @@ static int btintel_diagnostics(struct hci_dev *hdev, struct sk_buff *skb)
 			       skb->data, skb->len, false);
 		/* Generate devcoredump from exception */
 		if (!hci_devcd_init(hdev, skb->len)) {
-			hci_devcd_append(hdev, skb);
+			hci_devcd_append(hdev, skb_clone(skb, GFP_KERNEL));
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

