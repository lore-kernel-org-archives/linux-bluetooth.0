Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 371BC3AEF49
	for <linux-bluetooth@vger.kernel.org>; Wed,  4 Feb 2026 15:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770220701; cv=none; b=BWu8+1tr4uvX75fihB8UPUo3CTtohz2ZD4OIwIglYvXrCTWa2wfuhz6VrePe7zSCSUDQGJegh7DD7n5DAXmFS6HssiMrThXSW3KDqUBZfj/ngPGyqzzWAFzDp8wSqezM6Dx+R4XBIXdWWYVoqJ25SCcZR776pXqE2ceWr1RNDd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770220701; c=relaxed/simple;
	bh=gBmM2MdGfWcKbiqdg9xe1EcxJgot5YZQdKwX7d6ZT1E=;
	h=Date:From:To:Cc:Subject:Message-ID; b=GbbJunYoq9+bc/EFFC05/gNo2evKJg+1znjszwQUtAd/AQU0FODFGBLWSnoBAL3sqRRKf6ueLc+6gAq1IycwWl7y6NzWU+swlSjFygKakmZ+k7M/xoxfwAz+JutDQmg+avRjKkSnj8AonZP1jKDCzjyybhVtkfwGLCxHXVAvOTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EZdGyT1X; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EZdGyT1X"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770220701; x=1801756701;
  h=date:from:to:cc:subject:message-id;
  bh=gBmM2MdGfWcKbiqdg9xe1EcxJgot5YZQdKwX7d6ZT1E=;
  b=EZdGyT1XydgljVY+hxNENWUnGwTF1yhr9e4g2KbJpykPcpU3qE6guwmr
   P6w3JnWuusU+p6InNXlb6CGVhWY+oPNzj9PcJfsQg3em6Xv3UNFHGtf5C
   zu5lVILvJF/p9yEakf1P/1xWhmxAfeDaK7r6+OBA4YxB11/zd5DV9lhF3
   /KyE9wpGdIccXB36bMu4t0BhH2Z8z0T0Fs0pIcm+sAcy+MuRBnfcpV7W8
   ZN3CoxNvSZh6hdv7i8maxIaeZ0sacJm42Jy9eN8cToDYFD/79iZSdn1rv
   RAwq9r7lMtHNjM8tePutw712+lxutelEhXF9CmXF01dN6cs9rH7cwiQIG
   g==;
X-CSE-ConnectionGUID: pJKPotU/RGeLSphxrVcL0g==
X-CSE-MsgGUID: KlNSxO7DSpC5noir6tTH8A==
X-IronPort-AV: E=McAfee;i="6800,10657,11691"; a="71313683"
X-IronPort-AV: E=Sophos;i="6.21,272,1763452800"; 
   d="scan'208";a="71313683"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2026 07:58:20 -0800
X-CSE-ConnectionGUID: 7GTOrDaYTJqhanfPXQrHmA==
X-CSE-MsgGUID: 3oTIJC9zTNGmp3xTMMsyLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,272,1763452800"; 
   d="scan'208";a="209991203"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 04 Feb 2026 07:58:18 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vnfGg-00000000iqi-3CAH;
	Wed, 04 Feb 2026 15:58:14 +0000
Date: Wed, 04 Feb 2026 23:57:29 +0800
From: kernel test robot <lkp@intel.com>
To: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 294cf04ca959817d017b4cf165a8038dd46368ee
Message-ID: <202602042321.mPcLQnHb-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: 294cf04ca959817d017b4cf165a8038dd46368ee  Bluetooth: hci_core: Rate limit the logging of invalid ISO handle

elapsed time: 1061m

