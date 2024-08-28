Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A97201B1411
	for <linux-bluetooth@vger.kernel.org>; Wed, 28 Aug 2024 20:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724877871; cv=none; b=AquV3g1tygnD5WwoxVvlhTn81Ej0TG+WE/UIW7h4jra0LtNU5ydNiL2CeaZDG7xwIHcXgGaxhaZ3TnuGa+XOhScrKuuEfNWug1tu43DjfU7J3xDK43zEfgUGMwUS7oVBhTmKvnynkB7U18kt6kGPaXbncR1Zy4MBeCssrKQy6us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724877871; c=relaxed/simple;
	bh=o8thq6xvfu/8tnxMiUXiEe1UdXbprm15NM/5Ms4TqhQ=;
	h=Date:From:To:Cc:Subject:Message-ID; b=eVQH/wN10wQWnCC129d8XcJEoiNblrEwaA201e3gqcF1azUp58lzgoehc6p/bZVGxK7aKywoMphH7bKzXWVXTEF9nNlIT8xJOLXAUR+Q1WxJw5/gBobeg3Uj0XRNAh5X5lkb6R7XO7fwZ8FxwtS8JE5oVyobwz9QMtVt2g5DlHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fp7UbNzj; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fp7UbNzj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724877869; x=1756413869;
  h=date:from:to:cc:subject:message-id;
  bh=o8thq6xvfu/8tnxMiUXiEe1UdXbprm15NM/5Ms4TqhQ=;
  b=fp7UbNzjsjb2HsT+bKgTjs48HJ+xWKQP/MfdceUHLnn1DOJYC+He8kjQ
   HJQu1wiyIhAgi471JT/XWUSpTDQuN2fylTPiJNCJ6JdFWLAS3WeW5SNu2
   yHLE5xR/EXEirYhbYYvgYsS0/4ON0R7zC4H8qTSBRgJrQCiVq2si9xb0h
   ihfRlcutsdy4UYu7vXGwKt3YvhSRtMM+wr3klH61dLRXVu6QBplleF8ot
   FKa+asmSP/2cgP62qAj2GZ2nkHAZBvOBS+WohQzUEB+J8aSU8LuQqa7sE
   n+KXB6PzujFs4VZNi2sjKKM3yKIDpICef+oglW7w554DlK7IXn9dyau+c
   Q==;
X-CSE-ConnectionGUID: SC+yWXFbTkmEmdMlr5ZDOw==
X-CSE-MsgGUID: 63wyqSYFTYSayulb2Er5Lg==
X-IronPort-AV: E=McAfee;i="6700,10204,11178"; a="34009139"
X-IronPort-AV: E=Sophos;i="6.10,183,1719903600"; 
   d="scan'208";a="34009139"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2024 13:44:29 -0700
X-CSE-ConnectionGUID: 1XRRAxTuQi+TfRM+lGzyAg==
X-CSE-MsgGUID: MepVoTuUSceGOYh8YW/ALw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,183,1719903600"; 
   d="scan'208";a="67711458"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 28 Aug 2024 13:44:28 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sjPWk-000LL4-0F;
	Wed, 28 Aug 2024 20:44:26 +0000
Date: Thu, 29 Aug 2024 04:44:13 +0800
From: kernel test robot <lkp@intel.com>
To: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 5785ffa3900938badbf6776348dc2a94bc0d6444
Message-ID: <202408290411.9attdZ5W-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: 5785ffa3900938badbf6776348dc2a94bc0d6444  Bluetooth: MGMT: Fix not generating command complete for MGMT_OP_DISCONNECT

elapsed time: 1505m

