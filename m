Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C9EC133296
	for <linux-bluetooth@vger.kernel.org>; Thu, 22 Feb 2024 13:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708608353; cv=none; b=WQ75jOyqXJ3gVKVaLAND0eDwf3+WgV5OhdtaudNkcwwHscWLNVe0obC9iINCOZceI0uo+e+RXWjwEQR0BUj2md2KQS5gm1vvMuWeT2zBH8pk37y4Y8JjXA+sUU/xMlpQCBjtQPvz0mat6eKg/cyHji7RqMD2Y/jBQAtE1CYPi/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708608353; c=relaxed/simple;
	bh=64uHWmftR0X6Mi6ENVskFTQu5hAWbikT4g9lxMzITq0=;
	h=Date:From:To:Cc:Subject:Message-ID; b=l8oqbOcxRKw/bzfLFV16deUfFlVhe9Sja8YAOQKfK5uIOrvTcAOjIYRyyqpl+glcAz6ICrHYfIBlkeiv/JpFFUbi4k/whmqrqyHgu8IaeZK8c5wZznDYo96f4qakJz6bF2aEZVJ56RJy4sj3XlZmlPjjYWAkRBGfqlgHOx0WzRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ENw0PDVY; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ENw0PDVY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708608352; x=1740144352;
  h=date:from:to:cc:subject:message-id;
  bh=64uHWmftR0X6Mi6ENVskFTQu5hAWbikT4g9lxMzITq0=;
  b=ENw0PDVYNV6ZtyWrxpN+UPOok9mGCj1GF4GQIyqA4ztmBEhtTzGVEqcW
   hHxbictWOW4Q4quUJ2GCz5npLe/i+Vr+rP0A+lo+SiraWMcZVXJjC3XqD
   VL0zCIse72SMqKZ862+LxMmLjEmHCaJ1ughcbSWBukrkwp818xT88CKba
   ZxxFKa8qpML5sV/9Xl4bDGUshTSDjPz8+0UWFhxcHxPaqIzHuKpQcgcy7
   AhaSKS+fQLJhhZL4WPkCtX7ae1ggTyJHz+lZ3dTkQYb67XtS3eb13QEuh
   d6Bjq3TJugDrVckpqZEK93pMfYFzjbJeeMm5gOH9qZlit5LyY2r+vVKd6
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10991"; a="2692119"
X-IronPort-AV: E=Sophos;i="6.06,177,1705392000"; 
   d="scan'208";a="2692119"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 05:25:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,177,1705392000"; 
   d="scan'208";a="42956021"
Received: from lkp-server02.sh.intel.com (HELO 3c78fa4d504c) ([10.239.97.151])
  by orviesa001.jf.intel.com with ESMTP; 22 Feb 2024 05:25:50 -0800
Received: from kbuild by 3c78fa4d504c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rd954-0006Ly-26;
	Thu, 22 Feb 2024 13:25:44 +0000
Date: Thu, 22 Feb 2024 21:24:38 +0800
From: kernel test robot <lkp@intel.com>
To: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 452481b004a5707842457c3f2e848d362e74667e
Message-ID: <202402222133.RcJauwMK-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: 452481b004a5707842457c3f2e848d362e74667e  Bluetooth: btintel: Print Firmware Sequencer information

elapsed time: 1242m

configs tested: 162
configs skipped: 4

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
arc                   randconfig-001-20240222   gcc  
arc                   randconfig-002-20240222   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                   randconfig-001-20240222   gcc  
arm                   randconfig-002-20240222   gcc  
arm                   randconfig-003-20240222   clang
arm                   randconfig-004-20240222   clang
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240222   clang
arm64                 randconfig-002-20240222   gcc  
arm64                 randconfig-003-20240222   clang
arm64                 randconfig-004-20240222   clang
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240222   gcc  
csky                  randconfig-002-20240222   gcc  
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240222   clang
hexagon               randconfig-002-20240222   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240222   gcc  
i386         buildonly-randconfig-002-20240222   clang
i386         buildonly-randconfig-003-20240222   clang
i386         buildonly-randconfig-004-20240222   gcc  
i386         buildonly-randconfig-005-20240222   clang
i386         buildonly-randconfig-006-20240222   gcc  
i386                                defconfig   clang
i386                  randconfig-001-20240222   clang
i386                  randconfig-002-20240222   clang
i386                  randconfig-003-20240222   gcc  
i386                  randconfig-004-20240222   clang
i386                  randconfig-005-20240222   gcc  
i386                  randconfig-006-20240222   clang
i386                  randconfig-011-20240222   gcc  
i386                  randconfig-012-20240222   clang
i386                  randconfig-013-20240222   gcc  
i386                  randconfig-014-20240222   gcc  
i386                  randconfig-015-20240222   clang
i386                  randconfig-016-20240222   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240222   gcc  
loongarch             randconfig-002-20240222   gcc  
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
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240222   gcc  
nios2                 randconfig-002-20240222   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240222   gcc  
parisc                randconfig-002-20240222   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc               randconfig-001-20240222   clang
powerpc               randconfig-002-20240222   clang
powerpc               randconfig-003-20240222   clang
powerpc64             randconfig-001-20240222   clang
powerpc64             randconfig-002-20240222   clang
powerpc64             randconfig-003-20240222   gcc  
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240222   clang
riscv                 randconfig-002-20240222   gcc  
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240222   gcc  
s390                  randconfig-002-20240222   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                    randconfig-001-20240222   gcc  
sh                    randconfig-002-20240222   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240222   gcc  
sparc64               randconfig-002-20240222   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240222   clang
um                    randconfig-002-20240222   clang
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240222   clang
x86_64       buildonly-randconfig-002-20240222   clang
x86_64       buildonly-randconfig-003-20240222   gcc  
x86_64       buildonly-randconfig-004-20240222   clang
x86_64       buildonly-randconfig-005-20240222   gcc  
x86_64       buildonly-randconfig-006-20240222   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240222   clang
x86_64                randconfig-002-20240222   clang
x86_64                randconfig-003-20240222   clang
x86_64                randconfig-004-20240222   clang
x86_64                randconfig-005-20240222   gcc  
x86_64                randconfig-006-20240222   gcc  
x86_64                randconfig-011-20240222   clang
x86_64                randconfig-012-20240222   gcc  
x86_64                randconfig-013-20240222   clang
x86_64                randconfig-014-20240222   gcc  
x86_64                randconfig-015-20240222   clang
x86_64                randconfig-016-20240222   clang
x86_64                randconfig-071-20240222   clang
x86_64                randconfig-072-20240222   clang
x86_64                randconfig-073-20240222   clang
x86_64                randconfig-074-20240222   gcc  
x86_64                randconfig-075-20240222   gcc  
x86_64                randconfig-076-20240222   gcc  
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                randconfig-001-20240222   gcc  
xtensa                randconfig-002-20240222   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
