Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABA482AE77
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Oct 2024 04:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728363038; cv=none; b=gdsRsf93iYRxfILZsXm4oAURUUFmpBZeT8ZcBv4zPClxIlvEt/O1B6Ik6PLISgXyw7xE3n/cgHJY6Kk2kyAwzPTPGludjyz8m+fenCDcePdPk3mAxU8U4k1Ls1ogS8zbIp+Rj/zZOBtjmn+WwAM/FLl8C4mDNGtA78hl1EGyau8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728363038; c=relaxed/simple;
	bh=JhX2Zenv/YmM5I5rOMzxJqio90LC+bnYwnzZYx4J1QY=;
	h=Date:From:To:Cc:Subject:Message-ID; b=OPKjHGsduboSkCrUuZ+CON3jS78MGP+zhrTAmbwk1eqfIi+2lk+i67fzAKk2ry8R0q/yABhyYLpojrWhIpC4GsrO9CwA5ga5D50Chau6EequxgzQ4CyZWnBt1Y6erxGBgrZegeoFWwasvQdyU236g/BgOKdxVXv8l3HREduiEyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nPCnBhcA; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nPCnBhcA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728363037; x=1759899037;
  h=date:from:to:cc:subject:message-id;
  bh=JhX2Zenv/YmM5I5rOMzxJqio90LC+bnYwnzZYx4J1QY=;
  b=nPCnBhcA9eqhayOt7acUxMkIabkKprtp4utmu5bkuAERS4Tw7cyOyxGw
   7BbnOR2mKzvQGFUeqFryfw6cabS/yK8D0UKL0gECj1jsrj1/GE6DOZVhu
   Amya3rqxkUwQ5nLi8ROQFuNGu0t9v8RmSwJETBkLbW4at2Q1Lqi+GqCAo
   JcczA1aoKVxdt8G9PVRO8NZuEhtF22XMFGtrcTX0jcdLwJRMMtaPTvHja
   iprIqT9clI6tNlzMdEUe8V70DtnDIAwTf9Mouy3t29ETL+y2TkO4IwUSQ
   LsGr63dQE0SILMDFBjhD0pZ5AFL5sY9CRTWPl/lnZ2rbd53qGzVzvA2cq
   g==;
X-CSE-ConnectionGUID: 0BbwHVUnTf+3j20fTblZrw==
X-CSE-MsgGUID: +vydVqgWSI2R9onzvbkUZQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11218"; a="52940673"
X-IronPort-AV: E=Sophos;i="6.11,185,1725346800"; 
   d="scan'208";a="52940673"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2024 21:50:35 -0700
X-CSE-ConnectionGUID: VGWDXWttTlyAzonAEUwaEg==
X-CSE-MsgGUID: aYeZZjuOQz+8hmRzHd1MLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,185,1725346800"; 
   d="scan'208";a="80676324"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 07 Oct 2024 21:50:34 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sy2B5-0005uO-1Q;
	Tue, 08 Oct 2024 04:50:31 +0000
Date: Tue, 08 Oct 2024 12:49:43 +0800
From: kernel test robot <lkp@intel.com>
To: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 f5a04a514aa2bdc3f642dd395593f5acce5dcfcb
Message-ID: <202410081228.LzyvORIx-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: f5a04a514aa2bdc3f642dd395593f5acce5dcfcb  Bluetooth: Remove debugfs directory on module init failure

elapsed time: 763m

