Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0742B43F0B5
	for <linux-bluetooth@vger.kernel.org>; Sat, 18 Jul 2026 04:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784347493; cv=none; b=s9OsQjsjXE8WF7QHyQiQtYGOO0ynVpscqkVWSNNT59T/8qoPe4gbl6ZUBYSpser12bPO3BQAQgz/FbwAgBn04PA4wVJ7hWTPCgHwj2detxuaYKe5yHcGQn+rCYdjeAJIgJrtGZZYlh5jojIZ/eIj1+y6qin8iXAJIj6UzMh3RJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784347493; c=relaxed/simple;
	bh=DxfxkrYp5v1neNbIZeYlr/3z7K/n/GS8vRiHkbMAFZ8=;
	h=Date:From:To:Cc:Subject:Message-ID; b=KjA8uYgzSoMBnfJjeXG0GpZI0M9d8JYzBmlzPcA+tyZRTBuFh6X+7+OpIw7o9HkeOh26R07QAi0eaVJHhjeNTQLyo/jg9z5ndl5JAH69OeejgqlLhNQtuT/JZhYCV6PHdlAvxHCeiOmlQ4rxzmYT0DKNXQBT11XUo6DudNczP0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RBVWiFTT; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RBVWiFTT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784347492; x=1815883492;
  h=date:from:to:cc:subject:message-id;
  bh=DxfxkrYp5v1neNbIZeYlr/3z7K/n/GS8vRiHkbMAFZ8=;
  b=RBVWiFTTDKMRu0Ro7eXLP9gGwnFdkxVD1Yl/CJCVl0d7jC3L961twEkZ
   yc8DQsZxwuvMF2eTEg0+7A5JI6NT1R1SjPBAHiubsc4kpkmCxvGAZ5fj8
   hpMA66wb7yWQ5gjfwTi03C9rd39YFMNOscFg8vXcM4OtNRVrCi1bjfTjJ
   Ue52bpl2E4Df2Kve4slmoHE9gKAkIFdmeEi3tE1QostVAKcTHHLfjT5NN
   UUMmPF6m+emWICjhXmL1Oktm2fDwxpqHTxwB3d7sngeylVj1DMs00fsz0
   6QU6z6yicXXv06odrpp8Fba57xDlN9uNnGg9pZeKggFSPIQ9IVlgzObaC
   w==;
X-CSE-ConnectionGUID: 0UQK1WkFTdyEpvQsmBSdOw==
X-CSE-MsgGUID: DUv0Az7lSXGrU8Y99JMmmg==
X-IronPort-AV: E=McAfee;i="6800,10657,11849"; a="84966578"
X-IronPort-AV: E=Sophos;i="6.25,170,1779174000"; 
   d="scan'208";a="84966578"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2026 21:04:51 -0700
X-CSE-ConnectionGUID: eQ8mk8EMTnGDXnNU649AAw==
X-CSE-MsgGUID: wotwHsjAT5GevKxfsL72ug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,170,1779174000"; 
   d="scan'208";a="287012269"
Received: from lkp-server02.sh.intel.com (HELO ea128546eb3d) ([10.239.97.151])
  by orviesa002.jf.intel.com with ESMTP; 17 Jul 2026 21:04:49 -0700
Received: from kbuild by ea128546eb3d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wkwIB-00000000TRM-0e9t;
	Sat, 18 Jul 2026 04:04:47 +0000
Date: Sat, 18 Jul 2026 12:04:25 +0800
From: kernel test robot <lkp@intel.com>
To: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 bd8bee79e1fa8db2d587733f8b6fd9597b04d6e3
Message-ID: <202607181214.NJp5O88h-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: bd8bee79e1fa8db2d587733f8b6fd9597b04d6e3  Bluetooth: btintel_pcie: serialize reset_type with RECOVERY_IN_PROGRESS

elapsed time: 2063m

