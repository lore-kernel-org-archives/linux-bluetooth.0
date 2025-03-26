Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 162721F4736
	for <linux-bluetooth@vger.kernel.org>; Wed, 26 Mar 2025 20:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743022035; cv=none; b=u8VIMEd6luoa1S2QnRpqj4wZDhdbu0Qp8u4hzVJM6PwX/GPzEPV3Eec7gbvRZ/dVsAxHbNy9VqvJdU8ie96t8hd8NeCYfXZlY/lyc/bit2xuYekf1l/XpC4tZZkDCFwjSg/lSnzajnw+6FaOltthJ1B+4P5LGZb+1cRKObs7An0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743022035; c=relaxed/simple;
	bh=hy980I2tdBHvBjCawCpH6YDL8hvuv6kOK2dlj5NvyfA=;
	h=Date:From:To:Cc:Subject:Message-ID; b=SxPkKuCn+MUZ96F9/BILhGXGibhm0Kk5+jKcrAzYqUa8wddkF7SeeXsQF5ByKZKEKYB2+xtMRRbK3gQ47wvnq0Gja/DS9XVHoC5NNcxpYMqvm/zCHXFRvxY48rTUfRY012kEMTLdHJxQnaP02NEraBeH4QdbFnKN0l4eGL+n8ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QhK8og9J; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QhK8og9J"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743022034; x=1774558034;
  h=date:from:to:cc:subject:message-id;
  bh=hy980I2tdBHvBjCawCpH6YDL8hvuv6kOK2dlj5NvyfA=;
  b=QhK8og9JZwavDaPumIPnh80iGbsGeywLvZPakN8obZDbW/+GoVlGdllx
   uy/ofXA3kZH05epFElwfA01C0ooxtjD042YbUT1YEHjnvhkmo/aQj68aa
   FWi+4Y3FkfnqJy6prhcfXqaQqlhWgaZWx7MyjqnJd8mSimYcguHp15Shl
   an7AldA0f+FJkd+/FZgE+lWuaSWegsT570I7aKkdn8cKSrrOt50liz60o
   VFPpWUgvF/Jk62k+YYzmuVZnUD5dtXLL/Iv6rFy0d5V/yIJTGa2H0fqCF
   7CyoAA8U9PIhHdsIe2ZFvBJlvuCXeeLx7n8Y1yZc0OIy0J4eRWAYRS51n
   w==;
X-CSE-ConnectionGUID: xgGgCJcUTQyD4mMNBaoNvw==
X-CSE-MsgGUID: PVBAAn4UTmmn97sjqKHvrw==
X-IronPort-AV: E=McAfee;i="6700,10204,11385"; a="44251014"
X-IronPort-AV: E=Sophos;i="6.14,278,1736841600"; 
   d="scan'208";a="44251014"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2025 13:47:13 -0700
X-CSE-ConnectionGUID: /ke4iZrXRf+g0fBtr8z2dg==
X-CSE-MsgGUID: 9emRVn0YTF22PSCgJkpxLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,278,1736841600"; 
   d="scan'208";a="124895980"
Received: from lkp-server02.sh.intel.com (HELO e98e3655d6d2) ([10.239.97.151])
  by fmviesa007.fm.intel.com with ESMTP; 26 Mar 2025 13:47:12 -0700
Received: from kbuild by e98e3655d6d2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1txXeY-00063t-0C;
	Wed, 26 Mar 2025 20:47:10 +0000
Date: Thu, 27 Mar 2025 04:46:39 +0800
From: kernel test robot <lkp@intel.com>
To: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD REGRESSION
 eed14eb510c040a3826b633048244bb7a816c67d
Message-ID: <202503270431.Kgo6DqBq-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: eed14eb510c040a3826b633048244bb7a816c67d  Bluetooth: MGMT: Add LL Privacy Setting

Error/Warning (recently discovered and may have been fixed):

    drivers/bluetooth/btnxpuart.c:1683:15: error: 'struct hci_dev' has no member named 'cmd_timeout'; did you mean 'cmd_timer'?

Error/Warning ids grouped by kconfigs:

recent_errors
`-- mips-allyesconfig
    `-- drivers-bluetooth-btnxpuart.c:error:struct-hci_dev-has-no-member-named-cmd_timeout

elapsed time: 1445m

