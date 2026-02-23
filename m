Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 670B4322C99
	for <linux-bluetooth@vger.kernel.org>; Mon, 23 Feb 2026 17:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771866155; cv=none; b=VUDbwEi3Ji9WcA1kk5Re6nJWfvKQJR69E8bZCQVvRiYe3wJ3xul7gMRsAxww0x4TDKoEuuCG2i7+h22XYfugEeUoyQ4BcPVKwanCbBYz8pIJU5yfeMBjcmw/d1WKVfJ/BH/76a5ld6Zk4fwvcYWoAcENygndE2mzg72rNNwLJ00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771866155; c=relaxed/simple;
	bh=lNyG0W9p+DPIt1HyQbjLgyu5+qJtQQQdUiQZk54AJFA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YWmwvT8YfobbvdMkCFP8vaHDNxjnqUaK2AekclrZJ+37zy6NhOEo13CMORiSwq4Lya75L9z3U8/1mYA1GR1ePFVVaT75JY3PutJdPkW5NS67w1BOjcFYa5iTLGmuvAAqKl1WRyT0n8xrr8TslmuEPAOXDshSItW45a6kju6R2DA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Zyfq01aE; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Zyfq01aE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771866153; x=1803402153;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lNyG0W9p+DPIt1HyQbjLgyu5+qJtQQQdUiQZk54AJFA=;
  b=Zyfq01aE/0QWthdZPfqG4mVnSRs6zQYsxw7WTK5TMkmoCBqNvRgBXIQt
   lPuMU5dyRMtOuqw7UiRuwIfpyWV0H7Cg/UtUK6WqcGyEq6F0L1WK2+tIM
   nbQCjtCr2TilTW1BfKdAlzhsOZ2xYE7mpnlYQV/hYMl8nh5RecUhvzl3g
   +ePwMBn93ppw+wrOrLpXYsGvr+jXTegE/5O/YenVGruip9iNQLike9T7c
   3HebnUtVWDpXHEB0DE1MsYNzFdtVumtV6w5+/C3DkC1inF3dCFOgwDt4p
   H0C+hKUA5EazYLTA6gaeEMoEtJ4LS8pB7dnI73JiotyUA3I7QWAPf2uKI
   w==;
X-CSE-ConnectionGUID: cbXZkDRtSKWT+EJ++DVZiw==
X-CSE-MsgGUID: V/5MKXtjT0CRCBCJAUG+jA==
X-IronPort-AV: E=McAfee;i="6800,10657,11710"; a="95484481"
X-IronPort-AV: E=Sophos;i="6.21,307,1763452800"; 
   d="scan'208";a="95484481"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2026 09:02:33 -0800
X-CSE-ConnectionGUID: qJMLjnVeTZ6lpPaXosUbow==
X-CSE-MsgGUID: oBvA+07QQ+6QInDvC+oHNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,307,1763452800"; 
   d="scan'208";a="214698402"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by orviesa006.jf.intel.com with ESMTP; 23 Feb 2026 09:02:30 -0800
From: Kiran K <kiran.k@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: ravishankar.srivatsa@intel.com,
	chandrashekar.devegowda@intel.com,
	chethan.tumkur.narayan@intel.com,
	Kiran K <kiran.k@intel.com>
Subject: [PATCH v1 6/7] Bluetooth: btintel: Add support for Scorpious Peak2F support
Date: Mon, 23 Feb 2026 22:51:02 +0530
Message-ID: <20260223172104.167471-6-kiran.k@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260223172104.167471-1-kiran.k@intel.com>
References: <20260223172104.167471-1-kiran.k@intel.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for Intel Bluetooth Scorpious Peak2F core.

Signed-off-by: Kiran K <kiran.k@intel.com>
---
 drivers/bluetooth/btintel.c      | 3 +++
 drivers/bluetooth/btintel_pcie.c | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index b3cbb61065d1..b6dd3ab830c7 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -498,6 +498,7 @@ int btintel_version_info_tlv(struct hci_dev *hdev,
 	case 0x1e:	/* BlazarI (Bzr) */
 	case 0x1f:      /* Scorpious Peak */
 	case 0x20:	/* Scorpious Peak2 */
+	case 0x21:	/* Scorpious Peak2 F */
 	case 0x22:	/* BlazarIW (BzrIW) */
 		break;
 	default:
@@ -3325,6 +3326,7 @@ void btintel_set_msft_opcode(struct hci_dev *hdev, u8 hw_variant)
 	case 0x1e:
 	case 0x1f:
 	case 0x20:
+	case 0x21:
 	case 0x22:
 		hci_set_msft_opcode(hdev, 0xFC1E);
 		break;
@@ -3667,6 +3669,7 @@ static int btintel_setup_combined(struct hci_dev *hdev)
 	case 0x1e:
 	case 0x1f:
 	case 0x20:
+	case 0x21:
 	case 0x22:
 		/* Display version information of TLV type */
 		btintel_version_info_tlv(hdev, &ver_tlv);
diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index bf71817b1cc6..d0cabf4df7c0 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -2107,6 +2107,7 @@ static int btintel_pcie_setup_internal(struct hci_dev *hdev)
 	case 0x1e:	/* BzrI */
 	case 0x1f:	/* ScP  */
 	case 0x20:	/* ScP2 */
+	case 0x21:	/* ScP2 F */
 	case 0x22:	/* BzrIW */
 		/* Display version information of TLV type */
 		btintel_version_info_tlv(hdev, &ver_tlv);
-- 
2.43.0

