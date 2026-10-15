Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0764A414412
	for <linux-bluetooth@vger.kernel.org>; Thu, 15 Oct 2026 17:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792087150; cv=none; b=HEud7dJi8ealutbVXvfoV9+x4ErUMiIJVWUj1l+oBGi2l9cyXkx+U54ETkzeEe27DG8gaUfc1CXYtoUdUVC94zZOxQB9kJR/Vun8J1mCFzQNt4NnziAFhfl/is0lMSmQVdeNaWEfpjgZPTnYZCsSytdXt8iMjB6KOC66Zqf9RF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792087150; c=relaxed/simple;
	bh=ZOrff8RorN0Xg3KyY5LLH03Qcu1AzkZctFwyZXTkg9g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VyORlmUplxZ6eO+wrIviqFaKQ0kUFwuYTuLVVBCntoom5jcbzO6k6xZSlPxMy/1lIciX6L9878UtXOgFABnHm8XlgX5PEECBQbxkSbpQki0zkid9WGZ3Cbi9R9Dn66W/3LeZ7j2JuNJS1Um2C7v8RNGYpMxR2agg/3/Rb2nrz54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IDvwTYbQ; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IDvwTYbQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792087145; x=1823623145;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ZOrff8RorN0Xg3KyY5LLH03Qcu1AzkZctFwyZXTkg9g=;
  b=IDvwTYbQhMrg+7mvhf6+CBXt1TuUoMtju9TRwp58m7vYK8wvONzcNQKE
   KYwp5eAj9STiDhJ45IUSAMNzKgPHylr8dsTU2KS7fbbi+j6JI43mQptAf
   /BzbGfj9qpfIs6NvsVIrZPBt2J+VqU9GTMjVKIJt43mUlJhdoUsdE1zxC
   iD8qdK7uf7AS9+iKwhDt6g4xR4dKeTzXWfM8zsvIRTNs8b//H9JNV0MTa
   xAuDo6ElAjWftJdA//saD3nN7I3XTqOEX6PLMYjoHVHCYyzFWGZRRljPz
   vfHnhLTeoZ3U/6+UM4ZXhk4qJwPoVfBP15lLkOezitAV6ijoloAg/QEBz
   Q==;
X-CSE-ConnectionGUID: dshokZijR5+Uy1AJKIaIhw==
X-CSE-MsgGUID: xq+XlO5aSRqSMnfK6rnx7Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11936"; a="971328"
X-IronPort-AV: E=Sophos;i="6.27,160,1787036400"; 
   d="scan'208";a="971328"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2026 10:59:04 -0700
X-CSE-ConnectionGUID: GeY/DT+rSl6NuZXCk7X6jQ==
X-CSE-MsgGUID: aaCNMWsmRpOIbBEvAD/w6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,160,1787036400"; 
   d="scan'208";a="1641975"
Received: from weba0534.iind.intel.com ([10.66.226.131])
  by orviesa007.jf.intel.com with ESMTP; 15 Oct 2026 10:59:02 -0700
From: Sai Teja Aluvala <aluvala.sai.teja@intel.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org
Cc: kiran.k@intel.com,
	chethan.tumkur.narayan@intel.com,
	Sai Teja Aluvala <aluvala.sai.teja@intel.com>
Subject: [PATCH v8 0/2] Bluetooth: add hardware rfkill handling
Date: Thu, 15 Oct 2026 23:20:34 +0530
Message-ID: <20261015175036.1690457-1-aluvala.sai.teja@intel.com>
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

Changes since v7:

Sashiko's automated review of v7 is available at:
  https://sashiko.dev/#/patchset/20261015160215.1658054-1-aluvala.sai.teja%40intel.com

  - rfkill_wait_state/rfkill_wait_done were set without a lock, so a
    late GP2 acknowledgment of a timed-out doorbell could complete the
    next doorbell before firmware handled it. Both are now set under
    ipc_lock, which the GP2 handler also takes.

The shutdown concern was reviewed; no functional change was made.
Firmware accepts HCI reset regardless of the HW rfkill state, and an
assertion not yet seen by the worker is handled like one while HCI is
down: the worker still reports the block and handles the release. A
comment in btintel_pcie_shutdown() now documents this.

Changes since v6:

Sashiko's automated review of v6 is available at:
  https://sashiko.dev/#/patchset/20261014172114.1426239-1-aluvala.sai.teja%40intel.com

  - After shutdown acknowledged an assertion, IPC_CONTROL still held
    that acknowledgment while the switch was asserted, so a later
    worker run (e.g. after s2idle resume) treated it as a release and
    reported an unblock. A release is now only handled once FUNC_CTRL
    shows the switch released.

