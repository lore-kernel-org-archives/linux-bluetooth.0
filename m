Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7CB622259F
	for <linux-bluetooth@vger.kernel.org>; Sat, 21 Mar 2026 13:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774098972; cv=none; b=DCXrOVhTDnLbkNFD+OIE4tQhvizpmv20ZS2SOAQhBI4J2XFCozTBQ8uIbGWy8J+UVSwyBe1AAMd/SEqO1YmFFYPBTXYI6sYPXdmK8hkk6hdQ37ehPhOFT9noYJdfHzYaXlRxZXppf2f+AaAmoqg24px1nI+/0AnQK0LIkqgLSKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774098972; c=relaxed/simple;
	bh=R+nKtAAx9Shj/tzMNBvTmFtT/qZBCtHVmF0VBng5L9A=;
	h=Date:From:To:Cc:Subject:Message-ID; b=XHlkTYUCA2wlP8yNZ9EUvlF2YkkCGRtukI5XDDP3veMJcF4MR+aJ4aLpWHa6fy0bOrro9zMI54AXt8jU4l/qzN4rlUbycVJSqyulAIKS9rXqPkHLE8cpaTH2hqerpoPX7WC99t8oj+XAkcDU3vER6m7rvg2j8PQHpMRTpIG7zuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fasuy8BG; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fasuy8BG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774098970; x=1805634970;
  h=date:from:to:cc:subject:message-id;
  bh=R+nKtAAx9Shj/tzMNBvTmFtT/qZBCtHVmF0VBng5L9A=;
  b=fasuy8BGibhRnl1VWHt2QzMeVgINC+HbEHvrLfPVFUbIsRETV4QOPruG
   EtNPownant0cIH+78G508FiufftVN0weKcTO9HGHs5sthbviFvGJHvtWT
   XtfeDhXp3oT/sYzFYlXb6DrHMYz6yoGBJXwFy2uwd8dbUnOn2CWk1vGIx
   +jOQ5QpqxocgWxgpFZzJchx23tSDSYtXhuM77jzDCZ97m2aIS6bScxwhs
   OfuzropbTO6MX5DE5/8oKpqvV33wUehLugRRYpy3Q2JhavljAvSrrARTg
   1tA3u3z+iTzvDZZxo+9wVrVszIL20RvnG6/W1vvsT+dm3s48nKQ4n2wJo
   w==;
X-CSE-ConnectionGUID: TA9YkFKMRJKPNpnHnl6b4Q==
X-CSE-MsgGUID: La4TiQedSlCHy6YhWPwc9w==
X-IronPort-AV: E=McAfee;i="6800,10657,11735"; a="74189192"
X-IronPort-AV: E=Sophos;i="6.23,133,1770624000"; 
   d="scan'208";a="74189192"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2026 06:16:09 -0700
X-CSE-ConnectionGUID: UVevm3tTRQG7aAzc9q4PGg==
X-CSE-MsgGUID: 7poL+HXiRKqBuVQ06T6CPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,133,1770624000"; 
   d="scan'208";a="228281607"
Received: from lkp-server02.sh.intel.com (HELO d7fefbca0d04) ([10.239.97.151])
  by fmviesa005.fm.intel.com with ESMTP; 21 Mar 2026 06:16:08 -0700
Received: from kbuild by d7fefbca0d04 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w3wBR-000000000nl-3IHx;
	Sat, 21 Mar 2026 13:16:05 +0000
Date: Sat, 21 Mar 2026 21:15:17 +0800
From: kernel test robot <lkp@intel.com>
To: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 eae2412ea6f80623e44075912f12037449ccc38d
Message-ID: <202603212111.Jssi5Pd5-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: eae2412ea6f80623e44075912f12037449ccc38d  Bluetooth: L2CAP: Fix regressions caused by reusing ident

elapsed time: 2570m

