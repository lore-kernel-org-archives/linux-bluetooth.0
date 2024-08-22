Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A34613C9CB
	for <linux-bluetooth@vger.kernel.org>; Thu, 22 Aug 2024 16:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724343387; cv=none; b=sm/KhgDQAMEtUwVPeGp02sxeAxbRoZYPFF6+VdbxgxPSwKLSClLFY76dZ57aRPHzVSimdgQpgBudr38YL2qp9Z/TWy9iI6AHLFEuFzz6O3fsy8bnp2lWe2O9YOzE74TI25GOFCc9vyQAUvKwmjg6IG2J9b/bz2yPP8Y++reSf5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724343387; c=relaxed/simple;
	bh=1mJqwM31urFbryjqXOPnwIrHWrrskwz7oXqYF9Wu6XI=;
	h=Date:From:To:Cc:Subject:Message-ID; b=eoeEpQd1k9PokRCY4qFdwNnEidzz0blVV60drxTDv8JeOiRSxUIdC3ujI8WrEe3cvnW0oOpPjpKRBfpr7dZNgSMiUTMDeoXhhgX/UMsdQND3RH356LVz9sjmkcSmNcvvC5A4YKjKfRdmpSKKPuDHl6LAvpD2ZjBfNOKpmQfaLaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a1HpEO/c; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a1HpEO/c"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724343384; x=1755879384;
  h=date:from:to:cc:subject:message-id;
  bh=1mJqwM31urFbryjqXOPnwIrHWrrskwz7oXqYF9Wu6XI=;
  b=a1HpEO/cKT8I5ppte5Q/ga7b0jjx3tgAd2GBD1AL13bZCclo8BRTWhGG
   7CUxZbgjKByUuMm4Ckg8daCrDKSt5TMMuTHNMjn0M/YVvmH+6++B/GiPV
   4k0q5kGNq6SbhEWADyjteDJVvvhnPHq9VINCRCeCxrKYyH8ruEIH3cEvH
   dbgxWmjd79MUL7NiGOt4WOplC1KdOrNDVNyMKRoZz1afqShTzkOLyPI+H
   JuKICZdJX4rstHwVVMhCdTxtB8GNi7BOU6zb3QzDIIQYzUo5VP03DJAoi
   CFeGbfizP7W4jn33KeaoxmXtU9BeAt9Tu0LbV7t8mzrG3yrYXLp1banrH
   w==;
X-CSE-ConnectionGUID: RxgQRf3gTxOYYqnAo9geFQ==
X-CSE-MsgGUID: Qr4pGuBrTpiuemLIWZE1Rw==
X-IronPort-AV: E=McAfee;i="6700,10204,11172"; a="33438474"
X-IronPort-AV: E=Sophos;i="6.10,167,1719903600"; 
   d="scan'208";a="33438474"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2024 09:16:20 -0700
X-CSE-ConnectionGUID: TLf1A4uBQmeijZjsRpDFNQ==
X-CSE-MsgGUID: lS/Bm7KTRBiEZOlLeWgssw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,167,1719903600"; 
   d="scan'208";a="92242226"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 22 Aug 2024 09:16:18 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1shATw-000CyD-0x;
	Thu, 22 Aug 2024 16:16:16 +0000
Date: Fri, 23 Aug 2024 00:15:25 +0800
From: kernel test robot <lkp@intel.com>
To: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 a15c5bad17706e132334514a7502d6c0d67cd5d4
Message-ID: <202408230022.zfI7HCaq-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: a15c5bad17706e132334514a7502d6c0d67cd5d4  Bluetooth: btrtl: Use kvmemdup to simplify the code

elapsed time: 1457m

