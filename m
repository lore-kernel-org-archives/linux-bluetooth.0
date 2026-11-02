Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793637887;
	b=gPKljRTIC6sYnHoISeymCwfdlrYROp+IAATChrb8dN6esw37R2Vz0LmWYYQ1hVm4MeoE
	 j3epJRanYAbny1BqlH8TaoCTy9DGlnGFhn0rGcNazRMTOt25a+FOhqZl7aoA8wGOoHKtf
	 X1+HkFUt8nlQey1tRakWJKVBzR4Qj08uuMZ3WUGSjwPDYk8662zeoJjU2vEaZISwjhHtF
	 5uuI+NJ9OhePCRb4WptOxJker9LBcP0kupv5l9ICQYowkx84rwLyLtjnMyvlW14IBndQD
	 N3KBfIkrZYJRV/XghcJKawMGRsj7gHptIjEMY+KC+ySfPwpC6SzdEzea+MDl84+rF9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793637887;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=EfcKVvS1npxfSypc70U61H/uWzSA9wykS2r0HMhm3y0=;
	b=ueDbDkpi211mPniNvK+bHkGO0uM/S2XO9WW3kCdcTd1QgZ760x9hZCibF0FNF5qUqDwt
	 hLdHh7cgEXUztHR1g7PRt2RWmPnr9tw3XgC/k4ucLem4Ekm0ePEecWalVbhOiSKYXPNtF
	 TyI7AxwEFzs21kvTbPPOHS5Sllkoj5tSsWQdU8B4SjE3/fBLmfDOIY8ZtRrlBzXAroT6B
	 5+JJvyTiQmycJhQpluYCX9Oa1/4coza/kghuOaK86cm6vyjthGfy+TsFi0RgBPaLWZxKD
	 iE9dwa3j+0xl9sitWm+nECu9f4Ehb/xYK6JDDFkAsoYcdO5h2LiPAKkwrCT6NMSeQ4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=huyE5MFg;
	arc=none smtp.remote-ip=198.175.65.14
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73675606B1D2
	for <linux-bluetooth@vger.kernel.org>; Mon,  2 Nov 2026 16:44:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 73675606B1D2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=huyE5MFg
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793637885; x=1825173885;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=gTsPDWI9fwE2cP79Hkbtzhtf37q82kZO4f2C/mRR1CI=;
  b=huyE5MFgzKUbKYRFs24y0/6TvAGwkuTpD9PP1NAVKNS3ZDIcFUHo3+Lj
   FedYKPVhOhzRGrcc5QsW+A4koGhsww76PYqwNbtW2uD+K8U2y3RKKuwUB
   r3JDXD482HexwPXgDMdw/CNI3/hGMdZxImusw6ywVw2i9BS3IUVP/BEa0
   Y8QT93YxoIWtAQx0OmUPp2zaCNS3S/GGEfvhals1rG8rSB/u0/jPNHJg2
   5sBrCZb9i0qXwjLiW5ilW4The4H2ti/i39Ce++S0pz+14c2kj8Dj12hUa
   cNLPgo5FgnJJnOKu0BtLmjGQgOqulwvY24QapMNYETUrEnDBRULFH7Fpj
   w==;
X-CSE-ConnectionGUID: 4w3K7kohSHK84wRHYhfRgw==
X-CSE-MsgGUID: sczdmbj8Ssi+bPOiGLGphQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11954"; a="2221962"
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="2221962"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 08:44:45 -0800
X-CSE-ConnectionGUID: PeDE1pMxSG+zlCAivZpyMg==
X-CSE-MsgGUID: rjhZIRTcTWa7zmMfZTH84w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="6329056"
Received: from weba0534.iind.intel.com ([10.66.226.131])
  by fmviesa002.fm.intel.com with ESMTP; 02 Nov 2026 08:44:43 -0800
From: Sai Teja Aluvala <aluvala.sai.teja@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: kiran.k@intel.com,
	chethan.tumkur.narayan@intel.com,
	Sai Teja Aluvala <aluvala.sai.teja@intel.com>
Subject: [PATCH v2 0/2] Bluetooth: btintel_pcie: debug INI rework and fatal error injection
Date: Mon,  2 Nov 2026 22:06:11 +0530
Message-ID: <20261102163613.2524534-1-aluvala.sai.teja@intel.com>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series moves the btintel_pcie debug INI parsing into the debug
file and adds a test mode for injecting firmware exceptions.

Patch 1 moves the debug INI parser (DBG_PATH, ENABLE_INI, LOG_MASK)
from btintel_pcie.c to btintel_pcie_debug.c, so that all debug INI
handling lives in one file. The parsing behaviour is unchanged.

Patch 2 adds the FATAL_ERR_TESTMODE debug INI option. It injects a
firmware exception for testing. The INI value selects the exception
type and the injection context (thread, IRQ or rfkill). Whether the
exception is expected to trigger recovery depends on its type. The
test mode is disabled when the OPFW API lock is set, unless the
unlocker firmware was loaded.

v2:
 - Drop the btintel "Zero-initialize new_ver" patch, as
   btintel_read_version_tlv() already clears the structure.
 - Arm the post-setup injection before setting SETUP_DONE, so the rfkill
   work cannot inject ahead of it.
 - Keep the post-setup injection pending if HCI is down when the rfkill
   work runs, and let the normal rfkill handling continue.
 - Document that the test mode intentionally injects on every rfkill
   assertion and skips the initial rfkill check after the post-setup
   injection, and that the api_lock check uses the operational firmware
   version.

Sai Teja Aluvala (2):
  Bluetooth: btintel_pcie: Move debug INI parsing to debug file
  Bluetooth: btintel_pcie: Add fatal error injection test mode

 drivers/bluetooth/btintel.c            |   5 +-
 drivers/bluetooth/btintel.h            |   1 +
 drivers/bluetooth/btintel_pcie.c       | 152 +++----------
 drivers/bluetooth/btintel_pcie.h       |   5 +-
 drivers/bluetooth/btintel_pcie_debug.c | 288 ++++++++++++++++++++++++-
 drivers/bluetooth/btintel_pcie_debug.h |  33 ++-
 6 files changed, 356 insertions(+), 128 deletions(-)

-- 
2.53.0

