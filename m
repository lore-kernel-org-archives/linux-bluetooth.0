Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 761EE19D8AC
	for <linux-bluetooth@vger.kernel.org>; Thu,  5 Jun 2025 13:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749129619; cv=none; b=XtCLFsF5Vd+VaL8vXLorCPUGK8/7x+63+sZefDX0W9ekeo2i7HvoU3LFFYpI/rtzbb7l+RL1+AT1LQhwFzf+SxSpngFJgpS+IOrScPWSUBvAm1LEPsQ5b+p+ZkTQHRYYIS0drIRPiE6pVC1UmrQWC+sGPAvb+7wzEVw0gm3IOw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749129619; c=relaxed/simple;
	bh=J55lzRbHyGIpJJBFMj8akIQ5Q73/AVxv5BloiijK6Yw=;
	h=Date:From:To:Cc:Subject:Message-ID; b=jk3jEVzydk4ODD3CqckWuu8AnKbuQQiwk+6bWOC/6x3U3lPx1DPjgGzlq+fP9oVu3ibbd3PjjwR5ZF4NBrtT7Kj4Nu2zN5UwOKM/3RbM7elgBKcy2AUMmNEY+/MRO+ZAwInDU8et959h6R64e/B+A7pQydNxcf3Bpx8m5Nl6W5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B1lqAl73; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B1lqAl73"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749129618; x=1780665618;
  h=date:from:to:cc:subject:message-id;
  bh=J55lzRbHyGIpJJBFMj8akIQ5Q73/AVxv5BloiijK6Yw=;
  b=B1lqAl73zY9j+Q/Yi7/OCQ9794wCki0sQVKhR4k0utBjhnUvvy8aCPhE
   FeMW3GbPgBQ10Yo4KgREsy/2rL5ZtGRHVn/uQuA3uIsWvEUHj+BXvGHQo
   BpB6xtKOG7Dymq659wkGS1jgoqgtgD490kqGB16sfgdw2/SAfsPwdbowT
   x4WUM9aQsgdlIvp2t1KU9vK9BKz2A0b9TbFMph3EwY1uG2TtIjlBi7OJB
   TeRjHY5UuxVG0MuGEiKPds8ib0O1hCrk5K+IGj0YjFOfLseQnnnAMUctS
   S7SJAB5vwLeOi4pIBncb+YzKEKOL8AA7puYB8RRh2LkMdNynlRYJoccsN
   A==;
X-CSE-ConnectionGUID: ePpbyi0sTgSmKypaVL7q9g==
X-CSE-MsgGUID: mjAIie7TSpuIuyGyzhnkqg==
X-IronPort-AV: E=McAfee;i="6800,10657,11455"; a="54910159"
X-IronPort-AV: E=Sophos;i="6.16,212,1744095600"; 
   d="scan'208";a="54910159"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2025 06:20:17 -0700
X-CSE-ConnectionGUID: DZCNe0csQ7C8aZxHw7nU7g==
X-CSE-MsgGUID: 1pX2A01VT8iz1I+3DIK/rg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,212,1744095600"; 
   d="scan'208";a="146017023"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 05 Jun 2025 06:20:15 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uNAVx-00047h-15;
	Thu, 05 Jun 2025 13:20:13 +0000
Date: Thu, 05 Jun 2025 21:19:12 +0800
From: kernel test robot <lkp@intel.com>
To: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 f60dca4b11df849ac5bbe6cee2b0fc74f54e1e5d
Message-ID: <202506052102.hFOuiy2F-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: f60dca4b11df849ac5bbe6cee2b0fc74f54e1e5d  Bluetooth: MGMT: Protect mgmt_pending list with its own lock

elapsed time: 1315m

