Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9755D3B9DA7
	for <linux-bluetooth@vger.kernel.org>; Fri, 18 Sep 2026 13:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789739395; cv=none; b=BslaSQM85uXTuWQYy214oHOZPpX5hLbLw95nieiSsQIt1cQ5yvcSAYPJ8cAEhwBz5j5yJ/wgcW5nomASZl7QfXEwEJKizZLqv6dBkEFTPqzNiHXfrPxNF5KwwT4ZjnpV38aAzNAPpQVf9B36CyCRRaTjHgSF7VKnz7JbDg4n9H4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789739395; c=relaxed/simple;
	bh=hXbxtQL3/vCMcuvW/E7wuW9SfAaPuW9YSV4v8UBJcXA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ULLyDcnu21oDTmACJONes/I7ayH5VrG7JX7m7/aDCzAC51CdNR/8ksmMYogesUv1QxHynSR+xdd/Ha6JXUzn6kKKIOwraFTfhuQi3914tZmPutkuCY4mmsNWSb3FhB3DlngXgUykH9uJFpGtakkkg/a8tvJs2HIOFJY/uQ42wpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C/pqMA91; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C/pqMA91"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789739394; x=1821275394;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=hXbxtQL3/vCMcuvW/E7wuW9SfAaPuW9YSV4v8UBJcXA=;
  b=C/pqMA91n9dqcd4qtHjhCn2ffoJgPQ1qUFZHZaMVeb8+8ie3fvFWjphd
   7j+WT9YKl2jqk6qH+nb+xHtDI8l8nvIkfExjxexY/XfYzGO1vzI97e4By
   VGI9Hk+cxCkWkk34klwCr43QX7h9Yf9/jD1bspiZ5uJT803rhCv2s0rkT
   tV7Jawcb0I+MFdXMiGyku4YgRErnCIf+hNeKawiYLVpKbl7Dy3lcMLsD9
   G0vm4XjWmwfDC8cG+COWk4OoRF6QHcJJENiYTmy+5UqtyEJ0zW4xHAseQ
   x18TJqWP504n6evsfKjTHtyLVzkVLRXl8RJd/TkY/TvjLh8n4G3WCDG4P
   A==;
X-CSE-ConnectionGUID: TXYr0KXdRt+m6ER9WuCbfw==
X-CSE-MsgGUID: 2Qegdae/RdSFGZIQPzB6Fg==
X-IronPort-AV: E=McAfee;i="6800,10657,11908"; a="101594350"
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; 
   d="scan'208";a="101594350"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2026 06:49:53 -0700
X-CSE-ConnectionGUID: GbQhDDqERMOUeOwm7FVkGQ==
X-CSE-MsgGUID: 95BZUConTxK3hJLsep7naA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; 
   d="scan'208";a="297874487"
Received: from unknown (HELO WEBAPTLH152.iind.intel.com) ([10.66.226.239])
  by fmviesa002.fm.intel.com with ESMTP; 18 Sep 2026 06:49:52 -0700
From: Catherine L <catherine.l@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: chethan.tumkur.narayan@intel.com,
	kiran.k@intel.com,
	Catherine L <catherine.l@intel.com>
Subject: [PATCH v1 1/2] Bluetooth: btintel_pcie: Add CNVi ID for Titan Lake (Scorpius Peak2 C0)
Date: Fri, 18 Sep 2026 19:19:19 +0530
Message-ID: <20260918134919.39137-1-catherine.l@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Define BTINTEL_CNVI_SCP2_C0 (0xA11) for the Scorpius Peak2 C0 stepping
used on Titan Lake platforms and handle it in btintel_pcie_read_hwexp()
alongside existing Scorpius Peak2 variants.

Signed-off-by: Catherine L <catherine.l@intel.com>
---
 drivers/bluetooth/btintel.h      | 1 +
 drivers/bluetooth/btintel_pcie.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/bluetooth/btintel.h b/drivers/bluetooth/btintel.h
index ef232820c31b..e51fb78ee469 100644
--- a/drivers/bluetooth/btintel.h
+++ b/drivers/bluetooth/btintel.h
@@ -61,6 +61,7 @@ struct intel_tlv {
 #define BTINTEL_CNVI_BLAZARU		0x930	/* BlazarU - Meteor Lake */
 #define BTINTEL_CNVI_SCP		0xA00	/* Scorpius Peak - Panther Lake */
 #define BTINTEL_CNVI_SCP2		0xA10	/* Scorpius Peak2 - Nova Lake */
+#define BTINTEL_CNVI_SCP2_C0		0xA11	/* Scorpius Peak2 C0 - Titan Lake */
 #define BTINTEL_CNVI_SCP2F		0xA20	/* Scorpius Peak2F - Nova Lake */
 
 /* CNVR */
diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index 30923eaabed7..9dbadef31324 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -1635,6 +1635,7 @@ static void btintel_pcie_read_hwexp(struct btintel_pcie_data *data)
 		break;
 	case BTINTEL_CNVI_SCP:
 	case BTINTEL_CNVI_SCP2:
+	case BTINTEL_CNVI_SCP2_C0:
 	case BTINTEL_CNVI_SCP2F:
 		break;
 	default:
-- 
2.43.0

