Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B9F81741
	for <linux-bluetooth@vger.kernel.org>; Thu,  9 May 2024 23:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715298212; cv=none; b=R/gaVDOhgImHDnDVwyDT4b21O24PYW81z81SnoPuCR2FZ8/AjrCGSEUNq5XzdyAkCg0tomZNjt+Q6DjpjsnVkTSBPbQlgO+m7sGYh7j26SJh74H/EAKsVw//Oek6vmWuDlu3B+motWgNM+Lb81Ng6hd5NHHX7LwIrpRqKBDQkP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715298212; c=relaxed/simple;
	bh=A7P8fatkeY67vdzb7jyzy+k6TfJjdjp9+1Eh66evMV4=;
	h=Date:From:To:Cc:Subject:Message-ID; b=ZyYdDf6LYYqupKoVpu7UgNWGmHyH9EXDULU9rrZu/i6F1uW3Wh7Ctu4lfsbO40kflXtinYTiOrKmcxIsBJXUJWl63+aBvGLdQtpqUzBVeNoEIJ6tXFv+hMRTpyO4jBhVufU53Wj3eSxCUqZizGO/uoJK9q7LuNX9aveqTI1E0bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Mnz6n1cW; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Mnz6n1cW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715298211; x=1746834211;
  h=date:from:to:cc:subject:message-id;
  bh=A7P8fatkeY67vdzb7jyzy+k6TfJjdjp9+1Eh66evMV4=;
  b=Mnz6n1cW3htpK07BHlHfaqqlZs5ofZdAcDZGTFDWDglubGNsLBFNQiTX
   Ah2YNDZwmQzeOCqdeplBJKs2xvUschV+uz+fZdla0vNlJGBu9ayCb6a4U
   Dxi8JLswypuMJqh8k4cSmkn/wS26qWcKqazx+PwiBIFQAHNOteRZkAndW
   BvnfAfZ9eaA1dZ3tFomDQNVZ1Dzk/VMk4IQB+I4dKZUc9q43mvTELdfYE
   PStf2v7WKoPcUAdUMHz5es1Lx0vdx1QydvRPZDLIFJck+tRKgdbTYzgKp
   +Nx7TssKiDRexQCkrtfPoBuuGZh8yN94TNB8ZkvQH35IP0uNuzuv7Nnia
   A==;
X-CSE-ConnectionGUID: LItvvj14QI6c4Hffs6DxNA==
X-CSE-MsgGUID: vJo/qUXJQQCjom4nu9V0uw==
X-IronPort-AV: E=McAfee;i="6600,9927,11068"; a="21852286"
X-IronPort-AV: E=Sophos;i="6.08,149,1712646000"; 
   d="scan'208";a="21852286"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2024 16:43:30 -0700
X-CSE-ConnectionGUID: ninE/7ohQp+aGAAXaOuKdQ==
X-CSE-MsgGUID: QGqNYNidTIWS+35GbNzpLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,149,1712646000"; 
   d="scan'208";a="60590833"
Received: from lkp-server01.sh.intel.com (HELO f8b243fe6e68) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 09 May 2024 16:43:29 -0700
Received: from kbuild by f8b243fe6e68 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s5DQ6-0005V3-3A;
	Thu, 09 May 2024 23:43:26 +0000
Date: Fri, 10 May 2024 07:43:05 +0800
From: kernel test robot <lkp@intel.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Linux Memory Management List <linux-mm@kvack.org>,
 linux-bluetooth@vger.kernel.org
Subject: [linux-next:pending-fixes] BUILD SUCCESS
 e84b53c411b51bc97acac760c3624d626e5a05a9
Message-ID: <202405100702.P6NsKoNA-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git pending-fixes
branch HEAD: e84b53c411b51bc97acac760c3624d626e5a05a9  Merge branch 'for-linux-next-fixes' of https://gitlab.freedesktop.org/drm/misc/kernel.git

Warning ids grouped by kconfigs:

clang_recent_errors
`-- x86_64-randconfig-104-20240510
    `-- net-bluetooth-l2cap_core.c:preceding-lock-on-line

elapsed time: 1448m

configs tested: 158
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
arc                      axs103_smp_defconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20240510   gcc  
arc                   randconfig-002-20240510   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                        mvebu_v5_defconfig   gcc  
arm                           omap1_defconfig   gcc  
arm                   randconfig-001-20240510   gcc  
arm                   randconfig-002-20240510   clang
arm                   randconfig-003-20240510   gcc  
arm                   randconfig-004-20240510   gcc  
arm                           stm32_defconfig   gcc  
arm                         wpcm450_defconfig   gcc  
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240510   clang
arm64                 randconfig-002-20240510   gcc  
arm64                 randconfig-003-20240510   clang
arm64                 randconfig-004-20240510   clang
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240510   gcc  
csky                  randconfig-002-20240510   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240510   clang
hexagon               randconfig-002-20240510   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240509   gcc  
i386         buildonly-randconfig-002-20240509   gcc  
i386         buildonly-randconfig-003-20240509   clang
i386         buildonly-randconfig-004-20240509   clang
i386         buildonly-randconfig-005-20240509   gcc  
i386         buildonly-randconfig-006-20240509   gcc  
i386                                defconfig   clang
i386                  randconfig-001-20240509   clang
i386                  randconfig-002-20240509   clang
i386                  randconfig-003-20240509   clang
i386                  randconfig-004-20240509   gcc  
i386                  randconfig-005-20240509   clang
i386                  randconfig-006-20240509   gcc  
i386                  randconfig-011-20240509   clang
i386                  randconfig-012-20240509   gcc  
i386                  randconfig-013-20240509   clang
i386                  randconfig-014-20240509   gcc  
i386                  randconfig-015-20240509   gcc  
i386                  randconfig-016-20240509   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240510   gcc  
loongarch             randconfig-002-20240510   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                        m5307c3_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                     decstation_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240510   gcc  
nios2                 randconfig-002-20240510   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240510   gcc  
parisc                randconfig-002-20240510   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                 canyonlands_defconfig   clang
powerpc                      cm5200_defconfig   clang
powerpc                      ppc40x_defconfig   clang
powerpc               randconfig-001-20240510   gcc  
powerpc               randconfig-002-20240510   gcc  
powerpc               randconfig-003-20240510   clang
powerpc                      walnut_defconfig   gcc  
powerpc64             randconfig-001-20240510   clang
powerpc64             randconfig-002-20240510   clang
powerpc64             randconfig-003-20240510   clang
riscv                             allnoconfig   gcc  
riscv                               defconfig   clang
riscv                 randconfig-001-20240510   clang
riscv                 randconfig-002-20240510   clang
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240510   gcc  
s390                  randconfig-002-20240510   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                        dreamcast_defconfig   gcc  
sh                    randconfig-001-20240510   gcc  
sh                    randconfig-002-20240510   gcc  
sh                           se7750_defconfig   gcc  
sh                   secureedge5410_defconfig   gcc  
sh                        sh7757lcr_defconfig   gcc  
sh                            titan_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240510   gcc  
sparc64               randconfig-002-20240510   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240510   gcc  
um                    randconfig-002-20240510   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240510   gcc  
x86_64       buildonly-randconfig-002-20240510   clang
x86_64       buildonly-randconfig-003-20240510   gcc  
x86_64       buildonly-randconfig-004-20240510   clang
x86_64       buildonly-randconfig-005-20240510   gcc  
x86_64       buildonly-randconfig-006-20240510   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240510   gcc  
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                randconfig-001-20240510   gcc  
xtensa                randconfig-002-20240510   gcc  
xtensa                         virt_defconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
