Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 098F258AC4
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Sep 2024 17:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726075328; cv=none; b=B4PPijTPRhEUcBxFibUiZV0cPEpJ/t7FWco+Xg7ATa0gm48dSMtZTN/lAPf6PBUS27qdLF5G9zjmCsKxvBk3BotBSxVe6/46d3zSP+ETGDclF7A5NqXMinsXB0Mo/1sR4z75MpO96NmnmhiQW1IjaUiMOvJ+QCHv9Y1YIfAplDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726075328; c=relaxed/simple;
	bh=mG+JOtieFYBmZZjI8huNhVOlNO8oa7SS3bsaDj3ed8o=;
	h=Date:From:To:Cc:Subject:Message-ID; b=WpV0Fn71VDU3wJWggvY3CCiF4Ob0nH13IC6YN9A0LzkUHJwokUZRCZZwCBLyZsjDeoLPmF6aQIZeQ9sVwIPhZtAQoYeqhHMi+hvLEE6Gm8SA87kHq57CsRbKvQTRgd1/iHYE5rsvJXxILm1kUCdvpZ2yCBqwJ5C1doZuZyrEiaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m21G8G6r; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m21G8G6r"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726075327; x=1757611327;
  h=date:from:to:cc:subject:message-id;
  bh=mG+JOtieFYBmZZjI8huNhVOlNO8oa7SS3bsaDj3ed8o=;
  b=m21G8G6rm43grQjzv4DSJwuY5RlHBCfFLN5uKFTrkhUrGlSC8gsSFXLP
   U1JEsRs6/8pwCffaroOBOJsebc2a6bsKHghc25ue+tUeeBjUwGrTAyEqs
   47N6K59O6zFo4HrpDoiaHLzkV96jOf5uJ2D9TycsOkk67DrFt/5UvNjBQ
   C2WyDOEBmTwMzqweCdAWDINZW8tTCFh2MIDQKSDjTEVTSHCqurUy1YInS
   Kb7I3dEXKGv6B6bSkUVGM1CJ9c6bcLErz7FxIR67RmVvQWPS2WdDTTujV
   vk0TAP9I92HdOPfnMhmLruq4gXrKnvqv+o257KlqG389WYG+ixhG+aZQ1
   A==;
X-CSE-ConnectionGUID: /1D/WrdzQgm3nUeKw9n2xw==
X-CSE-MsgGUID: IgfaoW8aRaG9xvhteEY0EA==
X-IronPort-AV: E=McAfee;i="6700,10204,11192"; a="47407910"
X-IronPort-AV: E=Sophos;i="6.10,220,1719903600"; 
   d="scan'208";a="47407910"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2024 10:22:07 -0700
X-CSE-ConnectionGUID: wqiVN+oWTJyj3EVNPiDlWA==
X-CSE-MsgGUID: O+aFjZKUSe+taAu/qJ1e8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,220,1719903600"; 
   d="scan'208";a="67361567"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 11 Sep 2024 10:22:06 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1soR2Y-0003tS-2v;
	Wed, 11 Sep 2024 17:22:02 +0000
Date: Thu, 12 Sep 2024 01:21:12 +0800
From: kernel test robot <lkp@intel.com>
To: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 fd8c0f820825964dc525a99b9096048f829a1e8a
Message-ID: <202409120110.pd7cAsHV-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: fd8c0f820825964dc525a99b9096048f829a1e8a  Bluetooth: hci_sync: Ignore errors from HCI_OP_REMOTE_NAME_REQ_CANCEL

elapsed time: 1463m

