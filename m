Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 548F24EB30
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 May 2024 12:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715862318; cv=none; b=ZdwOWR7M89UyJODD/3B6KgBCemBMyHN/6YrxofuWIgdRI5ZrxOGXc7aQtAqOw/44XutwYq8pgbqb1ecVLQ4H6g8eOuR3lzu/Ljrm+i2iKf6LOz2PoZ4XsA+ATYMpXRhXPdhoFJH4+rgd5vVLpPUEVTjco+3lZxKbVUpmvAnjXcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715862318; c=relaxed/simple;
	bh=4jiXpxc3j7OALC8V2lVstSau+0Xjp6FbGvkWYtmD7IM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pYm4kZczoqsYloFv4TpNkL3QNJen/dCCGSUcpnRFx2MGmM2NfiLNYogK/3qTzW+6ggBDAkS4KeRLIGZlUVZbeIqIhckTSUs3K/hzKw+72G+8b/x5S5MxOR7nRXyUrU19nVkZ0zcxgJMg5nSyAv0nE3RORF77tzGOcp1cDkrbMbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bFc8EcYL; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bFc8EcYL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715862316; x=1747398316;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4jiXpxc3j7OALC8V2lVstSau+0Xjp6FbGvkWYtmD7IM=;
  b=bFc8EcYLIckp3ci+ZxTIy+jAZSQBa9K/FNuPnVnuLZfYlaeWuJkXSGnR
   yXtfA0ELxD6w+re+WHljWmBUqMvPafgF1Q9PWW+WGd7GBBfpIo82grpb0
   4gxa3UA+Lr/8f2Jzut6c1DwzobvKyQ1T35p1zD/+hek3kWoI2/t263xKT
   OSVLOMbS1HzG4pJt1YXLil0N4QdCDvpNWqnZqEQA0THb5DiCbitilg9y9
   hgUeq+qNqgVFJZcsTe0YV+kGlP+Ct4jQrpolFvmxVih5+4PRIxkxcwakN
   9StzyRQrRb32uMXueRXyetbk/hQp85fuIiKLfY6Ufb4wUiaPkeEXLMRFm
   g==;
X-CSE-ConnectionGUID: uUxuiVNeSgCEB6sQHOVu6Q==
X-CSE-MsgGUID: xCXYWiKPTAS7d1iiNvHINQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11074"; a="15790878"
X-IronPort-AV: E=Sophos;i="6.08,164,1712646000"; 
   d="scan'208";a="15790878"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2024 05:25:16 -0700
X-CSE-ConnectionGUID: IC8UNlyKRc2eF0iB/hNn8Q==
X-CSE-MsgGUID: U8PEVWK/QMK70+UKonz4GA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,164,1712646000"; 
   d="scan'208";a="62246365"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by orviesa002.jf.intel.com with ESMTP; 16 May 2024 05:25:14 -0700
From: Kiran K <kiran.k@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: ravishankar.srivatsa@intel.com,
	chethan.tumkur.narayan@intel.com,
	vijay.satija@intel.com,
	Kiran K <kiran.k@intel.com>
Subject: [PATCH v1 3/3] Bluetooth: btintel_pcie: Fix REVERSE_INULL issue reported by coverity
Date: Thu, 16 May 2024 18:09:38 +0530
Message-Id: <20240516123938.891523-3-kiran.k@intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240516123938.891523-1-kiran.k@intel.com>
References: <20240516123938.891523-1-kiran.k@intel.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Vijay Satija <vijay.satija@intel.com>

check pdata return of skb_pull_data, instead of data.

Signed-off-by: Vijay Satija <vijay.satija@intel.com>
Signed-off-by: Kiran K <kiran.k@intel.com>
---
 drivers/bluetooth/btintel_pcie.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index d8f82e0f6435..58144c82b1cb 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -382,7 +382,7 @@ static int btintel_pcie_recv_frame(struct btintel_pcie_data *data,
 
 	/* The first 4 bytes indicates the Intel PCIe specific packet type */
 	pdata = skb_pull_data(skb, BTINTEL_PCIE_HCI_TYPE_LEN);
-	if (!data) {
+	if (!pdata) {
 		bt_dev_err(hdev, "Corrupted packet received");
 		ret = -EILSEQ;
 		goto exit_error;
-- 
2.40.1

