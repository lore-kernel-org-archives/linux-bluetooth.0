Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 330B555E5B
	for <linux-bluetooth@vger.kernel.org>; Tue, 11 Jun 2024 16:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718125131; cv=none; b=OjzeQY6ULuvvFrnHndD6rz6ImVlWFWKWgJogKbYo6LMmVVGAFmkhDOAJv3S2pppsbfxfEekB9WZbcOAT/QTKJiJIf3Z/ZXNP47BdRyTm4bj9wAgyhrNAFOqph9UoTXSLXZs6OLHplEEHzQ85hMpFO/2UxEXqenbKiI0FUWCYqio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718125131; c=relaxed/simple;
	bh=r1VCb1GZO8Nfsno+WIIjTbHn4iHLWIck94g8phSGx+4=;
	h=Date:From:To:Cc:Subject:Message-ID; b=ZooKqEsLmPqv4tz77a56D1rhXALpq3g/U4vqnECX+JZoEOZbotjhg0m7qfk3Da+Q/EIIPvwGL9qQyMcUUBeYA0URQ9y8ynx2Bdia/kpG0KFdlv5yTNo+Y/7pTeSSTzWS+XNhrXF9HAFLUwRA2HhRFUQYnuz7QAP9GxNZ0/EmCCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CJnUO+Yi; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CJnUO+Yi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718125130; x=1749661130;
  h=date:from:to:cc:subject:message-id;
  bh=r1VCb1GZO8Nfsno+WIIjTbHn4iHLWIck94g8phSGx+4=;
  b=CJnUO+YiQ80l7dIO2lHJxGTFaCs2CK2Sg9IMbTHW2iPAKqXanEu1Ts1g
   akCghylATFa+4h61qLK5/kd5Rx3Z45UFI4gNCt6Y3GULeaG9B8+yn8vmV
   AVQHXh/fy1HknPvhDjUnvkZJBPnPjt4BAJVugNjm8ltOy6AnHn4tQhaJE
   2QzxnIMUkgoaZDBNxLiFaiTRMMLT5z9pHktWN27K2gFzTyJi69iaxM5Cw
   DFu+VMkKKSE/1TkJ1i3L9xBK/U8R0pP5IOrn0NXmOKCxpUEWytZ166Qo0
   COusTfGo6k2GFVNWcw8EBcSWtroO+vpKnOLSdtsYvi3Prpl64A33hcVyM
   g==;
X-CSE-ConnectionGUID: KnnV8sC+QbeuHfbarDHtug==
X-CSE-MsgGUID: +CnNnyEqRBm2XhDWL/ECCg==
X-IronPort-AV: E=McAfee;i="6600,9927,11100"; a="18707722"
X-IronPort-AV: E=Sophos;i="6.08,230,1712646000"; 
   d="scan'208";a="18707722"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2024 09:58:49 -0700
X-CSE-ConnectionGUID: 9LtAyZ/2TpWiyK55JI9Aig==
X-CSE-MsgGUID: KgZI2JpeTo6Whz4En2qPAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,230,1712646000"; 
   d="scan'208";a="40215642"
Received: from lkp-server01.sh.intel.com (HELO 628d7d8b9fc6) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 11 Jun 2024 09:58:49 -0700
Received: from kbuild by 628d7d8b9fc6 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sH4pa-0000gX-0j;
	Tue, 11 Jun 2024 16:58:46 +0000
Date: Wed, 12 Jun 2024 00:58:39 +0800
From: kernel test robot <lkp@intel.com>
To: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 d2118673f3ae27f667c0a8690d297cbb7f917e6e
Message-ID: <202406120036.OneDwHKc-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: d2118673f3ae27f667c0a8690d297cbb7f917e6e  Bluetooth: qca: Fix BT enable failure again for QCA6390 after warm reboot

elapsed time: 1454m

