Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 873D22F6900
	for <linux-bluetooth@vger.kernel.org>; Sat, 21 Feb 2026 05:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771651499; cv=none; b=ql5CjWFUclFLhj9fUvzpsHu+3ZpQvfaiwZ1rWailqO6OB1ZHSG8Wj35U9w5RRCg69zv1UaWuUFvwN7QGPajvcdGkK+0D4NYL+7MBVnUKVSJLYQThG9BEu6icHVVLbSpNgKxMwjYAI1+BxaJi5oP6d8btTVprZwSRwRc0IPe9bFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771651499; c=relaxed/simple;
	bh=LPiq8XFFsNF5nMUR+E/OYhqvM3zmSHg9jLs4kw26mns=;
	h=Date:From:To:Cc:Subject:Message-ID; b=N1yS0R1z3cuSD1JWp4LzrpwlkyYz5m8R1Un6AjzdlxPjnFafvgU+nGOsiXqA60oWzGOjc0/WqZ4qb9oJBonbWFV8C/uTwqfe43QggGVWMELdlwJpiZHECTpDmovx/atSHuvGZrWrVIYHEkl/hzotL0BZIF1Aj5oGOLVmri5UCLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AF0v1bmT; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AF0v1bmT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771651496; x=1803187496;
  h=date:from:to:cc:subject:message-id;
  bh=LPiq8XFFsNF5nMUR+E/OYhqvM3zmSHg9jLs4kw26mns=;
  b=AF0v1bmTq8cjEpWw/U2Yb9NokS36t6axka8RG3sK8z6bZGA8Gvsmg5hD
   QES1Xs9Mb2YkEmw9tXDuorc1r71y/WraEdhP87oimJhQht6ag+Zu3NdNb
   rMJFvUrivuCaY5zMegsufPWYPkr0fXbojb9adpFISxMp3KMYOT61HtbMQ
   /eiig1WjY7vsefD8N7E+HRU1Wq0wuzj7qUzwU8Ma5tRzccLgDNAmdH6HW
   ND7HPDZGUXWkucIGQVcR0BWJy/AsJ1TZpKub3IagJurQWuIIhI+EZLvJq
   11/U8gxhnmSRy/UvhHXYv5cBXgaIv8u8FTBTzyVj4HR/yLkLcscEFKkxd
   Q==;
X-CSE-ConnectionGUID: zFRCAw9CTYiH0DQrhD+UOA==
X-CSE-MsgGUID: W1sa0jR3S5ubuGhZQByLVg==
X-IronPort-AV: E=McAfee;i="6800,10657,11707"; a="83056437"
X-IronPort-AV: E=Sophos;i="6.21,302,1763452800"; 
   d="scan'208";a="83056437"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2026 21:24:56 -0800
X-CSE-ConnectionGUID: ZNh5d37hRWmyOCjdKb8HuA==
X-CSE-MsgGUID: G/ExiOQBTrm1umAZEdJt0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,302,1763452800"; 
   d="scan'208";a="252737343"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 20 Feb 2026 21:24:55 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vtfU4-000000014ik-24Gf;
	Sat, 21 Feb 2026 05:24:52 +0000
Date: Sat, 21 Feb 2026 13:23:55 +0800
From: kernel test robot <lkp@intel.com>
To: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 fa5643fbc394ad551252eb5512c303ff30733085
Message-ID: <202602211347.algkLj52-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: fa5643fbc394ad551252eb5512c303ff30733085  Bluetooth: btusb: Add Lite-On 04ca:3807 for MediaTek MT7921

elapsed time: 862m

