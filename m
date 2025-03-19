Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C8361CAA81
	for <linux-bluetooth@vger.kernel.org>; Wed, 19 Mar 2025 21:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742421245; cv=none; b=cj26nTQoJZ8nPU1ULyrdPzy60Qa+XS4n7xtdGl74mweoxeF4vd/SclfC/YsB/8/XZ29c43qOIgbkbgfRT2tsxQBu1cf4slV04iMYDyL2dPWeYYYoe55xvjOywb3+C56XImUf1X5xsKdn+sYuAzGeh/fhNC+RsHtQ5dGTqqLOjrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742421245; c=relaxed/simple;
	bh=pAVUHyCiEn9dytEdkpL0vcgg/24IPhID1Rcf4X7Cv4M=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Be3S0L4KRKw8rW4XjDrGXpKqdZzWMD49mLHE3QUN6uVnjY4O0e1r//ptBPlx7ZhGg9rNMj0Su701DNCo2u+PSvmKv3iBMTkc9QQWFmm/TawUc2cv1c+FUFzoWk7GNNSVbzAExAGqAkTGZgmD49AgcXCmVHJz504ZD4CGQ+hOd6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FwAMq+8+; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FwAMq+8+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742421243; x=1773957243;
  h=date:from:to:cc:subject:message-id;
  bh=pAVUHyCiEn9dytEdkpL0vcgg/24IPhID1Rcf4X7Cv4M=;
  b=FwAMq+8+m8JAmFkrRrHCxjO/45MHwCEfcyX27gUP8QBv8QykmaW4Z0xR
   nkwT6tYkD2dptu1j0htJpR2JYuxOTDLttfiQjIcOLX9/bahwPFEfs2+Em
   pSDevjkK0MUJevo+k/ceXYZ2Y74cX7lt28YKyPkshEHKhXGw+1cU7quQ7
   YatTY5IZbYdb2a+7D6LEBENRnTuLqFXoHwYLQubb9JeX4U6JMU36SpNFO
   5LIsEqj96dwbQVdw4DOUSsCu+ZN7I3dRPdClCBhHoCpbFPmDTTAdQx1o8
   6iXSFMY7FvNmJuFQlX6jbLZ0+hyJRyV+mmHmxrFDkPKxPRePcXpC+NfgG
   g==;
X-CSE-ConnectionGUID: lpk68mePS92xmcZhMkBtSg==
X-CSE-MsgGUID: 4UwfnhNWSN+XjzpZOTAsLQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11378"; a="53849262"
X-IronPort-AV: E=Sophos;i="6.14,259,1736841600"; 
   d="scan'208";a="53849262"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2025 14:54:02 -0700
X-CSE-ConnectionGUID: 3VjEgY/KT8ulMBPulxL66A==
X-CSE-MsgGUID: +RK/jKJFSTyIxaBhAfOupA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,259,1736841600"; 
   d="scan'208";a="127013895"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by fmviesa003.fm.intel.com with ESMTP; 19 Mar 2025 14:53:54 -0700
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tv1MG-000Fh6-1X;
	Wed, 19 Mar 2025 21:53:52 +0000
Date: Thu, 20 Mar 2025 05:53:19 +0800
From: kernel test robot <lkp@intel.com>
To: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 5fa10370a7c1f07a6e2ac71cd9e5dfd670b81d6f
Message-ID: <202503200513.WVcmuIXs-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: 5fa10370a7c1f07a6e2ac71cd9e5dfd670b81d6f  HCI: coredump: Log devcd dumps into the monitor

elapsed time: 1449m

