Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 413FC27452
	for <linux-bluetooth@vger.kernel.org>; Sat, 11 May 2024 05:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715405197; cv=none; b=nDsKb0rITYBXb2NsvyAuZzd4+ItCmJ8A+yCzsnWlsk/aADRfxtj9A0erPvRd3o55FkTQPzocbQ/kzZmUmhDxXkbJaLcz5tr4qZ0D8SCWn04qejRfS/0b7kEIdswCi9ae9I9ehKLLsSvdNCkwVEVlIN3fo7jboYpoIdYtEdjJKWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715405197; c=relaxed/simple;
	bh=gAYMV0I35sAlJt0TBy6UeVu0g+hDAONZcwrOCc02+RQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HXNR8WHq3pT5nCyG7qxbA3J9frEHT3zB7Nc2wO0aUcs07SzIxSt2X4EaDclEu5AihFcWLu9t9i6e8yZye2sq4o/LpXHzEdYZiA+fn5zSqvyUf9Za/fOYeQ3WrxdrNnaJxHFGZjZ8FftpFAQMRY6P5XEI1Z+lXNPogMGTgXgN3rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NiMP0glW; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NiMP0glW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715405196; x=1746941196;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gAYMV0I35sAlJt0TBy6UeVu0g+hDAONZcwrOCc02+RQ=;
  b=NiMP0glWROShEFgQQugRPhGexfzknDwFA6fXfgpGolyzTFInP+ki/huf
   bt5pzWJ6Y4CJ4Fo4C6XjvxyuZKfV4CPtVuokIvTTRs2vg4TouJowg9vf2
   tmU93Ip4WO6j5d9Hm0fGmZlYeQnGsmWqghJsI5Ky8ua50CEnbe+VPKGbO
   qowZ0TJfGPDVbZn51ZOMdlXS6WJIU1zfrGuoZ+FEMH6eYfisRtRq8rJpo
   9RTCUfHgIhBJu+KWXlPm5VCISB14LHV2y4PAsz49vERxTk9EclfR6whQK
   r9NCIYTIUairBPusgADQi5ZC0K/1YEan4H/0k+S3y0JEzqESJmMpcIxal
   w==;
X-CSE-ConnectionGUID: 2L4W8UqkSfu/tsnB+G2jDg==
X-CSE-MsgGUID: ySbXacfgSHe+1SojMYv5Ig==
X-IronPort-AV: E=McAfee;i="6600,9927,11069"; a="33917272"
X-IronPort-AV: E=Sophos;i="6.08,153,1712646000"; 
   d="scan'208";a="33917272"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 22:26:35 -0700
X-CSE-ConnectionGUID: p+6e/cVuRMSwawpn3p1NOA==
X-CSE-MsgGUID: i3rxvjHRTcGgtbQQoktEAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,153,1712646000"; 
   d="scan'208";a="29790245"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by fmviesa007.fm.intel.com with ESMTP; 10 May 2024 22:26:33 -0700
From: Kiran K <kiran.k@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: ravishankar.srivatsa@intel.com,
	chethan.tumkur.narayan@intel.com,
	chandrashekar.devegowda@intel.com,
	Kiran K <kiran.k@intel.com>
Subject: [PATCH v1 2/2] Bluetooth: btintel_pcie: Refactor and code cleanup
Date: Sat, 11 May 2024 11:10:59 +0530
Message-Id: <20240511054059.349729-2-kiran.k@intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240511054059.349729-1-kiran.k@intel.com>
References: <20240511054059.349729-1-kiran.k@intel.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Minor refactor and s/TX_WAIT_TIMEOUT_MS/BTINTEL_PCIE_TX_WAIT_TIMEOUT_MS/g.

Fixes: 8b72a66f8a35 ("Bluetooth: btintel_pcie: Add *setup* function to download firmware")
Signed-off-by: Kiran K <kiran.k@intel.com>
---
 drivers/bluetooth/btintel_pcie.c | 7 +++----
 drivers/bluetooth/btintel_pcie.h | 2 +-
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index 030a75e5d2a3..5b6805d87fcf 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -151,7 +151,7 @@ static int btintel_pcie_send_sync(struct btintel_pcie_data *data,
 
 	/* Wait for the complete interrupt - URBD0 */
 	ret = wait_event_timeout(data->tx_wait_q, data->tx_wait_done,
-				 msecs_to_jiffies(TX_WAIT_TIMEOUT_MS));
+				 msecs_to_jiffies(BTINTEL_PCIE_TX_WAIT_TIMEOUT_MS));
 	if (!ret)
 		return -ETIME;
 
@@ -1096,10 +1096,9 @@ static int btintel_pcie_send_frame(struct hci_dev *hdev,
 		hdev->stat.err_tx++;
 		bt_dev_err(hdev, "Failed to send frame (%d)", ret);
 		goto exit_error;
-	} else {
-		hdev->stat.byte_tx += skb->len;
-		kfree_skb(skb);
 	}
+	hdev->stat.byte_tx += skb->len;
+	kfree_skb(skb);
 
 exit_error:
 	return ret;
diff --git a/drivers/bluetooth/btintel_pcie.h b/drivers/bluetooth/btintel_pcie.h
index 0e596e094f80..baaff70420f5 100644
--- a/drivers/bluetooth/btintel_pcie.h
+++ b/drivers/bluetooth/btintel_pcie.h
@@ -87,7 +87,7 @@ enum {
 /* DMA allocation alignment */
 #define BTINTEL_PCIE_DMA_POOL_ALIGNMENT	256
 
-#define TX_WAIT_TIMEOUT_MS	500
+#define BTINTEL_PCIE_TX_WAIT_TIMEOUT_MS		500
 
 /* Doorbell vector for TFD */
 #define BTINTEL_PCIE_TX_DB_VEC	0
-- 
2.40.1

