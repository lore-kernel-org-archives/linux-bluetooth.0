Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAC024C81
	for <linux-bluetooth@vger.kernel.org>; Wed, 13 Nov 2024 12:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731501194; cv=none; b=jQhX8/AzCtlw8bnm+Bw/z0vzZgUHuPb2IsI/WrUvb3UL/Nj5Pfei3llElMVtaVwbfDpX9eFkcaAJOqSuOl/f4cFjiISc9qEEGMEEAgypPA6YVvYxGUv4pcMSt7UXv4Cbup0KV4M3DL+zSFtAckj96VdFozKP82XflJ/FJF2K13w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731501194; c=relaxed/simple;
	bh=Fb+9SXa64puXms5Knp4q6636czmmMMz8dLx+2RcODUU=;
	h=Date:From:To:Cc:Subject:Message-ID; b=nMtnd3zjTf3Jh29x7VPuJDZqAx7QpA/r0pXJXarzNVkzrPzhcO88cC2/I26bwScIj50FpnoigRJTt0jyIUUb5FXdntxyXfHxB9GUgsUXuM8XNROF32NMRb0ZCGWrWIrqwBwb2moBoH2YW11pwPM3tyN6+sBBQBnK7cLL8s0IHZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CtsuYsbd; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CtsuYsbd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731501192; x=1763037192;
  h=date:from:to:cc:subject:message-id;
  bh=Fb+9SXa64puXms5Knp4q6636czmmMMz8dLx+2RcODUU=;
  b=CtsuYsbdj4CUN+U18cnfwEn/dhnnHH71VOgRQV5qKMaDhPNWZHwDnXVh
   NtnKV7fLziRifBOE3X0/LQSWc4EQk6X0zrCDmHV1FzhTXocOHX3GtADjk
   RVyQziOpfLPT3YSP9zehB7xwWusq90DEfeHN60mQr8nxJW8YVfupz2IMY
   z6VT6IgW8ehblQcHUtH7qPWixr2OPfMiGVP7aDLZmeo+Dumd9xV9M7cqG
   A80uN2KcjRN5c9MzKxC2Iq49KmP7sRZWPMDlxkrWFnDBFScdY7+ClT3sN
   ZOF8CIz32XgrWK85vJgDS6Mxzkqnc2W39YfTOs7HdT1goLhyHI+A+/aYM
   w==;
X-CSE-ConnectionGUID: mV8Qw/WyTOePr4dSVWr/7Q==
X-CSE-MsgGUID: vozuVV/MTM6PLNvFn0hhXw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="31356267"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="31356267"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2024 04:33:11 -0800
X-CSE-ConnectionGUID: 4Yq8CliQT7eSyzdk/0afGA==
X-CSE-MsgGUID: HooQPgFsROO8wnGSNHko2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,150,1728975600"; 
   d="scan'208";a="87851931"
Received: from lkp-server01.sh.intel.com (HELO 80bd855f15b3) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 13 Nov 2024 04:33:11 -0800
Received: from kbuild by 80bd855f15b3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tBCYW-0000NR-0a;
	Wed, 13 Nov 2024 12:33:08 +0000
Date: Wed, 13 Nov 2024 20:32:40 +0800
From: kernel test robot <lkp@intel.com>
To: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 e88b020190bf5bc3e7ce5bd8003fc39b23cc95fe
Message-ID: <202411132035.YpRHcNNF-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: e88b020190bf5bc3e7ce5bd8003fc39b23cc95fe  Bluetooth: btintel: Direct exception event to bluetooth stack

elapsed time: 1168m

