Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793628624;
	b=G8QNCWsAGT72IGpl3YUyuI/O0bvUA0tAdwPhuksbArPEgKCrr5Zo6ecyHXhZLr9/ZYoh
	 hd+W/k9SRHB5X2N1iu7FdRJU/Xho/5ORWBqz3Nd1/lUXd59Vuf4Hd0CyFsFfO/7Qtl2Pl
	 eiEG7YY5Upoy38hl90KmL81RlebWlm8LTaEA4TBMOXzoCfyTGq8D7z0+J2uJsB+BDln8x
	 yaMFp++wSL6CyIWlG/8Aulk5suLz3O53WomBlMdi13lC2rsO4SrNTUmm3I8pVn8a9NjFn
	 n8HaFrQLZJGM0HXRBourUehXUeFKd0FgJAgBFrp0iNTkJjnpo5GumTuL5P0mbzIjHQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793628624;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=qulvHBbGQn+WCX3/6pqjsBwvG1ll++yZXseIoilvwac=;
	b=08QLLMkFNLEkv1gstF2Myy7pyUo2JNJD1zsmls2JkpyaMCoXKonzAPDgSwW7oKAKx28F
	 j++omNyQWfrHhvMFou+ipmiwiqkWofS0p6S4uy3+GzAIhVRnLv2ldJFfghffxHDSwUZEP
	 vaiCuUzV6ZLLUvj+AjIypxPjc7nfu5lPEEv4evvj8Ay6pmUBu1G4Hk5VTGaaMWrG8TvXr
	 qa9j+Mgy91e0U4YI0QMGIlNpBcY0mCtU1U1X9icOrUm6J5fWbzlFoUkjpQb20Ao1WTl+T
	 q7rDh2P734//sP1ZcKQzbzsUK1txHKC+RxvKlXeEOGnubNxk58D6Iv/j3v/KSL8/vOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=YLCjkxuR;
	arc=none smtp.remote-ip=198.175.65.11
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC8C0606A324
	for <linux-bluetooth@vger.kernel.org>; Mon,  2 Nov 2026 14:10:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CC8C0606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=YLCjkxuR
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793628623; x=1825164623;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=1RY5SUyIbF30PLg8q2pmmVWRwP7VqMITJk+LhdPAWqI=;
  b=YLCjkxuRhI98vbzrXE0GhVvWegthmT4Baup9+Gp44mautnU5if+7Oij4
   o8qDYGUmM0KyY84nsABJd4NxdVpuEWP9M1Lgg3U5x4PevjFF3l75Y7FgE
   HIEGqz+TYYMTOOXp0RuZ8/kmcf2ZY+C5IJliS3HGCU42PKuituW/94oz8
   hipAfbRoIcUpsb7iMysrIJ9c9Jdo6dcvRcXaKL0m1ktQP8B37rqqaVSjt
   Q0Xkv0XEtavhiSPLktYzFpQ/6JEoFHrFJyZc0bbjM+kDsu9ImrsWju/3O
   vVLc+8PP/he64ByUsD185wh06+16g2/czNTWmimQAnVemXv+KHPg2mgKX
   Q==;
X-CSE-ConnectionGUID: HQJ/XqlAT8asccL45uE6ag==
X-CSE-MsgGUID: uk9eXZgKQ+S6nekxAbM9bA==
X-IronPort-AV: E=McAfee;i="6800,10657,11954"; a="2199649"
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="2199649"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 06:10:23 -0800
X-CSE-ConnectionGUID: KWwCKrU/TwWqVX0UkRhgQg==
X-CSE-MsgGUID: eXpde/DbSmWojb9gap7f0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="6301586"
Received: from weba0534.iind.intel.com ([10.66.226.131])
  by fmviesa002.fm.intel.com with ESMTP; 02 Nov 2026 06:10:21 -0800
From: Sai Teja Aluvala <aluvala.sai.teja@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: kiran.k@intel.com,
	chethan.tumkur.narayan@intel.com,
	Sai Teja Aluvala <aluvala.sai.teja@intel.com>
Subject: [PATCH v1 0/3] Bluetooth: btintel_pcie: debug INI rework and fatal error injection
Date: Mon,  2 Nov 2026 19:31:49 +0530
Message-ID: <20261102140152.2307401-1-aluvala.sai.teja@intel.com>
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
file, adds a test mode for injecting firmware exceptions, and fixes an
uninitialized variable in the shared btintel bootloader setup.

Patch 1 moves the debug INI parser (DBG_PATH, ENABLE_INI, LOG_MASK)
from btintel_pcie.c to btintel_pcie_debug.c, so that all debug INI
handling lives in one file. The parsing behaviour is unchanged.

Patch 2 adds the FATAL_ERR_TESTMODE debug INI option. It injects a
firmware exception for testing. The INI value selects the exception
type and the injection context (thread, IRQ or rfkill). Whether the
exception is expected to trigger recovery depends on its type. The
test mode is disabled when the OPFW API lock is set, unless the
unlocker firmware was loaded.

Patch 3 zero-initializes new_ver in the bootloader setup. Fields that
are missing from the controller response, such as api_lock, were left
as uninitialized stack data and copied to the caller.

Sai Teja Aluvala (3):
  Bluetooth: btintel_pcie: Move debug INI parsing to debug file
  Bluetooth: btintel_pcie: Add fatal error injection test mode
  Bluetooth: btintel: Zero-initialize new_ver in bootloader setup

 drivers/bluetooth/btintel.c            |   7 +-
 drivers/bluetooth/btintel.h            |   1 +
 drivers/bluetooth/btintel_pcie.c       | 138 ++----------
 drivers/bluetooth/btintel_pcie.h       |   5 +-
 drivers/bluetooth/btintel_pcie_debug.c | 280 ++++++++++++++++++++++++-
 drivers/bluetooth/btintel_pcie_debug.h |  33 ++-
 6 files changed, 335 insertions(+), 129 deletions(-)

-- 
2.53.0

