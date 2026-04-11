Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3657132E6B8
	for <linux-bluetooth@vger.kernel.org>; Sat, 11 Apr 2026 10:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775902343; cv=none; b=OESHARahTFBEyaYC4oTWVNEyeHkOib06k+RqXLD+HRfO7QMIUT8nWyK/9yoSbFB32omlm1GTylRFozOSmjUwTAqvmo0NLDF+ko01CMtk1aLtwvJOGZoh15/XtnJIoC4e6VuFhzJ8DTkaFBbf127/hmZApDeg7qzzCkJFFOImuMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775902343; c=relaxed/simple;
	bh=5D+HAy2t+4afjgqrYDWvgConwo9F47bB26cYzcBDOJk=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Osq2Z9zE7VgZL3dU10QUqLDn/TcrrsEzyX/UCdus6Zdx9+3g0Hx5BlqQaQdb5TM06JzjWsu+ALDc05IzsWWyyFvE/v4481qjRz2qkcbSyFa7e1g1FAVyFEzE3JLANFNDD98c4hzmnp2OG37wZPVZejNIvissYuWIviBzF9LhIcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cdXHeWi/; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cdXHeWi/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775902341; x=1807438341;
  h=date:from:to:cc:subject:message-id;
  bh=5D+HAy2t+4afjgqrYDWvgConwo9F47bB26cYzcBDOJk=;
  b=cdXHeWi/w2VvXL/l3ZIzN2lzmctqqLE3vBukdzs8PXLQbJlNhE5WVJlU
   dLxneu36qZo+ElS2aiKUF/pKHJNHQMPTO7mKkRmo+2RbOpJssWN8paWNY
   s1unVLi59WiEt+CcfZqPzR7EdLQ0r8WkVMiPw09QJzgJS5pEFtCIZuK1G
   f4nHw/G/yZN7lIXuv2G0FRwioKpygRapxOX5t1KrOc7aK9S1MDnvr41LG
   BtUZKZnusRl4dSBcOdyWzOczOxs6KOd6v7cTYXHhCnCtM+aWnL4zhsgO+
   hwsQsm1nKAEBUefU3v0WT94y8ch5KWo8UiT6d/p15vad5pKxPlu/1mg5r
   g==;
X-CSE-ConnectionGUID: JFjrWR4fSNGu/PrJCtVyRQ==
X-CSE-MsgGUID: zNJLZxhURc+OPfLoV4F5Uw==
X-IronPort-AV: E=McAfee;i="6800,10657,11755"; a="87201915"
X-IronPort-AV: E=Sophos;i="6.23,173,1770624000"; 
   d="scan'208";a="87201915"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2026 03:12:21 -0700
X-CSE-ConnectionGUID: p5QobbWNS6WNaQpKTQZ/rw==
X-CSE-MsgGUID: 92ntCJjASPGRredF7WePjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,173,1770624000"; 
   d="scan'208";a="228470140"
Received: from lkp-server01.sh.intel.com (HELO 3eaaf1a74b89) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 11 Apr 2026 03:12:20 -0700
Received: from kbuild by 3eaaf1a74b89 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wBVK5-00000000145-1WeR;
	Sat, 11 Apr 2026 10:12:17 +0000
Date: Sat, 11 Apr 2026 18:12:09 +0800
From: kernel test robot <lkp@intel.com>
To: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 02751aa9eb61cba881dad5a1e2663389b76ea8f2
Message-ID: <202604111803.jcd5PBix-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: 02751aa9eb61cba881dad5a1e2663389b76ea8f2  Bluetooth: hci_qca: Fix missing wakeup during SSR memdump handling

elapsed time: 1007m

