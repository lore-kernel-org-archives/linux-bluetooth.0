Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4122053E36
	for <linux-bluetooth@vger.kernel.org>; Tue, 21 May 2024 08:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716280109; cv=none; b=oyie1afqQSDVaCAJNzeww1wzQWUCvbQ9vkst5pgWhj16Yl7Snks8te93wMW25kL60VbJMpDbLL5o0KRrY2FbggYYsn8DcBrOgFOlGl3FamITsPmddHWOYutySd9lmB7l+PNSxulQSw1cIKb0F+Ork5XLp09N6A5D1kq6gZj9Aw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716280109; c=relaxed/simple;
	bh=dTRHCteFjKEyO5HZ52VZkD3n2jM9B3KUviKIc4yZlbg=;
	h=Date:From:To:Cc:Subject:Message-ID; b=HnmaSTYFFvBTTuM5770pGtVONTndeUFh4ONwEAUgj8LsJDI+/Dqi6Mhz2ne+DhIookYbVxTR096ENie/VPWM1flQAeUJRWyxX1GH+QG8r0KghTW07NUegabtNFL9ffkJ5NRtnCqqUD03pOezHTbMgT65w3OkXG3dd3r4da70f44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m9UbW5Gw; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m9UbW5Gw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716280107; x=1747816107;
  h=date:from:to:cc:subject:message-id;
  bh=dTRHCteFjKEyO5HZ52VZkD3n2jM9B3KUviKIc4yZlbg=;
  b=m9UbW5GwWhvHKiPsZSBljMXgwAr526r029MyChiBk7LZ3wUGuI5NYgzy
   LaZdehukkIT40oie8b6wT29LGaI/C0n2A4pzUKHUgsnFFnEtjCWMTvR/w
   YNSx6RJGyZ7WUnCctkO5fpCaw9dYi5V8R3XcwVhkpd8HvIpiOhHcfMXfi
   CIz8UVi1OwwGS4DQBzsqMSDRzFi+M+T5m7y1XZ8bQpk1Ah0if7kHpqexS
   +jQP+s+4GViQl9o5xNPShatCqKidKdxsYVjl9FThA4kC2PSS7/W8INvrX
   2Y0jdhOrIDsZx1wSaVXLuGPEkRsYSw9bIkaUaE/ocTh1cTky8KhuUO+ky
   Q==;
X-CSE-ConnectionGUID: nIfje5mvRxCCDK1CRGowSg==
X-CSE-MsgGUID: FXI9cuHdTJ+3yvg9YmrHkQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11078"; a="12571321"
X-IronPort-AV: E=Sophos;i="6.08,177,1712646000"; 
   d="scan'208";a="12571321"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2024 01:28:26 -0700
X-CSE-ConnectionGUID: 8dCqUgynTNCo07rKWRZo0g==
X-CSE-MsgGUID: 4qEuZGSRQl+pXoHC88NPqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,177,1712646000"; 
   d="scan'208";a="70242583"
Received: from unknown (HELO 108735ec233b) ([10.239.97.151])
  by orviesa001.jf.intel.com with ESMTP; 21 May 2024 01:28:25 -0700
Received: from kbuild by 108735ec233b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s9Kr9-00069S-0y;
	Tue, 21 May 2024 08:28:23 +0000
Date: Tue, 21 May 2024 16:28:02 +0800
From: kernel test robot <lkp@intel.com>
To: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 7b13a745870c1d098466fcb44e44edb550ef3338
Message-ID: <202405211600.AOllYt41-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: 7b13a745870c1d098466fcb44e44edb550ef3338  tty: rfcomm: prefer array indexing over pointer arithmetic

elapsed time: 720m

configs tested: 139
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
arc                   randconfig-001-20240521   gcc  
arc                   randconfig-002-20240521   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                   randconfig-001-20240521   gcc  
arm                   randconfig-002-20240521   gcc  
arm                   randconfig-003-20240521   clang
arm                   randconfig-004-20240521   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240521   clang
arm64                 randconfig-002-20240521   gcc  
arm64                 randconfig-003-20240521   clang
arm64                 randconfig-004-20240521   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240521   gcc  
csky                  randconfig-002-20240521   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240521   clang
hexagon               randconfig-002-20240521   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240521   clang
i386         buildonly-randconfig-002-20240521   clang
i386         buildonly-randconfig-003-20240521   gcc  
i386         buildonly-randconfig-004-20240521   clang
i386         buildonly-randconfig-005-20240521   gcc  
i386         buildonly-randconfig-006-20240521   gcc  
i386                                defconfig   clang
i386                  randconfig-001-20240521   gcc  
i386                  randconfig-002-20240521   clang
i386                  randconfig-003-20240521   gcc  
i386                  randconfig-004-20240521   gcc  
i386                  randconfig-005-20240521   gcc  
i386                  randconfig-006-20240521   clang
i386                  randconfig-011-20240521   gcc  
i386                  randconfig-012-20240521   clang
i386                  randconfig-013-20240521   clang
i386                  randconfig-014-20240521   clang
i386                  randconfig-015-20240521   clang
i386                  randconfig-016-20240521   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240521   gcc  
loongarch             randconfig-002-20240521   gcc  
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
nios2                 randconfig-001-20240521   gcc  
nios2                 randconfig-002-20240521   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240521   gcc  
parisc                randconfig-002-20240521   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc               randconfig-001-20240521   clang
powerpc               randconfig-002-20240521   gcc  
powerpc               randconfig-003-20240521   clang
powerpc64             randconfig-001-20240521   clang
powerpc64             randconfig-002-20240521   gcc  
powerpc64             randconfig-003-20240521   gcc  
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240521   clang
riscv                 randconfig-002-20240521   clang
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240521   clang
s390                  randconfig-002-20240521   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                    randconfig-001-20240521   gcc  
sh                    randconfig-002-20240521   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240521   gcc  
sparc64               randconfig-002-20240521   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240521   gcc  
um                    randconfig-002-20240521   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64                              defconfig   gcc  
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                randconfig-001-20240521   gcc  
xtensa                randconfig-002-20240521   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
