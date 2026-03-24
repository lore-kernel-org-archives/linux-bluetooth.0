Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AC482FFFB8
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Mar 2026 17:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774374062; cv=none; b=CjT2Fjp5jz8NA2kxBQZEijEN/Ea8VTzsTGOyBgaL9Yj8acgAItVVTksdj0V/835cRtt4NVND3ccbJCXDmR1dTuyOHtvokYOkfFTTxrPP0i+BaVlNgABVariE8nlGRbV/6iWZmdW+yGA1p7c/LbWEraXvBbSs57GUrXh4MJcYFB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774374062; c=relaxed/simple;
	bh=HDhChax9CMrUw+PkhKnWWgIf/6RwC+knOQZyACexLno=;
	h=Date:From:To:Cc:Subject:Message-ID; b=ZrYbZf1tn97qGZyzLltZupsnfwqdPj7gOMvFlVe/Nm/c9z6pAR2tE/Rj4uXBTKUI6jRFVBD5cUEpX5+6bWYpnsAbETLxeQypb7WGAtGxs46C17vFbdM34d4EiA4BTkplTzUO0SLUNJqWiU1Cv55EskRTp8/nYrl0FBi3ZVHxxLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VAt5LhtG; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VAt5LhtG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774374061; x=1805910061;
  h=date:from:to:cc:subject:message-id;
  bh=HDhChax9CMrUw+PkhKnWWgIf/6RwC+knOQZyACexLno=;
  b=VAt5LhtGmNvqRK5yhbrVwQwjrqw8etr1NoSyBrigaybrDfAoWHExrRv+
   TuTycEL6oW2QVK4AhdbAzs1zqXCljgksH9V63DKTn/xSw14J1h320T7VT
   SLFoifVZDUutK7xZsECRvKtX2STbuSIPhge1yWNkD7H44hG/EbI+TvkVo
   TchOeAiJDLqDVIUOVixf0Vn88R1dMYd+XBuhfH+Psb51d2dHqYwNXMxLz
   zz5bs5etGpWswOd2eaym8i6C6EYh0399V/Kgg/nx7iIGfIztjEkfpxZce
   Mca9UTT/aFscRucUCfMu9WUeKHbAXtXxpGeh0PUnDNlsQ/Qm22B6eC5Mf
   g==;
X-CSE-ConnectionGUID: YgeXNjppSyKAGDt1b/KmCw==
X-CSE-MsgGUID: jR7mVziQQByq6Ubp5fJr+A==
X-IronPort-AV: E=McAfee;i="6800,10657,11739"; a="98021969"
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="98021969"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2026 10:41:01 -0700
X-CSE-ConnectionGUID: plB6AHFaQSipld//7cQDDg==
X-CSE-MsgGUID: sqjFJCrjTXmPK1Zrwth3wQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="224386821"
Received: from lkp-server01.sh.intel.com (HELO 3905d212be1b) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 24 Mar 2026 10:40:59 -0700
Received: from kbuild by 3905d212be1b with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w55kO-0000000054D-2M7o;
	Tue, 24 Mar 2026 17:40:56 +0000
Date: Wed, 25 Mar 2026 01:40:45 +0800
From: kernel test robot <lkp@intel.com>
To: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 acf374fce194d131a220bdeea0fdbfb9d275dc77
Message-ID: <202603250136.snB6ySsn-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: acf374fce194d131a220bdeea0fdbfb9d275dc77  Bluetooth: L2CAP: Fix ERTM re-init and zero pdu_len infinite loop

elapsed time: 1305m

