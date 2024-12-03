Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 534D71E3DD8
	for <linux-bluetooth@vger.kernel.org>; Tue,  3 Dec 2024 11:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733224657; cv=none; b=p2pZMe+Sljv1+igsjG+mZde39F6lIzy7up2cXszH97x1n5eTiMAGuBDgLR6ZLiKm7CKhm3hsyraNlDht7SeR9exZNpNvETlHXbtK/GyaF4/v/AbfUlfgDRd7KFrZijYUnqMsQiJkEYqXp8N9DJb70+KZd+Zd7Ns/zhuWAocIIHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733224657; c=relaxed/simple;
	bh=lnZKTASrQsliNCsnBByUPNi51U1/9T34yRz8+Pq6sx0=;
	h=Date:From:To:Cc:Subject:Message-ID; b=q4W814dCtABDVe4HDePjmhdIzE35sAR9M6HtwodIHyhx+Tt2dDajdIiQXT8Z63ZDpoGe7qBNijg76iaZqvpqGd98lhO6n4VxJUGalMVeDylLbTaNhvwGOQ2CyuaJlaaOUSDn3suUCHJkQRHV5Uqw4vs8rD9f/XA/pXqkPnTdRCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JDyMWgNv; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JDyMWgNv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733224655; x=1764760655;
  h=date:from:to:cc:subject:message-id;
  bh=lnZKTASrQsliNCsnBByUPNi51U1/9T34yRz8+Pq6sx0=;
  b=JDyMWgNvG4vANGkmtldm8d09S6REB/gUvt0/hZme+xE+YHj3BTTz/2D/
   m0Vm1ZKgpbOxUsJZLGIsIsZtyPtOSIbfZW56332kLxuHPN+9rdAcyIVJ9
   EOHCjHW9hR4Jn7EUoikgHiI1KViw/67h+wnHIzgXFD27qxgwynixXComG
   o3+DzFHzYPeHBDirNC7Z3Hdb1DHazCaVFndh3XXOcSIrhfWQAy7wkZ3Ne
   WhGcflMv/I0rcSWuujYhZmp0SdRpZdkXuA1xxCAwGCa53W42Rv5RQTjJe
   NTWGCtcD8ZtdN9XWfAwkElXGK6iHNwbYq9b4kSOptnpQhRQ0K77T8GoJq
   w==;
X-CSE-ConnectionGUID: TVgwbUIOTSyCdBG9Rhrp7Q==
X-CSE-MsgGUID: 2PDrqsYfQNmpgX96CgiBVw==
X-IronPort-AV: E=McAfee;i="6700,10204,11274"; a="37204374"
X-IronPort-AV: E=Sophos;i="6.12,205,1728975600"; 
   d="scan'208";a="37204374"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2024 03:17:35 -0800
X-CSE-ConnectionGUID: vbVbBkraRT+Qine7vvECTw==
X-CSE-MsgGUID: osfVW6zwSaG5QyeICTufHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,205,1728975600"; 
   d="scan'208";a="124235675"
Received: from lkp-server01.sh.intel.com (HELO 388c121a226b) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 03 Dec 2024 03:17:33 -0800
Received: from kbuild by 388c121a226b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tIQuJ-0000Zy-1k;
	Tue, 03 Dec 2024 11:17:31 +0000
Date: Tue, 03 Dec 2024 19:14:56 +0800
From: kernel test robot <lkp@intel.com>
To: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 47ebf099106eb021cf7dd677720e6469a38785a5
Message-ID: <202412031946.OuFd0uCB-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: 47ebf099106eb021cf7dd677720e6469a38785a5  Bluetooth: iso: Allow BIG re-sync

elapsed time: 749m

