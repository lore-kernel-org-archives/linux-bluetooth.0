Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 230534A0F11
	for <linux-bluetooth@vger.kernel.org>; Wed, 14 Oct 2026 08:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791966920; cv=none; b=R34TC/Bs4WOU0XNTO3JZFzir8Mgys9R1Bam0Fzm/Cy9e0iEkfPunZyC0abvzc8eAloaAGWfVaL2841npqLC9ySspwZR28k0xc4wIEW3wKhtqpdhboe9Bk/iqLvhaOjvBfEf2CVBlLjRjgW6cbkar62BnAirDI8nIU2rC11F4h88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791966920; c=relaxed/simple;
	bh=WF9mzXoojrS4n1l+4hsQgtqR2gazkpzBM5BX0qZTFr8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=THwyxziQ1c9b3GtxDMaLUyMjhGdo8GWedK5YpxwFZLSTqBEk1tsa+M/Kt7EcqMBeFBneoEE1n7UGEDVqzuI08+5uclD6CgsvnWbgXx9/3urYKUzOYSUY9s97emV01/OhSJ1YVapBLpZ55IwDapj/ro5kQ5aVRNcRFShQNX98bkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VtcfNyyT; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VtcfNyyT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791966918; x=1823502918;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=WF9mzXoojrS4n1l+4hsQgtqR2gazkpzBM5BX0qZTFr8=;
  b=VtcfNyyTTfR7lOKmWurA1FBvJztBjqz4rJuLevsp6B3QnEB9CiyS/RIW
   H7SuS8hyOUiLjevSWvzd4+4QTYmyZE0tw4ICuxytdI70jvnFvK1KgnEIe
   LD3jjIwjj2fDuGqxJEq4oq3I5b2Q9hBt5TW7AuNg++u1DjFme+Z/It/AI
   GCRvUuOiYjj5ObcK+dGVApbhdEc0qfL00Nl7BoD/Gi8bsDNl1jPsMJukj
   QGig2e/T0kN2jPQEPNnAZl5U4BlAdhnC/RWLaFP0EvGTpe+GJbJQUTyF2
   WLYEd8pQvyRwad3fr/tH2/WtKUOOxyjcSWLdbhJ5QyntDYgQGxeakQi8j
   w==;
X-CSE-ConnectionGUID: iSkqFLgZRoK5iAWlCa+39g==
X-CSE-MsgGUID: HLeJsdiDQyyrct6PFJ6nIg==
X-IronPort-AV: E=McAfee;i="6800,10657,11934"; a="593393"
X-IronPort-AV: E=Sophos;i="6.27,157,1787036400"; 
   d="scan'208";a="593393"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2026 01:35:17 -0700
X-CSE-ConnectionGUID: 8ZhDvie6R0y7LSFYL4lOHQ==
X-CSE-MsgGUID: f9MwVsvmTLSJhvJMr1Fwig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,157,1787036400"; 
   d="scan'208";a="1704415"
Received: from weba0534.iind.intel.com ([10.66.226.131])
  by fmviesa008.fm.intel.com with ESMTP; 14 Oct 2026 01:35:16 -0700
From: Sai Teja Aluvala <aluvala.sai.teja@intel.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org
Cc: kiran.k@intel.com,
	chethan.tumkur.narayan@intel.com,
	Sai Teja Aluvala <aluvala.sai.teja@intel.com>
Subject: [PATCH v4 0/2] Bluetooth: add hardware rfkill handling
Date: Wed, 14 Oct 2026 13:56:48 +0530
Message-ID: <20261014082650.1270679-1-aluvala.sai.teja@intel.com>
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

 drivers/bluetooth/btintel_pcie.c | 202 +++++++++++++++++++++++++++++--
 drivers/bluetooth/btintel_pcie.h |  30 +++++
 include/net/bluetooth/hci_core.h |   4 +
 net/bluetooth/hci_core.c         |  51 +++++++-
 4 files changed, 277 insertions(+), 10 deletions(-)

-- 
2.53.0

