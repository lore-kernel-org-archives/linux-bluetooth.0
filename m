Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B714325495
	for <linux-bluetooth@vger.kernel.org>; Mon, 23 Feb 2026 17:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771866151; cv=none; b=ZPEnnwGMgPAI8j5V/UouFfAGyqFjMZ1+m2NT0ykj4c908GRN2F5hzo3L2pzyA+oYMhPbSBHqiGnuIpLZMzbjOERyjrZRdlk065zYe8eqUQ1RXpg28KjHyI/sWylNHTT3zXsxKGmS6g6xZJY4ehez6t7LsOvqMdTMATBZJfVxGCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771866151; c=relaxed/simple;
	bh=axlfXtY670o7l2ABOdE3a+KwdhKULPwH72LH/68iVxk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HjI4iuq50UocXqEu7mQlqHTnCSOqpB5puRejfOtyJbCRVrfzQ6OVLW3IPZhhPK910oL2Lqbvsggmi219dfXzYcUPl9wrntEFiWv/oVj8eDuVfkHvFQ3cJaeCnSak6ImlmJGLGZoKptO5PqLkx5TQbS4JCLVt6wjbu/K+FHvuqeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iN76XiyD; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iN76XiyD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771866149; x=1803402149;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=axlfXtY670o7l2ABOdE3a+KwdhKULPwH72LH/68iVxk=;
  b=iN76XiyD/a8diBZl8JbKIwwjjPa1wDDMg3j3/QqbCBHa2XjEzYMYRKT7
   BAP4Y/2d0QS8IJ7b5l2tUzF+nNFVYO5Lv2o36qimY56cIOTv90Ap+Ph9l
   VdOXx30d2wDevJeImAenQuP8KQB7EYKdbVeA0wLsJHSzcti+BiC9Kh+yf
   f9U9mZTQJe1XphcAMtC9yEY4l38USwwRY2IFZGcpp/AD+QNX6EVGAX+fF
   bVaN7BETlm4UvHm7cZtjI488+JzLUo4FLxb6WR474PWa4LkTApbfZSUxV
   Q8XtglMv+iXSo56EFuAoDH2pNkXO6F9Rg11Kf+LrN8MEcj2NHPbAZvJLG
   Q==;
X-CSE-ConnectionGUID: ug8Np6YiS2GGLe2Igqo83A==
X-CSE-MsgGUID: 64qnYiGcRGiBWl/xL2lq/Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11710"; a="95484469"
X-IronPort-AV: E=Sophos;i="6.21,307,1763452800"; 
   d="scan'208";a="95484469"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2026 09:02:28 -0800
X-CSE-ConnectionGUID: ucHVG8E3SC+vGSSSDr/vpg==
X-CSE-MsgGUID: IKWxzyPHS/OnNU0r1lNstA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,307,1763452800"; 
   d="scan'208";a="214698351"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by orviesa006.jf.intel.com with ESMTP; 23 Feb 2026 09:02:24 -0800
From: Kiran K <kiran.k@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: ravishankar.srivatsa@intel.com,
	chandrashekar.devegowda@intel.com,
	chethan.tumkur.narayan@intel.com,
	Kiran K <kiran.k@intel.com>
Subject: [PATCH v1 3/7] Bluetooth: btintel: Add support for Scorpious Peak2 support
Date: Mon, 23 Feb 2026 22:50:59 +0530
Message-ID: <20260223172104.167471-3-kiran.k@intel.com>
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

Add support for Intel Bluetooth Scorpious Peak2 core.

Signed-off-by: Kiran K <kiran.k@intel.com>
---
 drivers/bluetooth/btintel.c      | 3 +++
 drivers/bluetooth/btintel_pcie.c | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index 2547b590f87a..26aa8ea7d33e 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -497,6 +497,7 @@ int btintel_version_info_tlv(struct hci_dev *hdev,
 	case 0x1d:	/* BlazarU (BzrU) */
 	case 0x1e:	/* BlazarI (Bzr) */
 	case 0x1f:      /* Scorpious Peak */
+	case 0x20:	/* Scorpious Peak2 */
 	case 0x22:	/* BlazarIW (BzrIW) */
 		break;
 	default:
@@ -3318,6 +3319,7 @@ void btintel_set_msft_opcode(struct hci_dev *hdev, u8 hw_variant)
 	case 0x1d:
 	case 0x1e:
 	case 0x1f:
+	case 0x20:
 	case 0x22:
 		hci_set_msft_opcode(hdev, 0xFC1E);
 		break;
@@ -3659,6 +3661,7 @@ static int btintel_setup_combined(struct hci_dev *hdev)
 	case 0x1d:
 	case 0x1e:
 	case 0x1f:
+	case 0x20:
 	case 0x22:
 		/* Display version information of TLV type */
 		btintel_version_info_tlv(hdev, &ver_tlv);
diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index 1a35cbabcc07..19abffca209f 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -2099,6 +2099,7 @@ static int btintel_pcie_setup_internal(struct hci_dev *hdev)
 	switch (INTEL_HW_VARIANT(ver_tlv.cnvi_bt)) {
 	case 0x1e:	/* BzrI */
 	case 0x1f:	/* ScP  */
+	case 0x20:	/* ScP2 */
 	case 0x22:	/* BzrIW */
 		/* Display version information of TLV type */
 		btintel_version_info_tlv(hdev, &ver_tlv);
-- 
2.43.0

