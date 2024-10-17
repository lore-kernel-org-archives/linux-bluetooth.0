Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF611DA0F1
	for <linux-bluetooth@vger.kernel.org>; Thu, 17 Oct 2024 10:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729159652; cv=none; b=WT7kf8EzKU+9qK4b8phU+xedfX+5fvPBV4p2dWV6GYdkdhWsnY+i9O06DeD6ffn5vgcoXcRBg3fB0tTSzc8HmCo15IZWgNF6QRAbgX7EcbmOXULi20pj/aOpMRLeXuZ3HmyFXRBMF2XFzfPsykwC/TapkUqojOAITcBKtXmimy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729159652; c=relaxed/simple;
	bh=N+mmSzGLHofbfUDMjU8xOAMvykGi+1WYA1RPjRPtvtc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LgLBtuqPCh+mFkco+qvrkMo9kMIbz2vfvP378nkeeiQmobnHdDnAyDF3ZqzmtU5/JRYvXUazizFxdAHne1+kyXvG7rLQl5OO9G19OudMF0yhxId36voTz7G3XTsNWn3qLO3LkgMGAJQ9EZQZGwmZYoRaTzgY/19pxI0uAmtbb+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=crHPo0Se; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="crHPo0Se"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729159649; x=1760695649;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=N+mmSzGLHofbfUDMjU8xOAMvykGi+1WYA1RPjRPtvtc=;
  b=crHPo0SeKHPtuBmimg4nqiAFEz9+Fr7RYXwZX2DPx1dPmQCgy5IynDfJ
   bsj1l6BZWbOasF1XBmZXY0T6f3BSyvC9u9FL49G/nPv7/V0CEtQ2+1T8o
   tKVufyEJB6ApkxSi0/HItUQdp1ZKH7t8md9hRc8QbChx6O2S3swBQeRdA
   DkVR1EF2PuML5PNFJy+k7tjeJtZoWnSFN9c3qen0frxrgxS0MTkvy3z8o
   VNhr5rPUwOXTIJntQokTm3ILQyWIOLmZ+VbqxaudgTKmHi+uVoquIv9hi
   v/0tMoNuGxCvpXj2estHSmLbiZfb/xO/T0Nw6GauSVNN99fQU2O262c3L
   A==;
X-CSE-ConnectionGUID: crbqR66FSpyNlZ/S9kcQ3A==
X-CSE-MsgGUID: 9HhvegScToukV5W5PiEHmA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="51181932"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="51181932"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2024 03:07:29 -0700
X-CSE-ConnectionGUID: +kryV3UbRN+261mhg24TNg==
X-CSE-MsgGUID: YGSz21NrTtG+//RD9B43gg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,210,1725346800"; 
   d="scan'208";a="78539287"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by fmviesa008.fm.intel.com with ESMTP; 17 Oct 2024 03:07:26 -0700
From: Kiran K <kiran.k@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: ravishankar.srivatsa@intel.com,
	chethan.tumkur.narayan@intel.com,
	chandrashekar.devegowda@intel.com,
	Kiran K <kiran.k@intel.com>
Subject: [PATCH v2] Bluetooth:btintel: Do no pass vendor events to stack
Date: Thu, 17 Oct 2024 15:52:36 +0530
Message-Id: <20241017102236.729685-1-kiran.k@intel.com>
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

