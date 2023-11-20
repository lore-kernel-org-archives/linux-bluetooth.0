Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YJy1m9QD"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2FD6D3
	for <linux-bluetooth@vger.kernel.org>; Mon, 20 Nov 2023 04:24:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700483093; x=1732019093;
  h=date:from:to:cc:subject:message-id;
  bh=sI19UicZR1rbweDHsD3djoWb62xYG06HEuN2wNuuw/M=;
  b=YJy1m9QD7ZG7j3uz5RLQwZ7Jv0coaaX2AqTgY8L5PMJV23ctuL9N32iv
   VOGoGtPl9fm0lJcpDhtD9EtGPnkNwM7AiSpmwx+hJn9AeFtoaR1EhMxzW
   lzyrAOSfjsZkMYF0jO1krDQoIsFvBKln4EgympfN723D5rq2ksB2bnLkl
   BXRBPRB6PAqqfffr7PTTF172sHsaI1ufzS1rIv8OlFiqvBG1MxexDTFZi
   IYiI2NPTF5XgR/HCC5ZhFULFagy/EKA/R79k2hdDnnIRdj93iQsbtxXGe
   cGOtRU3AzcEiQT0tWGMix3rDXzg5hE3EjwyPAAQ0YER5ymaP5GB0Nq6mk
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10899"; a="388746319"
X-IronPort-AV: E=Sophos;i="6.04,213,1695711600"; 
   d="scan'208";a="388746319"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 04:24:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10899"; a="836725228"
X-IronPort-AV: E=Sophos;i="6.04,213,1695711600"; 
   d="scan'208";a="836725228"
Received: from lkp-server02.sh.intel.com (HELO b8de5498638e) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 20 Nov 2023 04:24:51 -0800
Received: from kbuild by b8de5498638e with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1r53Kb-0006Qv-1f;
	Mon, 20 Nov 2023 12:24:49 +0000
Date: Mon, 20 Nov 2023 20:24:23 +0800
From: kernel test robot <lkp@intel.com>
To: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 d5742377e3ac807f1879bb6d8571c8787622a37d
Message-ID: <202311202021.fVfmvfJJ-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: d5742377e3ac807f1879bb6d8571c8787622a37d  Bluetooth: qca: Set both WIDEBAND_SPEECH and LE_STATES quirks for QCA2066

elapsed time: 4010m