configs tested: 164
configs skipped: 6

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
arc                              allmodconfig    clang-19
arc                              allmodconfig    gcc-14.2.0
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    clang-19
arc                              allyesconfig    gcc-14.2.0
arc                   randconfig-001-20250326    gcc-14.2.0
arc                   randconfig-002-20250326    gcc-8.5.0
arm                              allmodconfig    clang-19
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-21
arm                               allnoconfig    gcc-14.2.0
arm                              allyesconfig    clang-19
arm                              allyesconfig    gcc-14.2.0
arm                         assabet_defconfig    gcc-14.2.0
arm                         axm55xx_defconfig    clang-15
arm                       imx_v4_v5_defconfig    clang-15
arm                          ixp4xx_defconfig    gcc-14.2.0
arm                         mv78xx0_defconfig    gcc-14.2.0
arm                        neponset_defconfig    gcc-14.2.0
arm                   randconfig-001-20250326    gcc-7.5.0
arm                   randconfig-002-20250326    clang-21
arm                   randconfig-003-20250326    gcc-8.5.0
arm                   randconfig-004-20250326    clang-21
arm64                            alldefconfig    gcc-14.2.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20250326    clang-21
arm64                 randconfig-002-20250326    clang-21
arm64                 randconfig-003-20250326    gcc-8.5.0
arm64                 randconfig-004-20250326    gcc-6.5.0
csky                              allnoconfig    gcc-14.2.0
csky                  randconfig-001-20250326    gcc-14.2.0
csky                  randconfig-002-20250326    gcc-14.2.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-21
hexagon                           allnoconfig    gcc-14.2.0
hexagon                          allyesconfig    clang-21
hexagon               randconfig-001-20250326    clang-21
hexagon               randconfig-002-20250326    clang-21
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250326    gcc-12
i386        buildonly-randconfig-002-20250326    clang-20
i386        buildonly-randconfig-003-20250326    clang-20
i386        buildonly-randconfig-004-20250326    clang-20
i386        buildonly-randconfig-005-20250326    gcc-12
i386        buildonly-randconfig-006-20250326    clang-20
i386                                defconfig    clang-20
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20250326    gcc-14.2.0
loongarch             randconfig-002-20250326    gcc-12.4.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                          multi_defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                        bcm63xx_defconfig    clang-21
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250326    gcc-12.4.0
nios2                 randconfig-002-20250326    gcc-10.5.0
openrisc                          allnoconfig    clang-15
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-12
openrisc                            defconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    clang-15
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-12
parisc                              defconfig    gcc-14.2.0
parisc                randconfig-001-20250326    gcc-13.3.0
parisc                randconfig-002-20250326    gcc-7.5.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    clang-15
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-21
powerpc                      katmai_defconfig    clang-21
powerpc                      mgcoge_defconfig    clang-21
powerpc                      pasemi_defconfig    gcc-14.2.0
powerpc               randconfig-001-20250326    clang-21
powerpc               randconfig-002-20250326    gcc-6.5.0
powerpc               randconfig-003-20250326    clang-19
powerpc                     taishan_defconfig    clang-17
powerpc                     tqm8540_defconfig    gcc-14.2.0
powerpc                        warp_defconfig    gcc-14.2.0
powerpc64                        alldefconfig    gcc-14.2.0
powerpc64             randconfig-001-20250326    clang-21
powerpc64             randconfig-002-20250326    gcc-8.5.0
powerpc64             randconfig-003-20250326    clang-21
riscv                            allmodconfig    clang-21
riscv                             allnoconfig    clang-15
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-21
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20250326    clang-21
riscv                 randconfig-002-20250326    gcc-8.5.0
s390                             allmodconfig    gcc-14.2.0
s390                              allnoconfig    clang-15
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    clang-15
s390                                defconfig    gcc-12
s390                  randconfig-001-20250326    clang-15
s390                  randconfig-002-20250326    clang-15
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                         apsh4a3a_defconfig    gcc-14.2.0
sh                                  defconfig    gcc-12
sh                                  defconfig    gcc-14.2.0
sh                          r7785rp_defconfig    gcc-14.2.0
sh                    randconfig-001-20250326    gcc-6.5.0
sh                    randconfig-002-20250326    gcc-6.5.0
sh                           se7705_defconfig    gcc-14.2.0
sh                  sh7785lcr_32bit_defconfig    gcc-14.2.0
sh                              ul2_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250326    gcc-11.5.0
sparc                 randconfig-002-20250326    gcc-5.5.0
sparc64                             defconfig    gcc-12
sparc64                             defconfig    gcc-14.2.0
sparc64               randconfig-001-20250326    gcc-5.5.0
sparc64               randconfig-002-20250326    gcc-11.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-15
um                                allnoconfig    clang-21
um                               allyesconfig    gcc-12
um                                  defconfig    clang-21
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250326    clang-15
um                    randconfig-002-20250326    gcc-11
um                           x86_64_defconfig    clang-15
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250326    clang-20
x86_64      buildonly-randconfig-002-20250326    gcc-11
x86_64      buildonly-randconfig-003-20250326    clang-20
x86_64      buildonly-randconfig-004-20250326    clang-20
x86_64      buildonly-randconfig-005-20250326    clang-20
x86_64      buildonly-randconfig-006-20250326    clang-20
x86_64                              defconfig    gcc-11
x86_64                randconfig-071-20250327    gcc-12
x86_64                randconfig-072-20250327    gcc-12
x86_64                randconfig-073-20250327    gcc-12
x86_64                randconfig-074-20250327    gcc-12
x86_64                randconfig-075-20250327    gcc-12
x86_64                randconfig-076-20250327    gcc-12
x86_64                randconfig-077-20250327    gcc-12
x86_64                randconfig-078-20250327    gcc-12
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250326    gcc-7.5.0
xtensa                randconfig-002-20250326    gcc-13.3.0
xtensa                         virt_defconfig    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
