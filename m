Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E2B71CEABB
	for <linux-bluetooth@vger.kernel.org>; Sat, 26 Oct 2024 12:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729944553; cv=none; b=dDJOWkROq2MxAzGDrAjg0PCncAISzuBpaeOp3b1X9Vpn5coBileEWeKZqagjPMD5M35WNkwBUz9Sh1FqzwjM+tfxckbamvrAW9vHIwjkx7s80jvHIVP0M6C2ojBBpJwKEfkOzvzgBMQpMFp2E9dOQqWUpKNMpO7refaxpicmcmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729944553; c=relaxed/simple;
	bh=03BmZezCSzupUYb1tsaV4NJ1A/m7pB4XvxxoK2Gz7as=;
	h=Date:From:To:Cc:Subject:Message-ID; b=nehXg9CT4Us5tWpR/bmrSf/7HHqYKi66FwWGOCGrNuE8LCmX6lJrBnnz8tFIDkd0ekh6u5xRsKJEwPP7lcncjw7G/GOgx6tknr/XfGj7aKMerRYKL94/2eoe66pCiJ1XPAERc1b3Xh/na6/IZUtvYBiCKzAvVhcsNQnovzyhHBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P5F/+AHi; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P5F/+AHi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729944551; x=1761480551;
  h=date:from:to:cc:subject:message-id;
  bh=03BmZezCSzupUYb1tsaV4NJ1A/m7pB4XvxxoK2Gz7as=;
  b=P5F/+AHiekMOuHhwRzt01ohuohWYGOfHiBKUTnf+GcBwd4olVee+zHGz
   8djRyRbxqsUBNL/CvfFoO15NRgZG8QawYEf3qPCiIZCkvLbD5ZLLD55NV
   04OWUD1XwYH7xcJa6pkFS38McHOrxYH529seL5hc01t+nbwX4Wp7sr+bg
   2370cWjfHvWz+QNr9CYvhKNdpKvYGvejuIZX7lVNNfddBO5tgWkSPBuMl
   ht3/Tg8JET1ZmXW8QE4KXOHHWhnh77Oea5WwfIHISVbI+26nHXDUR7bey
   Myevw2M86A20N7Fx40HCeSfB6bmr7Are1+iUaWqzK092fQieAtDLWz7f0
   A==;
X-CSE-ConnectionGUID: QSZYOGViQgy6AV4nUJYYLw==
X-CSE-MsgGUID: vInl6IHWSeWTOX1nZszkpg==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="29560703"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="29560703"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2024 05:09:02 -0700
X-CSE-ConnectionGUID: xErI1qjtTMmqa5MMBwnU6A==
X-CSE-MsgGUID: TWj2ODLQRD6FYOln4kteZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,235,1725346800"; 
   d="scan'208";a="81490124"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 26 Oct 2024 05:09:00 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t4fbF-000Zbm-22;
	Sat, 26 Oct 2024 12:08:57 +0000
Date: Sat, 26 Oct 2024 20:08:22 +0800
From: kernel test robot <lkp@intel.com>
To: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 2422d0e13858b7e14746045cb36b3fcd6d3bddb2
Message-ID: <202410262014.S0p8bPf2-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: 2422d0e13858b7e14746045cb36b3fcd6d3bddb2  Bluetooth: btmtk: adjust the position to init iso data anchor

elapsed time: 1179m

