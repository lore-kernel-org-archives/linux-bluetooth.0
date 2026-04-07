Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00B2926056C
	for <linux-bluetooth@vger.kernel.org>; Tue,  7 Apr 2026 17:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775584109; cv=none; b=ADJldDxC/nRUrpHSd2vyWZ6+HHsrUGB1uPlFcC0oAC76DSPr8gXaVPTkmy4DmkG6r5jvSX/GUn7AhsbcaINhWwaO8gbd/62w5bH2ota5T6d7Pn7fLMDmRI1W9tAspBTvR+QMMmbUSyOZLnSOUTmDIRPt4vADjA3IpPqQDh6Lmhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775584109; c=relaxed/simple;
	bh=yrHJUmQHS5kRCF/Tuaf/RAzODBWbFvCNGC11zJjdn1o=;
	h=Date:From:To:Cc:Subject:Message-ID; b=qAwHnp6tAdtjclkBcDkMaMh4M3DVqd5Z9YYbMbmYGX4X7412SKKW7cwExi2K7zT39Loh5OAxzB5HIv1xKkX8GVnCFmYrlUxVwcu5YXmhoNJy5wqO2jIDz5XXuJ3/7LjjpDGRnSI+p3HXQ0CswRS8tq5RtFJU3KV0vxj4GoWAbZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Vr6oquka; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Vr6oquka"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775584102; x=1807120102;
  h=date:from:to:cc:subject:message-id;
  bh=yrHJUmQHS5kRCF/Tuaf/RAzODBWbFvCNGC11zJjdn1o=;
  b=Vr6oqukaMa7wZqFiJR2AF2favUvIC12vLGyUlP66zbLN4R6v1Fmki+Wz
   3TMpRijt4auIC3yw4lnZI1Vj/jxtQ/yS6wNSMxp/2T06M3s1GYbY2Fr6b
   3gfl4kXwZEhKUY3FyRORJ57mDbjhWa3FqB5X4Eo2GFYlpJ0xSM2YNsT/O
   ajF7WyFWrPZ0YH7FzKOKkRYPHJaJOpErp7LjBbteAUaab6llSPUMfr8Nb
   zHlbkA8XOkEjcMcYl3BKYUNZG6ZniI3mMvQIUDA7e43gikMceUKDJUHJ8
   ScuY8QQAiQuCc2p2MC9HV/6bZJCtcZbJ0CW9VWGPjD4VsJAesbDLiTKV9
   w==;
X-CSE-ConnectionGUID: dLaoDnoNTvC1WVRDNr8uGg==
X-CSE-MsgGUID: BSX4jWQWQt6rBgH7WOHAyg==
X-IronPort-AV: E=McAfee;i="6800,10657,11752"; a="64101462"
X-IronPort-AV: E=Sophos;i="6.23,166,1770624000"; 
   d="scan'208";a="64101462"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2026 10:48:21 -0700
X-CSE-ConnectionGUID: 38lkxEycQFuU6rfh1NwvIw==
X-CSE-MsgGUID: lEJYzvTETNWDSzeURTHQGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,166,1770624000"; 
   d="scan'208";a="258659799"
Received: from lkp-server01.sh.intel.com (HELO d00eb8a6782a) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 07 Apr 2026 10:48:20 -0700
Received: from kbuild by d00eb8a6782a with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wAAXA-000000000rt-39dR;
	Tue, 07 Apr 2026 17:48:16 +0000
Date: Wed, 08 Apr 2026 01:48:09 +0800
From: kernel test robot <lkp@intel.com>
To: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 ff4aaa2d1db81fcb7c078deb667789f75a259284
Message-ID: <202604080100.JqWNPIkv-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: ff4aaa2d1db81fcb7c078deb667789f75a259284  Bluetooth: l2cap: Add missing chan lock in l2cap_ecred_reconf_rsp

elapsed time: 1159m

