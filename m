Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C25160B8A
	for <linux-bluetooth@vger.kernel.org>; Sat,  1 Nov 2025 15:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762011593; cv=none; b=TdJWX/N6Fgq5xw8QtKvUxqnffPCYX4uqH49gPMwoAsP9Vptn5qnNvjl2phwkAiKgZW/CFoG170Odnos9x2tw0QEu/vFxvrxwZ4jyjsVVzTwbA4AoiU7UaE/MkgmhHvFXt24mWSfX4myJaHjROeEKuIF39a6C2kiznms3ul5iejE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762011593; c=relaxed/simple;
	bh=++NL9vyWnlBMYhkkjD9TyMm7YuIqALjVyjQ1KZUXGkg=;
	h=Date:From:To:Cc:Subject:Message-ID; b=HdU0DV/nIwmSdl2xynwrxxrCd+Lc+jANGaUOddmYkwbf7uis3YozMkAMIVcTOnIWWwOfPuGgOJBytOKaaNnot6mE7IJT2MMEvexlF54oIH27kexjcRxxffOn2c4oIlrwuwqvAgpQwdT/6tI6Qpqs9GWZi2KbvJ5FdNDBi5wO0Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HoYKL+lJ; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HoYKL+lJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762011591; x=1793547591;
  h=date:from:to:cc:subject:message-id;
  bh=++NL9vyWnlBMYhkkjD9TyMm7YuIqALjVyjQ1KZUXGkg=;
  b=HoYKL+lJ4eIHAlKpadwRRBhL+orxXFMKY15oHlmq4+yiLOr/Xfz1ITIP
   9echfBHVpox768UH8h/7UDpPZ6UgxrqEIsj549LukrlNumrbPPhF+4Bfe
   F+RFJSRcDz0Hm27iANhRVe+sfx5tF/jKvPoT2EcX00jVI7HwjpHAwM23l
   cGAp2MRdp/ZFU+aVX+juQAHnK7KgDYvDqut6l3y1JlB3XYD43SZq8ma+o
   sUqj8DSW/uZucjhlmbM/4ozOjtJRKJ5NdIZ37ozb1MAzPnsEnRBeINm0G
   JmV/Iun3Gd6bMFwkDm9shRHurAc4XC48cUXesFdoUWO99/zR8B03evMSH
   w==;
X-CSE-ConnectionGUID: ZG2BvirUSKyPTM6MVTOgzQ==
X-CSE-MsgGUID: CwFYD4ToQlmRtAnP2ydibA==
X-IronPort-AV: E=McAfee;i="6800,10657,11600"; a="64251640"
X-IronPort-AV: E=Sophos;i="6.19,272,1754982000"; 
   d="scan'208";a="64251640"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2025 08:39:50 -0700
X-CSE-ConnectionGUID: kffasybxT3CbtZJgbvAHlA==
X-CSE-MsgGUID: 3Py2/7QeRomz4MHvdcJQ6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,272,1754982000"; 
   d="scan'208";a="186434750"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by orviesa007.jf.intel.com with ESMTP; 01 Nov 2025 08:39:49 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vFDhj-000OPM-0Z;
	Sat, 01 Nov 2025 15:39:47 +0000
Date: Sat, 01 Nov 2025 23:39:29 +0800
From: kernel test robot <lkp@intel.com>
To: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 e1e9d861e2f9a56d080e8375ab1d6d786e1aa1bc
Message-ID: <202511012323.uu3ns9dm-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: e1e9d861e2f9a56d080e8375ab1d6d786e1aa1bc  Bluetooth: MGMT: Fix OOB access in parse_adv_monitor_pattern()

elapsed time: 1436m

