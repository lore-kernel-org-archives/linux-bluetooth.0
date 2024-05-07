Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31DBB71B3B
	for <linux-bluetooth@vger.kernel.org>; Tue,  7 May 2024 21:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715117574; cv=none; b=VLsUd8pKRfULkB7tUkCdlCPC6ZwlqcVk4A1F48218x3cGW9acm364OMRlSCAvSOVebNx59cRrdemVafXIuDjsnYbMMhXC1OzZkX3ZmztsyruJNdQRBFfKqnz8/7GioelJNqR0MGgRtpqHegMd3VJQ6SrZ46KYY+HMMv//z2D2mE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715117574; c=relaxed/simple;
	bh=t/C7VM3aRJ24YyFiE4+YNJdmo0W9FN7hEAuCDBsVyRg=;
	h=Date:From:To:Cc:Subject:Message-ID; b=GVj0+Wvf2djP51qMnzW3jid2dG/1xOTgbbc7lJL3HQQ53VO296cH0VDUChUh+vZjAMX1o/YQeyuu+SzQvvaC7+yvWdbfhwiLuBXh+4NZhVJmDnli6pgd16LzfGPBkIduLSmtu2hVsinMyqWnfQqju6LGyO0VKKb0+ZeDBTQxnRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B1xJ7x9F; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B1xJ7x9F"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715117573; x=1746653573;
  h=date:from:to:cc:subject:message-id;
  bh=t/C7VM3aRJ24YyFiE4+YNJdmo0W9FN7hEAuCDBsVyRg=;
  b=B1xJ7x9FVYNUjWWBDx9fEU2I+6OlwP/fV4hkncDUdyRvZFve49El4IJg
   wQbcSpSg6zdyY9uqNd6FDB2+/VT2ZOKfe6Dxw/VMmH+zIkPEIb32pbfTy
   VK/jeLhFiPTiwwNdoRCBHVC26ppo5okxfCKLj4tfRb75pOTvw85arWNYD
   D2G2bEueiDZg2yxKXGqp6FWNWmyHkZGbG9sOEaECH0B8R5+tYryRq5Lq0
   HXuvAD8AQ4Spvk3RxElbeqERWyYKKYPaEP38/T4uHZRbOCRBu2p8LV2Nn
   /dPPq5HE8oriUUojw+zoICgiwSKOMHjYqVq390iKsrYNnAcUXywsQTO9o
   A==;
X-CSE-ConnectionGUID: Vx7DRTHwT1CHRS3JMtCXpg==
X-CSE-MsgGUID: //DNLDtATaC61f657U5VZQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11066"; a="22357679"
X-IronPort-AV: E=Sophos;i="6.08,143,1712646000"; 
   d="scan'208";a="22357679"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2024 14:32:52 -0700
X-CSE-ConnectionGUID: tt0E+MFMSyuEO14kl88I0A==
X-CSE-MsgGUID: t1xEOC6HQZWHOa7oKkJHlg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,143,1712646000"; 
   d="scan'208";a="28758935"
Received: from lkp-server01.sh.intel.com (HELO f8b243fe6e68) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 07 May 2024 14:32:50 -0700
Received: from kbuild by f8b243fe6e68 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s4SQa-0002ej-0K;
	Tue, 07 May 2024 21:32:48 +0000
Date: Wed, 08 May 2024 05:32:06 +0800
From: kernel test robot <lkp@intel.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Linux Memory Management List <linux-mm@kvack.org>,
 linux-bluetooth@vger.kernel.org
Subject: [linux-next:pending-fixes] BUILD SUCCESS
 9b1e89a69d0843b8aa85621fba79deead84eb6d1
Message-ID: <202405080503.RevWxaRO-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git pending-fixes
branch HEAD: 9b1e89a69d0843b8aa85621fba79deead84eb6d1  Merge branch 'for-linux-next-fixes' of https://gitlab.freedesktop.org/drm/misc/kernel.git

