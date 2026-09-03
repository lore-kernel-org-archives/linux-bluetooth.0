Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810304A8FE1
	for <linux-bluetooth@vger.kernel.org>; Thu,  3 Sep 2026 14:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788445878; cv=none; b=a3nGUmuikGdV74olaUzvnsvcIQCulrsCk8GOnIFvNqXz//Cggb4vY8Gn5OgOru8qf65fdy9E7opCzNVttcRuAy2Apmcn483OB1HpUKHPNkxULUJnWwH7C51ik8BGdzHRkjXjd47p99e5wSutfGD7YBN7xXRDSxtqhH/FRZ21u/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788445878; c=relaxed/simple;
	bh=zPTeEmfYXKrwFm2QQig7yOIaGZXKBk6j+DNOZFRIM1I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=C/z+Z6L1fvHBEEDaeMyn+NIYtrPMoPuc+Ljy5tCS06/tMH3WVVIkQpQrj4RX6JNPMk+G59xOusllSh0W5okV00nyq31bCOBTk/6Si0UteNtdRuHNuJqCy7u7aRlhnt0djXUOYV2itOIO0k5ZHirdtxO/3jH4adcHqIQThLKtqak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZqdG7K+j; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZqdG7K+j"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788445864; x=1819981864;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=zPTeEmfYXKrwFm2QQig7yOIaGZXKBk6j+DNOZFRIM1I=;
  b=ZqdG7K+jGJvAeZ848xzgbcQD3v8g7li06OhDu93pdxWxYqiFZ2ZvFLSO
   i0s6kXNyQLRvOKRbkgbHPeJaXTCnBMvu6Cf2e8reZYZI4sKy8rRBUqZHf
   VmeHygAvxMIF2AmNB2j5KcdaPxag0pDonxYWolTFRP7e4Zr2BhGO7IZab
   trKRo7u3+4e1ARysr+L6nRmjoDBof/4RbIAT/uX41uzwdpVHh9eGszGgn
   EEuTSIv6JDNnGNW10h/xCsX7GGNC0n2viSS64hYkHbyfghWxqA7O2gJkw
   Yog9qEqEU42i/1ctD5r3XGnnKleUcE7W9f9FTlm/YW9WVaXoKXmGl+d22
   A==;
X-CSE-ConnectionGUID: mbFycu+mTu6DX0PJzymBVg==
X-CSE-MsgGUID: UTzrOSjBTQSYS+iLhAWNmA==
X-IronPort-AV: E=McAfee;i="6800,10657,11895"; a="91439993"
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; 
   d="scan'208";a="91439993"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 07:30:59 -0700
X-CSE-ConnectionGUID: QshMuhytRWK8JYa2xPaRdw==
X-CSE-MsgGUID: ZLOPokN/T2+3I+D0XCt9/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; 
   d="scan'208";a="294617136"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by fmviesa001.fm.intel.com with ESMTP; 03 Sep 2026 07:30:58 -0700
From: Kiran K <kiran.k@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: ravishankar.srivatsa@intel.com,
	chethan.tumkur.narayan@intel.com,
	chandrashekar.devegowda@intel.com,
	Kiran K <kiran.k@intel.com>
Subject: [PATCH v2 1/2] Bluetooth: btintel_pcie: validate packet_len before skb_put_data
Date: Thu,  3 Sep 2026 20:21:01 +0530
Message-ID: <20260903145102.54675-1-kiran.k@intel.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

btintel_pcie_submit_rx_work() reads packet_len from rfh_hdr without
checking if it exceeds the RX buffer size. An oversized packet_len
can lead to an out-of-bounds read in skb_put_data().

Validate packet_len to ensure it is non-zero and does not exceed
BTINTEL_PCIE_BUFFER_SIZE - sizeof(*rfh_hdr), logging an error when
invalid.

This issue was reported by Claude Mythos. It can be simulated either by
using customized firmware configured to return an invalid packet_len or
by modifying rfh_hdr->packet_len in the driver before calling
btintel_pcie_submit_rx_work().

Fixes: c2b636b3f788 ("Bluetooth: btintel_pcie: Add support for PCIe transport")
Signed-off-by: Kiran K <kiran.k@intel.com>
---
changes in v2:
- Update commit message
- Add more debug information in error message

 drivers/bluetooth/btintel_pcie.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index 30923eaabed7..281dc5261c74 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -1954,7 +1954,9 @@ static int btintel_pcie_submit_rx_work(struct btintel_pcie_data *data, u8 status
 	rfh_hdr = buf;
 
 	len = rfh_hdr->packet_len;
-	if (len <= 0) {
+	if (len == 0 || len > BTINTEL_PCIE_BUFFER_SIZE - sizeof(*rfh_hdr)) {
+		bt_dev_err(data->hdev, "Invalid packet_len %d (max %zu)", len,
+			   BTINTEL_PCIE_BUFFER_SIZE - sizeof(*rfh_hdr));
 		ret = -EINVAL;
 		goto resubmit;
 	}
-- 
2.54.0

