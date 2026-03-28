Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 616D227B327
	for <linux-bluetooth@vger.kernel.org>; Sat, 28 Mar 2026 12:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774700671; cv=none; b=OfImLHE9Garg3JVulOysGU16rzjJy+gPrsnC5v5NhoU5tL8/fhI6k8jFs5vZU3cIXmnFOqlxOxWtq9Xy5ltLeqhvwhEJkeJwtYiikoSLuv4JVayFLwqa+fvvNgCppqiy4lFnvS9qz1jge0zarjQKo4laQroSKauRRe4KJH28doI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774700671; c=relaxed/simple;
	bh=TKX4u52Vq4KZj5HCHgeTQxhME0aOsB6ePxTP7xnFark=;
	h=Date:From:To:Cc:Subject:Message-ID; b=GhndCC5W9VtEBMVxvX/Qnu21sAJNo7KtFCq95puVgXCBrJ2q0S5wXLL1bM58H1IROA3Xqgc9dmj+dDtcQuAH6n+eH7g0wf2F+Pu2DbaYo7CNlHoUusWmuW2EJO9cmi2Ze2aPvHiQ9Hz1fcZcn4XlT3Nf1EQXGWv+/UGW8/XPk2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XVU6f581; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XVU6f581"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774700670; x=1806236670;
  h=date:from:to:cc:subject:message-id;
  bh=TKX4u52Vq4KZj5HCHgeTQxhME0aOsB6ePxTP7xnFark=;
  b=XVU6f581aVHjSnx9FeMtqIcuOGWGzs7zCGNjZeeWXg0xWu1pxe4UKcsF
   +jS5UVp9u+3GX4qwCvWf6c/1tVplSEs2dHmrzzU7OPbc33jraZkp3SYph
   bClJTrq0xv1m/37ptk+PjMk1jLfylS5rueiitytiHM8yFqdglNCrm0Q8P
   zlrcCF4/4T0+3CNnTsm6FUEKPwE6mfSTaaNHwSu9nAY3zE1jat/D46Kl3
   SXjqpuwkr0uT9ZCWdoWWU4a5FmQpsPuCXrHt/zcRiZRbEw/URNkW6VSiU
   pu4FxjolzWhksz8hAqGFqIXLkBOZR8mIg2ztFV7Qckh4RuYUaUMMWlzFr
   w==;
X-CSE-ConnectionGUID: PXsRIuYfRWWXT3aOad9bdQ==
X-CSE-MsgGUID: R7klLOOpTQm6uafFJbijXw==
X-IronPort-AV: E=McAfee;i="6800,10657,11742"; a="75657683"
X-IronPort-AV: E=Sophos;i="6.23,146,1770624000"; 
   d="scan'208";a="75657683"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2026 05:24:29 -0700
X-CSE-ConnectionGUID: I0uoRWHcQWuNadlJcXgHJg==
X-CSE-MsgGUID: 89TdygGXS4y6/5LYohd7QQ==
X-ExtLoop1: 1
Received: from lkp-server01.sh.intel.com (HELO 3905d212be1b) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 28 Mar 2026 05:24:28 -0700
Received: from kbuild by 3905d212be1b with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w6SiI-00000000BOz-1Deo;
	Sat, 28 Mar 2026 12:24:26 +0000
Date: Sat, 28 Mar 2026 20:24:01 +0800
From: kernel test robot <lkp@intel.com>
To: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 42ee54fcd11e44651484944c052ca6a85904acd4
Message-ID: <202603282053.6DsBPwRR-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: 42ee54fcd11e44651484944c052ca6a85904acd4  Bluetooth: hci_h4: Fix race during initialization

elapsed time: 1005m

