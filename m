Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A4E73C140F
	for <linux-bluetooth@vger.kernel.org>; Sat, 12 Sep 2026 07:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789197056; cv=none; b=g8behScSXDN8Bdq335SzbPKxYptdH6quCQI8WDGjMyjyBmzU5tqVl8jmo1UjTX2IUiZIkesenr4Hbx0QfVz1JB366/01w9ODgbZe5DBw81OWjph/Fg0cUwWVnjiFbsjbrqSeDQZTK/YSE9znwOCjbwcp5J8QweTtWNYezRjISl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789197056; c=relaxed/simple;
	bh=a7haC/CdroMajtTVlzxEdcLTfu/Xl/fkkTeDQoZbcLA=;
	h=Date:From:To:Cc:Subject:Message-ID; b=V5V8NW6GxW9ZVMsMRmgDx432KNMC/U4H3Vg2jij+qUrlg8HiLzpKXkG3B4ruO4bEmK1UwJqYKXe1TnnsKocdcFMyp+W+eOvPEHJ/Pgb0MH2oaHMgrR12//rUDDerONe6IajvZI4uQnEqQrZnBBj3T5ssbXdXHHlBofbPBP9Jvn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iTXPUzvt; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iTXPUzvt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789197054; x=1820733054;
  h=date:from:to:cc:subject:message-id;
  bh=a7haC/CdroMajtTVlzxEdcLTfu/Xl/fkkTeDQoZbcLA=;
  b=iTXPUzvtFOLYqWHa43mUgELLg7WKWywFSzpbznDmirO8QP+5LESTbKic
   FE86TmO+RtzYZLERcmkyCcNEwscZPnARtgRt4CTB1A7/E+/JDlCW1mneM
   yg0nwIOEak4uM+TxReDWq7d3Ur3kDlYxBUZuwfCzBFKzRhKRdFJgqWfZm
   VOxGJuLiSHOTlim4dHlLw+2IfsJHvXAi0C7+2UfAcPW2Kjm8Y0Fqm+ZmV
   qZ+zaq/k1Ilqy6cY2qDCxWOYXplTu69Z3V2Hw9cDgaBpCRpa+1bA8HfiJ
   wjL7o4AUxUj4xiXiEn/TRrDIGsXAHllAv+t6S+lYj5afkpYBMTxvPHcDV
   w==;
X-CSE-ConnectionGUID: xs0vK6l7TUWckj7c0S5Yog==
X-CSE-MsgGUID: OG95lowgSg2rhNXnBHBYvg==
X-IronPort-AV: E=McAfee;i="6800,10657,11902"; a="89859456"
X-IronPort-AV: E=Sophos;i="6.27,98,1787036400"; 
   d="scan'208";a="89859456"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2026 00:10:54 -0700
X-CSE-ConnectionGUID: g2hqLcq5TtOGWqdiZ3v5bw==
X-CSE-MsgGUID: xQeAfAHYT7Op8xv6MtE42A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,98,1787036400"; 
   d="scan'208";a="269512487"
Received: from lkp-server02.sh.intel.com (HELO 0a3643a6ed9d) ([10.239.97.151])
  by fmviesa008.fm.intel.com with ESMTP; 12 Sep 2026 00:10:52 -0700
Received: from kbuild by 0a3643a6ed9d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1x5Hsv-000000002kH-2PGu;
	Sat, 12 Sep 2026 07:10:49 +0000
Date: Sat, 12 Sep 2026 15:10:45 +0800
From: kernel test robot <lkp@intel.com>
To: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 e40edfa049b967f0b9379bf549c59431302ad181
Message-ID: <202609121542.PyOOqSRy-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: e40edfa049b967f0b9379bf549c59431302ad181  Bluetooth: SMP: Zeroize raw key data on the stack in smp_e()

elapsed time: 1987m

