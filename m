Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA11414658E
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 May 2024 13:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715864457; cv=none; b=PNkSimwEUi+fYBhqUHseqLv4JRtwrnmxxAdtToGaC81+OtZg2w38qB2C5HdRov/j5tZyLW6IkxcBNReTSBAAaDidxSNd83ieU25YwrgpPDnFxxC4BlxW7kAHEt212QWefbBYODoFIwyqfXdSSz6/n1WD7J9bbXlpoYGiTFmC/MA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715864457; c=relaxed/simple;
	bh=UelzzseOVEb5xnEvTVZqUl1Wg2Y8s5/14CVh7FmByKc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XssINKF4DoaslMBQV8ATBPato9tdq5rgFW++2N6yFsmLtpbzNHW9Zzjcy1a4/t8O2z3l8DvPVHlNGBh7Gj0SO7oWJGTU/ZGFASP61xcU7fOt4IYupFliYVzgc1wS+hVYH7P14BDIyerErGi5KsYKyBWzQS4q9oM064Ue3TIm3EU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NcwFgYsr; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NcwFgYsr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715864455; x=1747400455;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UelzzseOVEb5xnEvTVZqUl1Wg2Y8s5/14CVh7FmByKc=;
  b=NcwFgYsrBtpqE4Fv4rPFhZK0l6n29kFx672ro0SSTmnZebAn6sZ1P0Nh
   ClIShpOKHM46HNk7meVQx2gD0chNOQVEhB0jxGdPpuG8X1eN6jqIioYiT
   Aq/XZe3yMNM8gJiJJVIylgU1Rn/ymLaSskFGqsEAgJ4z6pMqY7or06RMj
   sLPOaaTt3SbSWZD4Z0Yl+k/ICqXWrSBKxThF0QefK26zPXrhcNLf1zvEf
   QoyVmbRY3fLa4QpUHkhTKP8+uFU2RtzgJGGhcFjnXJov8fsoHWq2427rB
   DJDLnKBMw2GugqTKzx9Lp3RE8pN1SeFGEAUe0v+Ya7nOT96pc6JyeeKii
   Q==;
X-CSE-ConnectionGUID: Vxx1uErKSBW3oUO+I3U3EQ==
X-CSE-MsgGUID: L9t4BmECQRiMCD6IuSsK9w==
X-IronPort-AV: E=McAfee;i="6600,9927,11074"; a="23108551"
X-IronPort-AV: E=Sophos;i="6.08,164,1712646000"; 
   d="scan'208";a="23108551"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2024 06:00:55 -0700
X-CSE-ConnectionGUID: OU6ZoC5eRz2okfKmOYXb/A==
X-CSE-MsgGUID: iEXJhYNPQoS5zrrSmid/8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,164,1712646000"; 
   d="scan'208";a="54623627"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by fmviesa002.fm.intel.com with ESMTP; 16 May 2024 06:00:53 -0700
From: Kiran K <kiran.k@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: ravishankar.srivatsa@intel.com,
	chethan.tumkur.narayan@intel.com,
	vijay.satija@intel.com,
	Kiran K <kiran.k@intel.com>
Subject: [PATCH v2 3/3] Bluetooth: btintel_pcie: Fix REVERSE_INULL issue reported by coverity
Date: Thu, 16 May 2024 18:45:10 +0530
Message-Id: <20240516131510.904787-3-kiran.k@intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240516131510.904787-1-kiran.k@intel.com>
References: <20240516131510.904787-1-kiran.k@intel.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Vijay Satija <vijay.satija@intel.com>

check pdata return of skb_pull_data, instead of data.

Fixes: c2b636b3f788 ("Bluetooth: btintel_pcie: Add support for PCIe transport")
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

