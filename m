Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D73B22E2284
	for <linux-bluetooth@vger.kernel.org>; Fri, 22 Aug 2025 14:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755872045; cv=none; b=pXlQgqt5cFeeC5qdbqTl3yNOtBFbz3YMi2YjAnGK29Inm9qX1XJIimFzk2IJkmWu4EFtWA7uwB9xoi69ga/OAlEITUIipunEObC7rV9fKIM0+fG57i4pcDKJKpUtsh4HEQXv/j8Iulf+7L1zFMgNOEPePNBWFWO2tnrx+dYsQnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755872045; c=relaxed/simple;
	bh=DNC57MAp3TAbuF/ww0pHivxZuT/zaie9f4kiTzYTIXc=;
	h=Date:From:To:Cc:Subject:Message-ID; b=ZtOIu6UXO+B5cEPOoYWkxSvE6enOV7Q+RzKZKPLqY1KoMVilkTTc7vNTtbo/ot+RDhV/u6TqnGXnw1NovrdmbMPuf9OUXHEULtjdOlDaUbqQ9Jh5mAXRQesZpALZ+vvIc7tIlnAci5cn78ZyRTjwLv15eflzY3wsfnHmywOZ8Zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KKgMAMVP; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KKgMAMVP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755872044; x=1787408044;
  h=date:from:to:cc:subject:message-id;
  bh=DNC57MAp3TAbuF/ww0pHivxZuT/zaie9f4kiTzYTIXc=;
  b=KKgMAMVP8ruZm74ZUsXQK/82fthztWAjTWlQva3a/cUz73voH3sXly2C
   nchg2pYp4fy7Jn6dNQfDPvAt7psdTw8+41ueuPsAY1TQYZqAPxlIBpI8b
   OI/jzKMKiuYP6Ua4f6yNdQ4OJ0QzNqlSxMcd/0+c3CH8SrqivwnogzJyr
   /iGIs196XdIpnKI+hslOiuXqSkSBYTMYcYk3EoQkg/LV87mASbWiz18xV
   qC0e9L2k50ZZzyKvq7QayLxfrVzwm/A0X4EhKgEJxmFzOdo0f0MVZ+MMv
   H2uQi/CbqW9RL1nYEq8yYt/eTCOlT9ByAhJFC8hpVKfSMSZmzGNgc9lk/
   w==;
X-CSE-ConnectionGUID: 8jjAIbl/Twu7YQfOZ8bYPA==
X-CSE-MsgGUID: G/fuegfFQQiyHZrI4aPcEQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11529"; a="61993330"
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="61993330"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2025 07:14:02 -0700
X-CSE-ConnectionGUID: Q+CwvI1GRD+YLmwz6mSgUA==
X-CSE-MsgGUID: fwIkaBF/TM6BZ2x6Gf7GMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="168617407"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by fmviesa006.fm.intel.com with ESMTP; 22 Aug 2025 07:14:01 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1upSVJ-000LO3-2Y;
	Fri, 22 Aug 2025 14:12:49 +0000
Date: Fri, 22 Aug 2025 22:09:59 +0800
From: kernel test robot <lkp@intel.com>
To: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 832f2b9e58e24a336d0a0398c726393222a6986b
Message-ID: <202508222253.2wxxHDHK-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: 832f2b9e58e24a336d0a0398c726393222a6986b  Bluetooth: MGMT: Fix not exposing debug UUID on MGMT_OP_READ_EXP_FEATURES_INFO

elapsed time: 1450m

configs tested: 123
configs skipped: 7

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    gcc-15.1.0
arc                   randconfig-001-20250821    gcc-9.5.0
arc                   randconfig-002-20250821    gcc-13.4.0
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    gcc-15.1.0
arm                         mv78xx0_defconfig    clang-19
arm                   randconfig-001-20250821    gcc-13.4.0
arm                   randconfig-002-20250821    clang-22
arm                   randconfig-003-20250821    clang-22
arm                   randconfig-004-20250821    clang-22
arm                          sp7021_defconfig    gcc-15.1.0
arm                       versatile_defconfig    gcc-15.1.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20250821    clang-22
arm64                 randconfig-002-20250821    clang-22
arm64                 randconfig-003-20250821    gcc-11.5.0
arm64                 randconfig-004-20250821    gcc-13.4.0
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20250821    gcc-13.4.0
csky                  randconfig-002-20250821    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-22
hexagon               randconfig-001-20250821    clang-20
hexagon               randconfig-002-20250821    clang-22
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250821    gcc-12
i386        buildonly-randconfig-002-20250821    gcc-12
i386        buildonly-randconfig-003-20250821    clang-20
i386        buildonly-randconfig-004-20250821    gcc-12
i386        buildonly-randconfig-005-20250821    gcc-12
i386        buildonly-randconfig-006-20250821    clang-20
i386                                defconfig    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch             randconfig-001-20250821    gcc-14.3.0
loongarch             randconfig-002-20250821    gcc-15.1.0
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                        qi_lb60_defconfig    clang-22
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20250821    gcc-9.5.0
nios2                 randconfig-002-20250821    gcc-10.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250821    gcc-12.5.0
parisc                randconfig-002-20250821    gcc-8.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-22
powerpc                   currituck_defconfig    clang-22
powerpc                        icon_defconfig    gcc-15.1.0
powerpc               randconfig-001-20250821    clang-17
powerpc               randconfig-002-20250821    clang-22
powerpc               randconfig-003-20250821    gcc-9.5.0
powerpc64             randconfig-002-20250821    clang-22
powerpc64             randconfig-003-20250821    clang-22
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-22
riscv                 randconfig-001-20250822    gcc-8.5.0
riscv                 randconfig-002-20250822    clang-22
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    clang-22
s390                  randconfig-001-20250822    clang-22
s390                  randconfig-002-20250822    clang-22
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                    randconfig-001-20250822    gcc-12.5.0
sh                    randconfig-002-20250822    gcc-15.1.0
sh                  sh7785lcr_32bit_defconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250822    gcc-15.1.0
sparc                 randconfig-002-20250822    gcc-8.5.0
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20250822    gcc-8.5.0
sparc64               randconfig-002-20250822    gcc-8.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-12
um                                  defconfig    clang-22
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250822    gcc-12
um                    randconfig-002-20250822    gcc-12
um                           x86_64_defconfig    clang-22
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250821    clang-20
x86_64      buildonly-randconfig-002-20250821    clang-20
x86_64      buildonly-randconfig-003-20250821    clang-20
x86_64      buildonly-randconfig-004-20250821    gcc-12
x86_64      buildonly-randconfig-005-20250821    clang-20
x86_64      buildonly-randconfig-006-20250821    clang-20
x86_64                              defconfig    gcc-11
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-002-20250822    gcc-13.4.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
