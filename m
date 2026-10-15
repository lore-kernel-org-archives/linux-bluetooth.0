Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C378456E1C
	for <linux-bluetooth@vger.kernel.org>; Thu, 15 Oct 2026 06:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792046494; cv=none; b=HsvYjqqGgIQWr0FJkRH0dGhhj0TmsitphiCQZBQ1UeCBPZVPYDLtlHWAyPEtVfmCBCU8Fk45Zq00ZwFad1AO60+Q57p62X8t6rs2RgVEZp4ETWowEZ8PfedGzeMgXZvdkaqj5y4YTJyER4gWANYJCu0aWdsbE4xZwr7MAWBGKUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792046494; c=relaxed/simple;
	bh=Ldnjz/LYF+Ig3OxXZ6EbIyTFTUTNpesxqpcNoWt/Tls=;
	h=Date:From:To:Cc:Subject:Message-ID; b=PWkBIuv51LKsD1UlQ0FFXOoZET2m3NDQW4HU2LRtjUH+wFpqzgIKFJxb7dM9zD827Q7JXTVPKnda3oFcr/bIVnpp0jyl+yBf+SGyxs5xCPzrsy3U1cQBpIlCkUxUSzbgq66lcF4WBzq+Fp3wY9xVb7htxAAPrg6IoYHkGwDsEok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PqwbRcZU; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PqwbRcZU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792046493; x=1823582493;
  h=date:from:to:cc:subject:message-id;
  bh=Ldnjz/LYF+Ig3OxXZ6EbIyTFTUTNpesxqpcNoWt/Tls=;
  b=PqwbRcZU/bKBu3duU5CnVfASG8//uL5Xp17LmHlIq0PeF6YYIbSsuSTx
   6XT5wXXxg4d5H5erqyOQkFLAaflZOYjXY72LrYTxJyxFpZswElpBbos7f
   7gUi5OHMOtmYHWNz3YyRAdIzPCNF6GFv1Ghdhg1FHOpeibY5Ic+bjSOAM
   dm52/RBoELWhJGNjHrkhhaLVknIV8ieDpK3v6Nai8lK+9r37A6y5kyhmc
   qa9gEz1QHApYaX8FezsWa51g/QO8g/2jDZJwaiJ4DEQy6rK4skYiNK52o
   lcpualCwXhVs5e9opafH3IwcsLjpB5WVLvHzN9mV5EWCUSHRfDP8CFG7U
   Q==;
X-CSE-ConnectionGUID: WIoFig7QSKS+XGowkpUdNg==
X-CSE-MsgGUID: V8qgbN2STneFml0BChoJww==
X-IronPort-AV: E=McAfee;i="6800,10657,11935"; a="693801"
X-IronPort-AV: E=Sophos;i="6.27,159,1787036400"; 
   d="scan'208";a="693801"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2026 23:41:32 -0700
X-CSE-ConnectionGUID: GhxUwhldRAq4Hl88gjvtdw==
X-CSE-MsgGUID: SvlUOxvqQgiUy25K/yDCAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,159,1787036400"; 
   d="scan'208";a="1861694"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 14 Oct 2026 23:41:31 -0700
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xHF9c-00000000Fxe-3fKo;
	Thu, 15 Oct 2026 06:41:28 +0000
Date: Thu, 15 Oct 2026 14:40:57 +0800
From: kernel test robot <lkp@intel.com>
To: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 609a23989d637e2f90522a37c62e65c8c9b8b0ff
Message-ID: <202610151454.qzsGkUhF-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: 609a23989d637e2f90522a37c62e65c8c9b8b0ff  Bluetooth: btusb: annotate Intel Otter Peak 2 USB ID

elapsed time: 2249m

