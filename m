Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB5B07353F
	for <linux-bluetooth@vger.kernel.org>; Wed, 28 Feb 2024 12:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709122495; cv=none; b=Yjz9PECHV135Akg1Z8NEQX+E+ZGzXTjqlCjqcmrM8vvMSKdonEmpZ3XBjOY6ZXOAmqjaKyY/8bcawZWnJLAa7arYm7E7dN/bTy59z051OL6PQdY+T1uIt8Llox5/2cbbnCZ6wVjuDAiZY38HeY3oBPwvfQBUbxjI+WOFKHxDMYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709122495; c=relaxed/simple;
	bh=A6KE+COO3KSZERQ5AxuYKTrsYVLAb8IWECPsuiUqBKE=;
	h=Date:From:To:Cc:Subject:Message-ID; b=F74vDyCytmpO3ZlCCoXgipe+BAU1aC5TqxYI2pDeQuyvieNsF6JEFAYvcJ3m7EQ+rI4HvN7TVV0yqiNxCo9gHgYIDYYIWP5dd4DppFWqMHe+aI2XGyWGH9NijW3kcpmrmGdjC2OPEJpDPvhKdcCVPmQ9H5LszVAxJXjpc57W7eU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jvEpweSN; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jvEpweSN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709122493; x=1740658493;
  h=date:from:to:cc:subject:message-id;
  bh=A6KE+COO3KSZERQ5AxuYKTrsYVLAb8IWECPsuiUqBKE=;
  b=jvEpweSNnz0bft8OuaT4sGJqEgTmgA5RLnuT3cSrwHe4pH29Uwb4lwcM
   vCaDf4U2qNXD2BviRze67P9MnzO4yV7GRhyTxnMmbAMvCmuAC2FyJqKTf
   n0C1S6h8oo4hll3UKZh3QrMS6ALAS6mKC7D+1uIDrWFegOHSxJ0N5AtBk
   VwPsnIdCwAB3qddClHwUwdmRAYa1QfI2xutOxJESalQy/i/ndzguJ0r4c
   fPB0T+nvVRv+3C3C/6QoilgRrI8Vu6YNBRn5V+uf8stY5yaQGr3IF24PE
   PHtF6nOGjmLMthK+ZWRC3DzuPophU8v9Yt38O77iCLSwfUVyYKgXEVn/9
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="3382313"
X-IronPort-AV: E=Sophos;i="6.06,190,1705392000"; 
   d="scan'208";a="3382313"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 04:14:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,190,1705392000"; 
   d="scan'208";a="12026417"
Received: from lkp-server02.sh.intel.com (HELO 3c78fa4d504c) ([10.239.97.151])
  by fmviesa004.fm.intel.com with ESMTP; 28 Feb 2024 04:14:51 -0800
Received: from kbuild by 3c78fa4d504c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rfIpk-000C2X-2Q;
	Wed, 28 Feb 2024 12:14:48 +0000
Date: Wed, 28 Feb 2024 20:14:34 +0800
From: kernel test robot <lkp@intel.com>
To: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 715b938b3a0fe772d52fc810402e0c91e1adca4d
Message-ID: <202402282031.VAPdwwzg-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: 715b938b3a0fe772d52fc810402e0c91e1adca4d  Bluetooth: hci_sync: Use QoS to determine which PHY to scan

elapsed time: 1160m

configs tested: 163
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
arc                   randconfig-001-20240228   gcc  
arc                   randconfig-002-20240228   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                   randconfig-001-20240228   clang
arm                   randconfig-002-20240228   clang
arm                   randconfig-003-20240228   clang
arm                   randconfig-004-20240228   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240228   clang
arm64                 randconfig-002-20240228   gcc  
arm64                 randconfig-003-20240228   gcc  
arm64                 randconfig-004-20240228   clang
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240228   gcc  
csky                  randconfig-002-20240228   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240228   clang
hexagon               randconfig-002-20240228   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240228   clang
i386         buildonly-randconfig-002-20240228   clang
i386         buildonly-randconfig-003-20240228   clang
i386         buildonly-randconfig-004-20240228   clang
i386         buildonly-randconfig-005-20240228   gcc  
i386         buildonly-randconfig-006-20240228   clang
i386                                defconfig   clang
i386                  randconfig-001-20240228   clang
i386                  randconfig-002-20240228   clang
i386                  randconfig-003-20240228   gcc  
i386                  randconfig-004-20240228   clang
i386                  randconfig-005-20240228   clang
i386                  randconfig-006-20240228   gcc  
i386                  randconfig-011-20240228   clang
i386                  randconfig-012-20240228   clang
i386                  randconfig-013-20240228   gcc  
i386                  randconfig-014-20240228   gcc  
i386                  randconfig-015-20240228   gcc  
i386                  randconfig-016-20240228   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240228   gcc  
loongarch             randconfig-002-20240228   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240228   gcc  
nios2                 randconfig-002-20240228   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240228   gcc  
parisc                randconfig-002-20240228   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc               randconfig-001-20240228   clang
powerpc               randconfig-002-20240228   clang
powerpc               randconfig-003-20240228   gcc  
powerpc64             randconfig-001-20240228   clang
powerpc64             randconfig-002-20240228   clang
powerpc64             randconfig-003-20240228   gcc  
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240228   clang
riscv                 randconfig-002-20240228   clang
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240228   clang
s390                  randconfig-002-20240228   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                    randconfig-001-20240228   gcc  
sh                    randconfig-002-20240228   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240228   gcc  
sparc64               randconfig-002-20240228   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240228   clang
um                    randconfig-002-20240228   clang
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240228   gcc  
x86_64       buildonly-randconfig-002-20240228   clang
x86_64       buildonly-randconfig-003-20240228   clang
x86_64       buildonly-randconfig-004-20240228   gcc  
x86_64       buildonly-randconfig-005-20240228   gcc  
x86_64       buildonly-randconfig-006-20240228   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240228   clang
x86_64                randconfig-002-20240228   gcc  
x86_64                randconfig-003-20240228   gcc  
x86_64                randconfig-004-20240228   gcc  
x86_64                randconfig-005-20240228   gcc  
x86_64                randconfig-006-20240228   clang
x86_64                randconfig-011-20240228   clang
x86_64                randconfig-012-20240228   clang
x86_64                randconfig-013-20240228   clang
x86_64                randconfig-014-20240228   gcc  
x86_64                randconfig-015-20240228   gcc  
x86_64                randconfig-016-20240228   gcc  
x86_64                randconfig-071-20240228   gcc  
x86_64                randconfig-072-20240228   clang
x86_64                randconfig-073-20240228   gcc  
x86_64                randconfig-074-20240228   gcc  
x86_64                randconfig-075-20240228   clang
x86_64                randconfig-076-20240228   clang
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                randconfig-001-20240228   gcc  
xtensa                randconfig-002-20240228   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
