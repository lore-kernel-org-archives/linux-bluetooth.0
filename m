Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 054E01474A5
	for <linux-bluetooth@vger.kernel.org>; Mon, 14 Oct 2024 08:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728895257; cv=none; b=C0DGsx4pO1yMbY8G0XvJTxJeQ3BSQaAVuSanU0ft032C1ePAc30JQriYVMPJrR+ot0BKmvwqBqoSEC3KX6AUhgEab7Mq5NjH/uoKunMOF90C6l0zwUY2UXhVo3DiWj/hxOxwNCjgPbEa2oHxIOW2xc34Xpuopm3M+OGuWPexGz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728895257; c=relaxed/simple;
	bh=4SgHT9i1JeLb+7xHKMaY1ksupXJEiJKd8k27dMYDjQw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NR1i8ge9YKdee8Day1DeHSIBWVmwq+C2VI0s7mWjX8lVzyUd6eSiSMMuUDUb6sOCEWDb60vfUOwZhWHV9zR/SU75+QkD0oiEq22wQ2JF1kRfEES9U23ugwuaPLP5oLMY8CTap6FyWRY2fMcglqzeEqjpIiWG4qgMf0mqkPOguZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=alQFKUcy; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="alQFKUcy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728895256; x=1760431256;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=4SgHT9i1JeLb+7xHKMaY1ksupXJEiJKd8k27dMYDjQw=;
  b=alQFKUcyOZLV5NwrJtv1S+gmyFTkNQpWq/5YyerinNeQ1LECS06Kr5ad
   mLoeH5HD3JLHobzaPXPfZRvD8A5gesg4fWuORRMytWXu+Av2+vtF4+jBo
   pvethiILSWRCpoeqr+NJwiC++lh8suQtF6rxtCO9XsoAxxI/QgOTw0Icv
   ShLl9/a45Uuq/h7D63+WCS3K/w+rbWFwgBtYaOCC8melYTmLGeP92Dtcz
   oDLY8NxMZkyfmWKycXddZlycHRQO6XUZYwOCf5qN7Jucs8ABm9zBer5FY
   ioOtt8pi6MOwSJlDx4zxXNKnTVvY3TYgjePyXHuWQWbC/tLKw6hRZE7cb
   w==;
X-CSE-ConnectionGUID: Q2z2a1sORQGr7wok3ku5/w==
X-CSE-MsgGUID: YrhdVrb+SpiJXk82CFdyoQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="50761430"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="50761430"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2024 01:40:55 -0700
X-CSE-ConnectionGUID: /t/ncqXCQLeje399ipcTQw==
X-CSE-MsgGUID: 0ahOA/7eTOm3KwkseCEj8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,202,1725346800"; 
   d="scan'208";a="114958027"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by orviesa001.jf.intel.com with ESMTP; 14 Oct 2024 01:40:54 -0700
From: Kiran K <kiran.k@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: ravishankar.srivatsa@intel.com,
	chethan.tumkur.narayan@intel.com,
	chandrashekar.devegowda@intel.com,
	Kiran K <kiran.k@intel.com>
Subject: [PATCH v1] Bluetooth:btintel: Do no pass vendor events to stack
Date: Mon, 14 Oct 2024 14:26:02 +0530
Message-Id: <20241014085602.711258-1-kiran.k@intel.com>
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
below warning log.

--
Bluetooth: hci0: Malformed MSFT vendor event: 0x02
--

Signed-off-by: Kiran K <kiran.k@intel.com>
---
 drivers/bluetooth/btintel.c      | 6 ++++--
 drivers/bluetooth/btintel_pcie.c | 9 ++++++---
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index 432f723e3869..652a5595fb16 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -3383,7 +3383,8 @@ int btintel_recv_event(struct hci_dev *hdev, struct sk_buff *skb)
 				 * indicating that the bootup completed.
 				 */
 				btintel_bootup(hdev, ptr, len);
-				break;
+				kfree_skb(skb);
+				return 0;
 			case 0x06:
 				/* When the firmware loading completes the
 				 * device sends out a vendor specific event
@@ -3391,7 +3392,8 @@ int btintel_recv_event(struct hci_dev *hdev, struct sk_buff *skb)
 				 * loading.
 				 */
 				btintel_secure_send_result(hdev, ptr, len);
-				break;
+				kfree_skb(skb);
+				return 0;
 			}
 		}
 
diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index d581a539d439..b2eeb6838247 100644
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

