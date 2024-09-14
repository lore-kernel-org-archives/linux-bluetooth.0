Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F551FB4
	for <linux-bluetooth@vger.kernel.org>; Sat, 14 Sep 2024 01:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726278998; cv=none; b=SVoVJoVW4mawf3P57yUqfOgN/dsU80jaHhMBij6gvJfksBWUzCKDV5sDKg6aSd33qhWCuZzWEtTWErR0/2uJ1r+1kFoOmREMyhughQAq6ahO9hWqVIcECN54zAJFIoavAjPqvge5qEqlW0c5AZE/1nRukC4ERbKDVExwUCK4Mfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726278998; c=relaxed/simple;
	bh=/rFm5sDSrD72FIUqjXPE1PAWEBKKuhXLuH41JqbV9nY=;
	h=Date:From:To:Cc:Subject:Message-ID; b=LWxRN+HPTOqfXL3HwfAK8hB8GEL4LMJILEOkbf7s6o8ZtoXLepbdiIOkuEvGtQJXzgbvZe0ow7oUK7QglPcZ5Tjzo/D0exSaft6xTtZgzmP/b5qwZ6RMf3J/kRM+6syLJS5STuIUgYwHTgTy098fq9No0Af1c8y2k9gBTqaq+bI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JnucGcA9; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JnucGcA9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726278997; x=1757814997;
  h=date:from:to:cc:subject:message-id;
  bh=/rFm5sDSrD72FIUqjXPE1PAWEBKKuhXLuH41JqbV9nY=;
  b=JnucGcA9zJhjhU05GbGzSIdASRAX52rRUXX+E0jg810BryXwzDD5FnpE
   BOWv7TNiwqpYUIQhR9ISiPrtKLt9M81Pyz/mEyEgtlhzJYUgZ1Sx1ILVO
   CJ4tTbn5a4DnxFgJVmJ+ejEDUdw5QHq7HIPQd6PPCxeMsU4XhsEACTDeX
   AVjFwLoAR/Sm1fIt97UslLPWVV6CxiYMcxYQhzSpPrfB3dFxQ17DXcXhA
   8ggh0S0a+n65DuXBiX/iWPsXKXwhrPW11wmAeiD/8/nLydlyMyYalmLgt
   eQ441N/1g57g/1/WVqJOTIWgZH1HyTc+cvcn+QJh+Tw7l23VXQQTe44Kg
   Q==;
X-CSE-ConnectionGUID: Vwt6B9nLQOaaIEkn/YVTbA==
X-CSE-MsgGUID: wBwmEb08R/izs3GQpDX5RA==
X-IronPort-AV: E=McAfee;i="6700,10204,11194"; a="35866890"
X-IronPort-AV: E=Sophos;i="6.10,227,1719903600"; 
   d="scan'208";a="35866890"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2024 18:56:36 -0700
X-CSE-ConnectionGUID: HwvwrzwyT/KJbFOukAdCMg==
X-CSE-MsgGUID: bgE5hmttRdiEfjd8bEcPtw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,227,1719903600"; 
   d="scan'208";a="105716095"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 13 Sep 2024 18:56:35 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1spI1Y-0007F4-2i;
	Sat, 14 Sep 2024 01:56:32 +0000
Date: Sat, 14 Sep 2024 09:55:46 +0800
From: kernel test robot <lkp@intel.com>
To: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 7ffaa200251871980af12e57649ad57c70bf0f43
Message-ID: <202409140939.tssu9GcW-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: 7ffaa200251871980af12e57649ad57c70bf0f43  Bluetooth: btintel_pcie: Allocate memory for driver private data

elapsed time: 1647m

