Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 868611BF32B
	for <linux-bluetooth@vger.kernel.org>; Fri,  2 Aug 2024 09:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722592028; cv=none; b=Lt9UgcYVPwfUsT7vuBbiBFinJoc55yZ+jdJO8zStnKKXawiPu74IVAdjxve+5LWDm/IUpnVpokZBziEz3XQGmfinImcxpgRl2TKnUdLQ4L5MrZfzAVO8WbJd70RooqmMhdGlGxgvkMkHH94hTuZqdFcZPx9QX99Jvu7joCCMHUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722592028; c=relaxed/simple;
	bh=1sW0daJZ1HHdt2imhU/Aga4u72nKv4oU0dhrWhfw7uk=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Fk5WGnvHaHFZqaUDT2PT2jGjKKFHySsaI8wxHzxkS3Pm8UmXlV7SoE7uMdZQT9t718DnbjMnHK3F1wlZScU0IIe8nC/ORtvLGpsLAgGwLYTrEn/oecfAN2ujIDuDU74mFnU2TUUEdM7a9sHb3mrl3m0E0qHtwQsVufBGtx9H4Dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JhWwYHmV; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JhWwYHmV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722592025; x=1754128025;
  h=date:from:to:cc:subject:message-id;
  bh=1sW0daJZ1HHdt2imhU/Aga4u72nKv4oU0dhrWhfw7uk=;
  b=JhWwYHmVSQOAVAoXQXfKjr8uz41907PugmQa2r3dYTbH7/SEBj1kfNt9
   r2DHIDuDftcWDqCkC62sKgoJIv1mCCw8EZv83XfmoJNqXTNp5gR9ORPn/
   ooaw8jP/m7R00D0xjIgrSDd7LGnB0eOfYxAs6eBdwL8lrtGWYlpCeeduX
   SkyEGeoPyebGXP+1Mm7daXEsgId4TbL2O1JfJMup0yR2yNTCX5yPCW/02
   V4E0GMLxqzhOXc3JVn2ZV/6h4ZE0wT2RNymDu9IljgyQm+WTj8dWt0vgY
   ZQxDZPdUsLszIU/+7ka52HdCCMe1avC4h5Istsr3zGt5NorcXyJgoOsyh
   g==;
X-CSE-ConnectionGUID: M5T8eK3+Rs6cozWbjFXeJQ==
X-CSE-MsgGUID: sucEWEqVQ/amicSDS9ErQQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11151"; a="38105890"
X-IronPort-AV: E=Sophos;i="6.09,257,1716274800"; 
   d="scan'208";a="38105890"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2024 02:47:05 -0700
X-CSE-ConnectionGUID: zgsCLsZpTg2PhDunUK07eA==
X-CSE-MsgGUID: IFXoOBljS7uT0JsdhASfjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,257,1716274800"; 
   d="scan'208";a="55583181"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 02 Aug 2024 02:47:04 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sZosH-000wbU-1d;
	Fri, 02 Aug 2024 09:47:01 +0000
Date: Fri, 02 Aug 2024 17:46:01 +0800
From: kernel test robot <lkp@intel.com>
To: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 2360f368524bb817b71bdd2efed53d0c3c3929ad
Message-ID: <202408021758.Bjj25gwB-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: 2360f368524bb817b71bdd2efed53d0c3c3929ad  Bluetooth: hci_sync: avoid dup filtering when passive scanning with adv monitor

elapsed time: 1499m