configs tested: 392
configs skipped: 23

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            alldefconfig   gcc  
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                          axs103_defconfig   gcc  
arc                                 defconfig   gcc  
arc                     haps_hs_smp_defconfig   gcc  
arc                 nsimosci_hs_smp_defconfig   gcc  
arc                   randconfig-001-20231118   gcc  
arc                   randconfig-001-20231119   gcc  
arc                   randconfig-001-20231120   gcc  
arc                   randconfig-002-20231118   gcc  
arc                   randconfig-002-20231119   gcc  
arc                   randconfig-002-20231120   gcc  
arc                           tb10x_defconfig   gcc  
arc                        vdk_hs38_defconfig   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                        clps711x_defconfig   gcc  
arm                                 defconfig   clang
arm                          gemini_defconfig   gcc  
arm                           h3600_defconfig   gcc  
arm                      integrator_defconfig   gcc  
arm                      jornada720_defconfig   gcc  
arm                        keystone_defconfig   gcc  
arm                            mps2_defconfig   gcc  
arm                        multi_v7_defconfig   gcc  
arm                          pxa910_defconfig   gcc  
arm                             pxa_defconfig   gcc  
arm                   randconfig-001-20231118   gcc  
arm                   randconfig-001-20231119   gcc  
arm                   randconfig-001-20231120   clang
arm                   randconfig-002-20231118   gcc  
arm                   randconfig-002-20231119   gcc  
arm                   randconfig-002-20231120   clang
arm                   randconfig-003-20231118   gcc  
arm                   randconfig-003-20231119   gcc  
arm                   randconfig-003-20231120   clang
arm                   randconfig-004-20231118   gcc  
arm                   randconfig-004-20231119   gcc  
arm                   randconfig-004-20231120   clang
arm                        spear6xx_defconfig   gcc  
arm                           stm32_defconfig   gcc  
arm                           sunxi_defconfig   gcc  
arm                           u8500_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                            allyesconfig   clang
arm64                               defconfig   gcc  
arm64                 randconfig-001-20231118   gcc  
arm64                 randconfig-001-20231119   gcc  
arm64                 randconfig-001-20231120   clang
arm64                 randconfig-002-20231118   gcc  
arm64                 randconfig-002-20231119   gcc  
arm64                 randconfig-002-20231120   clang
arm64                 randconfig-003-20231118   gcc  
arm64                 randconfig-003-20231119   gcc  
arm64                 randconfig-003-20231120   clang
arm64                 randconfig-004-20231118   gcc  
arm64                 randconfig-004-20231119   gcc  
arm64                 randconfig-004-20231120   clang
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20231118   gcc  
csky                  randconfig-001-20231119   gcc  
csky                  randconfig-001-20231120   gcc  
csky                  randconfig-002-20231118   gcc  
csky                  randconfig-002-20231119   gcc  
csky                  randconfig-002-20231120   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20231120   clang
hexagon               randconfig-002-20231120   clang
i386                             alldefconfig   gcc  
i386                             allmodconfig   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   clang
i386                              allnoconfig   gcc  
i386                             allyesconfig   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20231118   gcc  
i386         buildonly-randconfig-001-20231119   gcc  
i386         buildonly-randconfig-002-20231118   gcc  
i386         buildonly-randconfig-002-20231119   gcc  
i386         buildonly-randconfig-003-20231118   gcc  
i386         buildonly-randconfig-003-20231119   gcc  
i386         buildonly-randconfig-004-20231118   gcc  
i386         buildonly-randconfig-004-20231119   gcc  
i386         buildonly-randconfig-005-20231118   gcc  
i386         buildonly-randconfig-005-20231119   gcc  
i386         buildonly-randconfig-006-20231118   gcc  
i386         buildonly-randconfig-006-20231119   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20231118   gcc  
i386                  randconfig-001-20231119   gcc  
i386                  randconfig-002-20231118   gcc  
i386                  randconfig-002-20231119   gcc  
i386                  randconfig-003-20231118   gcc  
i386                  randconfig-003-20231119   gcc  
i386                  randconfig-004-20231118   gcc  
i386                  randconfig-004-20231119   gcc  
i386                  randconfig-005-20231118   gcc  
i386                  randconfig-005-20231119   gcc  
i386                  randconfig-006-20231118   gcc  
i386                  randconfig-006-20231119   gcc  
i386                  randconfig-011-20231118   gcc  
i386                  randconfig-011-20231119   clang
i386                  randconfig-011-20231119   gcc  
i386                  randconfig-011-20231120   gcc  
i386                  randconfig-012-20231118   gcc  
i386                  randconfig-012-20231119   clang
i386                  randconfig-012-20231119   gcc  
i386                  randconfig-012-20231120   gcc  
i386                  randconfig-013-20231118   gcc  
i386                  randconfig-013-20231119   clang
i386                  randconfig-013-20231119   gcc  
i386                  randconfig-013-20231120   gcc  
i386                  randconfig-014-20231118   gcc  
i386                  randconfig-014-20231119   clang
i386                  randconfig-014-20231119   gcc  
i386                  randconfig-014-20231120   gcc  
i386                  randconfig-015-20231118   gcc  
i386                  randconfig-015-20231119   clang
i386                  randconfig-015-20231119   gcc  
i386                  randconfig-015-20231120   gcc  
i386                  randconfig-016-20231118   gcc  
i386                  randconfig-016-20231119   clang
i386                  randconfig-016-20231119   gcc  
i386                  randconfig-016-20231120   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20231118   gcc  
loongarch             randconfig-001-20231119   gcc  
loongarch             randconfig-001-20231120   gcc  
loongarch             randconfig-002-20231118   gcc  
loongarch             randconfig-002-20231119   gcc  
loongarch             randconfig-002-20231120   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                         apollo_defconfig   gcc  
m68k                                defconfig   gcc  
m68k                          hp300_defconfig   gcc  
m68k                        m5272c3_defconfig   gcc  
m68k                        m5407c3_defconfig   gcc  
m68k                        stmark2_defconfig   gcc  
m68k                           sun3_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
microblaze                      mmu_defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                          ath25_defconfig   clang
mips                        bcm63xx_defconfig   clang
mips                         cobalt_defconfig   gcc  
mips                     decstation_defconfig   gcc  
mips                 decstation_r4k_defconfig   gcc  
mips                           gcw0_defconfig   gcc  
mips                     loongson1b_defconfig   gcc  
mips                      maltasmvp_defconfig   gcc  
mips                  maltasmvp_eva_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20231118   gcc  
nios2                 randconfig-001-20231119   gcc  
nios2                 randconfig-001-20231120   gcc  
nios2                 randconfig-002-20231118   gcc  
nios2                 randconfig-002-20231119   gcc  
nios2                 randconfig-002-20231120   gcc  
openrisc                         alldefconfig   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20231118   gcc  
parisc                randconfig-001-20231119   gcc  
parisc                randconfig-001-20231120   gcc  
parisc                randconfig-002-20231118   gcc  
parisc                randconfig-002-20231119   gcc  
parisc                randconfig-002-20231120   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   clang
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                          allyesconfig   gcc  
powerpc                        cell_defconfig   gcc  
powerpc                      cm5200_defconfig   gcc  
powerpc                   currituck_defconfig   gcc  
powerpc                     ep8248e_defconfig   gcc  
powerpc                    ge_imp3a_defconfig   clang
powerpc                    klondike_defconfig   gcc  
powerpc                 linkstation_defconfig   gcc  
powerpc                      makalu_defconfig   gcc  
powerpc                      mgcoge_defconfig   gcc  
powerpc                 mpc837x_rdb_defconfig   gcc  
powerpc                      pcm030_defconfig   gcc  
powerpc                      pmac32_defconfig   clang
powerpc                      ppc40x_defconfig   gcc  
powerpc               randconfig-001-20231118   gcc  
powerpc               randconfig-001-20231119   gcc  
powerpc               randconfig-001-20231120   clang
powerpc               randconfig-002-20231118   gcc  
powerpc               randconfig-002-20231119   gcc  
powerpc               randconfig-002-20231120   clang
powerpc               randconfig-003-20231118   gcc  
powerpc               randconfig-003-20231119   gcc  
powerpc               randconfig-003-20231120   clang
powerpc                     redwood_defconfig   gcc  
powerpc                     sequoia_defconfig   gcc  
powerpc                        warp_defconfig   gcc  
powerpc                         wii_defconfig   gcc  
powerpc64             randconfig-001-20231118   gcc  
powerpc64             randconfig-001-20231119   gcc  
powerpc64             randconfig-001-20231120   clang
powerpc64             randconfig-002-20231118   gcc  
powerpc64             randconfig-002-20231119   gcc  
powerpc64             randconfig-002-20231120   clang
powerpc64             randconfig-003-20231118   gcc  
powerpc64             randconfig-003-20231119   gcc  
powerpc64             randconfig-003-20231120   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv             nommu_k210_sdcard_defconfig   gcc  
riscv                 randconfig-001-20231118   gcc  
riscv                 randconfig-001-20231119   gcc  
riscv                 randconfig-001-20231120   clang
riscv                 randconfig-002-20231118   gcc  
riscv                 randconfig-002-20231119   gcc  
riscv                 randconfig-002-20231120   clang
riscv                          rv32_defconfig   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20231118   gcc  
s390                  randconfig-001-20231119   gcc  
s390                  randconfig-001-20231120   gcc  
s390                  randconfig-002-20231118   gcc  
s390                  randconfig-002-20231119   gcc  
s390                  randconfig-002-20231120   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                         ap325rxa_defconfig   gcc  
sh                         apsh4a3a_defconfig   gcc  
sh                        apsh4ad0a_defconfig   gcc  
sh                                  defconfig   gcc  
sh                         ecovec24_defconfig   gcc  
sh                        edosk7760_defconfig   gcc  
sh                            hp6xx_defconfig   gcc  
sh                               j2_defconfig   gcc  
sh                          kfr2r09_defconfig   gcc  
sh                          landisk_defconfig   gcc  
sh                          polaris_defconfig   gcc  
sh                    randconfig-001-20231118   gcc  
sh                    randconfig-001-20231119   gcc  
sh                    randconfig-001-20231120   gcc  
sh                    randconfig-002-20231118   gcc  
sh                    randconfig-002-20231119   gcc  
sh                    randconfig-002-20231120   gcc  
sh                          rsk7264_defconfig   gcc  
sh                   rts7751r2dplus_defconfig   gcc  
sh                           se7705_defconfig   gcc  
sh                           se7750_defconfig   gcc  
sh                           se7780_defconfig   gcc  
sh                   secureedge5410_defconfig   gcc  
sh                           sh2007_defconfig   gcc  
sh                        sh7763rdp_defconfig   gcc  
sh                  sh7785lcr_32bit_defconfig   gcc  
sh                            titan_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                       sparc64_defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20231118   gcc  
sparc64               randconfig-001-20231119   gcc  
sparc64               randconfig-001-20231120   gcc  
sparc64               randconfig-002-20231118   gcc  
sparc64               randconfig-002-20231119   gcc  
sparc64               randconfig-002-20231120   gcc  
um                               allmodconfig   gcc  
um                                allnoconfig   gcc  
um                               allyesconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                    randconfig-001-20231118   gcc  
um                    randconfig-001-20231119   gcc  
um                    randconfig-001-20231120   clang
um                    randconfig-002-20231118   gcc  
um                    randconfig-002-20231119   gcc  
um                    randconfig-002-20231120   clang
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   clang
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-001-20231118   gcc  
x86_64       buildonly-randconfig-001-20231119   gcc  
x86_64       buildonly-randconfig-001-20231120   clang
x86_64       buildonly-randconfig-002-20231118   gcc  
x86_64       buildonly-randconfig-002-20231119   gcc  
x86_64       buildonly-randconfig-002-20231120   clang
x86_64       buildonly-randconfig-003-20231118   gcc  
x86_64       buildonly-randconfig-003-20231119   gcc  
x86_64       buildonly-randconfig-003-20231120   clang
x86_64       buildonly-randconfig-004-20231118   gcc  
x86_64       buildonly-randconfig-004-20231119   gcc  
x86_64       buildonly-randconfig-004-20231120   clang
x86_64       buildonly-randconfig-005-20231118   gcc  
x86_64       buildonly-randconfig-005-20231119   gcc  
x86_64       buildonly-randconfig-005-20231120   clang
x86_64       buildonly-randconfig-006-20231118   gcc  
x86_64       buildonly-randconfig-006-20231119   gcc  
x86_64       buildonly-randconfig-006-20231120   clang
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64                randconfig-001-20231118   gcc  
x86_64                randconfig-001-20231119   gcc  
x86_64                randconfig-002-20231118   gcc  
x86_64                randconfig-002-20231119   gcc  
x86_64                randconfig-003-20231118   gcc  
x86_64                randconfig-003-20231119   gcc  
x86_64                randconfig-004-20231118   gcc  
x86_64                randconfig-004-20231119   gcc  
x86_64                randconfig-005-20231118   gcc  
x86_64                randconfig-005-20231119   gcc  
x86_64                randconfig-006-20231118   gcc  
x86_64                randconfig-006-20231119   gcc  
x86_64                randconfig-011-20231118   gcc  
x86_64                randconfig-011-20231119   gcc  
x86_64                randconfig-011-20231120   clang
x86_64                randconfig-012-20231118   gcc  
x86_64                randconfig-012-20231119   gcc  
x86_64                randconfig-012-20231120   clang
x86_64                randconfig-013-20231118   gcc  
x86_64                randconfig-013-20231119   gcc  
x86_64                randconfig-013-20231120   clang
x86_64                randconfig-014-20231118   gcc  
x86_64                randconfig-014-20231119   gcc  
x86_64                randconfig-014-20231120   clang
x86_64                randconfig-015-20231118   gcc  
x86_64                randconfig-015-20231119   gcc  
x86_64                randconfig-015-20231120   clang
x86_64                randconfig-016-20231118   gcc  
x86_64                randconfig-016-20231119   gcc  
x86_64                randconfig-016-20231120   clang
x86_64                randconfig-071-20231118   gcc  
x86_64                randconfig-071-20231119   gcc  
x86_64                randconfig-071-20231120   clang
x86_64                randconfig-072-20231118   gcc  
x86_64                randconfig-072-20231119   gcc  
x86_64                randconfig-072-20231120   clang
x86_64                randconfig-073-20231118   gcc  
x86_64                randconfig-073-20231119   gcc  
x86_64                randconfig-073-20231120   clang
x86_64                randconfig-074-20231118   gcc  
x86_64                randconfig-074-20231119   gcc  
x86_64                randconfig-074-20231120   clang
x86_64                randconfig-075-20231118   gcc  
x86_64                randconfig-075-20231119   gcc  
x86_64                randconfig-075-20231120   clang
x86_64                randconfig-076-20231118   gcc  
x86_64                randconfig-076-20231119   gcc  
x86_64                randconfig-076-20231120   clang
x86_64                           rhel-8.3-bpf   clang
x86_64                           rhel-8.3-bpf   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                           alldefconfig   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                       common_defconfig   gcc  
xtensa                generic_kc705_defconfig   gcc  
xtensa                randconfig-001-20231118   gcc  
xtensa                randconfig-001-20231119   gcc  
xtensa                randconfig-001-20231120   gcc  
xtensa                randconfig-002-20231118   gcc  
xtensa                randconfig-002-20231119   gcc  
xtensa                randconfig-002-20231120   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
