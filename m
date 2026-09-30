Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C593459AF8
	for <linux-bluetooth@vger.kernel.org>; Wed, 30 Sep 2026 07:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790754660; cv=none; b=mIFzgTiabI3J6t79QPAmj3JuFHxqGMH/2F4Xw22TfRt1PSOAa7txQQTrfmaCmyyRhjEa+wR7gypqHoHniQlUHnvMdETj0Wi21Kn+W+CyPlU6s8mhaqQPnMX/72t9hQKN4tdDcLqIMc8vi+YYIGyAxY9aHuKNVxy5kHpYmai4kag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790754660; c=relaxed/simple;
	bh=K8AJMELE1oMdZTDDVeq3lhlli48EgH6L/bw6RoM9WyY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EDdXGbz4JFXFDO+g3JafuZRnPYgNuYpPW4RU7qmSG8MqoCM5qtD3arlEptumVxbrYZpJjnZSNF8tdl5Cv/UfyvgbLBpF/CBhPo95Mahm4SMdK1W0jbp6imwY6FZQEU2uZNQ3aE0SYRoe0ozNsFdCn5aLZiXxbpz2HWGX02szw1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XTwjuY56; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XTwjuY56"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790754659; x=1822290659;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=K8AJMELE1oMdZTDDVeq3lhlli48EgH6L/bw6RoM9WyY=;
  b=XTwjuY56xH/iKHgeEdRWyryGNURmA+KpZnp7qB2iYUIuud57Egy1KN3K
   7Nmw3gHjLMzc3r43AJchPSh+zKErryYWITciWtbqvdkSnqvPdDMKe7Xq7
   t1JfUa8UkIIFh5FEwA78kQsVP1MdiMHZdy6qfgwC/JqLrdQb+QbWLUoQV
   0rgo3Hu2srrKD7D+tT/jbflr2AHHahqgXKkyIHPKqI6bhZtVX8wbVSdB6
   hfZ63bUB272Rh/HkzSz8D3khD4P7aFRjK6/ukDA5hH7YYNOCx81KIUqn3
   lZ30PfOxUnk8tuEFl8DIfd9c50vas7rsGbpNa1rGntYCvgJSGPNhcUQEX
   A==;
X-CSE-ConnectionGUID: BCBokA5gSJenrFtKup/tzA==
X-CSE-MsgGUID: C9ypSZuVRxKpIuRRFXyvZA==
X-IronPort-AV: E=McAfee;i="6800,10657,11920"; a="90386168"
X-IronPort-AV: E=Sophos;i="6.27,132,1787036400"; 
   d="scan'208";a="90386168"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2026 00:50:58 -0700
X-CSE-ConnectionGUID: uFaOidh+RsiUBAzIn43wyg==
X-CSE-MsgGUID: oSKd3J/7Riqkm8EUU3SsSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,132,1787036400"; 
   d="scan'208";a="274816296"
Received: from weba0534.iind.intel.com ([10.66.226.131])
  by fmviesa010.fm.intel.com with ESMTP; 30 Sep 2026 00:50:57 -0700
From: Sai Teja Aluvala <aluvala.sai.teja@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: kiran.k@intel.com,
	chethan.tumkur.narayan@intel.com,
	Sai Teja Aluvala <aluvala.sai.teja@intel.com>
Subject: [PATCH v1 0/1] emulator: add generic HW rfkill test tool
Date: Wed, 30 Sep 2026 13:12:38 +0530
Message-ID: <cover.1790752800.git.aluvala.sai.teja@intel.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit


This patch adds emulator/hci_rfkill, a testing utility for the generic
Bluetooth hardware-rfkill path.

The tool operates on an hciN device and:

  - writes Y/N to the kernel force_hw_rfkill debugfs entry;
  - reads back the debugfs hardware-rfkill state;
  - verifies the corresponding /sys/class/rfkill hardware state;
  - supports enable-only, disable-only, and toggle modes;
  - optionally restores the adapter's original up/down state.

The tool is built only under TESTING and is not installed as a production
utility.

This tests the generic net/bluetooth rfkill notification and state
handling. It does not test vendor-specific hardware interrupt, doorbell,
or register-read logic. For example, the Intel PCIe interrupt/doorbell
path must still be tested with the corresponding kernel driver and
hardware or transport-level emulation.

Dependency:

  This tool requires the separate Bluetooth kernel series:

    [PATCH v1 0/4] Bluetooth: add hardware rfkill handling and test hook

  In particular, that series adds the Bluetooth kernel debugfs interface:

    /sys/kernel/debug/bluetooth/hciN/force_hw_rfkill

  The Bluetooth kernel series is submitted to bluetooth-next and itself
  depends on the separate RFKILL helper submitted to wireless-next.
  Its cover-thread lore link is:

    https://lore.kernel.org/linux-bluetooth/cover.1790752799.git.aluvala.sai.teja@intel.com/

Patch:

  1. emulator: add generic HW rfkill test tool

Changes in v1:
  - Initial version.

The patch has been prepared against bluez/master.

Sai Teja Aluvala (1):
  emulator: add generic HW rfkill test tool

 Makefile.tools        |   3 +
 emulator/hci_rfkill.c | 478 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 481 insertions(+)
 create mode 100644 emulator/hci_rfkill.c

-- 
2.53.0
