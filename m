Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22F911B0F23
	for <linux-bluetooth@vger.kernel.org>; Fri, 18 Jul 2025 19:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752867052; cv=none; b=fCg16ENzq935EioRZ+ZNl8hxPSfRiMCUNGbYUOfIZSa4EMoP1f/Yf4zL8sEpigHgm1uBFql124tK6bdR616IG/64p/oURccf2zf50V5Eb66qJlSvMGT1E5sNCvY08+QqBflB31JcM58M/Z01nP6XdvS3sFElEHCjPXgNHkN5tvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752867052; c=relaxed/simple;
	bh=DENGTCDiG19qQMuFFeEbCYMNs5bqXUe8ua1f2rku1Fs=;
	h=Date:From:To:Cc:Subject:Message-ID; b=qtULPqAYMRGQQ+6ZahfrH7bV+IWQ+GpIBWlZelXk+JtyRvK4p45xPTHAmcowqHvGb4AtzV5OwrGZ7AY+zWyhc4Rtpd6OOnRvWQbif1FNu8dJC9V75tgAak6F3QPB9WcPEcTpQrda99vJQ5Jeo/2Ysw+1jw3ZnkyRRu1bl/tAr9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VZWQQ7/4; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VZWQQ7/4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752867051; x=1784403051;
  h=date:from:to:cc:subject:message-id;
  bh=DENGTCDiG19qQMuFFeEbCYMNs5bqXUe8ua1f2rku1Fs=;
  b=VZWQQ7/4HPj39pczmyy/JVthitydjzb1pF4Ufsa4qeJWAG3HpLMHjAvj
   25h/iGgtRsRTWCg5t86FyWDENV/mxL4uz/mxoEqRSmyIgNSc6Pr9u6jUy
   WMMhMaeQqoGyRvlNEhD/8lLG6j0QEcHTMsM4t+9cE+5EYSxQgiGWa6fAR
   auEMModZFBti8KSq22Ry3h//qkpaJXQEi4k9SavULRXwUvibRcqGYxuZI
   LVDtydpXNthKyFQG3UO23q0DEvruXqag+vcl4AZIn/stB+EEi7R37tTvz
   EmrAgEi+5cJe87kQzslDdPia6saqkXJ4sZD8Ab8ANGQ9i6iGKf5tbiGo0
   A==;
X-CSE-ConnectionGUID: UtKHuqRoQcWSPDZ8w2dgWg==
X-CSE-MsgGUID: 52EIEy2CRbCuBVJra2KqOg==
X-IronPort-AV: E=McAfee;i="6800,10657,11496"; a="58980751"
X-IronPort-AV: E=Sophos;i="6.16,322,1744095600"; 
   d="scan'208";a="58980751"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2025 12:30:50 -0700
X-CSE-ConnectionGUID: JRm41Y3pRNeQglj8qGi2Bw==
X-CSE-MsgGUID: zRMiacpFRrC7xzfLKyvr1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,322,1744095600"; 
   d="scan'208";a="189083594"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 18 Jul 2025 12:30:49 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ucqn7-000EyR-0T;
	Fri, 18 Jul 2025 19:30:45 +0000
Date: Sat, 19 Jul 2025 03:30:45 +0800
From: kernel test robot <lkp@intel.com>
To: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 2215f5c93ed12bdca19fe640574a0ee7f274325a
Message-ID: <202507190332.BykeDvyr-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: 2215f5c93ed12bdca19fe640574a0ee7f274325a  Bluetooth: hci_devcd_dump: fix out-of-bounds via dev_coredumpv

elapsed time: 1451m

configs tested: 103
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    gcc-15.1.0
arc                   randconfig-001-20250718    gcc-10.5.0
arc                   randconfig-002-20250718    gcc-15.1.0
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-21
arm                       omap2plus_defconfig    gcc-15.1.0
arm                   randconfig-001-20250718    gcc-7.5.0
arm                   randconfig-002-20250718    gcc-8.5.0
arm                   randconfig-003-20250718    gcc-6.5.0
arm                   randconfig-004-20250718    gcc-10.5.0
arm                        spear6xx_defconfig    clang-21
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20250718    gcc-13.4.0
arm64                 randconfig-002-20250718    gcc-5.5.0
arm64                 randconfig-003-20250718    clang-21
arm64                 randconfig-004-20250718    gcc-7.5.0
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20250718    gcc-15.1.0
csky                  randconfig-002-20250718    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-21
hexagon               randconfig-001-20250718    clang-21
hexagon               randconfig-002-20250718    clang-21
i386        buildonly-randconfig-001-20250718    gcc-12
i386        buildonly-randconfig-002-20250718    clang-20
i386        buildonly-randconfig-003-20250718    gcc-12
i386        buildonly-randconfig-004-20250718    gcc-11
i386        buildonly-randconfig-005-20250718    gcc-12
i386        buildonly-randconfig-006-20250718    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-21
loongarch             randconfig-001-20250718    gcc-15.1.0
loongarch             randconfig-002-20250718    gcc-15.1.0
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                           ip32_defconfig    clang-21
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20250718    gcc-8.5.0
nios2                 randconfig-002-20250718    gcc-11.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
openrisc                 simple_smp_defconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250718    gcc-14.3.0
parisc                randconfig-002-20250718    gcc-13.4.0
parisc64                            defconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc               randconfig-001-20250718    gcc-9.3.0
powerpc               randconfig-002-20250718    gcc-11.5.0
powerpc               randconfig-003-20250718    clang-17
powerpc                        warp_defconfig    gcc-15.1.0
powerpc64             randconfig-001-20250718    clang-18
powerpc64             randconfig-002-20250718    clang-21
powerpc64             randconfig-003-20250718    gcc-6.5.0
riscv                             allnoconfig    gcc-15.1.0
riscv                 randconfig-001-20250718    clang-21
riscv                 randconfig-002-20250718    clang-16
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-15.1.0
s390                  randconfig-001-20250718    clang-21
s390                  randconfig-002-20250718    clang-21
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                    randconfig-001-20250718    gcc-6.5.0
sh                    randconfig-002-20250718    gcc-7.5.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250718    gcc-10.3.0
sparc                 randconfig-002-20250718    gcc-11.5.0
sparc64               randconfig-001-20250718    gcc-10.5.0
sparc64               randconfig-002-20250718    clang-20
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    gcc-12
um                    randconfig-001-20250718    gcc-12
um                    randconfig-002-20250718    gcc-12
x86_64                            allnoconfig    clang-20
x86_64      buildonly-randconfig-001-20250718    clang-20
x86_64      buildonly-randconfig-002-20250718    gcc-12
x86_64      buildonly-randconfig-003-20250718    gcc-12
x86_64      buildonly-randconfig-004-20250718    clang-20
x86_64      buildonly-randconfig-005-20250718    clang-20
x86_64      buildonly-randconfig-006-20250718    clang-20
x86_64                              defconfig    gcc-11
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250718    gcc-7.5.0
xtensa                randconfig-002-20250718    gcc-12.4.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