configs tested: 222
configs skipped: 7

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
alpha                               defconfig    gcc-15.2.0
arc                              allmodconfig    clang-16
arc                              allmodconfig    gcc-15.2.0
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    clang-23
arc                                 defconfig    gcc-15.2.0
arc                   randconfig-001-20260324    gcc-8.5.0
arc                   randconfig-002-20260324    gcc-8.5.0
arm                               allnoconfig    clang-23
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                              allyesconfig    gcc-15.2.0
arm                                 defconfig    gcc-15.2.0
arm                   randconfig-001-20260324    gcc-8.5.0
arm                   randconfig-002-20260324    gcc-8.5.0
arm                   randconfig-003-20260324    gcc-8.5.0
arm                   randconfig-004-20260324    gcc-8.5.0
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260324    gcc-13.4.0
arm64                 randconfig-002-20260324    gcc-13.4.0
arm64                 randconfig-002-20260324    gcc-8.5.0
arm64                 randconfig-003-20260324    clang-23
arm64                 randconfig-003-20260324    gcc-13.4.0
arm64                 randconfig-004-20260324    clang-23
arm64                 randconfig-004-20260324    gcc-13.4.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260324    gcc-13.4.0
csky                  randconfig-001-20260324    gcc-15.2.0
csky                  randconfig-002-20260324    gcc-13.4.0
csky                  randconfig-002-20260324    gcc-15.2.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    clang-23
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    gcc-15.2.0
hexagon               randconfig-001-20260324    clang-23
hexagon               randconfig-001-20260324    gcc-11.5.0
hexagon               randconfig-002-20260324    clang-23
hexagon               randconfig-002-20260324    gcc-11.5.0
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260324    gcc-12
i386        buildonly-randconfig-002-20260324    gcc-12
i386        buildonly-randconfig-003-20260324    gcc-12
i386        buildonly-randconfig-004-20260324    gcc-12
i386        buildonly-randconfig-005-20260324    gcc-12
i386        buildonly-randconfig-006-20260324    gcc-12
i386                                defconfig    gcc-15.2.0
i386                  randconfig-001-20260324    clang-20
i386                  randconfig-001-20260324    gcc-14
i386                  randconfig-002-20260324    clang-20
i386                  randconfig-003-20260324    clang-20
i386                  randconfig-004-20260324    clang-20
i386                  randconfig-005-20260324    clang-20
i386                  randconfig-006-20260324    clang-20
i386                  randconfig-006-20260324    gcc-14
i386                  randconfig-007-20260324    clang-20
i386                  randconfig-007-20260324    gcc-14
i386                  randconfig-011-20260324    gcc-13
i386                  randconfig-012-20260324    gcc-13
i386                  randconfig-013-20260324    gcc-13
i386                  randconfig-014-20260324    gcc-13
i386                  randconfig-015-20260324    gcc-13
i386                  randconfig-016-20260324    gcc-13
i386                  randconfig-017-20260324    gcc-13
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    clang-23
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260324    gcc-11.5.0
loongarch             randconfig-001-20260324    gcc-14.3.0
loongarch             randconfig-002-20260324    clang-18
loongarch             randconfig-002-20260324    gcc-11.5.0
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    clang-16
m68k                             allyesconfig    gcc-15.2.0
m68k                                defconfig    clang-19
m68k                        m5407c3_defconfig    gcc-15.2.0
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    clang-19
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
mips                           mtx1_defconfig    clang-23
nios2                            allmodconfig    clang-23
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    clang-23
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-19
nios2                 randconfig-001-20260324    gcc-11.5.0
nios2                 randconfig-002-20260324    gcc-11.5.0
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
parisc                randconfig-001-20260324    gcc-8.5.0
parisc                randconfig-002-20260324    gcc-8.5.0
parisc64                            defconfig    clang-19
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-23
powerpc                           allnoconfig    gcc-15.2.0
powerpc               randconfig-001-20260324    gcc-8.5.0
powerpc               randconfig-002-20260324    gcc-8.5.0
powerpc                  storcenter_defconfig    gcc-15.2.0
powerpc64             randconfig-001-20260324    gcc-8.5.0
powerpc64             randconfig-002-20260324    gcc-8.5.0
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-15.2.0
riscv                 randconfig-001-20260324    clang-23
riscv                 randconfig-002-20260324    clang-23
s390                             allmodconfig    clang-18
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    gcc-15.2.0
s390                  randconfig-001-20260324    clang-23
s390                  randconfig-002-20260324    clang-23
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-23
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    clang-19
sh                               allyesconfig    gcc-15.2.0
sh                                  defconfig    gcc-14
sh                                  defconfig    gcc-15.2.0
sh                    randconfig-001-20260324    clang-23
sh                    randconfig-002-20260324    clang-23
sparc                             allnoconfig    clang-23
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260324    gcc-14
sparc                 randconfig-001-20260324    gcc-15.2.0
sparc                 randconfig-002-20260324    gcc-14
sparc                 randconfig-002-20260324    gcc-15.2.0
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    clang-20
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260324    clang-23
sparc64               randconfig-001-20260324    gcc-14
sparc64               randconfig-002-20260324    clang-20
sparc64               randconfig-002-20260324    gcc-14
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-14
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    clang-23
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260324    gcc-14
um                    randconfig-002-20260324    clang-17
um                    randconfig-002-20260324    gcc-14
um                           x86_64_defconfig    clang-23
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260324    gcc-14
x86_64      buildonly-randconfig-002-20260324    clang-20
x86_64      buildonly-randconfig-002-20260324    gcc-14
x86_64      buildonly-randconfig-003-20260324    clang-20
x86_64      buildonly-randconfig-003-20260324    gcc-14
x86_64      buildonly-randconfig-004-20260324    gcc-14
x86_64      buildonly-randconfig-005-20260324    gcc-12
x86_64      buildonly-randconfig-005-20260324    gcc-14
x86_64      buildonly-randconfig-006-20260324    clang-20
x86_64      buildonly-randconfig-006-20260324    gcc-14
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260324    clang-20
x86_64                randconfig-002-20260324    clang-20
x86_64                randconfig-003-20260324    clang-20
x86_64                randconfig-004-20260324    clang-20
x86_64                randconfig-005-20260324    clang-20
x86_64                randconfig-006-20260324    clang-20
x86_64                randconfig-011-20260324    gcc-14
x86_64                randconfig-012-20260324    gcc-14
x86_64                randconfig-013-20260324    gcc-14
x86_64                randconfig-014-20260324    gcc-14
x86_64                randconfig-015-20260324    gcc-14
x86_64                randconfig-016-20260324    gcc-14
x86_64                randconfig-071-20260324    gcc-12
x86_64                randconfig-072-20260324    gcc-12
x86_64                randconfig-073-20260324    gcc-12
x86_64                randconfig-074-20260324    gcc-12
x86_64                randconfig-075-20260324    gcc-12
x86_64                randconfig-076-20260324    gcc-12
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
xtensa                randconfig-001-20260324    gcc-14
xtensa                randconfig-001-20260324    gcc-8.5.0
xtensa                randconfig-002-20260324    gcc-14
xtensa                randconfig-002-20260324    gcc-14.3.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
