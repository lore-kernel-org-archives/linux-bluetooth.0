Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E97BED2E2
	for <linux-bluetooth@vger.kernel.org>; Sun, 24 Dec 2023 19:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m/voCozC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703444487; x=1734980487;
  h=date:from:to:cc:subject:message-id;
  bh=RiRPEq9BQmgKuRE+wyq6mfMYPq3lpadzlR/sQI7SpkE=;
  b=m/voCozCkpJDfypdep617co3aMB+xasTAlnQtPsWVQU+pdmBKS+lucQ1
   IpYDxm3TyITUw7Kk53q+fVw8y4Nup7dPETLVrTxz2Rl4THgqmyUstELkT
   HLrEq/qNfbe+77gTUzkBMvQ6uH4ibF07OY6fEwqsXZCBkdMKOcBuhTtnM
   auSGRPqohcjKozM951xGUPvtpW5QR2s8qurmwbmBjoiQm/lPmr5P9F6Pd
   dUY1jbdapw17jOHrWeaAQdT56IwRsp+abh4U9sGDw0V19rsVtWfJzwxcA
   dHKsqGUKu2hY/0Kizst6XQ20C4isRLa/7ZEdcK11ZAnO/M1rDwWuUARgP
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10934"; a="381227134"
X-IronPort-AV: E=Sophos;i="6.04,301,1695711600"; 
   d="scan'208";a="381227134"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Dec 2023 11:01:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10934"; a="727359275"
X-IronPort-AV: E=Sophos;i="6.04,301,1695711600"; 
   d="scan'208";a="727359275"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 24 Dec 2023 11:01:26 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rHTi5-000CXT-2N;
	Sun, 24 Dec 2023 19:00:45 +0000
Date: Mon, 25 Dec 2023 02:58:07 +0800
From: kernel test robot <lkp@intel.com>
To: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 da9065caa594d19b26e1a030fd0cc27bd365d685
Message-ID: <202312250203.NisfMECz-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: da9065caa594d19b26e1a030fd0cc27bd365d685  Bluetooth: Fix atomicity violation in {min,max}_key_size_set

elapsed time: 2874m

configs tested: 93
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
arc                   randconfig-001-20231224   gcc  
arc                   randconfig-002-20231224   gcc  
arm                   randconfig-001-20231224   gcc  
arm                   randconfig-002-20231224   gcc  
arm                   randconfig-003-20231224   gcc  
arm                   randconfig-004-20231224   gcc  
arm64                 randconfig-001-20231224   gcc  
arm64                 randconfig-002-20231224   gcc  
arm64                 randconfig-003-20231224   gcc  
arm64                 randconfig-004-20231224   gcc  
csky                  randconfig-001-20231224   gcc  
csky                  randconfig-002-20231224   gcc  
hexagon               randconfig-001-20231224   clang
hexagon               randconfig-002-20231224   clang
i386                             allmodconfig   clang
i386                              allnoconfig   clang
i386                             allyesconfig   clang
i386         buildonly-randconfig-001-20231224   gcc  
i386         buildonly-randconfig-002-20231224   gcc  
i386         buildonly-randconfig-003-20231224   gcc  
i386         buildonly-randconfig-004-20231224   gcc  
i386         buildonly-randconfig-005-20231224   gcc  
i386         buildonly-randconfig-006-20231224   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20231224   gcc  
i386                  randconfig-002-20231224   gcc  
i386                  randconfig-003-20231224   gcc  
i386                  randconfig-004-20231224   gcc  
i386                  randconfig-005-20231224   gcc  
i386                  randconfig-006-20231224   gcc  
i386                  randconfig-011-20231224   clang
i386                  randconfig-012-20231224   clang
i386                  randconfig-013-20231224   clang
i386                  randconfig-014-20231224   clang
i386                  randconfig-015-20231224   clang
i386                  randconfig-016-20231224   clang
loongarch                        allmodconfig   gcc  
loongarch             randconfig-001-20231224   gcc  
loongarch             randconfig-002-20231224   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                       allyesconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                 randconfig-001-20231224   gcc  
nios2                 randconfig-002-20231224   gcc  
parisc                randconfig-001-20231224   gcc  
parisc                randconfig-002-20231224   gcc  
powerpc               randconfig-001-20231224   gcc  
powerpc               randconfig-002-20231224   gcc  
powerpc               randconfig-003-20231224   gcc  
powerpc64             randconfig-001-20231224   gcc  
powerpc64             randconfig-002-20231224   gcc  
powerpc64             randconfig-003-20231224   gcc  
riscv                 randconfig-001-20231224   gcc  
riscv                 randconfig-002-20231224   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                  randconfig-001-20231224   clang
s390                  randconfig-002-20231224   clang
sh                               allmodconfig   gcc  
sh                               allyesconfig   gcc  
sh                    randconfig-001-20231224   gcc  
sh                    randconfig-002-20231224   gcc  
sparc                            allmodconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64               randconfig-001-20231224   gcc  
sparc64               randconfig-002-20231224   gcc  
um                               allmodconfig   clang
um                               allyesconfig   clang
um                    randconfig-001-20231224   gcc  
um                    randconfig-002-20231224   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20231224   gcc  
x86_64       buildonly-randconfig-002-20231224   gcc  
x86_64       buildonly-randconfig-003-20231224   gcc  
x86_64       buildonly-randconfig-004-20231224   gcc  
x86_64       buildonly-randconfig-005-20231224   gcc  
x86_64       buildonly-randconfig-006-20231224   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20231224   clang
x86_64                randconfig-002-20231224   clang
x86_64                randconfig-003-20231224   clang
x86_64                randconfig-004-20231224   clang
x86_64                randconfig-005-20231224   clang
x86_64                randconfig-006-20231224   clang
x86_64                randconfig-011-20231224   gcc  
x86_64                randconfig-012-20231224   gcc  
x86_64                          rhel-8.3-rust   clang
xtensa                randconfig-001-20231224   gcc  
xtensa                randconfig-002-20231224   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
