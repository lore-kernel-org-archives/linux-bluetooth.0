Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41ED9184524
	for <linux-bluetooth@vger.kernel.org>; Sat, 28 Feb 2026 08:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772268855; cv=none; b=uae1lsd8jkn9Wfprk7CTKbNdftc5KzlsxWNwkKjILMedNZwKBIyhTqyJUAO1rl7fjYVLf/Rk8uKgEn8m9OFoZ/et4aR21xVGBbICLomhsfL5tAu2qqeIHbpPr+zscK17OIHcqS+rC5hIdV3VeAD5YK7DzRDrLFvGMvcyLwHhKSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772268855; c=relaxed/simple;
	bh=V9M6F8H6G1phYONJ/nMXebl29IYT9QKjrz3MtqbCEWg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=edBULuvwi4nvOk/NuRmZykQ4jsfm/j9lY+0ZDMSHeCPo3+a8MLc52bs4uGSPMOeMi9I1McFhUjXO/uziIExnioQnbXEoUAXF5Jz1yIBOQzP8zCl0uKdsLaLc7/cUVk/oY0urZfP/3g++ty4j1odK0W911fNkrsdCcybo9eQ2wHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=elC7AZ23; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="elC7AZ23"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772268855; x=1803804855;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=V9M6F8H6G1phYONJ/nMXebl29IYT9QKjrz3MtqbCEWg=;
  b=elC7AZ236sAyt/Px1YoukSGuf0nsxw6H6cvXWucRaRlrrH6C6cLlvDA/
   Eqx9l9dqUiSJUw4H3skZARk16mXkbNoowuwdWhzcf9IkuhDxCEBcORvaP
   TCB2RjXdA/qnAkgAcSmUi1NEW+AfytheEeZ82NTNPfKuxG0ZAhcDoHh1y
   Dv11wVoBKQ56gFZzB/NNDLetZHfs/ZWtAvNStEBwxLulsqNYIExd3dy33
   /xvMbVaRe7u0oeXxpZ+yaL3gkiCgwVJF3EAzCVpFTZvRplPkr/I3dSPFM
   Ap/wqyIdlRF0rQ+QCu80kJzVtZ/NO+ZAGEF/SEVtnlKzcp0szXcHwFiTN
   Q==;
X-CSE-ConnectionGUID: u/rsGyFoS4WErd/BNoZoag==
X-CSE-MsgGUID: UTMCAK73R3SYevkgSNzjEQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11714"; a="77189244"
X-IronPort-AV: E=Sophos;i="6.21,315,1763452800"; 
   d="scan'208";a="77189244"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2026 00:54:15 -0800
X-CSE-ConnectionGUID: Y39DotOrRlezf6tLeozXwQ==
X-CSE-MsgGUID: htWoxoshTrGXac8j+hRjAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,315,1763452800"; 
   d="scan'208";a="221630159"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by orviesa004.jf.intel.com with ESMTP; 28 Feb 2026 00:54:13 -0800
From: Kiran K <kiran.k@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: ravishankar.srivatsa@intel.com,
	chandrashekar.devegowda@intel.com,
	chethan.tumkur.narayan@intel.com,
	Kiran K <kiran.k@intel.com>
Subject: [PATCH v3 7/9] Bluetooth: btintel_pcie: Add support for exception dump for ScP2F
Date: Sat, 28 Feb 2026 14:42:37 +0530
Message-ID: <20260228091239.230284-7-kiran.k@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260228091239.230284-1-kiran.k@intel.com>
References: <20260228091239.230284-1-kiran.k@intel.com>
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
index 5f281403bcfa..058ccb328112 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -1235,6 +1235,7 @@ static void btintel_pcie_read_hwexp(struct btintel_pcie_data *data)
 		addr = BTINTEL_PCIE_SCP_HWEXP_DMP_ADDR;
 	break;
 	case BTINTEL_CNVI_SCP2:
+	case BTINTEL_CNVI_SCP2F:
 		len = BTINTEL_PCIE_SCP2_HWEXP_SIZE;
 		addr = BTINTEL_PCIE_SCP2_HWEXP_DMP_ADDR;
 	break;
-- 
2.43.0

