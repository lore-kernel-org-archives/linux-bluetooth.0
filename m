Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0764926E6F0
	for <linux-bluetooth@vger.kernel.org>; Fri, 19 Dec 2025 21:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766179099; cv=none; b=btseavuvgo2nZMi6XQaQgN66qc/rCfSkjCKV28qNyIeFDK0pM/9bXo2vYahQs3T6aBUfwDgPL9YSl879yOE/oOgehFaPxvQAcscq+JokxjVlIMkMQpQUYZyLEJ94bzF47tdwfPpaat6796S13wwzCxJxJAQBqxB0wbjOjSny984=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766179099; c=relaxed/simple;
	bh=Kp0rNkntYhvclWKRB9ifhO7kNocfmTzFQqxnb4AsVNg=;
	h=Date:From:To:Cc:Subject:Message-ID; b=vGV2LmKkBXoHVrGeS8JIcqR3G1/9hIjL7YT8TM0BSrNcOcxtEakqtUWUQVAZlMqlIF/Ql1aaE2yikutKFqnMgarkKL8kmvp3D5/EvLujieSrttRvgKRZYHzHxAA8E6YwZl5+L+U2aHA7SqEN1HmvoX8dXTdGXATDNdrObBhXGDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VFAXeSE7; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VFAXeSE7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766179098; x=1797715098;
  h=date:from:to:cc:subject:message-id;
  bh=Kp0rNkntYhvclWKRB9ifhO7kNocfmTzFQqxnb4AsVNg=;
  b=VFAXeSE7gpbqhcmLtNiueJKljoaZ/JVvX7DTQ1FGkVcVz1rpoCTVW1oV
   bCVyDt9zymUooWY9n5l5aeGCnJZS6JaaDYDCaScQonlijrYHS+KfUWWva
   MBdIEAMhDiMP5evrw0qY/CD9n3FcBXtOLL9tCQFS/5wkPqm9P54gRM0t3
   6hrl6kJvg/tnvpniQ8pQ8UAn7gGC6WWP5degO83QM8qdGPCk2DaRYsQ2s
   eVdzIhoZKRWIRSO976iXR6065vVPLv2oV6UC3ImFYMQVwvyHPwN+xC+OQ
   EFjpHY8HewKn3yrH5WUaoRupgLn2FsuRO9sCpbpskwz8/c22kffgSqg2K
   g==;
X-CSE-ConnectionGUID: sl9xle8qSpiuOWAJIk65wg==
X-CSE-MsgGUID: IUMtfWl/R9WvXxoCpE+ErA==
X-IronPort-AV: E=McAfee;i="6800,10657,11647"; a="79261000"
X-IronPort-AV: E=Sophos;i="6.21,162,1763452800"; 
   d="scan'208";a="79261000"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2025 13:18:17 -0800
X-CSE-ConnectionGUID: k/xmRQHFS/WOjEnjU6wmMw==
X-CSE-MsgGUID: q1wTfcjwRVGiU1qOWcGWew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,162,1763452800"; 
   d="scan'208";a="198952424"
Received: from lkp-server01.sh.intel.com (HELO 0d09efa1b85f) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 19 Dec 2025 13:18:17 -0800
Received: from kbuild by 0d09efa1b85f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vWhrZ-000000003zl-2rMC;
	Fri, 19 Dec 2025 21:18:13 +0000
Date: Sat, 20 Dec 2025 05:17:43 +0800
From: kernel test robot <lkp@intel.com>
To: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 98246938a0e66e4100e95b6b7881843a9a4e4882
Message-ID: <202512200529.qnOCd3DX-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: 98246938a0e66e4100e95b6b7881843a9a4e4882  Bluetooth: L2CAP: Add support for setting BT_PHY

elapsed time: 1466m

