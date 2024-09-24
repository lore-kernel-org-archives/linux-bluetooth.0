Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91DFF1B85DB
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Sep 2024 05:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727155925; cv=none; b=G8EhkBqGym+tSCjVqBhYdoEWWpVDlW/bARS66WVKsEev1ESOnpmENqImBpygCKJH6zdtlfclbn9xH5/5gNMreyy/oZm+1D8OQpKL12+jcUbsRRAw45ANLNlzv+G0LkhH12nMRc0tDmV+dICZ++wdMIR6d1F763v1nuoOZ6Fq5yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727155925; c=relaxed/simple;
	bh=PobXMv+XOEe5Bl8Tcp5g5I/LIFmT5dLRHwv+T4V9Mbw=;
	h=Date:From:To:Cc:Subject:Message-ID; b=e7UdH/edJJKPpHNzere/5S3ec/vp5oJdx0a3RxUL/6bYWsOivQXHKNyNiAKUeOPgSgj3lxFYJWKGoww8+p4hSCK7ELYiSlYmoKr1+Q+LOwNXFzl7dXKf8CXt8+QU7w3jq2U5YM3Rlxu3Y3inCxERkae0v99BqsDQrwqfzq958d8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OioCFlp4; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OioCFlp4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727155923; x=1758691923;
  h=date:from:to:cc:subject:message-id;
  bh=PobXMv+XOEe5Bl8Tcp5g5I/LIFmT5dLRHwv+T4V9Mbw=;
  b=OioCFlp4QLncgf4AhWE41lYwAaqW/eBFWG5rHkPn6LTb9bjWv5V+Fb2q
   dfQrGTetV6E8D4kJ6Q8n2jyFRttFfQhrmQ+YfGlosCcy0mUjBZrW+JJR2
   tiaNXtW4Etii4BgQ7sSFYxaGs1QNkfh8iR+jxf3xob3xgeYG6Ts/bbRmz
   vCIQifURplcJaC2dLdrWVUIE9G1p1DWbjbYkD/fZs88fOSUg/cJ1bkxTa
   q4vwFJXZGj6KIGdAGObVD091j/JAcjDLd2lXbKXNS1B5Vfnj42Hd+jQQM
   Odtc0zpM/Ux3prhdXlYFfEC8vWGk7Pv5jwEbmSldBB4LhXZOMyUXTkgpg
   g==;
X-CSE-ConnectionGUID: z8HvLlNwRqKfsqHYIHYtXQ==
X-CSE-MsgGUID: qXs8HZU0QkOPsYgNfF2hyA==
X-IronPort-AV: E=McAfee;i="6700,10204,11204"; a="26279391"
X-IronPort-AV: E=Sophos;i="6.10,253,1719903600"; 
   d="scan'208";a="26279391"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2024 22:32:03 -0700
X-CSE-ConnectionGUID: 18Zbnt0+T0OIXeqYA55EmA==
X-CSE-MsgGUID: uJjNg84wRV+aCfTZYJ/vBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,253,1719903600"; 
   d="scan'208";a="102128956"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 23 Sep 2024 22:32:01 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ssy9X-000Hyf-1t;
	Tue, 24 Sep 2024 05:31:59 +0000
Date: Tue, 24 Sep 2024 13:31:29 +0800
From: kernel test robot <lkp@intel.com>
To: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 667e8026261de5d230908a836f65fa2b48219d05
Message-ID: <202409241321.2oioEqjq-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: 667e8026261de5d230908a836f65fa2b48219d05  Bluetooth: btusb: mediatek: change the conditions for ISO interface

elapsed time: 721m

