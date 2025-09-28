Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F5319F43A
	for <linux-bluetooth@vger.kernel.org>; Sun, 28 Sep 2025 07:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759046148; cv=none; b=Pxt6UlQR0cNE2RJV8fCEKxIExnDkd7SReJaeC2yv8C+OS2sAcyeEEr3x3rDb877YpyTS3zMKpN6k0WHYllW65a9tG7I5U5o657WL09X9gBD2RUCb1YwKyTfG4emBxPIBkCegY7NsJ8Qk5pAlVdVyObetVj2u4vvFnkCqIrYDKDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759046148; c=relaxed/simple;
	bh=z+F6axM3SK7+iI+yviMc8wtciMB66jgZ6tyVPNHWDg0=;
	h=Date:From:To:Cc:Subject:Message-ID; b=ktXmhqQVfKsRQf6soUlnugxleshA8JRRutiWt9msMmo9BnHVqXXBgZmrztaUH48CWY2lTt7k8Cz5h8wOdZivLyCZpvHBnTcFpVoJHFW4v3hfsgHHrVvGRj9TRiQlUWTpiKParcf4fcKeF+QeGt+yTUKYTAHHA8iUI0D9uWk9Ixc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eCPMD/5H; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eCPMD/5H"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759046146; x=1790582146;
  h=date:from:to:cc:subject:message-id;
  bh=z+F6axM3SK7+iI+yviMc8wtciMB66jgZ6tyVPNHWDg0=;
  b=eCPMD/5H8lPCjMVxI9xlxlo+NUbwlJtrsA6KKuY8CqWUnPQrTmLrFNWb
   Oi8qs78Km7L76mliI3uhGsd+kT+IGnAJTn4guXVyA+7HSRLyCUj9JIBMS
   UK8Ad4Oe2fk1PruyyNcrc90sjPN69QyizL0M8AKzGH38IM/IvtElCTzlb
   9xhLpKj9w1v42cUnI4Rdl4F1SGjkRZU6MSF84NW6bI/y7fU/eU8EAIa85
   8J0mGavxdKGJDfIIO6ll9S+wqpsdxjk3Mz/QVH/zCbkahCXJW64vottkh
   662qO//QnEFveGZTM5OuNg9+ttCY7x7mTHCtknAXBf3iTFxpMo5i8AWeS
   w==;
X-CSE-ConnectionGUID: hg+uesSwRyuOnp0FVlpR1A==
X-CSE-MsgGUID: 7jB/VReQRMOGpGADKcX/DQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11566"; a="61208812"
X-IronPort-AV: E=Sophos;i="6.18,299,1751266800"; 
   d="scan'208";a="61208812"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2025 00:55:46 -0700
X-CSE-ConnectionGUID: BhwEJIKlQuCKxQ/WJtlwiQ==
X-CSE-MsgGUID: U64EUbPIRaCqozNDgXR85g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,299,1751266800"; 
   d="scan'208";a="178363640"
Received: from lkp-server02.sh.intel.com (HELO 84c55410ccf6) ([10.239.97.151])
  by fmviesa008.fm.intel.com with ESMTP; 28 Sep 2025 00:55:44 -0700
Received: from kbuild by 84c55410ccf6 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v2mFk-0007dD-26;
	Sun, 28 Sep 2025 07:55:42 +0000
Date: Sun, 28 Sep 2025 15:54:39 +0800
From: kernel test robot <lkp@intel.com>
To: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 be812ace0378a9db86344ad637c5ed2a5d11f216
Message-ID: <202509281532.CYe2b1iC-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: be812ace0378a9db86344ad637c5ed2a5d11f216  Bluetooth: Avoid a couple dozen -Wflex-array-member-not-at-end warnings

elapsed time: 928m

configs tested: 129
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    gcc-15.1.0
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    gcc-15.1.0
arc                                 defconfig    gcc-15.1.0
arc                 nsimosci_hs_smp_defconfig    gcc-15.1.0
arc                   randconfig-001-20250928    gcc-8.5.0
arc                   randconfig-002-20250928    gcc-8.5.0
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    gcc-15.1.0
arm                       multi_v4t_defconfig    clang-16
arm                   randconfig-001-20250928    clang-22
arm                   randconfig-002-20250928    clang-22
arm                   randconfig-003-20250928    clang-22
arm                   randconfig-004-20250928    clang-22
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20250928    gcc-15.1.0
arm64                 randconfig-002-20250928    gcc-9.5.0
arm64                 randconfig-003-20250928    clang-17
arm64                 randconfig-004-20250928    clang-22
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    gcc-15.1.0
csky                  randconfig-001-20250928    gcc-14.3.0
csky                  randconfig-002-20250928    gcc-15.1.0
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-22
hexagon               randconfig-001-20250928    clang-22
hexagon               randconfig-002-20250928    clang-22
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20250928    clang-20
i386        buildonly-randconfig-002-20250928    clang-20
i386        buildonly-randconfig-003-20250928    gcc-14
i386        buildonly-randconfig-004-20250928    clang-20
i386        buildonly-randconfig-005-20250928    clang-20
i386        buildonly-randconfig-006-20250928    clang-20
i386                                defconfig    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch             randconfig-001-20250928    gcc-15.1.0
loongarch             randconfig-002-20250928    gcc-15.1.0
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
m68k                          amiga_defconfig    gcc-15.1.0
m68k                          hp300_defconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                          ath25_defconfig    clang-22
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20250928    gcc-11.5.0
nios2                 randconfig-002-20250928    gcc-8.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250928    gcc-14.3.0
parisc                randconfig-002-20250928    gcc-15.1.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-22
powerpc                       holly_defconfig    clang-22
powerpc               randconfig-001-20250928    gcc-8.5.0
powerpc               randconfig-002-20250928    clang-22
powerpc               randconfig-003-20250928    gcc-8.5.0
powerpc64             randconfig-001-20250928    gcc-10.5.0
powerpc64             randconfig-002-20250928    clang-20
powerpc64             randconfig-003-20250928    clang-22
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-22
riscv                 randconfig-001-20250928    gcc-11.5.0
riscv                 randconfig-002-20250928    gcc-13.4.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    clang-22
s390                  randconfig-001-20250928    gcc-8.5.0
s390                  randconfig-002-20250928    clang-18
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                    randconfig-001-20250928    gcc-15.1.0
sh                    randconfig-002-20250928    gcc-11.5.0
sh                             sh03_defconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250928    gcc-15.1.0
sparc                 randconfig-002-20250928    gcc-15.1.0
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20250928    gcc-8.5.0
sparc64               randconfig-002-20250928    clang-22
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-14
um                                  defconfig    clang-22
um                             i386_defconfig    gcc-14
um                    randconfig-001-20250928    gcc-14
um                    randconfig-002-20250928    clang-19
um                           x86_64_defconfig    clang-22
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250928    gcc-14
x86_64      buildonly-randconfig-002-20250928    gcc-14
x86_64      buildonly-randconfig-003-20250928    gcc-14
x86_64      buildonly-randconfig-004-20250928    gcc-14
x86_64      buildonly-randconfig-005-20250928    clang-20
x86_64      buildonly-randconfig-006-20250928    clang-20
x86_64                              defconfig    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250928    gcc-8.5.0
xtensa                randconfig-002-20250928    gcc-10.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