configs tested: 173
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    gcc-15.1.0
arc                              allmodconfig    clang-16
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    clang-22
arc                                 defconfig    gcc-15.1.0
arc                   randconfig-001-20251219    gcc-11.5.0
arc                   randconfig-002-20251219    gcc-11.5.0
arm                               allnoconfig    gcc-15.1.0
arm                              allyesconfig    clang-16
arm                                 defconfig    gcc-15.1.0
arm                        neponset_defconfig    gcc-15.1.0
arm                   randconfig-001-20251219    gcc-11.5.0
arm                   randconfig-002-20251219    gcc-11.5.0
arm                   randconfig-003-20251219    gcc-11.5.0
arm                   randconfig-004-20251219    gcc-11.5.0
arm64                            allmodconfig    clang-22
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    gcc-15.1.0
arm64                 randconfig-001-20251219    gcc-9.5.0
arm64                 randconfig-002-20251219    gcc-9.5.0
arm64                 randconfig-003-20251219    gcc-9.5.0
arm64                 randconfig-004-20251219    gcc-9.5.0
csky                             allmodconfig    gcc-15.1.0
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    gcc-15.1.0
csky                  randconfig-001-20251219    gcc-9.5.0
csky                  randconfig-002-20251219    gcc-9.5.0
hexagon                          allmodconfig    gcc-15.1.0
hexagon                           allnoconfig    gcc-15.1.0
hexagon                             defconfig    gcc-15.1.0
hexagon               randconfig-001-20251219    gcc-11.5.0
hexagon               randconfig-002-20251219    gcc-11.5.0
i386                             allmodconfig    clang-20
i386                              allnoconfig    gcc-15.1.0
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20251219    clang-20
i386        buildonly-randconfig-002-20251219    clang-20
i386        buildonly-randconfig-003-20251219    clang-20
i386        buildonly-randconfig-004-20251219    clang-20
i386        buildonly-randconfig-005-20251219    clang-20
i386        buildonly-randconfig-006-20251219    clang-20
i386                                defconfig    gcc-15.1.0
i386                  randconfig-001-20251219    clang-20
i386                  randconfig-002-20251219    clang-20
i386                  randconfig-003-20251219    clang-20
i386                  randconfig-004-20251219    clang-20
i386                  randconfig-005-20251219    clang-20
i386                  randconfig-006-20251219    clang-20
i386                  randconfig-007-20251219    clang-20
i386                  randconfig-011-20251219    gcc-14
i386                  randconfig-012-20251219    gcc-14
i386                  randconfig-013-20251219    gcc-14
i386                  randconfig-014-20251219    gcc-14
i386                  randconfig-015-20251219    gcc-14
i386                  randconfig-016-20251219    gcc-14
i386                  randconfig-017-20251219    gcc-14
loongarch                        allmodconfig    clang-22
loongarch                         allnoconfig    gcc-15.1.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20251219    gcc-11.5.0
loongarch             randconfig-002-20251219    gcc-11.5.0
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    clang-16
m68k                                defconfig    clang-19
m68k                          multi_defconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    clang-19
mips                             allmodconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                             allyesconfig    gcc-15.1.0
nios2                            allmodconfig    clang-22
nios2                             allnoconfig    clang-22
nios2                               defconfig    clang-19
nios2                 randconfig-001-20251219    gcc-11.5.0
nios2                 randconfig-002-20251219    gcc-11.5.0
openrisc                         allmodconfig    clang-22
openrisc                          allnoconfig    clang-22
openrisc                            defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    clang-22
parisc                           allyesconfig    clang-19
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20251219    clang-22
parisc                randconfig-002-20251219    clang-22
parisc64                            defconfig    clang-19
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-22
powerpc                   bluestone_defconfig    gcc-15.1.0
powerpc                     mpc5200_defconfig    gcc-15.1.0
powerpc                 mpc832x_rdb_defconfig    gcc-15.1.0
powerpc               randconfig-001-20251219    clang-22
powerpc               randconfig-002-20251219    clang-22
powerpc                     tqm8541_defconfig    gcc-15.1.0
powerpc64             randconfig-001-20251219    clang-22
powerpc64             randconfig-002-20251219    clang-22
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    clang-22
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-15.1.0
riscv                 randconfig-001-20251219    clang-22
riscv                 randconfig-002-20251219    clang-22
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    gcc-15.1.0
s390                  randconfig-001-20251219    clang-22
s390                  randconfig-002-20251219    clang-22
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    clang-22
sh                               allyesconfig    clang-19
sh                                  defconfig    gcc-14
sh                    randconfig-001-20251219    clang-22
sh                    randconfig-002-20251219    clang-22
sparc                             allnoconfig    clang-22
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20251219    gcc-8.5.0
sparc                 randconfig-002-20251219    gcc-8.5.0
sparc64                          allmodconfig    clang-22
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20251219    gcc-8.5.0
sparc64               randconfig-002-20251219    gcc-8.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-15.1.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20251219    gcc-8.5.0
um                    randconfig-002-20251219    gcc-8.5.0
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-22
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20251219    clang-20
x86_64      buildonly-randconfig-002-20251219    clang-20
x86_64      buildonly-randconfig-003-20251219    clang-20
x86_64      buildonly-randconfig-004-20251219    clang-20
x86_64      buildonly-randconfig-005-20251219    clang-20
x86_64      buildonly-randconfig-006-20251219    clang-20
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20251219    gcc-14
x86_64                randconfig-002-20251219    gcc-14
x86_64                randconfig-003-20251219    gcc-14
x86_64                randconfig-004-20251219    gcc-14
x86_64                randconfig-005-20251219    gcc-14
x86_64                randconfig-006-20251219    gcc-14
x86_64                randconfig-011-20251219    clang-20
x86_64                randconfig-012-20251219    clang-20
x86_64                randconfig-013-20251219    clang-20
x86_64                randconfig-014-20251219    clang-20
x86_64                randconfig-015-20251219    clang-20
x86_64                randconfig-016-20251219    clang-20
x86_64                randconfig-071-20251219    gcc-14
x86_64                randconfig-072-20251219    gcc-14
x86_64                randconfig-073-20251219    gcc-14
x86_64                randconfig-074-20251219    gcc-14
x86_64                randconfig-075-20251219    gcc-14
x86_64                randconfig-076-20251219    gcc-14
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    clang-22
xtensa                           allyesconfig    clang-22
xtensa                randconfig-001-20251219    gcc-8.5.0
xtensa                randconfig-002-20251219    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