Not reported by Sashiko, also fixed in v7:

  - The check added in v5 to keep HCI_RFKILLED set on a soft unblock
    while HW rfkill is asserted used rfkill_blocked(), which inside
    set_block still reports the soft block being removed. A soft
    block followed by a soft unblock therefore left HCI_RFKILLED set
    on every controller. The hardware state is now tracked in a new
    HCI_HW_RFKILLED flag instead.
  - hdev->rfkill_block also used rfkill_blocked(), so if it ran just
    after a soft unblock it could block the device again while rfkill
    reported it unblocked. It now combines HCI_HW_RFKILLED with
    rfkill_soft_blocked().
  - With CONFIG_RFKILL=n, hci_rfkill_set_hw_state() returned early,
    so a HW rfkill assertion neither powered off nor blocked the
    device. The hardware state is now enforced without an rfkill
    device too.

Rebased onto the latest bluetooth-next, which added YoYo debug
support to btintel_pcie. The HW rfkill worker is now also disabled
in the new btintel_pcie_probe_cleanup(), which replaces the old
probe failure reset.

Changes since v5:

Sashiko's automated review of v5 is available at:
  https://sashiko.dev/#/patchset/20261014165156.1413500-1-aluvala.sai.teja%40intel.com

The following concerns it raised have been addressed in v6:

  - hci_rfkill_set_hw_state() checked the soft block state and cleared
    HCI_RFKILLED without hdev->rfkill_lock, racing with a concurrent
    soft block; it now runs under hdev->rfkill_lock.
  - hdev->rfkill_block read rfkill_blocked() before taking
    hdev->rfkill_lock, so a concurrent soft unblock could leave a stale
    block applied; the state is now read under the lock.
  - The worker's doorbell(false) and shutdown's doorbell(true) could
    overlap and consume each other's GP2 acknowledgment; doorbell
    transitions are now serialized with a new rfkill_doorbell_lock.
  - HW_RFKILL is unmasked again during the setup firmware download
    retry; the worker now does nothing until setup has completed, and
    the setup retry path is left as in upstream.

Changes since v4:

Sashiko's automated review of v4 is available at:
  https://sashiko.dev/#/patchset/20261014082650.1270679-1-aluvala.sai.teja%40intel.com

Two genuine issues were found in the flush_work() added to
hci_rfkill_set_hw_state() in v3, and are fixed in v5:

  - Flushing hdev->rfkill_block under hdev->unregister_lock could
    deadlock against hci_dev_close_sync() taking hdev->lock and a
    mgmt command holding hdev->lock in hci_cmd_sync_submit().
  - The flush did not order the work before rfkill core's async
    event, so userspace could still see a stale HCI_RFKILLED flag.

The flush is removed. On release, HCI_RFKILLED is now cleared before
rfkill_set_hw_state() if the device is not soft blocked.

Not reported by Sashiko, also fixed in v5:

  - A soft unblock cleared HCI_RFKILLED while the hardware switch was
    still asserted, allowing the controller to be powered on under a
    hard block; the flag is now kept set in that case.
  - hci_unregister_dev() no longer takes hdev->unregister_lock around
    rfkill_unregister(), which created a lock-order inversion with
    rfkill_global_mutex. HCI_UNREGISTER, already set under that lock,
    stops further hci_rfkill_set_hw_state() calls.
  - btintel_pcie_shutdown() no longer masks HW_RFKILL, so HW rfkill
    events are still reported to the stack while HCI is down.

The remaining concerns were reviewed; no further changes were made.

Changes since v3:

Sashiko's automated review of v3 is available at:
  https://sashiko.dev/#/patchset/20261014061947.1238279-1-aluvala.sai.teja%40intel.com

Of the concerns raised, one was a genuine bug and is fixed in v4:

  - A masked HW_RFKILL MSI-X cause still latches, so an unrelated
    interrupt during remove could requeue the HW rfkill worker after
    it was canceled, leading to a use-after-free. The handler now only
    queues the worker while HW_RFKILL is unmasked, and remove and the
    probe failure path disable the worker instead of canceling it.

The remaining concerns were reviewed; no further changes were made.

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
unchanged, as requested.

v2 also dropped the Bluetooth-specific debugfs test hook, the redundant
hdev->rfkill pointer-clear patch, and the separate RFKILL-core helper
dependency that were present in v1.

The series has been prepared against bluetooth-next/master.

Sai Teja Aluvala (2):
  Bluetooth: Add HCI interface for HW rfkill events
  Bluetooth: btintel_pcie: add HW rfkill interrupt/doorbell flow

 drivers/bluetooth/btintel_pcie.c | 221 ++++++++++++++++++++++++++++++-
 drivers/bluetooth/btintel_pcie.h |  33 +++++
 include/net/bluetooth/hci.h      |   2 +
 include/net/bluetooth/hci_core.h |   4 +
 net/bluetooth/hci_core.c         |  82 +++++++++++-
 5 files changed, 334 insertions(+), 8 deletions(-)

-- 
2.53.0

