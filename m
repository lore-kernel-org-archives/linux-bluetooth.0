Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2661C4F3935;
	Mon, 28 Sep 2026 17:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790615253; cv=none; b=HhQaPksyZxzXAO0q67/0F0j337q49YEuRYWxFmoVlqwyQNY9/29PArcYO8HhdCGc12X+DQVlxAdpa9omBWzf8dsrkzhBvYDxw2OfcSoHkNNSEoBZ6zMnZlzABiipGWIPb1k6GMKwKKRU5JqNOY3iUhztTNBWOBUl/dYnCmlghvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790615253; c=relaxed/simple;
	bh=TgIAoAtbPA3U/SivfLjPbcx1VYaGIRcW7/k9PxE/Ym0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=emRd5nA8PXEaPF7pAjmZxSwD2DjzyXc7JMiJ6WDTGE28P61Z65FKhPY+pd75xzxDZ5Cap4mJutsxUt4ZI1XrwWYsuUn9lhoaY9DRTkwQf8axjw4FFQYltkPm0sReg97+cQFjH3YhjfsB6L17G5AkA6rDGMfH6Ap6ZObqsnkoMy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Pc4SdkYx; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Pc4SdkYx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790615249; x=1822151249;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=TgIAoAtbPA3U/SivfLjPbcx1VYaGIRcW7/k9PxE/Ym0=;
  b=Pc4SdkYxt6b8w2tLo9+GqXE3ZWxKRR+rVSlXtFXlGDCwiMesb6r1c4Rz
   4qNcTRLbFY6yBcl8Hlg0DLJK5EtDXyTLuhecLDr65A4hRP3q0IFqqILSq
   UD/OCgc81UJxEWeqnU0/YWHvQsSMydV0UuzCspkxaXY6hKUdVQFja7t3h
   lP9dG4k+4jCBsUZ4bUsPlf/gVeWIROWkRuvTz0CGBlbe+n9RBMINbLXCJ
   k13TOHQdolr9ZFfJiDMZBViUE4tRTqtcRA7WVuc9OGrvCbNRrlc1n7QHi
   0WGBtGBuNzidM9USaO2gwKpm65nAJ9t2BdD3uX2IL4A4MixqXpw/gNorP
   Q==;
X-CSE-ConnectionGUID: sKZtT4jnTMC4B7c8cVqT+A==
X-CSE-MsgGUID: 0R/a6pukRLWG+bjLz5B+Bw==
X-IronPort-AV: E=McAfee;i="6800,10657,11919"; a="116847863"
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; 
   d="scan'208";a="116847863"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 10:07:26 -0700
X-CSE-ConnectionGUID: WO4tgXyfRsOi7wsN8zueeg==
X-CSE-MsgGUID: KBJRRFsYRbuZQXzeFpYULw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; 
   d="scan'208";a="275222317"
Received: from unknown (HELO WEBA2062.iind.intel.com) ([10.66.228.2])
  by fmviesa008.fm.intel.com with ESMTP; 28 Sep 2026 10:07:24 -0700
From: Ravindra <ravindra@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: lsa.uz@pm.me,
	pmenzel@molgen.mpg.de,
	marcel@holtmann.org,
	luiz.dentz@gmail.com,
	kiran.k@intel.com,
	chethan.tumkur.narayan@intel.com,
	linux-kernel@vger.kernel.org,
	Ravindra <ravindra@intel.com>
Subject: [PATCH v6 0/4] Bluetooth: btintel_pcie: fix D-state transitions and PM flows
Date: Mon, 28 Sep 2026 22:39:59 +0530
Message-ID: <20260928171003.2925480-1-ravindra@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series fixes the suspend/resume path of btintel_pcie.

Patch 1 refreshes the boot-stage register before the fallback state check.
Patch 2 distinguishes S0ix from S3/S4 and routes thaw through a normal D0
transition. Patch 3 verifies the state after GP0 and completes any missing
RX or mailbox setup. It also serializes the alive-context claim between the
GP0 handler and the PM fallback so only one path reinitializes the RX ring.
Patch 4 clears the GP0 cause with a direct W1C write.

Ravindra (2):
  Bluetooth: btintel_pcie: fix PM flow for S0ix, S3 and S4
  Bluetooth: btintel_pcie: clear the GP0 cause with a W1C write

Sergey Lebedev (1):
  Bluetooth: btintel_pcie: verify and serialize D-state transitions

Vladimir V. Kondratyev (1):
  Bluetooth: btintel_pcie: fix stale cache in set_dxstate fallback check

 drivers/bluetooth/btintel_pcie.c | 140 +++++++++++++++++++++++--------
 drivers/bluetooth/btintel_pcie.h |   3 +-
 2 files changed, 107 insertions(+), 36 deletions(-)

-- 
2.43.0

