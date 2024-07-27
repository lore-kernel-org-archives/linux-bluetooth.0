Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A27B7318A
	for <linux-bluetooth@vger.kernel.org>; Sat, 27 Jul 2024 14:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722089732; cv=none; b=HqJY68Yetm2+L2tuXP92CUMDDXWKGVxfsM07UvCTK77cYxzaXuR1VMP1SMEc5JXPlXGiG27sPl5VSsnVT6ov8K6/8qyUxO7OWAQRX9w130ohioUzJkAQQv/isMyjy5bQAwAYyPri2GI7P1dX8+rfevpt2H4R97Foz5wS+b7Elys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722089732; c=relaxed/simple;
	bh=KRRDBCjTvfK++BLYtq7ceDOuDXekQASAFKxWa9uAyns=;
	h=Date:From:To:Cc:Subject:Message-ID; b=RG9FITvWuKBNAzw1cxCGfdq/lTgGok6SDaLm/ricXga5vkfsqefq5s+p9ZDuSkk9KHmeNZVR3T7uT40W13EE9NKVDmaynpJX18hvhIqJ8G9uR54VNmONRxuba0dYRxhKIm+/mW3T/+vXzThGzlYMa8tzWymQtoQOtM0O2hSkH+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l1aCc531; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l1aCc531"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722089730; x=1753625730;
  h=date:from:to:cc:subject:message-id;
  bh=KRRDBCjTvfK++BLYtq7ceDOuDXekQASAFKxWa9uAyns=;
  b=l1aCc531wg9w4bznEoeRIXDJjrMmz3sNJA3+qs/ta/qPdoSFjxkx4HOe
   vBR1vv5Anr5+ktvkpQzKq9ruKLwh2kYqhhHAILzuOJHVPA0GieSj4D5Gy
   TdnN8AHcBP0Pn/ilRiRC+w7M68MCeGkjYG+SNu0c+Q2GouYw0dC3IRvCQ
   3OMMW3rABPO/6ZOJPoWImxfvQb4sVxPhugat5iI1Q/buGE7CIL7EezZ6q
   k22jSWAL2TQeCUhVTEI6X4POKVSeCNBE2pMY24GfrHdpTmy5KQmBfy/C6
   JeaCkeQKp0OyLej4qHB2jHvyzM2jHK23yYRgB0aHcmua9DFO8NIaW0NyI
   Q==;
X-CSE-ConnectionGUID: UECy39KcTvC8wfzzb3PdJw==
X-CSE-MsgGUID: 7AixPUDeRgOTwizYqGjSww==
X-IronPort-AV: E=McAfee;i="6700,10204,11146"; a="19479815"
X-IronPort-AV: E=Sophos;i="6.09,241,1716274800"; 
   d="scan'208";a="19479815"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2024 07:15:29 -0700
X-CSE-ConnectionGUID: vqYs11uGRFi5zM2b8BaYqA==
X-CSE-MsgGUID: kYZNFmcmQ8O6T7ElVGVjwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,241,1716274800"; 
   d="scan'208";a="54127527"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 27 Jul 2024 07:15:27 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sXiCj-000pye-1b;
	Sat, 27 Jul 2024 14:15:25 +0000
Date: Sat, 27 Jul 2024 22:15:11 +0800
From: kernel test robot <lkp@intel.com>
To: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD REGRESSION
 7a27b0ac58abccdf46e89bea9ed9f81a496132ab
Message-ID: <202407272208.hH4u1GsC-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: 7a27b0ac58abccdf46e89bea9ed9f81a496132ab  Bluetooth: hci_event: Fix setting DISCOVERY_FINDING for passive scanning

Error/Warning ids grouped by kconfigs:

recent_errors
|-- sparc-randconfig-001-20240727
|   `-- (.head.text):relocation-truncated-to-fit:R_SPARC_WDISP22-against-init.text
`-- sparc-randconfig-002-20240727
    `-- (.head.text):relocation-truncated-to-fit:R_SPARC_WDISP22-against-init.text

elapsed time: 1406m

configs tested: 293
configs skipped: 11

tested configs:
alpha                             allnoconfig   gcc-13.3.0
alpha                            allyesconfig   gcc-13.3.0
alpha                               defconfig   gcc-13.2.0
alpha                               defconfig   gcc-13.3.0
arc                              allmodconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                              allyesconfig   gcc-13.2.0
arc                          axs103_defconfig   gcc-13.2.0
arc                                 defconfig   gcc-13.2.0
arc                   randconfig-001-20240727   gcc-13.2.0
arc                   randconfig-002-20240727   gcc-13.2.0
arc                    vdk_hs38_smp_defconfig   gcc-13.2.0
arm                              allmodconfig   gcc-13.2.0
arm                               allnoconfig   clang-20
arm                              allyesconfig   gcc-13.2.0
arm                              allyesconfig   gcc-14.1.0
arm                         assabet_defconfig   clang-15
arm                         axm55xx_defconfig   clang-20
arm                          collie_defconfig   gcc-14.1.0
arm                                 defconfig   clang-14
arm                                 defconfig   gcc-13.2.0
arm                         mv78xx0_defconfig   clang-20
arm                       omap2plus_defconfig   gcc-14.1.0
arm                          pxa168_defconfig   clang-20
arm                          pxa910_defconfig   gcc-13.2.0
arm                   randconfig-001-20240727   gcc-13.2.0
arm                   randconfig-001-20240727   gcc-14.1.0
arm                   randconfig-002-20240727   gcc-13.2.0
arm                   randconfig-002-20240727   gcc-14.1.0
arm                   randconfig-003-20240727   clang-17
arm                   randconfig-003-20240727   gcc-13.2.0
arm                   randconfig-004-20240727   gcc-13.2.0
arm                   randconfig-004-20240727   gcc-14.1.0
arm64                            allmodconfig   clang-20
arm64                            allmodconfig   gcc-13.2.0
arm64                             allnoconfig   gcc-14.1.0
arm64                               defconfig   gcc-13.2.0
arm64                               defconfig   gcc-14.1.0
arm64                 randconfig-001-20240727   clang-20
arm64                 randconfig-001-20240727   gcc-13.2.0
arm64                 randconfig-002-20240727   gcc-13.2.0
arm64                 randconfig-002-20240727   gcc-14.1.0
arm64                 randconfig-003-20240727   gcc-13.2.0
arm64                 randconfig-003-20240727   gcc-14.1.0
arm64                 randconfig-004-20240727   clang-20
arm64                 randconfig-004-20240727   gcc-13.2.0
csky                              allnoconfig   gcc-14.1.0
csky                                defconfig   gcc-13.2.0
csky                                defconfig   gcc-14.1.0
csky                  randconfig-001-20240727   gcc-13.2.0
csky                  randconfig-001-20240727   gcc-14.1.0
csky                  randconfig-002-20240727   gcc-13.2.0
csky                  randconfig-002-20240727   gcc-14.1.0
hexagon                          allmodconfig   clang-20
hexagon                           allnoconfig   clang-20
hexagon                          allyesconfig   clang-20
hexagon                             defconfig   clang-20
hexagon               randconfig-001-20240727   clang-20
hexagon               randconfig-002-20240727   clang-20
i386                             allmodconfig   clang-18
i386                             allmodconfig   gcc-13
i386                              allnoconfig   clang-18
i386                              allnoconfig   gcc-13
i386                             allyesconfig   clang-18
i386                             allyesconfig   gcc-13
i386         buildonly-randconfig-001-20240727   gcc-13
i386         buildonly-randconfig-002-20240727   clang-18
i386         buildonly-randconfig-002-20240727   gcc-13
i386         buildonly-randconfig-003-20240727   gcc-13
i386         buildonly-randconfig-003-20240727   gcc-8
i386         buildonly-randconfig-004-20240727   gcc-10
i386         buildonly-randconfig-004-20240727   gcc-13
i386         buildonly-randconfig-005-20240727   clang-18
i386         buildonly-randconfig-005-20240727   gcc-13
i386         buildonly-randconfig-006-20240727   clang-18
i386         buildonly-randconfig-006-20240727   gcc-13
i386                                defconfig   clang-18
i386                  randconfig-001-20240727   clang-18
i386                  randconfig-001-20240727   gcc-13
i386                  randconfig-002-20240727   gcc-13
i386                  randconfig-002-20240727   gcc-8
i386                  randconfig-003-20240727   clang-18
i386                  randconfig-003-20240727   gcc-13
i386                  randconfig-004-20240727   clang-18
i386                  randconfig-004-20240727   gcc-13
i386                  randconfig-005-20240727   clang-18
i386                  randconfig-005-20240727   gcc-13
i386                  randconfig-006-20240727   gcc-13
i386                  randconfig-011-20240727   gcc-13
i386                  randconfig-012-20240727   gcc-13
i386                  randconfig-013-20240727   gcc-11
i386                  randconfig-013-20240727   gcc-13
i386                  randconfig-014-20240727   gcc-13
i386                  randconfig-015-20240727   clang-18
i386                  randconfig-015-20240727   gcc-13
i386                  randconfig-016-20240727   gcc-13
i386                  randconfig-016-20240727   gcc-7
loongarch                        allmodconfig   gcc-14.1.0
loongarch                         allnoconfig   gcc-14.1.0
loongarch                           defconfig   gcc-13.2.0
loongarch                           defconfig   gcc-14.1.0
loongarch             randconfig-001-20240727   gcc-13.2.0
loongarch             randconfig-001-20240727   gcc-14.1.0
loongarch             randconfig-002-20240727   gcc-13.2.0
loongarch             randconfig-002-20240727   gcc-14.1.0
m68k                             allmodconfig   gcc-14.1.0
m68k                              allnoconfig   gcc-14.1.0
m68k                             allyesconfig   gcc-14.1.0
m68k                         amcore_defconfig   gcc-14.1.0
m68k                         apollo_defconfig   gcc-14.1.0
m68k                                defconfig   gcc-13.2.0
m68k                                defconfig   gcc-14.1.0
m68k                       m5475evb_defconfig   gcc-14.1.0
m68k                        mvme16x_defconfig   gcc-14.1.0
m68k                           sun3_defconfig   gcc-13.2.0
microblaze                       alldefconfig   gcc-14.1.0
microblaze                       allmodconfig   gcc-14.1.0
microblaze                        allnoconfig   gcc-14.1.0
microblaze                       allyesconfig   gcc-14.1.0
microblaze                          defconfig   gcc-13.2.0
microblaze                          defconfig   gcc-14.1.0
mips                              allnoconfig   gcc-14.1.0
mips                          ath79_defconfig   gcc-13.2.0
mips                          ath79_defconfig   gcc-14.1.0
mips                         bigsur_defconfig   gcc-14.1.0
mips                     loongson1b_defconfig   gcc-13.2.0
mips                malta_qemu_32r6_defconfig   gcc-13.2.0
mips                      maltasmvp_defconfig   gcc-13.2.0
nios2                             allnoconfig   gcc-14.1.0
nios2                               defconfig   gcc-13.2.0
nios2                               defconfig   gcc-14.1.0
nios2                 randconfig-001-20240727   gcc-13.2.0
nios2                 randconfig-001-20240727   gcc-14.1.0
nios2                 randconfig-002-20240727   gcc-13.2.0
nios2                 randconfig-002-20240727   gcc-14.1.0
openrisc                          allnoconfig   gcc-14.1.0
openrisc                         allyesconfig   gcc-14.1.0
openrisc                            defconfig   gcc-14.1.0
parisc                           allmodconfig   gcc-14.1.0
parisc                            allnoconfig   gcc-14.1.0
parisc                           allyesconfig   gcc-14.1.0
parisc                              defconfig   gcc-14.1.0
parisc                randconfig-001-20240727   gcc-13.2.0
parisc                randconfig-001-20240727   gcc-14.1.0
parisc                randconfig-002-20240727   gcc-13.2.0
parisc                randconfig-002-20240727   gcc-14.1.0
parisc64                            defconfig   gcc-13.2.0
parisc64                            defconfig   gcc-14.1.0
powerpc                          allmodconfig   gcc-14.1.0
powerpc                           allnoconfig   gcc-14.1.0
powerpc                          allyesconfig   clang-20
powerpc                          allyesconfig   gcc-14.1.0
powerpc                      bamboo_defconfig   gcc-13.2.0
powerpc                    ge_imp3a_defconfig   gcc-14.1.0
powerpc                       holly_defconfig   gcc-14.1.0
powerpc                     mpc5200_defconfig   gcc-14.1.0
powerpc                  mpc866_ads_defconfig   clang-20
powerpc                  mpc885_ads_defconfig   gcc-14.1.0
powerpc                    mvme5100_defconfig   gcc-13.2.0
powerpc                      pmac32_defconfig   gcc-13.2.0
powerpc                      ppc44x_defconfig   clang-16
powerpc                         ps3_defconfig   gcc-14.1.0
powerpc               randconfig-001-20240727   clang-20
powerpc               randconfig-002-20240727   gcc-14.1.0
powerpc               randconfig-003-20240727   clang-20
powerpc               randconfig-003-20240727   gcc-13.2.0
powerpc                    sam440ep_defconfig   gcc-14.1.0
powerpc                     tqm8541_defconfig   gcc-13.2.0
powerpc64             randconfig-001-20240727   clang-20
powerpc64             randconfig-001-20240727   gcc-13.2.0
powerpc64             randconfig-002-20240727   gcc-13.2.0
powerpc64             randconfig-002-20240727   gcc-14.1.0
powerpc64             randconfig-003-20240727   gcc-13.2.0
powerpc64             randconfig-003-20240727   gcc-14.1.0
riscv                            allmodconfig   gcc-14.1.0
riscv                             allnoconfig   gcc-14.1.0
riscv                            allyesconfig   clang-20
riscv                            allyesconfig   gcc-14.1.0
riscv                               defconfig   clang-20
riscv                               defconfig   gcc-14.1.0
riscv                 randconfig-001-20240727   gcc-13.2.0
riscv                 randconfig-001-20240727   gcc-14.1.0
riscv                 randconfig-002-20240727   gcc-13.2.0
riscv                 randconfig-002-20240727   gcc-14.1.0
s390                             alldefconfig   gcc-13.2.0
s390                             allmodconfig   clang-20
s390                              allnoconfig   clang-20
s390                              allnoconfig   gcc-14.1.0
s390                             allyesconfig   clang-20
s390                             allyesconfig   gcc-14.1.0
s390                                defconfig   clang-20
s390                                defconfig   gcc-14.1.0
s390                  randconfig-001-20240727   gcc-13.2.0
s390                  randconfig-001-20240727   gcc-14.1.0
s390                  randconfig-002-20240727   clang-20
s390                  randconfig-002-20240727   gcc-13.2.0
sh                               alldefconfig   gcc-14.1.0
sh                               allmodconfig   gcc-14.1.0
sh                                allnoconfig   gcc-14.1.0
sh                               allyesconfig   gcc-14.1.0
sh                                  defconfig   gcc-14.1.0
sh                        edosk7705_defconfig   gcc-14.1.0
sh                        edosk7760_defconfig   gcc-14.1.0
sh                     magicpanelr2_defconfig   gcc-13.2.0
sh                            migor_defconfig   gcc-14.1.0
sh                    randconfig-001-20240727   gcc-13.2.0
sh                    randconfig-001-20240727   gcc-14.1.0
sh                    randconfig-002-20240727   gcc-13.2.0
sh                    randconfig-002-20240727   gcc-14.1.0
sh                      rts7751r2d1_defconfig   gcc-14.1.0
sh                           se7619_defconfig   gcc-13.2.0
sh                           sh2007_defconfig   gcc-14.1.0
sh                        sh7785lcr_defconfig   gcc-14.1.0
sh                              ul2_defconfig   gcc-14.1.0
sparc                            allmodconfig   gcc-14.1.0
sparc                       sparc64_defconfig   gcc-13.2.0
sparc64                             defconfig   gcc-14.1.0
sparc64               randconfig-001-20240727   gcc-13.2.0
sparc64               randconfig-001-20240727   gcc-14.1.0
sparc64               randconfig-002-20240727   gcc-13.2.0
sparc64               randconfig-002-20240727   gcc-14.1.0
um                               allmodconfig   gcc-13.3.0
um                                allnoconfig   clang-17
um                                allnoconfig   gcc-14.1.0
um                               allyesconfig   gcc-13
um                               allyesconfig   gcc-13.3.0
um                                  defconfig   clang-20
um                                  defconfig   gcc-14.1.0
um                             i386_defconfig   gcc-13
um                             i386_defconfig   gcc-14.1.0
um                    randconfig-001-20240727   gcc-13
um                    randconfig-001-20240727   gcc-13.2.0
um                    randconfig-002-20240727   gcc-13
um                    randconfig-002-20240727   gcc-13.2.0
um                           x86_64_defconfig   clang-15
um                           x86_64_defconfig   gcc-14.1.0
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240727   gcc-8
x86_64       buildonly-randconfig-002-20240727   gcc-13
x86_64       buildonly-randconfig-002-20240727   gcc-8
x86_64       buildonly-randconfig-003-20240727   gcc-13
x86_64       buildonly-randconfig-003-20240727   gcc-8
x86_64       buildonly-randconfig-004-20240727   gcc-13
x86_64       buildonly-randconfig-004-20240727   gcc-8
x86_64       buildonly-randconfig-005-20240727   clang-18
x86_64       buildonly-randconfig-005-20240727   gcc-8
x86_64       buildonly-randconfig-006-20240727   gcc-13
x86_64       buildonly-randconfig-006-20240727   gcc-8
x86_64                              defconfig   clang-18
x86_64                              defconfig   gcc-13
x86_64                randconfig-001-20240727   gcc-13
x86_64                randconfig-001-20240727   gcc-8
x86_64                randconfig-002-20240727   clang-18
x86_64                randconfig-002-20240727   gcc-8
x86_64                randconfig-003-20240727   clang-18
x86_64                randconfig-003-20240727   gcc-8
x86_64                randconfig-004-20240727   clang-18
x86_64                randconfig-004-20240727   gcc-8
x86_64                randconfig-005-20240727   gcc-13
x86_64                randconfig-005-20240727   gcc-8
x86_64                randconfig-006-20240727   clang-18
x86_64                randconfig-006-20240727   gcc-8
x86_64                randconfig-011-20240727   gcc-13
x86_64                randconfig-011-20240727   gcc-8
x86_64                randconfig-012-20240727   gcc-13
x86_64                randconfig-012-20240727   gcc-8
x86_64                randconfig-013-20240727   clang-18
x86_64                randconfig-013-20240727   gcc-8
x86_64                randconfig-014-20240727   gcc-10
x86_64                randconfig-014-20240727   gcc-8
x86_64                randconfig-015-20240727   gcc-12
x86_64                randconfig-015-20240727   gcc-8
x86_64                randconfig-016-20240727   gcc-10
x86_64                randconfig-016-20240727   gcc-8
x86_64                randconfig-071-20240727   gcc-13
x86_64                randconfig-071-20240727   gcc-8
x86_64                randconfig-072-20240727   gcc-13
x86_64                randconfig-072-20240727   gcc-8
x86_64                randconfig-073-20240727   gcc-8
x86_64                randconfig-074-20240727   gcc-8
x86_64                randconfig-075-20240727   clang-18
x86_64                randconfig-075-20240727   gcc-8
x86_64                randconfig-076-20240727   clang-18
x86_64                randconfig-076-20240727   gcc-8
x86_64                          rhel-8.3-rust   clang-18
xtensa                            allnoconfig   gcc-14.1.0
xtensa                  cadence_csp_defconfig   gcc-13.2.0
xtensa                generic_kc705_defconfig   gcc-13.2.0
xtensa                randconfig-001-20240727   gcc-13.2.0
xtensa                randconfig-001-20240727   gcc-14.1.0
xtensa                randconfig-002-20240727   gcc-13.2.0
xtensa                randconfig-002-20240727   gcc-14.1.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