configs tested: 136
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-13.2.0
arc                              allyesconfig    gcc-13.2.0
arc                         haps_hs_defconfig    gcc-13.2.0
arc                   randconfig-001-20241113    gcc-13.2.0
arc                   randconfig-002-20241113    gcc-13.2.0
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-20
arm                              allyesconfig    gcc-14.2.0
arm                          collie_defconfig    gcc-14.2.0
arm                        mvebu_v5_defconfig    gcc-14.2.0
arm                   randconfig-001-20241113    clang-20
arm                   randconfig-002-20241113    clang-20
arm                   randconfig-003-20241113    clang-20
arm                   randconfig-004-20241113    clang-20
arm                         s5pv210_defconfig    gcc-14.2.0
arm64                            allmodconfig    clang-20
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20241113    clang-20
arm64                 randconfig-002-20241113    gcc-14.2.0
arm64                 randconfig-003-20241113    gcc-14.2.0
arm64                 randconfig-004-20241113    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
csky                  randconfig-001-20241113    gcc-14.2.0
csky                  randconfig-002-20241113    gcc-14.2.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    clang-20
hexagon                          allyesconfig    clang-20
hexagon               randconfig-002-20241113    clang-20
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20241113    clang-19
i386        buildonly-randconfig-002-20241113    clang-19
i386        buildonly-randconfig-003-20241113    clang-19
i386        buildonly-randconfig-004-20241113    gcc-12
i386        buildonly-randconfig-005-20241113    gcc-12
i386        buildonly-randconfig-006-20241113    gcc-12
i386                                defconfig    clang-19
i386                  randconfig-001-20241113    gcc-12
i386                  randconfig-002-20241113    gcc-12
i386                  randconfig-003-20241113    clang-19
i386                  randconfig-004-20241113    clang-19
i386                  randconfig-005-20241113    gcc-12
i386                  randconfig-006-20241113    gcc-12
i386                  randconfig-011-20241113    clang-19
i386                  randconfig-012-20241113    gcc-12
i386                  randconfig-013-20241113    clang-19
i386                  randconfig-014-20241113    clang-19
i386                  randconfig-015-20241113    gcc-11
i386                  randconfig-016-20241113    gcc-12
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20241113    gcc-14.2.0
loongarch             randconfig-002-20241113    gcc-14.2.0
m68k                             alldefconfig    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                          ath79_defconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20241113    gcc-14.2.0
nios2                 randconfig-002-20241113    gcc-14.2.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-14.2.0
parisc                randconfig-001-20241113    gcc-14.2.0
parisc                randconfig-002-20241113    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-20
powerpc                  iss476-smp_defconfig    gcc-14.2.0
powerpc                       maple_defconfig    clang-20
powerpc                     ppa8548_defconfig    gcc-14.2.0
powerpc               randconfig-001-20241113    clang-20
powerpc               randconfig-002-20241113    clang-20
powerpc               randconfig-003-20241113    clang-15
powerpc                     tqm5200_defconfig    gcc-14.2.0
powerpc64             randconfig-001-20241113    gcc-14.2.0
powerpc64             randconfig-002-20241113    clang-20
powerpc64             randconfig-003-20241113    gcc-14.2.0
riscv                            allmodconfig    clang-20
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-20
riscv                               defconfig    clang-20
riscv                 randconfig-001-20241113    gcc-14.2.0
riscv                 randconfig-002-20241113    clang-20
s390                             allmodconfig    clang-20
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    clang-20
s390                  randconfig-001-20241113    gcc-14.2.0
s390                  randconfig-002-20241113    clang-20
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-14.2.0
sh                        edosk7760_defconfig    gcc-14.2.0
sh                    randconfig-001-20241113    gcc-14.2.0
sh                    randconfig-002-20241113    gcc-14.2.0
sh                      rts7751r2d1_defconfig    gcc-14.2.0
sh                           se7721_defconfig    gcc-14.2.0
sh                           se7750_defconfig    gcc-14.2.0
sh                        sh7757lcr_defconfig    gcc-14.2.0
sh                   sh7770_generic_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc64                             defconfig    gcc-14.2.0
sparc64               randconfig-001-20241113    gcc-14.2.0
sparc64               randconfig-002-20241113    gcc-14.2.0
um                               allmodconfig    clang-20
um                                allnoconfig    clang-17
um                               allyesconfig    gcc-12
um                                  defconfig    clang-20
um                             i386_defconfig    gcc-12
um                    randconfig-001-20241113    gcc-12
um                    randconfig-002-20241113    clang-20
um                           x86_64_defconfig    clang-15
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-19
x86_64                               rhel-8.3    gcc-12
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20241113    gcc-14.2.0
xtensa                randconfig-002-20241113    gcc-14.2.0
xtensa                         virt_defconfig    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
