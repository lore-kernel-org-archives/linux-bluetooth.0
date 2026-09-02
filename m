Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF6121E1DF0
	for <linux-bluetooth@vger.kernel.org>; Wed,  2 Sep 2026 12:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788353902; cv=none; b=XbsEOTrksQ5QrJ6xTAbaIa9tWjRlKJesl6PK+b0Z19w4f234oSIYvLWiwqZRLU64cdM8kGw/SSnONmi9zvEbTyhA6vgHWssFNViqAZwP2b1P4Dx5zCOd+7S2YglmuIoDE3wh2i8qttbN8/k9/tG/KYrdUcIeThNnPSA0c0OzOIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788353902; c=relaxed/simple;
	bh=nbnCUrcKqzOD+3zfFHYLx6HxSQ2VWbeMhnX9aUp4dd4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K8ULI68ZqD+ABm0I+jdZ7C6BLF3JCCMcPgNcYE4zeu/cmCqviWZY4cspPHpdMpWcnx9XSugXAZWvxCe9wWKmeiqpmO1ge+AfqQ6J2RNlfJqZ3MizOJYzfdGL2Gj6m1MLlZ4eJ4oHLzd9LpES5LtjO1GN7IPeMVhWfvIdDZ+2jMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gG0m/nAf; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gG0m/nAf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788353901; x=1819889901;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nbnCUrcKqzOD+3zfFHYLx6HxSQ2VWbeMhnX9aUp4dd4=;
  b=gG0m/nAfjIW/QRIMGLLTUI1p61wVpCaBmkxx1nfayCdilFqZMJ+3huiK
   neG7Y8eEM6NihOijy1XjMk8j4MTF51URe4LSOrtp4sx4Fl3bnQSk/ngPi
   vDE1l47mEM1Sv5ePErzG47TY0vD5uOZzJ+yC44KnpvChPpuRr79ZP5Ddy
   EydkmUpNWhlDOZYl1mIszsWiONe8OXTPqViT6eSrsZKRL3OJ6NHhkK3ZV
   q1nLsF7bMDYO5SDlqlY26mSYTn1ftwDUkGEjYkZ+uBZO58iIrsamQLjDN
   +lNXh68dtGU4vN6YIxbU9lBAQ3/pC3vhi5EaeVYmDnPZFS/n2Wlxq9TNj
   Q==;
X-CSE-ConnectionGUID: o+wfJj9uRe6Udng4JGCRgg==
X-CSE-MsgGUID: Ez6HwA85TViRa+leL9clOw==
X-IronPort-AV: E=McAfee;i="6800,10657,11893"; a="92630872"
X-IronPort-AV: E=Sophos;i="6.25,257,1779174000"; 
   d="scan'208";a="92630872"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2026 05:58:20 -0700
X-CSE-ConnectionGUID: T9F13K8VQnGLNz9GWI9suA==
X-CSE-MsgGUID: yUKZ7WxDT9+J8oaphqv1CQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,257,1779174000"; 
   d="scan'208";a="272912831"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by orviesa003.jf.intel.com with ESMTP; 02 Sep 2026 05:58:18 -0700
From: Kiran K <kiran.k@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: ravishankar.srivatsa@intel.com,
	chethan.tumkur.narayan@intel.com,
	chandrashekar.devegowda@intel.com,
	Kiran K <kiran.k@intel.com>
Subject: [PATCH v1 2/2] Bluetooth: btintel_pcie: fix tx_handle bounds off-by-one
Date: Wed,  2 Sep 2026 18:48:30 +0530
Message-ID: <20260902131830.35502-2-kiran.k@intel.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260902131830.35502-1-kiran.k@intel.com>
References: <20260902131830.35502-1-kiran.k@intel.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Valid indices into txq->urbd0s/tfds/bufs are 0..txq->count-1, so
tfd_index == txq->count is already out of range. Change the guard in
btintel_pcie_msix_tx_handle() from '> txq->count' to '>= txq->count'.

Fixes: c2b636b3f788 ("Bluetooth: btintel_pcie: Add support for PCIe transport")
Signed-off-by: Kiran K <kiran.k@intel.com>
---
 drivers/bluetooth/btintel_pcie.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index 1eabb0c8326f..e2cd27fef0c4 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -1423,7 +1423,7 @@ static void btintel_pcie_msix_tx_handle(struct btintel_pcie_data *data)
 
 		urbd0 = &txq->urbd0s[cr_tia];
 
-		if (urbd0->tfd_index > txq->count)
+		if (urbd0->tfd_index >= txq->count)
 			return;
 
 		cr_tia = (cr_tia + 1) % txq->count;
-- 
2.54.0