Warning ids grouped by kconfigs:

gcc_recent_errors
|-- i386-randconfig-052-20240508
|   `-- net-bluetooth-l2cap_core.c:preceding-lock-on-line
`-- x86_64-randconfig-103-20240508
    `-- net-bluetooth-l2cap_core.c:preceding-lock-on-line

elapsed time: 1296m

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
arc                   randconfig-001-20240507   gcc  
arc                   randconfig-002-20240507   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                   randconfig-001-20240507   gcc  
arm                   randconfig-002-20240507   clang
arm                   randconfig-003-20240507   gcc  
arm                   randconfig-004-20240507   clang
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240507   clang
arm64                 randconfig-002-20240507   clang
arm64                 randconfig-003-20240507   clang
arm64                 randconfig-004-20240507   clang
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240507   gcc  
csky                  randconfig-002-20240507   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240507   clang
hexagon               randconfig-002-20240507   clang
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240507   clang
i386         buildonly-randconfig-002-20240507   clang
i386         buildonly-randconfig-003-20240507   clang
i386         buildonly-randconfig-004-20240507   gcc  
i386         buildonly-randconfig-005-20240507   gcc  
i386         buildonly-randconfig-006-20240507   clang
i386                                defconfig   clang
i386                  randconfig-001-20240507   clang
i386                  randconfig-002-20240507   gcc  
i386                  randconfig-003-20240507   clang
i386                  randconfig-004-20240507   clang
i386                  randconfig-005-20240507   clang
i386                  randconfig-006-20240507   clang
i386                  randconfig-011-20240507   gcc  
i386                  randconfig-012-20240507   clang
i386                  randconfig-013-20240507   clang
i386                  randconfig-014-20240507   gcc  
i386                  randconfig-015-20240507   gcc  
i386                  randconfig-016-20240507   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240507   gcc  
loongarch             randconfig-002-20240507   gcc  
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
nios2                 randconfig-001-20240507   gcc  
nios2                 randconfig-002-20240507   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240507   gcc  
parisc                randconfig-002-20240507   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc               randconfig-001-20240507   gcc  
powerpc               randconfig-002-20240507   clang
powerpc               randconfig-003-20240507   clang
powerpc64             randconfig-001-20240507   gcc  
powerpc64             randconfig-002-20240507   gcc  
powerpc64             randconfig-003-20240507   clang
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240507   clang
riscv                 randconfig-002-20240507   gcc  
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240507   gcc  
s390                  randconfig-002-20240507   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                    randconfig-001-20240507   gcc  
sh                    randconfig-002-20240507   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240507   gcc  
sparc64               randconfig-002-20240507   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240507   gcc  
um                    randconfig-002-20240507   clang
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240507   clang
x86_64       buildonly-randconfig-002-20240507   clang
x86_64       buildonly-randconfig-003-20240507   clang
x86_64       buildonly-randconfig-004-20240507   clang
x86_64       buildonly-randconfig-005-20240507   clang
x86_64       buildonly-randconfig-006-20240507   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240507   gcc  
x86_64                randconfig-002-20240507   clang
x86_64                randconfig-003-20240507   clang
x86_64                randconfig-004-20240507   gcc  
x86_64                randconfig-005-20240507   gcc  
x86_64                randconfig-006-20240507   gcc  
x86_64                randconfig-011-20240507   gcc  
x86_64                randconfig-012-20240507   clang
x86_64                randconfig-013-20240507   clang
x86_64                randconfig-014-20240507   clang
x86_64                randconfig-015-20240507   clang
x86_64                randconfig-016-20240507   clang
x86_64                randconfig-071-20240507   gcc  
x86_64                randconfig-072-20240507   gcc  
x86_64                randconfig-073-20240507   clang
x86_64                randconfig-074-20240507   clang
x86_64                randconfig-075-20240507   clang
x86_64                randconfig-076-20240507   clang
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                randconfig-001-20240507   gcc  
xtensa                randconfig-002-20240507   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
