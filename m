Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 687DD1F95C
	for <linux-bluetooth@vger.kernel.org>; Fri,  9 Jan 2026 00:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767919296; cv=none; b=uxr+jClOiqmgkRwAbjDG8BMYurlf3GGoMGwvsdMHwCTC3Ifx4W5kw4SP9lSJscKe4NjySymgu+/F+I1It5u2gU8QhU7wwvpwtBzf7vWqUiF8NjEGi0eS3srRLk8wh11fY/Iwgu7iZn4Z6TOPckpM37Qf90M6cP8SdN7p3mb18jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767919296; c=relaxed/simple;
	bh=eO3t8+In3s4AEPkYI64tcJ583mrNDdZ/VTjof3VD7yU=;
	h=Date:From:To:Cc:Subject:Message-ID; b=qagfMRRe/DAdr20h51LQNVP7MCiC/NsPAN71EsdW+/x0uIBFLR9CMxsAlMGs++nin/HOLRt4V/r8DLVhhWjektx38b77qKnqSVgFfuRnKXxeZslnf9tnbsm32q20segW6lSjjbDCSDH3UBDzEHNBR5cWIwEcNuS18+nwDaRe5Zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=foYdXxjX; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="foYdXxjX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767919296; x=1799455296;
  h=date:from:to:cc:subject:message-id;
  bh=eO3t8+In3s4AEPkYI64tcJ583mrNDdZ/VTjof3VD7yU=;
  b=foYdXxjXZKxzNvE0GgKI/aAQhKwWQ2N+w2fXvvcK6PR8ORkIUXTg5AOY
   OSvNvYYkFDNyIlKGjz2LPdWJ3K7g+6LjaHB4t1fRRnK97dTO/U4J6Dxjz
   P20QUn24s2Ctk2fwDJ5QChcsZQV5ELwNvLkoLm2VUyRV7+TSaWkBnJL36
   +mvdsXlBCYwiSS9WY1e3G0/Lh+Wu3TBjk8cswKNoFY/aKSu4WB144CZtf
   mbKg+CTaqUhFk+xqHl71S2b/322S2vrKySZTsetzqhV2gp+LC9aD2e/lW
   to7QnnDBVyalQx4jSimEMOLENREaREro4JpemgnZmrCbjQ5YwPda0q/6k
   A==;
X-CSE-ConnectionGUID: K2N5+E/EQVKF2XV3Q9RnUA==
X-CSE-MsgGUID: lapony7sT6GV0wgjM8Btgw==
X-IronPort-AV: E=McAfee;i="6800,10657,11665"; a="80413733"
X-IronPort-AV: E=Sophos;i="6.21,211,1763452800"; 
   d="scan'208";a="80413733"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2026 16:41:35 -0800
X-CSE-ConnectionGUID: ejo0oA5+SYmRlDDQyjikoA==
X-CSE-MsgGUID: dc7rZYJCQ9iWa2iRaa6IKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,211,1763452800"; 
   d="scan'208";a="207480772"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 08 Jan 2026 16:41:33 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1ve0ZH-000000005HQ-17lv;
	Fri, 09 Jan 2026 00:41:31 +0000
Date: Fri, 09 Jan 2026 08:41:09 +0800
From: kernel test robot <lkp@intel.com>
To: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD REGRESSION
 bdb9aba465a85122bcba01a6154e237b9843e25b
Message-ID: <202601090859.LZ9NiqiM-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: bdb9aba465a85122bcba01a6154e237b9843e25b  Bluetooth: Fix using PHYs bitfields as PHY value

Error/Warning (recently discovered and may have been fixed):

    https://lore.kernel.org/oe-kbuild-all/202601080917.48r3wydk-lkp@intel.com

    drivers/i2c/busses/i2c-designware-platform.o: warning: objtool: dw_i2c_plat_remove+0xe1: no-cfi indirect call!

Error/Warning ids grouped by kconfigs:

recent_errors
`-- x86_64-randconfig-161-20260108
    `-- drivers-i2c-busses-i2c-designware-platform.o:warning:objtool:dw_i2c_plat_remove:no-cfi-indirect-call

elapsed time: 1654m