configs tested: 132
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    gcc-15.1.0
arc                   randconfig-001-20250605    gcc-15.1.0
arc                   randconfig-002-20250605    gcc-15.1.0
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-21
arm                              allyesconfig    gcc-15.1.0
arm                          exynos_defconfig    clang-21
arm                          pxa910_defconfig    gcc-15.1.0
arm                             pxa_defconfig    gcc-15.1.0
arm                   randconfig-001-20250605    clang-21
arm                   randconfig-002-20250605    clang-17
arm                   randconfig-003-20250605    clang-21
arm                   randconfig-004-20250605    clang-21
arm                             rpc_defconfig    clang-18
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20250605    clang-21
arm64                 randconfig-002-20250605    clang-21
arm64                 randconfig-003-20250605    clang-21
arm64                 randconfig-004-20250605    clang-21
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20250605    gcc-10.5.0
csky                  randconfig-002-20250605    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-21
hexagon               randconfig-001-20250605    clang-21
hexagon               randconfig-002-20250605    clang-20
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250605    gcc-12
i386        buildonly-randconfig-002-20250605    clang-20
i386        buildonly-randconfig-003-20250605    gcc-12
i386        buildonly-randconfig-004-20250605    clang-20
i386        buildonly-randconfig-005-20250605    clang-20
i386        buildonly-randconfig-006-20250605    gcc-11
i386                                defconfig    clang-20
loongarch                        allmodconfig    gcc-15.1.0
loongarch                         allnoconfig    gcc-15.1.0
loongarch             randconfig-001-20250605    gcc-12.4.0
loongarch             randconfig-002-20250605    gcc-15.1.0
m68k                             alldefconfig    gcc-15.1.0
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
m68k                       bvme6000_defconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                        bcm63xx_defconfig    clang-21
nios2                         3c120_defconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250605    gcc-14.2.0
nios2                 randconfig-002-20250605    gcc-11.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250605    gcc-9.3.0
parisc                randconfig-002-20250605    gcc-11.5.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-21
powerpc                   bluestone_defconfig    clang-21
powerpc                     mpc512x_defconfig    clang-21
powerpc                 mpc8313_rdb_defconfig    gcc-15.1.0
powerpc                 mpc837x_rdb_defconfig    gcc-15.1.0
powerpc               randconfig-001-20250605    clang-21
powerpc               randconfig-002-20250605    clang-21
powerpc               randconfig-003-20250605    clang-21
powerpc64             randconfig-001-20250605    clang-18
powerpc64             randconfig-002-20250605    clang-21
powerpc64             randconfig-003-20250605    clang-21
riscv                            allmodconfig    clang-21
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-21
riscv             nommu_k210_sdcard_defconfig    gcc-15.1.0
riscv                 randconfig-001-20250605    clang-21
riscv                 randconfig-002-20250605    clang-21
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    clang-21
s390                  randconfig-001-20250605    clang-21
s390                  randconfig-002-20250605    clang-21
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                ecovec24-romimage_defconfig    gcc-15.1.0
sh                    randconfig-001-20250605    gcc-12.4.0
sh                    randconfig-002-20250605    gcc-12.4.0
sh                   sh7770_generic_defconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                 randconfig-001-20250605    gcc-11.5.0
sparc                 randconfig-002-20250605    gcc-7.5.0
sparc                       sparc64_defconfig    gcc-15.1.0
sparc64                             defconfig    gcc-15.1.0
sparc64               randconfig-001-20250605    gcc-12.4.0
sparc64               randconfig-002-20250605    gcc-15.1.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    gcc-12
um                                  defconfig    clang-21
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250605    clang-21
um                    randconfig-002-20250605    clang-21
um                           x86_64_defconfig    clang-21
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250605    clang-20
x86_64      buildonly-randconfig-002-20250605    gcc-12
x86_64      buildonly-randconfig-003-20250605    clang-20
x86_64      buildonly-randconfig-004-20250605    clang-20
x86_64      buildonly-randconfig-005-20250605    gcc-12
x86_64      buildonly-randconfig-006-20250605    clang-20
x86_64                              defconfig    gcc-11
x86_64                          rhel-9.4-rust    clang-18
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250605    gcc-7.5.0
xtensa                randconfig-002-20250605    gcc-12.4.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