configs tested: 294
configs skipped: 8

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
alpha                               defconfig    gcc-15.2.0
arc                              allmodconfig    clang-16
arc                              allmodconfig    gcc-15.2.0
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    clang-19
arc                              allyesconfig    clang-23
arc                              allyesconfig    gcc-15.2.0
arc                                 defconfig    gcc-15.2.0
arc                   randconfig-001-20260320    gcc-13.4.0
arc                   randconfig-001-20260321    gcc-8.5.0
arc                   randconfig-002-20260320    gcc-13.4.0
arc                   randconfig-002-20260321    gcc-8.5.0
arm                               allnoconfig    clang-23
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                              allyesconfig    gcc-15.2.0
arm                                 defconfig    gcc-15.2.0
arm                           h3600_defconfig    gcc-15.2.0
arm                   randconfig-001-20260320    gcc-13.4.0
arm                   randconfig-001-20260321    gcc-8.5.0
arm                   randconfig-002-20260320    gcc-13.4.0
arm                   randconfig-002-20260321    gcc-8.5.0
arm                   randconfig-003-20260320    gcc-13.4.0
arm                   randconfig-003-20260321    gcc-8.5.0
arm                   randconfig-004-20260320    gcc-13.4.0
arm                   randconfig-004-20260321    gcc-8.5.0
arm64                            allmodconfig    clang-19
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260320    clang-17
arm64                 randconfig-001-20260321    clang-23
arm64                 randconfig-002-20260320    clang-17
arm64                 randconfig-002-20260321    clang-23
arm64                 randconfig-003-20260320    clang-17
arm64                 randconfig-003-20260321    clang-23
arm64                 randconfig-004-20260320    clang-17
arm64                 randconfig-004-20260321    clang-23
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260320    clang-17
csky                  randconfig-001-20260321    clang-23
csky                  randconfig-002-20260320    clang-17
csky                  randconfig-002-20260321    clang-23
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    clang-23
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    gcc-15.2.0
hexagon               randconfig-001-20260320    clang-23
hexagon               randconfig-001-20260320    gcc-8.5.0
hexagon               randconfig-001-20260321    gcc-11.5.0
hexagon               randconfig-002-20260320    clang-19
hexagon               randconfig-002-20260320    gcc-8.5.0
hexagon               randconfig-002-20260321    gcc-11.5.0
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260320    gcc-14
i386        buildonly-randconfig-001-20260321    clang-20
i386        buildonly-randconfig-002-20260320    gcc-14
i386        buildonly-randconfig-002-20260321    clang-20
i386        buildonly-randconfig-003-20260320    clang-20
i386        buildonly-randconfig-003-20260320    gcc-14
i386        buildonly-randconfig-003-20260321    clang-20
i386        buildonly-randconfig-004-20260320    gcc-14
i386        buildonly-randconfig-004-20260321    clang-20
i386        buildonly-randconfig-005-20260320    clang-20
i386        buildonly-randconfig-005-20260320    gcc-14
i386        buildonly-randconfig-005-20260321    clang-20
i386        buildonly-randconfig-006-20260320    clang-20
i386        buildonly-randconfig-006-20260320    gcc-14
i386        buildonly-randconfig-006-20260321    clang-20
i386                                defconfig    gcc-15.2.0
i386                  randconfig-001-20260320    clang-20
i386                  randconfig-001-20260321    gcc-14
i386                  randconfig-002-20260320    clang-20
i386                  randconfig-002-20260321    gcc-14
i386                  randconfig-003-20260320    clang-20
i386                  randconfig-003-20260321    gcc-14
i386                  randconfig-004-20260320    clang-20
i386                  randconfig-004-20260321    gcc-14
i386                  randconfig-005-20260320    clang-20
i386                  randconfig-005-20260321    gcc-14
i386                  randconfig-006-20260320    clang-20
i386                  randconfig-006-20260321    gcc-14
i386                  randconfig-007-20260320    clang-20
i386                  randconfig-007-20260321    gcc-14
i386                  randconfig-011-20260320    clang-20
i386                  randconfig-011-20260321    gcc-12
i386                  randconfig-012-20260320    clang-20
i386                  randconfig-012-20260321    gcc-12
i386                  randconfig-013-20260320    clang-20
i386                  randconfig-013-20260321    gcc-12
i386                  randconfig-014-20260320    clang-20
i386                  randconfig-014-20260321    gcc-12
i386                  randconfig-015-20260320    clang-20
i386                  randconfig-015-20260321    gcc-12
i386                  randconfig-016-20260320    clang-20
i386                  randconfig-016-20260321    gcc-12
i386                  randconfig-017-20260320    clang-20
i386                  randconfig-017-20260321    gcc-12
loongarch                        allmodconfig    clang-19
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    clang-23
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260320    clang-23
loongarch             randconfig-001-20260320    gcc-8.5.0
loongarch             randconfig-001-20260321    gcc-11.5.0
loongarch             randconfig-002-20260320    clang-18
loongarch             randconfig-002-20260320    gcc-8.5.0
loongarch             randconfig-002-20260321    gcc-11.5.0
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    clang-16
m68k                             allyesconfig    gcc-15.2.0
m68k                                defconfig    clang-19
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    clang-19
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
nios2                            allmodconfig    clang-23
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    clang-23
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-19
nios2                 randconfig-001-20260320    gcc-11.5.0
nios2                 randconfig-001-20260320    gcc-8.5.0
nios2                 randconfig-001-20260321    gcc-11.5.0
nios2                 randconfig-002-20260320    gcc-8.5.0
nios2                 randconfig-002-20260321    gcc-11.5.0
openrisc                         allmodconfig    clang-23
openrisc                         allmodconfig    gcc-15.2.0
openrisc                          allnoconfig    clang-23
openrisc                          allnoconfig    gcc-15.2.0
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    clang-23
parisc                            allnoconfig    gcc-15.2.0
parisc                           allyesconfig    clang-19
parisc                           allyesconfig    gcc-15.2.0
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260320    gcc-10.5.0
parisc                randconfig-001-20260321    clang-23
parisc                randconfig-002-20260320    gcc-10.5.0
parisc                randconfig-002-20260321    clang-23
parisc64                            defconfig    clang-19
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-23
powerpc                           allnoconfig    gcc-15.2.0
powerpc                      ep88xc_defconfig    gcc-15.2.0
powerpc                 mpc832x_rdb_defconfig    gcc-15.2.0
powerpc               randconfig-001-20260320    gcc-10.5.0
powerpc               randconfig-001-20260321    clang-23
powerpc               randconfig-002-20260320    gcc-10.5.0
powerpc               randconfig-002-20260321    clang-23
powerpc64             randconfig-001-20260320    gcc-10.5.0
powerpc64             randconfig-001-20260321    clang-23
powerpc64             randconfig-002-20260320    gcc-10.5.0
powerpc64             randconfig-002-20260321    clang-23
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-15.2.0
riscv                 randconfig-001-20260320    gcc-8.5.0
riscv                 randconfig-001-20260321    clang-23
riscv                 randconfig-002-20260320    clang-23
riscv                 randconfig-002-20260320    gcc-8.5.0
riscv                 randconfig-002-20260321    clang-23
s390                             allmodconfig    clang-18
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    gcc-15.2.0
s390                  randconfig-001-20260320    gcc-13.4.0
s390                  randconfig-001-20260320    gcc-8.5.0
s390                  randconfig-001-20260321    clang-23
s390                  randconfig-002-20260320    gcc-8.5.0
s390                  randconfig-002-20260321    clang-23
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-23
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    clang-19
sh                               allyesconfig    gcc-15.2.0
sh                                  defconfig    gcc-14
sh                        edosk7760_defconfig    gcc-15.2.0
sh                    randconfig-001-20260320    gcc-15.2.0
sh                    randconfig-001-20260320    gcc-8.5.0
sh                    randconfig-001-20260321    clang-23
sh                    randconfig-002-20260320    gcc-12.5.0
sh                    randconfig-002-20260320    gcc-8.5.0
sh                    randconfig-002-20260321    clang-23
sparc                             allnoconfig    clang-23
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260320    gcc-14
sparc                 randconfig-001-20260321    gcc-14
sparc                 randconfig-002-20260320    gcc-14
sparc                 randconfig-002-20260321    gcc-14
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260320    gcc-14
sparc64               randconfig-001-20260321    gcc-14
sparc64               randconfig-002-20260320    gcc-14
sparc64               randconfig-002-20260321    gcc-14
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-14
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260320    gcc-14
um                    randconfig-001-20260321    gcc-14
um                    randconfig-002-20260320    gcc-14
um                    randconfig-002-20260321    gcc-14
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260320    clang-20
x86_64      buildonly-randconfig-001-20260321    clang-20
x86_64      buildonly-randconfig-002-20260320    clang-20
x86_64      buildonly-randconfig-002-20260321    clang-20
x86_64      buildonly-randconfig-003-20260320    clang-20
x86_64      buildonly-randconfig-003-20260321    clang-20
x86_64      buildonly-randconfig-004-20260320    clang-20
x86_64      buildonly-randconfig-004-20260321    clang-20
x86_64      buildonly-randconfig-005-20260320    clang-20
x86_64      buildonly-randconfig-005-20260321    clang-20
x86_64      buildonly-randconfig-006-20260320    clang-20
x86_64      buildonly-randconfig-006-20260321    clang-20
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260320    clang-20
x86_64                randconfig-001-20260321    clang-20
x86_64                randconfig-002-20260320    clang-20
x86_64                randconfig-002-20260321    clang-20
x86_64                randconfig-003-20260320    clang-20
x86_64                randconfig-003-20260321    clang-20
x86_64                randconfig-004-20260320    clang-20
x86_64                randconfig-004-20260321    clang-20
x86_64                randconfig-005-20260320    clang-20
x86_64                randconfig-005-20260321    clang-20
x86_64                randconfig-006-20260320    clang-20
x86_64                randconfig-006-20260321    clang-20
x86_64                randconfig-011-20260320    gcc-14
x86_64                randconfig-011-20260321    clang-20
x86_64                randconfig-012-20260320    gcc-14
x86_64                randconfig-012-20260321    clang-20
x86_64                randconfig-013-20260320    gcc-14
x86_64                randconfig-013-20260321    clang-20
x86_64                randconfig-014-20260320    gcc-14
x86_64                randconfig-014-20260321    clang-20
x86_64                randconfig-015-20260320    gcc-14
x86_64                randconfig-015-20260321    clang-20
x86_64                randconfig-016-20260320    gcc-14
x86_64                randconfig-016-20260321    clang-20
x86_64                randconfig-071-20260320    gcc-14
x86_64                randconfig-071-20260321    gcc-14
x86_64                randconfig-072-20260320    gcc-14
x86_64                randconfig-072-20260321    gcc-14
x86_64                randconfig-073-20260320    gcc-14
x86_64                randconfig-073-20260321    gcc-14
x86_64                randconfig-074-20260320    gcc-14
x86_64                randconfig-074-20260321    gcc-14
x86_64                randconfig-075-20260320    gcc-14
x86_64                randconfig-075-20260321    gcc-14
x86_64                randconfig-076-20260320    gcc-14
x86_64                randconfig-076-20260321    gcc-14
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    clang-23
xtensa                            allnoconfig    gcc-15.2.0
xtensa                           allyesconfig    clang-23
xtensa                randconfig-001-20260320    gcc-14
xtensa                randconfig-001-20260321    gcc-14
xtensa                randconfig-002-20260320    gcc-14
xtensa                randconfig-002-20260321    gcc-14

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
