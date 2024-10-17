Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1540134A8
	for <linux-bluetooth@vger.kernel.org>; Thu, 17 Oct 2024 11:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729165011; cv=none; b=tgbDx+mLhFo8rXe4jrCwAeQoqz2ZpP99PZuSACu368QTiJy1n7soAwp2IpFefh2jtZld0qYqwH4ptWu+2MvLRttFzys5G6wRC4GpUkfYc6DBAr8jIUYAzrfNp52ml8kKaTg7hcPuYGgqt/dN4Xp1fWRNr6QvjlRIVFp/meYgeAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729165011; c=relaxed/simple;
	bh=LLOJICgVu0Un28rAjmEYdCj1PNmCSD15gVU7LEQw0Ec=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jWkKeyRQJZt/CuRIpNB4955AdmLod0K6dgt/q068W6WTO04ziKxJ0clzAoM/bUyhpMrCGecfA7wFwo9zpn6iFV1Ke2VUWYgbkppBg3uI3fOsNlLF399fFmuKt7dwaj6PEEn8BioqFhari9681jwd8a+0ICJ/DEqWoNRBZ8khJlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ed6QkzUo; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ed6QkzUo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729165009; x=1760701009;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=LLOJICgVu0Un28rAjmEYdCj1PNmCSD15gVU7LEQw0Ec=;
  b=ed6QkzUoUzyncPaU910JlErVADsbF6JMM3DNRKJh5nhqG7cTjKndtDJN
   vaAs+Jo/9zurBz/KdcgwxtweO0p23oaKzDd623+3FhsoJSEm2uI/ATzr8
   3wPI/s+aMD5q3c2KQss2gOYWFdN6bmMXXEYuR0Smw4mOIZhSqG+Hid0c4
   B/ZG4Az2d6NOZwQIgmWyDhR21d5d/MX7rHRGCweDUOJrYC/bzHiPHgrXQ
   T+RXfSkMmkuqCim0Ul70xY+Bap0m08uQT00mzD0SUJW9JbBK+wxwDz3tS
   k+IJvNwSG3AGUAWiREtW96iO6MBeOIMokKT9g2Kgu5HdripI5N2GoDZKj
   g==;
X-CSE-ConnectionGUID: RDanRHZoR2iERoEctOxxKw==
X-CSE-MsgGUID: 28Q1rx2zTaiktTbK1XVzWg==
X-IronPort-AV: E=McAfee;i="6700,10204,11227"; a="39235822"
X-IronPort-AV: E=Sophos;i="6.11,210,1725346800"; 
   d="scan'208";a="39235822"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2024 04:36:48 -0700
X-CSE-ConnectionGUID: h6VSBYYtSZycGMHJVRq7NA==
X-CSE-MsgGUID: 7ijbFKgNSrqaua3I7rxUpw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,210,1725346800"; 
   d="scan'208";a="78865262"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by fmviesa010.fm.intel.com with ESMTP; 17 Oct 2024 04:36:46 -0700
From: Kiran K <kiran.k@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: ravishankar.srivatsa@intel.com,
	chethan.tumkur.narayan@intel.com,
	chandrashekar.devegowda@intel.com,
	Kiran K <kiran.k@intel.com>
Subject: [PATCH v3] Bluetooth: btintel: Do no pass vendor events to stack
Date: Thu, 17 Oct 2024 17:21:56 +0530
Message-Id: <20241017115156.733062-1-kiran.k@intel.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

During firmware download, vendor specific events like boot up and
secure send result are generated. These events can be safely processed at
the driver level. Passing on these events to stack prints unnecessary
log as below.

    Bluetooth: hci0: Malformed MSFT vendor event: 0x02

Fixes: 3368aa357f3b ("Bluetooth: msft: Handle MSFT Monitor Device Event")
Signed-off-by: Kiran K <kiran.k@intel.com>
---
 drivers/bluetooth/btintel.c      | 6 ++++--
 drivers/bluetooth/btintel_pcie.c | 9 ++++++---
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index 2be6d48a2a65..e122dff855ba 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -3395,7 +3395,8 @@ int btintel_recv_event(struct hci_dev *hdev, struct sk_buff *skb)
 				 * indicating that the bootup completed.
 				 */
 				btintel_bootup(hdev, ptr, len);
-				break;
+				kfree_skb(skb);
+				return 0;
 			case 0x06:
 				/* When the firmware loading completes the
 				 * device sends out a vendor specific event
@@ -3403,7 +3404,8 @@ int btintel_recv_event(struct hci_dev *hdev, struct sk_buff *skb)
 				 * loading.
 				 */
 				btintel_secure_send_result(hdev, ptr, len);
-				break;
+				kfree_skb(skb);
+				return 0;
 			}
 		}
 
diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index e4ae8c898dfd..deed8052b482 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -551,7 +551,8 @@ static int btintel_pcie_recv_event(struct hci_dev *hdev, struct sk_buff *skb)
 				if (btintel_pcie_in_op(data)) {
 					btintel_pcie_wr_sleep_cntrl(data, BTINTEL_PCIE_STATE_D0);
 					data->alive_intr_ctxt = BTINTEL_PCIE_INTEL_HCI_RESET2;
-					break;
+					kfree_skb(skb);
+					return 0;
 				}
 
 				if (btintel_pcie_in_iml(data)) {
@@ -568,7 +569,8 @@ static int btintel_pcie_recv_event(struct hci_dev *hdev, struct sk_buff *skb)
 						btintel_wake_up_flag(data->hdev,
 								     INTEL_WAIT_FOR_D0);
 				}
-				break;
+				kfree_skb(skb);
+				return 0;
 			case 0x06:
 				/* When the firmware loading completes the
 				 * device sends out a vendor specific event
@@ -576,7 +578,8 @@ static int btintel_pcie_recv_event(struct hci_dev *hdev, struct sk_buff *skb)
 				 * loading.
 				 */
 				btintel_secure_send_result(hdev, ptr, len);
-				break;
+				kfree_skb(skb);
+				return 0;
 			}
 		}
 
-- 
2.40.1