configs tested: 126
configs skipped: 10

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
arc                              allmodconfig    gcc-15.2.0
arc                               allnoconfig    gcc-15.2.0
arc                   randconfig-001-20260411    gcc-12.5.0
arc                   randconfig-002-20260411    gcc-8.5.0
arm                               allnoconfig    clang-23
arm                              allyesconfig    gcc-15.2.0
arm                   randconfig-001-20260411    gcc-14.3.0
arm                   randconfig-002-20260411    clang-23
arm                   randconfig-003-20260411    clang-23
arm                   randconfig-004-20260411    clang-23
arm64                             allnoconfig    gcc-15.2.0
arm64                 randconfig-001-20260411    clang-23
arm64                 randconfig-002-20260411    clang-23
arm64                 randconfig-003-20260411    clang-16
arm64                 randconfig-004-20260411    clang-19
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                  randconfig-001-20260411    gcc-12.5.0
csky                  randconfig-002-20260411    gcc-15.2.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-23
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260411    clang-20
i386        buildonly-randconfig-002-20260411    clang-20
i386        buildonly-randconfig-003-20260411    clang-20
i386        buildonly-randconfig-004-20260411    clang-20
i386        buildonly-randconfig-005-20260411    gcc-14
i386        buildonly-randconfig-006-20260411    gcc-14
i386                  randconfig-001-20260411    clang-20
i386                  randconfig-002-20260411    clang-20
i386                  randconfig-003-20260411    clang-20
i386                  randconfig-004-20260411    clang-20
i386                  randconfig-005-20260411    gcc-14
i386                  randconfig-006-20260411    gcc-13
i386                  randconfig-007-20260411    clang-20
i386                  randconfig-011-20260411    clang-20
i386                  randconfig-012-20260411    gcc-14
i386                  randconfig-013-20260411    gcc-14
i386                  randconfig-014-20260411    gcc-14
i386                  randconfig-015-20260411    clang-20
i386                  randconfig-016-20260411    gcc-14
i386                  randconfig-017-20260411    gcc-14
loongarch                         allnoconfig    clang-23
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    gcc-15.2.0
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-11.5.0
openrisc                          allnoconfig    gcc-15.2.0
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    gcc-15.2.0
parisc                           allyesconfig    gcc-15.2.0
parisc                randconfig-001-20260411    gcc-10.5.0
parisc                randconfig-002-20260411    gcc-11.5.0
powerpc                           allnoconfig    gcc-15.2.0
powerpc               randconfig-001-20260411    clang-17
powerpc               randconfig-002-20260411    clang-17
powerpc64             randconfig-001-20260411    clang-16
powerpc64             randconfig-002-20260411    gcc-11.5.0
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                 randconfig-001-20260411    clang-17
riscv                 randconfig-002-20260411    gcc-10.5.0
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                  randconfig-001-20260411    gcc-8.5.0
s390                  randconfig-002-20260411    gcc-8.5.0
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    gcc-15.2.0
sh                                  defconfig    gcc-15.2.0
sh                    randconfig-001-20260411    gcc-12.5.0
sh                    randconfig-002-20260411    gcc-12.5.0
sparc                             allnoconfig    gcc-15.2.0
sparc                 randconfig-001-20260411    gcc-8.5.0
sparc                 randconfig-002-20260411    gcc-15.2.0
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20260411    gcc-15.2.0
sparc64               randconfig-002-20260411    gcc-11.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-14
um                                  defconfig    clang-23
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260411    gcc-14
um                    randconfig-002-20260411    gcc-14
um                           x86_64_defconfig    clang-23
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260411    gcc-14
x86_64      buildonly-randconfig-002-20260411    clang-20
x86_64      buildonly-randconfig-003-20260411    gcc-13
x86_64      buildonly-randconfig-004-20260411    gcc-14
x86_64      buildonly-randconfig-005-20260411    gcc-14
x86_64      buildonly-randconfig-006-20260411    gcc-14
x86_64                              defconfig    gcc-14
x86_64                randconfig-001-20260411    gcc-12
x86_64                randconfig-003-20260411    gcc-14
x86_64                randconfig-011-20260411    gcc-14
x86_64                randconfig-012-20260411    clang-20
x86_64                randconfig-013-20260411    gcc-14
x86_64                randconfig-014-20260411    clang-20
x86_64                randconfig-015-20260411    gcc-14
x86_64                randconfig-016-20260411    clang-20
x86_64                randconfig-071-20260411    clang-20
x86_64                randconfig-072-20260411    clang-20
x86_64                randconfig-073-20260411    gcc-14
x86_64                randconfig-074-20260411    clang-20
x86_64                randconfig-075-20260411    gcc-14
x86_64                randconfig-076-20260411    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.2.0
xtensa                randconfig-001-20260411    gcc-15.2.0
xtensa                randconfig-002-20260411    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
