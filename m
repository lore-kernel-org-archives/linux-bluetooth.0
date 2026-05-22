Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A6A83E47B
	for <linux-bluetooth@vger.kernel.org>; Fri, 22 May 2026 06:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779430533; cv=none; b=PZx69O5x4gjide+TBAer+bBuMIfbevsMPemmA0sXuVDLiexwUk/hytXZbqDnfyiPSGVZreqAHlt7uVgfMwf2ihgg20J51G/1GQ4QkCIPpvFeIeRuqJ+9D9Gs04SxflyhGIbAg5fFRrCl4R6iru0Y6PePPoyWHZsD0rMbDjaKzOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779430533; c=relaxed/simple;
	bh=K3186LwQ2zWnf/L7cojrO1FITQ4DK1a8PQ9V4P06xdI=;
	h=Date:From:To:Cc:Subject:Message-ID; b=ew8ci1o7sWu16undZTXUPdmWpzkwalb2RCLhmA3NOfZGEGERf/WlgErGJMKbKLmL0ecYRHlaH3Ku0MZz/rVGGRaxpoi51V/0frsEWuuByQnDuWJ7GiFhSUGQPRuLeGBm/Vre68wUlAOs7F+WLgrEbvncd4d+n6QkVZhtm0AoQ+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q4x1B8Cy; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q4x1B8Cy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779430528; x=1810966528;
  h=date:from:to:cc:subject:message-id;
  bh=K3186LwQ2zWnf/L7cojrO1FITQ4DK1a8PQ9V4P06xdI=;
  b=Q4x1B8CyvPm4nzSC9452tfCg1PbHR7r1T2bpoBF3vpv602oh0Ncu7d/E
   QLPK0nP75hS1nLYfEGOblxiYGGK+Aqc4pzcy+EVPUKHflg8Ivfqrd4XF6
   1+bR3He+bjYekUjRd2eDbcQgKl4fevyH8fP+SAfVfOK1Rnwjm27XXuIxD
   +YbnzfSi+868c3K6cJ+n/UAapw9YWHtUta9GM+JwrAJ8BmplVQfsK6ISV
   ro7zV9hLUW+p5InF0QywRgLkpXiRrnPjcdxz15YW3hc5lSBxJz+4c7zOs
   j+UlfnXXZ1nvEXEzu7Qijjg3j+aC2oZJe7J1Jpq61R+7kmluMzS6L1VU1
   g==;
X-CSE-ConnectionGUID: pN27nNIsRmalI5ttgGg2yA==
X-CSE-MsgGUID: bZm8uHn1THq6PrA4kXBeWA==
X-IronPort-AV: E=McAfee;i="6800,10657,11793"; a="97778797"
X-IronPort-AV: E=Sophos;i="6.24,161,1774335600"; 
   d="scan'208";a="97778797"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2026 23:15:28 -0700
X-CSE-ConnectionGUID: zLV0NcjzTj2lZFSGnhwUQQ==
X-CSE-MsgGUID: nL6NmB/AS/uGM8Dp1cMcGg==
X-ExtLoop1: 1
Received: from lkp-server01.sh.intel.com (HELO fdb68b0ce653) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 21 May 2026 23:15:27 -0700
Received: from kbuild by fdb68b0ce653 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wQJAK-000000001rV-3VRH;
	Fri, 22 May 2026 06:15:24 +0000
Date: Fri, 22 May 2026 14:14:56 +0800
From: kernel test robot <lkp@intel.com>
To: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 3c2c428f25e25d18a496d7b04926451cb03652aa
Message-ID: <202605221448.Fl2aMv0X-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: 3c2c428f25e25d18a496d7b04926451cb03652aa  Bluetooth: btusb: Allow firmware re-download when version matches

elapsed time: 866m

