Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91601426693
	for <linux-bluetooth@vger.kernel.org>; Fri,  9 Oct 2026 09:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791537785; cv=none; b=feWouiiaKjUZK45qPHdzTmze6mm9mZKemhVenjhjD7pVih02JO6HUxPD/oDx7YhKRfFgD8XTx1Mr6nDUnCDDUCYhbQaYvqpz29rTgkdiod2xiIhl+hBsjWb4WEvWPxXVX/2MQBEqu2jCMxNp6azcyTMojmjnILmprf/YTk0dRK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791537785; c=relaxed/simple;
	bh=Rn9A6eteo/b53GAsjKOsIBBuA9XAQRWfRKATAMoKYE4=;
	h=Date:From:To:Cc:Subject:Message-ID; b=lZiAk9O3GQPJPwV4NoKCgwYLv7rkaa6vRWRkNkOiMem7quYy6IPmpWdMdnO6zDNIdMP52jIDXkbeoOWKP43QiyOceM08OE/jDk/Q6hgI1+9nQzaWcjArr9M5y2I8dzocco8FzYKq612J4AsxaJ7Vji3I2R6idLkRdzu7joFPOeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lJn5syUk; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lJn5syUk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791537782; x=1823073782;
  h=date:from:to:cc:subject:message-id;
  bh=Rn9A6eteo/b53GAsjKOsIBBuA9XAQRWfRKATAMoKYE4=;
  b=lJn5syUkCN/ufWjAbYHbVPGKdRjQAONdWF+htKl0wqf2iXNlJAErgmEQ
   n0EbZCTKqOSP2phNzmyiHoh8egemZ7e4BgHAWCWldEUeOckBO0eUI04Dh
   XGKwJihwquEo0vj+nAgSqZbF8zDMOdKWlSWTUCMCpNkAQtoMdceiW8iEK
   gJtnC5RF4Rd0it7xE4FJtA5+xbbDxB0BV243WF80aTwLH2JtAAa4MX+tY
   AlYI1k23Kgu7rbUAI4S7461WbhQlPjYgrXmJDUHlHe/4cGr0Cy1Fbqm/k
   O7IVcjX9kkRCjRtj9chTwgSMXZthUWrm617E1ML7gxJD+cRmO/xUrfxvF
   w==;
X-CSE-ConnectionGUID: kcKLtDEdToK/vf6J76LZYg==
X-CSE-MsgGUID: nkSP708tSkWOH4NTL61RQw==
X-IronPort-AV: E=McAfee;i="6800,10657,11929"; a="342101"
X-IronPort-AV: E=Sophos;i="6.27,148,1787036400"; 
   d="scan'208";a="342101"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 02:23:01 -0700
X-CSE-ConnectionGUID: Sz/ovLglS5qxF2y2mEIL8A==
X-CSE-MsgGUID: U58pU27rSNCxUrNFVJp6aA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,148,1787036400"; 
   d="scan'208";a="433357"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 09 Oct 2026 02:22:59 -0700
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xF6ob-000000005Xk-0CtP;
	Fri, 09 Oct 2026 09:22:57 +0000
Date: Fri, 09 Oct 2026 17:22:41 +0800
From: kernel test robot <lkp@intel.com>
To: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 97a128698d9dcacb9a15cdc5080718a644b12637
Message-ID: <202610091738.LdRhCfaX-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: 97a128698d9dcacb9a15cdc5080718a644b12637  Merge branch 'bluetooth' into bluetooth-next

elapsed time: 1219m