configs tested: 214
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-14.1.0
alpha                            allyesconfig   clang-20
alpha                            allyesconfig   gcc-13.3.0
alpha                               defconfig   gcc-14.1.0
arc                              alldefconfig   gcc-14.1.0
arc                              allmodconfig   clang-20
arc                              allmodconfig   gcc-13.2.0
arc                               allnoconfig   gcc-14.1.0
arc                              allyesconfig   clang-20
arc                              allyesconfig   gcc-13.2.0
arc                          axs101_defconfig   clang-20
arc                          axs101_defconfig   gcc-14.1.0
arc                                 defconfig   gcc-14.1.0
arc                   randconfig-001-20240911   gcc-13.2.0
arc                   randconfig-002-20240911   gcc-13.2.0
arc                    vdk_hs38_smp_defconfig   clang-20
arm                              allmodconfig   clang-20
arm                              allmodconfig   gcc-14.1.0
arm                               allnoconfig   gcc-14.1.0
arm                              allyesconfig   clang-20
arm                              allyesconfig   gcc-14.1.0
arm                     davinci_all_defconfig   clang-20
arm                                 defconfig   gcc-14.1.0
arm                          exynos_defconfig   clang-20
arm                      footbridge_defconfig   clang-20
arm                            hisi_defconfig   gcc-14.1.0
arm                          moxart_defconfig   clang-20
arm                            mps2_defconfig   clang-20
arm                        multi_v7_defconfig   clang-20
arm                       netwinder_defconfig   gcc-14.1.0
arm                   randconfig-001-20240911   gcc-13.2.0
arm                   randconfig-002-20240911   gcc-13.2.0
arm                   randconfig-003-20240911   gcc-13.2.0
arm                   randconfig-004-20240911   gcc-13.2.0
arm                         socfpga_defconfig   gcc-14.1.0
arm                           tegra_defconfig   clang-20
arm64                            allmodconfig   clang-20
arm64                             allnoconfig   gcc-14.1.0
arm64                               defconfig   gcc-14.1.0
arm64                 randconfig-001-20240911   gcc-13.2.0
arm64                 randconfig-002-20240911   gcc-13.2.0
arm64                 randconfig-003-20240911   gcc-13.2.0
arm64                 randconfig-004-20240911   gcc-13.2.0
csky                              allnoconfig   gcc-14.1.0
csky                                defconfig   gcc-14.1.0
csky                  randconfig-001-20240911   gcc-13.2.0
csky                  randconfig-002-20240911   gcc-13.2.0
hexagon                          allmodconfig   clang-20
hexagon                           allnoconfig   gcc-14.1.0
hexagon                          allyesconfig   clang-20
hexagon                             defconfig   gcc-14.1.0
hexagon               randconfig-001-20240911   gcc-13.2.0
hexagon               randconfig-002-20240911   gcc-13.2.0
i386                             allmodconfig   clang-18
i386                             allmodconfig   gcc-12
i386                              allnoconfig   clang-18
i386                              allnoconfig   gcc-12
i386                             allyesconfig   clang-18
i386                             allyesconfig   gcc-12
i386         buildonly-randconfig-001-20240911   gcc-12
i386         buildonly-randconfig-002-20240911   gcc-12
i386         buildonly-randconfig-003-20240911   gcc-12
i386         buildonly-randconfig-004-20240911   gcc-12
i386         buildonly-randconfig-005-20240911   gcc-12
i386         buildonly-randconfig-006-20240911   gcc-12
i386                                defconfig   clang-18
i386                  randconfig-001-20240911   gcc-12
i386                  randconfig-002-20240911   gcc-12
i386                  randconfig-003-20240911   gcc-12
i386                  randconfig-004-20240911   gcc-12
i386                  randconfig-005-20240911   gcc-12
i386                  randconfig-006-20240911   gcc-12
i386                  randconfig-011-20240911   gcc-12
i386                  randconfig-012-20240911   gcc-12
i386                  randconfig-013-20240911   gcc-12
i386                  randconfig-014-20240911   gcc-12
i386                  randconfig-015-20240911   gcc-12
i386                  randconfig-016-20240911   gcc-12
loongarch                        allmodconfig   gcc-14.1.0
loongarch                         allnoconfig   gcc-14.1.0
loongarch                           defconfig   gcc-14.1.0
loongarch             randconfig-001-20240911   gcc-13.2.0
loongarch             randconfig-002-20240911   gcc-13.2.0
m68k                             allmodconfig   gcc-14.1.0
m68k                              allnoconfig   gcc-14.1.0
m68k                             allyesconfig   gcc-14.1.0
m68k                                defconfig   gcc-14.1.0
m68k                          sun3x_defconfig   gcc-14.1.0
microblaze                       alldefconfig   clang-20
microblaze                       allmodconfig   gcc-14.1.0
microblaze                        allnoconfig   gcc-14.1.0
microblaze                       allyesconfig   gcc-14.1.0
microblaze                          defconfig   gcc-14.1.0
mips                              allnoconfig   gcc-14.1.0
mips                  cavium_octeon_defconfig   gcc-14.1.0
mips                         db1xxx_defconfig   clang-20
mips                  decstation_64_defconfig   clang-20
mips                 decstation_r4k_defconfig   clang-20
mips                           ip32_defconfig   gcc-14.1.0
mips                      loongson3_defconfig   gcc-14.1.0
mips                malta_qemu_32r6_defconfig   gcc-14.1.0
mips                          rb532_defconfig   clang-20
mips                          rb532_defconfig   gcc-14.1.0
mips                          rm200_defconfig   clang-20
nios2                             allnoconfig   gcc-14.1.0
nios2                               defconfig   gcc-14.1.0
nios2                 randconfig-001-20240911   gcc-13.2.0
nios2                 randconfig-002-20240911   gcc-13.2.0
openrisc                          allnoconfig   clang-20
openrisc                         allyesconfig   gcc-14.1.0
openrisc                            defconfig   gcc-12
parisc                           allmodconfig   gcc-14.1.0
parisc                            allnoconfig   clang-20
parisc                           allyesconfig   gcc-14.1.0
parisc                              defconfig   gcc-12
parisc                randconfig-001-20240911   gcc-13.2.0
parisc                randconfig-002-20240911   gcc-13.2.0
parisc64                            defconfig   gcc-14.1.0
powerpc                          allmodconfig   gcc-14.1.0
powerpc                           allnoconfig   clang-20
powerpc                          allyesconfig   clang-20
powerpc                          allyesconfig   gcc-14.1.0
powerpc                   bluestone_defconfig   clang-20
powerpc                       ebony_defconfig   clang-20
powerpc                        icon_defconfig   clang-20
powerpc                  iss476-smp_defconfig   clang-20
powerpc                 linkstation_defconfig   clang-20
powerpc                     mpc512x_defconfig   clang-20
powerpc                     mpc512x_defconfig   gcc-14.1.0
powerpc                 mpc8313_rdb_defconfig   clang-20
powerpc                 mpc834x_itx_defconfig   gcc-14.1.0
powerpc                      ppc64e_defconfig   clang-20
powerpc                     rainier_defconfig   gcc-14.1.0
powerpc               randconfig-003-20240911   gcc-13.2.0
powerpc                         wii_defconfig   clang-20
powerpc                 xes_mpc85xx_defconfig   clang-20
powerpc64             randconfig-001-20240911   gcc-13.2.0
powerpc64             randconfig-002-20240911   gcc-13.2.0
powerpc64             randconfig-003-20240911   gcc-13.2.0
riscv                            allmodconfig   clang-20
riscv                            allmodconfig   gcc-14.1.0
riscv                             allnoconfig   clang-20
riscv                            allyesconfig   clang-20
riscv                            allyesconfig   gcc-14.1.0
riscv                               defconfig   gcc-12
riscv                               defconfig   gcc-14.1.0
riscv             nommu_k210_sdcard_defconfig   clang-20
riscv                 randconfig-001-20240911   gcc-13.2.0
riscv                 randconfig-002-20240911   gcc-13.2.0
s390                             allmodconfig   clang-20
s390                             allmodconfig   gcc-14.1.0
s390                              allnoconfig   clang-20
s390                             allyesconfig   gcc-14.1.0
s390                                defconfig   gcc-12
s390                  randconfig-001-20240911   gcc-13.2.0
s390                  randconfig-002-20240911   gcc-13.2.0
s390                       zfcpdump_defconfig   clang-20
sh                               allmodconfig   gcc-14.1.0
sh                                allnoconfig   gcc-14.1.0
sh                               allyesconfig   gcc-14.1.0
sh                                  defconfig   gcc-12
sh                               j2_defconfig   clang-20
sh                    randconfig-001-20240911   gcc-13.2.0
sh                    randconfig-002-20240911   gcc-13.2.0
sh                           se7619_defconfig   gcc-14.1.0
sparc                            alldefconfig   clang-20
sparc                            allmodconfig   gcc-14.1.0
sparc64                             defconfig   gcc-12
sparc64               randconfig-001-20240911   gcc-13.2.0
sparc64               randconfig-002-20240911   gcc-13.2.0
um                               allmodconfig   clang-20
um                                allnoconfig   clang-20
um                               allyesconfig   clang-20
um                               allyesconfig   gcc-12
um                                  defconfig   gcc-12
um                             i386_defconfig   gcc-12
um                    randconfig-001-20240911   gcc-13.2.0
um                    randconfig-002-20240911   gcc-13.2.0
um                           x86_64_defconfig   gcc-12
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240911   clang-18
x86_64       buildonly-randconfig-002-20240911   clang-18
x86_64       buildonly-randconfig-003-20240911   clang-18
x86_64       buildonly-randconfig-004-20240911   clang-18
x86_64       buildonly-randconfig-005-20240911   clang-18
x86_64       buildonly-randconfig-006-20240911   clang-18
x86_64                              defconfig   clang-18
x86_64                              defconfig   gcc-11
x86_64                                  kexec   gcc-12
x86_64                randconfig-001-20240911   clang-18
x86_64                randconfig-002-20240911   clang-18
x86_64                randconfig-003-20240911   clang-18
x86_64                randconfig-004-20240911   clang-18
x86_64                randconfig-005-20240911   clang-18
x86_64                randconfig-006-20240911   clang-18
x86_64                randconfig-011-20240911   clang-18
x86_64                randconfig-012-20240911   clang-18
x86_64                randconfig-013-20240911   clang-18
x86_64                randconfig-014-20240911   clang-18
x86_64                randconfig-015-20240911   clang-18
x86_64                randconfig-016-20240911   clang-18
x86_64                randconfig-071-20240911   clang-18
x86_64                randconfig-072-20240911   clang-18
x86_64                randconfig-073-20240911   clang-18
x86_64                randconfig-074-20240911   clang-18
x86_64                randconfig-075-20240911   clang-18
x86_64                randconfig-076-20240911   clang-18
x86_64                          rhel-8.3-rust   clang-18
x86_64                               rhel-8.3   gcc-12
xtensa                            allnoconfig   gcc-14.1.0
xtensa                  cadence_csp_defconfig   clang-20
xtensa                randconfig-001-20240911   gcc-13.2.0
xtensa                randconfig-002-20240911   gcc-13.2.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
