Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D03114831E
	for <linux-bluetooth@vger.kernel.org>; Fri,  4 Apr 2025 21:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743800587; cv=none; b=tNKgFYv5iZUN5BaD/5Cw5qzdcwdBxEBSqusdDXez7Wa/SmNHaYigu2lH9pzY2DqOo91vXLQ4v0tuNKBFJU8PCrRqjsxNIjWzrUhuqUaLibrrF6Maqc2sBh6i46xMOVJ+kJVJWsaw/NxFKXu1mYKnQK9VDA7X13tt8nsXlUqKtm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743800587; c=relaxed/simple;
	bh=uDX2u0BK3fCq7vaZjouzdbCGKkWzaISVB2+nZRQKiCs=;
	h=Date:From:To:Cc:Subject:Message-ID; b=DuuNPbWqqbL9frwoGLL39DXtgJSM7fs0qwbDdpWVSLA/11nn0gKblLdpxWgTwZwr7Rw8EMZRTR/FBeIxhw30d33kclbxoZsFa27CQFEF3n3O3lS3NxbeoiXvWA6PGLaJacrMG3gc4vhs5yDoxZzSFGGG/JHE2FjYHsthxlXZ9yQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gIzmjdYp; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gIzmjdYp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743800585; x=1775336585;
  h=date:from:to:cc:subject:message-id;
  bh=uDX2u0BK3fCq7vaZjouzdbCGKkWzaISVB2+nZRQKiCs=;
  b=gIzmjdYpYwcx7FmdPydeKPQ02zkildrSyBxd4+zRORfJoQ8NeHNTa96c
   zSt62RoqGrYyqTgjdBfluzR1QWRg8JCN4pn21C+OJE9ncH+s3ed5IDelp
   Sq1xTnvicET/IvNDvnWyJApDcSJo3CweJ2aPpC/XGgnroRuPL81SKNbDY
   5Q5+xoJVbOVbyv24nNR5rV4GsLTv34Py3e2co6keS9oyh7TgxWb1fjPGo
   o68cIc5sUBgsQqUf0mklSkOYhyAYwPF9xA6DlXUS5B8UjeyXFZXV+FJv5
   PDKtxqhiinecZ6ZEc3lnB4ZdfBVNJej/l3ED43Al4yPjBk7LhT4N2E6ic
   w==;
X-CSE-ConnectionGUID: St+xQN40TlSDiOjTOiMDpw==
X-CSE-MsgGUID: zDYu+HaJRO2HzmvYg7fDvQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11394"; a="44499578"
X-IronPort-AV: E=Sophos;i="6.15,189,1739865600"; 
   d="scan'208";a="44499578"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2025 14:03:04 -0700
X-CSE-ConnectionGUID: 5audLA0KRVWkhJGki7C8UA==
X-CSE-MsgGUID: aCBaUD92RXm6o/x+j1Z+Sg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,189,1739865600"; 
   d="scan'208";a="127391400"
Received: from lkp-server01.sh.intel.com (HELO b207828170a5) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 04 Apr 2025 14:03:04 -0700
Received: from kbuild by b207828170a5 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1u0oBp-0001Y4-1q;
	Fri, 04 Apr 2025 21:03:01 +0000
Date: Sat, 05 Apr 2025 05:02:54 +0800
From: kernel test robot <lkp@intel.com>
To: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 061e4972c48c032fb90927d468511d57210a65e4
Message-ID: <202504050544.gV3nCDO0-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: 061e4972c48c032fb90927d468511d57210a65e4  Bluetooth: btnxpuart: Add an error message if FW dump trigger fails

elapsed time: 1448m

configs tested: 120
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
arc                              allmodconfig    gcc-14.2.0
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    gcc-14.2.0
arc                   randconfig-001-20250404    gcc-14.2.0
arc                   randconfig-002-20250404    gcc-14.2.0
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-21
arm                              allyesconfig    gcc-14.2.0
arm                            hisi_defconfig    gcc-14.2.0
arm                           imxrt_defconfig    clang-21
arm                          pxa910_defconfig    gcc-14.2.0
arm                   randconfig-001-20250404    clang-21
arm                   randconfig-002-20250404    gcc-7.5.0
arm                   randconfig-003-20250404    clang-21
arm                   randconfig-004-20250404    clang-21
arm                        spear3xx_defconfig    clang-17
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20250404    gcc-5.5.0
arm64                 randconfig-002-20250404    gcc-7.5.0
arm64                 randconfig-003-20250404    gcc-9.5.0
arm64                 randconfig-004-20250404    clang-15
csky                              allnoconfig    gcc-14.2.0
csky                  randconfig-001-20250404    gcc-13.3.0
csky                  randconfig-002-20250404    gcc-11.5.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-21
hexagon               randconfig-001-20250404    clang-15
hexagon               randconfig-002-20250404    clang-21
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250404    gcc-12
i386        buildonly-randconfig-002-20250404    gcc-12
i386        buildonly-randconfig-003-20250404    gcc-12
i386        buildonly-randconfig-004-20250404    gcc-12
i386        buildonly-randconfig-005-20250404    gcc-12
i386        buildonly-randconfig-006-20250404    gcc-12
i386                                defconfig    clang-20
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20250404    gcc-14.2.0
loongarch             randconfig-002-20250404    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                        m5272c3_defconfig    gcc-14.2.0
m68k                        stmark2_defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
nios2                         10m50_defconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250404    gcc-5.5.0
nios2                 randconfig-002-20250404    gcc-11.5.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-14.2.0
openrisc                  or1klitex_defconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-14.2.0
parisc                randconfig-001-20250404    gcc-8.5.0
parisc                randconfig-002-20250404    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-21
powerpc                 linkstation_defconfig    clang-20
powerpc                     mpc83xx_defconfig    clang-21
powerpc                      pcm030_defconfig    clang-15
powerpc                     ppa8548_defconfig    gcc-14.2.0
powerpc               randconfig-001-20250404    gcc-5.5.0
powerpc               randconfig-002-20250404    gcc-9.3.0
powerpc               randconfig-003-20250404    clang-21
powerpc64             randconfig-001-20250404    gcc-10.5.0
powerpc64             randconfig-002-20250404    clang-21
powerpc64             randconfig-003-20250404    gcc-10.5.0
riscv                            allmodconfig    clang-21
riscv                             allnoconfig    gcc-14.2.0
riscv                 randconfig-001-20250404    gcc-14.2.0
riscv                 randconfig-002-20250404    clang-19
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-15
s390                             allyesconfig    gcc-14.2.0
s390                  randconfig-001-20250404    clang-15
s390                  randconfig-002-20250404    clang-17
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                    randconfig-001-20250404    gcc-5.5.0
sh                    randconfig-002-20250404    gcc-5.5.0
sh                           se7705_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250404    gcc-14.2.0
sparc                 randconfig-002-20250404    gcc-8.5.0
sparc64               randconfig-001-20250404    gcc-10.5.0
sparc64               randconfig-002-20250404    gcc-14.2.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    gcc-12
um                    randconfig-001-20250404    gcc-12
um                    randconfig-002-20250404    clang-21
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250404    clang-20
x86_64      buildonly-randconfig-002-20250404    clang-20
x86_64      buildonly-randconfig-003-20250404    clang-20
x86_64      buildonly-randconfig-004-20250404    gcc-12
x86_64      buildonly-randconfig-005-20250404    gcc-12
x86_64      buildonly-randconfig-006-20250404    gcc-12
x86_64                              defconfig    gcc-11
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250404    gcc-14.2.0
xtensa                randconfig-002-20250404    gcc-10.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
