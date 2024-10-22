Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E8315CD4A
	for <linux-bluetooth@vger.kernel.org>; Tue, 22 Oct 2024 08:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729585688; cv=none; b=hP6Fi2mkVx8PKwKUxM+5oVIIgO2SocN2UMi5HZ24NqLbJh7y6/5QnB+RMrAfUeUDP7uCS5kOXAVcTCDDCWRYXPL8cYF1bU28QlETfQS4xw9BiPNiemVk4gimZkhZEiS8iXdkFQxunREViHMCJtHqpssCcQCtt6zNpriuMTLdDb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729585688; c=relaxed/simple;
	bh=c4QH6kpzKLNeWvJM4NbcSM4DkSDG2BtINJkInosImtU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CLy7CINpnW+POimsWSgR22UtJ0JztAhW2Ga6wb3a63chSuVIhDo6gnn7vwTm51JZvsGCtaNrFCWNUojGu6hIT7k1RNPpYrF8+Fo5W+DwSJiq1SOwMBqZJ74bZF1t9GOqSppN+WtfbMX/hQg/1GEo/5n7tshRjtuRk6+Jq9pkaic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=do9DrUH3; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="do9DrUH3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729585687; x=1761121687;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=c4QH6kpzKLNeWvJM4NbcSM4DkSDG2BtINJkInosImtU=;
  b=do9DrUH36pMzZJTEwe2Z83M+ThQsGj9ssLrsO0kPzllV4wy9vkrVqR6f
   dAfaChjewKC/eah5oIx+sHsfABcOXWbQONWJWasXg44ax9qM1woVCzJXn
   Q9kTFUPWUfHnOYU0Np3sEMxL9dUReWzfUrnGRgu9+hTWndom5I2EAfv1I
   tZSdKt5JzQD31rnygsdi8GeZPg/LcSuWQ/LrDUQ9RratJETs0+QN8xHqu
   cKR54rM+I1wgGj6n24fQqCOuftj4CMUpKHYOrp4SRUWqHojPDOiu/9APC
   q5Y5DllvejKPo4VG2hz7NarL5GhF+HK5UtO2pDTbRTwySyzphS/E7ZTa6
   Q==;
X-CSE-ConnectionGUID: TYnZkun4STOGXtYK3pQsCQ==
X-CSE-MsgGUID: 03Hxf3B/RQ6a8AJKuFH4Iw==
X-IronPort-AV: E=McAfee;i="6700,10204,11232"; a="28995329"
X-IronPort-AV: E=Sophos;i="6.11,222,1725346800"; 
   d="scan'208";a="28995329"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2024 01:28:06 -0700
X-CSE-ConnectionGUID: kS3yug4aQHC5t0XualzuLg==
X-CSE-MsgGUID: oh2Zsu4qRmKVo2WhfCB8wA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,222,1725346800"; 
   d="scan'208";a="84386115"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by fmviesa005.fm.intel.com with ESMTP; 22 Oct 2024 01:28:05 -0700
From: Kiran K <kiran.k@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: ravishankar.srivatsa@intel.com,
	chethan.tumkur.narayan@intel.com,
	chandrashekar.devegowda@intel.com,
	vijay.satija@intel.com,
	Kiran K <kiran.k@intel.com>
Subject: [PATCH v1] Bluetooth: btintel: Direct exception event to bluetooth stack
Date: Tue, 22 Oct 2024 14:13:05 +0530
Message-Id: <20241022084305.790330-1-kiran.k@intel.com>
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
 drivers/bluetooth/btintel.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index e122dff855ba..e9cd7efd6853 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -3365,9 +3365,8 @@ int btintel_diagnostics(struct hci_dev *hdev, struct sk_buff *skb)
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

