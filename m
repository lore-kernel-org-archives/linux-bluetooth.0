Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BAC51552F5
	for <linux-bluetooth@vger.kernel.org>; Fri,  7 Jun 2024 20:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717793144; cv=none; b=uiPCUT7L6eujWcB43uUTJMUZ/ZNOFvyeeZ5p+d9HnZxYH6fnQdrwtYkSTsveoDJ1hCPllEsDp89hKN2/c8itDDfgfyZkl3CGNuAx2ob+sq707y8wHMXj8s1fgECteZqKWwGYbw8ZLuA4KXHBSplqvGIUgw5a1RBRbvbfW4wfIf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717793144; c=relaxed/simple;
	bh=a2LjW/8QLFF/ywhW9DvnQGTY/qFhUtPciM/uZ+xGWeI=;
	h=Date:From:To:Cc:Subject:Message-ID; b=LMA+KPB0iUyQFepSsPsvaYyeOgYMfTgw7SGA3ByX4oapsn5IdsByaN5fqlD27iXk9EihxxKWtKqQZR1t7MEy1GYGPz9zudqDSMlkkauce1Lo+GosZ/al273KLPYWUKWvUuj6QPolcqY5D+2I4wyoVKKh5ZCu3IkEgzv1nCaSyPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZU7P2XMc; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZU7P2XMc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717793144; x=1749329144;
  h=date:from:to:cc:subject:message-id;
  bh=a2LjW/8QLFF/ywhW9DvnQGTY/qFhUtPciM/uZ+xGWeI=;
  b=ZU7P2XMcsgmMm3HQw0G8k97jwOtUmh843ohe7im6nuVVvodMI3tuk9I0
   vDsxQfxXxGFGcCmPfHqaTmionLSfZylUiDgWJ6vJw/zjnxQbfAzOMe3cI
   2TPsQs9Z7Mn/CJxMGdc5SnCG21bNMIdEqAAcgAmmdtpIKUIz441xpWpWL
   LpfGi6CHwt62cjeg2QIL4JJ/wBQc0HJFQ8brnSqTW5f9rtmT4LRv7cCs0
   23oSWJoRunMRu6s1qWUbrrW2bMutXF6hlsCbRDQ+4TI4qQR02vehHwNB1
   TMstI+JFULHHYlwjQ0LImySGqHSC+wIyRgrgR3r17CeRcx07SC7VgvlOc
   A==;
X-CSE-ConnectionGUID: nlcumhzPQEWfH52VKGrrWQ==
X-CSE-MsgGUID: CYuwVy0TTIWdx8DtQ7nkaQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11096"; a="14666718"
X-IronPort-AV: E=Sophos;i="6.08,221,1712646000"; 
   d="scan'208";a="14666718"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2024 13:45:43 -0700
X-CSE-ConnectionGUID: xvdAope0Tpu0olwcRg5Y7A==
X-CSE-MsgGUID: 1rdcxqPRS0eTroZSAKryBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,221,1712646000"; 
   d="scan'208";a="38557639"
Received: from lkp-server01.sh.intel.com (HELO 472b94a103a1) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 07 Jun 2024 13:45:42 -0700
Received: from kbuild by 472b94a103a1 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sFgSx-0000VA-21;
	Fri, 07 Jun 2024 20:45:39 +0000
Date: Sat, 08 Jun 2024 04:45:13 +0800
From: kernel test robot <lkp@intel.com>
To: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 0b22b7f8aef3450dd9a035ccdb9ff3419530d892
Message-ID: <202406080411.TM6Qo42X-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: 0b22b7f8aef3450dd9a035ccdb9ff3419530d892  Bluetooth: hci_bcm4377: Add BCM4388 support

elapsed time: 1455m

configs tested: 66
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                               allnoconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20240608   gcc  
arc                   randconfig-002-20240608   gcc  
arm                               allnoconfig   clang
arm                                 defconfig   clang
arm                   randconfig-001-20240608   gcc  
arm                   randconfig-002-20240608   clang
arm                   randconfig-003-20240608   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
csky                              allnoconfig   gcc  
csky                                defconfig   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
i386         buildonly-randconfig-001-20240608   gcc  
i386         buildonly-randconfig-002-20240608   clang
i386         buildonly-randconfig-003-20240608   gcc  
i386         buildonly-randconfig-004-20240608   gcc  
i386         buildonly-randconfig-005-20240608   clang
i386         buildonly-randconfig-006-20240608   gcc  
i386                  randconfig-001-20240608   clang
i386                  randconfig-002-20240608   gcc  
i386                  randconfig-003-20240608   gcc  
i386                  randconfig-004-20240608   clang
i386                  randconfig-005-20240608   gcc  
i386                  randconfig-006-20240608   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                                defconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                               defconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                            defconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                           allnoconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   clang
s390                              allnoconfig   clang
s390                                defconfig   clang
sh                                allnoconfig   gcc  
sh                                  defconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                             defconfig   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                                  kexec   clang
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