configs tested: 424
configs skipped: 14

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                              allnoconfig    gcc-16.1.0
alpha                             allyesconfig    gcc-16.1.0
alpha                                defconfig    gcc-16.1.0
alpha                randconfig-r2100-20261008    gcc-9.5.0  cocci
alpha                randconfig-r2102-20261008    clang-22   cocci
alpha                randconfig-r2102-20261008    gcc-12.5.0 cocci
alpha                randconfig-r2104-20261008    gcc-14     cocci
alpha                randconfig-r2105-20261007    gcc-9.5.0  cocci
alpha                randconfig-r2107-20261008    gcc-8.5.0  cocci
alpha                randconfig-r2202-20261007    gcc-8.5.0  smatch
alpha                randconfig-r2304-20261007    clang-24   sparse
arc                               allmodconfig    gcc-16.1.0
arc                                allnoconfig    gcc-16.1.0
arc                               allyesconfig    gcc-16.1.0
arc                                  defconfig    gcc-16.1.0
arc                   randconfig-1000-20261009    gcc-10.5.0
arc                   randconfig-1001-20261009    gcc-10.5.0
arc                  randconfig-r2102-20261007    clang-24   cocci
arc                  randconfig-r2104-20261008    gcc-8.5.0  cocci
arc                  randconfig-r2300-20261008    clang-24   sparse
arc                  randconfig-r2303-20261008    gcc-10.5.0 sparse
arc                  randconfig-r2304-20261008    clang-24   sparse
arc                  randconfig-r2304-20261008    gcc-16.1.0 sparse
arm                                allnoconfig    gcc-16.1.0
arm                          bcm2835_defconfig    clang-24
arm                                  defconfig    gcc-16.1.0
arm                             mmp2_defconfig    gcc-16.1.0
arm                             mps2_defconfig    clang-24
arm                   randconfig-1000-20261009    gcc-10.5.0
arm                   randconfig-1001-20261009    gcc-10.5.0
arm                   randconfig-1002-20261009    gcc-10.5.0
arm                   randconfig-1003-20261009    gcc-10.5.0
arm                  randconfig-r2101-20261008    gcc-8.5.0  cocci
arm                  randconfig-r2104-20261008    gcc-16.1.0 cocci
arm                  randconfig-r2107-20261008    gcc-14     cocci
arm                  randconfig-r2107-20261008    gcc-16.1.0 cocci
arm                  randconfig-r2107-20261008    gcc-8.5.0  cocci
arm                  randconfig-r2200-20261008    clang-17   smatch
arm                  randconfig-r2201-20261008    gcc-8.5.0  smatch
arm                  randconfig-r2202-20261007    gcc-12.5.0 smatch
arm                  randconfig-r2300-20261007    gcc-14.3.0 sparse
arm                  randconfig-r2300-20261008    gcc-10.5.0 sparse
arm64                              allnoconfig    gcc-16.1.0
arm64                                defconfig    gcc-16.1.0
arm64                 randconfig-1000-20261009    gcc-15.2.0
arm64                 randconfig-1001-20261009    gcc-15.2.0
arm64                 randconfig-1002-20261009    gcc-15.2.0
arm64                 randconfig-1003-20261009    gcc-15.2.0
arm64                randconfig-r2304-20261008    gcc-10.5.0 sparse
arm64                randconfig-r2306-20261007    gcc-14     sparse
arm64                randconfig-r2307-20261008    clang-24   sparse
csky                              allmodconfig    gcc-16.1.0
csky                               allnoconfig    gcc-16.1.0
csky                                 defconfig    gcc-16.1.0
csky                  randconfig-1000-20261009    gcc-15.2.0
csky                  randconfig-1001-20261009    gcc-15.2.0
csky                 randconfig-r2106-20261007    gcc-9.5.0  cocci
csky                 randconfig-r2301-20261008    gcc-10.5.0 sparse
csky                 randconfig-r2307-20261008    gcc-8.5.0  sparse
hexagon                           allmodconfig    gcc-16.1.0
hexagon                            allnoconfig    gcc-16.1.0
hexagon                              defconfig    gcc-16.1.0
hexagon               randconfig-1000-20261008    gcc-16.1.0
hexagon               randconfig-1000-20261009    clang-18
hexagon               randconfig-1001-20261008    gcc-16.1.0
hexagon               randconfig-1001-20261009    clang-18
hexagon              randconfig-r2201-20261008    clang-24   smatch
hexagon              randconfig-r2305-20261008    gcc-13.4.0 sparse
i386                               allnoconfig    gcc-16.1.0
i386        buildonly-randconfig-1000-20261009    clang-22
i386        buildonly-randconfig-1001-20261009    clang-22
i386        buildonly-randconfig-1002-20261009    clang-22
i386        buildonly-randconfig-1003-20261009    clang-22
i386        buildonly-randconfig-1004-20261009    clang-22
i386        buildonly-randconfig-1005-20261009    clang-22
i386                                 defconfig    gcc-16.1.0
i386                  randconfig-1000-20261008    gcc-14
i386                  randconfig-1000-20261009    clang-22
i386                  randconfig-1001-20261008    gcc-14
i386                  randconfig-1001-20261009    clang-22
i386                  randconfig-1002-20261008    gcc-14
i386                  randconfig-1002-20261009    clang-22
i386                  randconfig-1003-20261008    gcc-14
i386                  randconfig-1003-20261009    clang-22
i386                  randconfig-1004-20261008    gcc-14
i386                  randconfig-1004-20261009    clang-22
i386                  randconfig-1005-20261008    gcc-14
i386                  randconfig-1005-20261009    clang-22
i386                  randconfig-1006-20261008    gcc-14
i386                  randconfig-1006-20261009    clang-22
i386                  randconfig-1007-20261008    clang-22
i386                  randconfig-1007-20261009    clang-22
i386                  randconfig-1008-20261008    clang-22
i386                  randconfig-1008-20261009    clang-22
i386                  randconfig-1009-20261008    clang-22
i386                  randconfig-1009-20261009    clang-22
i386                  randconfig-1010-20261008    clang-22
i386                  randconfig-1010-20261009    clang-22
i386                  randconfig-1011-20261008    clang-22
i386                  randconfig-1011-20261009    clang-22
i386                  randconfig-1012-20261008    clang-22
i386                  randconfig-1012-20261009    clang-22
i386                  randconfig-1013-20261008    clang-22
i386                  randconfig-1013-20261009    clang-22
i386                  randconfig-2100-20261007    clang-22   cocci
i386                  randconfig-2100-20261008    clang-22   cocci
i386                  randconfig-2101-20261007    clang-22   cocci
i386                  randconfig-2101-20261008    clang-22   cocci
i386                  randconfig-2102-20261007    clang-22   cocci
i386                  randconfig-2102-20261008    clang-22   cocci
i386                  randconfig-2103-20261007    clang-22   cocci
i386                  randconfig-2103-20261008    clang-22   cocci
i386                  randconfig-2200-20261007    gcc-14     smatch
i386                  randconfig-2200-20261008    clang-22   smatch
i386                  randconfig-2300-20261007    clang-22   sparse
i386                  randconfig-2300-20261008    clang-22   sparse
i386                  randconfig-2301-20261007    clang-22   sparse
i386                  randconfig-2301-20261008    clang-22   sparse
i386                  randconfig-2302-20261007    clang-22   sparse
i386                  randconfig-2302-20261008    clang-22   sparse
i386                 randconfig-r2101-20261008    clang-22   cocci
i386                 randconfig-r2300-20261008    gcc-10.5.0 sparse
i386                 randconfig-r2302-20261008    gcc-16.1.0 sparse
i386                 randconfig-r2304-20261008    gcc-13.4.0 sparse
i386                 randconfig-r2307-20261008    gcc-14     sparse
i386                 randconfig-r2309-20261007    gcc-14     sparse
loongarch                          allnoconfig    gcc-16.1.0
loongarch                            defconfig    clang-24
loongarch             randconfig-1000-20261008    gcc-16.1.0
loongarch             randconfig-1000-20261009    clang-18
loongarch             randconfig-1001-20261008    gcc-16.1.0
loongarch             randconfig-1001-20261009    clang-18
loongarch            randconfig-r2100-20261007    clang-24   cocci
loongarch            randconfig-r2100-20261008    gcc-12.5.0 cocci
loongarch            randconfig-r2101-20261008    gcc-9.5.0  cocci
loongarch            randconfig-r2106-20261008    gcc-14     cocci
loongarch            randconfig-r2307-20261008    clang-24   sparse
loongarch            randconfig-r2308-20261008    gcc-14.3.0 sparse
m68k                              allmodconfig    gcc-16.1.0
m68k                               allnoconfig    gcc-16.1.0
m68k                              allyesconfig    gcc-16.1.0
m68k                                 defconfig    clang-24
m68k                           hp300_defconfig    clang-24
m68k                 randconfig-r2105-20261008    gcc-8.5.0  cocci
m68k                 randconfig-r2200-20261008    gcc-16.1.0 smatch
m68k                 randconfig-r2202-20261008    gcc-8.5.0  smatch
m68k                 randconfig-r2300-20261008    gcc-13.4.0 sparse
m68k                 randconfig-r2301-20261008    gcc-13.4.0 sparse
m68k                 randconfig-r2302-20261007    clang-24   sparse
m68k                 randconfig-r2305-20261007    gcc-14.3.0 sparse
m68k                 randconfig-r2309-20261008    gcc-14     sparse
microblaze                         allnoconfig    gcc-16.1.0
microblaze                           defconfig    clang-24
microblaze           randconfig-r2102-20261008    clang-24   cocci
microblaze           randconfig-r2103-20261008    gcc-12.5.0 cocci
microblaze           randconfig-r2105-20261007    gcc-9.5.0  cocci
microblaze           randconfig-r2301-20261008    gcc-16.1.0 sparse
microblaze           randconfig-r2304-20261007    gcc-14.3.0 sparse
microblaze           randconfig-r2305-20261008    gcc-10.5.0 sparse
microblaze           randconfig-r2305-20261008    gcc-16.1.0 sparse
microblaze           randconfig-r2308-20261008    gcc-14     sparse
mips                              allmodconfig    gcc-16.1.0
mips                               allnoconfig    gcc-16.1.0
mips                              allyesconfig    gcc-16.1.0
mips                         bcm63xx_defconfig    clang-24
mips                       maltasmvp_defconfig    gcc-16.1.0
mips                 randconfig-r2107-20261008    gcc-16.1.0 cocci
mips                 randconfig-r2202-20261008    gcc-15.2.0 smatch
mips                 randconfig-r2300-20261008    gcc-13.4.0 sparse
mips                 randconfig-r2301-20261008    gcc-10.5.0 sparse
mips                 randconfig-r2306-20261008    clang-24   sparse
nios2                             alldefconfig    clang-24
nios2                             allmodconfig    clang-20
nios2                              allnoconfig    clang-24
nios2                                defconfig    clang-24
nios2                 randconfig-1000-20261008    gcc-16.1.0
nios2                 randconfig-1000-20261009    clang-18
nios2                 randconfig-1001-20261008    gcc-16.1.0
nios2                 randconfig-1001-20261009    clang-18
nios2                randconfig-r2100-20261008    clang-24   cocci
nios2                randconfig-r2102-20261008    gcc-9.5.0  cocci
nios2                randconfig-r2103-20261008    gcc-12.5.0 cocci
nios2                randconfig-r2104-20261008    gcc-8.5.0  cocci
nios2                randconfig-r2202-20261008    gcc-8.5.0  smatch
nios2                randconfig-r2301-20261007    gcc-14.3.0 sparse
nios2                randconfig-r2301-20261008    clang-24   sparse
nios2                randconfig-r2302-20261008    gcc-10.5.0 sparse
nios2                randconfig-r2305-20261007    clang-24   sparse
nios2                randconfig-r2305-20261008    gcc-10.5.0 sparse
nios2                randconfig-r2306-20261008    gcc-8.5.0  sparse
nios2                randconfig-r2307-20261007    gcc-14     sparse
openrisc                          allmodconfig    clang-20
openrisc                           allnoconfig    clang-24
openrisc                             defconfig    gcc-16.1.0
openrisc                   or1klitex_defconfig    gcc-16.1.0
openrisc             randconfig-r2101-20261007    clang-24   cocci
openrisc             randconfig-r2101-20261008    gcc-12.5.0 cocci
openrisc             randconfig-r2104-20261007    gcc-9.5.0  cocci
openrisc             randconfig-r2104-20261008    gcc-16.1.0 cocci
openrisc             randconfig-r2202-20261008    gcc-15.2.0 smatch
openrisc             randconfig-r2301-20261007    clang-24   sparse
openrisc             randconfig-r2305-20261008    clang-24   sparse
parisc                            allmodconfig    gcc-16.1.0
parisc                             allnoconfig    clang-24
parisc                            allyesconfig    clang-17
parisc                               defconfig    gcc-16.1.0
parisc                randconfig-1000-20261009    gcc-8.5.0
parisc                randconfig-1001-20261009    gcc-8.5.0
parisc               randconfig-r2200-20261008    gcc-13.4.0 smatch
parisc               randconfig-r2300-20261008    gcc-16.1.0 sparse
parisc               randconfig-r2301-20261008    gcc-13.4.0 sparse
parisc               randconfig-r2302-20261007    gcc-14.3.0 sparse
parisc               randconfig-r2305-20261008    gcc-13.4.0 sparse
parisc               randconfig-r2309-20261008    clang-24   sparse
parisc64                          alldefconfig    gcc-16.1.0
parisc64                             defconfig    clang-24
powerpc                           allmodconfig    gcc-16.1.0
powerpc                            allnoconfig    clang-24
powerpc                       chrp32_defconfig    clang-24
powerpc                        holly_defconfig    clang-24
powerpc                        ppc64_defconfig    gcc-16.1.0
powerpc               randconfig-1000-20261009    gcc-8.5.0
powerpc               randconfig-1001-20261009    gcc-8.5.0
powerpc              randconfig-r2105-20261008    gcc-16.1.0 cocci
powerpc64             randconfig-1000-20261009    gcc-8.5.0
powerpc64             randconfig-1001-20261009    gcc-8.5.0
powerpc64            randconfig-r2103-20261008    clang-22   cocci
powerpc64            randconfig-r2105-20261008    gcc-8.5.0  cocci
powerpc64            randconfig-r2201-20261007    clang-24   smatch
powerpc64            randconfig-r2300-20261007    clang-24   sparse
powerpc64            randconfig-r2303-20261008    clang-24   sparse
powerpc64            randconfig-r2308-20261007    gcc-14     sparse
riscv                              allnoconfig    clang-24
riscv                                defconfig    gcc-16.1.0
riscv                 randconfig-1000-20261009    gcc-16.1.0
riscv                 randconfig-1001-20261009    gcc-16.1.0
riscv                 randconfig-2000-20261007    gcc-12.5.0
riscv                 randconfig-2000-20261008    gcc-11.5.0
riscv                 randconfig-2001-20261007    gcc-12.5.0
riscv                 randconfig-2001-20261008    gcc-11.5.0
riscv                randconfig-r2101-20261008    clang-24   cocci
riscv                randconfig-r2103-20261008    gcc-8.5.0  cocci
riscv                randconfig-r2104-20261007    gcc-9.5.0  cocci
riscv                randconfig-r2106-20261008    gcc-8.5.0  cocci
riscv                randconfig-r2201-20261007    clang-24   smatch
riscv                randconfig-r2307-20261008    clang-24   sparse
riscv                randconfig-r2308-20261008    clang-24   sparse
s390                              allmodconfig    clang-17
s390                               allnoconfig    clang-24
s390                              allyesconfig    gcc-16.1.0
s390                                 defconfig    gcc-16.1.0
s390                  randconfig-1000-20261009    gcc-16.1.0
s390                  randconfig-1001-20261009    gcc-16.1.0
s390                  randconfig-2000-20261007    gcc-12.5.0
s390                  randconfig-2000-20261008    gcc-11.5.0
s390                  randconfig-2001-20261007    gcc-12.5.0
s390                  randconfig-2001-20261008    gcc-11.5.0
s390                 randconfig-r2100-20261008    clang-24   cocci
s390                 randconfig-r2107-20261008    gcc-8.5.0  cocci
s390                 randconfig-r2201-20261008    gcc-11.5.0 smatch
s390                 randconfig-r2202-20261008    clang-17   smatch
s390                 randconfig-r2302-20261008    clang-24   sparse
s390                 randconfig-r2304-20261008    gcc-13.4.0 sparse
s390                 randconfig-r2306-20261008    gcc-14.3.0 sparse
s390                 randconfig-r2309-20261008    clang-24   sparse
s390                 randconfig-r2309-20261008    gcc-14.3.0 sparse
sh                                allmodconfig    gcc-16.1.0
sh                                 allnoconfig    clang-24
sh                                allyesconfig    clang-17
sh                                   defconfig    gcc-14
sh                  kfr2r09-romimage_defconfig    clang-24
sh                      magicpanelr2_defconfig    gcc-16.1.0
sh                    randconfig-1000-20261009    gcc-16.1.0
sh                    randconfig-1001-20261009    gcc-16.1.0
sh                    randconfig-2000-20261007    gcc-12.5.0
sh                    randconfig-2000-20261008    gcc-11.5.0
sh                    randconfig-2001-20261007    gcc-12.5.0
sh                    randconfig-2001-20261008    gcc-11.5.0
sh                   randconfig-r2200-20261008    gcc-16.1.0 smatch
sh                   randconfig-r2302-20261008    gcc-13.4.0 sparse
sh                   randconfig-r2303-20261008    gcc-16.1.0 sparse
sh                   randconfig-r2306-20261008    clang-24   sparse
sh                   randconfig-r2308-20261008    clang-24   sparse
sparc                              allnoconfig    clang-24
sparc                                defconfig    gcc-16.1.0
sparc                 randconfig-1000-20261009    clang-18
sparc                 randconfig-1001-20261009    clang-18
sparc                 randconfig-2000-20261007    clang-24
sparc                 randconfig-2000-20261008    gcc-14
sparc                 randconfig-2001-20261007    clang-24
sparc                 randconfig-2001-20261008    gcc-14
sparc                randconfig-r2102-20261008    clang-24   cocci
sparc                randconfig-r2103-20261008    clang-24   cocci
sparc                randconfig-r2104-20261008    gcc-8.5.0  cocci
sparc                randconfig-r2105-20261008    gcc-8.5.0  cocci
sparc                randconfig-r2106-20261008    gcc-16.1.0 cocci
sparc                randconfig-r2201-20261008    gcc-8.5.0  smatch
sparc                randconfig-r2303-20261007    clang-24   sparse
sparc                randconfig-r2303-20261008    gcc-13.4.0 sparse
sparc                randconfig-r2304-20261008    gcc-10.5.0 sparse
sparc64                           allmodconfig    clang-20
sparc64                              defconfig    gcc-14
sparc64               randconfig-1000-20261009    clang-18
sparc64               randconfig-1001-20261009    clang-18
sparc64               randconfig-2000-20261007    clang-24
sparc64               randconfig-2000-20261008    gcc-14
sparc64               randconfig-2001-20261007    clang-24
sparc64               randconfig-2001-20261008    gcc-14
sparc64              randconfig-r2100-20261008    clang-22   cocci
sparc64              randconfig-r2100-20261008    gcc-8.5.0  cocci
sparc64              randconfig-r2102-20261008    gcc-12.5.0 cocci
sparc64              randconfig-r2102-20261008    gcc-8.5.0  cocci
sparc64              randconfig-r2103-20261007    clang-24   cocci
sparc64              randconfig-r2106-20261007    gcc-9.5.0  cocci
sparc64              randconfig-r2106-20261008    gcc-16.1.0 cocci
sparc64              randconfig-r2107-20261007    gcc-9.5.0  cocci
sparc64              randconfig-r2302-20261008    gcc-13.4.0 sparse
sparc64              randconfig-r2308-20261008    clang-24   sparse
um                                allmodconfig    clang-17
um                                 allnoconfig    clang-24
um                                allyesconfig    gcc-16.1.0
um                                   defconfig    gcc-14
um                              i386_defconfig    gcc-14
um                    randconfig-1000-20261009    clang-18
um                    randconfig-1001-20261009    clang-18
um                    randconfig-2000-20261007    clang-24
um                    randconfig-2000-20261008    gcc-14
um                    randconfig-2001-20261007    clang-24
um                    randconfig-2001-20261008    gcc-14
um                   randconfig-r2101-20261008    gcc-12.5.0 cocci
um                   randconfig-r2105-20261008    gcc-14     cocci
um                   randconfig-r2105-20261008    gcc-16.1.0 cocci
um                   randconfig-r2107-20261007    gcc-9.5.0  cocci
um                   randconfig-r2200-20261008    clang-17   smatch
um                   randconfig-r2201-20261008    clang-24   smatch
um                   randconfig-r2202-20261008    clang-17   smatch
um                   randconfig-r2303-20261007    gcc-14.3.0 sparse
um                   randconfig-r2306-20261008    clang-24   sparse
um                   randconfig-r2307-20261008    gcc-14.3.0 sparse
um                            x86_64_defconfig    gcc-14
x86_64                             allnoconfig    clang-24
x86_64      buildonly-randconfig-1000-20261009    clang-22
x86_64      buildonly-randconfig-1001-20261009    clang-22
x86_64      buildonly-randconfig-1002-20261009    clang-22
x86_64      buildonly-randconfig-1003-20261009    clang-22
x86_64      buildonly-randconfig-1004-20261009    clang-22
x86_64      buildonly-randconfig-1005-20261009    clang-22
x86_64                               defconfig    gcc-14
x86_64                                   kexec    clang-22
x86_64                randconfig-1000-20261008    gcc-14
x86_64                randconfig-1000-20261009    gcc-14
x86_64                randconfig-1001-20261008    gcc-14
x86_64                randconfig-1001-20261009    gcc-14
x86_64                randconfig-1002-20261008    gcc-14
x86_64                randconfig-1002-20261009    gcc-14
x86_64                randconfig-1003-20261008    gcc-14
x86_64                randconfig-1003-20261009    gcc-14
x86_64                randconfig-1004-20261008    gcc-14
x86_64                randconfig-1004-20261009    gcc-14
x86_64                randconfig-1005-20261008    gcc-14
x86_64                randconfig-1005-20261009    gcc-14
x86_64                randconfig-1006-20261008    clang-22
x86_64                randconfig-1007-20261008    clang-22
x86_64                randconfig-1008-20261008    clang-22
x86_64                randconfig-1009-20261008    clang-22
x86_64                randconfig-1010-20261008    clang-22
x86_64                randconfig-1011-20261008    clang-22
x86_64                randconfig-1012-20261008    clang-22
x86_64                randconfig-1012-20261009    gcc-14
x86_64                randconfig-1013-20261008    clang-22
x86_64                randconfig-1013-20261009    gcc-14
x86_64                randconfig-1014-20261008    clang-22
x86_64                randconfig-1014-20261009    gcc-14
x86_64                randconfig-1015-20261008    clang-22
x86_64                randconfig-1015-20261009    gcc-14
x86_64                randconfig-1016-20261008    clang-22
x86_64                randconfig-1016-20261009    gcc-14
x86_64                randconfig-1017-20261008    clang-22
x86_64                randconfig-1017-20261009    gcc-14
x86_64                randconfig-2100-20261007    clang-22   cocci
x86_64                randconfig-2100-20261008    clang-22   cocci
x86_64                randconfig-2101-20261007    clang-22   cocci
x86_64                randconfig-2101-20261008    clang-22   cocci
x86_64                randconfig-2102-20261007    clang-22   cocci
x86_64                randconfig-2102-20261008    clang-22   cocci
x86_64                randconfig-2103-20261007    clang-22   cocci
x86_64                randconfig-2103-20261008    clang-22   cocci
x86_64                randconfig-2200-20261007    gcc-14     smatch
x86_64                randconfig-2200-20261008    gcc-14     smatch
x86_64                randconfig-2300-20261007    clang-22   sparse
x86_64                randconfig-2300-20261008    clang-22   sparse
x86_64                randconfig-2301-20261007    clang-22   sparse
x86_64                randconfig-2301-20261008    clang-22   sparse
x86_64                randconfig-2302-20261007    clang-22   sparse
x86_64                randconfig-2302-20261008    clang-22   sparse
x86_64               randconfig-r2103-20261008    gcc-9.5.0  cocci
x86_64               randconfig-r2303-20261008    gcc-10.5.0 sparse
x86_64               randconfig-r2306-20261008    gcc-14     sparse
x86_64               randconfig-r2309-20261008    gcc-8.5.0  sparse
x86_64                                rhel-9.4    clang-22
x86_64                            rhel-9.4-bpf    clang-22
x86_64                            rhel-9.4-bpf    gcc-14
x86_64                           rhel-9.4-func    clang-22
x86_64                     rhel-9.4-kselftests    clang-22
x86_64                          rhel-9.4-kunit    clang-22
x86_64                          rhel-9.4-kunit    gcc-14
x86_64                            rhel-9.4-ltp    clang-22
x86_64                            rhel-9.4-ltp    gcc-14
x86_64                           rhel-9.4-rust    clang-22
x86_64                           rhel-9.4-rust    clang-22
xtensa                             allnoconfig    clang-24
xtensa                            allyesconfig    clang-20
xtensa                   audio_kc705_defconfig    gcc-16.1.0
xtensa                randconfig-1000-20261009    clang-18
xtensa                randconfig-1001-20261009    clang-18
xtensa                randconfig-2000-20261007    clang-24
xtensa                randconfig-2000-20261008    gcc-14
xtensa                randconfig-2001-20261007    clang-24
xtensa                randconfig-2001-20261008    gcc-14
xtensa               randconfig-r2106-20261008    gcc-8.5.0  cocci
xtensa               randconfig-r2200-20261008    gcc-8.5.0  smatch
xtensa               randconfig-r2201-20261008    gcc-13.4.0 smatch
xtensa               randconfig-r2308-20261008    gcc-8.5.0  sparse
xtensa               randconfig-r2309-20261008    clang-24   sparse

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
