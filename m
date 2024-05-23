Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F6903CF51
	for <linux-bluetooth@vger.kernel.org>; Thu, 23 May 2024 07:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716449075; cv=none; b=hguVQ7xPApZIzf5QbqyJwqj6Q/2Mkz/eaqm5nwqIXKkYyvGcHN8ScKNluwlQgQg045w3ntygtT0GYMT4PTvUkfd8E8R7K40oDGFlBK/QCuMwdxIpcuV0zGplNol7GSgR5gFupE3fsPc6jUsF8vrvU7T7dJbjEPObIU4EqSftAyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716449075; c=relaxed/simple;
	bh=zH3n4bh8igPv+N270rSmkvHFZlySnYAeuZApeN+akj4=;
	h=Date:From:To:Cc:Subject:Message-ID; b=ecsCBFLt5um/1FVXoh27jR88pchDh4hY8jX05Cb3TLfTaaGWwM8S4dC8YXDA09PH2RO8Fp2hhnhV4z5zhDI8JK3pLvGhPK0n0OITL3mnEQa+4CZ0LcKQd0McN2/e50aeBIisMlVRM7DXB5ZR4J8s4USgXtO2W4gpjIePLUGAOYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=do3ugYCO; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="do3ugYCO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716449073; x=1747985073;
  h=date:from:to:cc:subject:message-id;
  bh=zH3n4bh8igPv+N270rSmkvHFZlySnYAeuZApeN+akj4=;
  b=do3ugYCOSHEj1RWHWu+LAvaV6kDSdE0dQv/5U59+FWYLE8Z7iS56hXlK
   R1GQDwYEM8Ro6A9A+KfO8VGHVAvVW+AIAHelVIYubmPPhnsYTeba4LMGY
   KqnYslTUp2Nz7LGqm/OFika/JzDESt+Q+Yv3CbrKm/HYYtZxilp2d8ZEt
   tEeMLMVWph/R91QD37isA0IAapOM/LatnyaPF2mCzjgFMX+3rjFC9nU6w
   yQaRo9dCd6/nMml/uNjC3BClUQe3j++kgaHiMnCRZIg12WFK9jMmrNmbR
   V4iO5lJv4dbfjT2xxRYMc+4zJoZYc4YU9qUJriRjo993mnS8jbT7YhYcd
   Q==;
X-CSE-ConnectionGUID: avoYCy29R4i7LwCnDojfFw==
X-CSE-MsgGUID: pUAMLYg3SVuOiO4Qi+LeGA==
X-IronPort-AV: E=McAfee;i="6600,9927,11080"; a="35256579"
X-IronPort-AV: E=Sophos;i="6.08,181,1712646000"; 
   d="scan'208";a="35256579"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2024 00:24:32 -0700
X-CSE-ConnectionGUID: 20zKiNstQD2Hko7jxvPhhw==
X-CSE-MsgGUID: U6GWNb/lTuqL0KJDLZouRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,181,1712646000"; 
   d="scan'208";a="38047097"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by fmviesa003.fm.intel.com with ESMTP; 23 May 2024 00:24:25 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sA2oJ-0002Za-1z;
	Thu, 23 May 2024 07:24:23 +0000
Date: Thu, 23 May 2024 15:22:25 +0800
From: kernel test robot <lkp@intel.com>
To: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 a3975db95fcd8e304f1ee4b0be1895038942a8ef
Message-ID: <202405231523.PNfZhDfp-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: a3975db95fcd8e304f1ee4b0be1895038942a8ef  Bluetooth: L2CAP: Fix rejecting L2CAP_CONN_PARAM_UPDATE_REQ

elapsed time: 944m

configs tested: 101
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
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240523   clang
i386         buildonly-randconfig-002-20240523   gcc  
i386         buildonly-randconfig-003-20240523   clang
i386         buildonly-randconfig-004-20240523   clang
i386         buildonly-randconfig-005-20240523   clang
i386         buildonly-randconfig-006-20240523   gcc  
i386                                defconfig   clang
i386                  randconfig-001-20240523   gcc  
i386                  randconfig-002-20240523   clang
i386                  randconfig-003-20240523   clang
i386                  randconfig-004-20240523   clang
i386                  randconfig-005-20240523   gcc  
i386                  randconfig-006-20240523   clang
i386                  randconfig-011-20240523   gcc  
i386                  randconfig-012-20240523   clang
i386                  randconfig-013-20240523   clang
i386                  randconfig-014-20240523   gcc  
i386                  randconfig-015-20240523   gcc  
i386                  randconfig-016-20240523   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
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
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64                              defconfig   gcc  
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
