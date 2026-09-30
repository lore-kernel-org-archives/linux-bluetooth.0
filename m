Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE85F3C276E
	for <linux-bluetooth@vger.kernel.org>; Wed, 30 Sep 2026 07:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790754643; cv=none; b=ZRdU/4GCNWuGIuds/A/753ofqxh+PTi0LL25mtaUszwQRPXvXenKwuX5H2MQ34qkVJZ5sRjmZGdT7QJBXG54K51gNb4UQ7i7gcXkGVMAwtAfpV+gsJviRA6e9ai9cpoPmGnbuXfehXXJldN/XqYefO5XEbgqYgeeCU9NCardZyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790754643; c=relaxed/simple;
	bh=OT2QWhCSlr6MIH5dWHjQyKjCLYN1JGxx71ba1Qno0jA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OI9KA1LyWzjiq7KGTQzN0TOSyV4LtXqAWQZ1bHh3q0pEQ8HCKw8Ta+MhZPPy6/aLXTi5OnXj61HE/RkW7SzKlIXnnIoIEWz2hPguW27FAcrZn0ku8Onj5UBupCXDqzmtCTtCA5OqAZnaPW67pT3XwTDSAlwBvF4Q2BPU7HyvLXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JiwMpdzW; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JiwMpdzW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790754641; x=1822290641;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=OT2QWhCSlr6MIH5dWHjQyKjCLYN1JGxx71ba1Qno0jA=;
  b=JiwMpdzWj/0dP1MtX6QGXuLXw26ymTNy5JUW71W0q7ZuDSrPItd7LeE9
   4tl4TqzCGFHkYyTfVH4GO9/EBx4z6Uw63ygJ2PX7pn15yPfyt823rqWZg
   RGZfIJFBoHPJWV5p5vxBG30q7Y1rlyYPSOa3ILc7qVhGHfu+dJEG/rYYl
   zLhh+daJKhaya+8mqi4N6yXQu/q3bddyqVXfFGsPMMgJryltxOaAN4O9z
   I0sK9LE6pgxp0mbE6dXVj1fA2tWIO81D/Upy3RTZIAVyAqZMxnSMwLso1
   ahlFdP2LoDHRBAvzh1icX6RRMIY3PbkJxjPJEo0IzK8Mn4KYYOZTHnqRv
   w==;
X-CSE-ConnectionGUID: 5J5IliPPRRysVWf2jD/uhg==
X-CSE-MsgGUID: n/zE6FMLR7CENLIb9EXBJQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11920"; a="90386133"
X-IronPort-AV: E=Sophos;i="6.27,132,1787036400"; 
   d="scan'208";a="90386133"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2026 00:50:40 -0700
X-CSE-ConnectionGUID: NHocWyxHSZSRCJRWaCd6mA==
X-CSE-MsgGUID: Vdc6u12PTUGpYe+B8RR93A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,132,1787036400"; 
   d="scan'208";a="274816246"
Received: from weba0534.iind.intel.com ([10.66.226.131])
  by fmviesa010.fm.intel.com with ESMTP; 30 Sep 2026 00:50:38 -0700
From: Sai Teja Aluvala <aluvala.sai.teja@intel.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org
Cc: kiran.k@intel.com,
	chethan.tumkur.narayan@intel.com,
	Sai Teja Aluvala <aluvala.sai.teja@intel.com>
Subject: [PATCH v1 0/4] Bluetooth: add hardware rfkill handling and test hook
Date: Wed, 30 Sep 2026 13:12:16 +0530
Message-ID: <cover.1790752799.git.aluvala.sai.teja@intel.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit


This series adds hardware rfkill handling for the Intel PCIe transport,
the Bluetooth-side notification path, and a debugfs test hook for
exercising the generic stack handling.

The resulting flow is:

  transport hardware event
    -> hci_rfkill_set_hw_state()
    -> rfkill hardware state
    -> hdev->rfkill_block work
    -> HCI_RFKILLED state and device power handling

For Intel PCIe controllers, the series adds GP2 and HW_RFKILL MSI-X
handling, IPC_CONTROL doorbell synchronization, delayed state checking,
reset/shutdown/remove lifecycle handling, and notification of the
generic HCI rfkill layer.

The debugfs hook exposes:

  /sys/kernel/debug/bluetooth/hciN/force_hw_rfkill

Writing Y or N simulates a hardware rfkill transition at the generic HCI
rfkill interface. It intentionally does not emulate the transport
driver's physical interrupt, doorbell, or register-detection logic.

Dependency:

  This series depends on the separately submitted RFKILL patch:

    [PATCH v1 0/1] rfkill: expose hardware-only block state

  That patch adds rfkill_hard_blocked() to:

    include/linux/rfkill.h
    net/rfkill/core.c

The dependency is being submitted separately to wireless-next because
include/linux/rfkill.h and net/rfkill/core.c are maintained by the
RFKILL/linux-wireless maintainers. The RFKILL patch is not duplicated in
this Bluetooth series. Once the RFKILL series is archived, its lore link
is:

  https://lore.kernel.org/linux-wireless/cover.1790752797.git.aluvala.sai.teja@intel.com/

Patches:

  1. Bluetooth: Add interface to allow stack to communicate hw rfkill events
  2. Bluetooth: hci_core: clear hdev->rfkill after destroying it
  3. Bluetooth: btintel_pcie: add HW rfkill interrupt/doorbell flow
  4. Bluetooth: hci_debugfs: add force_hw_rfkill test hook

Changes in v1:
  - Initial version.

The series has been prepared against bluetooth-next/master.

Sai Teja Aluvala (4):
  Bluetooth: Add interface to allow stack to communicate hw rfkill
    events
  Bluetooth: hci_core: clear hdev->rfkill after destroying it
  Bluetooth: btintel_pcie: add HW rfkill interrupt/doorbell flow
  Bluetooth: hci_debugfs: add force_hw_rfkill test hook

 drivers/bluetooth/btintel_pcie.c | 140 ++++++++++++++++++++++++++++++-
 drivers/bluetooth/btintel_pcie.h |  27 ++++++
 include/net/bluetooth/hci_core.h |   3 +
 net/bluetooth/hci_core.c         |  35 ++++++++
 net/bluetooth/hci_debugfs.c      | 107 +++++++++++++++++++++++
 5 files changed, 308 insertions(+), 4 deletions(-)


base-commit: fdd5964bd389936856971647fcac3442117009dc
-- 
2.53.0