configs tested: 133
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                             allnoconfig   gcc-13.2.0
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                               defconfig   gcc-13.2.0
arc                               allnoconfig   gcc  
arc                               allnoconfig   gcc-13.2.0
arc                                 defconfig   gcc  
arc                                 defconfig   gcc-13.2.0
arc                   randconfig-001-20240611   gcc-13.2.0
arc                   randconfig-002-20240611   gcc-13.2.0
arm                               allnoconfig   clang
arm                                 defconfig   clang
arm                   randconfig-001-20240611   gcc-13.2.0
arm                   randconfig-002-20240611   clang-19
arm                   randconfig-003-20240611   clang-15
arm                   randconfig-004-20240611   clang-19
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240611   clang-19
arm64                 randconfig-002-20240611   clang-17
arm64                 randconfig-003-20240611   clang-19
arm64                 randconfig-004-20240611   gcc-13.2.0
csky                              allnoconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240611   gcc-13.2.0
csky                  randconfig-002-20240611   gcc-13.2.0
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240611   clang-19
hexagon               randconfig-002-20240611   clang-14
i386         buildonly-randconfig-001-20240611   gcc  
i386         buildonly-randconfig-002-20240611   gcc  
i386         buildonly-randconfig-003-20240611   clang
i386         buildonly-randconfig-004-20240611   gcc  
i386         buildonly-randconfig-005-20240611   gcc  
i386         buildonly-randconfig-006-20240611   gcc  
i386                  randconfig-001-20240611   clang
i386                  randconfig-002-20240611   gcc  
i386                  randconfig-003-20240611   gcc  
i386                  randconfig-004-20240611   clang
i386                  randconfig-005-20240611   gcc  
i386                  randconfig-006-20240611   clang
i386                  randconfig-011-20240611   clang
i386                  randconfig-012-20240611   gcc  
i386                  randconfig-013-20240611   clang
i386                  randconfig-014-20240611   gcc  
i386                  randconfig-015-20240611   clang
i386                  randconfig-016-20240611   clang
loongarch                        allmodconfig   gcc-13.2.0
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240611   gcc-13.2.0
loongarch             randconfig-002-20240611   gcc-13.2.0
m68k                             allmodconfig   gcc-13.2.0
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc-13.2.0
m68k                                defconfig   gcc  
microblaze                       allmodconfig   gcc-13.2.0
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc-13.2.0
microblaze                          defconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc-13.2.0
nios2                            allmodconfig   gcc-13.2.0
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc-13.2.0
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240611   gcc-13.2.0
nios2                 randconfig-002-20240611   gcc-13.2.0
openrisc                          allnoconfig   gcc  
openrisc                          allnoconfig   gcc-13.2.0
openrisc                            defconfig   gcc  
openrisc                            defconfig   gcc-13.2.0
parisc                            allnoconfig   gcc  
parisc                            allnoconfig   gcc-13.2.0
parisc                              defconfig   gcc  
parisc                              defconfig   gcc-13.2.0
parisc                randconfig-001-20240611   gcc-13.2.0
parisc                randconfig-002-20240611   gcc-13.2.0
parisc64                            defconfig   gcc  
parisc64                            defconfig   gcc-13.2.0
powerpc                           allnoconfig   gcc  
powerpc                           allnoconfig   gcc-13.2.0
powerpc               randconfig-001-20240611   gcc-13.2.0
powerpc               randconfig-002-20240611   clang-19
powerpc               randconfig-003-20240611   clang-19
powerpc64             randconfig-001-20240611   gcc-13.2.0
powerpc64             randconfig-002-20240611   clang-19
powerpc64             randconfig-003-20240611   clang-19
riscv                             allnoconfig   gcc  
riscv                             allnoconfig   gcc-13.2.0
riscv                               defconfig   clang
riscv                 randconfig-001-20240611   gcc-13.2.0
riscv                 randconfig-002-20240611   clang-19
s390                              allnoconfig   clang
s390                                defconfig   clang
s390                  randconfig-001-20240611   gcc-13.2.0
s390                  randconfig-002-20240611   gcc-13.2.0
sh                               allmodconfig   gcc-13.2.0
sh                                allnoconfig   gcc  
sh                                  defconfig   gcc  
sh                    randconfig-001-20240611   gcc-13.2.0
sh                    randconfig-002-20240611   gcc-13.2.0
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240611   gcc-13.2.0
sparc64               randconfig-002-20240611   gcc-13.2.0
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240611   gcc-11
um                    randconfig-002-20240611   gcc-13
um                           x86_64_defconfig   clang
x86_64       buildonly-randconfig-001-20240611   gcc-13
x86_64       buildonly-randconfig-002-20240611   gcc-9
x86_64       buildonly-randconfig-003-20240611   gcc-13
x86_64       buildonly-randconfig-004-20240611   clang-18
x86_64       buildonly-randconfig-005-20240611   gcc-9
x86_64       buildonly-randconfig-006-20240611   gcc-13
x86_64                randconfig-001-20240611   clang-18
x86_64                randconfig-002-20240611   gcc-12
x86_64                randconfig-003-20240611   gcc-8
x86_64                randconfig-004-20240611   clang-18
x86_64                randconfig-005-20240611   gcc-10
xtensa                            allnoconfig   gcc  
xtensa                randconfig-001-20240611   gcc-13.2.0
xtensa                randconfig-002-20240611   gcc-13.2.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