configs tested: 203
configs skipped: 8

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.1.0
alpha                            allyesconfig    clang-20
alpha                               defconfig    clang-20
alpha                               defconfig    gcc-14.1.0
arc                              allmodconfig    clang-20
arc                               allnoconfig    gcc-14.1.0
arc                              allyesconfig    clang-20
arc                                 defconfig    gcc-14.1.0
arc                            hsdk_defconfig    clang-20
arc                   randconfig-001-20240924    gcc-14.1.0
arc                   randconfig-002-20240924    gcc-14.1.0
arc                    vdk_hs38_smp_defconfig    clang-20
arm                              allmodconfig    clang-20
arm                               allnoconfig    gcc-14.1.0
arm                              allyesconfig    clang-20
arm                                 defconfig    gcc-14.1.0
arm                       imx_v4_v5_defconfig    clang-20
arm                           imxrt_defconfig    clang-20
arm                         nhk8815_defconfig    clang-20
arm                             pxa_defconfig    clang-20
arm                   randconfig-001-20240924    gcc-14.1.0
arm                   randconfig-002-20240924    gcc-14.1.0
arm                   randconfig-003-20240924    gcc-14.1.0
arm                   randconfig-004-20240924    gcc-14.1.0
arm                          sp7021_defconfig    clang-20
arm                           stm32_defconfig    clang-20
arm                       versatile_defconfig    clang-20
arm64                            allmodconfig    clang-20
arm64                             allnoconfig    gcc-14.1.0
arm64                               defconfig    gcc-14.1.0
arm64                 randconfig-001-20240924    gcc-14.1.0
arm64                 randconfig-002-20240924    gcc-14.1.0
arm64                 randconfig-003-20240924    gcc-14.1.0
arm64                 randconfig-004-20240924    gcc-14.1.0
csky                              allnoconfig    gcc-14.1.0
csky                                defconfig    gcc-14.1.0
csky                  randconfig-001-20240924    gcc-14.1.0
csky                  randconfig-002-20240924    gcc-14.1.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    gcc-14.1.0
hexagon                          allyesconfig    clang-20
hexagon                             defconfig    gcc-14.1.0
hexagon               randconfig-001-20240924    gcc-14.1.0
hexagon               randconfig-002-20240924    gcc-14.1.0
i386                             allmodconfig    clang-18
i386                              allnoconfig    clang-18
i386                             allyesconfig    clang-18
i386        buildonly-randconfig-001-20240924    gcc-12
i386        buildonly-randconfig-002-20240924    gcc-12
i386        buildonly-randconfig-003-20240924    gcc-12
i386        buildonly-randconfig-004-20240924    gcc-12
i386        buildonly-randconfig-005-20240924    gcc-12
i386        buildonly-randconfig-006-20240924    gcc-12
i386                                defconfig    clang-18
i386                  randconfig-001-20240924    gcc-12
i386                  randconfig-002-20240924    gcc-12
i386                  randconfig-003-20240924    gcc-12
i386                  randconfig-004-20240924    gcc-12
i386                  randconfig-005-20240924    gcc-12
i386                  randconfig-006-20240924    gcc-12
i386                  randconfig-011-20240924    gcc-12
i386                  randconfig-012-20240924    gcc-12
i386                  randconfig-013-20240924    gcc-12
i386                  randconfig-014-20240924    gcc-12
i386                  randconfig-015-20240924    gcc-12
i386                  randconfig-016-20240924    gcc-12
loongarch                        allmodconfig    gcc-14.1.0
loongarch                         allnoconfig    gcc-14.1.0
loongarch                           defconfig    gcc-14.1.0
loongarch             randconfig-001-20240924    gcc-14.1.0
loongarch             randconfig-002-20240924    gcc-14.1.0
m68k                             allmodconfig    gcc-14.1.0
m68k                              allnoconfig    gcc-14.1.0
m68k                             allyesconfig    gcc-14.1.0
m68k                                defconfig    gcc-14.1.0
m68k                       m5475evb_defconfig    clang-20
m68k                          sun3x_defconfig    clang-20
m68k                           virt_defconfig    clang-20
microblaze                       allmodconfig    gcc-14.1.0
microblaze                        allnoconfig    gcc-14.1.0
microblaze                       allyesconfig    gcc-14.1.0
microblaze                          defconfig    gcc-14.1.0
mips                              allnoconfig    gcc-14.1.0
mips                      bmips_stb_defconfig    clang-20
mips                     cu1830-neo_defconfig    clang-20
mips                          eyeq5_defconfig    clang-20
mips                           ip28_defconfig    clang-20
mips                           ip32_defconfig    clang-20
nios2                         3c120_defconfig    clang-20
nios2                             allnoconfig    gcc-14.1.0
nios2                               defconfig    gcc-14.1.0
nios2                 randconfig-001-20240924    gcc-14.1.0
nios2                 randconfig-002-20240924    gcc-14.1.0
openrisc                          allnoconfig    clang-20
openrisc                          allnoconfig    gcc-14.1.0
openrisc                         allyesconfig    gcc-14.1.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-14.1.0
parisc                            allnoconfig    clang-20
parisc                            allnoconfig    gcc-14.1.0
parisc                           allyesconfig    gcc-14.1.0
parisc                              defconfig    gcc-12
parisc                generic-32bit_defconfig    clang-20
parisc                generic-64bit_defconfig    clang-20
parisc                randconfig-001-20240924    gcc-14.1.0
parisc                randconfig-002-20240924    gcc-14.1.0
parisc64                            defconfig    gcc-14.1.0
powerpc                          allmodconfig    gcc-14.1.0
powerpc                           allnoconfig    clang-20
powerpc                           allnoconfig    gcc-14.1.0
powerpc                          allyesconfig    gcc-14.1.0
powerpc                      chrp32_defconfig    clang-20
powerpc                        fsp2_defconfig    clang-20
powerpc                        icon_defconfig    clang-20
powerpc                     ksi8560_defconfig    clang-20
powerpc                   lite5200b_defconfig    clang-20
powerpc                     mpc512x_defconfig    clang-20
powerpc                    mvme5100_defconfig    clang-20
powerpc                      pasemi_defconfig    clang-20
powerpc                         ps3_defconfig    clang-20
powerpc                     tqm8548_defconfig    clang-20
powerpc                      tqm8xx_defconfig    clang-20
powerpc64                        alldefconfig    clang-20
powerpc64             randconfig-001-20240924    gcc-14.1.0
powerpc64             randconfig-002-20240924    gcc-14.1.0
powerpc64             randconfig-003-20240924    gcc-14.1.0
riscv                            allmodconfig    gcc-14.1.0
riscv                             allnoconfig    clang-20
riscv                             allnoconfig    gcc-14.1.0
riscv                            allyesconfig    gcc-14.1.0
riscv                               defconfig    gcc-12
riscv                    nommu_k210_defconfig    clang-20
riscv                 randconfig-001-20240924    gcc-14.1.0
riscv                 randconfig-002-20240924    gcc-14.1.0
s390                             allmodconfig    gcc-14.1.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.1.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20240924    gcc-14.1.0
s390                  randconfig-002-20240924    gcc-14.1.0
sh                               allmodconfig    gcc-14.1.0
sh                                allnoconfig    gcc-14.1.0
sh                               allyesconfig    gcc-14.1.0
sh                         ap325rxa_defconfig    clang-20
sh                         apsh4a3a_defconfig    clang-20
sh                                  defconfig    gcc-12
sh                        dreamcast_defconfig    clang-20
sh                          polaris_defconfig    clang-20
sh                    randconfig-001-20240924    gcc-14.1.0
sh                    randconfig-002-20240924    gcc-14.1.0
sh                          rsk7264_defconfig    clang-20
sh                   rts7751r2dplus_defconfig    clang-20
sh                           se7721_defconfig    clang-20
sh                        sh7763rdp_defconfig    clang-20
sh                             shx3_defconfig    clang-20
sparc                            allmodconfig    gcc-14.1.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20240924    gcc-14.1.0
sparc64               randconfig-002-20240924    gcc-14.1.0
um                               allmodconfig    clang-20
um                                allnoconfig    clang-17
um                                allnoconfig    clang-20
um                               allyesconfig    clang-20
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20240924    gcc-14.1.0
um                    randconfig-002-20240924    gcc-14.1.0
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-18
x86_64                           allyesconfig    clang-18
x86_64      buildonly-randconfig-001-20240924    clang-18
x86_64      buildonly-randconfig-002-20240924    clang-18
x86_64      buildonly-randconfig-003-20240924    clang-18
x86_64      buildonly-randconfig-004-20240924    clang-18
x86_64      buildonly-randconfig-005-20240924    clang-18
x86_64      buildonly-randconfig-006-20240924    clang-18
x86_64                              defconfig    clang-18
x86_64                                  kexec    clang-18
x86_64                                  kexec    gcc-12
x86_64                randconfig-001-20240924    clang-18
x86_64                randconfig-002-20240924    clang-18
x86_64                randconfig-003-20240924    clang-18
x86_64                randconfig-004-20240924    clang-18
x86_64                randconfig-005-20240924    clang-18
x86_64                randconfig-006-20240924    clang-18
x86_64                randconfig-011-20240924    clang-18
x86_64                randconfig-012-20240924    clang-18
x86_64                randconfig-013-20240924    clang-18
x86_64                randconfig-014-20240924    clang-18
x86_64                randconfig-015-20240924    clang-18
x86_64                randconfig-016-20240924    clang-18
x86_64                randconfig-071-20240924    clang-18
x86_64                randconfig-072-20240924    clang-18
x86_64                randconfig-073-20240924    clang-18
x86_64                randconfig-074-20240924    clang-18
x86_64                randconfig-075-20240924    clang-18
x86_64                randconfig-076-20240924    clang-18
x86_64                               rhel-8.3    gcc-12
x86_64                          rhel-8.3-rust    clang-18
xtensa                            allnoconfig    gcc-14.1.0
xtensa                randconfig-001-20240924    gcc-14.1.0
xtensa                randconfig-002-20240924    gcc-14.1.0
xtensa                         virt_defconfig    clang-20

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