configs tested: 200
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    clang-19
alpha                               defconfig    gcc-15.1.0
arc                              allmodconfig    clang-19
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    clang-19
arc                                 defconfig    gcc-15.1.0
arc                   randconfig-001-20251101    gcc-8.5.0
arc                   randconfig-002-20251101    gcc-8.5.0
arm                              allmodconfig    clang-19
arm                               allnoconfig    clang-22
arm                              allyesconfig    clang-19
arm                                 defconfig    gcc-15.1.0
arm                        mvebu_v7_defconfig    clang-22
arm                   randconfig-001-20251101    gcc-13.4.0
arm                   randconfig-001-20251101    gcc-8.5.0
arm                   randconfig-002-20251101    clang-22
arm                   randconfig-002-20251101    gcc-8.5.0
arm                   randconfig-003-20251101    clang-18
arm                   randconfig-003-20251101    gcc-8.5.0
arm                   randconfig-004-20251101    clang-22
arm                   randconfig-004-20251101    gcc-8.5.0
arm                        spear3xx_defconfig    clang-22
arm                        spear6xx_defconfig    clang-22
arm                        vexpress_defconfig    clang-22
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                            allyesconfig    gcc-15.1.0
arm64                               defconfig    gcc-15.1.0
arm64                 randconfig-001-20251101    gcc-14.3.0
arm64                 randconfig-002-20251101    gcc-14.3.0
arm64                 randconfig-003-20251101    gcc-14.3.0
arm64                 randconfig-004-20251101    gcc-14.3.0
csky                             allmodconfig    gcc-15.1.0
csky                              allnoconfig    gcc-15.1.0
csky                             allyesconfig    gcc-15.1.0
csky                                defconfig    gcc-15.1.0
csky                  randconfig-001-20251101    gcc-14.3.0
csky                  randconfig-002-20251101    gcc-14.3.0
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-19
hexagon                             defconfig    gcc-15.1.0
hexagon               randconfig-001-20251101    clang-19
hexagon               randconfig-001-20251101    clang-22
hexagon               randconfig-002-20251101    clang-19
hexagon               randconfig-002-20251101    clang-22
i386                             allmodconfig    clang-20
i386                              allnoconfig    gcc-14
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20251101    clang-20
i386        buildonly-randconfig-002-20251101    clang-20
i386        buildonly-randconfig-003-20251101    clang-20
i386        buildonly-randconfig-004-20251101    clang-20
i386        buildonly-randconfig-005-20251101    clang-20
i386        buildonly-randconfig-006-20251101    clang-20
i386                                defconfig    gcc-15.1.0
i386                  randconfig-001-20251101    gcc-14
i386                  randconfig-002-20251101    gcc-14
i386                  randconfig-003-20251101    gcc-14
i386                  randconfig-004-20251101    gcc-14
i386                  randconfig-005-20251101    gcc-14
i386                  randconfig-006-20251101    gcc-14
i386                  randconfig-007-20251101    gcc-14
i386                  randconfig-011-20251101    clang-20
i386                  randconfig-012-20251101    clang-20
i386                  randconfig-013-20251101    clang-20
i386                  randconfig-014-20251101    clang-20
i386                  randconfig-015-20251101    clang-20
i386                  randconfig-016-20251101    clang-20
i386                  randconfig-017-20251101    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch                        allyesconfig    gcc-15.1.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20251101    clang-18
loongarch             randconfig-001-20251101    clang-19
loongarch             randconfig-002-20251101    clang-19
m68k                             allmodconfig    clang-19
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    clang-19
m68k                                defconfig    clang-19
microblaze                       allmodconfig    clang-19
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    clang-19
microblaze                          defconfig    clang-19
mips                             allmodconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                             allyesconfig    gcc-15.1.0
nios2                            allmodconfig    clang-22
nios2                             allnoconfig    gcc-11.5.0
nios2                            allyesconfig    clang-22
nios2                               defconfig    clang-19
nios2                 randconfig-001-20251101    clang-19
nios2                 randconfig-001-20251101    gcc-9.5.0
nios2                 randconfig-002-20251101    clang-19
nios2                 randconfig-002-20251101    gcc-8.5.0
openrisc                         allmodconfig    clang-22
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20251101    gcc-11.5.0
parisc                randconfig-002-20251101    gcc-8.5.0
parisc64                            defconfig    clang-19
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    gcc-15.1.0
powerpc               randconfig-001-20251101    gcc-11.5.0
powerpc               randconfig-002-20251101    clang-22
powerpc                     skiroot_defconfig    clang-22
powerpc64             randconfig-001-20251101    gcc-11.5.0
powerpc64             randconfig-002-20251101    clang-20
riscv                            allmodconfig    gcc-15.1.0
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    gcc-15.1.0
riscv                               defconfig    gcc-15.1.0
riscv                 randconfig-001-20251101    clang-17
riscv                 randconfig-001-20251101    gcc-8.5.0
riscv                 randconfig-002-20251101    clang-17
riscv                 randconfig-002-20251101    gcc-8.5.0
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    gcc-15.1.0
s390                  randconfig-001-20251101    clang-17
s390                  randconfig-002-20251101    clang-17
s390                  randconfig-002-20251101    clang-22
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-14
sh                    randconfig-001-20251101    clang-17
sh                    randconfig-001-20251101    gcc-15.1.0
sh                    randconfig-002-20251101    clang-17
sh                    randconfig-002-20251101    gcc-15.1.0
sh                           se7206_defconfig    clang-22
sh                   secureedge5410_defconfig    clang-22
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                            allyesconfig    clang-22
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20251101    clang-16
sparc                 randconfig-002-20251101    clang-16
sparc64                          allmodconfig    clang-22
sparc64                          allyesconfig    clang-22
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20251101    clang-16
sparc64               randconfig-002-20251101    clang-16
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    clang-19
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20251101    clang-16
um                    randconfig-002-20251101    clang-16
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20251101    gcc-14
x86_64      buildonly-randconfig-002-20251101    gcc-14
x86_64      buildonly-randconfig-003-20251101    gcc-14
x86_64      buildonly-randconfig-004-20251101    gcc-14
x86_64      buildonly-randconfig-005-20251101    gcc-14
x86_64      buildonly-randconfig-006-20251101    gcc-14
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20251101    clang-20
x86_64                randconfig-002-20251101    clang-20
x86_64                randconfig-003-20251101    clang-20
x86_64                randconfig-004-20251101    clang-20
x86_64                randconfig-005-20251101    clang-20
x86_64                randconfig-006-20251101    clang-20
x86_64                randconfig-011-20251101    gcc-14
x86_64                randconfig-012-20251101    gcc-14
x86_64                randconfig-013-20251101    gcc-14
x86_64                randconfig-014-20251101    gcc-14
x86_64                randconfig-015-20251101    gcc-14
x86_64                randconfig-016-20251101    gcc-14
x86_64                randconfig-071-20251101    clang-20
x86_64                randconfig-072-20251101    clang-20
x86_64                randconfig-073-20251101    clang-20
x86_64                randconfig-074-20251101    clang-20
x86_64                randconfig-075-20251101    clang-20
x86_64                randconfig-076-20251101    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                           allyesconfig    clang-22
xtensa                randconfig-001-20251101    clang-16
xtensa                randconfig-002-20251101    clang-16

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
