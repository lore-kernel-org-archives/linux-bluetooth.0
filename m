Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 186D417C9
	for <linux-bluetooth@vger.kernel.org>; Sun, 28 Jan 2024 02:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706410635; cv=none; b=nbCteNTzIzI8mJtUT2qtwFdvTHFBcCNuBrqltayB9FYEoQC86Dkpxgea7Mi45d/WAcHTCBgUhXGSwQmq5D/8KEq73QAGytl2/X+iliJ6foOlXOMPEsNstoxolM1MMNCuVKtqaeGYYbkF3jtlZaRKTA2IBBuv00J3OXXKA3tPShE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706410635; c=relaxed/simple;
	bh=v3AJaivW05RCkXKJBpjOighv++a/xpGSpCluBPLSKZI=;
	h=Date:From:To:Cc:Subject:Message-ID; b=t0HJ5e9r4dX6CuUn9D4edi6LXgkfSsWCgao91YRsj4GIJsai2ftxHfE7yKOcKWX5U74PYzBxgUp4AYAIm9EDGWcyeRwKhOQfXNzUC16/GwWPRPZgCG5s/0WT7Xh1h6bIhU5pOfMtJhaBH+G3JFVS/yug7QahCQ5zuQ5PaHr4Rts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=diPEZj7I; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="diPEZj7I"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706410633; x=1737946633;
  h=date:from:to:cc:subject:message-id;
  bh=v3AJaivW05RCkXKJBpjOighv++a/xpGSpCluBPLSKZI=;
  b=diPEZj7IqWM0rFbUw+9A4t3iT8VzhY8j4TFPJmz1YtC1A9rUpKMjPuAc
   wNzOlynn34n7WRHowqqTfyiTep2gKfUKkolFx3ayG56fh4EqAghajOVO+
   QFmUVK7L+4y7PyFlPnZaI/TZdQ+jSABCDxmADkYR6ecZCzAsz3HG8lNlZ
   qPed/tQhvvWQLOg8geWcYJ7pVGlZMef+Rlv9H9iEQt39KdMvxTHYsPId1
   CRM78OgCua7el3Kk89Vq10OgjMq2fK1hCo1kAC4G2NsNcSW/T2dNBECDu
   8jzRYNR//MA3apL/4BT9OAdnb2S4pwP+ixX3GcoMqGuJ4FA+GiuucIqkG
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10966"; a="2600885"
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; 
   d="scan'208";a="2600885"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2024 18:57:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; 
   d="scan'208";a="21744176"
Received: from lkp-server01.sh.intel.com (HELO 370188f8dc87) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 27 Jan 2024 18:57:10 -0800
Received: from kbuild by 370188f8dc87 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rTvM5-00030W-08;
	Sun, 28 Jan 2024 02:57:09 +0000
Date: Sun, 28 Jan 2024 10:56:09 +0800
From: kernel test robot <lkp@intel.com>
To: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 64692e12507b3efd71b4ff5596c9742d91f1ffe5
Message-ID: <202401281007.MNhPXeKB-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: 64692e12507b3efd71b4ff5596c9742d91f1ffe5  Bluetooth: qca: Fix wrong event type for patch config command

elapsed time: 3206m

configs tested: 99
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
arc                   randconfig-001-20240128   gcc  
arc                   randconfig-002-20240128   gcc  
arc                           tb10x_defconfig   gcc  
arm                   randconfig-001-20240128   clang
arm                   randconfig-002-20240128   clang
arm                   randconfig-003-20240128   clang
arm                   randconfig-004-20240128   clang
arm64                 randconfig-001-20240128   clang
arm64                 randconfig-002-20240128   clang
arm64                 randconfig-003-20240128   clang
arm64                 randconfig-004-20240128   clang
csky                  randconfig-001-20240128   gcc  
csky                  randconfig-002-20240128   gcc  
hexagon                          allmodconfig   clang
hexagon                          allyesconfig   clang
hexagon               randconfig-001-20240128   clang
hexagon               randconfig-002-20240128   clang
i386         buildonly-randconfig-001-20240127   gcc  
i386         buildonly-randconfig-002-20240127   gcc  
i386         buildonly-randconfig-003-20240127   gcc  
i386         buildonly-randconfig-004-20240127   gcc  
i386         buildonly-randconfig-005-20240127   gcc  
i386         buildonly-randconfig-006-20240127   gcc  
i386                  randconfig-001-20240127   gcc  
i386                  randconfig-002-20240127   gcc  
i386                  randconfig-003-20240127   gcc  
i386                  randconfig-004-20240127   gcc  
i386                  randconfig-005-20240127   gcc  
i386                  randconfig-006-20240127   gcc  
i386                  randconfig-011-20240127   clang
i386                  randconfig-012-20240127   clang
i386                  randconfig-013-20240127   clang
i386                  randconfig-014-20240127   clang
i386                  randconfig-015-20240127   clang
i386                  randconfig-016-20240127   clang
loongarch                        allmodconfig   gcc  
loongarch             randconfig-001-20240128   gcc  
loongarch             randconfig-002-20240128   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                       allyesconfig   gcc  
mips                             allyesconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                 randconfig-001-20240128   gcc  
nios2                 randconfig-002-20240128   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240128   gcc  
parisc                randconfig-002-20240128   gcc  
parisc64                            defconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc               randconfig-001-20240128   clang
powerpc               randconfig-002-20240128   clang
powerpc               randconfig-003-20240128   clang
powerpc64             randconfig-001-20240128   clang
powerpc64             randconfig-002-20240128   clang
powerpc64             randconfig-003-20240128   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   clang
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                 randconfig-001-20240128   clang
riscv                 randconfig-002-20240128   clang
riscv                          rv32_defconfig   clang
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20240128   gcc  
s390                  randconfig-002-20240128   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                    randconfig-001-20240128   gcc  
sh                    randconfig-002-20240128   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240128   gcc  
sparc64               randconfig-002-20240128   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                    randconfig-001-20240128   clang
um                    randconfig-002-20240128   clang
um                           x86_64_defconfig   gcc  
xtensa                            allnoconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
