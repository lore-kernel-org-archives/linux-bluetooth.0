Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E7731DDA0
	for <linux-bluetooth@vger.kernel.org>; Wed,  3 Sep 2025 17:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756918889; cv=none; b=HT1btalQGY4j90yIxEN6c0e1zsjW0h7IHPzKzy/WnGeAkflJ7vmLMlXBtqDn1sstQ5uhSrEBDAuZNxoM/GF3iaW9y1LArCcQv6Jbz1dqEBTjcO9ZGKstZm5J3KYrd+fIUQScPp0eZOcms42zS6jDFg6Ydlxc7bXv5NSCktXlFvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756918889; c=relaxed/simple;
	bh=dYUNl0juHnMuOq/p8A1M1lzw7ZEkIKK523NOPywLXLc=;
	h=Date:From:To:Cc:Subject:Message-ID; b=CcXEUMZYaEkCUd0G8V8ItNabS+unGDDZ72rMUXjPbfWWx1pbgo/x3bdwBF94rHEA8F5GNzDPMWIJ4D3Z/4MMxFsrij0PPihrApMo0apQhNfMe5Qndmx8PICFdaWRhHqj9dx0ECiOPevbYYnHrFebvE/Gs6RPcZ4DdVI87vcY6t8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FMlfbnQk; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FMlfbnQk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756918888; x=1788454888;
  h=date:from:to:cc:subject:message-id;
  bh=dYUNl0juHnMuOq/p8A1M1lzw7ZEkIKK523NOPywLXLc=;
  b=FMlfbnQkfv9hCwG9q0Up3gC/62fy4LNoxzYV/iPWimNa9EK8f07bVhv5
   nwMwzR9X8/X5JQjwhpkpU+ncRjL5U7aUAXHR9yN5M2JHMqJZIiuK5pGAu
   x/+7kSN4zPSFr3GBfjWIOQqwg+5iRigFoqGwv1Qz0UHNrIKU5Rqh6duQL
   ZVJ6fzZ1OgWtxyi38bu8hMK7SKCf+H2hZZqiTw4swov25tVG/s6we5/Pg
   zbho5WJGMD/vCwxkYjR0UroUQ6FdZiANN7V9cCpMHnE+4XCzhNEUbBshN
   QECka7usruMCiTZ+jikQ0OEJSBaRFlyjhXTEyGLIa5evFq4GAWRB+jclQ
   w==;
X-CSE-ConnectionGUID: A9EqpIo2SlmuAeWP0b68wA==
X-CSE-MsgGUID: Z7eIZO51SBiTe7zZoS2zhQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="63074565"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="63074565"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2025 10:01:26 -0700
X-CSE-ConnectionGUID: BjKcWcsuTLyHtycJ0tpE7g==
X-CSE-MsgGUID: pvSYfx7HRtewq89Ud9HyoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,236,1751266800"; 
   d="scan'208";a="171585039"
Received: from lkp-server02.sh.intel.com (HELO 06ba48ef64e9) ([10.239.97.151])
  by fmviesa006.fm.intel.com with ESMTP; 03 Sep 2025 10:01:24 -0700
Received: from kbuild by 06ba48ef64e9 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1utqrK-0004Df-0p;
	Wed, 03 Sep 2025 17:01:22 +0000
Date: Thu, 04 Sep 2025 01:00:37 +0800
From: kernel test robot <lkp@intel.com>
To: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 16ebf6c26de558f19ca4b677ab083fbe2e099ac9
Message-ID: <202509040123.5iVcDYkt-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: 16ebf6c26de558f19ca4b677ab083fbe2e099ac9  Bluetooth: Fix build after header cleanup

elapsed time: 1443m

