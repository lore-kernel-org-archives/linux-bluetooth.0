Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C9B6304976
	for <linux-bluetooth@vger.kernel.org>; Mon, 28 Sep 2026 05:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790571672; cv=none; b=YEA9OvoZHX66oEfOw5eoxthgYLNFBc2SQvN3lhRRsiAylVYFhBWKm/TiBJpd6yCzKeo3H72tV0kEWJBlyBiPX8J3syJqFgSH99vy2HV7PbyUyhuK7hJ/y4B0tKe4Fbwp9rEgnim7qm9Sf3l6qHZ6vsW0/o97epFfG3ZAoCBEjCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790571672; c=relaxed/simple;
	bh=1bDhetjct19ot3GNcBBTYgsEn2u14xyDwpblYDJQUC0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MIPVivMzCrn14uce8QxXCJs0xVAAToXb7UeqDW33UQvw7RphqW8g4h0heTsd/goJ9ZXjuU0b6ZaXyEaDZkdM7NmVSntCukHrquqlGqgDJEnp9RlzKaaatXYZq2uDiiVG82P92f9BxcqU9/RRYZg3aBN0QTb3F5/aQIvj/S1nuko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OnifniRK; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OnifniRK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790571670; x=1822107670;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=1bDhetjct19ot3GNcBBTYgsEn2u14xyDwpblYDJQUC0=;
  b=OnifniRKf3lz+5aPqyeQ73xjJ8Uyl+Z8UOPcYr/caZAnMPcYFk8W9fOj
   Vqa6SssorQe5zsQBm71oTaZUdPShMqqOLNOPYACJbrbAw8+54qnu/9ZQw
   +4mZFGLO07SO9BNhwbAyeXBNTNGcZxCnkjeifXl17WLc+vfpZya71pKn2
   +30gjIzgGQWWZGJb/OFwX17GZVTCR5tGGI6xE4ToSYZskFsPJ2ZRZq5W4
   a4bS3F1oNc86UPOwOyKV14Vj7XCSQEzjsrDKiIO6Xl1dqpsEQNmc/MW9r
   24KpqhxMIwp4I9/DG30rLrc7dlW29n8qsnJwRvs0tIR7Ormr/lPmJ0a5F
   g==;
X-CSE-ConnectionGUID: TwgcMlN9Q2S/MHI5h9uX3g==
X-CSE-MsgGUID: jJVlNlyFQkm1FbDsKh+9Ew==
X-IronPort-AV: E=McAfee;i="6800,10657,11918"; a="90127771"
X-IronPort-AV: E=Sophos;i="6.27,127,1787036400"; 
   d="scan'208";a="90127771"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2026 22:01:09 -0700
X-CSE-ConnectionGUID: OrG/op9GSAeXpMH5t3Yxzg==
X-CSE-MsgGUID: +VKtr++wRtGKwlXAoraETg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,127,1787036400"; 
   d="scan'208";a="312863699"
Received: from unknown (HELO WEBA2062.iind.intel.com) ([10.66.228.2])
  by orviesa001.jf.intel.com with ESMTP; 27 Sep 2026 22:01:07 -0700
From: Ravindra <ravindra@intel.com>
To: linux-bluetooth@vger.kernel.org,
	lsa.uz@pm.me,
	vladimirkondratyev2@gmail.com
Cc: chethan.tumkur.narayan@intel.com,
	kiran.k@intel.com,
	pmenzel@molgen.mpg.de,
	Ravindra <ravindra@intel.com>
Subject: [PATCH v5 0/4] Bluetooth: btintel_pcie: fix D-state transition and PM flows
Date: Mon, 28 Sep 2026 10:33:40 +0530
Message-ID: <20260928050344.2893790-1-ravindra@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series fixes the suspend/resume path of btintel_pcie.

Patch 1 re-reads the boot stage register before the fallback state check,
so a missed alive interrupt no longer leaves btintel_pcie_set_dxstate()
testing a stale cache and aborting suspend with -EBUSY.

Patch 2 distinguishes S0ix from S3/S4 so the controller is placed in the
correct D-state, and routes .thaw through a normal D0 transition instead
of an unnecessary FLR.

Patch 3 stops treating gp0_received as proof that the requested D-state
transition completed. The flag is set at the top of the GP0 handler,
before the switch on alive_intr_ctxt, so a matched case can return having
changed nothing. The state is now verified against the register, and the
handler's work is completed from the fallback when needed.

Patch 4 clears the GP0 cause with a direct W1C write. The previous
read-modify-write helper wrote zero to GP0, leaving it uncleared, and
could acknowledge unrelated pending causes.

Changes in v5:
- Resend of the full series. v4 4/4 was posted on its own and could not be
  applied by CI, because its context depends on 3/4.
- 4/4: picked up Sergey's Tested-by and Reviewed-by.
- No functional changes since v4.

Changes in v4:
- 3/4: verify the state after the alive interrupt instead of trusting
  gp0_received, keep the flag reset inside the retry loop, complete the
  mbox<->alive handshake, propagate btintel_pcie_start_rx() errors, and
  restore the D3 context when the handler did not record it.
- 4/4: replace the W1C read-modify-write with a direct GP0 write.
- 1/4: corrected the Fixes: tag.

Ravindra (2):
  Bluetooth: btintel_pcie: fix PM flow for S0ix, S3 and S4
  Bluetooth: btintel_pcie: clear the GP0 cause with a W1C write

Sergey Lebedev (1):
  Bluetooth: btintel_pcie: verify state after alive interrupt

Vladimir V. Kondratyev (1):
  Bluetooth: btintel_pcie: fix stale cache in set_dxstate fallback check

 drivers/bluetooth/btintel_pcie.c | 124 ++++++++++++++++++++++---------
 drivers/bluetooth/btintel_pcie.h |   3 +-
 2 files changed, 91 insertions(+), 36 deletions(-)

-- 
2.43.0

