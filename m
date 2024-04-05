Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B0A171649
	for <linux-bluetooth@vger.kernel.org>; Fri,  5 Apr 2024 16:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712336219; cv=none; b=JEKJzO6BPQnNe+eBsA7r+KDCsn4m+ptX9PuKwei5hv08H0R9whPLWOOJTdAFE59+0uso5Y56GY8f2enLVjBGR2iiz7rXVpxYRPnrKIIAZFKUreXCr/s1q71nEvb7+I30xADMCEc67K/gYrB20Zhu5GT+DsvrTRY/mYJqNSI091U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712336219; c=relaxed/simple;
	bh=M3xLPpGiyFhK2Lg9NQ4SEIvf6EKqcYf1QlOKrVmU8Dw=;
	h=Date:From:To:Cc:Subject:Message-ID; b=n5eV0TuzHxZFOYTsiqtdFtkM9xa+buQodc9hiTuTRFT0HhGvE/NM6UF9mujTz1GvLu6CyhHyx0KX/UFl5EsJ4zw26HJkupN7vSSIFf8hpx47NeFaiPLu1jo5l0uFWIH6oWR6/8BmRjLytfeWIVLOxyCopfaAPLbt/8eaebE7CNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dCcOJ+Qf; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dCcOJ+Qf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712336217; x=1743872217;
  h=date:from:to:cc:subject:message-id;
  bh=M3xLPpGiyFhK2Lg9NQ4SEIvf6EKqcYf1QlOKrVmU8Dw=;
  b=dCcOJ+Qf3V04ulue+M3Ik7i0lDEaExC2Ojk+Zik5Urfmli86e2FNsoYl
   jVc2TISQ6Bt9vOdX/YmY0kR3Y5pvZoMHLp6UYgH1j3UmWWWCj9tv3r9Lc
   cPGpV2YBK6E4OuAZZq2wXWGG7OpzWnOagOiNVq7LsdPCKLGFpa1qUV61r
   kO4XP2ckLHYH5dFHF7tRmgdz4tEGvjdTNGnypliYv3iNv4Q3pVPfv9NxS
   Uyk+VkqIUKLBzM1t2oAaEEuZJJJu/Jop6+egSHFtex+ere+NPWNIvXZJ/
   AVln96eHipQilKj/2Gcj/XG3K7snaCuTWg1BShm/2PpnOMe66MLgvL427
   Q==;
X-CSE-ConnectionGUID: y9HXkmgFQVGDWRkhFzv34A==
X-CSE-MsgGUID: PuMwA37lSSqFARsJMEE6zg==
X-IronPort-AV: E=McAfee;i="6600,9927,11035"; a="10645207"
X-IronPort-AV: E=Sophos;i="6.07,181,1708416000"; 
   d="scan'208";a="10645207"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2024 09:56:56 -0700
X-CSE-ConnectionGUID: r8zMbB16RkeZw1YktjNn9w==
X-CSE-MsgGUID: ieJUcaR7SHWeE2tKPz8j2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,181,1708416000"; 
   d="scan'208";a="19244512"
Received: from lkp-server01.sh.intel.com (HELO e61807b1d151) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 05 Apr 2024 09:56:54 -0700
Received: from kbuild by e61807b1d151 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rsms0-0002Wk-34;
	Fri, 05 Apr 2024 16:56:52 +0000
Date: Sat, 06 Apr 2024 00:56:26 +0800
From: kernel test robot <lkp@intel.com>
To: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 54b53156ad3667aa51be8d44f3fbb4731e8518f4
Message-ID: <202404060024.jUvoyqHx-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: 54b53156ad3667aa51be8d44f3fbb4731e8518f4  Bluetooth: hci_intel: Fix multiple issues reported by checkpatch.pl

elapsed time: 1466m

