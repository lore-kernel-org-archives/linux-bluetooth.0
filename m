Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 903F615665C
	for <linux-bluetooth@vger.kernel.org>; Fri,  8 Aug 2025 04:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754626720; cv=none; b=MzRv0Opu3M50HT+0T1H6ltm0hWCeYQf9n2TWazGlg+h6UfwWmfGztbBvqodBMSnlfQQCCZgZOKHfATN456g8do8i+rHLTI8i7L0CG6Bscv9nKq5PsJW4ZwJN6L3SMFQYdcxDRE2qX0/gQv0PLtzX16dumTY9rzTXkpDYnPGry50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754626720; c=relaxed/simple;
	bh=RAASr1ohkBoknoO0LRsoQTQdApsnVaapWr/YkaXcqKI=;
	h=Date:From:To:Cc:Subject:Message-ID; b=eYMN4aQun8Jl2DBXpg8OzlCcbHF/DVQ1PbFvK2RTyPf6lmJjE1/VyMqvB1IP6NRtT9igKfYlwKbfka4QfLLSpT4R1dfFC9gmweJiHGsq2W9Y3d+lrllqEPZlfk+dyINK/TOFj8YWpLOAXKSRJR+5avC6bXMZtpF9h79RebN5mO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lRHEh2U4; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lRHEh2U4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754626718; x=1786162718;
  h=date:from:to:cc:subject:message-id;
  bh=RAASr1ohkBoknoO0LRsoQTQdApsnVaapWr/YkaXcqKI=;
  b=lRHEh2U4UCWjKREfleW/LmSzH4CU7PnvM84lsjGdvDp5qqObwFXjvxEJ
   irwgp9XjGlTyNXi3nYTcOcHjUQDvEDd6yq0a281EaoXcBsjvea3UpNBMu
   hJH7V2eZN2DLcLWiDVbp2W70EWRVNLHsGLu/s/h7YNes5b8VFWs5qYO/D
   U+n98L3X/7+N3NsSQz8rm33fGvgqS7z8KhCTXemOy64xyVSG/jhx++2PD
   72hNP8tWRMBHzgVodAZj4xapv1bi5l4GIBJarVLSGvSEeU+wwo+3ow1sl
   ZFVmO6dZ1/6R7aD4h8rrD71FnpYt/Ukx+wIPULTKW+nbYTdGDUte6yIaY
   g==;
X-CSE-ConnectionGUID: QidKXoAmQoaW9+K+SPxPWg==
X-CSE-MsgGUID: 9sagyNrIRcmovBJfrsuvuA==
X-IronPort-AV: E=McAfee;i="6800,10657,11514"; a="60818686"
X-IronPort-AV: E=Sophos;i="6.17,274,1747724400"; 
   d="scan'208";a="60818686"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2025 21:18:38 -0700
X-CSE-ConnectionGUID: EB3dZ925SeiuT0QGkqcg0A==
X-CSE-MsgGUID: I76gS37uR92WRqJWvQ1+6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,274,1747724400"; 
   d="scan'208";a="169445134"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by orviesa003.jf.intel.com with ESMTP; 07 Aug 2025 21:18:36 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ukEYr-0003Xi-29;
	Fri, 08 Aug 2025 04:18:33 +0000
Date: Fri, 08 Aug 2025 12:17:23 +0800
From: kernel test robot <lkp@intel.com>
To: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 3e383124ce63360852a6992b8e36d944112ab233
Message-ID: <202508081217.1IqRuvMu-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: 3e383124ce63360852a6992b8e36d944112ab233  Bluetooth: hci_sync: Prevent unintended PA sync when SID is 0xFF

elapsed time: 745m

configs tested: 120
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    gcc-15.1.0
arc                   randconfig-001-20250808    gcc-14.3.0
arc                   randconfig-002-20250808    gcc-12.5.0
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    gcc-15.1.0
arm                   randconfig-001-20250808    gcc-14.3.0
arm                   randconfig-002-20250808    gcc-10.5.0
arm                   randconfig-003-20250808    clang-22
arm                   randconfig-004-20250808    clang-22
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20250808    clang-20
arm64                 randconfig-002-20250808    gcc-10.5.0
arm64                 randconfig-003-20250808    clang-22
arm64                 randconfig-004-20250808    gcc-8.5.0
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20250808    gcc-15.1.0
csky                  randconfig-002-20250808    gcc-12.5.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-22
hexagon               randconfig-001-20250808    clang-20
hexagon               randconfig-002-20250808    clang-22
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250808    clang-20
i386        buildonly-randconfig-002-20250808    clang-20
i386        buildonly-randconfig-003-20250808    gcc-12
i386        buildonly-randconfig-004-20250808    clang-20
i386        buildonly-randconfig-005-20250808    gcc-12
i386        buildonly-randconfig-006-20250808    clang-20
i386                                defconfig    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch             randconfig-001-20250808    clang-22
loongarch             randconfig-002-20250808    gcc-15.1.0
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20250808    gcc-9.5.0
nios2                 randconfig-002-20250808    gcc-8.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250808    gcc-8.5.0
parisc                randconfig-002-20250808    gcc-13.4.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-22
powerpc               randconfig-001-20250808    clang-22
powerpc               randconfig-002-20250808    clang-18
powerpc               randconfig-003-20250808    clang-22
powerpc64             randconfig-001-20250808    clang-18
powerpc64             randconfig-002-20250808    clang-22
powerpc64             randconfig-003-20250808    clang-16
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-22
riscv                 randconfig-001-20250808    clang-22
riscv                 randconfig-002-20250808    clang-22
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    clang-22
s390                  randconfig-001-20250808    gcc-10.5.0
s390                  randconfig-002-20250808    gcc-10.5.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                    randconfig-001-20250808    gcc-13.4.0
sh                    randconfig-002-20250808    gcc-10.5.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250808    gcc-12.5.0
sparc                 randconfig-002-20250808    gcc-8.5.0
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20250808    clang-22
sparc64               randconfig-002-20250808    clang-22
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-12
um                                  defconfig    clang-22
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250808    gcc-12
um                    randconfig-002-20250808    gcc-12
um                           x86_64_defconfig    clang-22
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250808    clang-20
x86_64      buildonly-randconfig-002-20250808    gcc-12
x86_64      buildonly-randconfig-003-20250808    clang-20
x86_64      buildonly-randconfig-004-20250808    clang-20
x86_64      buildonly-randconfig-005-20250808    gcc-12
x86_64      buildonly-randconfig-006-20250808    clang-20
x86_64                              defconfig    gcc-11
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250808    gcc-9.5.0
xtensa                randconfig-002-20250808    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
