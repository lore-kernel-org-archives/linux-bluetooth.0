Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 975AA1353E4
	for <linux-bluetooth@vger.kernel.org>; Fri, 16 Feb 2024 21:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708119928; cv=none; b=Wyi9hR3MuiNX4qlpazRwZ2oRswpAd2J+gaHV1P1Y6rVekiaqLnci3YW8ZweCPoA0/u4bc2JVIg5I8/ZdBqQFwschDAlADlb/IFp61PknJIDacTcq/Oukpd+2FSj9GAc4o35BV2Nul+UqIXjsk1krmf2ZEt/fSsXBGFohTf49q2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708119928; c=relaxed/simple;
	bh=GypU9V+keVhJnVFlDli1lbO+Od5QxzkRzKfuVJA51ac=;
	h=Date:From:To:Cc:Subject:Message-ID; b=ONP4xEoNEKu2Yknbwhnk9/FYDM/GAYO/oiHJfjO9+xOJaeDfyevomONFSBYgU2jKMhCqME3nd6FUYSHqC5GidF4ZJ+C/KIKFZeT0n7+JQGTNRXdG6hnxxLGqj8wi49ZSNfCWvKbsytwUzAZIrQLVz8HQiasNCY5H0UWHRoQ76v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V6nD+w7M; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V6nD+w7M"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708119927; x=1739655927;
  h=date:from:to:cc:subject:message-id;
  bh=GypU9V+keVhJnVFlDli1lbO+Od5QxzkRzKfuVJA51ac=;
  b=V6nD+w7Mfak0higu6iQr5Iis+oQQbCfFoFJl7pkKYYkuUWNVhdIUcfWs
   FiYnu0HBFXBdzxdGHOPHp4yrQKJQhjcDfz4AnimqRoE/6KSToNYn1aORS
   xzb3i6zijfeGRG0wn/ZEg5fgrDw8Cd/tm05J5tjEz6Rnr5SWUh9z+fstv
   FNXAdqr9a/ubnezVXkTDd+ZtqE0jDUS4wUerm02A7H+fXsAa8XD9Ck2vf
   EkU2MV9kMsN8w7kY8VRPIYiQA02zf3SfWjHqwNBLnt7bt5WHB8vwIdUDB
   tE0/f7ahwWxMJjp668w1IdIvtbjezG3I80S/FunjS/jHqNVy8vup00cGZ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10986"; a="2132395"
X-IronPort-AV: E=Sophos;i="6.06,165,1705392000"; 
   d="scan'208";a="2132395"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2024 13:45:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,165,1705392000"; 
   d="scan'208";a="4109518"
Received: from lkp-server02.sh.intel.com (HELO 3c78fa4d504c) ([10.239.97.151])
  by fmviesa008.fm.intel.com with ESMTP; 16 Feb 2024 13:45:24 -0800
Received: from kbuild by 3c78fa4d504c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rb61K-0001d0-0e;
	Fri, 16 Feb 2024 21:45:22 +0000
Date: Sat, 17 Feb 2024 05:44:26 +0800
From: kernel test robot <lkp@intel.com>
To: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 96fb2aab16bf3eb2fd69477fff9e70f128b52d30
Message-ID: <202402170524.5OejgPq8-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: 96fb2aab16bf3eb2fd69477fff9e70f128b52d30  Bluetooth: hci_sync: Attempt to dequeue connection attempt

elapsed time: 1452m

configs tested: 179
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20240216   gcc  
arc                   randconfig-002-20240216   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                             pxa_defconfig   gcc  
arm                   randconfig-001-20240216   clang
arm                   randconfig-002-20240216   clang
arm                   randconfig-003-20240216   gcc  
arm                   randconfig-004-20240216   gcc  
arm                           tegra_defconfig   gcc  
arm                           u8500_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240216   clang
arm64                 randconfig-002-20240216   gcc  
arm64                 randconfig-003-20240216   clang
arm64                 randconfig-004-20240216   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240216   gcc  
csky                  randconfig-002-20240216   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240216   clang
hexagon               randconfig-002-20240216   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240216   gcc  
i386         buildonly-randconfig-002-20240216   clang
i386         buildonly-randconfig-003-20240216   clang
i386         buildonly-randconfig-004-20240216   gcc  
i386         buildonly-randconfig-005-20240216   gcc  
i386         buildonly-randconfig-006-20240216   clang
i386                                defconfig   clang
i386                  randconfig-001-20240216   clang
i386                  randconfig-002-20240216   clang
i386                  randconfig-003-20240216   gcc  
i386                  randconfig-004-20240216   clang
i386                  randconfig-005-20240216   gcc  
i386                  randconfig-006-20240216   clang
i386                  randconfig-011-20240216   gcc  
i386                  randconfig-012-20240216   gcc  
i386                  randconfig-013-20240216   gcc  
i386                  randconfig-014-20240216   clang
i386                  randconfig-015-20240216   gcc  
i386                  randconfig-016-20240216   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240216   gcc  
loongarch             randconfig-002-20240216   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                          amiga_defconfig   gcc  
m68k                                defconfig   gcc  
m68k                       m5249evb_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240216   gcc  
nios2                 randconfig-002-20240216   gcc  
openrisc                         alldefconfig   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
openrisc                    or1ksim_defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240216   gcc  
parisc                randconfig-002-20240216   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                        fsp2_defconfig   gcc  
powerpc                        icon_defconfig   gcc  
powerpc                         ps3_defconfig   gcc  
powerpc               randconfig-001-20240216   clang
powerpc               randconfig-002-20240216   clang
powerpc               randconfig-003-20240216   clang
powerpc64             randconfig-001-20240216   clang
powerpc64             randconfig-002-20240216   clang
powerpc64             randconfig-003-20240216   gcc  
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240216   gcc  
riscv                 randconfig-002-20240216   clang
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240216   gcc  
s390                  randconfig-002-20240216   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                    randconfig-001-20240216   gcc  
sh                    randconfig-002-20240216   gcc  
sh                              ul2_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240216   gcc  
sparc64               randconfig-002-20240216   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                    randconfig-001-20240216   gcc  
um                    randconfig-002-20240216   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240216   clang
x86_64       buildonly-randconfig-002-20240216   clang
x86_64       buildonly-randconfig-003-20240216   clang
x86_64       buildonly-randconfig-004-20240216   clang
x86_64       buildonly-randconfig-005-20240216   gcc  
x86_64       buildonly-randconfig-006-20240216   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240216   gcc  
x86_64                randconfig-002-20240216   clang
x86_64                randconfig-003-20240216   gcc  
x86_64                randconfig-004-20240216   gcc  
x86_64                randconfig-005-20240216   gcc  
x86_64                randconfig-006-20240216   clang
x86_64                randconfig-011-20240216   gcc  
x86_64                randconfig-012-20240216   gcc  
x86_64                randconfig-013-20240216   clang
x86_64                randconfig-014-20240216   gcc  
x86_64                randconfig-015-20240216   clang
x86_64                randconfig-016-20240216   clang
x86_64                randconfig-071-20240216   clang
x86_64                randconfig-072-20240216   clang
x86_64                randconfig-073-20240216   gcc  
x86_64                randconfig-074-20240216   gcc  
x86_64                randconfig-075-20240216   clang
x86_64                randconfig-076-20240216   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                randconfig-001-20240216   gcc  
xtensa                randconfig-002-20240216   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
