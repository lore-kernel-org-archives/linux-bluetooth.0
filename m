Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F1B94E1BA
	for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jan 2024 19:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eMUYu+X+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704914723; x=1736450723;
  h=date:from:to:cc:subject:message-id;
  bh=ond3JqippRh50PYGIRnvXfeozzlLBiXTgvjwobdgN6w=;
  b=eMUYu+X+TChVqb9Vdl7MsX2dZXhfqiYJ7qkAIzMWM0lU2NsAhkwWYWWa
   BJWr2NBMH8W/HFjx9KVeglnmSJZz7qnO3dJXnDnWG3P7OjbErG0ukXTLE
   WCngURZfEjyVHm7AI3GdB4qrc52B/LlP6KljDFA54270/7kKa/jsgEWii
   ZMvlX/azfxFJwMwb69gfGFZXilBZ/Gf9YZ12lWQ3JR+Y96dQ/rfEWoiP/
   hqQWvyS+hooxTo4BE+Chds868v5olo6CJ8CcYAF5EwvyTWWy4wkVRYVdI
   ks+FA9Ug/za0wUUVYIVVTotRWWp9Mc44ZU99w3UfaM6B9PSn/Hcz/7TLQ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10949"; a="17221110"
X-IronPort-AV: E=Sophos;i="6.04,184,1695711600"; 
   d="scan'208";a="17221110"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2024 11:25:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10949"; a="872754148"
X-IronPort-AV: E=Sophos;i="6.04,184,1695711600"; 
   d="scan'208";a="872754148"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 10 Jan 2024 11:25:21 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rNeCV-0007Pc-1G;
	Wed, 10 Jan 2024 19:25:19 +0000
Date: Thu, 11 Jan 2024 03:25:04 +0800
From: kernel test robot <lkp@intel.com>
To: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 f8c47ee39e6dc6170da06865b84e8c8b08e87ab0
Message-ID: <202401110302.beVLJW4x-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: f8c47ee39e6dc6170da06865b84e8c8b08e87ab0  Bluetooth: hci_event: Use HCI error defines instead of magic values

elapsed time: 1451m

configs tested: 150
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
arc                   randconfig-001-20240110   gcc  
arc                   randconfig-002-20240110   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                          collie_defconfig   clang
arm                                 defconfig   clang
arm                            mmp2_defconfig   clang
arm                         orion5x_defconfig   clang
arm                          pxa910_defconfig   gcc  
arm                   randconfig-001-20240110   clang
arm                   randconfig-002-20240110   clang
arm                   randconfig-003-20240110   clang
arm                   randconfig-004-20240110   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240110   clang
arm64                 randconfig-002-20240110   clang
arm64                 randconfig-003-20240110   clang
arm64                 randconfig-004-20240110   clang
csky                              allnoconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240110   gcc  
csky                  randconfig-002-20240110   gcc  
hexagon                           allnoconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240110   clang
hexagon               randconfig-002-20240110   clang
i386                             allmodconfig   clang
i386                              allnoconfig   clang
i386                             allyesconfig   clang
i386         buildonly-randconfig-001-20240110   clang
i386         buildonly-randconfig-002-20240110   clang
i386         buildonly-randconfig-003-20240110   clang
i386         buildonly-randconfig-004-20240110   clang
i386         buildonly-randconfig-005-20240110   clang
i386         buildonly-randconfig-006-20240110   clang
i386                                defconfig   gcc  
i386                  randconfig-001-20240110   clang
i386                  randconfig-002-20240110   clang
i386                  randconfig-003-20240110   clang
i386                  randconfig-004-20240110   clang
i386                  randconfig-005-20240110   clang
i386                  randconfig-006-20240110   clang
i386                  randconfig-011-20240110   gcc  
i386                  randconfig-012-20240110   gcc  
i386                  randconfig-013-20240110   gcc  
i386                  randconfig-014-20240110   gcc  
i386                  randconfig-015-20240110   gcc  
i386                  randconfig-016-20240110   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240110   gcc  
loongarch             randconfig-002-20240110   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                         amcore_defconfig   gcc  
m68k                                defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   clang
mips                             allyesconfig   gcc  
mips                     cu1000-neo_defconfig   clang
mips                     loongson1c_defconfig   clang
mips                     loongson2k_defconfig   gcc  
mips                        qi_lb60_defconfig   clang
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240110   gcc  
nios2                 randconfig-002-20240110   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240110   gcc  
parisc                randconfig-002-20240110   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   clang
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc               randconfig-001-20240110   clang
powerpc               randconfig-002-20240110   clang
powerpc               randconfig-003-20240110   clang
powerpc64             randconfig-001-20240110   clang
powerpc64             randconfig-002-20240110   clang
powerpc64             randconfig-003-20240110   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   clang
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                 randconfig-001-20240110   clang
riscv                 randconfig-002-20240110   clang
riscv                          rv32_defconfig   clang
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20240110   gcc  
s390                  randconfig-002-20240110   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                    randconfig-001-20240110   gcc  
sh                    randconfig-002-20240110   gcc  
sparc                            allmodconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240110   gcc  
sparc64               randconfig-002-20240110   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                    randconfig-001-20240110   clang
um                    randconfig-002-20240110   clang
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240110   clang
x86_64       buildonly-randconfig-002-20240110   clang
x86_64       buildonly-randconfig-003-20240110   clang
x86_64       buildonly-randconfig-004-20240110   clang
x86_64       buildonly-randconfig-005-20240110   clang
x86_64       buildonly-randconfig-006-20240110   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240110   gcc  
x86_64                randconfig-002-20240110   gcc  
x86_64                randconfig-003-20240110   gcc  
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                randconfig-001-20240110   gcc  
xtensa                randconfig-002-20240110   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
