Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SPMy0q2O"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A2461AD
	for <linux-bluetooth@vger.kernel.org>; Sat,  9 Dec 2023 08:16:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702138613; x=1733674613;
  h=date:from:to:cc:subject:message-id;
  bh=wPrdWlgS7e3sCie8457N31lcKE4SJgIUpu64zZpi6Qk=;
  b=SPMy0q2O5QAaEh+v7eB78vNhuqIKqfxdMhuwc1rltZEiVexJiWnlbDsP
   ojykH7H6IbiS+J+GE8VCOuaYiS6vwd7oR7VtMhW1+GdXqph9OIDmLBaFH
   CQflHXgE2T2qMrcxRlVEPoQkAw9I5Qu1mcLHa/XECD48jmoDgCOCsdqOA
   qwoqzc8mLqqNBn7l1pRrQmFbo8oq+g4wOtI/N4IaK9idnM/VJfDZ/8RMp
   HXxtJUs7eMwn9OszWT8cerUeaCnjeV3K8DPsoA1YnN9wVBY3ApnZK+e2e
   G3nljibQ7jcHP0wmgdx6tKEur/U+bRP7IFxyhPUvlCXW7StMbkb/ul5iM
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10919"; a="398379566"
X-IronPort-AV: E=Sophos;i="6.04,263,1695711600"; 
   d="scan'208";a="398379566"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2023 08:16:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,263,1695711600"; 
   d="scan'208";a="13819373"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orviesa002.jf.intel.com with ESMTP; 09 Dec 2023 08:16:47 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rC00Q-000FaN-0w;
	Sat, 09 Dec 2023 16:16:42 +0000
Date: Sun, 10 Dec 2023 00:16:04 +0800
From: kernel test robot <lkp@intel.com>
To: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 3d41844703fe3ceffa5249ee556cf39191f95c7b
Message-ID: <202312100002.WIWQOzWg-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: 3d41844703fe3ceffa5249ee556cf39191f95c7b  Bluetooth: qca: Support HFP offload for QCA2066

elapsed time: 1487m

configs tested: 139
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                         haps_hs_defconfig   gcc  
arc                   randconfig-001-20231209   gcc  
arc                   randconfig-002-20231209   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                        mvebu_v5_defconfig   clang
arm                   randconfig-001-20231209   gcc  
arm                   randconfig-002-20231209   gcc  
arm                   randconfig-003-20231209   gcc  
arm                   randconfig-004-20231209   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20231209   gcc  
arm64                 randconfig-002-20231209   gcc  
arm64                 randconfig-003-20231209   gcc  
arm64                 randconfig-004-20231209   gcc  
csky                              allnoconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20231209   gcc  
csky                  randconfig-002-20231209   gcc  
hexagon                           allnoconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20231209   clang
hexagon               randconfig-002-20231209   clang
i386                             allmodconfig   clang
i386                              allnoconfig   clang
i386                             allyesconfig   clang
i386         buildonly-randconfig-001-20231209   gcc  
i386         buildonly-randconfig-002-20231209   gcc  
i386         buildonly-randconfig-003-20231209   gcc  
i386         buildonly-randconfig-004-20231209   gcc  
i386         buildonly-randconfig-005-20231209   gcc  
i386         buildonly-randconfig-006-20231209   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20231209   gcc  
i386                  randconfig-002-20231209   gcc  
i386                  randconfig-003-20231209   gcc  
i386                  randconfig-004-20231209   gcc  
i386                  randconfig-005-20231209   gcc  
i386                  randconfig-006-20231209   gcc  
i386                  randconfig-011-20231209   clang
i386                  randconfig-012-20231209   clang
i386                  randconfig-013-20231209   clang
i386                  randconfig-014-20231209   clang
i386                  randconfig-015-20231209   clang
i386                  randconfig-016-20231209   clang
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20231209   gcc  
loongarch             randconfig-002-20231209   gcc  
m68k                              allnoconfig   gcc  
m68k                                defconfig   gcc  
m68k                        m5272c3_defconfig   gcc  
m68k                       m5475evb_defconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   clang
mips                     cu1000-neo_defconfig   clang
mips                           gcw0_defconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20231209   gcc  
nios2                 randconfig-002-20231209   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
openrisc                 simple_smp_defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20231209   gcc  
parisc                randconfig-002-20231209   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   clang
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                       ebony_defconfig   clang
powerpc                  iss476-smp_defconfig   gcc  
powerpc                  mpc866_ads_defconfig   clang
powerpc                      ppc6xx_defconfig   gcc  
powerpc               randconfig-001-20231209   gcc  
powerpc               randconfig-002-20231209   gcc  
powerpc               randconfig-003-20231209   gcc  
powerpc                     taishan_defconfig   gcc  
powerpc64             randconfig-001-20231209   gcc  
powerpc64             randconfig-002-20231209   gcc  
powerpc64             randconfig-003-20231209   gcc  
riscv                             allnoconfig   clang
riscv                               defconfig   gcc  
riscv                 randconfig-001-20231209   gcc  
riscv                 randconfig-002-20231209   gcc  
s390                             alldefconfig   clang
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20231209   clang
s390                  randconfig-002-20231209   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                     magicpanelr2_defconfig   gcc  
sh                    randconfig-001-20231209   gcc  
sh                    randconfig-002-20231209   gcc  
sh                           se7705_defconfig   gcc  
sh                        sh7763rdp_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20231209   gcc  
sparc64               randconfig-002-20231209   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                    randconfig-001-20231209   gcc  
um                    randconfig-002-20231209   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   clang
x86_64                              defconfig   gcc  
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                randconfig-001-20231209   gcc  
xtensa                randconfig-002-20231209   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
