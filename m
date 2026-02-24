Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4439039E19C
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Feb 2026 15:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771946186; cv=none; b=ApJEBbZ6DO+GwcZiklY/WuKiU57WC32AfZff+5mgPZxyUbMpoOFJxdfrYATeUfuRWaHed6axe+5C5FMXVJOXukXfMPYn+ddbUlrUG0P7GZkLPxbjOLsh5reU8CekFZDp3F86ixaY6L1tqlbyupN4c7r4WOHq5xJ6DhXZ2xH5v5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771946186; c=relaxed/simple;
	bh=FInTdW/meee/L6cR+upnz3vhOYIFS2HzEK8/lr+9Li0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qv2Php9UOTnoOpAhB54e/16BafhfvOFN58ZJmUyaVBJA+eqwmptvkIys6pq0+pYQrdEtdnJaFaqaoMWTEKnVIZykIHXM9xzu4OzkmMbIFmB6X7l1uNiUbNEC4y7GvlfD0N8mYr0QYjkIUcanC0r+dP4C6i1dOCE7pwOPAo+2Cec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iFI1YapD; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iFI1YapD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771946185; x=1803482185;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FInTdW/meee/L6cR+upnz3vhOYIFS2HzEK8/lr+9Li0=;
  b=iFI1YapD8qS8WtDBBBblbpFzvRxZCm+v3fcJoOPSFRu5fdfSq+rZ5PAp
   DeEKF/C3Z5fugSlVwDjiEHrBwdhEeUZvBBav2IIn/+9CoOf6r9EyrqCfA
   oiibyyJ4tjLv8pzFdfBlwm4KP+C2I8usjjVuJj5m7gZ/N6FV4dXvJwNWc
   k5kDIPyBrXHlAVPriXy0USYFPIOWg/Ciz3oIxyqAginybec0GGBztvX4A
   fzIZJWAq4RJPIgQ2l4AZapCh1lVk2oZ73G+DU44okCqo1m+YhAKutO0zG
   6gzevPSERLPYoPQvol5I3EtNjBHQAhFHcbsxQuckmLFwdhbnlGt60/r7a
   A==;
X-CSE-ConnectionGUID: 2U+3EqQgT3ew2TbUTnm2tQ==
X-CSE-MsgGUID: fg9QcbWiRearO7SDSM78aQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11711"; a="72874706"
X-IronPort-AV: E=Sophos;i="6.21,308,1763452800"; 
   d="scan'208";a="72874706"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2026 07:16:25 -0800
X-CSE-ConnectionGUID: Jgkz4GwzRHO38ohMtAFufA==
X-CSE-MsgGUID: kD2G6RPSSseOnEFwAJLgig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,308,1763452800"; 
   d="scan'208";a="253676518"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by orviesa001.jf.intel.com with ESMTP; 24 Feb 2026 07:16:23 -0800
From: Kiran K <kiran.k@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: ravishankar.srivatsa@intel.com,
	chandrashekar.devegowda@intel.com,
	chethan.tumkur.narayan@intel.com,
	Kiran K <kiran.k@intel.com>
Subject: [PATCH v2 7/9] btintel_pcie: Add support for exception dump for ScP2F
Date: Tue, 24 Feb 2026 21:04:46 +0530
Message-ID: <20260224153449.193551-7-kiran.k@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260224153449.193551-1-kiran.k@intel.com>
References: <20260224153449.193551-1-kiran.k@intel.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add device coredump support for Scorpious Peak2F product.

Signed-off-by: Kiran K <kiran.k@intel.com>
---
 drivers/bluetooth/btintel.h      | 1 +
 drivers/bluetooth/btintel_pcie.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/bluetooth/btintel.h b/drivers/bluetooth/btintel.h
index b5c00be8277a..0e9ca99aaaae 100644
--- a/drivers/bluetooth/btintel.h
+++ b/drivers/bluetooth/btintel.h
@@ -60,6 +60,7 @@ struct intel_tlv {
 #define BTINTEL_CNVI_BLAZARU		0x930	/* BlazarU - Meteor Lake */
 #define BTINTEL_CNVI_SCP		0xA00	/* Scorpius Peak - Panther Lake */
 #define BTINTEL_CNVI_SCP2		0xA10	/* Scorpius Peak2 - Nova Lake */
+#define BTINTEL_CNVI_SCP2F		0xA20	/* Scorpius Peak2F - Nova Lake */
 
 /* CNVR */
 #define BTINTEL_CNVR_FMP2		0x910
diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index d0cabf4df7c0..d903460bea76 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -1234,6 +1234,7 @@ static void btintel_pcie_read_hwexp(struct btintel_pcie_data *data)
 		addr = BTINTEL_PCIE_SCP_HWEXP_DMP_ADDR;
 	break;
 	case BTINTEL_CNVI_SCP2:
+	case BTINTEL_CNVI_SCP2F:
 		len = BTINTEL_PCIE_SCP2_HWEXP_SIZE;
 		addr = BTINTEL_PCIE_SCP2_HWEXP_DMP_ADDR;
 	break;
-- 
2.43.0

