Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2191288C8C
	for <linux-bluetooth@vger.kernel.org>; Fri,  6 Jun 2025 13:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749215631; cv=none; b=TNzMvQHCAuJewYQ2cbIIcU2JgsXoyAYuhAZoWpXXstZAv8v/tNeleoBnk8lMXb6rj5VyWWiFCash5wowHebd6+8+7/3pNgKtefPd3fi4WZDoUK47AFLJE8nOQXqcIT1L9iIZonM2npMCmAUyY/2ya9zdaOj0jDxVTHQwZA8/aBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749215631; c=relaxed/simple;
	bh=40ixqwDGP/AJMpIMxfLJDOYMx/uXbCUL/bDICRxcuzQ=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Y8I2lrt73XAtaAvOrLJrrO0wmBqtbKaFwx59rnS4Dy0/WwyvCFE9aj1vuzfUpiZKdxMvHprsfj0XuvQM75u74nHQOyxehOZX82kjRjGCIEKi6tOPMgRwGhzPsk2lgLqW+TOqfJSkkLN5wXZIijELMQwcwn37Xsw21zp/UzHXw9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R4g2Lg+Z; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R4g2Lg+Z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749215629; x=1780751629;
  h=date:from:to:cc:subject:message-id;
  bh=40ixqwDGP/AJMpIMxfLJDOYMx/uXbCUL/bDICRxcuzQ=;
  b=R4g2Lg+ZeFDVi0N8MdjSgoHTi7q18q9mUNU91djH7leCOnSyqwL3iAne
   ixp0RaxxkfSkdC4SayESg+xMKSX9TymiGUpWdDHX0bo1Ny6o3emU3i+Hw
   UwQ6/59+SCtJn5Z6J8j4bbNRGKn0U7LmbJj2PTji/JnGuguQrq0sywizL
   Ar7lfkc8tSGNwQNUbvkxlC2Nt7+S4hWCdVuBJGb/bOEgY+ZdKvR4q2wG2
   BDVs16Es4N/xNFxQCCGUq5zP8iuWl/BO2bMPJuTnfhOg936qwl/kyLgBg
   lsMomGn3tWfGar2vTu2pwQx3Cf/wtpWrPE1DgvShUKZJUekzlTknY6xou
   w==;
X-CSE-ConnectionGUID: RCx0yS8jTVqzKirE+LPNGw==
X-CSE-MsgGUID: Lph3OGXLRTe6tdJmyNAX8g==
X-IronPort-AV: E=McAfee;i="6800,10657,11456"; a="68804157"
X-IronPort-AV: E=Sophos;i="6.16,215,1744095600"; 
   d="scan'208";a="68804157"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2025 06:13:49 -0700
X-CSE-ConnectionGUID: XcnjauDXQBKkMErdnLjm5A==
X-CSE-MsgGUID: WwR5snsVQPKQsf2aYJMVDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,215,1744095600"; 
   d="scan'208";a="145833578"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 06 Jun 2025 06:13:48 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uNWtF-00050D-2P;
	Fri, 06 Jun 2025 13:13:45 +0000
Date: Fri, 06 Jun 2025 21:13:39 +0800
From: kernel test robot <lkp@intel.com>
To: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 7615e0c7b24ad0a789a7722aaaa4656a00ec1ded
Message-ID: <202506062129.EGo86wPB-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: 7615e0c7b24ad0a789a7722aaaa4656a00ec1ded  Bluetooth: hci_sync: Fix broadcast/PA when using an existing instance

elapsed time: 1047m