configs tested: 214
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
alpha                               defconfig    gcc-15.2.0
arc                              alldefconfig    clang-23
arc                              allmodconfig    clang-16
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    clang-23
arc                              allyesconfig    gcc-15.2.0
arc                                 defconfig    gcc-15.2.0
arc                   randconfig-001-20260221    gcc-14.3.0
arc                   randconfig-002-20260221    gcc-14.3.0
arm                              alldefconfig    gcc-15.2.0
arm                               allnoconfig    clang-23
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                                 defconfig    gcc-15.2.0
arm                            dove_defconfig    gcc-15.2.0
arm                             mxs_defconfig    gcc-15.2.0
arm                         nhk8815_defconfig    clang-23
arm                          pxa168_defconfig    gcc-15.2.0
arm                   randconfig-001-20260221    gcc-14.3.0
arm                   randconfig-002-20260221    gcc-14.3.0
arm                   randconfig-003-20260221    gcc-14.3.0
arm                   randconfig-004-20260221    gcc-14.3.0
arm                         vf610m4_defconfig    clang-23
arm64                            allmodconfig    clang-19
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260221    clang-23
arm64                 randconfig-002-20260221    clang-23
arm64                 randconfig-003-20260221    clang-23
arm64                 randconfig-004-20260221    clang-23
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260221    clang-23
csky                  randconfig-002-20260221    clang-23
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    clang-23
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    gcc-15.2.0
hexagon               randconfig-001-20260221    clang-23
hexagon               randconfig-002-20260221    clang-23
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260221    clang-20
i386        buildonly-randconfig-002-20260221    clang-20
i386        buildonly-randconfig-003-20260221    clang-20
i386        buildonly-randconfig-004-20260221    clang-20
i386        buildonly-randconfig-005-20260221    clang-20
i386        buildonly-randconfig-006-20260221    clang-20
i386                                defconfig    gcc-15.2.0
i386                  randconfig-001-20260221    gcc-14
i386                  randconfig-002-20260221    clang-20
i386                  randconfig-002-20260221    gcc-14
i386                  randconfig-003-20260221    gcc-12
i386                  randconfig-003-20260221    gcc-14
i386                  randconfig-004-20260221    clang-20
i386                  randconfig-004-20260221    gcc-14
i386                  randconfig-005-20260221    clang-20
i386                  randconfig-005-20260221    gcc-14
i386                  randconfig-006-20260221    gcc-14
i386                  randconfig-007-20260221    gcc-14
i386                  randconfig-011-20260221    gcc-14
i386                  randconfig-012-20260221    gcc-14
i386                  randconfig-013-20260221    gcc-14
i386                  randconfig-014-20260221    gcc-14
i386                  randconfig-015-20260221    gcc-14
i386                  randconfig-016-20260221    gcc-14
i386                  randconfig-017-20260221    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    clang-23
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260221    clang-23
loongarch             randconfig-001-20260221    gcc-15.2.0
loongarch             randconfig-002-20260221    clang-18
loongarch             randconfig-002-20260221    clang-23
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    clang-16
m68k                         amcore_defconfig    clang-23
m68k                                defconfig    clang-19
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    clang-19
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
mips                           jazz_defconfig    clang-23
nios2                            allmodconfig    clang-23
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    clang-23
nios2                               defconfig    clang-19
nios2                 randconfig-001-20260221    clang-23
nios2                 randconfig-001-20260221    gcc-11.5.0
nios2                 randconfig-002-20260221    clang-23
nios2                 randconfig-002-20260221    gcc-10.5.0
openrisc                         allmodconfig    clang-23
openrisc                         allmodconfig    gcc-15.2.0
openrisc                          allnoconfig    clang-23
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    clang-23
parisc                           allyesconfig    clang-19
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260221    gcc-8.5.0
parisc                randconfig-001-20260221    gcc-9.5.0
parisc                randconfig-002-20260221    gcc-8.5.0
parisc                randconfig-002-20260221    gcc-9.5.0
parisc64                            defconfig    clang-19
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-23
powerpc                    gamecube_defconfig    clang-23
powerpc                 mpc8313_rdb_defconfig    gcc-15.2.0
powerpc               randconfig-001-20260221    gcc-12.5.0
powerpc               randconfig-001-20260221    gcc-9.5.0
powerpc               randconfig-002-20260221    gcc-9.5.0
powerpc                        warp_defconfig    clang-23
powerpc64             randconfig-001-20260221    gcc-11.5.0
powerpc64             randconfig-001-20260221    gcc-9.5.0
powerpc64             randconfig-002-20260221    gcc-8.5.0
powerpc64             randconfig-002-20260221    gcc-9.5.0
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-15.2.0
riscv                 randconfig-001-20260221    gcc-10.5.0
riscv                 randconfig-002-20260221    gcc-10.5.0
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    gcc-15.2.0
s390                  randconfig-001-20260221    gcc-10.5.0
s390                  randconfig-002-20260221    gcc-10.5.0
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-23
sh                               allyesconfig    clang-19
sh                                  defconfig    gcc-14
sh                 kfr2r09-romimage_defconfig    gcc-15.2.0
sh                            migor_defconfig    gcc-15.2.0
sh                    randconfig-001-20260221    gcc-10.5.0
sh                    randconfig-002-20260221    gcc-10.5.0
sh                              ul2_defconfig    gcc-15.2.0
sparc                             allnoconfig    clang-23
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260221    gcc-8.5.0
sparc                 randconfig-002-20260221    gcc-8.5.0
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260221    gcc-8.5.0
sparc64               randconfig-002-20260221    gcc-8.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-14
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260221    gcc-8.5.0
um                    randconfig-002-20260221    gcc-8.5.0
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260221    clang-20
x86_64      buildonly-randconfig-002-20260221    clang-20
x86_64      buildonly-randconfig-003-20260221    clang-20
x86_64      buildonly-randconfig-004-20260221    clang-20
x86_64      buildonly-randconfig-005-20260221    clang-20
x86_64      buildonly-randconfig-006-20260221    clang-20
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260221    clang-20
x86_64                randconfig-001-20260221    gcc-14
x86_64                randconfig-002-20260221    gcc-14
x86_64                randconfig-003-20260221    gcc-14
x86_64                randconfig-004-20260221    clang-20
x86_64                randconfig-004-20260221    gcc-14
x86_64                randconfig-005-20260221    clang-20
x86_64                randconfig-005-20260221    gcc-14
x86_64                randconfig-006-20260221    gcc-14
x86_64                randconfig-011-20260221    gcc-14
x86_64                randconfig-012-20260221    gcc-14
x86_64                randconfig-013-20260221    gcc-14
x86_64                randconfig-014-20260221    gcc-14
x86_64                randconfig-015-20260221    gcc-14
x86_64                randconfig-016-20260221    gcc-14
x86_64                randconfig-071-20260221    clang-20
x86_64                randconfig-071-20260221    gcc-14
x86_64                randconfig-072-20260221    clang-20
x86_64                randconfig-073-20260221    clang-20
x86_64                randconfig-074-20260221    clang-20
x86_64                randconfig-074-20260221    gcc-14
x86_64                randconfig-075-20260221    clang-20
x86_64                randconfig-076-20260221    clang-20
x86_64                randconfig-076-20260221    gcc-12
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    clang-23
xtensa                           allyesconfig    clang-23
xtensa                randconfig-001-20260221    gcc-8.5.0
xtensa                randconfig-002-20260221    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