configs tested: 157
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.1.0
alpha                            allyesconfig    clang-20
alpha                               defconfig    gcc-14.1.0
arc                              allmodconfig    clang-20
arc                               allnoconfig    gcc-14.1.0
arc                              allyesconfig    clang-20
arc                          axs103_defconfig    gcc-14.1.0
arc                                 defconfig    gcc-14.1.0
arc                   randconfig-001-20241026    gcc-14.1.0
arc                   randconfig-002-20241026    gcc-14.1.0
arm                              allmodconfig    clang-20
arm                               allnoconfig    gcc-14.1.0
arm                              allyesconfig    clang-20
arm                                 defconfig    gcc-14.1.0
arm                        multi_v5_defconfig    gcc-14.1.0
arm                        neponset_defconfig    gcc-14.1.0
arm                   randconfig-001-20241026    gcc-14.1.0
arm                   randconfig-002-20241026    gcc-14.1.0
arm                   randconfig-003-20241026    gcc-14.1.0
arm                   randconfig-004-20241026    gcc-14.1.0
arm                          sp7021_defconfig    gcc-14.1.0
arm                       versatile_defconfig    gcc-14.1.0
arm64                            allmodconfig    clang-20
arm64                             allnoconfig    gcc-14.1.0
arm64                               defconfig    gcc-14.1.0
arm64                 randconfig-001-20241026    gcc-14.1.0
arm64                 randconfig-002-20241026    gcc-14.1.0
arm64                 randconfig-003-20241026    gcc-14.1.0
arm64                 randconfig-004-20241026    gcc-14.1.0
csky                              allnoconfig    gcc-14.1.0
csky                                defconfig    gcc-14.1.0
csky                  randconfig-001-20241026    gcc-14.1.0
csky                  randconfig-002-20241026    gcc-14.1.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    gcc-14.1.0
hexagon                          allyesconfig    clang-20
hexagon                             defconfig    gcc-14.1.0
hexagon               randconfig-001-20241026    gcc-14.1.0
hexagon               randconfig-002-20241026    gcc-14.1.0
i386                             allmodconfig    clang-19
i386                              allnoconfig    clang-19
i386                             allyesconfig    clang-19
i386                                defconfig    clang-19
loongarch                        allmodconfig    gcc-14.1.0
loongarch                         allnoconfig    gcc-14.1.0
loongarch                           defconfig    gcc-14.1.0
loongarch             randconfig-001-20241026    gcc-14.1.0
loongarch             randconfig-002-20241026    gcc-14.1.0
m68k                             allmodconfig    gcc-14.1.0
m68k                              allnoconfig    gcc-14.1.0
m68k                             allyesconfig    gcc-14.1.0
m68k                         amcore_defconfig    gcc-14.1.0
m68k                                defconfig    gcc-14.1.0
m68k                           sun3_defconfig    gcc-14.1.0
microblaze                       allmodconfig    gcc-14.1.0
microblaze                        allnoconfig    gcc-14.1.0
microblaze                       allyesconfig    gcc-14.1.0
microblaze                          defconfig    gcc-14.1.0
mips                              allnoconfig    gcc-14.1.0
mips                          rb532_defconfig    gcc-14.1.0
nios2                             allnoconfig    gcc-14.1.0
nios2                               defconfig    gcc-14.1.0
nios2                 randconfig-001-20241026    gcc-14.1.0
nios2                 randconfig-002-20241026    gcc-14.1.0
openrisc                          allnoconfig    clang-20
openrisc                         allyesconfig    gcc-14.1.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-14.1.0
parisc                            allnoconfig    clang-20
parisc                           allyesconfig    gcc-14.1.0
parisc                              defconfig    gcc-12
parisc                randconfig-001-20241026    gcc-14.1.0
parisc                randconfig-002-20241026    gcc-14.1.0
parisc64                            defconfig    gcc-14.1.0
powerpc                     akebono_defconfig    gcc-14.1.0
powerpc                          allmodconfig    gcc-14.1.0
powerpc                           allnoconfig    clang-20
powerpc                          allyesconfig    gcc-14.1.0
powerpc                   bluestone_defconfig    gcc-14.1.0
powerpc                 canyonlands_defconfig    gcc-14.1.0
powerpc                     kmeter1_defconfig    gcc-14.1.0
powerpc               randconfig-001-20241026    gcc-14.1.0
powerpc               randconfig-002-20241026    gcc-14.1.0
powerpc               randconfig-003-20241026    gcc-14.1.0
powerpc64             randconfig-001-20241026    gcc-14.1.0
powerpc64             randconfig-002-20241026    gcc-14.1.0
powerpc64             randconfig-003-20241026    gcc-14.1.0
riscv                            allmodconfig    gcc-14.1.0
riscv                             allnoconfig    clang-20
riscv                            allyesconfig    gcc-14.1.0
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20241026    gcc-14.1.0
riscv                 randconfig-002-20241026    gcc-14.1.0
s390                             allmodconfig    gcc-14.1.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.1.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20241026    gcc-14.1.0
s390                  randconfig-002-20241026    gcc-14.1.0
sh                               allmodconfig    gcc-14.1.0
sh                                allnoconfig    gcc-14.1.0
sh                               allyesconfig    gcc-14.1.0
sh                                  defconfig    gcc-12
sh                        edosk7705_defconfig    gcc-14.1.0
sh                    randconfig-001-20241026    gcc-14.1.0
sh                    randconfig-002-20241026    gcc-14.1.0
sh                           se7619_defconfig    gcc-14.1.0
sh                        sh7757lcr_defconfig    gcc-14.1.0
sparc                            allmodconfig    gcc-14.1.0
sparc                       sparc64_defconfig    gcc-14.1.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20241026    gcc-14.1.0
sparc64               randconfig-002-20241026    gcc-14.1.0
um                               allmodconfig    clang-20
um                                allnoconfig    clang-20
um                               allyesconfig    clang-20
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20241026    gcc-14.1.0
um                    randconfig-002-20241026    gcc-14.1.0
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20241026    clang-19
x86_64      buildonly-randconfig-002-20241026    clang-19
x86_64      buildonly-randconfig-003-20241026    clang-19
x86_64      buildonly-randconfig-004-20241026    clang-19
x86_64      buildonly-randconfig-005-20241026    clang-19
x86_64      buildonly-randconfig-006-20241026    clang-19
x86_64                              defconfig    clang-19
x86_64                                  kexec    clang-19
x86_64                randconfig-001-20241026    clang-19
x86_64                randconfig-002-20241026    clang-19
x86_64                randconfig-003-20241026    clang-19
x86_64                randconfig-004-20241026    clang-19
x86_64                randconfig-005-20241026    clang-19
x86_64                randconfig-006-20241026    clang-19
x86_64                randconfig-011-20241026    clang-19
x86_64                randconfig-012-20241026    clang-19
x86_64                randconfig-013-20241026    clang-19
x86_64                randconfig-014-20241026    clang-19
x86_64                randconfig-015-20241026    clang-19
x86_64                randconfig-016-20241026    clang-19
x86_64                randconfig-071-20241026    clang-19
x86_64                randconfig-072-20241026    clang-19
x86_64                randconfig-073-20241026    clang-19
x86_64                randconfig-074-20241026    clang-19
x86_64                randconfig-075-20241026    clang-19
x86_64                randconfig-076-20241026    clang-19
x86_64                               rhel-8.3    gcc-12
x86_64                           rhel-8.3-bpf    clang-19
x86_64                         rhel-8.3-kunit    clang-19
x86_64                           rhel-8.3-ltp    clang-19
x86_64                          rhel-8.3-rust    clang-19
xtensa                            allnoconfig    gcc-14.1.0
xtensa                randconfig-001-20241026    gcc-14.1.0
xtensa                randconfig-002-20241026    gcc-14.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