configs tested: 154
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
arc                   randconfig-001-20260407    gcc-11.5.0
arc                   randconfig-002-20260407    gcc-9.5.0
arm                               allnoconfig    clang-23
arm                              allyesconfig    gcc-15.2.0
arm                                 defconfig    clang-23
arm                   randconfig-001-20260407    gcc-12.5.0
arm                   randconfig-002-20260407    clang-23
arm                   randconfig-003-20260407    gcc-10.5.0
arm                   randconfig-004-20260407    clang-20
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260407    clang-16
arm64                 randconfig-002-20260407    gcc-13.4.0
arm64                 randconfig-003-20260407    gcc-8.5.0
arm64                 randconfig-004-20260407    clang-23
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260407    gcc-13.4.0
csky                  randconfig-002-20260407    gcc-9.5.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-23
hexagon                             defconfig    clang-23
hexagon               randconfig-001-20260407    clang-19
hexagon               randconfig-002-20260407    clang-23
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                             allyesconfig    gcc-14
i386                                defconfig    clang-20
i386                  randconfig-001-20260407    clang-20
i386                  randconfig-002-20260407    gcc-14
i386                  randconfig-003-20260407    clang-20
i386                  randconfig-004-20260407    gcc-14
i386                  randconfig-005-20260407    clang-20
i386                  randconfig-006-20260407    gcc-14
i386                  randconfig-007-20260407    gcc-14
i386                  randconfig-011-20260407    gcc-14
i386                  randconfig-012-20260407    clang-20
i386                  randconfig-013-20260407    clang-20
i386                  randconfig-014-20260407    clang-20
i386                  randconfig-015-20260407    gcc-14
i386                  randconfig-016-20260407    clang-20
i386                  randconfig-017-20260407    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-23
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260407    clang-23
loongarch             randconfig-002-20260407    gcc-15.2.0
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
nios2                 randconfig-001-20260407    gcc-11.5.0
nios2                 randconfig-002-20260407    gcc-11.5.0
openrisc                         allmodconfig    gcc-15.2.0
openrisc                          allnoconfig    gcc-15.2.0
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    gcc-15.2.0
parisc                           allyesconfig    gcc-15.2.0
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260407    gcc-8.5.0
parisc                randconfig-002-20260407    gcc-8.5.0
parisc64                            defconfig    gcc-15.2.0
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    gcc-15.2.0
powerpc               randconfig-001-20260407    gcc-13.4.0
powerpc               randconfig-002-20260407    gcc-8.5.0
powerpc64             randconfig-001-20260407    gcc-12.5.0
powerpc64             randconfig-002-20260407    gcc-10.5.0
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-23
riscv                 randconfig-001-20260407    clang-23
riscv                 randconfig-002-20260407    gcc-12.5.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    clang-23
s390                  randconfig-001-20260407    gcc-14.3.0
s390                  randconfig-002-20260407    clang-20
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    gcc-15.2.0
sh                                  defconfig    gcc-15.2.0
sh                    randconfig-001-20260407    gcc-13.4.0
sh                    randconfig-002-20260407    gcc-15.2.0
sh                        sh7785lcr_defconfig    gcc-15.2.0
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260407    gcc-15.2.0
sparc                 randconfig-002-20260407    gcc-15.2.0
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20260407    clang-23
sparc64               randconfig-002-20260407    clang-20
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-14
um                                  defconfig    clang-23
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260407    gcc-12
um                    randconfig-002-20260407    gcc-14
um                           x86_64_defconfig    clang-23
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260407    gcc-14
x86_64      buildonly-randconfig-002-20260407    gcc-14
x86_64      buildonly-randconfig-003-20260407    gcc-14
x86_64      buildonly-randconfig-004-20260407    clang-20
x86_64      buildonly-randconfig-005-20260407    gcc-14
x86_64      buildonly-randconfig-006-20260407    gcc-14
x86_64                              defconfig    gcc-14
x86_64                randconfig-001-20260407    clang-20
x86_64                randconfig-002-20260407    clang-20
x86_64                randconfig-003-20260407    clang-20
x86_64                randconfig-004-20260407    gcc-14
x86_64                randconfig-005-20260407    gcc-14
x86_64                randconfig-006-20260407    gcc-14
x86_64                randconfig-011-20260407    gcc-14
x86_64                randconfig-012-20260407    clang-20
x86_64                randconfig-013-20260407    clang-20
x86_64                randconfig-014-20260407    clang-20
x86_64                randconfig-015-20260407    gcc-14
x86_64                randconfig-016-20260407    gcc-14
x86_64                randconfig-071-20260407    clang-20
x86_64                randconfig-072-20260407    clang-20
x86_64                randconfig-073-20260407    clang-20
x86_64                randconfig-074-20260407    clang-20
x86_64                randconfig-075-20260407    clang-20
x86_64                randconfig-076-20260407    clang-20
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.2.0
xtensa                randconfig-001-20260407    gcc-12.5.0
xtensa                randconfig-002-20260407    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