configs tested: 98
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-13.3.0
arc                               allnoconfig    gcc-13.2.0
arc                   randconfig-001-20240914    gcc-13.2.0
arc                   randconfig-002-20240914    gcc-13.2.0
arm                               allnoconfig    clang-20
arm                   randconfig-001-20240914    gcc-14.1.0
arm                   randconfig-002-20240914    gcc-14.1.0
arm                   randconfig-003-20240914    gcc-14.1.0
arm                   randconfig-004-20240914    clang-20
arm64                             allnoconfig    gcc-14.1.0
arm64                 randconfig-001-20240914    gcc-14.1.0
arm64                 randconfig-002-20240914    gcc-14.1.0
arm64                 randconfig-003-20240914    clang-20
arm64                 randconfig-004-20240914    gcc-14.1.0
csky                              allnoconfig    gcc-14.1.0
csky                  randconfig-001-20240914    gcc-14.1.0
csky                  randconfig-002-20240914    gcc-14.1.0
hexagon                           allnoconfig    clang-20
hexagon               randconfig-001-20240914    clang-20
hexagon               randconfig-002-20240914    clang-17
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20240914    gcc-12
i386        buildonly-randconfig-002-20240914    clang-18
i386        buildonly-randconfig-003-20240914    gcc-12
i386        buildonly-randconfig-004-20240914    gcc-12
i386        buildonly-randconfig-005-20240914    clang-18
i386        buildonly-randconfig-006-20240914    gcc-11
i386                                defconfig    clang-18
i386                  randconfig-001-20240914    gcc-12
i386                  randconfig-002-20240914    clang-18
i386                  randconfig-003-20240914    gcc-12
i386                  randconfig-004-20240914    gcc-12
i386                  randconfig-005-20240914    clang-18
i386                  randconfig-006-20240914    clang-18
i386                  randconfig-011-20240914    gcc-12
i386                  randconfig-012-20240914    gcc-12
i386                  randconfig-013-20240914    clang-18
i386                  randconfig-014-20240914    clang-18
i386                  randconfig-015-20240914    clang-18
i386                  randconfig-016-20240914    clang-18
loongarch                         allnoconfig    gcc-14.1.0
loongarch             randconfig-001-20240914    gcc-14.1.0
loongarch             randconfig-002-20240914    gcc-14.1.0
m68k                             allmodconfig    gcc-14.1.0
m68k                              allnoconfig    gcc-14.1.0
m68k                             allyesconfig    gcc-14.1.0
microblaze                       allmodconfig    gcc-14.1.0
microblaze                        allnoconfig    gcc-14.1.0
microblaze                       allyesconfig    gcc-14.1.0
mips                              allnoconfig    gcc-14.1.0
nios2                             allnoconfig    gcc-14.1.0
nios2                 randconfig-001-20240914    gcc-14.1.0
nios2                 randconfig-002-20240914    gcc-14.1.0
openrisc                          allnoconfig    gcc-14.1.0
openrisc                            defconfig    gcc-14.1.0
parisc                            allnoconfig    gcc-14.1.0
parisc                              defconfig    gcc-14.1.0
parisc                randconfig-001-20240914    gcc-14.1.0
parisc                randconfig-002-20240914    gcc-14.1.0
powerpc                           allnoconfig    gcc-14.1.0
powerpc               randconfig-001-20240914    gcc-14.1.0
powerpc64             randconfig-001-20240914    gcc-14.1.0
powerpc64             randconfig-002-20240914    gcc-14.1.0
powerpc64             randconfig-003-20240914    clang-20
riscv                             allnoconfig    gcc-14.1.0
riscv                               defconfig    clang-20
riscv                 randconfig-001-20240914    clang-14
riscv                 randconfig-002-20240914    gcc-14.1.0
s390                             allmodconfig    clang-20
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.1.0
s390                                defconfig    clang-20
s390                  randconfig-001-20240914    gcc-14.1.0
s390                  randconfig-002-20240914    gcc-14.1.0
sh                               allmodconfig    gcc-14.1.0
sh                                allnoconfig    gcc-14.1.0
sh                               allyesconfig    gcc-14.1.0
sh                                  defconfig    gcc-14.1.0
sh                    randconfig-001-20240914    gcc-14.1.0
sh                    randconfig-002-20240914    gcc-14.1.0
sparc                            allmodconfig    gcc-14.1.0
sparc64                             defconfig    gcc-14.1.0
sparc64               randconfig-001-20240914    gcc-14.1.0
sparc64               randconfig-002-20240914    gcc-14.1.0
um                                allnoconfig    clang-17
um                                  defconfig    clang-20
um                             i386_defconfig    gcc-12
um                    randconfig-001-20240914    gcc-12
um                    randconfig-002-20240914    clang-16
um                           x86_64_defconfig    clang-15
x86_64                            allnoconfig    clang-18
x86_64                           allyesconfig    clang-18
x86_64                              defconfig    gcc-11
x86_64                          rhel-8.3-rust    clang-18
xtensa                            allnoconfig    gcc-14.1.0
xtensa                randconfig-001-20240914    gcc-14.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
