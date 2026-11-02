Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793641562;
	b=xrTcVhXwa50Y6DlSUmyISzX7vtb2cq13MU52pX+BpOY7gElpfc182yP8Ae8A08juGVvb
	 K5Z2b1gZ4b1eqb9cBxI6ebJ+tTECzrHai+tpaNSwFv9qoMiKnKuOr1zCbC4ThP6rB8xyB
	 wPoKbxiQXz2uYDVgQ4qgwYvSmYdS1dIcQ+MT+56n7cIwMWUTFWY7HFUgGL3ITMVkBA2D1
	 9joSyp0l+ZDL0N2EvuFD7JAkOUiuEi5S9hMuOVLqw4N+cSAN3hA2lZaTPIt+guGI4GlZw
	 0iZYyL7tCAIeFMgIHodWNNtusap2ptPC7tK3zb36gk8yl+z40GMFTj8RXFpqHH2Q/YQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793641562;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=TFnGewZY17lDabE642g91v5xUsfcm45SI+CMWCUQOnk=;
	b=21zxOdvmqcGaCMCiuQe1DJsm5RUXFZcqBdcUMk6QTBwBuKE4daqIlWfH3CAZJ66N0Tjx
	 WesMWrf15cZ3N027AziV6cSsQP7ZOfesYVOvylR1v8ZYkanO/PwtCRE1k0WL63RNmHPS3
	 qxHhPUNPgnXS7TN21aY647VWIJiblwcMQZGmKfZ3Owhv4wU4MeHbxJSXM6N6W2gYbgpF9
	 Msox9N7fdtS4//sOdLe/xBpBxH/AiEpGg68PHzgWsOT3JnPTY3XlZME2W8V8NEj1RQfLV
	 ssfDzALiiSd2aMHn0uB8w0hzrKajnL8kdVbfcYxc1um0QQztePpR6QWLfgu075vYk5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=kz7KmsQ4;
	arc=none smtp.remote-ip=198.175.65.16
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B17A6074664
	for <linux-bluetooth@vger.kernel.org>; Mon,  2 Nov 2026 17:46:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8B17A6074664
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=kz7KmsQ4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793641560; x=1825177560;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=FvvQMjOT1jmpYZNT/7xxnr4vCwDwv246u9RIex5Wt4M=;
  b=kz7KmsQ4nCgdTTVfL/eXhlPOM2S8mIh9GdYneTeNSp+8ccfj5yZNqXMI
   lv3DHBkxtItvW6aigWEdYzzKfLqGctlzgmWupEeUuZEI3ZRmF5pmsPgZT
   NdBWJ8gLOYPekRw3ocU2IXxNXEI5yppTICD4nrr7EHTblqs0g7NPWHM6v
   LdIkuRd0dUX1Cg99s2vVLxEVjQa2Em08ztdTvUOfx9JtSq4AFJ34VQOhn
   E0iqO+wzepr8Hb/QHg1m+Sj9Sm/iU47lyq5GQuL116bZk+AHHHYPu2FB2
   T8a1ZcxlxeiUmtDh0GxI0ne7vlYeWQ3PI4rkRW3qNZBSgQenvnYfNml2N
   g==;
X-CSE-ConnectionGUID: PxNmun/WQcKc7omNnsFZeA==
X-CSE-MsgGUID: rKMugZXFRdu1SG9pKTZeLg==
X-IronPort-AV: E=McAfee;i="6800,10657,11954"; a="2338655"
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="2338655"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 09:46:00 -0800
X-CSE-ConnectionGUID: kKwc1O96Qyq7B2G7BHq/CA==
X-CSE-MsgGUID: B4Up8uJJRIWmf0hw5VLZ8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="8023720"
Received: from weba0534.iind.intel.com ([10.66.226.131])
  by fmviesa013.fm.intel.com with ESMTP; 02 Nov 2026 09:45:59 -0800
From: Sai Teja Aluvala <aluvala.sai.teja@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: kiran.k@intel.com,
	chethan.tumkur.narayan@intel.com,
	Sai Teja Aluvala <aluvala.sai.teja@intel.com>
Subject: [PATCH v3 0/2] Bluetooth: btintel_pcie: debug INI rework and fatal error injection
Date: Mon,  2 Nov 2026 23:07:28 +0530
Message-ID: <20261102173730.2626329-1-aluvala.sai.teja@intel.com>
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
 drivers/bluetooth/btintel_pcie.c       | 160 ++++---------
 drivers/bluetooth/btintel_pcie.h       |   5 +-
 drivers/bluetooth/btintel_pcie_debug.c | 296 ++++++++++++++++++++++++-
 drivers/bluetooth/btintel_pcie_debug.h |  33 ++-
 6 files changed, 372 insertions(+), 128 deletions(-)

-- 
2.53.0