configs tested: 120
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-16.1.0
alpha                               defconfig    gcc-16.1.0
arc                              allmodconfig    gcc-16.1.0
arc                               allnoconfig    gcc-16.1.0
arc                              allyesconfig    gcc-16.1.0
arc                                 defconfig    gcc-16.1.0
arc                   randconfig-001-20260912    gcc-11.5.0
arc                   randconfig-002-20260912    gcc-8.5.0
arm                               allnoconfig    clang-17
arm                              allyesconfig    gcc-16.1.0
arm                         lpc32xx_defconfig    clang-17
arm                   randconfig-001-20260912    gcc-10.5.0
arm                   randconfig-002-20260912    clang-18
arm                   randconfig-003-20260912    gcc-13.4.0
arm                   randconfig-004-20260912    clang-17
arm                         vf610m4_defconfig    gcc-16.1.0
arm                    vt8500_v6_v7_defconfig    gcc-16.1.0
arm64                             allnoconfig    gcc-16.1.0
csky                              allnoconfig    gcc-16.1.0
csky                                defconfig    gcc-16.1.0
csky                  randconfig-001-20260912    gcc-13.4.0
hexagon                           allnoconfig    clang-24
hexagon                             defconfig    clang-24
hexagon               randconfig-001-20260912    clang-22
hexagon               randconfig-002-20260912    clang-17
i386                              allnoconfig    gcc-14
i386                                defconfig    clang-22
i386                  randconfig-011-20260912    clang-22
i386                  randconfig-012-20260912    gcc-13
i386                  randconfig-013-20260912    gcc-14
i386                  randconfig-014-20260912    clang-22
i386                  randconfig-015-20260912    clang-22
i386                  randconfig-016-20260912    clang-22
i386                  randconfig-017-20260912    gcc-14
loongarch                         allnoconfig    clang-20
loongarch                           defconfig    clang-24
loongarch             randconfig-001-20260912    clang-24
loongarch             randconfig-002-20260912    gcc-13.4.0
m68k                              allnoconfig    gcc-16.1.0
m68k                                defconfig    gcc-16.1.0
microblaze                        allnoconfig    gcc-16.1.0
microblaze                          defconfig    gcc-16.1.0
mips                              allnoconfig    gcc-16.1.0
mips                          ath79_defconfig    gcc-16.1.0
mips                      malta_kvm_defconfig    gcc-16.1.0
mips                        qi_lb60_defconfig    clang-17
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20260912    gcc-8.5.0
nios2                 randconfig-002-20260912    gcc-11.5.0
openrisc                          allnoconfig    gcc-16.1.0
openrisc                            defconfig    gcc-16.1.0
parisc                            allnoconfig    gcc-16.1.0
parisc                           allyesconfig    gcc-16.1.0
parisc                              defconfig    gcc-16.1.0
parisc                randconfig-001-20260912    gcc-8.5.0
parisc                randconfig-002-20260912    gcc-8.5.0
parisc64                            defconfig    gcc-16.1.0
powerpc                           allnoconfig    gcc-16.1.0
powerpc               randconfig-001-20260912    gcc-13.4.0
powerpc               randconfig-002-20260912    clang-24
powerpc64             randconfig-001-20260912    clang-24
powerpc64             randconfig-002-20260912    gcc-8.5.0
riscv                            allmodconfig    clang-24
riscv                             allnoconfig    gcc-16.1.0
riscv                            allyesconfig    clang-24
riscv                               defconfig    clang-24
riscv                 randconfig-001-20260912    gcc-15.2.0
riscv                 randconfig-002-20260912    clang-24
s390                             allmodconfig    clang-24
s390                              allnoconfig    clang-24
s390                                defconfig    clang-18
s390                  randconfig-001-20260912    clang-24
s390                  randconfig-002-20260912    clang-17
sh                               allmodconfig    gcc-16.1.0
sh                                allnoconfig    gcc-16.1.0
sh                               allyesconfig    gcc-16.1.0
sh                         ap325rxa_defconfig    gcc-16.1.0
sh                                  defconfig    gcc-16.1.0
sh                          polaris_defconfig    gcc-16.1.0
sh                    randconfig-001-20260912    gcc-9.5.0
sh                    randconfig-002-20260912    gcc-11.5.0
sparc                             allnoconfig    gcc-16.1.0
sparc                               defconfig    gcc-16.1.0
sparc                 randconfig-001-20260912    gcc-12.5.0
sparc                 randconfig-002-20260912    gcc-14.3.0
sparc64                             defconfig    clang-24
sparc64               randconfig-001-20260912    clang-24
sparc64               randconfig-002-20260912    clang-20
um                               allmodconfig    clang-17
um                                allnoconfig    clang-17
um                                  defconfig    clang-24
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260912    gcc-14
um                    randconfig-002-20260912    clang-24
um                           x86_64_defconfig    clang-24
x86_64                            allnoconfig    clang-22
x86_64      buildonly-randconfig-001-20260912    gcc-14
x86_64      buildonly-randconfig-002-20260912    gcc-14
x86_64      buildonly-randconfig-003-20260912    gcc-14
x86_64      buildonly-randconfig-004-20260912    gcc-14
x86_64      buildonly-randconfig-005-20260912    clang-22
x86_64      buildonly-randconfig-006-20260912    gcc-12
x86_64                              defconfig    gcc-14
x86_64                randconfig-011-20260912    gcc-14
x86_64                randconfig-012-20260912    gcc-14
x86_64                randconfig-013-20260912    gcc-14
x86_64                randconfig-014-20260912    clang-22
x86_64                randconfig-015-20260912    gcc-14
x86_64                randconfig-016-20260912    clang-22
x86_64                randconfig-071-20260912    gcc-14
x86_64                randconfig-072-20260912    gcc-14
x86_64                randconfig-073-20260912    gcc-14
x86_64                randconfig-074-20260912    clang-22
x86_64                randconfig-075-20260912    gcc-14
x86_64                randconfig-076-20260912    gcc-14
x86_64                          rhel-9.4-rust    clang-22
xtensa                            allnoconfig    gcc-16.1.0
xtensa                randconfig-001-20260912    gcc-16.1.0
xtensa                randconfig-002-20260912    gcc-14.3.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
