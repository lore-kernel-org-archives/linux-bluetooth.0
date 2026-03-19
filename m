Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B84DE1A0728
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Mar 2026 17:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773940935; cv=none; b=aJ7IUsEjl0JuHQ6xUviKFA9hHDHnqbGhVULGxdbgWB0bDJTBJjqzOxcenMShkIF8qd1jKuZqk7yIhEltdhAoAeRKZvQmaqPSoMvbvF4bw2ZnvZH4W41J+fC8/NMUzEBhDfslfR5tKZG/USG4bXLQTwGEDGEsskAgeIy9XCdicVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773940935; c=relaxed/simple;
	bh=1mh3m+Cf88XD9NPXAutaJ2DKTAHami2Al9s4yXdJ2i8=;
	h=Date:From:To:Cc:Subject:Message-ID; b=hAku0WZGmTD/xv1EDnBUMzmrqSO1P6zuKo5bjs+k+soHNq3Vxs64AQhMUreRq//71Q1/u+PGLxfso+oIW9iRN14+UvmeTRXHTTuoPCP7WU8ZVn54Ps9oZyH6xHZzyDifgI2bcJkYj/acv9zeEerUaps8D/U4NkatpIK9jlMWeoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Sf47QArI; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Sf47QArI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773940934; x=1805476934;
  h=date:from:to:cc:subject:message-id;
  bh=1mh3m+Cf88XD9NPXAutaJ2DKTAHami2Al9s4yXdJ2i8=;
  b=Sf47QArIX+SYHCMNpa4szxO21nKyDWItO0KqXFRK+MrDlKelyIRMoweR
   upCOzziB/unMvze+XAdVoKYyQYtdOeLNfkV3xtbEc0UCzTvMtF9T1u+K4
   gHgtnPdzEYyAm+3mgcYWe0XoU6JjFbTkkKLw1aj+6EBaJAXJV4iECGEoJ
   Gcg3IMuT9wKX93uMOYlk8KtGRnVwniE844LdIoUvxLny3H0Ieh6E1LaVj
   f5gQekIxs4DSY4r8qiL0v5CpynYToOdrnqFCjd46XxMYhHZtS1zxysbOe
   6+P0BBHo2K2QTLy2vZz4WbubtQ/NRIjzi9Hcrs8IArzn3ppXTIzNpWbZ1
   g==;
X-CSE-ConnectionGUID: 43ubc5rBSyacF/Cr8o8piQ==
X-CSE-MsgGUID: cuQRtS8zQC6Cvy/gi23ccQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11734"; a="74722977"
X-IronPort-AV: E=Sophos;i="6.23,129,1770624000"; 
   d="scan'208";a="74722977"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2026 10:22:13 -0700
X-CSE-ConnectionGUID: ZelQnOCLSee3wN4q8NMkzw==
X-CSE-MsgGUID: e2OVWT5ESPChSLMEI/NI7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,129,1770624000"; 
   d="scan'208";a="225010403"
Received: from lkp-server02.sh.intel.com (HELO a51c2a36b9df) ([10.239.97.151])
  by fmviesa004.fm.intel.com with ESMTP; 19 Mar 2026 10:22:11 -0700
Received: from kbuild by a51c2a36b9df with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w3H4S-000000001Q4-0KL8;
	Thu, 19 Mar 2026 17:22:08 +0000
Date: Fri, 20 Mar 2026 01:21:39 +0800
From: kernel test robot <lkp@intel.com>
To: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 0f1a322270bb6fc6b3d7abf4b2e08b9349e25b81
Message-ID: <202603200133.nDxpkJyh-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: 0f1a322270bb6fc6b3d7abf4b2e08b9349e25b81  Bluetooth: hci_ll: Fix firmware leak on error path

elapsed time: 1472m