configs tested: 134
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-6.5.0
alpha                            allyesconfig    gcc-9.3.0
alpha                               defconfig    gcc-7.5.0
arc                              allmodconfig    gcc-14.2.0
arc                               allnoconfig    gcc-8.5.0
arc                              allyesconfig    gcc-14.2.0
arc                                 defconfig    gcc-14.2.0
arc                   randconfig-001-20250319    gcc-14.2.0
arc                   randconfig-002-20250319    gcc-14.2.0
arm                              allmodconfig    gcc-8.5.0
arm                               allnoconfig    clang-21
arm                              allyesconfig    gcc-6.5.0
arm                   randconfig-001-20250319    clang-18
arm                   randconfig-002-20250319    clang-21
arm                   randconfig-003-20250319    clang-20
arm                   randconfig-004-20250319    clang-16
arm64                            alldefconfig    gcc-8.5.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-8.5.0
arm64                               defconfig    gcc-6.5.0
arm64                 randconfig-001-20250319    gcc-14.2.0
arm64                 randconfig-002-20250319    gcc-7.5.0
arm64                 randconfig-003-20250319    gcc-12.3.0
arm64                 randconfig-004-20250319    gcc-7.5.0
csky                              allnoconfig    gcc-9.3.0
csky                                defconfig    gcc-12.4.0
csky                  randconfig-001-20250319    gcc-14.2.0
csky                  randconfig-002-20250319    gcc-10.5.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-21
hexagon                             defconfig    clang-21
hexagon               randconfig-001-20250319    clang-21
hexagon               randconfig-002-20250319    clang-16
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250319    gcc-12
i386        buildonly-randconfig-002-20250319    gcc-12
i386        buildonly-randconfig-003-20250319    gcc-12
i386        buildonly-randconfig-004-20250319    clang-20
i386        buildonly-randconfig-005-20250319    gcc-12
i386        buildonly-randconfig-006-20250319    clang-20
i386                                defconfig    clang-20
loongarch                        allmodconfig    gcc-12.4.0
loongarch                         allnoconfig    gcc-13.3.0
loongarch             randconfig-001-20250319    gcc-14.2.0
loongarch             randconfig-002-20250319    gcc-14.2.0
m68k                             allmodconfig    gcc-8.5.0
m68k                              allnoconfig    gcc-5.5.0
m68k                             allyesconfig    gcc-6.5.0
m68k                                defconfig    gcc-8.5.0
microblaze                       allmodconfig    gcc-9.3.0
microblaze                        allnoconfig    gcc-11.5.0
microblaze                       allyesconfig    gcc-9.3.0
mips                              allnoconfig    gcc-10.5.0
mips                          ath25_defconfig    clang-21
mips                           gcw0_defconfig    clang-14
mips                     loongson1b_defconfig    clang-21
mips                        qi_lb60_defconfig    clang-21
nios2                         3c120_defconfig    gcc-7.5.0
nios2                             allnoconfig    gcc-8.5.0
nios2                 randconfig-001-20250319    gcc-14.2.0
nios2                 randconfig-002-20250319    gcc-10.5.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-5.5.0
parisc                            allnoconfig    gcc-10.5.0
parisc                           allyesconfig    gcc-9.3.0
parisc                              defconfig    gcc-14.2.0
parisc                randconfig-001-20250319    gcc-10.5.0
parisc                randconfig-002-20250319    gcc-5.5.0
powerpc                          allmodconfig    gcc-10.5.0
powerpc                           allnoconfig    gcc-8.5.0
powerpc                          allyesconfig    clang-21
powerpc                      mgcoge_defconfig    clang-21
powerpc                     ppa8548_defconfig    gcc-13.3.0
powerpc               randconfig-001-20250319    gcc-9.3.0
powerpc               randconfig-002-20250319    clang-21
powerpc               randconfig-003-20250319    clang-21
powerpc64                        alldefconfig    clang-21
powerpc64             randconfig-001-20250319    clang-20
powerpc64             randconfig-002-20250319    gcc-5.5.0
powerpc64             randconfig-003-20250319    clang-21
riscv                            allmodconfig    clang-21
riscv                             allnoconfig    gcc-7.5.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-21
riscv                 randconfig-001-20250319    clang-20
riscv                 randconfig-002-20250319    clang-17
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-15
s390                             allyesconfig    gcc-13.2.0
s390                                defconfig    clang-15
s390                  randconfig-001-20250319    gcc-11.5.0
s390                  randconfig-002-20250319    gcc-8.5.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-10.5.0
sh                               allyesconfig    gcc-7.5.0
sh                                  defconfig    gcc-11.5.0
sh                    randconfig-001-20250319    gcc-11.5.0
sh                    randconfig-002-20250319    gcc-14.2.0
sh                             sh03_defconfig    gcc-5.5.0
sh                        sh7763rdp_defconfig    gcc-10.5.0
sh                  sh7785lcr_32bit_defconfig    gcc-7.5.0
sparc                            allmodconfig    gcc-6.5.0
sparc                             allnoconfig    gcc-6.5.0
sparc                 randconfig-001-20250319    gcc-6.5.0
sparc                 randconfig-002-20250319    gcc-13.3.0
sparc64                             defconfig    gcc-10.5.0
sparc64               randconfig-001-20250319    gcc-14.2.0
sparc64               randconfig-002-20250319    gcc-14.2.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    gcc-12
um                                  defconfig    clang-21
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250319    gcc-12
um                    randconfig-002-20250319    gcc-11
um                           x86_64_defconfig    clang-15
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250319    clang-20
x86_64      buildonly-randconfig-002-20250319    clang-20
x86_64      buildonly-randconfig-003-20250319    gcc-12
x86_64      buildonly-randconfig-004-20250319    gcc-11
x86_64      buildonly-randconfig-005-20250319    clang-20
x86_64      buildonly-randconfig-006-20250319    clang-20
x86_64                              defconfig    gcc-11
xtensa                            allnoconfig    gcc-14.2.0
xtensa                generic_kc705_defconfig    gcc-7.5.0
xtensa                randconfig-001-20250319    gcc-10.5.0
xtensa                randconfig-002-20250319    gcc-14.2.0
xtensa                    smp_lx200_defconfig    gcc-10.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
