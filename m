Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FD2738655F
	for <linux-bluetooth@vger.kernel.org>; Fri, 17 Apr 2026 09:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776419254; cv=none; b=LjA8f8p0YHFUgrj6LTz2NMPKXlGpS4JXTskYlKpWyW4Ekv2hF+XRXyb5pMYdOTUc5BD86oDIcxxyDgGl2Hml3cbGGrYGYY032UAkYXfrAUBWB0o3+tCO7sEcO+AxGHpTynNwfrM7WxKosLv/QFkFr2w5UpZqCii1P/fEc7mV0pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776419254; c=relaxed/simple;
	bh=cn+e7kbd5Wwu3dSxZGujqw6zgbIIRxsNVmAFriOPY/0=;
	h=Date:From:To:Cc:Subject:Message-ID; b=KGHTgZsYCie5C2a8Az56LKmecOANZXzt7Qtr2VD2Yt3d5J/IXr7uV+bkBIQv7bT67rMHnADGsQGAbRecLW6w6UJt5cB/ug92lNVcP73HryBJiskcEcj2y0uyFu+0niiixfJ4yczuoJLpmL28asDrFLECKuoVHhRAjkQ/UryMBPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PCC1jdbF; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PCC1jdbF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776419253; x=1807955253;
  h=date:from:to:cc:subject:message-id;
  bh=cn+e7kbd5Wwu3dSxZGujqw6zgbIIRxsNVmAFriOPY/0=;
  b=PCC1jdbFy9rz8qTbZBlOXlUaFouL47puopo7h7k6/t1Z0ExB5hwoV4aM
   WDXMTIdJ65s0PnCI74jCHebF8LREcdI4XtzVXgc9IAcoCO8YiGSM9QQre
   jNYbBHpLRUFGqnkKEIhQCsN1p5DXjxjOyCYBgIJ8v43FUzriyjtfTlebW
   paEI9bwYMFCgODrRqg5DDSxmSIkC+DuuUey/mZaSS+gXw65NgxD5OL4Fz
   vczabFk6q7wyrF5gcuscJQ96/zrEXTriexJg7OlTmh3B2StVTCV3QhOO+
   6LePFaG1erySHl6QBzNpt4dUg3/c+LhvTwsm0IXWkPqSLMV1GJh649ZMe
   w==;
X-CSE-ConnectionGUID: P6/6rWKEQu68+6Nk6rOZ+g==
X-CSE-MsgGUID: OMFI8G0qTyOJjQS0XPaEEw==
X-IronPort-AV: E=McAfee;i="6800,10657,11761"; a="100080788"
X-IronPort-AV: E=Sophos;i="6.23,184,1770624000"; 
   d="scan'208";a="100080788"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2026 02:47:28 -0700
X-CSE-ConnectionGUID: iJXSlpVETZSCl44sAy9QZw==
X-CSE-MsgGUID: zC3QZxIKSOeAoqYpZ+2iqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,184,1770624000"; 
   d="scan'208";a="226313876"
Received: from lkp-server01.sh.intel.com (HELO 7e48d0ff8e22) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 17 Apr 2026 02:47:25 -0700
Received: from kbuild by 7e48d0ff8e22 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wDfnH-000000000Bp-2FV0;
	Fri, 17 Apr 2026 09:47:23 +0000
Date: Fri, 17 Apr 2026 17:46:54 +0800
From: kernel test robot <lkp@intel.com>
To: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 b57b0f27cb05c5a9dac9eeb2cb2798a4c189a685
Message-ID: <202604171746.cWs3AVMg-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: b57b0f27cb05c5a9dac9eeb2cb2798a4c189a685  Bluetooth: btmtk: add event filter to filter specific event

elapsed time: 731m