configs tested: 262
configs skipped: 7

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
alpha                               defconfig    gcc-15.2.0
arc                              allmodconfig    clang-16
arc                              allmodconfig    gcc-15.2.0
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    clang-22
arc                              allyesconfig    gcc-15.2.0
arc                          axs101_defconfig    gcc-15.2.0
arc                          axs103_defconfig    clang-22
arc                                 defconfig    gcc-15.2.0
arc                   randconfig-001-20260204    gcc-8.5.0
arc                   randconfig-001-20260204    gcc-9.5.0
arc                   randconfig-002-20260204    gcc-8.5.0
arm                               allnoconfig    clang-22
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                              allyesconfig    gcc-15.2.0
arm                                 defconfig    gcc-15.2.0
arm                          moxart_defconfig    clang-22
arm                        mvebu_v7_defconfig    clang-22
arm                           omap1_defconfig    gcc-15.2.0
arm                            qcom_defconfig    gcc-15.2.0
arm                   randconfig-001-20260204    clang-22
arm                   randconfig-001-20260204    gcc-8.5.0
arm                   randconfig-002-20260204    gcc-11.5.0
arm                   randconfig-002-20260204    gcc-8.5.0
arm                   randconfig-003-20260204    clang-22
arm                   randconfig-003-20260204    gcc-8.5.0
arm                   randconfig-004-20260204    gcc-8.5.0
arm                         socfpga_defconfig    gcc-15.2.0
arm                        spear3xx_defconfig    gcc-15.2.0
arm64                            allmodconfig    clang-19
arm64                            allmodconfig    clang-22
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260204    gcc-11.5.0
arm64                 randconfig-001-20260204    gcc-8.5.0
arm64                 randconfig-002-20260204    clang-22
arm64                 randconfig-002-20260204    gcc-11.5.0
arm64                 randconfig-003-20260204    clang-22
arm64                 randconfig-003-20260204    gcc-11.5.0
arm64                 randconfig-004-20260204    gcc-11.5.0
arm64                 randconfig-004-20260204    gcc-14.3.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260204    gcc-11.5.0
csky                  randconfig-002-20260204    gcc-11.5.0
hexagon                          alldefconfig    gcc-15.2.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    clang-22
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    gcc-15.2.0
hexagon               randconfig-001-20260204    clang-19
hexagon               randconfig-001-20260204    gcc-15.2.0
hexagon               randconfig-002-20260204    clang-18
hexagon               randconfig-002-20260204    gcc-15.2.0
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260204    gcc-14
i386        buildonly-randconfig-002-20260204    gcc-14
i386        buildonly-randconfig-003-20260204    gcc-14
i386        buildonly-randconfig-004-20260204    gcc-14
i386        buildonly-randconfig-005-20260204    gcc-14
i386        buildonly-randconfig-006-20260204    gcc-14
i386                                defconfig    gcc-15.2.0
i386                  randconfig-001-20260204    gcc-14
i386                  randconfig-002-20260204    gcc-14
i386                  randconfig-003-20260204    clang-20
i386                  randconfig-003-20260204    gcc-14
i386                  randconfig-004-20260204    gcc-12
i386                  randconfig-004-20260204    gcc-14
i386                  randconfig-005-20260204    gcc-14
i386                  randconfig-006-20260204    gcc-14
i386                  randconfig-007-20260204    gcc-14
i386                  randconfig-011-20260204    clang-20
i386                  randconfig-012-20260204    clang-20
i386                  randconfig-012-20260204    gcc-14
i386                  randconfig-013-20260204    clang-20
i386                  randconfig-014-20260204    clang-20
i386                  randconfig-015-20260204    clang-20
i386                  randconfig-015-20260204    gcc-13
i386                  randconfig-016-20260204    clang-20
i386                  randconfig-017-20260204    clang-20
loongarch                        allmodconfig    clang-19
loongarch                        allmodconfig    clang-22
loongarch                         allnoconfig    clang-22
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260204    gcc-15.2.0
loongarch             randconfig-002-20260204    gcc-15.2.0
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    clang-16
m68k                             allyesconfig    gcc-15.2.0
m68k                                defconfig    clang-19
m68k                        m5272c3_defconfig    clang-22
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    clang-19
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
mips                            gpr_defconfig    clang-22
mips                      malta_kvm_defconfig    clang-22
mips                        vocore2_defconfig    clang-22
nios2                         10m50_defconfig    clang-22
nios2                            allmodconfig    clang-22
nios2                             allnoconfig    clang-22
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-19
nios2                 randconfig-001-20260204    gcc-11.5.0
nios2                 randconfig-001-20260204    gcc-15.2.0
nios2                 randconfig-002-20260204    gcc-11.5.0
nios2                 randconfig-002-20260204    gcc-15.2.0
openrisc                         allmodconfig    clang-22
openrisc                          allnoconfig    clang-22
openrisc                          allnoconfig    gcc-15.2.0
openrisc                            defconfig    gcc-15.2.0
openrisc                    or1ksim_defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    clang-22
parisc                            allnoconfig    gcc-15.2.0
parisc                           allyesconfig    clang-19
parisc                           allyesconfig    gcc-15.2.0
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260204    gcc-8.5.0
parisc                randconfig-002-20260204    gcc-10.5.0
parisc                randconfig-002-20260204    gcc-8.5.0
parisc64                            defconfig    clang-19
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-22
powerpc                           allnoconfig    gcc-15.2.0
powerpc                      cm5200_defconfig    clang-22
powerpc                        icon_defconfig    clang-22
powerpc                     kmeter1_defconfig    clang-22
powerpc               randconfig-001-20260204    clang-22
powerpc               randconfig-001-20260204    gcc-8.5.0
powerpc               randconfig-002-20260204    gcc-14.3.0
powerpc               randconfig-002-20260204    gcc-8.5.0
powerpc                     redwood_defconfig    clang-22
powerpc64                        alldefconfig    clang-22
powerpc64             randconfig-001-20260204    clang-19
powerpc64             randconfig-001-20260204    gcc-8.5.0
powerpc64             randconfig-002-20260204    gcc-11.5.0
powerpc64             randconfig-002-20260204    gcc-8.5.0
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    clang-22
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-15.2.0
riscv             nommu_k210_sdcard_defconfig    clang-22
riscv                 randconfig-001-20260204    gcc-8.5.0
riscv                 randconfig-002-20260204    clang-22
riscv                 randconfig-002-20260204    gcc-8.5.0
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    gcc-15.2.0
s390                  randconfig-001-20260204    clang-19
s390                  randconfig-001-20260204    gcc-8.5.0
s390                  randconfig-002-20260204    gcc-8.5.0
s390                  randconfig-002-20260204    gcc-9.5.0
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-22
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    clang-19
sh                               allyesconfig    gcc-15.2.0
sh                                  defconfig    gcc-14
sh                                  defconfig    gcc-15.2.0
sh                    randconfig-001-20260204    gcc-14.3.0
sh                    randconfig-001-20260204    gcc-8.5.0
sh                    randconfig-002-20260204    gcc-12.5.0
sh                    randconfig-002-20260204    gcc-8.5.0
sh                          rsk7201_defconfig    clang-22
sh                     sh7710voipgw_defconfig    gcc-15.2.0
sparc                             allnoconfig    clang-22
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260204    gcc-8.5.0
sparc                 randconfig-002-20260204    gcc-8.5.0
sparc64                          allmodconfig    clang-22
sparc64                             defconfig    clang-20
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260204    clang-22
sparc64               randconfig-001-20260204    gcc-8.5.0
sparc64               randconfig-002-20260204    gcc-8.5.0
sparc64               randconfig-002-20260204    gcc-9.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-14
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    clang-22
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260204    gcc-14
um                    randconfig-001-20260204    gcc-8.5.0
um                    randconfig-002-20260204    gcc-14
um                    randconfig-002-20260204    gcc-8.5.0
um                           x86_64_defconfig    clang-22
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                            allnoconfig    clang-22
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260204    clang-20
x86_64      buildonly-randconfig-001-20260204    gcc-12
x86_64      buildonly-randconfig-002-20260204    clang-20
x86_64      buildonly-randconfig-002-20260204    gcc-14
x86_64      buildonly-randconfig-003-20260204    clang-20
x86_64      buildonly-randconfig-004-20260204    clang-20
x86_64      buildonly-randconfig-004-20260204    gcc-14
x86_64      buildonly-randconfig-005-20260204    clang-20
x86_64      buildonly-randconfig-006-20260204    clang-20
x86_64      buildonly-randconfig-006-20260204    gcc-14
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260204    gcc-13
x86_64                randconfig-001-20260204    gcc-14
x86_64                randconfig-002-20260204    gcc-14
x86_64                randconfig-003-20260204    gcc-14
x86_64                randconfig-004-20260204    gcc-14
x86_64                randconfig-005-20260204    clang-20
x86_64                randconfig-005-20260204    gcc-14
x86_64                randconfig-006-20260204    clang-20
x86_64                randconfig-006-20260204    gcc-14
x86_64                randconfig-011-20260204    clang-20
x86_64                randconfig-012-20260204    clang-20
x86_64                randconfig-012-20260204    gcc-14
x86_64                randconfig-013-20260204    clang-20
x86_64                randconfig-014-20260204    clang-20
x86_64                randconfig-014-20260204    gcc-14
x86_64                randconfig-015-20260204    clang-20
x86_64                randconfig-015-20260204    gcc-14
x86_64                randconfig-016-20260204    clang-20
x86_64                randconfig-016-20260204    gcc-14
x86_64                randconfig-071-20260204    gcc-14
x86_64                randconfig-072-20260204    gcc-14
x86_64                randconfig-073-20260204    gcc-14
x86_64                randconfig-074-20260204    gcc-14
x86_64                randconfig-075-20260204    gcc-14
x86_64                randconfig-076-20260204    gcc-14
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    clang-22
xtensa                            allnoconfig    gcc-15.2.0
xtensa                           allyesconfig    clang-22
xtensa                randconfig-001-20260204    gcc-8.5.0
xtensa                randconfig-001-20260204    gcc-9.5.0
xtensa                randconfig-002-20260204    gcc-12.5.0
xtensa                randconfig-002-20260204    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
