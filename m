Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EFB94A18
	for <linux-bluetooth@vger.kernel.org>; Wed, 22 Jan 2025 17:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737567435; cv=none; b=BRcdnznARy1o/UmmsphpRcTQrlTVHyxbBEIpFwNTjdaBNxurfdebRHqR7oBnmNWhsCePoLShb2oomkBFJF4AiO30Pvs/KVdnHDKDtaoS19uwGN2nue9hWTEJzplUBuxdAR5kufMa2tTnhms+5VCX8i66PwBqrAqVbQ9cIBGiF1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737567435; c=relaxed/simple;
	bh=0D5Zp+1xmvhhdIcgaWDNj/qPWrIXcvxwwD5HnhZOsHE=;
	h=Date:From:To:Cc:Subject:Message-ID; b=oSARM56bS5gvBNfL0v/kqBUN8U60kIWGECGI0C7hvaJkpeHaiXqWicuB7/Bo9UT/nf1QIimDfOZVHw8cUjkpTMf59rg1jE2zWCwVIdpRO8K3148AXPsUogiBnF9K84kbU2FU33qsbFroX0zLohWsnqiib+/xDrOBhB1OcmUObZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TYJ4becD; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TYJ4becD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737567433; x=1769103433;
  h=date:from:to:cc:subject:message-id;
  bh=0D5Zp+1xmvhhdIcgaWDNj/qPWrIXcvxwwD5HnhZOsHE=;
  b=TYJ4becDRuL8a1QMs9xJdH3T5J2mrYA7xGkdGDR18LkOx5iG5Bq58cyB
   iDNUouoKD/PWaVWiBj39BZx47/1yikdMmGYedQbDGWK6O5fHuZoKcJbl6
   1439XrG6HNQuUzUtS2Ne8ffpRPcoIG6I2+rF1GJk2jiDFFTE7frvaCS74
   cSWdD/Z+GOkc/bj46X7wODKGm8CTIGQ5FDulUBkMGzCOjx3xpHvYzYRSY
   T8DLC8sZDcdCn7W+pgzZwMzoDW13/VpL2baV8PvBzeQOHHU3gEutU5PkY
   greq7Wi7q5kNLq+DVVKdn5GKjc9P0no5byf+5bLjUfRL7TygiAmspqJas
   A==;
X-CSE-ConnectionGUID: 6jNj5RxaTAG77Drr0mSVJA==
X-CSE-MsgGUID: oUSBVUYPQx2J9fl9z8cFIA==
X-IronPort-AV: E=McAfee;i="6700,10204,11323"; a="60505743"
X-IronPort-AV: E=Sophos;i="6.13,225,1732608000"; 
   d="scan'208";a="60505743"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2025 09:37:12 -0800
X-CSE-ConnectionGUID: trDwveBHRuO2sAXNFgCbcw==
X-CSE-MsgGUID: MRQ2VEWlSL+WVnEuTKiGAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="111848013"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 22 Jan 2025 09:37:11 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1taef6-000aAF-2l;
	Wed, 22 Jan 2025 17:37:08 +0000
Date: Thu, 23 Jan 2025 01:36:20 +0800
From: kernel test robot <lkp@intel.com>
To: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 07b6216dfc34029a7663100fad7cc2c22dd77a74
Message-ID: <202501230114.H5fhnjOK-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: 07b6216dfc34029a7663100fad7cc2c22dd77a74  Bluetooth: Add ABI doc for sysfs reset

elapsed time: 1441m