configs tested: 133
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-13.2.0
alpha                             allnoconfig   gcc-13.3.0
alpha                            allyesconfig   gcc-13.3.0
arc                              allmodconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                              allyesconfig   gcc-13.2.0
arc                   randconfig-001-20240828   gcc-13.2.0
arc                   randconfig-002-20240828   gcc-13.2.0
arm                              allmodconfig   gcc-14.1.0
arm                               allnoconfig   clang-20
arm                               allnoconfig   gcc-13.2.0
arm                              allyesconfig   gcc-14.1.0
arm                   randconfig-001-20240828   gcc-14.1.0
arm                   randconfig-002-20240828   clang-20
arm                   randconfig-003-20240828   gcc-14.1.0
arm                   randconfig-004-20240828   clang-20
arm64                            allmodconfig   clang-20
arm64                             allnoconfig   gcc-13.2.0
arm64                             allnoconfig   gcc-14.1.0
arm64                 randconfig-001-20240828   clang-17
arm64                 randconfig-002-20240828   clang-20
arm64                 randconfig-003-20240828   clang-15
arm64                 randconfig-004-20240828   clang-15
csky                              allnoconfig   gcc-13.2.0
csky                              allnoconfig   gcc-14.1.0
csky                  randconfig-001-20240828   gcc-14.1.0
csky                  randconfig-002-20240828   gcc-14.1.0
hexagon                          allmodconfig   clang-20
hexagon                           allnoconfig   clang-20
hexagon                          allyesconfig   clang-20
hexagon               randconfig-001-20240828   clang-20
hexagon               randconfig-002-20240828   clang-16
i386                             allmodconfig   gcc-12
i386                              allnoconfig   gcc-12
i386                             allyesconfig   gcc-12
i386         buildonly-randconfig-001-20240829   clang-18
i386         buildonly-randconfig-002-20240829   clang-18
i386         buildonly-randconfig-003-20240829   clang-18
i386         buildonly-randconfig-004-20240829   clang-18
i386         buildonly-randconfig-006-20240829   clang-18
i386                                defconfig   clang-18
i386                  randconfig-002-20240829   clang-18
i386                  randconfig-003-20240829   clang-18
i386                  randconfig-004-20240829   clang-18
i386                  randconfig-005-20240829   clang-18
i386                  randconfig-006-20240829   clang-18
i386                  randconfig-011-20240829   clang-18
i386                  randconfig-012-20240829   clang-18
i386                  randconfig-013-20240829   clang-18
i386                  randconfig-014-20240829   clang-18
i386                  randconfig-015-20240829   clang-18
i386                  randconfig-016-20240829   clang-18
loongarch                        allmodconfig   gcc-14.1.0
loongarch                         allnoconfig   gcc-13.2.0
loongarch                         allnoconfig   gcc-14.1.0
loongarch             randconfig-001-20240828   gcc-14.1.0
m68k                             allmodconfig   gcc-14.1.0
m68k                              allnoconfig   gcc-13.2.0
m68k                              allnoconfig   gcc-14.1.0
m68k                             allyesconfig   gcc-14.1.0
microblaze                       allmodconfig   gcc-14.1.0
microblaze                        allnoconfig   gcc-13.2.0
microblaze                        allnoconfig   gcc-14.1.0
microblaze                       allyesconfig   gcc-14.1.0
mips                              allnoconfig   gcc-13.2.0
mips                              allnoconfig   gcc-14.1.0
nios2                             allnoconfig   gcc-13.2.0
nios2                             allnoconfig   gcc-14.1.0
openrisc                          allnoconfig   gcc-14.1.0
openrisc                         allyesconfig   gcc-14.1.0
openrisc                            defconfig   gcc-14.1.0
parisc                           allmodconfig   gcc-14.1.0
parisc                            allnoconfig   gcc-14.1.0
parisc                           allyesconfig   gcc-14.1.0
parisc                              defconfig   gcc-14.1.0
powerpc                          allmodconfig   gcc-14.1.0
powerpc                           allnoconfig   gcc-14.1.0
riscv                             allnoconfig   gcc-14.1.0
riscv                               defconfig   clang-20
riscv                               defconfig   gcc-14.1.0
s390                             allmodconfig   clang-20
s390                              allnoconfig   clang-20
s390                              allnoconfig   gcc-14.1.0
s390                             allyesconfig   clang-20
s390                             allyesconfig   gcc-14.1.0
s390                                defconfig   clang-20
s390                                defconfig   gcc-14.1.0
sh                               allmodconfig   gcc-14.1.0
sh                                allnoconfig   gcc-13.2.0
sh                                allnoconfig   gcc-14.1.0
sh                               allyesconfig   gcc-14.1.0
sh                                  defconfig   gcc-14.1.0
sparc64                             defconfig   gcc-14.1.0
um                               allmodconfig   clang-20
um                                allnoconfig   clang-17
um                                allnoconfig   gcc-14.1.0
um                               allyesconfig   gcc-12
um                                  defconfig   clang-20
um                                  defconfig   gcc-14.1.0
um                             i386_defconfig   gcc-12
um                             i386_defconfig   gcc-14.1.0
um                           x86_64_defconfig   clang-15
um                           x86_64_defconfig   gcc-14.1.0
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240828   clang-18
x86_64       buildonly-randconfig-002-20240828   clang-18
x86_64       buildonly-randconfig-003-20240828   gcc-12
x86_64       buildonly-randconfig-004-20240828   clang-18
x86_64       buildonly-randconfig-005-20240828   gcc-11
x86_64       buildonly-randconfig-006-20240828   clang-18
x86_64                              defconfig   gcc-11
x86_64                randconfig-001-20240828   gcc-12
x86_64                randconfig-002-20240828   clang-18
x86_64                randconfig-003-20240828   gcc-12
x86_64                randconfig-004-20240828   clang-18
x86_64                randconfig-005-20240828   clang-18
x86_64                randconfig-006-20240828   gcc-12
x86_64                randconfig-011-20240828   clang-18
x86_64                randconfig-012-20240828   clang-18
x86_64                randconfig-013-20240828   clang-18
x86_64                randconfig-014-20240828   clang-18
x86_64                randconfig-015-20240828   gcc-12
x86_64                randconfig-016-20240828   gcc-12
x86_64                randconfig-071-20240828   gcc-12
x86_64                randconfig-072-20240828   gcc-12
x86_64                randconfig-073-20240828   gcc-12
x86_64                randconfig-074-20240828   gcc-12
x86_64                randconfig-075-20240828   gcc-12
x86_64                randconfig-076-20240828   clang-18
x86_64                          rhel-8.3-rust   clang-18
xtensa                            allnoconfig   gcc-13.2.0
xtensa                            allnoconfig   gcc-14.1.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