configs tested: 221
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                              allnoconfig    gcc-16.1.0
alpha                             allyesconfig    gcc-16.1.0
alpha                                defconfig    gcc-16.1.0
alpha                randconfig-r2308-20261014    gcc-14.3.0 sparse
arc                               allmodconfig    clang-24
arc                                allnoconfig    gcc-16.1.0
arc                               allyesconfig    clang-24
arc                                  defconfig    gcc-16.1.0
arm                                allnoconfig    gcc-16.1.0
arm                               allyesconfig    clang-24
arm                      am200epdkit_defconfig    gcc-16.1.0
arm                      davinci_all_defconfig    clang-24
arm                                  defconfig    gcc-16.1.0
arm                       jornada720_defconfig    clang-24
arm                          mv78xx0_defconfig    gcc-16.1.0
arm                              mxs_defconfig    gcc-16.1.0
arm                          s3c6400_defconfig    clang-24
arm                          socfpga_defconfig    gcc-16.1.0
arm                            u8500_defconfig    clang-24
arm                         vexpress_defconfig    gcc-16.1.0
arm64                             allmodconfig    clang-24
arm64                              allnoconfig    gcc-16.1.0
arm64                                defconfig    gcc-16.1.0
arm64                 randconfig-1000-20261015    gcc-8.5.0
arm64                 randconfig-1001-20261015    gcc-8.5.0
arm64                 randconfig-1002-20261015    gcc-8.5.0
arm64                 randconfig-1003-20261015    gcc-8.5.0
arm64                 randconfig-2000-20261014    gcc-16.1.0
arm64                 randconfig-2001-20261014    gcc-16.1.0
arm64                randconfig-r2101-20261014    gcc-11.5.0 cocci
arm64                randconfig-r2105-20261014    gcc-8.5.0  cocci
csky                              allmodconfig    gcc-16.1.0
csky                               allnoconfig    gcc-16.1.0
csky                                 defconfig    gcc-16.1.0
csky                  randconfig-1000-20261015    gcc-8.5.0
csky                  randconfig-1001-20261015    gcc-8.5.0
csky                  randconfig-2000-20261014    gcc-16.1.0
csky                  randconfig-2001-20261014    gcc-16.1.0
csky                 randconfig-r2309-20261014    gcc-14.3.0 sparse
hexagon                           allmodconfig    gcc-16.1.0
hexagon                            allnoconfig    gcc-16.1.0
hexagon                              defconfig    gcc-16.1.0
hexagon               randconfig-1000-20261015    clang-24
hexagon               randconfig-1001-20261015    clang-24
hexagon               randconfig-2000-20261014    gcc-16.1.0
hexagon               randconfig-2001-20261014    gcc-16.1.0
hexagon              randconfig-r2103-20261014    gcc-11.5.0 cocci
i386                              allmodconfig    clang-22
i386                               allnoconfig    gcc-16.1.0
i386                              allyesconfig    clang-22
i386        buildonly-randconfig-1000-20261015    gcc-14
i386        buildonly-randconfig-1001-20261015    gcc-14
i386        buildonly-randconfig-1002-20261015    gcc-14
i386        buildonly-randconfig-1003-20261015    gcc-14
i386        buildonly-randconfig-1004-20261015    gcc-14
i386        buildonly-randconfig-1005-20261015    gcc-14
i386                                 defconfig    gcc-16.1.0
i386                  randconfig-1000-20261015    gcc-14
i386                  randconfig-1001-20261015    gcc-14
i386                  randconfig-1002-20261015    gcc-14
i386                  randconfig-1003-20261015    gcc-14
i386                  randconfig-1004-20261015    gcc-14
i386                  randconfig-1005-20261015    gcc-14
i386                  randconfig-1006-20261015    gcc-14
i386                  randconfig-1007-20261015    clang-22
i386                  randconfig-1008-20261015    clang-22
i386                  randconfig-1009-20261015    clang-22
i386                  randconfig-1010-20261015    clang-22
i386                  randconfig-1011-20261015    clang-22
i386                  randconfig-1012-20261015    clang-22
i386                  randconfig-1013-20261015    clang-22
i386                  randconfig-2200-20261014    clang-22   smatch
i386                 randconfig-r2111-20261014    gcc-8.5.0  cocci
loongarch                         allmodconfig    clang-24
loongarch                          allnoconfig    gcc-16.1.0
loongarch                            defconfig    clang-24
loongarch                 loongson64_defconfig    clang-24
loongarch             randconfig-1000-20261015    clang-24
loongarch             randconfig-1001-20261015    clang-24
loongarch             randconfig-2000-20261014    gcc-8.5.0
loongarch             randconfig-2001-20261014    gcc-8.5.0
loongarch            randconfig-r2104-20261014    gcc-8.5.0  cocci
m68k                              allmodconfig    gcc-16.1.0
m68k                               allnoconfig    gcc-16.1.0
m68k                              allyesconfig    clang-24
m68k                                 defconfig    clang-24
m68k                        m5208evb_defconfig    gcc-16.1.0
microblaze                         allnoconfig    gcc-16.1.0
microblaze                        allyesconfig    gcc-16.1.0
microblaze                           defconfig    clang-24
microblaze           randconfig-r2310-20261014    gcc-14.3.0 sparse
mips                              allmodconfig    gcc-16.1.0
mips                               allnoconfig    gcc-16.1.0
mips                              allyesconfig    gcc-16.1.0
mips                        bmips_be_defconfig    gcc-16.1.0
mips                 randconfig-r2201-20261014    clang-24   smatch
mips                 randconfig-r2307-20261014    gcc-14.3.0 sparse
nios2                             allmodconfig    clang-20
nios2                              allnoconfig    clang-24
nios2                                defconfig    clang-24
nios2                 randconfig-1000-20261015    clang-24
nios2                 randconfig-1001-20261015    clang-24
nios2                 randconfig-2000-20261014    gcc-8.5.0
nios2                 randconfig-2001-20261014    gcc-8.5.0
nios2                randconfig-r2102-20261014    gcc-11.5.0 cocci
openrisc                          allmodconfig    clang-20
openrisc                           allnoconfig    clang-24
openrisc                             defconfig    gcc-16.1.0
openrisc             randconfig-r2108-20261014    gcc-11.5.0 cocci
parisc                            allmodconfig    gcc-16.1.0
parisc                             allnoconfig    clang-24
parisc                            allyesconfig    clang-17
parisc                               defconfig    gcc-16.1.0
parisc                randconfig-1000-20261015    gcc-8.5.0
parisc                randconfig-1001-20261015    gcc-8.5.0
parisc                randconfig-2000-20261014    gcc-8.5.0
parisc                randconfig-2001-20261014    gcc-8.5.0
parisc               randconfig-r2202-20261014    gcc-12.5.0 smatch
parisc64                             defconfig    clang-24
powerpc                           allmodconfig    gcc-16.1.0
powerpc                            allnoconfig    clang-24
powerpc                         cell_defconfig    clang-24
powerpc               randconfig-1000-20261015    gcc-8.5.0
powerpc               randconfig-1001-20261015    gcc-8.5.0
powerpc               randconfig-2000-20261014    clang-22
powerpc               randconfig-2001-20261014    clang-22
powerpc              randconfig-r2107-20261014    gcc-8.5.0  cocci
powerpc                      tqm8540_defconfig    clang-24
powerpc64             randconfig-1000-20261015    gcc-8.5.0
powerpc64             randconfig-1001-20261015    gcc-8.5.0
powerpc64             randconfig-2000-20261014    clang-22
powerpc64             randconfig-2001-20261014    clang-22
powerpc64            randconfig-r2306-20261014    gcc-14.3.0 sparse
riscv                             allmodconfig    clang-24
riscv                              allnoconfig    clang-24
riscv                             allyesconfig    clang-24
riscv                                defconfig    gcc-16.1.0
riscv                 randconfig-1000-20261015    gcc-11.5.0
riscv                 randconfig-1001-20261015    gcc-11.5.0
riscv                 randconfig-2000-20261014    gcc-16.1.0
riscv                 randconfig-2001-20261014    gcc-16.1.0
s390                              allmodconfig    clang-17
s390                               allnoconfig    clang-24
s390                              allyesconfig    gcc-16.1.0
s390                                 defconfig    gcc-16.1.0
s390                  randconfig-1000-20261015    gcc-11.5.0
s390                  randconfig-1001-20261015    gcc-11.5.0
s390                  randconfig-2000-20261014    gcc-16.1.0
s390                  randconfig-2001-20261014    gcc-16.1.0
s390                 randconfig-r2106-20261014    gcc-8.5.0  cocci
s390                 randconfig-r2200-20261014    gcc-8.5.0  smatch
s390                 randconfig-r2311-20261014    gcc-14.3.0 sparse
sh                                allmodconfig    gcc-16.1.0
sh                                 allnoconfig    clang-24
sh                                allyesconfig    clang-17
sh                          ap325rxa_defconfig    clang-24
sh                                   defconfig    gcc-14
sh                    randconfig-1000-20261015    gcc-11.5.0
sh                    randconfig-1001-20261015    gcc-11.5.0
sh                    randconfig-2000-20261014    gcc-16.1.0
sh                    randconfig-2001-20261014    gcc-16.1.0
sh                         sh7763rdp_defconfig    gcc-16.1.0
sparc                              allnoconfig    clang-24
sparc                                defconfig    gcc-16.1.0
sparc                 randconfig-1000-20261015    gcc-8.5.0
sparc                 randconfig-1001-20261015    gcc-8.5.0
sparc                randconfig-r2110-20261014    gcc-8.5.0  cocci
sparc64                           allmodconfig    clang-20
sparc64                              defconfig    gcc-14
sparc64               randconfig-1000-20261015    gcc-8.5.0
sparc64               randconfig-1001-20261015    gcc-8.5.0
um                                allmodconfig    clang-17
um                                 allnoconfig    clang-24
um                                allyesconfig    gcc-16.1.0
um                                   defconfig    gcc-14
um                              i386_defconfig    gcc-14
um                    randconfig-1000-20261015    gcc-8.5.0
um                    randconfig-1001-20261015    gcc-8.5.0
um                            x86_64_defconfig    gcc-14
x86_64                             allnoconfig    clang-24
x86_64      buildonly-randconfig-1000-20261015    gcc-14
x86_64      buildonly-randconfig-1001-20261015    gcc-14
x86_64      buildonly-randconfig-1002-20261015    gcc-14
x86_64      buildonly-randconfig-1003-20261015    gcc-14
x86_64      buildonly-randconfig-1004-20261015    gcc-14
x86_64      buildonly-randconfig-1005-20261015    gcc-14
x86_64                               defconfig    gcc-14
x86_64                                   kexec    clang-22
x86_64                randconfig-1000-20261015    gcc-14
x86_64                randconfig-1001-20261015    gcc-14
x86_64                randconfig-1002-20261015    gcc-14
x86_64                randconfig-1003-20261015    gcc-14
x86_64                randconfig-1004-20261015    gcc-14
x86_64                randconfig-1005-20261015    gcc-14
x86_64                randconfig-1006-20261015    gcc-14
x86_64                randconfig-1007-20261015    gcc-14
x86_64                randconfig-1008-20261015    gcc-14
x86_64                randconfig-1009-20261015    gcc-14
x86_64                randconfig-1010-20261015    gcc-14
x86_64                randconfig-1011-20261015    gcc-14
x86_64                randconfig-1012-20261015    gcc-13
x86_64                randconfig-1013-20261015    gcc-13
x86_64                randconfig-1014-20261015    gcc-13
x86_64                randconfig-1015-20261015    gcc-13
x86_64                randconfig-1016-20261015    gcc-13
x86_64                randconfig-1017-20261015    gcc-13
x86_64                randconfig-2000-20261014    clang-22
x86_64                randconfig-2001-20261014    clang-22
x86_64               randconfig-r2109-20261014    gcc-11.5.0 cocci
x86_64                                rhel-9.4    clang-22
x86_64                            rhel-9.4-bpf    gcc-14
x86_64                           rhel-9.4-func    clang-22
x86_64                     rhel-9.4-kselftests    clang-22
x86_64                          rhel-9.4-kunit    gcc-14
x86_64                            rhel-9.4-ltp    gcc-14
x86_64                           rhel-9.4-rust    clang-22
xtensa                             allnoconfig    clang-24
xtensa                            allyesconfig    clang-20
xtensa                randconfig-1000-20261015    gcc-8.5.0
xtensa                randconfig-1001-20261015    gcc-8.5.0
xtensa               randconfig-r2100-20261014    gcc-11.5.0 cocci

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
