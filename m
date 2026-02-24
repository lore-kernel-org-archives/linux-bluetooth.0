Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 167413A0B0E
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Feb 2026 15:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771946182; cv=none; b=uDAcwYkx3kSiZu0B93ig05wFkRm6aQ1OZetnefUTgBEZViRLa1Kun+H3yNizYFWBq11a35cZKE8f4mpcoN/qv9sO89UGJTo/ejADUcz13wbCLNqNniXhGsKrT5fK5xdSRNeqyTqQL9CwlS/3r/8OChInkiXEIi+LV7OCcf392CA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771946182; c=relaxed/simple;
	bh=TuQZcotRmGkHmEROF5Nzxh9oT6D1Zy/KmJR//aXqZQg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WgYuGIyrL9XC/O08TimmY6Bfz+DRA5Ro0R6gecUOofhXcmyK0AEnEozAKewHxlVXJyalXJknHTy4G+a0x/ZVbJOcdSE7y9B/aBYzUyPrUrCIah7677HL9n7HsIfsCIxz2hSMtSuNaWJhrfU1IlI+V5Ny5xLngysEHsVPj3vKZuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U96q4GR/; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U96q4GR/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771946180; x=1803482180;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TuQZcotRmGkHmEROF5Nzxh9oT6D1Zy/KmJR//aXqZQg=;
  b=U96q4GR/ELA/WIeSifer0Sx1S2pRMfjdftthcGLkdkmZQyJMpP2FWf4g
   c4Cqr98/WDLRHDjT54k+YnzGGy2fifsemUA1QqhUj5CJo8M7uBJkJlGVx
   B4tHyyptfGZSIyCy9bpKhkb4/cDEsovYvHD3mde7Ws73RIXvqOSPVAvWc
   4XPKQkjzGcqE5Snmz2EhI+SbMNA26lZXRkNov7VRCZAP2QlBvY3YEVE6Z
   tKi/jMI8mVe5W+ZhYILq6bGY7gaVTxMNjYseWoZfRHHjSrxjj+CDPCKw7
   8gfzTxpaJLtRepvlULys7KK/UfSJ0l33109rOiZlorhs+Ak5yXxmlggNe
   Q==;
X-CSE-ConnectionGUID: NwmNub26RFm+CXwn5g/+TA==
X-CSE-MsgGUID: m2qUNNWrRpGiKbWQjfNLbg==
X-IronPort-AV: E=McAfee;i="6800,10657,11711"; a="72874687"
X-IronPort-AV: E=Sophos;i="6.21,308,1763452800"; 
   d="scan'208";a="72874687"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2026 07:16:20 -0800
X-CSE-ConnectionGUID: NBL9tHs5QI+H116g+0yZCA==
X-CSE-MsgGUID: qM8j4VmZS8mMiSzOBo09yQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,308,1763452800"; 
   d="scan'208";a="253676485"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by orviesa001.jf.intel.com with ESMTP; 24 Feb 2026 07:16:18 -0800
From: Kiran K <kiran.k@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: ravishankar.srivatsa@intel.com,
	chandrashekar.devegowda@intel.com,
	chethan.tumkur.narayan@intel.com,
	Kiran K <kiran.k@intel.com>
Subject: [PATCH v2 4/9] Bluetooth: btintel: Add DSBR support for ScP2 onwards
Date: Tue, 24 Feb 2026 21:04:43 +0530
Message-ID: <20260224153449.193551-4-kiran.k@intel.com>
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

Add DSBR support for Scorpious Peak2 cores onwards.

Refer commit eb9e749c0182 ("Bluetooth: btintel: Allow configuring drive
strength of BRI") for details about DSBR.

Signed-off-by: Kiran K <kiran.k@intel.com>
---
 drivers/bluetooth/btintel.c | 5 +++++
 drivers/bluetooth/btintel.h | 1 +
 2 files changed, 6 insertions(+)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index 26aa8ea7d33e..b3cbb61065d1 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -2823,6 +2823,7 @@ static int btintel_set_dsbr(struct hci_dev *hdev, struct intel_version_tlv *ver)
 	 * 1. BlazarI or BlazarIW + B0 step product in IML image.
 	 * 2. Gale Peak2 or BlazarU in OP image.
 	 * 3. Scorpious Peak in IML image.
+	 * 4. Scorpious Peak2 onwards + PCIe transport in IML image.
 	 */
 
 	switch (hw_variant) {
@@ -2843,6 +2844,10 @@ static int btintel_set_dsbr(struct hci_dev *hdev, struct intel_version_tlv *ver)
 			break;
 		return 0;
 	default:
+		/* Scorpius Peak2 onwards */
+		if (hw_variant >= BTINTEL_HWID_SCP2 && hdev->bus == HCI_PCI
+		    && ver->img_type == BTINTEL_IMG_IML)
+			break;
 		return 0;
 	}
 
diff --git a/drivers/bluetooth/btintel.h b/drivers/bluetooth/btintel.h
index b7ff183f8886..f16f852b83b8 100644
--- a/drivers/bluetooth/btintel.h
+++ b/drivers/bluetooth/btintel.h
@@ -74,6 +74,7 @@ struct intel_tlv {
 #define BTINTEL_HWID_BZRI	0x1e	/* BlazarI - Lunar Lake */
 #define BTINTEL_HWID_BZRU	0x1d	/* BlazarU - Meteor Lake */
 #define BTINTEL_HWID_SCP	0x1f	/* Scorpius Peak - Panther Lake */
+#define BTINTEL_HWID_SCP2	0x20	/* Scorpius Peak2 - Nova Lake */
 #define BTINTEL_HWID_BZRIW	0x22	/* BlazarIW - Wildcat Lake */
 
 struct intel_version_tlv {
-- 
2.43.0