configs tested: 230
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    clang-22
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    clang-19
alpha                            allyesconfig    gcc-15.1.0
arc                              allmodconfig    clang-19
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    clang-22
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    clang-19
arc                              allyesconfig    gcc-15.1.0
arc                   randconfig-001-20250903    gcc-15.1.0
arc                   randconfig-001-20250903    gcc-8.5.0
arc                   randconfig-002-20250903    gcc-8.5.0
arm                              allmodconfig    clang-19
arm                               allnoconfig    clang-22
arm                              allyesconfig    clang-19
arm                              allyesconfig    gcc-15.1.0
arm                         at91_dt_defconfig    clang-22
arm                       imx_v4_v5_defconfig    gcc-15.1.0
arm                             mxs_defconfig    gcc-15.1.0
arm                   randconfig-001-20250903    clang-22
arm                   randconfig-001-20250903    gcc-8.5.0
arm                   randconfig-002-20250903    clang-16
arm                   randconfig-002-20250903    gcc-8.5.0
arm                   randconfig-003-20250903    clang-22
arm                   randconfig-003-20250903    gcc-8.5.0
arm                   randconfig-004-20250903    clang-22
arm                   randconfig-004-20250903    gcc-8.5.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    clang-22
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20250903    gcc-8.5.0
arm64                 randconfig-002-20250903    gcc-11.5.0
arm64                 randconfig-002-20250903    gcc-8.5.0
arm64                 randconfig-003-20250903    clang-22
arm64                 randconfig-003-20250903    gcc-8.5.0
arm64                 randconfig-004-20250903    clang-22
arm64                 randconfig-004-20250903    gcc-8.5.0
csky                              allnoconfig    clang-22
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    clang-22
csky                  randconfig-001-20250903    gcc-10.5.0
csky                  randconfig-001-20250903    gcc-9.5.0
csky                  randconfig-002-20250903    gcc-10.5.0
csky                  randconfig-002-20250903    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-19
hexagon                          allyesconfig    clang-22
hexagon               randconfig-001-20250903    clang-22
hexagon               randconfig-001-20250903    gcc-10.5.0
hexagon               randconfig-002-20250903    clang-18
hexagon               randconfig-002-20250903    gcc-10.5.0
i386                             allmodconfig    clang-20
i386                              allnoconfig    clang-20
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20250903    clang-20
i386        buildonly-randconfig-001-20250903    gcc-12
i386        buildonly-randconfig-002-20250903    clang-20
i386        buildonly-randconfig-002-20250903    gcc-12
i386        buildonly-randconfig-003-20250903    clang-20
i386        buildonly-randconfig-004-20250903    clang-20
i386        buildonly-randconfig-005-20250903    clang-20
i386        buildonly-randconfig-006-20250903    clang-20
i386                                defconfig    clang-20
i386                  randconfig-001-20250903    gcc-13
i386                  randconfig-002-20250903    gcc-13
i386                  randconfig-003-20250903    gcc-13
i386                  randconfig-004-20250903    gcc-13
i386                  randconfig-005-20250903    gcc-13
i386                  randconfig-006-20250903    gcc-13
i386                  randconfig-007-20250903    gcc-13
i386                  randconfig-011-20250903    gcc-13
i386                  randconfig-012-20250903    gcc-13
i386                  randconfig-013-20250903    gcc-13
i386                  randconfig-014-20250903    gcc-13
i386                  randconfig-015-20250903    gcc-13
i386                  randconfig-016-20250903    gcc-13
i386                  randconfig-017-20250903    gcc-13
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch             randconfig-001-20250903    gcc-10.5.0
loongarch             randconfig-001-20250903    gcc-15.1.0
loongarch             randconfig-002-20250903    clang-22
loongarch             randconfig-002-20250903    gcc-10.5.0
m68k                             alldefconfig    clang-22
m68k                             allmodconfig    clang-19
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    clang-19
m68k                             allyesconfig    gcc-15.1.0
m68k                       m5275evb_defconfig    clang-22
m68k                          multi_defconfig    gcc-15.1.0
m68k                        mvme147_defconfig    clang-22
microblaze                       allmodconfig    clang-19
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    clang-19
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                       rbtx49xx_defconfig    clang-22
nios2                             allnoconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-15.1.0
nios2                               defconfig    gcc-15.1.0
nios2                 randconfig-001-20250903    gcc-10.5.0
nios2                 randconfig-002-20250903    gcc-10.5.0
openrisc                          allnoconfig    clang-22
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-13
openrisc                    or1ksim_defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    clang-22
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250903    gcc-10.5.0
parisc                randconfig-001-20250903    gcc-13.4.0
parisc                randconfig-002-20250903    gcc-10.5.0
parisc                randconfig-002-20250903    gcc-15.1.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-22
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    gcc-15.1.0
powerpc                      cm5200_defconfig    clang-22
powerpc                      cm5200_defconfig    gcc-15.1.0
powerpc                      pasemi_defconfig    gcc-15.1.0
powerpc                      pmac32_defconfig    gcc-15.1.0
powerpc               randconfig-001-20250903    gcc-10.5.0
powerpc               randconfig-001-20250903    gcc-8.5.0
powerpc               randconfig-002-20250903    gcc-10.5.0
powerpc               randconfig-002-20250903    gcc-8.5.0
powerpc               randconfig-003-20250903    gcc-10.5.0
powerpc               randconfig-003-20250903    gcc-14.3.0
powerpc64             randconfig-001-20250903    clang-22
powerpc64             randconfig-001-20250903    gcc-10.5.0
powerpc64             randconfig-002-20250903    clang-22
powerpc64             randconfig-002-20250903    gcc-10.5.0
powerpc64             randconfig-003-20250903    clang-22
powerpc64             randconfig-003-20250903    gcc-10.5.0
riscv                            allmodconfig    gcc-15.1.0
riscv                             allnoconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    gcc-15.1.0
riscv                               defconfig    gcc-13
riscv                 randconfig-001-20250903    gcc-12.5.0
riscv                 randconfig-001-20250903    gcc-8.5.0
riscv                 randconfig-002-20250903    gcc-12.5.0
riscv                 randconfig-002-20250903    gcc-9.5.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    gcc-13
s390                  randconfig-001-20250903    gcc-12.5.0
s390                  randconfig-001-20250903    gcc-8.5.0
s390                  randconfig-002-20250903    clang-22
s390                  randconfig-002-20250903    gcc-12.5.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-13
sh                    randconfig-001-20250903    gcc-12.5.0
sh                    randconfig-002-20250903    gcc-10.5.0
sh                    randconfig-002-20250903    gcc-12.5.0
sh                           se7712_defconfig    gcc-15.1.0
sh                            shmin_defconfig    clang-22
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250903    gcc-11.5.0
sparc                 randconfig-001-20250903    gcc-12.5.0
sparc                 randconfig-002-20250903    gcc-12.5.0
sparc                 randconfig-002-20250903    gcc-15.1.0
sparc64                             defconfig    gcc-13
sparc64               randconfig-001-20250903    gcc-12.5.0
sparc64               randconfig-001-20250903    gcc-8.5.0
sparc64               randconfig-002-20250903    gcc-11.5.0
sparc64               randconfig-002-20250903    gcc-12.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    clang-19
um                               allyesconfig    gcc-12
um                                  defconfig    gcc-13
um                             i386_defconfig    gcc-13
um                    randconfig-001-20250903    gcc-12
um                    randconfig-001-20250903    gcc-12.5.0
um                    randconfig-002-20250903    clang-18
um                    randconfig-002-20250903    gcc-12.5.0
um                           x86_64_defconfig    gcc-13
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250903    clang-20
x86_64      buildonly-randconfig-002-20250903    clang-20
x86_64      buildonly-randconfig-003-20250903    clang-20
x86_64      buildonly-randconfig-004-20250903    clang-20
x86_64      buildonly-randconfig-004-20250903    gcc-12
x86_64      buildonly-randconfig-005-20250903    clang-20
x86_64      buildonly-randconfig-006-20250903    clang-20
x86_64      buildonly-randconfig-006-20250903    gcc-12
x86_64                              defconfig    clang-20
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20250903    clang-20
x86_64                randconfig-002-20250903    clang-20
x86_64                randconfig-003-20250903    clang-20
x86_64                randconfig-004-20250903    clang-20
x86_64                randconfig-005-20250903    clang-20
x86_64                randconfig-006-20250903    clang-20
x86_64                randconfig-007-20250903    clang-20
x86_64                randconfig-008-20250903    clang-20
x86_64                randconfig-071-20250903    clang-20
x86_64                randconfig-072-20250903    clang-20
x86_64                randconfig-073-20250903    clang-20
x86_64                randconfig-074-20250903    clang-20
x86_64                randconfig-075-20250903    clang-20
x86_64                randconfig-076-20250903    clang-20
x86_64                randconfig-077-20250903    clang-20
x86_64                randconfig-078-20250903    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250903    gcc-11.5.0
xtensa                randconfig-001-20250903    gcc-12.5.0
xtensa                randconfig-002-20250903    gcc-12.5.0
xtensa                randconfig-002-20250903    gcc-14.3.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
