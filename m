Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DDC92AD35
	for <linux-bluetooth@vger.kernel.org>; Fri,  2 Oct 2026 01:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790905940; cv=none; b=kC0w4SUfGmvGWd99LFg2rVl6WbsNyO3vwZWyQBb+gVWFbuhaPTheEWsPugUiFet1kTYAnQgU7d00eLDqW+9YB0rWQVis4GfOSD13SP1gEIOkLaMzFY8T4HpUjD/7rY/rMWjsrg6nT+tec18/Bzaf8wVTbNcEutQiXQ3fs0KX7oE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790905940; c=relaxed/simple;
	bh=aii7tkiRtwupTbPOKj6N5WvKpzCB5kEqdBgXBRy3RJM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=knDdAlNV9/oeRt2iaytjcjuw/1CekzcSCEZCyZSzsEKR82ALTDIboKoAchDIOuopLKxW6GBabEUanP3qlmooFSFDQRXmwjmtKepB35Yrucx6JXNiG7ZBN4kiAQHKCC77u7UlscWxByAg4TE/LdOKPIr6hYNmuRb9/GPJQ5dUezk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H9GQWPAD; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H9GQWPAD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790905939; x=1822441939;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=aii7tkiRtwupTbPOKj6N5WvKpzCB5kEqdBgXBRy3RJM=;
  b=H9GQWPAD6zuMbQMESJQsby9gqVnFmITjEiY4LIwV7xYDI1MaT3sjrWw+
   9nxEPTahF69n5njGyMbsJHwaETrBEWIS34LW+tQKREOrPhXnRVLgpPwxG
   Jv/nezMeMhpffYGyDXJtmPQ7Dv/0tGPNm/HJMh1i55D01YEnu6QwF7m+H
   ip8x5zpKxESyZvFCrU+w+cTXhiW2ozDOuBAA62hJX3+jLlxKS6bXS3iJ4
   YmbEQjdu0NNP8N4OPNEV9xxxF0wWH/mFmdfEKnjJC/MAZzb2VKBTgIRoT
   VuTOrzib0pZ1xhsMBqKqspOb13zSRBsJIfvqcfcuNVx0G/caujLttcFhL
   Q==;
X-CSE-ConnectionGUID: T2Y9MKl5Sre7k9oy/zBIoA==
X-CSE-MsgGUID: gZbkvZQ9QQajbcNjYpZN+A==
X-IronPort-AV: E=McAfee;i="6800,10657,11922"; a="90814230"
X-IronPort-AV: E=Sophos;i="6.27,135,1787036400"; 
   d="scan'208";a="90814230"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2026 18:52:19 -0700
X-CSE-ConnectionGUID: NbHYeXaKR5mHvHynjQ9THw==
X-CSE-MsgGUID: ulX4Y/niQ7CsKumECVh4Iw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,135,1787036400"; 
   d="scan'208";a="304098443"
Received: from weba0534.iind.intel.com ([10.66.226.131])
  by fmviesa001.fm.intel.com with ESMTP; 01 Oct 2026 18:52:17 -0700
From: Sai Teja Aluvala <aluvala.sai.teja@intel.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org
Cc: kiran.k@intel.com,
	chethan.tumkur.narayan@intel.com,
	Sai Teja Aluvala <aluvala.sai.teja@intel.com>
Subject: [PATCH v2 0/2] Bluetooth: add hardware rfkill handling
Date: Fri,  2 Oct 2026 07:13:56 +0530
Message-ID: <cover.1790905146.git.aluvala.sai.teja@intel.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds hardware rfkill handling for the Intel PCIe transport and
the Bluetooth-side notification path.

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

Compared with v1, this version drops the Bluetooth-specific debugfs test
hook, the redundant hdev->rfkill pointer-clear patch, and the separate
RFKILL-core helper dependency. The real btintel_pcie hardware event path
and HCI notification interface are retained.

Sai Teja Aluvala (2):
  Bluetooth: Add interface to allow stack to communicate hw rfkill
    events
  Bluetooth: btintel_pcie: add HW rfkill interrupt/doorbell flow

 drivers/bluetooth/btintel_pcie.c | 140 ++++++++++++++++++++++++++++++-
 drivers/bluetooth/btintel_pcie.h |  27 ++++++
 include/net/bluetooth/hci_core.h |   3 +
 net/bluetooth/hci_core.c         |  34 ++++++++
 4 files changed, 200 insertions(+), 4 deletions(-)


base-commit: 3b44711c52eaf62723a4a715e1b7b4e49f1595ce
-- 
2.53.0
