Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71C1C18C05
	for <linux-bluetooth@vger.kernel.org>; Fri, 17 May 2024 09:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715938832; cv=none; b=IhBK+KPNdXyfwne8NQpXpEg1Z752GlFK+4OfwqcwEhfhFrWHS/p85LQvIqsK4bwTWN9B5tXgC6+Ss7vNtRjBc13pkKmwbVNcaH2hb90hKDFVReNmr4ZjltKI6j2m+IfInihbo5hrFhOou9NJb42At/NCeBF83Dkqhj5xbx7r+4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715938832; c=relaxed/simple;
	bh=UelzzseOVEb5xnEvTVZqUl1Wg2Y8s5/14CVh7FmByKc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FKqdgzn6SCP+GYbMMwN0CyjADHDEA3t+b7JT3SE/q/clsjaDMUxmKWS34pwFQKI4mS2Zcj2M7wZ5UdTMs/jSGCw4tx/2I+XZKAFAo3DKuF8vQEnNaXBDuapV8VDThhn4iCanuYo1/esjZ9/sTpK5n08BoEPc8QddJgSom/azsk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gN/RDQ79; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gN/RDQ79"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715938830; x=1747474830;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UelzzseOVEb5xnEvTVZqUl1Wg2Y8s5/14CVh7FmByKc=;
  b=gN/RDQ79v7FJ3ayX846YhDBuW0p9CZWYdnt7zWAzfb83Ht3HipAm+2iv
   rRO69yAkKgEZ14Cj0tlX5VtpPrPUAEWvVm6jckoBpgeXc6b/0/Xnmd177
   86x0NYb9XOHl4QFMGGRhHd02UtV3LS6XNlhYTQ75D1ullTLMbHOd2xlBK
   WzF35ROWtxYRtbYnp5fZe+mV+C4Wq0aajGBSpgJG0QdHuf/YeQD6UcLWU
   Ygjl6d0/KP1G58+V3FvcJKt2jtX2ibGAQr0DmtzeLLl0jyYqvQeLVj2ev
   SVq+LpGyiqpEg69hRC1ZFuAV2Pf/S8OTY2CG1mJDee4s3jWjCmrh/Bgkd
   g==;
X-CSE-ConnectionGUID: q+ruA1LuSTGKJ1VoPG9nww==
X-CSE-MsgGUID: DoO2b/rTTs2Lp42LwioDxg==
X-IronPort-AV: E=McAfee;i="6600,9927,11074"; a="11976648"
X-IronPort-AV: E=Sophos;i="6.08,167,1712646000"; 
   d="scan'208";a="11976648"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2024 02:40:29 -0700
X-CSE-ConnectionGUID: aRtrK44KRaWZ3ZfXI3MsDA==
X-CSE-MsgGUID: 06p2covwRWCpyWtomCvLDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,167,1712646000"; 
   d="scan'208";a="31676478"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by fmviesa007.fm.intel.com with ESMTP; 17 May 2024 02:40:27 -0700
From: Kiran K <kiran.k@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: ravishankar.srivatsa@intel.com,
	chethan.tumkur.narayan@intel.com,
	chandrashekar.devegowda@intel.com,
	vijay.satija@intel.com,
	Kiran K <kiran.k@intel.com>
Subject: [PATCH v3 3/3] Bluetooth: btintel_pcie: Fix REVERSE_INULL issue reported by coverity
Date: Fri, 17 May 2024 15:24:47 +0530
Message-Id: <20240517095447.956132-3-kiran.k@intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240517095447.956132-1-kiran.k@intel.com>
References: <20240517095447.956132-1-kiran.k@intel.com>
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