configs tested: 299
configs skipped: 5

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    gcc-15.1.0
arc                              allmodconfig    clang-16
arc                               allnoconfig    gcc-15.1.0
arc                                 defconfig    gcc-15.1.0
arc                     haps_hs_smp_defconfig    gcc-15.1.0
arc                   randconfig-001-20260108    gcc-9.5.0
arc                   randconfig-001-20260109    gcc-13.4.0
arc                   randconfig-002-20260108    gcc-8.5.0
arc                   randconfig-002-20260108    gcc-9.5.0
arc                   randconfig-002-20260109    gcc-13.4.0
arm                               allnoconfig    gcc-15.1.0
arm                              allyesconfig    clang-16
arm                                 defconfig    clang-22
arm                                 defconfig    gcc-15.1.0
arm                            hisi_defconfig    gcc-15.1.0
arm                         lpc32xx_defconfig    clang-17
arm                        mvebu_v5_defconfig    clang-22
arm                           omap1_defconfig    clang-22
arm                   randconfig-001-20260108    gcc-8.5.0
arm                   randconfig-001-20260108    gcc-9.5.0
arm                   randconfig-001-20260109    gcc-13.4.0
arm                   randconfig-002-20260108    gcc-13.4.0
arm                   randconfig-002-20260108    gcc-9.5.0
arm                   randconfig-002-20260109    gcc-13.4.0
arm                   randconfig-003-20260108    clang-17
arm                   randconfig-003-20260108    gcc-9.5.0
arm                   randconfig-003-20260109    gcc-13.4.0
arm                   randconfig-004-20260108    clang-22
arm                   randconfig-004-20260108    gcc-9.5.0
arm                   randconfig-004-20260109    gcc-13.4.0
arm                           sama7_defconfig    clang-22
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    gcc-15.1.0
arm64                 randconfig-001-20260108    gcc-10.5.0
arm64                 randconfig-001-20260109    gcc-8.5.0
arm64                 randconfig-002-20260108    gcc-10.5.0
arm64                 randconfig-002-20260109    gcc-8.5.0
arm64                 randconfig-003-20260108    gcc-10.5.0
arm64                 randconfig-003-20260109    gcc-8.5.0
arm64                 randconfig-004-20260108    gcc-10.5.0
arm64                 randconfig-004-20260109    gcc-8.5.0
csky                             allmodconfig    gcc-15.1.0
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    gcc-15.1.0
csky                  randconfig-001-20260108    gcc-10.5.0
csky                  randconfig-001-20260109    gcc-8.5.0
csky                  randconfig-002-20260108    gcc-10.5.0
csky                  randconfig-002-20260109    gcc-8.5.0
hexagon                          allmodconfig    gcc-15.1.0
hexagon                           allnoconfig    gcc-15.1.0
hexagon                             defconfig    clang-22
hexagon                             defconfig    gcc-15.1.0
hexagon               randconfig-001-20260108    clang-22
hexagon               randconfig-001-20260108    gcc-8.5.0
hexagon               randconfig-001-20260109    gcc-8.5.0
hexagon               randconfig-002-20260108    clang-22
hexagon               randconfig-002-20260108    gcc-8.5.0
hexagon               randconfig-002-20260109    gcc-8.5.0
i386                             allmodconfig    clang-20
i386                              allnoconfig    gcc-15.1.0
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20260108    clang-20
i386        buildonly-randconfig-001-20260109    clang-20
i386        buildonly-randconfig-002-20260108    clang-20
i386        buildonly-randconfig-002-20260109    clang-20
i386        buildonly-randconfig-003-20260108    clang-20
i386        buildonly-randconfig-003-20260108    gcc-13
i386        buildonly-randconfig-003-20260109    clang-20
i386        buildonly-randconfig-004-20260108    clang-20
i386        buildonly-randconfig-004-20260109    clang-20
i386        buildonly-randconfig-005-20260108    clang-20
i386        buildonly-randconfig-005-20260109    clang-20
i386        buildonly-randconfig-006-20260108    clang-20
i386        buildonly-randconfig-006-20260108    gcc-14
i386        buildonly-randconfig-006-20260109    clang-20
i386                                defconfig    clang-20
i386                                defconfig    gcc-15.1.0
i386                  randconfig-001-20260108    gcc-13
i386                  randconfig-001-20260108    gcc-14
i386                  randconfig-001-20260109    gcc-14
i386                  randconfig-002-20260108    gcc-13
i386                  randconfig-002-20260108    gcc-14
i386                  randconfig-002-20260109    gcc-14
i386                  randconfig-003-20260108    clang-20
i386                  randconfig-003-20260108    gcc-14
i386                  randconfig-003-20260109    gcc-14
i386                  randconfig-004-20260108    clang-20
i386                  randconfig-004-20260108    gcc-14
i386                  randconfig-004-20260109    gcc-14
i386                  randconfig-005-20260108    clang-20
i386                  randconfig-005-20260108    gcc-14
i386                  randconfig-005-20260109    gcc-14
i386                  randconfig-006-20260108    gcc-14
i386                  randconfig-006-20260109    gcc-14
i386                  randconfig-007-20260108    gcc-14
i386                  randconfig-007-20260109    gcc-14
i386                  randconfig-011-20260108    gcc-12
i386                  randconfig-011-20260108    gcc-14
i386                  randconfig-012-20260108    gcc-14
i386                  randconfig-013-20260108    gcc-14
i386                  randconfig-014-20260108    gcc-12
i386                  randconfig-014-20260108    gcc-14
i386                  randconfig-015-20260108    gcc-14
i386                  randconfig-016-20260108    gcc-14
i386                  randconfig-017-20260108    gcc-14
loongarch                         allnoconfig    gcc-15.1.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260108    clang-22
loongarch             randconfig-001-20260108    gcc-8.5.0
loongarch             randconfig-001-20260109    gcc-8.5.0
loongarch             randconfig-002-20260108    clang-22
loongarch             randconfig-002-20260108    gcc-8.5.0
loongarch             randconfig-002-20260109    gcc-8.5.0
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    clang-16
m68k                       bvme6000_defconfig    gcc-15.1.0
m68k                                defconfig    clang-19
m68k                                defconfig    gcc-15.1.0
m68k                        m5272c3_defconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    clang-19
microblaze                          defconfig    gcc-15.1.0
mips                             allmodconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                             allyesconfig    gcc-15.1.0
mips                  decstation_64_defconfig    gcc-15.1.0
mips                      loongson3_defconfig    gcc-15.1.0
mips                          malta_defconfig    clang-22
nios2                            allmodconfig    clang-22
nios2                             allnoconfig    clang-22
nios2                               defconfig    clang-19
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20260108    gcc-8.5.0
nios2                 randconfig-001-20260109    gcc-8.5.0
nios2                 randconfig-002-20260108    gcc-8.5.0
nios2                 randconfig-002-20260109    gcc-8.5.0
openrisc                         allmodconfig    clang-22
openrisc                          allnoconfig    clang-22
openrisc                            defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    clang-22
parisc                           allyesconfig    clang-19
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20260108    clang-22
parisc                randconfig-001-20260108    gcc-13.4.0
parisc                randconfig-001-20260109    gcc-8.5.0
parisc                randconfig-002-20260108    clang-22
parisc                randconfig-002-20260108    gcc-12.5.0
parisc                randconfig-002-20260109    gcc-8.5.0
parisc64                            defconfig    clang-19
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-22
powerpc                 canyonlands_defconfig    clang-22
powerpc                      chrp32_defconfig    clang-22
powerpc                     kmeter1_defconfig    gcc-15.1.0
powerpc                  mpc866_ads_defconfig    gcc-15.1.0
powerpc                      pmac32_defconfig    clang-22
powerpc                      ppc6xx_defconfig    clang-22
powerpc               randconfig-001-20260108    clang-22
powerpc               randconfig-001-20260108    gcc-13.4.0
powerpc               randconfig-001-20260109    gcc-8.5.0
powerpc               randconfig-002-20260108    clang-22
powerpc               randconfig-002-20260109    gcc-8.5.0
powerpc64             randconfig-001-20260108    clang-22
powerpc64             randconfig-001-20260109    gcc-8.5.0
powerpc64             randconfig-002-20260108    clang-22
powerpc64             randconfig-002-20260109    gcc-8.5.0
riscv                             allnoconfig    clang-22
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-22
riscv                               defconfig    gcc-15.1.0
riscv                 randconfig-001-20260108    gcc-13.4.0
riscv                 randconfig-001-20260108    gcc-15.1.0
riscv                 randconfig-001-20260109    clang-22
riscv                 randconfig-002-20260108    clang-22
riscv                 randconfig-002-20260108    gcc-13.4.0
riscv                 randconfig-002-20260109    clang-22
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                          debug_defconfig    gcc-15.1.0
s390                                defconfig    clang-22
s390                                defconfig    gcc-15.1.0
s390                  randconfig-001-20260108    gcc-13.4.0
s390                  randconfig-001-20260109    clang-22
s390                  randconfig-002-20260109    clang-22
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    clang-22
sh                               allyesconfig    clang-19
sh                                  defconfig    gcc-14
sh                    randconfig-001-20260108    gcc-13.4.0
sh                    randconfig-001-20260108    gcc-9.5.0
sh                    randconfig-001-20260109    clang-22
sh                    randconfig-002-20260108    gcc-13.4.0
sh                    randconfig-002-20260109    clang-22
sh                           se7712_defconfig    gcc-15.1.0
sh                           se7722_defconfig    clang-22
sh                          urquell_defconfig    gcc-15.1.0
sparc                             allnoconfig    clang-22
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20260108    gcc-8.5.0
sparc                 randconfig-001-20260109    gcc-14.3.0
sparc                 randconfig-002-20260108    gcc-15.1.0
sparc                 randconfig-002-20260108    gcc-8.5.0
sparc                 randconfig-002-20260109    gcc-14.3.0
sparc64                          allmodconfig    clang-22
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260108    gcc-8.5.0
sparc64               randconfig-001-20260109    gcc-14.3.0
sparc64               randconfig-002-20260108    clang-20
sparc64               randconfig-002-20260108    gcc-8.5.0
sparc64               randconfig-002-20260109    gcc-14.3.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-15.1.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260108    clang-18
um                    randconfig-001-20260108    gcc-8.5.0
um                    randconfig-001-20260109    gcc-14.3.0
um                    randconfig-002-20260108    clang-22
um                    randconfig-002-20260108    gcc-8.5.0
um                    randconfig-002-20260109    gcc-14.3.0
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-22
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260108    clang-20
x86_64      buildonly-randconfig-001-20260108    gcc-14
x86_64      buildonly-randconfig-001-20260109    gcc-14
x86_64      buildonly-randconfig-002-20260108    clang-20
x86_64      buildonly-randconfig-002-20260108    gcc-14
x86_64      buildonly-randconfig-002-20260109    gcc-14
x86_64      buildonly-randconfig-003-20260108    clang-20
x86_64      buildonly-randconfig-003-20260108    gcc-14
x86_64      buildonly-randconfig-003-20260109    gcc-14
x86_64      buildonly-randconfig-004-20260108    clang-20
x86_64      buildonly-randconfig-004-20260108    gcc-14
x86_64      buildonly-randconfig-004-20260109    gcc-14
x86_64      buildonly-randconfig-005-20260108    gcc-14
x86_64      buildonly-randconfig-005-20260109    gcc-14
x86_64      buildonly-randconfig-006-20260108    gcc-14
x86_64      buildonly-randconfig-006-20260109    gcc-14
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260108    clang-20
x86_64                randconfig-001-20260108    gcc-12
x86_64                randconfig-002-20260108    clang-20
x86_64                randconfig-002-20260108    gcc-12
x86_64                randconfig-003-20260108    gcc-12
x86_64                randconfig-004-20260108    gcc-12
x86_64                randconfig-004-20260108    gcc-14
x86_64                randconfig-005-20260108    gcc-12
x86_64                randconfig-005-20260108    gcc-14
x86_64                randconfig-006-20260108    gcc-12
x86_64                randconfig-006-20260108    gcc-14
x86_64                randconfig-011-20260108    clang-20
x86_64                randconfig-012-20260108    clang-20
x86_64                randconfig-013-20260108    clang-20
x86_64                randconfig-014-20260108    clang-20
x86_64                randconfig-014-20260108    gcc-14
x86_64                randconfig-015-20260108    clang-20
x86_64                randconfig-015-20260108    gcc-14
x86_64                randconfig-016-20260108    clang-20
x86_64                randconfig-016-20260108    gcc-14
x86_64                randconfig-071-20260108    gcc-14
x86_64                randconfig-071-20260109    clang-20
x86_64                randconfig-072-20260108    gcc-14
x86_64                randconfig-072-20260109    clang-20
x86_64                randconfig-073-20260108    gcc-14
x86_64                randconfig-073-20260109    clang-20
x86_64                randconfig-074-20260108    gcc-14
x86_64                randconfig-074-20260109    clang-20
x86_64                randconfig-075-20260108    clang-20
x86_64                randconfig-075-20260108    gcc-14
x86_64                randconfig-075-20260109    clang-20
x86_64                randconfig-076-20260108    clang-20
x86_64                randconfig-076-20260108    gcc-14
x86_64                randconfig-076-20260109    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    clang-22
xtensa                           allyesconfig    clang-22
xtensa                randconfig-001-20260108    gcc-11.5.0
xtensa                randconfig-001-20260108    gcc-8.5.0
xtensa                randconfig-001-20260109    gcc-14.3.0
xtensa                randconfig-002-20260108    gcc-8.5.0
xtensa                randconfig-002-20260109    gcc-14.3.0
xtensa                    smp_lx200_defconfig    gcc-15.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
