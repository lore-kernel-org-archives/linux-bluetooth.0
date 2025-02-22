Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F35351DC184
	for <linux-bluetooth@vger.kernel.org>; Sat, 22 Feb 2025 21:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740261539; cv=none; b=QvFu0pISS89NNWAdIsTUE6wmXv7DqzM64M538aWRLffZcF1DabsRkjEcusmvLvOJFdLZD1ZAxIbR3M1MWrDYfaB3RSE3Ho04bZ1fP+nGJDil/EJRUbXassmgY/it9+sF9bhCtSNDtCcYU+zq4vijOkL90AF9RNbezT6B7C5huzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740261539; c=relaxed/simple;
	bh=Wzwuo+CdUb9dCRBx88SnWwkGqdJUXRLONJIoN2YweMU=;
	h=Date:From:To:Cc:Subject:Message-ID; b=O3Otn5hFG+GnV54rP2TfcV38C/Pamt5QZIu4wRRM04eFwEBu8+0qTbJ6/jRT+Nmmkur39UeqbtCnBctfWTkDlbdF9edKuZDwSZbGYAMa/ha+crZT2miqZf75/HzB5zki8qsz3CgRdTvCqyxog8fNo+ciVB9WsOLyKUNuX7nCDDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KPZkx4Ao; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KPZkx4Ao"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740261538; x=1771797538;
  h=date:from:to:cc:subject:message-id;
  bh=Wzwuo+CdUb9dCRBx88SnWwkGqdJUXRLONJIoN2YweMU=;
  b=KPZkx4Ao3XE6YwMKyZgFruIFCvti0Zd5lT5affOpzqEHJGfjk1RhaN2R
   E2bsQPGRJ/nhOosOtllID491E6hLa8mcMURSAniYvuDJ0BmhXIkBXWssm
   W4R0AaUWby4poESIrMEdPguDp8poBcQhm7FG0cBV9hzK/SE/jilWbmWBP
   0eSdIjHg7PygeRScz9L28lJDRAxJ8dD6QlH9a+wuTA+pkCjBoVfrgXcu0
   fh9rhRN7GGxUKKpURvTBNb0+2NkmymLnyf9PpuJSYWQawThggGyuvQRXn
   zUOWz9i5h7kgKbAFovCeC1T4vNH9HsQ4AkNukuGJX77g9x5dCHkmbXPZc
   w==;
X-CSE-ConnectionGUID: R75qOjxKQTOxv0jLUUOwhg==
X-CSE-MsgGUID: 5m05Y7P2TfOxHteXIrSBMw==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="52481770"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="52481770"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2025 13:58:56 -0800
X-CSE-ConnectionGUID: AfjBBN5QSwid4sY1aG7psQ==
X-CSE-MsgGUID: ZIufnb7CRTiXI6lB663k/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,308,1732608000"; 
   d="scan'208";a="115494182"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by fmviesa006.fm.intel.com with ESMTP; 22 Feb 2025 13:58:56 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tlxWP-0006wG-0f;
	Sat, 22 Feb 2025 21:58:53 +0000
Date: Sun, 23 Feb 2025 05:57:59 +0800
From: kernel test robot <lkp@intel.com>
To: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 2fc8906de82f6d80dd222eef4f20f1b2a16101c9
Message-ID: <202502230553.7oVIjOLf-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: 2fc8906de82f6d80dd222eef4f20f1b2a16101c9  Bluetooth: hci_qca: use the power sequencer for wcn6750

elapsed time: 1448m

configs tested: 69
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                           allyesconfig    gcc-14.2.0
arc                  randconfig-001-20250222    gcc-13.2.0
arc                  randconfig-002-20250222    gcc-13.2.0
arm                  randconfig-001-20250222    gcc-14.2.0
arm                  randconfig-002-20250222    gcc-14.2.0
arm                  randconfig-003-20250222    clang-16
arm                  randconfig-004-20250222    gcc-14.2.0
arm64                randconfig-001-20250222    gcc-14.2.0
arm64                randconfig-002-20250222    clang-21
arm64                randconfig-003-20250222    clang-18
arm64                randconfig-004-20250222    clang-21
csky                 randconfig-001-20250222    gcc-14.2.0
csky                 randconfig-002-20250222    gcc-14.2.0
hexagon                         allmodconfig    clang-21
hexagon                         allyesconfig    clang-18
hexagon              randconfig-001-20250222    clang-17
hexagon              randconfig-002-20250222    clang-19
i386                            allmodconfig    gcc-12
i386                             allnoconfig    gcc-12
i386                            allyesconfig    gcc-12
i386       buildonly-randconfig-001-20250222    clang-19
i386       buildonly-randconfig-002-20250222    gcc-12
i386       buildonly-randconfig-003-20250222    gcc-12
i386       buildonly-randconfig-004-20250222    clang-19
i386       buildonly-randconfig-005-20250222    gcc-12
i386       buildonly-randconfig-006-20250222    clang-19
i386                               defconfig    clang-19
loongarch            randconfig-001-20250222    gcc-14.2.0
loongarch            randconfig-002-20250222    gcc-14.2.0
nios2                randconfig-001-20250222    gcc-14.2.0
nios2                randconfig-002-20250222    gcc-14.2.0
parisc               randconfig-001-20250222    gcc-14.2.0
parisc               randconfig-002-20250222    gcc-14.2.0
powerpc              randconfig-001-20250222    gcc-14.2.0
powerpc              randconfig-002-20250222    gcc-14.2.0
powerpc              randconfig-003-20250222    gcc-14.2.0
powerpc64            randconfig-001-20250222    gcc-14.2.0
powerpc64            randconfig-002-20250222    clang-16
powerpc64            randconfig-003-20250222    clang-18
riscv                randconfig-001-20250222    clang-21
riscv                randconfig-002-20250222    gcc-14.2.0
s390                            allmodconfig    clang-19
s390                            allyesconfig    gcc-14.2.0
s390                 randconfig-001-20250222    gcc-14.2.0
s390                 randconfig-002-20250222    clang-15
sh                              allmodconfig    gcc-14.2.0
sh                              allyesconfig    gcc-14.2.0
sh                   randconfig-001-20250222    gcc-14.2.0
sh                   randconfig-002-20250222    gcc-14.2.0
sparc                           allmodconfig    gcc-14.2.0
sparc                randconfig-001-20250222    gcc-14.2.0
sparc                randconfig-002-20250222    gcc-14.2.0
sparc64              randconfig-001-20250222    gcc-14.2.0
sparc64              randconfig-002-20250222    gcc-14.2.0
um                              allmodconfig    clang-21
um                              allyesconfig    gcc-12
um                   randconfig-001-20250222    gcc-12
um                   randconfig-002-20250222    gcc-12
x86_64                           allnoconfig    clang-19
x86_64                          allyesconfig    clang-19
x86_64     buildonly-randconfig-001-20250222    clang-19
x86_64     buildonly-randconfig-002-20250222    gcc-12
x86_64     buildonly-randconfig-003-20250222    gcc-12
x86_64     buildonly-randconfig-004-20250222    clang-19
x86_64     buildonly-randconfig-005-20250222    clang-19
x86_64     buildonly-randconfig-006-20250222    gcc-12
x86_64                             defconfig    gcc-11
xtensa               randconfig-001-20250222    gcc-14.2.0
xtensa               randconfig-002-20250222    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
