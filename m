Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48359D26A
	for <linux-bluetooth@vger.kernel.org>; Sun, 17 Mar 2024 06:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710657017; cv=none; b=XYyFKMlWyBE62fGyM8YHRxL/zuK6UkbL6/mtzJD/KGm/jcAGviX/Am9+PkCkzJJi8u/yVF/wEEupvP/JAxcffprCXC2l2mV0FtPusri1129V/p1ubvtzBdxaLBVHm1CpknDw1tJFxp4TaZsX5IvCGyiYiUFUEssUcYtY+fVqfPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710657017; c=relaxed/simple;
	bh=7+dBZUYxZwqluFYWJXjI3vdVyegNn09WVjSvqlmCKeg=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Wgwtxa7pw2NBxWhYkXJMVwsoYP02j9S7Xa3sFiTCbXPh4jUl51YBOpy5d57I6W6dPQsHby/cYVunyvujKmvPh7zQAkeG5XKsAdScYrVcHdJ3E/mFcXHHlMQCTGLFh2Cko3UOqcrwlImPutg+F7fMdxURNSGuRJN1kkciYiEI6Eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GSZVHYSn; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GSZVHYSn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710657015; x=1742193015;
  h=date:from:to:cc:subject:message-id;
  bh=7+dBZUYxZwqluFYWJXjI3vdVyegNn09WVjSvqlmCKeg=;
  b=GSZVHYSn7+6W8TjeQcOrZLSO33vXvQp2EqAVY+C1XhruQ1+AF+AiyMen
   DZ4Rfh8EW+kWToAER7hddTpL3rYmyEIFWSzOXCGrBqefs2f5g9cxDr+Ye
   jlDbNWAkZIY7RNcrk81PeZ68LgYE/4+S8JnxRRUlGX2pOlXp9UZ4ZrsVz
   +SFlFzXg68xr4R6J7udGJXYRvNP1lLlNG2hnKSOttpRa7IoeC37GBaFOf
   aRqsCoxS4S0vnFDs5BIaUjsMJFGXnsTLN8mlsc5aXisHj8r0gkrvAAGa0
   t55ioDqoek91fdSijyrFjVV675Q6BX7hp/Ay39U+VR2D/nw6Iw78oBsMV
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11015"; a="6089539"
X-IronPort-AV: E=Sophos;i="6.07,132,1708416000"; 
   d="scan'208";a="6089539"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2024 23:30:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,132,1708416000"; 
   d="scan'208";a="17834514"
Received: from lkp-server01.sh.intel.com (HELO b21307750695) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 16 Mar 2024 23:30:13 -0700
Received: from kbuild by b21307750695 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rlk26-000G4X-2e;
	Sun, 17 Mar 2024 06:30:10 +0000
Date: Sun, 17 Mar 2024 14:30:05 +0800
From: kernel test robot <lkp@intel.com>
To: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 f4a0fc6780c7c1583133a9b8f10d76f769e41d34
Message-ID: <202403171401.kfjzPlTp-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: f4a0fc6780c7c1583133a9b8f10d76f769e41d34  Bluetooth: Add support for MediaTek MT7922 device

elapsed time: 723m

configs tested: 178
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                          axs101_defconfig   gcc  
arc                                 defconfig   gcc  
arc                         haps_hs_defconfig   gcc  
arc                     haps_hs_smp_defconfig   gcc  
arc                   randconfig-001-20240317   gcc  
arc                   randconfig-002-20240317   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                         assabet_defconfig   clang
arm                                 defconfig   clang
arm                           imxrt_defconfig   clang
arm                   randconfig-001-20240317   clang
arm                   randconfig-002-20240317   clang
arm                   randconfig-003-20240317   gcc  
arm                   randconfig-004-20240317   clang
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240317   clang
arm64                 randconfig-002-20240317   gcc  
arm64                 randconfig-003-20240317   gcc  
arm64                 randconfig-004-20240317   clang
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240317   gcc  
csky                  randconfig-002-20240317   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240317   clang
hexagon               randconfig-002-20240317   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240317   gcc  
i386         buildonly-randconfig-002-20240317   clang
i386         buildonly-randconfig-003-20240317   gcc  
i386         buildonly-randconfig-004-20240317   clang
i386         buildonly-randconfig-005-20240317   clang
i386         buildonly-randconfig-006-20240317   gcc  
i386                                defconfig   clang
i386                  randconfig-001-20240317   clang
i386                  randconfig-002-20240317   clang
i386                  randconfig-003-20240317   clang
i386                  randconfig-004-20240317   clang
i386                  randconfig-005-20240317   gcc  
i386                  randconfig-006-20240317   gcc  
i386                  randconfig-011-20240317   clang
i386                  randconfig-012-20240317   clang
i386                  randconfig-013-20240317   clang
i386                  randconfig-014-20240317   gcc  
i386                  randconfig-015-20240317   gcc  
i386                  randconfig-016-20240317   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240317   gcc  
loongarch             randconfig-002-20240317   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                        mvme147_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                           jazz_defconfig   clang
mips                      loongson3_defconfig   gcc  
mips                malta_qemu_32r6_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240317   gcc  
nios2                 randconfig-002-20240317   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240317   gcc  
parisc                randconfig-002-20240317   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                  mpc866_ads_defconfig   clang
powerpc                      ppc6xx_defconfig   gcc  
powerpc               randconfig-001-20240317   clang
powerpc               randconfig-002-20240317   gcc  
powerpc               randconfig-003-20240317   clang
powerpc64             randconfig-001-20240317   gcc  
powerpc64             randconfig-002-20240317   clang
powerpc64             randconfig-003-20240317   clang
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240317   clang
riscv                 randconfig-002-20240317   clang
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240317   clang
s390                  randconfig-002-20240317   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                        edosk7705_defconfig   gcc  
sh                               j2_defconfig   gcc  
sh                    randconfig-001-20240317   gcc  
sh                    randconfig-002-20240317   gcc  
sh                          rsk7201_defconfig   gcc  
sh                           se7712_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240317   gcc  
sparc64               randconfig-002-20240317   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240317   gcc  
um                    randconfig-002-20240317   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240317   gcc  
x86_64       buildonly-randconfig-002-20240317   gcc  
x86_64       buildonly-randconfig-003-20240317   gcc  
x86_64       buildonly-randconfig-004-20240317   clang
x86_64       buildonly-randconfig-005-20240317   gcc  
x86_64       buildonly-randconfig-006-20240317   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240317   gcc  
x86_64                randconfig-002-20240317   gcc  
x86_64                randconfig-003-20240317   gcc  
x86_64                randconfig-004-20240317   gcc  
x86_64                randconfig-005-20240317   gcc  
x86_64                randconfig-006-20240317   clang
x86_64                randconfig-011-20240317   clang
x86_64                randconfig-012-20240317   gcc  
x86_64                randconfig-013-20240317   clang
x86_64                randconfig-014-20240317   clang
x86_64                randconfig-015-20240317   gcc  
x86_64                randconfig-016-20240317   clang
x86_64                randconfig-071-20240317   gcc  
x86_64                randconfig-072-20240317   clang
x86_64                randconfig-073-20240317   clang
x86_64                randconfig-074-20240317   gcc  
x86_64                randconfig-075-20240317   gcc  
x86_64                randconfig-076-20240317   clang
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                  cadence_csp_defconfig   gcc  
xtensa                       common_defconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