configs tested: 140
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
alpha                               defconfig    gcc-15.2.0
arc                              allmodconfig    gcc-15.2.0
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    gcc-15.2.0
arc                                 defconfig    gcc-15.2.0
arc                   randconfig-001-20260328    gcc-8.5.0
arc                   randconfig-002-20260328    gcc-15.2.0
arm                               allnoconfig    clang-23
arm                              allyesconfig    gcc-15.2.0
arm                                 defconfig    clang-23
arm                   randconfig-001-20260328    gcc-12.5.0
arm                   randconfig-002-20260328    gcc-8.5.0
arm                   randconfig-003-20260328    gcc-8.5.0
arm                   randconfig-004-20260328    gcc-8.5.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.2.0
arm64                 randconfig-001-20260328    gcc-14.3.0
arm64                 randconfig-002-20260328    gcc-14.3.0
arm64                 randconfig-003-20260328    gcc-8.5.0
arm64                 randconfig-004-20260328    gcc-8.5.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260328    gcc-15.2.0
csky                  randconfig-002-20260328    gcc-13.4.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-23
hexagon                             defconfig    clang-23
hexagon               randconfig-001-20260328    clang-23
hexagon               randconfig-002-20260328    clang-23
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260328    clang-20
i386        buildonly-randconfig-002-20260328    gcc-12
i386        buildonly-randconfig-003-20260328    gcc-14
i386        buildonly-randconfig-004-20260328    clang-20
i386        buildonly-randconfig-005-20260328    clang-20
i386        buildonly-randconfig-006-20260328    gcc-14
i386                                defconfig    clang-20
i386                  randconfig-011-20260328    gcc-13
i386                  randconfig-012-20260328    gcc-14
i386                  randconfig-013-20260328    clang-20
i386                  randconfig-014-20260328    gcc-14
i386                  randconfig-015-20260328    gcc-13
i386                  randconfig-016-20260328    gcc-13
i386                  randconfig-017-20260328    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-23
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260328    clang-23
loongarch             randconfig-002-20260328    gcc-15.2.0
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    gcc-15.2.0
m68k                                defconfig    gcc-15.2.0
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    gcc-15.2.0
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20260328    gcc-11.5.0
nios2                 randconfig-002-20260328    gcc-11.5.0
openrisc                         allmodconfig    gcc-15.2.0
openrisc                          allnoconfig    gcc-15.2.0
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    gcc-15.2.0
parisc                           allyesconfig    gcc-15.2.0
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260328    gcc-13.4.0
parisc                randconfig-002-20260328    gcc-8.5.0
parisc64                            defconfig    gcc-15.2.0
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    gcc-15.2.0
powerpc               randconfig-001-20260328    gcc-13.4.0
powerpc               randconfig-002-20260328    gcc-10.5.0
powerpc64             randconfig-001-20260328    gcc-13.4.0
powerpc64             randconfig-002-20260328    gcc-12.5.0
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-23
riscv                    nommu_virt_defconfig    clang-23
riscv                 randconfig-001-20260328    gcc-11.5.0
riscv                 randconfig-002-20260328    clang-17
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    clang-23
s390                  randconfig-001-20260328    clang-16
s390                  randconfig-002-20260328    clang-23
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    gcc-15.2.0
sh                                  defconfig    gcc-15.2.0
sh                    randconfig-001-20260328    gcc-15.2.0
sh                    randconfig-002-20260328    gcc-15.2.0
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260328    gcc-14.3.0
sparc                 randconfig-002-20260328    gcc-8.5.0
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20260328    clang-23
sparc64               randconfig-002-20260328    gcc-8.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-14
um                                  defconfig    clang-23
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260328    gcc-14
um                    randconfig-002-20260328    gcc-14
um                           x86_64_defconfig    clang-23
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260328    gcc-14
x86_64      buildonly-randconfig-002-20260328    clang-20
x86_64      buildonly-randconfig-003-20260328    clang-20
x86_64      buildonly-randconfig-004-20260328    clang-20
x86_64      buildonly-randconfig-005-20260328    gcc-14
x86_64      buildonly-randconfig-006-20260328    clang-20
x86_64                              defconfig    gcc-14
x86_64                randconfig-001-20260328    clang-20
x86_64                randconfig-002-20260328    gcc-13
x86_64                randconfig-003-20260328    gcc-14
x86_64                randconfig-004-20260328    gcc-14
x86_64                randconfig-005-20260328    clang-20
x86_64                randconfig-006-20260328    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.2.0
xtensa                randconfig-001-20260328    gcc-8.5.0
xtensa                randconfig-002-20260328    gcc-10.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
