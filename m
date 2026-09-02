Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BEBF47DFA8
	for <linux-bluetooth@vger.kernel.org>; Wed,  2 Sep 2026 12:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788353901; cv=none; b=HlXS/bfL8RfdjE2l/rZ4PQvMHu/yrPlwMeYIGz7R3YUbNm/LA42IHvomjfgvau3/3eM8EO2uWNuiUSnKNB7AO+bY5CeucqpojLHinNP2zaKK5ciglR97g699oHf3YiAGe1w1iQXCYa6CYPeiO3+J3Ic2eOuCk9Ftog9H7GyRzwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788353901; c=relaxed/simple;
	bh=TWYciRnNlqblwx1wox0gteCZ7Sp/7fzvPiVkWxh5oOY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rtOp7DL35jcrxC5EWE2EJ6/K4j7thNJ1yAlmPIv4jc/51eINRrGC7zAF7i5lycUPDcUmNsFqnFMsdsNF2qDyhdjrQLzkaK+bBdA6Zhr4R8C5phxy2TrspbEt9fSRUqSiPlrLdjTJAPSu6RewqoAysVU7X/uVYsCZ0DWw1P19VFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Gz3flKOc; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Gz3flKOc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788353900; x=1819889900;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=TWYciRnNlqblwx1wox0gteCZ7Sp/7fzvPiVkWxh5oOY=;
  b=Gz3flKOcWTzIlt8QsX2bdJu6T+aiGMfEhrHhpjYmJkU1cJP8iyaixijo
   WbF+DTsEaA/d3BRrEvjKuPKzHEzqZoCzBCoZz1B6neCESdkYDGXyT+B5h
   lqPUgzaa7v+e3tGJGjRUnWZthnQ1F3kwbG80x8bfDJRnac8cy2Y+0s1iq
   E8Jxt22empVshOWnlVkcYrc5Sy3VmNmf+Uef+hWblZ1LJyg8z37L3CqaW
   YqfZPToPTTuSWng1m1lJKKU+mvgcvj2DncX3rqarRVt046vsizwaIdG7S
   KlJPckA2LjKryEe8CfxBid0UDLUCAeRWRW0MayG0+mRYFlItIazWB+mia
   A==;
X-CSE-ConnectionGUID: I5CIwbtNR5yqCOKQAPdTpg==
X-CSE-MsgGUID: hsNOI/bJRPOHsKY5NRltsw==
X-IronPort-AV: E=McAfee;i="6800,10657,11893"; a="92630867"
X-IronPort-AV: E=Sophos;i="6.25,257,1779174000"; 
   d="scan'208";a="92630867"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2026 05:58:19 -0700
X-CSE-ConnectionGUID: zKz20dv9T5iTcQx0jEKXuw==
X-CSE-MsgGUID: GY1mUzRwTF+uyormpNoIuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,257,1779174000"; 
   d="scan'208";a="272912822"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by orviesa003.jf.intel.com with ESMTP; 02 Sep 2026 05:58:17 -0700
From: Kiran K <kiran.k@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: ravishankar.srivatsa@intel.com,
	chethan.tumkur.narayan@intel.com,
	chandrashekar.devegowda@intel.com,
	Kiran K <kiran.k@intel.com>
Subject: [PATCH v1 1/2] Bluetooth: btintel_pcie: validate packet_len before skb_put_data
Date: Wed,  2 Sep 2026 18:48:29 +0530
Message-ID: <20260902131830.35502-1-kiran.k@intel.com>
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

Fixes: c2b636b3f788 ("Bluetooth: btintel_pcie: Add support for PCIe transport")
Signed-off-by: Kiran K <kiran.k@intel.com>
---
 drivers/bluetooth/btintel_pcie.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index 30923eaabed7..1eabb0c8326f 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -1954,7 +1954,8 @@ static int btintel_pcie_submit_rx_work(struct btintel_pcie_data *data, u8 status
 	rfh_hdr = buf;
 
 	len = rfh_hdr->packet_len;
-	if (len <= 0) {
+	if (len == 0 || len > BTINTEL_PCIE_BUFFER_SIZE - sizeof(*rfh_hdr)) {
+		bt_dev_err(data->hdev, "Invalid packet_len %d", len);
 		ret = -EINVAL;
 		goto resubmit;
 	}
-- 
2.54.0