configs tested: 178
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.1.0
alpha                            allyesconfig    clang-20
alpha                               defconfig    gcc-14.1.0
arc                              allmodconfig    clang-20
arc                               allnoconfig    gcc-14.1.0
arc                              allyesconfig    clang-20
arc                                 defconfig    gcc-14.1.0
arc                   randconfig-001-20241008    gcc-14.1.0
arc                   randconfig-002-20241008    gcc-14.1.0
arm                              allmodconfig    clang-20
arm                               allnoconfig    gcc-14.1.0
arm                              allyesconfig    clang-20
arm                                 defconfig    gcc-14.1.0
arm                          pxa3xx_defconfig    gcc-14.1.0
arm                   randconfig-001-20241008    gcc-14.1.0
arm                   randconfig-002-20241008    gcc-14.1.0
arm                   randconfig-003-20241008    gcc-14.1.0
arm                   randconfig-004-20241008    gcc-14.1.0
arm64                            allmodconfig    clang-20
arm64                             allnoconfig    gcc-14.1.0
arm64                               defconfig    gcc-14.1.0
arm64                 randconfig-001-20241008    gcc-14.1.0
arm64                 randconfig-002-20241008    gcc-14.1.0
arm64                 randconfig-003-20241008    gcc-14.1.0
arm64                 randconfig-004-20241008    gcc-14.1.0
csky                              allnoconfig    gcc-14.1.0
csky                                defconfig    gcc-14.1.0
csky                  randconfig-001-20241008    gcc-14.1.0
csky                  randconfig-002-20241008    gcc-14.1.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    gcc-14.1.0
hexagon                          allyesconfig    clang-20
hexagon                             defconfig    gcc-14.1.0
hexagon               randconfig-001-20241008    gcc-14.1.0
hexagon               randconfig-002-20241008    gcc-14.1.0
i386                             allmodconfig    clang-18
i386                              allnoconfig    clang-18
i386                             allyesconfig    clang-18
i386        buildonly-randconfig-001-20241008    clang-18
i386        buildonly-randconfig-002-20241008    clang-18
i386        buildonly-randconfig-003-20241008    clang-18
i386        buildonly-randconfig-004-20241008    clang-18
i386        buildonly-randconfig-005-20241008    clang-18
i386        buildonly-randconfig-006-20241008    clang-18
i386                                defconfig    clang-18
i386                  randconfig-001-20241008    clang-18
i386                  randconfig-002-20241008    clang-18
i386                  randconfig-003-20241008    clang-18
i386                  randconfig-004-20241008    clang-18
i386                  randconfig-005-20241008    clang-18
i386                  randconfig-006-20241008    clang-18
i386                  randconfig-011-20241008    clang-18
i386                  randconfig-012-20241008    clang-18
i386                  randconfig-013-20241008    clang-18
i386                  randconfig-014-20241008    clang-18
i386                  randconfig-015-20241008    clang-18
i386                  randconfig-016-20241008    clang-18
loongarch                        allmodconfig    gcc-14.1.0
loongarch                         allnoconfig    gcc-14.1.0
loongarch                           defconfig    gcc-14.1.0
loongarch             randconfig-001-20241008    gcc-14.1.0
loongarch             randconfig-002-20241008    gcc-14.1.0
m68k                             allmodconfig    gcc-14.1.0
m68k                              allnoconfig    gcc-14.1.0
m68k                             allyesconfig    gcc-14.1.0
m68k                                defconfig    gcc-14.1.0
m68k                          hp300_defconfig    gcc-14.1.0
m68k                            q40_defconfig    gcc-14.1.0
microblaze                       allmodconfig    gcc-14.1.0
microblaze                        allnoconfig    gcc-14.1.0
microblaze                       allyesconfig    gcc-14.1.0
microblaze                          defconfig    gcc-14.1.0
mips                              allnoconfig    gcc-14.1.0
mips                      loongson3_defconfig    gcc-14.1.0
mips                        maltaup_defconfig    gcc-14.1.0
nios2                             allnoconfig    gcc-14.1.0
nios2                               defconfig    gcc-14.1.0
nios2                 randconfig-001-20241008    gcc-14.1.0
nios2                 randconfig-002-20241008    gcc-14.1.0
openrisc                          allnoconfig    clang-20
openrisc                          allnoconfig    gcc-14.1.0
openrisc                         allyesconfig    gcc-14.1.0
openrisc                            defconfig    gcc-12
openrisc                    or1ksim_defconfig    gcc-14.1.0
openrisc                       virt_defconfig    gcc-14.1.0
parisc                           allmodconfig    gcc-14.1.0
parisc                            allnoconfig    clang-20
parisc                            allnoconfig    gcc-14.1.0
parisc                           allyesconfig    gcc-14.1.0
parisc                              defconfig    gcc-12
parisc                randconfig-001-20241008    gcc-14.1.0
parisc                randconfig-002-20241008    gcc-14.1.0
parisc64                            defconfig    gcc-14.1.0
powerpc                          allmodconfig    gcc-14.1.0
powerpc                           allnoconfig    clang-20
powerpc                           allnoconfig    gcc-14.1.0
powerpc                          allyesconfig    gcc-14.1.0
powerpc                       eiger_defconfig    gcc-14.1.0
powerpc                 mpc832x_rdb_defconfig    gcc-14.1.0
powerpc                     mpc83xx_defconfig    gcc-14.1.0
powerpc                     ppa8548_defconfig    gcc-14.1.0
powerpc               randconfig-001-20241008    gcc-14.1.0
powerpc               randconfig-002-20241008    gcc-14.1.0
powerpc               randconfig-003-20241008    gcc-14.1.0
powerpc                     tqm8540_defconfig    gcc-14.1.0
powerpc                     tqm8541_defconfig    gcc-14.1.0
powerpc64             randconfig-001-20241008    gcc-14.1.0
powerpc64             randconfig-002-20241008    gcc-14.1.0
powerpc64             randconfig-003-20241008    gcc-14.1.0
riscv                            allmodconfig    gcc-14.1.0
riscv                             allnoconfig    clang-20
riscv                             allnoconfig    gcc-14.1.0
riscv                            allyesconfig    gcc-14.1.0
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20241008    gcc-14.1.0
riscv                 randconfig-002-20241008    gcc-14.1.0
s390                             allmodconfig    gcc-14.1.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.1.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20241008    gcc-14.1.0
s390                  randconfig-002-20241008    gcc-14.1.0
sh                               allmodconfig    gcc-14.1.0
sh                                allnoconfig    gcc-14.1.0
sh                               allyesconfig    gcc-14.1.0
sh                                  defconfig    gcc-12
sh                        dreamcast_defconfig    gcc-14.1.0
sh                    randconfig-001-20241008    gcc-14.1.0
sh                    randconfig-002-20241008    gcc-14.1.0
sh                           se7712_defconfig    gcc-14.1.0
sh                           se7780_defconfig    gcc-14.1.0
sparc                            alldefconfig    gcc-14.1.0
sparc                            allmodconfig    gcc-14.1.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20241008    gcc-14.1.0
sparc64               randconfig-002-20241008    gcc-14.1.0
um                               allmodconfig    clang-20
um                                allnoconfig    clang-17
um                                allnoconfig    clang-20
um                               allyesconfig    clang-20
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20241008    gcc-14.1.0
um                    randconfig-002-20241008    gcc-14.1.0
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-18
x86_64                           allyesconfig    clang-18
x86_64      buildonly-randconfig-001-20241008    gcc-12
x86_64      buildonly-randconfig-002-20241008    gcc-12
x86_64      buildonly-randconfig-003-20241008    gcc-12
x86_64      buildonly-randconfig-004-20241008    gcc-12
x86_64      buildonly-randconfig-005-20241008    gcc-12
x86_64      buildonly-randconfig-006-20241008    gcc-12
x86_64                              defconfig    clang-18
x86_64                                  kexec    gcc-12
x86_64                randconfig-001-20241008    gcc-12
x86_64                randconfig-002-20241008    gcc-12
x86_64                randconfig-003-20241008    gcc-12
x86_64                randconfig-004-20241008    gcc-12
x86_64                randconfig-005-20241008    gcc-12
x86_64                randconfig-006-20241008    gcc-12
x86_64                randconfig-011-20241008    gcc-12
x86_64                randconfig-012-20241008    gcc-12
x86_64                randconfig-013-20241008    gcc-12
x86_64                randconfig-014-20241008    gcc-12
x86_64                randconfig-015-20241008    gcc-12
x86_64                randconfig-016-20241008    gcc-12
x86_64                randconfig-071-20241008    gcc-12
x86_64                randconfig-072-20241008    gcc-12
x86_64                randconfig-073-20241008    gcc-12
x86_64                randconfig-074-20241008    gcc-12
x86_64                randconfig-075-20241008    gcc-12
x86_64                randconfig-076-20241008    gcc-12
x86_64                               rhel-8.3    gcc-12
x86_64                          rhel-8.3-rust    clang-18
xtensa                            allnoconfig    gcc-14.1.0
xtensa                randconfig-001-20241008    gcc-14.1.0
xtensa                randconfig-002-20241008    gcc-14.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