configs tested: 131
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allnoconfig    gcc-16.1.0
alpha                           allyesconfig    gcc-16.1.0
alpha                              defconfig    gcc-16.1.0
arc                             allmodconfig    gcc-16.1.0
arc                             allyesconfig    gcc-16.1.0
arc                  randconfig-001-20260717    gcc-11.5.0
arc                  randconfig-002-20260717    gcc-13.4.0
arm                  randconfig-001-20260717    clang-24
arm                  randconfig-002-20260717    clang-24
arm                  randconfig-003-20260717    gcc-8.5.0
arm                  randconfig-004-20260717    gcc-11.5.0
arm                          u8500_defconfig    gcc-16.1.0
arm64                         randconfig-001    gcc-14.3.0
arm64                randconfig-001-20260717    gcc-11.5.0
arm64                randconfig-002-20260717    gcc-8.5.0
arm64                randconfig-003-20260717    gcc-8.5.0
arm64                randconfig-004-20260717    gcc-9.5.0
csky                            allmodconfig    gcc-16.1.0
csky                 randconfig-001-20260717    gcc-13.4.0
csky                 randconfig-002-20260717    gcc-15.2.0
hexagon              randconfig-001-20260717    clang-24
hexagon              randconfig-002-20260717    clang-24
i386                            allmodconfig    gcc-14
i386       buildonly-randconfig-001-20260717    gcc-14
i386       buildonly-randconfig-002-20260717    gcc-14
i386       buildonly-randconfig-003-20260717    clang-22
i386       buildonly-randconfig-004-20260717    gcc-14
i386       buildonly-randconfig-005-20260717    gcc-14
i386       buildonly-randconfig-006-20260717    clang-22
i386                 randconfig-001-20260717    gcc-14
i386                 randconfig-001-20260718    gcc-14
i386                 randconfig-002-20260717    clang-22
i386                 randconfig-002-20260718    gcc-14
i386                 randconfig-003-20260717    clang-22
i386                 randconfig-003-20260718    gcc-14
i386                 randconfig-004-20260717    gcc-14
i386                 randconfig-004-20260718    gcc-14
i386                 randconfig-005-20260717    gcc-14
i386                 randconfig-005-20260718    gcc-14
i386                 randconfig-006-20260717    gcc-14
i386                 randconfig-006-20260718    gcc-14
i386                 randconfig-007-20260717    gcc-14
i386                 randconfig-007-20260718    gcc-14
i386                 randconfig-011-20260717    clang-22
i386                 randconfig-011-20260718    clang-22
i386                 randconfig-012-20260717    clang-22
i386                 randconfig-012-20260718    clang-22
i386                 randconfig-013-20260717    clang-22
i386                 randconfig-013-20260718    clang-22
i386                 randconfig-014-20260717    clang-22
i386                 randconfig-014-20260718    clang-22
i386                 randconfig-015-20260717    clang-22
i386                 randconfig-015-20260718    clang-22
i386                 randconfig-016-20260717    gcc-14
i386                 randconfig-016-20260718    clang-22
i386                 randconfig-017-20260717    clang-22
i386                 randconfig-017-20260718    clang-22
loongarch                          defconfig    clang-24
loongarch            randconfig-001-20260717    gcc-16.1.0
loongarch            randconfig-002-20260717    clang-24
m68k                       mvme147_defconfig    gcc-16.1.0
nios2                           allmodconfig    gcc-11.5.0
nios2                            allnoconfig    gcc-11.5.0
nios2                randconfig-001-20260717    gcc-8.5.0
nios2                randconfig-002-20260717    gcc-8.5.0
parisc                          allmodconfig    gcc-16.1.0
parisc                          allyesconfig    gcc-16.1.0
parisc                             defconfig    gcc-16.1.0
parisc                        randconfig-001    gcc-8.5.0
parisc               randconfig-001-20260717    gcc-10.5.0
parisc               randconfig-002-20260717    gcc-16.1.0
powerpc              randconfig-001-20260717    gcc-13.4.0
powerpc              randconfig-002-20260717    gcc-11.5.0
powerpc64            randconfig-001-20260717    gcc-15.2.0
powerpc64            randconfig-002-20260717    gcc-8.5.0
riscv                randconfig-001-20260717    clang-16
riscv                randconfig-001-20260718    clang-24
riscv                randconfig-002-20260717    clang-24
riscv                randconfig-002-20260718    clang-24
s390                 randconfig-001-20260717    clang-24
s390                 randconfig-001-20260718    clang-24
s390                 randconfig-002-20260717    clang-20
s390                 randconfig-002-20260718    clang-24
sh                                 defconfig    gcc-16.1.0
sh                   randconfig-001-20260717    gcc-9.5.0
sh                   randconfig-001-20260718    clang-24
sh                   randconfig-002-20260717    gcc-16.1.0
sh                   randconfig-002-20260718    clang-24
sparc                randconfig-001-20260717    gcc-8.5.0
sparc                randconfig-001-20260718    gcc-11.5.0
sparc                randconfig-002-20260717    gcc-14.3.0
sparc                randconfig-002-20260718    gcc-11.5.0
sparc64              randconfig-001-20260717    clang-22
sparc64              randconfig-001-20260718    gcc-11.5.0
sparc64              randconfig-002-20260717    clang-24
sparc64              randconfig-002-20260718    gcc-11.5.0
um                   randconfig-001-20260717    clang-24
um                   randconfig-001-20260718    gcc-11.5.0
um                   randconfig-002-20260717    clang-21
um                   randconfig-002-20260718    gcc-11.5.0
x86_64              buildonly-randconfig-001    gcc-12
x86_64     buildonly-randconfig-001-20260717    gcc-14
x86_64     buildonly-randconfig-002-20260717    gcc-14
x86_64     buildonly-randconfig-003-20260717    gcc-14
x86_64     buildonly-randconfig-004-20260717    gcc-14
x86_64     buildonly-randconfig-005-20260717    clang-22
x86_64     buildonly-randconfig-006-20260717    clang-22
x86_64                                 kexec    clang-22
x86_64               randconfig-001-20260717    clang-22
x86_64               randconfig-002-20260717    clang-22
x86_64               randconfig-003-20260717    gcc-14
x86_64               randconfig-004-20260717    gcc-14
x86_64               randconfig-005-20260717    gcc-14
x86_64               randconfig-006-20260717    gcc-13
x86_64               randconfig-011-20260717    gcc-14
x86_64               randconfig-012-20260717    gcc-14
x86_64               randconfig-013-20260717    clang-22
x86_64               randconfig-014-20260717    gcc-12
x86_64               randconfig-015-20260717    gcc-14
x86_64               randconfig-016-20260717    gcc-14
x86_64               randconfig-071-20260717    gcc-14
x86_64               randconfig-072-20260717    gcc-14
x86_64               randconfig-073-20260717    gcc-14
x86_64               randconfig-074-20260717    gcc-12
x86_64               randconfig-075-20260717    gcc-14
x86_64               randconfig-076-20260717    clang-22
x86_64                          rhel-9.4-bpf    gcc-14
xtensa               randconfig-001-20260717    gcc-16.1.0
xtensa               randconfig-001-20260718    gcc-11.5.0
xtensa               randconfig-002-20260717    gcc-14.3.0
xtensa               randconfig-002-20260718    gcc-11.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