configs tested: 161
configs skipped: 12

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
alpha                               defconfig    gcc-15.2.0
arc                              allmodconfig    gcc-15.2.0
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    gcc-15.2.0
arc                                 defconfig    gcc-15.2.0
arc                            randconfig-001    gcc-8.5.0
arc                   randconfig-001-20260522    gcc-9.5.0
arc                            randconfig-002    gcc-8.5.0
arc                   randconfig-002-20260522    gcc-8.5.0
arm                               allnoconfig    clang-23
arm                              allyesconfig    gcc-15.2.0
arm                                 defconfig    clang-23
arm                            randconfig-001    gcc-8.5.0
arm                   randconfig-001-20260522    gcc-8.5.0
arm                            randconfig-002    gcc-11.5.0
arm                   randconfig-002-20260522    gcc-10.5.0
arm                            randconfig-003    clang-20
arm                   randconfig-003-20260522    gcc-11.5.0
arm                            randconfig-004    gcc-14.3.0
arm                   randconfig-004-20260522    clang-23
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260522    clang-20
arm64                 randconfig-002-20260522    gcc-14.3.0
arm64                 randconfig-003-20260522    clang-23
arm64                 randconfig-004-20260522    gcc-10.5.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260522    gcc-15.2.0
csky                  randconfig-002-20260522    gcc-15.2.0
hexagon                           allnoconfig    clang-23
hexagon                             defconfig    clang-23
hexagon               randconfig-001-20260522    clang-23
hexagon               randconfig-002-20260522    clang-23
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260522    clang-20
i386        buildonly-randconfig-002-20260522    gcc-14
i386        buildonly-randconfig-003-20260522    clang-20
i386        buildonly-randconfig-004-20260522    gcc-14
i386        buildonly-randconfig-005-20260522    clang-20
i386        buildonly-randconfig-006-20260522    gcc-13
i386                                defconfig    clang-20
i386                  randconfig-001-20260522    gcc-14
i386                  randconfig-002-20260522    clang-20
i386                  randconfig-003-20260522    gcc-13
i386                  randconfig-004-20260522    gcc-14
i386                  randconfig-005-20260522    gcc-14
i386                  randconfig-006-20260522    clang-20
i386                  randconfig-007-20260522    gcc-13
i386                  randconfig-011-20260522    gcc-14
i386                  randconfig-012-20260522    clang-20
i386                  randconfig-013-20260522    clang-20
i386                  randconfig-014-20260522    gcc-14
i386                  randconfig-015-20260522    clang-20
i386                  randconfig-016-20260522    clang-20
i386                  randconfig-017-20260522    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-23
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260522    clang-23
loongarch             randconfig-002-20260522    gcc-15.2.0
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    gcc-15.2.0
m68k                                defconfig    gcc-15.2.0
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    gcc-15.2.0
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20260522    gcc-8.5.0
nios2                 randconfig-002-20260522    gcc-8.5.0
openrisc                         allmodconfig    gcc-15.2.0
openrisc                          allnoconfig    gcc-15.2.0
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    gcc-15.2.0
parisc                           allyesconfig    gcc-15.2.0
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260522    gcc-14.3.0
parisc                randconfig-002-20260522    gcc-8.5.0
parisc64                            defconfig    gcc-15.2.0
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    gcc-15.2.0
powerpc               randconfig-001-20260522    clang-20
powerpc               randconfig-002-20260522    clang-18
powerpc                        warp_defconfig    gcc-15.2.0
powerpc64             randconfig-001-20260522    gcc-10.5.0
powerpc64             randconfig-002-20260522    gcc-12.5.0
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-23
riscv                 randconfig-001-20260522    clang-17
riscv                 randconfig-002-20260522    clang-23
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    clang-23
s390                  randconfig-001-20260522    clang-23
s390                  randconfig-002-20260522    clang-23
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    gcc-15.2.0
sh                                  defconfig    gcc-15.2.0
sh                    randconfig-001-20260522    gcc-10.5.0
sh                    randconfig-002-20260522    gcc-14.3.0
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260522    gcc-15.2.0
sparc                 randconfig-002-20260522    gcc-15.2.0
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20260522    gcc-14.3.0
sparc64               randconfig-002-20260522    gcc-12.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-14
um                                  defconfig    clang-23
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260522    clang-23
um                    randconfig-002-20260522    gcc-14
um                           x86_64_defconfig    clang-23
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260522    clang-20
x86_64      buildonly-randconfig-002-20260522    gcc-13
x86_64      buildonly-randconfig-003-20260522    gcc-14
x86_64      buildonly-randconfig-004-20260522    clang-20
x86_64      buildonly-randconfig-005-20260522    clang-20
x86_64      buildonly-randconfig-006-20260522    gcc-14
x86_64                              defconfig    gcc-14
x86_64                randconfig-001-20260522    clang-20
x86_64                randconfig-002-20260522    clang-20
x86_64                randconfig-003-20260522    gcc-14
x86_64                randconfig-004-20260522    gcc-14
x86_64                randconfig-005-20260522    gcc-14
x86_64                randconfig-006-20260522    gcc-14
x86_64                randconfig-011-20260522    gcc-14
x86_64                randconfig-013-20260522    gcc-13
x86_64                randconfig-071-20260522    gcc-14
x86_64                randconfig-072-20260522    gcc-14
x86_64                randconfig-073-20260522    clang-20
x86_64                randconfig-074-20260522    gcc-14
x86_64                randconfig-075-20260522    clang-20
x86_64                randconfig-076-20260522    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.2.0
xtensa                           allyesconfig    gcc-15.2.0
xtensa                randconfig-001-20260522    gcc-9.5.0
xtensa                randconfig-002-20260522    gcc-11.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
