Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7F04191F8C
	for <linux-bluetooth@vger.kernel.org>; Sat, 24 May 2025 11:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748087453; cv=none; b=gSoVFGXCzQq0O0QAZb9yHYQkmEb+1KCX3mnWIWnmwrDav1akSB9BoJq5nhoQ6Aq2O+E/JCmxbYAwQhDcfH+07X7xdDcDbFBKGKAqySIgVsZfiLmzFvotT1c352HaQdR+OED05sm5TX1Yxoabsqba/0Nd12MHZivjVLlQS7Y8qwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748087453; c=relaxed/simple;
	bh=7iJinw8Qw7YqKCaQj+GlzpfC1CLnqG8W/qWAV9bpSSg=;
	h=Date:From:To:Cc:Subject:Message-ID; b=mHDBQQ/vSdcBdekehSq7uKMEdQvaw5TXMFrt10W+nT/r/9ZJQ5FV8foALF/iwGesw7upe/Tg8VMYQWgAMMtaV7T4l1VVh50XqEMtlyMTnt/e1r7CSLjbja1otjGMc6AwO91h0MIunPptrEBZgpC5yuNUQMufccdC2YDGk3yp2Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JwtyxxlV; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JwtyxxlV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748087452; x=1779623452;
  h=date:from:to:cc:subject:message-id;
  bh=7iJinw8Qw7YqKCaQj+GlzpfC1CLnqG8W/qWAV9bpSSg=;
  b=JwtyxxlVvRQkc1SU7atSXeVG4iMAkofCnI9PX3fay7NycXHEo1lx3Wkt
   /Nbroemy1Oko7YB4UPc8ojU7+ncAtxJEFVNOnCJ3CA1gCMICXky/kteUa
   G8bZiT1A/DydlWnV3Gfbue9NtOgg0UlMtaAZD/3dW34mQ7Cqtec+jwlYb
   3Nz8LOAquYNWpQtBegNl/4zlzU2Bq2qNaBBSMYIY7BJzhsV/oZqz9HqlS
   K/s727O8DbEHPubxNU0ZepdQV6idadSs4j5aVNmvcNG0ebiRoo/RzfHdf
   kzY7GuBHv4y56p60X0xb+kUW4zCOIQJKr9tTxtMPnXgP5ux9sYoi9zT9R
   Q==;
X-CSE-ConnectionGUID: ArAxeaQFSmW9Rs7yKr8oxA==
X-CSE-MsgGUID: sPOAe/k9SCS6QdVsBuYOHw==
X-IronPort-AV: E=McAfee;i="6700,10204,11441"; a="53919920"
X-IronPort-AV: E=Sophos;i="6.15,311,1739865600"; 
   d="scan'208";a="53919920"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2025 04:50:51 -0700
X-CSE-ConnectionGUID: C3lWHIZiSOCTxjDFE3Uy5g==
X-CSE-MsgGUID: LHkBiboIRp6k2ftlOmszNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,311,1739865600"; 
   d="scan'208";a="146718037"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 24 May 2025 04:50:50 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uInOq-000RAq-01;
	Sat, 24 May 2025 11:50:48 +0000
Date: Sat, 24 May 2025 19:50:13 +0800
From: kernel test robot <lkp@intel.com>
To: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 2ab3abab237b60e7cc1ac6f6f69ef83a11ce4881
Message-ID: <202505241903.CHLKhK6W-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: 2ab3abab237b60e7cc1ac6f6f69ef83a11ce4881  Bluetooth: MGMT: reject malformed HCI_CMD_SYNC commands

elapsed time: 1241m

configs tested: 119
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
arc                              allmodconfig    gcc-14.2.0
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    gcc-14.2.0
arc                        nsim_700_defconfig    gcc-14.2.0
arc                   randconfig-001-20250524    gcc-15.1.0
arc                   randconfig-002-20250524    gcc-15.1.0
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-21
arm                              allyesconfig    gcc-14.2.0
arm                            dove_defconfig    gcc-14.2.0
arm                          ep93xx_defconfig    clang-21
arm                      footbridge_defconfig    clang-17
arm                         nhk8815_defconfig    clang-21
arm                   randconfig-001-20250524    gcc-7.5.0
arm                   randconfig-002-20250524    gcc-7.5.0
arm                   randconfig-003-20250524    clang-20
arm                   randconfig-004-20250524    gcc-7.5.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20250524    gcc-5.5.0
arm64                 randconfig-002-20250524    gcc-7.5.0
arm64                 randconfig-003-20250524    clang-19
arm64                 randconfig-004-20250524    gcc-7.5.0
csky                              allnoconfig    gcc-14.2.0
csky                  randconfig-001-20250524    gcc-11.5.0
csky                  randconfig-002-20250524    gcc-9.3.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-21
hexagon               randconfig-001-20250524    clang-21
hexagon               randconfig-002-20250524    clang-21
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250524    clang-20
i386        buildonly-randconfig-002-20250524    gcc-12
i386        buildonly-randconfig-003-20250524    gcc-12
i386        buildonly-randconfig-004-20250524    gcc-12
i386        buildonly-randconfig-005-20250524    clang-20
i386        buildonly-randconfig-006-20250524    clang-20
i386                                defconfig    clang-20
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20250524    gcc-13.3.0
loongarch             randconfig-002-20250524    gcc-15.1.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                         amcore_defconfig    gcc-14.2.0
m68k                          atari_defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                        bcm47xx_defconfig    clang-18
mips                           gcw0_defconfig    clang-21
mips                        qi_lb60_defconfig    clang-21
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250524    gcc-13.3.0
nios2                 randconfig-002-20250524    gcc-9.3.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                randconfig-001-20250524    gcc-6.5.0
parisc                randconfig-002-20250524    gcc-8.5.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-21
powerpc                      pasemi_defconfig    clang-21
powerpc                      pcm030_defconfig    clang-21
powerpc               randconfig-001-20250524    gcc-5.5.0
powerpc               randconfig-002-20250524    gcc-7.5.0
powerpc               randconfig-003-20250524    clang-21
powerpc                     tqm8555_defconfig    gcc-14.2.0
powerpc64             randconfig-001-20250524    gcc-7.5.0
powerpc64             randconfig-002-20250524    gcc-10.5.0
powerpc64             randconfig-003-20250524    clang-21
riscv                            allmodconfig    clang-21
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-16
riscv                 randconfig-001-20250524    clang-21
riscv                 randconfig-002-20250524    gcc-9.3.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-14.2.0
s390                  randconfig-001-20250524    clang-17
s390                  randconfig-002-20250524    gcc-8.5.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                    randconfig-001-20250524    gcc-13.3.0
sh                    randconfig-002-20250524    gcc-7.5.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250524    gcc-6.5.0
sparc                 randconfig-002-20250524    gcc-6.5.0
sparc64               randconfig-001-20250524    gcc-8.5.0
sparc64               randconfig-002-20250524    gcc-6.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    gcc-12
um                    randconfig-001-20250524    gcc-12
um                    randconfig-002-20250524    clang-21
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250524    gcc-12
x86_64      buildonly-randconfig-002-20250524    gcc-12
x86_64      buildonly-randconfig-003-20250524    gcc-12
x86_64      buildonly-randconfig-004-20250524    gcc-12
x86_64      buildonly-randconfig-005-20250524    gcc-11
x86_64      buildonly-randconfig-006-20250524    clang-20
x86_64                              defconfig    gcc-11
x86_64                          rhel-9.4-rust    clang-18
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250524    gcc-8.5.0
xtensa                randconfig-002-20250524    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