configs tested: 147
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
arc                              allmodconfig    gcc-15.2.0
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    gcc-15.2.0
arc                   randconfig-001-20260319    gcc-8.5.0
arc                   randconfig-002-20260319    gcc-13.4.0
arm                               allnoconfig    clang-23
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    gcc-15.2.0
arm                         axm55xx_defconfig    clang-23
arm                   randconfig-001-20260319    clang-23
arm                   randconfig-002-20260319    gcc-8.5.0
arm                   randconfig-003-20260319    gcc-10.5.0
arm                   randconfig-004-20260319    gcc-11.5.0
arm                       spear13xx_defconfig    gcc-15.2.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.2.0
arm64                 randconfig-001-20260319    clang-23
arm64                 randconfig-002-20260319    gcc-12.5.0
arm64                 randconfig-003-20260319    gcc-15.2.0
arm64                 randconfig-004-20260319    clang-16
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                  randconfig-001-20260319    gcc-15.2.0
csky                  randconfig-002-20260319    gcc-15.2.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-23
hexagon                           allnoconfig    gcc-15.2.0
hexagon               randconfig-001-20260319    clang-23
hexagon               randconfig-002-20260319    clang-19
i386                             allmodconfig    clang-20
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260319    clang-20
i386        buildonly-randconfig-002-20260319    gcc-14
i386        buildonly-randconfig-003-20260319    gcc-14
i386        buildonly-randconfig-004-20260319    clang-20
i386        buildonly-randconfig-005-20260319    gcc-14
i386        buildonly-randconfig-006-20260319    clang-20
i386                  randconfig-001-20260319    clang-20
i386                  randconfig-002-20260319    clang-20
i386                  randconfig-003-20260319    gcc-14
i386                  randconfig-004-20260319    gcc-14
i386                  randconfig-005-20260319    clang-20
i386                  randconfig-006-20260319    clang-20
i386                  randconfig-007-20260319    gcc-13
i386                  randconfig-011-20260319    gcc-14
i386                  randconfig-012-20260319    gcc-14
i386                  randconfig-013-20260319    gcc-14
i386                  randconfig-014-20260319    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-23
loongarch                         allnoconfig    gcc-15.2.0
loongarch             randconfig-001-20260319    clang-18
loongarch             randconfig-002-20260319    clang-23
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    gcc-15.2.0
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    clang-23
nios2                             allnoconfig    gcc-11.5.0
nios2                 randconfig-001-20260319    gcc-11.5.0
nios2                 randconfig-002-20260319    gcc-8.5.0
openrisc                         allmodconfig    gcc-15.2.0
openrisc                          allnoconfig    clang-23
openrisc                          allnoconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    clang-23
parisc                            allnoconfig    gcc-15.2.0
parisc                           allyesconfig    gcc-15.2.0
parisc                randconfig-001-20260319    gcc-11.5.0
parisc                randconfig-002-20260319    gcc-8.5.0
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-23
powerpc                           allnoconfig    gcc-15.2.0
powerpc               randconfig-001-20260319    clang-23
powerpc               randconfig-002-20260319    clang-16
powerpc64             randconfig-001-20260319    clang-19
powerpc64             randconfig-002-20260319    clang-23
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                 randconfig-001-20260319    gcc-9.5.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                  randconfig-001-20260319    gcc-9.5.0
s390                  randconfig-001-20260320    gcc-13.4.0
s390                  randconfig-002-20260319    clang-23
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-23
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    gcc-15.2.0
sh                    randconfig-001-20260319    gcc-10.5.0
sh                    randconfig-002-20260319    gcc-10.5.0
sparc                             allnoconfig    clang-23
sparc                             allnoconfig    gcc-15.2.0
sparc                 randconfig-001-20260319    gcc-15.2.0
sparc                 randconfig-002-20260319    gcc-8.5.0
sparc64                          allmodconfig    clang-23
sparc64               randconfig-001-20260319    gcc-11.5.0
sparc64               randconfig-002-20260319    gcc-8.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-14
um                    randconfig-001-20260319    gcc-14
um                    randconfig-002-20260319    clang-23
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260319    clang-20
x86_64      buildonly-randconfig-002-20260319    clang-20
x86_64      buildonly-randconfig-003-20260319    gcc-14
x86_64      buildonly-randconfig-004-20260319    clang-20
x86_64      buildonly-randconfig-005-20260319    clang-20
x86_64      buildonly-randconfig-006-20260319    clang-20
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260319    gcc-14
x86_64                randconfig-002-20260319    gcc-12
x86_64                randconfig-003-20260319    gcc-14
x86_64                randconfig-004-20260319    gcc-14
x86_64                randconfig-005-20260319    clang-20
x86_64                randconfig-006-20260319    clang-20
x86_64                randconfig-011-20260319    clang-20
x86_64                randconfig-012-20260319    gcc-14
x86_64                randconfig-013-20260319    gcc-14
x86_64                randconfig-014-20260319    clang-20
x86_64                randconfig-015-20260319    clang-20
x86_64                randconfig-016-20260319    gcc-13
x86_64                               rhel-9.4    clang-20
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    clang-23
xtensa                            allnoconfig    gcc-15.2.0
xtensa                randconfig-001-20260319    gcc-8.5.0
xtensa                randconfig-002-20260319    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
