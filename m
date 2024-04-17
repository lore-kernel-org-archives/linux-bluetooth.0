Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D45EB13D260
	for <linux-bluetooth@vger.kernel.org>; Wed, 17 Apr 2024 14:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713363893; cv=none; b=ew1JCQ5KAM80xppCQHn7toXqRLQA4V5rjwbtPcWTyw30Uxp7xBKF8SCoKGxf1jUg1GncI/RD32vwjN03JHAq5J1olIRXyxufLoq53U8JlHOGv7dot3fXVgRd86b5S0o9REJKdtGA7NuaXE5X+oeTTS29shoVrD/1OWu8KGxILc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713363893; c=relaxed/simple;
	bh=6yR0I7FhS9YQbVM5ucI2p4EvNZiRgDbeeULTgSclRUI=;
	h=Date:From:To:Cc:Subject:Message-ID; b=PR69HEbTn9DyvH1zuwQi/po87FFE94qNh6W0KMBU62hwymZ83aZxZPdtu+TFLIgqDT6wjTpeKOXUiIantwYOXmrGPC2fTYRxiS+bL1K2OyrzVTgzCD3tczqtU+DNtx775SJCItAmRh2GRI4ebFRf1fWUtXlyO3d3jO/xVek+GX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Dep+UvjZ; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Dep+UvjZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713363891; x=1744899891;
  h=date:from:to:cc:subject:message-id;
  bh=6yR0I7FhS9YQbVM5ucI2p4EvNZiRgDbeeULTgSclRUI=;
  b=Dep+UvjZmRZeVl8FYNPaPfvK9ySbqaunZi/SGJkkslsv6xjP4e0E1+t3
   Vresme+0Z5epbYk0ZIrM+Gk1Htm+pDxRJ6GtxcV44n2zY4qCtD7OroI4r
   Oals/nIrDoO2NgxPu94/z58cxwqgc/qUrUSuT4lsxrPEJPWsYA2dAOVRE
   rY9lJE8r/dnA/LvsAu34D/U9PKJTaDD3BM7iEONU6YYf8IudPQKcQPtzj
   tFvdH+Y1Mr8zZ3urRiAQGYKoeEdiC5EtPVHoOWY1adyYKS6jN/lBAqrS+
   bZypziKIhkBnfz8orf9owVuamGYFToygAagLmKjQNIfei/RxfQFuQmOE7
   Q==;
X-CSE-ConnectionGUID: tvzrTLlSQzCWVrFooJY0zQ==
X-CSE-MsgGUID: QLvYXpdBQYe7glxUJ90tvw==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="9027362"
X-IronPort-AV: E=Sophos;i="6.07,209,1708416000"; 
   d="scan'208";a="9027362"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2024 07:24:41 -0700
X-CSE-ConnectionGUID: CRfGohhWRm+F4Xxnzkl32Q==
X-CSE-MsgGUID: ygNMMdeST367mjUJ9Rbm9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,209,1708416000"; 
   d="scan'208";a="45938617"
Received: from unknown (HELO 23c141fc0fd8) ([10.239.97.151])
  by fmviesa002.fm.intel.com with ESMTP; 17 Apr 2024 07:24:38 -0700
Received: from kbuild by 23c141fc0fd8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rx6DE-0006fs-06;
	Wed, 17 Apr 2024 14:24:36 +0000
Date: Wed, 17 Apr 2024 22:23:50 +0800
From: kernel test robot <lkp@intel.com>
To: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 00567f70051a41c2323dbce1c8fc22514202bd26
Message-ID: <202404172248.yMxtqA5E-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: 00567f70051a41c2323dbce1c8fc22514202bd26  Bluetooth: qca: fix invalid device address check

elapsed time: 1398m

configs tested: 128
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
arc                   randconfig-001-20240417   gcc  
arc                   randconfig-002-20240417   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                   randconfig-001-20240417   clang
arm                   randconfig-002-20240417   clang
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240417   clang
i386         buildonly-randconfig-002-20240417   gcc  
i386         buildonly-randconfig-003-20240417   clang
i386         buildonly-randconfig-004-20240417   gcc  
i386         buildonly-randconfig-005-20240417   gcc  
i386         buildonly-randconfig-006-20240417   gcc  
i386                                defconfig   clang
i386                  randconfig-001-20240417   clang
i386                  randconfig-002-20240417   gcc  
i386                  randconfig-003-20240417   gcc  
i386                  randconfig-004-20240417   clang
i386                  randconfig-005-20240417   clang
i386                  randconfig-006-20240417   clang
i386                  randconfig-011-20240417   gcc  
i386                  randconfig-012-20240417   gcc  
i386                  randconfig-013-20240417   clang
i386                  randconfig-014-20240417   gcc  
i386                  randconfig-015-20240417   gcc  
i386                  randconfig-016-20240417   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
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
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240417   clang
x86_64       buildonly-randconfig-002-20240417   gcc  
x86_64       buildonly-randconfig-003-20240417   clang
x86_64       buildonly-randconfig-004-20240417   clang
x86_64       buildonly-randconfig-005-20240417   clang
x86_64       buildonly-randconfig-006-20240417   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240417   gcc  
x86_64                randconfig-002-20240417   gcc  
x86_64                randconfig-003-20240417   gcc  
x86_64                randconfig-004-20240417   clang
x86_64                randconfig-005-20240417   clang
x86_64                randconfig-006-20240417   gcc  
x86_64                randconfig-011-20240417   clang
x86_64                randconfig-012-20240417   clang
x86_64                randconfig-013-20240417   clang
x86_64                randconfig-014-20240417   gcc  
x86_64                randconfig-015-20240417   clang
x86_64                randconfig-016-20240417   clang
x86_64                randconfig-071-20240417   gcc  
x86_64                randconfig-072-20240417   clang
x86_64                randconfig-073-20240417   gcc  
x86_64                randconfig-074-20240417   clang
x86_64                randconfig-075-20240417   clang
x86_64                randconfig-076-20240417   clang
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