configs tested: 195
configs skipped: 7

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-13.2.0
alpha                             allnoconfig   gcc-13.3.0
alpha                            allyesconfig   gcc-13.3.0
alpha                               defconfig   gcc-13.2.0
arc                              allmodconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                              allyesconfig   gcc-13.2.0
arc                          axs103_defconfig   gcc-13.2.0
arc                                 defconfig   gcc-13.2.0
arc                     nsimosci_hs_defconfig   gcc-13.2.0
arc                   randconfig-001-20240822   gcc-13.2.0
arc                   randconfig-002-20240822   gcc-13.2.0
arm                              allmodconfig   gcc-13.2.0
arm                              allmodconfig   gcc-14.1.0
arm                               allnoconfig   clang-20
arm                               allnoconfig   gcc-13.2.0
arm                              allyesconfig   gcc-13.2.0
arm                              allyesconfig   gcc-14.1.0
arm                                 defconfig   gcc-13.2.0
arm                      footbridge_defconfig   gcc-13.2.0
arm                          ixp4xx_defconfig   gcc-13.2.0
arm                            mmp2_defconfig   gcc-13.2.0
arm                   randconfig-001-20240822   gcc-13.2.0
arm                   randconfig-002-20240822   gcc-13.2.0
arm                   randconfig-003-20240822   gcc-13.2.0
arm                   randconfig-004-20240822   gcc-13.2.0
arm                        shmobile_defconfig   gcc-13.2.0
arm64                            allmodconfig   clang-20
arm64                            allmodconfig   gcc-13.2.0
arm64                             allnoconfig   gcc-13.2.0
arm64                             allnoconfig   gcc-14.1.0
arm64                               defconfig   gcc-13.2.0
arm64                 randconfig-001-20240822   gcc-13.2.0
arm64                 randconfig-002-20240822   gcc-13.2.0
arm64                 randconfig-003-20240822   gcc-13.2.0
arm64                 randconfig-004-20240822   gcc-13.2.0
csky                              allnoconfig   gcc-13.2.0
csky                              allnoconfig   gcc-14.1.0
csky                                defconfig   gcc-13.2.0
csky                  randconfig-001-20240822   gcc-13.2.0
csky                  randconfig-002-20240822   gcc-13.2.0
hexagon                          allmodconfig   clang-20
hexagon                           allnoconfig   clang-20
hexagon                          allyesconfig   clang-20
i386                             allmodconfig   clang-18
i386                             allmodconfig   gcc-12
i386                              allnoconfig   clang-18
i386                              allnoconfig   gcc-12
i386                             allyesconfig   clang-18
i386                             allyesconfig   gcc-12
i386         buildonly-randconfig-001-20240822   gcc-12
i386         buildonly-randconfig-002-20240822   gcc-12
i386         buildonly-randconfig-003-20240822   clang-18
i386         buildonly-randconfig-003-20240822   gcc-12
i386         buildonly-randconfig-004-20240822   clang-18
i386         buildonly-randconfig-004-20240822   gcc-12
i386         buildonly-randconfig-005-20240822   gcc-12
i386         buildonly-randconfig-006-20240822   gcc-12
i386                                defconfig   clang-18
i386                  randconfig-001-20240822   gcc-12
i386                  randconfig-002-20240822   gcc-12
i386                  randconfig-003-20240822   clang-18
i386                  randconfig-003-20240822   gcc-12
i386                  randconfig-004-20240822   clang-18
i386                  randconfig-004-20240822   gcc-12
i386                  randconfig-005-20240822   gcc-12
i386                  randconfig-006-20240822   clang-18
i386                  randconfig-006-20240822   gcc-12
i386                  randconfig-011-20240822   clang-18
i386                  randconfig-011-20240822   gcc-12
i386                  randconfig-012-20240822   clang-18
i386                  randconfig-012-20240822   gcc-12
i386                  randconfig-013-20240822   clang-18
i386                  randconfig-013-20240822   gcc-12
i386                  randconfig-014-20240822   gcc-12
i386                  randconfig-015-20240822   gcc-12
i386                  randconfig-016-20240822   clang-18
i386                  randconfig-016-20240822   gcc-12
loongarch                        allmodconfig   gcc-14.1.0
loongarch                         allnoconfig   gcc-13.2.0
loongarch                         allnoconfig   gcc-14.1.0
loongarch                           defconfig   gcc-13.2.0
loongarch                 loongson3_defconfig   gcc-13.2.0
loongarch             randconfig-001-20240822   gcc-13.2.0
loongarch             randconfig-002-20240822   gcc-13.2.0
m68k                             allmodconfig   gcc-14.1.0
m68k                              allnoconfig   gcc-13.2.0
m68k                              allnoconfig   gcc-14.1.0
m68k                             allyesconfig   gcc-14.1.0
m68k                                defconfig   gcc-13.2.0
m68k                            q40_defconfig   gcc-13.2.0
m68k                           virt_defconfig   gcc-13.2.0
microblaze                       allmodconfig   gcc-14.1.0
microblaze                        allnoconfig   gcc-13.2.0
microblaze                        allnoconfig   gcc-14.1.0
microblaze                       allyesconfig   gcc-14.1.0
microblaze                          defconfig   gcc-13.2.0
mips                              allnoconfig   gcc-13.2.0
mips                              allnoconfig   gcc-14.1.0
mips                    maltaup_xpa_defconfig   gcc-13.2.0
nios2                             allnoconfig   gcc-13.2.0
nios2                             allnoconfig   gcc-14.1.0
nios2                               defconfig   gcc-13.2.0
nios2                 randconfig-001-20240822   gcc-13.2.0
nios2                 randconfig-002-20240822   gcc-13.2.0
openrisc                          allnoconfig   gcc-14.1.0
openrisc                         allyesconfig   gcc-14.1.0
openrisc                            defconfig   gcc-14.1.0
parisc                           allmodconfig   gcc-14.1.0
parisc                            allnoconfig   gcc-14.1.0
parisc                           allyesconfig   gcc-14.1.0
parisc                              defconfig   gcc-14.1.0
parisc                randconfig-001-20240822   gcc-13.2.0
parisc                randconfig-002-20240822   gcc-13.2.0
parisc64                            defconfig   gcc-13.2.0
powerpc                          allmodconfig   gcc-14.1.0
powerpc                           allnoconfig   gcc-14.1.0
powerpc                          allyesconfig   gcc-14.1.0
powerpc                      bamboo_defconfig   gcc-13.2.0
powerpc                     kmeter1_defconfig   gcc-13.2.0
powerpc                 linkstation_defconfig   gcc-13.2.0
powerpc64             randconfig-001-20240822   gcc-13.2.0
powerpc64             randconfig-002-20240822   gcc-13.2.0
powerpc64             randconfig-003-20240822   gcc-13.2.0
riscv                            allmodconfig   gcc-14.1.0
riscv                             allnoconfig   gcc-14.1.0
riscv                            allyesconfig   gcc-14.1.0
riscv                               defconfig   gcc-14.1.0
riscv                 randconfig-001-20240822   gcc-13.2.0
riscv                 randconfig-002-20240822   gcc-13.2.0
s390                             allmodconfig   clang-20
s390                              allnoconfig   clang-20
s390                             allyesconfig   clang-20
s390                             allyesconfig   gcc-14.1.0
s390                                defconfig   gcc-14.1.0
s390                  randconfig-001-20240822   gcc-13.2.0
s390                  randconfig-002-20240822   gcc-13.2.0
sh                               allmodconfig   gcc-14.1.0
sh                                allnoconfig   gcc-13.2.0
sh                                allnoconfig   gcc-14.1.0
sh                               allyesconfig   gcc-14.1.0
sh                                  defconfig   gcc-14.1.0
sh                          landisk_defconfig   gcc-13.2.0
sh                    randconfig-001-20240822   gcc-13.2.0
sh                    randconfig-002-20240822   gcc-13.2.0
sh                           se7724_defconfig   gcc-13.2.0
sh                             sh03_defconfig   gcc-13.2.0
sh                   sh7770_generic_defconfig   gcc-13.2.0
sparc                            allmodconfig   gcc-14.1.0
sparc64                             defconfig   gcc-14.1.0
sparc64               randconfig-001-20240822   gcc-13.2.0
sparc64               randconfig-002-20240822   gcc-13.2.0
um                               allmodconfig   clang-20
um                               allmodconfig   gcc-13.3.0
um                                allnoconfig   clang-17
um                               allyesconfig   gcc-12
um                               allyesconfig   gcc-13.3.0
um                                  defconfig   gcc-14.1.0
um                             i386_defconfig   gcc-14.1.0
um                    randconfig-001-20240822   gcc-13.2.0
um                    randconfig-002-20240822   gcc-13.2.0
um                           x86_64_defconfig   gcc-14.1.0
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240822   gcc-12
x86_64       buildonly-randconfig-002-20240822   gcc-12
x86_64       buildonly-randconfig-003-20240822   gcc-12
x86_64       buildonly-randconfig-004-20240822   gcc-12
x86_64       buildonly-randconfig-005-20240822   gcc-12
x86_64       buildonly-randconfig-006-20240822   gcc-12
x86_64                              defconfig   clang-18
x86_64                              defconfig   gcc-11
x86_64                randconfig-001-20240822   gcc-12
x86_64                randconfig-002-20240822   gcc-12
x86_64                randconfig-003-20240822   gcc-12
x86_64                randconfig-004-20240822   gcc-12
x86_64                randconfig-005-20240822   gcc-12
x86_64                randconfig-006-20240822   gcc-12
x86_64                randconfig-011-20240822   gcc-12
x86_64                randconfig-012-20240822   gcc-12
x86_64                randconfig-013-20240822   gcc-12
x86_64                randconfig-014-20240822   gcc-12
x86_64                randconfig-015-20240822   gcc-12
x86_64                randconfig-016-20240822   gcc-12
x86_64                randconfig-071-20240822   gcc-12
x86_64                randconfig-072-20240822   gcc-12
x86_64                randconfig-073-20240822   gcc-12
x86_64                randconfig-074-20240822   gcc-12
x86_64                randconfig-075-20240822   gcc-12
x86_64                randconfig-076-20240822   gcc-12
x86_64                          rhel-8.3-rust   clang-18
xtensa                            allnoconfig   gcc-13.2.0
xtensa                            allnoconfig   gcc-14.1.0
xtensa                randconfig-001-20240822   gcc-13.2.0
xtensa                randconfig-002-20240822   gcc-13.2.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
