Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E3828563E
	for <linux-bluetooth@vger.kernel.org>; Fri, 24 May 2024 12:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716552796; cv=none; b=EYW1uspaj04S1+d8FpzQLUhYKDuSpKuq7IphdBYfXvBFvjqlps8uObK/PpLbADrJFlTUrU/8apCIGXhi3lepnkcpMof9UgJVjiREZ5KF8wAE5j8jQIde0JC9yRlNGtvXTXNxauIunNKOb8xe/gL4XdOJiD2bUiCL4YiIJ9j+zYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716552796; c=relaxed/simple;
	bh=EKB+Xjwv4FAOIrHVAODcsBRFzVCZfNgLla5soorTcPI=;
	h=Date:From:To:Cc:Subject:Message-ID; b=S3jDiJk6GXztbTFesIDYcVQmt/FOrFCIBgWegBcs4pc0i1jvqPVT8FQPRWd7m6lCxwgKB879qy1ts2gXIwi28RPJCLD2FcEkbiDcqDsRVQl3NHVukbozndegwzOQGfAzT73LXAUYFK0G1oBmYwmezRVztXastEdV2WuvAeYKGqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a1Zjfjww; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a1Zjfjww"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716552794; x=1748088794;
  h=date:from:to:cc:subject:message-id;
  bh=EKB+Xjwv4FAOIrHVAODcsBRFzVCZfNgLla5soorTcPI=;
  b=a1ZjfjwwQaLr9VLfwkWXavq7Fc2rJSt8cj8vakl/aInNxa86+t2aFpMy
   /e7BPP8Lum7OKuM/oEceVPWyw1OwYYMAy8eHKuSV4DV2Usjo/oTXuNziY
   zybbk3SRAHpbQKepFBMKDxnCa1cDlbIMTg6Px0rW9eB+zCnan7kQGCBYC
   dNBQqgqRvCyZdkuM0srVuWLFCLfsKEpiw37l0FDIihWjvePJS33RxS/IR
   v2rDKvwe8HpZa1C/xzrF4E99kfLpAYbtVAvpXSpkuqoqcUAnn0VDZWcvC
   Y6UUPaB+gI2PJ+A32/LNJHPoTeCdci5XVPbXYJ0dRWIBELi+UlWMqfeWQ
   A==;
X-CSE-ConnectionGUID: idHZ5fUtRhGrPG5a4tTvHQ==
X-CSE-MsgGUID: mjx4EM6vRIiA+UPYt8rugg==
X-IronPort-AV: E=McAfee;i="6600,9927,11081"; a="16716728"
X-IronPort-AV: E=Sophos;i="6.08,185,1712646000"; 
   d="scan'208";a="16716728"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2024 05:13:14 -0700
X-CSE-ConnectionGUID: s3NOKpfjRWC3DUQuT0OUXg==
X-CSE-MsgGUID: 78N1E0nVQAmLezIGZSNjGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,185,1712646000"; 
   d="scan'208";a="34109287"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by orviesa009.jf.intel.com with ESMTP; 24 May 2024 05:13:13 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sATnK-0005M7-0F;
	Fri, 24 May 2024 12:13:10 +0000
Date: Fri, 24 May 2024 20:12:19 +0800
From: kernel test robot <lkp@intel.com>
To: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 04e83604f5857d1762f8c04e9d0fbd0b11839a89
Message-ID: <202405242017.2uNoG7U0-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: 04e83604f5857d1762f8c04e9d0fbd0b11839a89  Bluetooth/nokia: Remove unused struct 'hci_nokia_radio_hdr'

elapsed time: 1137m

configs tested: 123
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
arc                   randconfig-001-20240524   gcc  
arc                   randconfig-002-20240524   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                   randconfig-001-20240524   clang
arm                   randconfig-002-20240524   gcc  
arm                   randconfig-003-20240524   gcc  
arm                   randconfig-004-20240524   clang
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240524   clang
arm64                 randconfig-002-20240524   clang
arm64                 randconfig-003-20240524   gcc  
arm64                 randconfig-004-20240524   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240524   gcc  
csky                  randconfig-002-20240524   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240524   clang
hexagon               randconfig-002-20240524   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240524   clang
i386         buildonly-randconfig-002-20240524   clang
i386         buildonly-randconfig-003-20240524   gcc  
i386         buildonly-randconfig-004-20240524   clang
i386         buildonly-randconfig-005-20240524   clang
i386         buildonly-randconfig-006-20240524   clang
i386                                defconfig   clang
i386                  randconfig-001-20240524   clang
i386                  randconfig-002-20240524   clang
i386                  randconfig-003-20240524   clang
i386                  randconfig-004-20240524   clang
i386                  randconfig-005-20240524   gcc  
i386                  randconfig-006-20240524   clang
i386                  randconfig-011-20240524   clang
i386                  randconfig-012-20240524   gcc  
i386                  randconfig-013-20240524   gcc  
i386                  randconfig-014-20240524   clang
i386                  randconfig-015-20240524   clang
i386                  randconfig-016-20240524   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240524   gcc  
loongarch             randconfig-002-20240524   gcc  
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
nios2                 randconfig-001-20240524   gcc  
nios2                 randconfig-002-20240524   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240524   gcc  
parisc                randconfig-002-20240524   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc               randconfig-001-20240524   gcc  
powerpc               randconfig-002-20240524   gcc  
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