configs tested: 188
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    clang-20
alpha                            allyesconfig    gcc-14.2.0
alpha                               defconfig    gcc-14.2.0
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-13.2.0
arc                              allyesconfig    gcc-13.2.0
arc                                 defconfig    gcc-14.2.0
arc                   randconfig-001-20250122    gcc-13.2.0
arc                   randconfig-002-20250122    gcc-13.2.0
arm                               allnoconfig    clang-17
arm                              allyesconfig    gcc-14.2.0
arm                         assabet_defconfig    gcc-14.2.0
arm                         at91_dt_defconfig    clang-20
arm                                 defconfig    gcc-14.2.0
arm                            hisi_defconfig    clang-20
arm                        multi_v7_defconfig    gcc-14.2.0
arm                   randconfig-001-20250122    clang-19
arm                   randconfig-002-20250122    clang-20
arm                   randconfig-003-20250122    gcc-14.2.0
arm                   randconfig-004-20250122    gcc-14.2.0
arm                          sp7021_defconfig    clang-20
arm64                             allnoconfig    gcc-14.2.0
arm64                               defconfig    gcc-14.2.0
arm64                 randconfig-001-20250122    clang-20
arm64                 randconfig-002-20250122    clang-15
arm64                 randconfig-003-20250122    clang-20
arm64                 randconfig-004-20250122    clang-19
csky                              allnoconfig    gcc-14.2.0
csky                                defconfig    gcc-14.2.0
csky                  randconfig-001-20250122    gcc-14.2.0
csky                  randconfig-002-20250122    gcc-14.2.0
hexagon                          alldefconfig    gcc-14.2.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    clang-20
hexagon                          allyesconfig    clang-18
hexagon                          allyesconfig    clang-20
hexagon                             defconfig    gcc-14.2.0
hexagon               randconfig-001-20250122    clang-20
hexagon               randconfig-001-20250122    gcc-14.2.0
hexagon               randconfig-002-20250122    clang-20
hexagon               randconfig-002-20250122    gcc-14.2.0
i386                             allmodconfig    clang-19
i386                              allnoconfig    clang-19
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-19
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250122    clang-19
i386        buildonly-randconfig-001-20250122    gcc-12
i386        buildonly-randconfig-002-20250122    gcc-12
i386        buildonly-randconfig-003-20250122    gcc-12
i386        buildonly-randconfig-004-20250122    clang-19
i386        buildonly-randconfig-004-20250122    gcc-12
i386        buildonly-randconfig-005-20250122    clang-19
i386        buildonly-randconfig-005-20250122    gcc-12
i386        buildonly-randconfig-006-20250122    clang-19
i386        buildonly-randconfig-006-20250122    gcc-12
i386                                defconfig    clang-19
i386                  randconfig-001-20250122    clang-19
i386                  randconfig-002-20250122    clang-19
i386                  randconfig-003-20250122    clang-19
i386                  randconfig-004-20250122    clang-19
i386                  randconfig-005-20250122    clang-19
i386                  randconfig-006-20250122    clang-19
i386                  randconfig-007-20250122    clang-19
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch                           defconfig    gcc-14.2.0
loongarch             randconfig-001-20250122    gcc-14.2.0
loongarch             randconfig-002-20250122    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                                defconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
microblaze                          defconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                        bcm63xx_defconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                               defconfig    gcc-14.2.0
nios2                 randconfig-001-20250122    gcc-14.2.0
nios2                 randconfig-002-20250122    gcc-14.2.0
openrisc                          allnoconfig    clang-20
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    clang-20
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-12
parisc                randconfig-001-20250122    gcc-14.2.0
parisc                randconfig-002-20250122    gcc-14.2.0
parisc64                            defconfig    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    clang-20
powerpc                          allyesconfig    clang-16
powerpc                          allyesconfig    gcc-14.2.0
powerpc                     kmeter1_defconfig    gcc-14.2.0
powerpc                       ppc64_defconfig    clang-20
powerpc               randconfig-001-20250122    gcc-14.2.0
powerpc               randconfig-002-20250122    clang-17
powerpc               randconfig-002-20250122    gcc-14.2.0
powerpc               randconfig-003-20250122    clang-15
powerpc               randconfig-003-20250122    gcc-14.2.0
powerpc                    sam440ep_defconfig    clang-20
powerpc                         wii_defconfig    gcc-14.2.0
powerpc64             randconfig-001-20250122    clang-20
powerpc64             randconfig-001-20250122    gcc-14.2.0
powerpc64             randconfig-002-20250122    clang-19
powerpc64             randconfig-002-20250122    gcc-14.2.0
powerpc64             randconfig-003-20250122    clang-20
powerpc64             randconfig-003-20250122    gcc-14.2.0
riscv                            allmodconfig    clang-20
riscv                            allmodconfig    gcc-14.2.0
riscv                             allnoconfig    clang-20
riscv                            allyesconfig    clang-20
riscv                            allyesconfig    gcc-14.2.0
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20250122    clang-20
riscv                 randconfig-002-20250122    gcc-14.2.0
s390                             allmodconfig    clang-19
s390                             allmodconfig    gcc-14.2.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20250122    clang-18
s390                  randconfig-002-20250122    clang-20
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-12
sh                            hp6xx_defconfig    gcc-14.2.0
sh                    randconfig-001-20250122    gcc-14.2.0
sh                    randconfig-002-20250122    gcc-14.2.0
sh                           se7705_defconfig    clang-20
sh                             sh03_defconfig    clang-20
sh                           sh2007_defconfig    clang-20
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250122    gcc-14.2.0
sparc                 randconfig-002-20250122    gcc-14.2.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20250122    gcc-14.2.0
sparc64               randconfig-002-20250122    gcc-14.2.0
um                               allmodconfig    clang-20
um                                allnoconfig    clang-20
um                               allyesconfig    clang-20
um                               allyesconfig    gcc-12
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250122    gcc-12
um                    randconfig-002-20250122    clang-20
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20250122    gcc-12
x86_64      buildonly-randconfig-002-20250122    clang-19
x86_64      buildonly-randconfig-003-20250122    gcc-12
x86_64      buildonly-randconfig-004-20250122    gcc-12
x86_64      buildonly-randconfig-005-20250122    gcc-12
x86_64      buildonly-randconfig-006-20250122    clang-19
x86_64                              defconfig    clang-19
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-19
x86_64                randconfig-001-20250122    gcc-12
x86_64                randconfig-002-20250122    gcc-12
x86_64                randconfig-003-20250122    gcc-12
x86_64                randconfig-004-20250122    gcc-12
x86_64                randconfig-005-20250122    gcc-12
x86_64                randconfig-006-20250122    gcc-12
x86_64                randconfig-007-20250122    gcc-12
x86_64                randconfig-008-20250122    gcc-12
x86_64                randconfig-071-20250122    clang-19
x86_64                randconfig-072-20250122    clang-19
x86_64                randconfig-073-20250122    clang-19
x86_64                randconfig-074-20250122    clang-19
x86_64                randconfig-075-20250122    clang-19
x86_64                randconfig-076-20250122    clang-19
x86_64                randconfig-077-20250122    clang-19
x86_64                randconfig-078-20250122    clang-19
x86_64                               rhel-9.4    clang-19
x86_64                           rhel-9.4-bpf    clang-19
x86_64                         rhel-9.4-kunit    clang-19
x86_64                           rhel-9.4-ltp    clang-19
x86_64                          rhel-9.4-rust    clang-19
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250122    gcc-14.2.0
xtensa                randconfig-002-20250122    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