configs tested: 118
configs skipped: 14

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    clang-20
arc                              allmodconfig    clang-20
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    clang-20
arc                            hsdk_defconfig    gcc-14.2.0
arc                   randconfig-001-20241203    clang-20
arc                   randconfig-001-20241203    gcc-13.2.0
arc                   randconfig-002-20241203    clang-20
arc                   randconfig-002-20241203    gcc-13.2.0
arc                    vdk_hs38_smp_defconfig    gcc-14.2.0
arm                              allmodconfig    clang-20
arm                               allnoconfig    gcc-14.2.0
arm                              allyesconfig    clang-20
arm                         at91_dt_defconfig    gcc-14.2.0
arm                         mv78xx0_defconfig    gcc-14.2.0
arm                   randconfig-001-20241203    clang-20
arm                   randconfig-002-20241203    clang-20
arm                   randconfig-002-20241203    gcc-14.2.0
arm                   randconfig-003-20241203    clang-20
arm                   randconfig-004-20241203    clang-20
arm                           stm32_defconfig    gcc-14.2.0
arm64                            allmodconfig    clang-20
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20241203    clang-20
arm64                 randconfig-001-20241203    gcc-14.2.0
arm64                 randconfig-002-20241203    clang-20
arm64                 randconfig-002-20241203    gcc-14.2.0
arm64                 randconfig-003-20241203    clang-20
arm64                 randconfig-003-20241203    gcc-14.2.0
arm64                 randconfig-004-20241203    clang-20
csky                             alldefconfig    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    gcc-14.2.0
hexagon                          allyesconfig    clang-20
i386        buildonly-randconfig-001-20241203    clang-19
i386        buildonly-randconfig-001-20241203    gcc-12
i386        buildonly-randconfig-002-20241203    clang-19
i386        buildonly-randconfig-002-20241203    gcc-12
i386        buildonly-randconfig-003-20241203    clang-19
i386        buildonly-randconfig-004-20241203    clang-19
i386        buildonly-randconfig-005-20241203    clang-19
i386        buildonly-randconfig-006-20241203    clang-19
i386        buildonly-randconfig-006-20241203    gcc-12
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch                 loongson3_defconfig    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                          hp300_defconfig    gcc-14.2.0
m68k                       m5275evb_defconfig    gcc-14.2.0
m68k                        stmark2_defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                  cavium_octeon_defconfig    gcc-14.2.0
mips                           ip28_defconfig    gcc-14.2.0
mips                        qi_lb60_defconfig    gcc-14.2.0
nios2                         3c120_defconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
openrisc                         alldefconfig    gcc-14.2.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                generic-64bit_defconfig    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    gcc-14.2.0
powerpc                      arches_defconfig    gcc-14.2.0
powerpc                     asp8347_defconfig    gcc-14.2.0
powerpc                   currituck_defconfig    gcc-14.2.0
powerpc                       eiger_defconfig    gcc-14.2.0
powerpc                    ge_imp3a_defconfig    gcc-14.2.0
powerpc                  iss476-smp_defconfig    gcc-14.2.0
powerpc                   motionpro_defconfig    gcc-14.2.0
powerpc                 mpc8315_rdb_defconfig    gcc-14.2.0
powerpc                     tqm8541_defconfig    gcc-14.2.0
riscv                            allmodconfig    gcc-14.2.0
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    gcc-14.2.0
s390                             allmodconfig    gcc-14.2.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.2.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                        edosk7705_defconfig    gcc-14.2.0
sh                        edosk7760_defconfig    gcc-14.2.0
sh                               j2_defconfig    gcc-14.2.0
sh                          kfr2r09_defconfig    gcc-14.2.0
sh                            migor_defconfig    gcc-14.2.0
sh                          r7780mp_defconfig    gcc-14.2.0
sh                           se7722_defconfig    gcc-14.2.0
sh                           se7724_defconfig    gcc-14.2.0
sh                        sh7785lcr_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
um                               allmodconfig    clang-20
um                                allnoconfig    clang-17
um                               allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20241203    clang-19
x86_64      buildonly-randconfig-001-20241203    gcc-11
x86_64      buildonly-randconfig-002-20241203    clang-19
x86_64      buildonly-randconfig-002-20241203    gcc-11
x86_64      buildonly-randconfig-003-20241203    clang-19
x86_64      buildonly-randconfig-003-20241203    gcc-11
x86_64      buildonly-randconfig-004-20241203    gcc-11
x86_64      buildonly-randconfig-005-20241203    gcc-11
x86_64      buildonly-randconfig-005-20241203    gcc-12
x86_64      buildonly-randconfig-006-20241203    clang-19
x86_64      buildonly-randconfig-006-20241203    gcc-11
xtensa                            allnoconfig    gcc-14.2.0
xtensa                         virt_defconfig    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
