Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 038A21E47CC
	for <linux-bluetooth@vger.kernel.org>; Wed, 14 Oct 2026 06:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791959296; cv=none; b=Jmk0IssffCMgBfEDeASOatQwXbrxEMwRGA/OlyIMGujO3TldOiP5Dc+M2v51TiRF0DNVkJAJl24I5dHJ8f2CAKx5q54vcqPJ8nThUjNo1FILsSne6xodp+UfSZTc718/viLF7cGt548GS1nYfgPeRCQGP+uymjRdzW1mBwOdJ8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791959296; c=relaxed/simple;
	bh=iPLSUDhIFmf7py61PUAZ2hXWtg3IaeWXTauendeBBm8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Pv4JpbkO+kd0/FQkCTv3Ys3yXSsdxndKmC/STtAnZydGlEkaCc1ib3LaqUp8xvQqGqBO9KpqXKm0i4lByXspO3bDca83RSpessTNhZjxPSIceZ0UsooBhr63MTtUSrqbic5wWe/J6RjhSEE+exHUv6cElXKTYvrRcN6+8GNlLuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aShdcCgj; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aShdcCgj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791959295; x=1823495295;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=iPLSUDhIFmf7py61PUAZ2hXWtg3IaeWXTauendeBBm8=;
  b=aShdcCgjYF5dEFDmBKiG1EnidY8zNrUHH8NnzD4lfltDgTdBH7/JpqMn
   AVPx1XcpbP8qamEdU+R71CA8AAAvhMaS47KZ/MQ5WZkycmsRSm1AQEjzA
   7nULH1jx8ITgP8x32dnfy5UcG9R981HvMppCaSXoSPeEFS03xxdUZ6V1T
   6eoTbiE3GYjBR/hwV3AaF1pqLzAzwvGoB4FfsVSb0Tb+N9T8yjIBOLSrv
   VB/PDUUjoueXQiAP6rmUsJUd5n/BC9sidpeLkYTwUyn3MIy1paC9Myw99
   euH+AiCZVvSz0JO14sMC/bN+N21kvOGvpUAyImVTxC9e9RJYoNemczHd8
   g==;
X-CSE-ConnectionGUID: Xp0JteeDR5O/e26J2EqDvw==
X-CSE-MsgGUID: M1Sekvg5SlKxYm5rKQdClw==
X-IronPort-AV: E=McAfee;i="6800,10657,11934"; a="598741"
X-IronPort-AV: E=Sophos;i="6.27,157,1787036400"; 
   d="scan'208";a="598741"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 23:28:14 -0700
X-CSE-ConnectionGUID: vnxRCz/HQhKHgIKjF3FT5A==
X-CSE-MsgGUID: 2uFUpI6CQjaZ9jEyvGQlQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,157,1787036400"; 
   d="scan'208";a="1449129"
Received: from weba0534.iind.intel.com ([10.66.226.131])
  by fmviesa005.fm.intel.com with ESMTP; 13 Oct 2026 23:28:13 -0700
From: Sai Teja Aluvala <aluvala.sai.teja@intel.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org
Cc: kiran.k@intel.com,
	chethan.tumkur.narayan@intel.com,
	Sai Teja Aluvala <aluvala.sai.teja@intel.com>
Subject: [PATCH v3 0/2] Bluetooth: add hardware rfkill handling
Date: Wed, 14 Oct 2026 11:49:45 +0530
Message-ID: <20261014061947.1238279-1-aluvala.sai.teja@intel.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds hardware rfkill handling for the Intel PCIe transport
and the Bluetooth-side notification path.

The resulting flow is:

  transport hardware event
    -> hci_rfkill_set_hw_state()
    -> rfkill hardware state
    -> hdev->rfkill_block work
    -> HCI_RFKILLED state and device power handling

For Intel PCIe controllers, the series adds GP2 and HW_RFKILL MSI-X
handling, IPC_CONTROL doorbell synchronization, delayed state checking,
reset/shutdown/remove/suspend lifecycle handling, and notification of
the generic HCI rfkill layer.

Patches:

  1. Bluetooth: Add HCI interface for HW rfkill events
  2. Bluetooth: btintel_pcie: add HW rfkill interrupt/doorbell flow

Changes since v2:

Sashiko's automated review of v2 is available at:
  https://sashiko.dev/#/patchset/cover.1790905146.git.aluvala.sai.teja%40intel.com

The following genuine concerns it raised against this series have been
addressed:

  - hci_rfkill_set_hw_state() could race with hci_unregister_dev() and
    let hdev->rfkill_block run after hdev->rfkill was destroyed; the
    work is now scheduled while still holding hdev->unregister_lock.
  - The asynchronous hardware rfkill work item and the rfkill core's
    synchronous set_block callback could race on HCI_RFKILLED and
    controller power state; both paths are now serialized with a new
    hdev->rfkill_lock.
  - The HW rfkill worker could dereference data->hdev before probe had
    published it; an early NULL check was added.
  - The worker and HW_RFKILL MSI-X cause could still run or fire during
    shutdown, reset, probe failure, remove, and suspend, racing with
    those lifecycle paths; the cause is now masked and the worker
    drained before each of them, and unmasked again after setup/resume.
  - A hardware rfkill release during suspend was not reported after
    resume because the initial state check unconditionally suppressed
    the first "off" result; it is now only suppressed when rfkill was
    not previously asserted.
  - GP2 completion could be falsely triggered by a stale interrupt
    that happened to match the current register state; the firmware
    acknowledgment is now checked against the specific requested
    transition.

Not reported by Sashiko, but found during this review and also fixed:

  - hci_rfkill_set_hw_state() now flushes hdev->rfkill_block before
    returning, closing a race where a userspace power-on could see a
    stale HCI_RFKILLED flag.
  - btintel_pcie_shutdown() keeps HW_RFKILL monitoring enabled when
    shutdown is itself caused by an active assertion, so a later
    de-assertion can still be detected.

The rfkill registration-failure path was also reviewed and confirmed
safe (hdev->rfkill is only published after hci_register_dev()
succeeds).

Pre-existing issues flagged by Sashiko that are unrelated to this
series (a workqueue leak on an existing probe failure path, and an
existing hci_unregister_dev() resource-ordering concern) were left
unchanged.

v2 also dropped the Bluetooth-specific debugfs test hook, the redundant
hdev->rfkill pointer-clear patch, and the separate RFKILL-core helper
dependency that were present in v1.

The series has been prepared against bluetooth-next/master.

Sai Teja Aluvala (2):
  Bluetooth: Add HCI interface for HW rfkill events
  Bluetooth: btintel_pcie: add HW rfkill interrupt/doorbell flow

 drivers/bluetooth/btintel_pcie.c | 197 +++++++++++++++++++++++++++++--
 drivers/bluetooth/btintel_pcie.h |  30 +++++
 include/net/bluetooth/hci_core.h |   4 +
 net/bluetooth/hci_core.c         |  51 +++++++-
 4 files changed, 273 insertions(+), 9 deletions(-)

-- 
2.53.0