configs tested: 228
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-13.2.0
alpha                            allyesconfig   gcc-13.3.0
alpha                               defconfig   gcc-13.2.0
arc                              allmodconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                              allyesconfig   gcc-13.2.0
arc                          axs101_defconfig   gcc-13.2.0
arc                                 defconfig   gcc-13.2.0
arc                   randconfig-001-20240801   gcc-13.2.0
arc                   randconfig-002-20240801   gcc-13.2.0
arc                        vdk_hs38_defconfig   gcc-13.2.0
arm                              allmodconfig   gcc-13.2.0
arm                               allnoconfig   gcc-13.2.0
arm                              allyesconfig   gcc-13.2.0
arm                       aspeed_g5_defconfig   gcc-14.1.0
arm                     davinci_all_defconfig   gcc-14.1.0
arm                                 defconfig   gcc-13.2.0
arm                          ep93xx_defconfig   gcc-14.1.0
arm                      integrator_defconfig   gcc-13.2.0
arm                          ixp4xx_defconfig   clang-20
arm                      jornada720_defconfig   gcc-14.1.0
arm                   randconfig-001-20240801   gcc-13.2.0
arm                   randconfig-002-20240801   gcc-13.2.0
arm                   randconfig-003-20240801   gcc-13.2.0
arm                   randconfig-004-20240801   gcc-13.2.0
arm                         s3c6400_defconfig   gcc-13.2.0
arm                        shmobile_defconfig   gcc-14.1.0
arm                           sunxi_defconfig   gcc-13.2.0
arm                    vt8500_v6_v7_defconfig   clang-20
arm64                            allmodconfig   gcc-13.2.0
arm64                             allnoconfig   gcc-13.2.0
arm64                               defconfig   gcc-13.2.0
arm64                 randconfig-001-20240801   gcc-13.2.0
arm64                 randconfig-002-20240801   gcc-13.2.0
arm64                 randconfig-003-20240801   gcc-13.2.0
arm64                 randconfig-004-20240801   gcc-13.2.0
csky                              allnoconfig   gcc-13.2.0
csky                                defconfig   gcc-13.2.0
csky                  randconfig-001-20240801   gcc-13.2.0
csky                  randconfig-002-20240801   gcc-13.2.0
i386                             allmodconfig   clang-18
i386                              allnoconfig   clang-18
i386                             allyesconfig   clang-18
i386         buildonly-randconfig-001-20240801   gcc-9
i386         buildonly-randconfig-001-20240802   gcc-13
i386         buildonly-randconfig-002-20240801   gcc-9
i386         buildonly-randconfig-002-20240802   gcc-13
i386         buildonly-randconfig-003-20240801   gcc-9
i386         buildonly-randconfig-003-20240802   gcc-13
i386         buildonly-randconfig-004-20240801   gcc-9
i386         buildonly-randconfig-004-20240802   gcc-13
i386         buildonly-randconfig-005-20240801   gcc-9
i386         buildonly-randconfig-005-20240802   gcc-13
i386         buildonly-randconfig-006-20240801   gcc-9
i386         buildonly-randconfig-006-20240802   gcc-13
i386                                defconfig   clang-18
i386                  randconfig-001-20240801   gcc-9
i386                  randconfig-001-20240802   gcc-13
i386                  randconfig-002-20240801   gcc-9
i386                  randconfig-002-20240802   gcc-13
i386                  randconfig-003-20240801   gcc-9
i386                  randconfig-003-20240802   gcc-13
i386                  randconfig-004-20240801   gcc-9
i386                  randconfig-004-20240802   gcc-13
i386                  randconfig-005-20240801   gcc-9
i386                  randconfig-005-20240802   gcc-13
i386                  randconfig-006-20240801   gcc-9
i386                  randconfig-006-20240802   gcc-13
i386                  randconfig-011-20240801   gcc-9
i386                  randconfig-011-20240802   gcc-13
i386                  randconfig-012-20240801   gcc-9
i386                  randconfig-012-20240802   gcc-13
i386                  randconfig-013-20240801   gcc-9
i386                  randconfig-013-20240802   gcc-13
i386                  randconfig-014-20240801   gcc-9
i386                  randconfig-014-20240802   gcc-13
i386                  randconfig-015-20240801   gcc-9
i386                  randconfig-015-20240802   gcc-13
i386                  randconfig-016-20240801   gcc-9
i386                  randconfig-016-20240802   gcc-13
loongarch                        allmodconfig   gcc-14.1.0
loongarch                         allnoconfig   gcc-13.2.0
loongarch                           defconfig   gcc-13.2.0
loongarch             randconfig-001-20240801   gcc-13.2.0
loongarch             randconfig-002-20240801   gcc-13.2.0
m68k                             allmodconfig   gcc-14.1.0
m68k                              allnoconfig   gcc-13.2.0
m68k                             allyesconfig   gcc-14.1.0
m68k                                defconfig   gcc-13.2.0
m68k                           virt_defconfig   gcc-13.2.0
microblaze                       allmodconfig   gcc-14.1.0
microblaze                        allnoconfig   gcc-13.2.0
microblaze                       allyesconfig   gcc-14.1.0
microblaze                          defconfig   gcc-13.2.0
mips                              allnoconfig   gcc-13.2.0
mips                          eyeq5_defconfig   gcc-14.1.0
mips                           jazz_defconfig   gcc-14.1.0
mips                malta_qemu_32r6_defconfig   gcc-13.2.0
mips                      maltasmvp_defconfig   gcc-13.2.0
mips                          rb532_defconfig   clang-20
nios2                             allnoconfig   gcc-13.2.0
nios2                               defconfig   gcc-13.2.0
nios2                 randconfig-001-20240801   gcc-13.2.0
nios2                 randconfig-002-20240801   gcc-13.2.0
openrisc                         alldefconfig   gcc-14.1.0
openrisc                          allnoconfig   gcc-14.1.0
openrisc                         allyesconfig   gcc-14.1.0
openrisc                            defconfig   gcc-14.1.0
parisc                           allmodconfig   gcc-14.1.0
parisc                            allnoconfig   gcc-14.1.0
parisc                           allyesconfig   gcc-14.1.0
parisc                              defconfig   gcc-14.1.0
parisc                randconfig-001-20240801   gcc-13.2.0
parisc                randconfig-002-20240801   gcc-13.2.0
parisc64                            defconfig   gcc-13.2.0
powerpc                          allmodconfig   gcc-14.1.0
powerpc                           allnoconfig   gcc-14.1.0
powerpc                          allyesconfig   gcc-14.1.0
powerpc                   bluestone_defconfig   clang-20
powerpc                        icon_defconfig   gcc-14.1.0
powerpc                  iss476-smp_defconfig   clang-20
powerpc                 linkstation_defconfig   clang-20
powerpc                   lite5200b_defconfig   clang-20
powerpc                       maple_defconfig   gcc-13.2.0
powerpc                   microwatt_defconfig   clang-20
powerpc                    mvme5100_defconfig   clang-20
powerpc                     rainier_defconfig   gcc-13.2.0
powerpc               randconfig-001-20240801   gcc-13.2.0
powerpc               randconfig-002-20240801   gcc-13.2.0
powerpc               randconfig-003-20240801   gcc-13.2.0
powerpc                    sam440ep_defconfig   gcc-14.1.0
powerpc                     sequoia_defconfig   gcc-13.2.0
powerpc                     tqm8540_defconfig   gcc-14.1.0
powerpc64             randconfig-001-20240801   gcc-13.2.0
powerpc64             randconfig-002-20240801   gcc-13.2.0
powerpc64             randconfig-003-20240801   gcc-13.2.0
riscv                            allmodconfig   gcc-14.1.0
riscv                             allnoconfig   gcc-14.1.0
riscv                            allyesconfig   gcc-14.1.0
riscv                               defconfig   gcc-14.1.0
riscv                    nommu_virt_defconfig   gcc-14.1.0
riscv                 randconfig-001-20240801   gcc-13.2.0
riscv                 randconfig-002-20240801   gcc-13.2.0
s390                             allmodconfig   clang-20
s390                              allnoconfig   gcc-14.1.0
s390                             allyesconfig   clang-20
s390                                defconfig   gcc-14.1.0
s390                  randconfig-001-20240801   gcc-13.2.0
s390                  randconfig-002-20240801   gcc-13.2.0
sh                                allnoconfig   gcc-13.2.0
sh                                  defconfig   gcc-14.1.0
sh                        edosk7760_defconfig   gcc-13.2.0
sh                          r7785rp_defconfig   gcc-14.1.0
sh                    randconfig-001-20240801   gcc-13.2.0
sh                    randconfig-002-20240801   gcc-13.2.0
sh                          rsk7269_defconfig   gcc-13.2.0
sh                             sh03_defconfig   gcc-13.2.0
sh                            titan_defconfig   gcc-13.2.0
sh                          urquell_defconfig   gcc-14.1.0
sparc64                             defconfig   gcc-14.1.0
sparc64               randconfig-001-20240801   gcc-13.2.0
sparc64               randconfig-002-20240801   gcc-13.2.0
um                               allmodconfig   gcc-13.3.0
um                                allnoconfig   gcc-14.1.0
um                               allyesconfig   gcc-13.3.0
um                                  defconfig   gcc-14.1.0
um                             i386_defconfig   gcc-14.1.0
um                    randconfig-001-20240801   gcc-13.2.0
um                    randconfig-002-20240801   gcc-13.2.0
um                           x86_64_defconfig   gcc-14.1.0
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240801   clang-18
x86_64       buildonly-randconfig-001-20240802   gcc-8
x86_64       buildonly-randconfig-002-20240801   clang-18
x86_64       buildonly-randconfig-002-20240802   gcc-8
x86_64       buildonly-randconfig-003-20240801   clang-18
x86_64       buildonly-randconfig-003-20240802   gcc-8
x86_64       buildonly-randconfig-004-20240801   clang-18
x86_64       buildonly-randconfig-004-20240802   gcc-8
x86_64       buildonly-randconfig-005-20240801   clang-18
x86_64       buildonly-randconfig-005-20240802   gcc-8
x86_64       buildonly-randconfig-006-20240801   clang-18
x86_64       buildonly-randconfig-006-20240802   gcc-8
x86_64                              defconfig   clang-18
x86_64                randconfig-001-20240801   clang-18
x86_64                randconfig-001-20240802   gcc-8
x86_64                randconfig-002-20240801   clang-18
x86_64                randconfig-002-20240802   gcc-8
x86_64                randconfig-003-20240801   clang-18
x86_64                randconfig-003-20240802   gcc-8
x86_64                randconfig-004-20240801   clang-18
x86_64                randconfig-004-20240802   gcc-8
x86_64                randconfig-005-20240801   clang-18
x86_64                randconfig-005-20240802   gcc-8
x86_64                randconfig-006-20240801   clang-18
x86_64                randconfig-006-20240802   gcc-8
x86_64                randconfig-011-20240801   clang-18
x86_64                randconfig-011-20240802   gcc-8
x86_64                randconfig-012-20240801   clang-18
x86_64                randconfig-012-20240802   gcc-8
x86_64                randconfig-013-20240801   clang-18
x86_64                randconfig-013-20240802   gcc-8
x86_64                randconfig-014-20240801   clang-18
x86_64                randconfig-014-20240802   gcc-8
x86_64                randconfig-015-20240801   clang-18
x86_64                randconfig-015-20240802   gcc-8
x86_64                randconfig-016-20240801   clang-18
x86_64                randconfig-016-20240802   gcc-8
x86_64                randconfig-071-20240801   clang-18
x86_64                randconfig-071-20240802   gcc-8
x86_64                randconfig-072-20240801   clang-18
x86_64                randconfig-072-20240802   gcc-8
x86_64                randconfig-073-20240801   clang-18
x86_64                randconfig-073-20240802   gcc-8
x86_64                randconfig-074-20240801   clang-18
x86_64                randconfig-074-20240802   gcc-8
x86_64                randconfig-075-20240801   clang-18
x86_64                randconfig-075-20240802   gcc-8
x86_64                randconfig-076-20240801   clang-18
x86_64                randconfig-076-20240802   gcc-8
x86_64                          rhel-8.3-rust   clang-18
xtensa                            allnoconfig   gcc-13.2.0
xtensa                  audio_kc705_defconfig   gcc-13.2.0
xtensa                       common_defconfig   gcc-13.2.0
xtensa                          iss_defconfig   gcc-14.1.0
xtensa                randconfig-001-20240801   gcc-13.2.0
xtensa                randconfig-002-20240801   gcc-13.2.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