configs tested: 160
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
alpha                               defconfig    gcc-15.2.0
arc                              allmodconfig    gcc-15.2.0
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    gcc-15.2.0
arc                                 defconfig    gcc-15.2.0
arc                   randconfig-001-20260417    gcc-8.5.0
arc                   randconfig-002-20260417    gcc-8.5.0
arm                               allnoconfig    clang-23
arm                              allyesconfig    gcc-15.2.0
arm                                 defconfig    clang-23
arm                   randconfig-001-20260417    gcc-10.5.0
arm                   randconfig-002-20260417    clang-23
arm                   randconfig-003-20260417    clang-23
arm                   randconfig-004-20260417    clang-23
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260417    clang-19
arm64                 randconfig-002-20260417    clang-23
arm64                 randconfig-003-20260417    clang-23
arm64                 randconfig-004-20260417    gcc-15.2.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260417    gcc-13.4.0
csky                  randconfig-002-20260417    gcc-14.3.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-23
hexagon               randconfig-001-20260417    clang-23
hexagon               randconfig-002-20260417    clang-23
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260417    clang-20
i386        buildonly-randconfig-002-20260417    clang-20
i386        buildonly-randconfig-003-20260417    clang-20
i386        buildonly-randconfig-004-20260417    clang-20
i386        buildonly-randconfig-005-20260417    gcc-14
i386        buildonly-randconfig-006-20260417    clang-20
i386                                defconfig    clang-20
i386                  randconfig-001-20260417    clang-20
i386                  randconfig-002-20260417    clang-20
i386                  randconfig-003-20260417    clang-20
i386                  randconfig-004-20260417    clang-20
i386                  randconfig-005-20260417    gcc-14
i386                  randconfig-006-20260417    clang-20
i386                  randconfig-007-20260417    clang-20
i386                  randconfig-011-20260417    gcc-14
i386                  randconfig-012-20260417    gcc-14
i386                  randconfig-013-20260417    clang-20
i386                  randconfig-014-20260417    gcc-14
i386                  randconfig-015-20260417    gcc-14
i386                  randconfig-016-20260417    clang-20
i386                  randconfig-017-20260417    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-23
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260417    clang-18
loongarch             randconfig-002-20260417    clang-23
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    gcc-15.2.0
m68k                                defconfig    gcc-15.2.0
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    gcc-15.2.0
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20260417    gcc-11.5.0
nios2                 randconfig-002-20260417    gcc-8.5.0
openrisc                         allmodconfig    gcc-15.2.0
openrisc                          allnoconfig    gcc-15.2.0
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    gcc-15.2.0
parisc                           allyesconfig    gcc-15.2.0
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260417    gcc-12.5.0
parisc                randconfig-002-20260417    gcc-8.5.0
parisc64                            defconfig    gcc-15.2.0
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    gcc-15.2.0
powerpc               randconfig-001-20260417    gcc-8.5.0
powerpc               randconfig-002-20260417    clang-23
powerpc64             randconfig-001-20260417    clang-23
powerpc64             randconfig-002-20260417    clang-23
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-23
riscv                 randconfig-001-20260417    clang-23
riscv                 randconfig-002-20260417    clang-19
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    clang-23
s390                  randconfig-001-20260417    gcc-14.3.0
s390                  randconfig-002-20260417    clang-23
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    gcc-15.2.0
sh                                  defconfig    gcc-15.2.0
sh                    randconfig-001-20260417    gcc-15.2.0
sh                    randconfig-002-20260417    gcc-15.2.0
sh                             shx3_defconfig    gcc-15.2.0
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260417    gcc-12.5.0
sparc                 randconfig-002-20260417    gcc-8.5.0
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20260417    clang-20
sparc64               randconfig-002-20260417    clang-23
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-14
um                                  defconfig    clang-23
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260417    gcc-13
um                    randconfig-002-20260417    clang-23
um                           x86_64_defconfig    clang-23
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260417    clang-20
x86_64      buildonly-randconfig-002-20260417    clang-20
x86_64      buildonly-randconfig-003-20260417    clang-20
x86_64      buildonly-randconfig-004-20260417    clang-20
x86_64      buildonly-randconfig-005-20260417    clang-20
x86_64      buildonly-randconfig-006-20260417    gcc-14
x86_64                              defconfig    gcc-14
x86_64                randconfig-001-20260417    gcc-14
x86_64                randconfig-002-20260417    clang-20
x86_64                randconfig-003-20260417    gcc-14
x86_64                randconfig-004-20260417    gcc-12
x86_64                randconfig-005-20260417    clang-20
x86_64                randconfig-006-20260417    clang-20
x86_64                randconfig-011-20260417    gcc-14
x86_64                randconfig-012-20260417    clang-20
x86_64                randconfig-013-20260417    clang-20
x86_64                randconfig-014-20260417    clang-20
x86_64                randconfig-015-20260417    clang-20
x86_64                randconfig-016-20260417    gcc-14
x86_64                randconfig-071-20260417    gcc-14
x86_64                randconfig-072-20260417    gcc-14
x86_64                randconfig-073-20260417    clang-20
x86_64                randconfig-074-20260417    clang-20
x86_64                randconfig-075-20260417    clang-20
x86_64                randconfig-076-20260417    clang-20
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.2.0
xtensa                           allyesconfig    gcc-15.2.0
xtensa                randconfig-001-20260417    gcc-9.5.0
xtensa                randconfig-002-20260417    gcc-9.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
