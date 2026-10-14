Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B96D655198C
	for <linux-bluetooth@vger.kernel.org>; Wed, 14 Oct 2026 17:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791998988; cv=none; b=bH6dFB0TGFXXsJi3NpU4fFD0mtCmfSIbGyxsBDCvbVXK4/Nj5m/DUQC1nqm7ZceU2xxoRuKJvM2WJ8De4tl4TlzldVTEqKS+58T0lR36tXTkI2mWDI2mOQa9L1V7z+2irBR03ym/xzCf7CcRkEJtA2Afvsz9S9Vbj1GjF2B/84Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791998988; c=relaxed/simple;
	bh=mwDL/1LgJrzrehtdPxfebbBFb/emOX0YPxGH4nuvE+M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=vCppBeKJgMoGrMs3gb1j2hw3R3KvJwFh8fkeFjf/pKi3xBKqgeqRmcBORYRx/Kl56bILjBWvHVIrRjAk2mgfa+Lv7JfVoPGm67Wi6jsJ/gJQW7Wb8bwuokR3GiLJfcQupOt0DS0YZ7dBT02EaE2b1Iy4EStLqtiglMSAH4sYjrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Hzvc8q3p; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Hzvc8q3p"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791998983; x=1823534983;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=mwDL/1LgJrzrehtdPxfebbBFb/emOX0YPxGH4nuvE+M=;
  b=Hzvc8q3pFvhHgpB51uRcNX/J2mEsXQRY/s/PBbzPNvU4ifMGaju3vcKN
   JswaFyvbaAQgEnYTby7M70Ev3SlcpZ97BVazEkzQIGHIyFNOB5FIG07JF
   A59qkk1wNw2QeB1bqB0toZMcUhvChAs21C+Kcqctpm5i56sW2TR0P2iQ8
   1FEWCEzfsJGBeuK0pjn7d6g9iU9ZNxHMhXKju3cQPMzEQp2s82YVClCcT
   UN98Ohi901IL7NWQ7zUB1PTSEjJh/mOWbWDXCGVM+vh9B7gyL81flybN9
   0NZSPORoeI7xvjVnVb0HSRN/RzDa2fiwvofzselYBiQ8uRvFXPjUovY19
   A==;
X-CSE-ConnectionGUID: Vr7b5jt7Rm2Z4WkWHVUXng==
X-CSE-MsgGUID: IawkSsh5QMWtypNP0aBm4w==
X-IronPort-AV: E=McAfee;i="6800,10657,11935"; a="747419"
X-IronPort-AV: E=Sophos;i="6.27,158,1787036400"; 
   d="scan'208";a="747419"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2026 10:29:42 -0700
X-CSE-ConnectionGUID: D6JDSRJWSJ2fkZ/FydOeKA==
X-CSE-MsgGUID: JuelANkjSnu1kb3CbR8Utw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,158,1787036400"; 
   d="scan'208";a="1569758"
Received: from weba0534.iind.intel.com ([10.66.226.131])
  by fmviesa003.fm.intel.com with ESMTP; 14 Oct 2026 10:29:39 -0700
From: Sai Teja Aluvala <aluvala.sai.teja@intel.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org
Cc: kiran.k@intel.com,
	chethan.tumkur.narayan@intel.com,
	Sai Teja Aluvala <aluvala.sai.teja@intel.com>
Subject: [PATCH v6 0/2] Bluetooth: add hardware rfkill handling
Date: Wed, 14 Oct 2026 22:51:12 +0530
Message-ID: <20261014172114.1426239-1-aluvala.sai.teja@intel.com>
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

 drivers/bluetooth/btintel_pcie.c | 206 +++++++++++++++++++++++++++++--
 drivers/bluetooth/btintel_pcie.h |  33 +++++
 include/net/bluetooth/hci_core.h |   4 +
 net/bluetooth/hci_core.c         |  69 ++++++++++-
 4 files changed, 303 insertions(+), 9 deletions(-)

-- 
2.53.0