configs tested: 242
configs skipped: 7

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    clang-19
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    gcc-15.1.0
arc                              alldefconfig    gcc-15.1.0
arc                              allmodconfig    clang-19
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    clang-19
arc                              allyesconfig    gcc-15.1.0
arc                                 defconfig    gcc-15.1.0
arc                   randconfig-001-20250606    gcc-15.1.0
arc                   randconfig-001-20250606    gcc-8.5.0
arc                   randconfig-002-20250606    gcc-10.5.0
arc                   randconfig-002-20250606    gcc-15.1.0
arc                           tb10x_defconfig    gcc-15.1.0
arc                        vdk_hs38_defconfig    gcc-15.1.0
arm                              allmodconfig    clang-19
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-21
arm                              allyesconfig    clang-19
arm                              allyesconfig    gcc-15.1.0
arm                                 defconfig    gcc-15.1.0
arm                       imx_v6_v7_defconfig    gcc-12
arm                        keystone_defconfig    gcc-15.1.0
arm                   randconfig-001-20250606    clang-21
arm                   randconfig-001-20250606    gcc-15.1.0
arm                   randconfig-002-20250606    gcc-11.5.0
arm                   randconfig-002-20250606    gcc-15.1.0
arm                   randconfig-003-20250606    clang-21
arm                   randconfig-003-20250606    gcc-15.1.0
arm                   randconfig-004-20250606    gcc-11.5.0
arm                   randconfig-004-20250606    gcc-15.1.0
arm                         s5pv210_defconfig    gcc-15.1.0
arm                        spear6xx_defconfig    clang-21
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                            allyesconfig    gcc-15.1.0
arm64                               defconfig    gcc-15.1.0
arm64                 randconfig-001-20250606    clang-21
arm64                 randconfig-001-20250606    gcc-15.1.0
arm64                 randconfig-002-20250606    gcc-15.1.0
arm64                 randconfig-003-20250606    clang-21
arm64                 randconfig-003-20250606    gcc-15.1.0
arm64                 randconfig-004-20250606    clang-21
arm64                 randconfig-004-20250606    gcc-15.1.0
csky                             allmodconfig    gcc-15.1.0
csky                              allnoconfig    gcc-15.1.0
csky                             allyesconfig    gcc-15.1.0
csky                                defconfig    gcc-15.1.0
csky                  randconfig-001-20250606    gcc-13.3.0
csky                  randconfig-001-20250606    gcc-14.3.0
csky                  randconfig-002-20250606    gcc-13.3.0
csky                  randconfig-002-20250606    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-19
hexagon                          allyesconfig    clang-21
hexagon                             defconfig    gcc-15.1.0
hexagon               randconfig-001-20250606    clang-21
hexagon               randconfig-001-20250606    gcc-13.3.0
hexagon               randconfig-002-20250606    clang-18
hexagon               randconfig-002-20250606    gcc-13.3.0
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-20
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250606    clang-20
i386        buildonly-randconfig-001-20250606    gcc-12
i386        buildonly-randconfig-002-20250606    gcc-12
i386        buildonly-randconfig-003-20250606    gcc-12
i386        buildonly-randconfig-004-20250606    gcc-12
i386        buildonly-randconfig-005-20250606    gcc-12
i386        buildonly-randconfig-006-20250606    gcc-11
i386        buildonly-randconfig-006-20250606    gcc-12
i386                                defconfig    clang-20
i386                  randconfig-001-20250606    clang-20
i386                  randconfig-002-20250606    clang-20
i386                  randconfig-003-20250606    clang-20
i386                  randconfig-004-20250606    clang-20
i386                  randconfig-005-20250606    clang-20
i386                  randconfig-006-20250606    clang-20
i386                  randconfig-007-20250606    clang-20
i386                  randconfig-011-20250606    clang-20
i386                  randconfig-012-20250606    clang-20
i386                  randconfig-013-20250606    clang-20
i386                  randconfig-014-20250606    clang-20
i386                  randconfig-015-20250606    clang-20
i386                  randconfig-016-20250606    clang-20
i386                  randconfig-017-20250606    clang-20
loongarch                        allmodconfig    gcc-15.1.0
loongarch                         allnoconfig    gcc-15.1.0
loongarch                        allyesconfig    gcc-15.1.0
loongarch                           defconfig    gcc-15.1.0
loongarch             randconfig-001-20250606    gcc-13.3.0
loongarch             randconfig-001-20250606    gcc-15.1.0
loongarch             randconfig-002-20250606    gcc-13.3.0
loongarch             randconfig-002-20250606    gcc-14.3.0
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
m68k                                defconfig    gcc-15.1.0
m68k                          sun3x_defconfig    gcc-12
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                             allmodconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                             allyesconfig    gcc-15.1.0
mips                      bmips_stb_defconfig    clang-21
mips                           ci20_defconfig    gcc-12
mips                           ip22_defconfig    gcc-15.1.0
mips                           ip30_defconfig    gcc-15.1.0
mips                       lemote2f_defconfig    gcc-15.1.0
mips                          rm200_defconfig    gcc-15.1.0
mips                           rs90_defconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-15.1.0
nios2                               defconfig    gcc-15.1.0
nios2                 randconfig-001-20250606    gcc-13.3.0
nios2                 randconfig-001-20250606    gcc-14.2.0
nios2                 randconfig-002-20250606    gcc-13.3.0
nios2                 randconfig-002-20250606    gcc-9.3.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-12
openrisc                 simple_smp_defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-12
parisc                randconfig-001-20250606    gcc-11.5.0
parisc                randconfig-001-20250606    gcc-13.3.0
parisc                randconfig-002-20250606    gcc-12.4.0
parisc                randconfig-002-20250606    gcc-13.3.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-21
powerpc                          allyesconfig    gcc-15.1.0
powerpc                    amigaone_defconfig    gcc-15.1.0
powerpc                      cm5200_defconfig    clang-21
powerpc                   microwatt_defconfig    gcc-12
powerpc                 mpc8313_rdb_defconfig    gcc-15.1.0
powerpc                 mpc837x_rdb_defconfig    gcc-15.1.0
powerpc                  mpc885_ads_defconfig    gcc-15.1.0
powerpc               randconfig-001-20250606    clang-21
powerpc               randconfig-001-20250606    gcc-13.3.0
powerpc               randconfig-002-20250606    clang-21
powerpc               randconfig-002-20250606    gcc-13.3.0
powerpc               randconfig-003-20250606    gcc-13.3.0
powerpc                  storcenter_defconfig    gcc-12
powerpc                     tqm8541_defconfig    gcc-15.1.0
powerpc64             randconfig-001-20250606    clang-21
powerpc64             randconfig-001-20250606    gcc-13.3.0
powerpc64             randconfig-002-20250606    clang-17
powerpc64             randconfig-002-20250606    gcc-13.3.0
powerpc64             randconfig-003-20250606    gcc-12.4.0
powerpc64             randconfig-003-20250606    gcc-13.3.0
riscv                            allmodconfig    clang-21
riscv                            allmodconfig    gcc-15.1.0
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                            allyesconfig    gcc-15.1.0
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20250606    gcc-11.5.0
riscv                 randconfig-002-20250606    gcc-8.5.0
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20250606    clang-21
s390                  randconfig-002-20250606    clang-18
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                         ap325rxa_defconfig    gcc-12
sh                                  defconfig    gcc-12
sh                          landisk_defconfig    gcc-15.1.0
sh                    randconfig-001-20250606    gcc-12.4.0
sh                    randconfig-002-20250606    gcc-10.5.0
sh                          rsk7264_defconfig    gcc-12
sh                           se7751_defconfig    gcc-15.1.0
sh                             sh03_defconfig    gcc-15.1.0
sh                  sh7785lcr_32bit_defconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                 randconfig-001-20250606    gcc-8.5.0
sparc                 randconfig-002-20250606    gcc-8.5.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20250606    gcc-12.4.0
sparc64               randconfig-002-20250606    gcc-15.1.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    clang-19
um                               allyesconfig    gcc-12
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250606    gcc-12
um                    randconfig-002-20250606    gcc-12
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250606    clang-20
x86_64      buildonly-randconfig-001-20250606    gcc-12
x86_64      buildonly-randconfig-002-20250606    gcc-12
x86_64      buildonly-randconfig-003-20250606    gcc-12
x86_64      buildonly-randconfig-004-20250606    gcc-12
x86_64      buildonly-randconfig-005-20250606    gcc-12
x86_64      buildonly-randconfig-006-20250606    gcc-12
x86_64                              defconfig    clang-20
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20250606    gcc-11
x86_64                randconfig-002-20250606    gcc-11
x86_64                randconfig-003-20250606    gcc-11
x86_64                randconfig-004-20250606    gcc-11
x86_64                randconfig-005-20250606    gcc-11
x86_64                randconfig-006-20250606    gcc-11
x86_64                randconfig-007-20250606    gcc-11
x86_64                randconfig-008-20250606    gcc-11
x86_64                randconfig-071-20250606    gcc-12
x86_64                randconfig-072-20250606    gcc-12
x86_64                randconfig-073-20250606    gcc-12
x86_64                randconfig-074-20250606    gcc-12
x86_64                randconfig-075-20250606    gcc-12
x86_64                randconfig-076-20250606    gcc-12
x86_64                randconfig-077-20250606    gcc-12
x86_64                randconfig-078-20250606    gcc-12
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-12
x86_64                         rhel-9.4-kunit    gcc-12
x86_64                           rhel-9.4-ltp    gcc-12
x86_64                          rhel-9.4-rust    clang-18
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250606    gcc-9.3.0
xtensa                randconfig-002-20250606    gcc-12.4.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