configs tested: 173
configs skipped: 7

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
arc                        nsim_700_defconfig   gcc  
arc                   randconfig-001-20240405   gcc  
arc                   randconfig-002-20240405   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                            hisi_defconfig   gcc  
arm                           imxrt_defconfig   clang
arm                             mxs_defconfig   clang
arm                   randconfig-001-20240405   gcc  
arm                   randconfig-002-20240405   clang
arm                   randconfig-003-20240405   gcc  
arm                   randconfig-004-20240405   clang
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240405   gcc  
arm64                 randconfig-002-20240405   gcc  
arm64                 randconfig-003-20240405   gcc  
arm64                 randconfig-004-20240405   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240405   gcc  
csky                  randconfig-002-20240405   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240405   clang
hexagon               randconfig-002-20240405   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240405   gcc  
i386         buildonly-randconfig-002-20240405   gcc  
i386         buildonly-randconfig-003-20240405   clang
i386         buildonly-randconfig-004-20240405   gcc  
i386         buildonly-randconfig-005-20240405   clang
i386         buildonly-randconfig-006-20240405   clang
i386                                defconfig   clang
i386                  randconfig-001-20240405   clang
i386                  randconfig-002-20240405   gcc  
i386                  randconfig-003-20240405   clang
i386                  randconfig-004-20240405   clang
i386                  randconfig-005-20240405   clang
i386                  randconfig-006-20240405   gcc  
i386                  randconfig-011-20240405   clang
i386                  randconfig-012-20240405   gcc  
i386                  randconfig-013-20240405   gcc  
i386                  randconfig-014-20240405   gcc  
i386                  randconfig-015-20240405   gcc  
i386                  randconfig-016-20240405   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240405   gcc  
loongarch             randconfig-002-20240405   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                            gpr_defconfig   clang
mips                malta_qemu_32r6_defconfig   gcc  
mips                           xway_defconfig   clang
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240405   gcc  
nios2                 randconfig-002-20240405   gcc  
openrisc                          allnoconfig   gcc  
openrisc                            defconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                              defconfig   gcc  
parisc                generic-32bit_defconfig   gcc  
parisc                randconfig-001-20240405   gcc  
parisc                randconfig-002-20240405   gcc  
parisc64                            defconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                    ge_imp3a_defconfig   gcc  
powerpc                     powernv_defconfig   gcc  
powerpc               randconfig-001-20240405   clang
powerpc               randconfig-002-20240405   clang
powerpc               randconfig-003-20240405   clang
powerpc64             randconfig-001-20240405   gcc  
powerpc64             randconfig-002-20240405   gcc  
powerpc64             randconfig-003-20240405   clang
riscv                             allnoconfig   gcc  
riscv                               defconfig   clang
riscv                 randconfig-001-20240405   clang
riscv                 randconfig-002-20240405   gcc  
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                          debug_defconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240405   clang
s390                  randconfig-002-20240405   gcc  
s390                       zfcpdump_defconfig   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                             espt_defconfig   gcc  
sh                            hp6xx_defconfig   gcc  
sh                    randconfig-001-20240405   gcc  
sh                    randconfig-002-20240405   gcc  
sh                          sdk7786_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240405   gcc  
sparc64               randconfig-002-20240405   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240405   gcc  
um                    randconfig-002-20240405   clang
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240405   clang
x86_64       buildonly-randconfig-002-20240405   clang
x86_64       buildonly-randconfig-003-20240405   gcc  
x86_64       buildonly-randconfig-004-20240405   gcc  
x86_64       buildonly-randconfig-005-20240405   clang
x86_64       buildonly-randconfig-006-20240405   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240405   clang
x86_64                randconfig-002-20240405   clang
x86_64                randconfig-003-20240405   clang
x86_64                randconfig-004-20240405   gcc  
x86_64                randconfig-005-20240405   clang
x86_64                randconfig-006-20240405   gcc  
x86_64                randconfig-011-20240405   clang
x86_64                randconfig-012-20240405   gcc  
x86_64                randconfig-013-20240405   gcc  
x86_64                randconfig-014-20240405   clang
x86_64                randconfig-015-20240405   gcc  
x86_64                randconfig-016-20240405   gcc  
x86_64                randconfig-071-20240405   gcc  
x86_64                randconfig-072-20240405   gcc  
x86_64                randconfig-073-20240405   gcc  
x86_64                randconfig-074-20240405   gcc  
x86_64                randconfig-075-20240405   gcc  
x86_64                randconfig-076-20240405   gcc  
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                  nommu_kc705_defconfig   gcc  
xtensa                randconfig-001-20240405   gcc  
xtensa                randconfig-002-20240405   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
