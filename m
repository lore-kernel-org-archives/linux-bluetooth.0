Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793795621;
	b=MXm/5xkjFCBVjNpLhA322uYvlWawYvFiFF7wC3rsmVekh8HiIJ768yBqw6yXh3Ovj3Ok
	 vejvkNCQx8MAGm0rSNx5tdnM8tKS8h0KAqrfxe7EaTRW+iTt8Js2jIOHvE52kHEXPnb2+
	 A9EcjPXh3pgpcvbeRHGOkCslpyBROI+wjfKuQs0mGOIi2EHwFHv6kM2q+qPXT9nHeDYKD
	 wfGOU8DzpbO94nXs3aU8OulSEYkIXPoz1SluxOzVX2a2KBpu42gjmx0nLDAi/c1NKMxpS
	 7aUi6b1KLBz5RHpzUV3eKa0GKD7fPUmCznIoG0MfgP85KSjqPwvMa2qtjTUdFGugVmA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793795621;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=JVlpWWl/wEpU3RfMlox4oL+34KJXaKjbR5gK3QH5u5E=;
	b=rANOz8l6wch3gjzlely2ypnB75KS0PaPcTOmECLdjYJ3/IVE+C4JhnWedVPW+29QBwfs
	 mRIajl5hYGB1L/CPU8hrgXFXrXuMzapvMvJSk4kwMFNBqTiVaLDtU0VOh7276zXz19ip5
	 p4hWNrWKYjyZ63MWVOJTgyafOrKLSWGsat6gN8rpraBoCIPNf/biXGVZwDXqL6MqEVksN
	 GuZAOWlO5IcLjQC+oI73xcJHnRJlSpNvg0yp2K8Xp/E+Uqf2WS64/ggxDKSvA2S8y+fGc
	 DY/dDxepBVxBtYegUmFmlu7d9sIrAIcXU0NUbpj8yVO3X7zkPGcb96iQHPi3mcv8I6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=GuItm+E5;
	arc=none smtp.remote-ip=198.175.65.12
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 600E0606A31B
	for <linux-bluetooth@vger.kernel.org>; Wed,  4 Nov 2026 12:33:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 600E0606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=GuItm+E5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793795619; x=1825331619;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ju92Y05dS3FXSTw+BmzEmkxTuR0EXp8FcA+9bDb07N4=;
  b=GuItm+E5evlErZYpbIh1MD8wzYcBHJiqy7yZr+Y50ASP2bp9A+fL9QqM
   fX663EJ54CPdntLdHLdj6faj5mogIhSheWTCI7x1PSAAr/WE5lwynr6oA
   GHrjlhZgfYVnR+UWS4641fNJtU5LOXREsZuZH4KtGh5QR/IstY9YavDXb
   o5ciyPZXg8jKaMDHYzM+VgWpO1qClO1wuGJ3FvoZacdzYBeROTnlqAHPk
   aOuUYeoRe7z/QUSugxNHRhIK9EiqhCN/8aBB0EhcL7StKlWxXM17sBmGx
   GQd5K+APlFNhqLO93YD0MjZB8HE0aiZvBJupePmgQuL114B83NZ39HDyb
   Q==;
X-CSE-ConnectionGUID: F/P0j7bDRSSnV8qW8VqWeg==
X-CSE-MsgGUID: FUV0Ah5zQhCVBb7NwOWf0g==
X-IronPort-AV: E=McAfee;i="6800,10657,11955"; a="2422487"
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="2422487"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2026 04:33:38 -0800
X-CSE-ConnectionGUID: eG7XfCmNRTCcdO6VKPC60A==
X-CSE-MsgGUID: PBcM0j1eTpWA5ZUpNDc8jg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="7099780"
Received: from weba0534.iind.intel.com ([10.66.226.131])
  by fmviesa007.fm.intel.com with ESMTP; 04 Nov 2026 04:33:37 -0800
From: Sai Teja Aluvala <aluvala.sai.teja@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: kiran.k@intel.com,
	chethan.tumkur.narayan@intel.com,
	Sai Teja Aluvala <aluvala.sai.teja@intel.com>
Subject: [PATCH v5 0/2] Bluetooth: btintel_pcie: debug INI rework and fatal error injection
Date: Wed,  4 Nov 2026 17:55:06 +0530
Message-ID: <20261104122508.241477-1-aluvala.sai.teja@intel.com>
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

v5: address the issues raised in the Sashiko cross review of v4:
 - Commit messages: describe the parser split, the new export and the
   MODULE_DESCRIPTION update (patch 1), and that the rfkill button only
   triggers the injection, that the injection is repeated after every
   setup and recovery re-probe, and that normal rfkill handling applies
   while HCI is down (patch 2).
 - Do not log an error when the injection fails with -ENETDOWN (HCI
   down), and log "unavailable" instead of "not found" when the lookup
   fails with an error.
 - Remove the unused api_lock_enabled field.
 - Reword comments: the initial rfkill check is deferred, not skipped,
   and "notification" is now "injection".

v4:
 - In test mode, ignore an rfkill release only if the assertion was not
   handled by the normal path (HWRFKILL_ON clear), instead of testing
   HCI_UP without req_lock.

v3:
 - Fall back to the normal rfkill handling when HCI is down, so the
   test mode no longer suppresses it.
 - Send the deferred post-setup notification when HCI is opened again.

v2:
 - Drop the btintel "Zero-initialize new_ver" patch, as
   btintel_read_version_tlv() already clears the structure.
 - Arm the post-setup injection before setting SETUP_DONE, so the rfkill
   work cannot inject ahead of it.
 - Keep the post-setup injection pending if HCI is down when the rfkill
   work runs.
 - Document that the test mode intentionally injects on every rfkill
   assertion and skips the initial rfkill check after the post-setup
   injection, and that the api_lock check uses the operational firmware
   version.

Sai Teja Aluvala (2):
  Bluetooth: btintel_pcie: Move debug INI parsing to debug file
  Bluetooth: btintel_pcie: Add fatal error injection test mode

 drivers/bluetooth/btintel.c            |   5 +-
 drivers/bluetooth/btintel.h            |   1 +
 drivers/bluetooth/btintel_pcie.c       | 161 ++++----------
 drivers/bluetooth/btintel_pcie.h       |   5 +-
 drivers/bluetooth/btintel_pcie_debug.c | 295 ++++++++++++++++++++++++-
 drivers/bluetooth/btintel_pcie_debug.h |  32 ++-
 6 files changed, 371 insertions(+), 128 deletions(-)

-- 
2.53.0

