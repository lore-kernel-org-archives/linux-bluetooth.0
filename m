Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D4EA2367C2
	for <linux-bluetooth@vger.kernel.org>; Fri, 11 Apr 2025 17:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744393602; cv=none; b=obvYp16uhkb/C5Uj2LBtci8VEwBqlpijlJ1T1kWXkpZ4X8MEZE8jSyKeIp4A6YpbaAN2I0TM+yO40cTGFQbbRQLWL/02GcBcQEfUCuCucn4WtwDpkZQMD5M3WIIDgePjuBw65oD8CqSCty6TZhPEfChaKwrDBdc4F8qTwIJDLa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744393602; c=relaxed/simple;
	bh=+6RzmtnvKCZc5pH37Hx8IH/GA98yyr3m5CmSlCnwniM=;
	h=Date:From:To:Cc:Subject:Message-ID; b=jseJEhE274M1+KtazReaWPaRIx6HBYm/v343VEeeIvPIuuGy13R4uBWylUyAmAsoNS8wm5xicaJEcAUwQJpMrUM+nfGap/Hl49qkWOA37xHrZ1CmzXbF046t4KnhXZSYJRp5mKeZrw6SgT5UL5lRnucqKkVRmhff4y6o0U5c6gU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OcBG4eF/; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OcBG4eF/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744393600; x=1775929600;
  h=date:from:to:cc:subject:message-id;
  bh=+6RzmtnvKCZc5pH37Hx8IH/GA98yyr3m5CmSlCnwniM=;
  b=OcBG4eF/oKCOKtCEcWAQBhdsbQbb7iRBRXeINiGFFh5s+j0gH/Bnd17G
   Q432Llaq5cgVOZ6jGW3AlY6KoKHz/IRsGwqJrjx5htMhX/YTJpDtf5inz
   wMwgBQRtvwY20u8ToBmDK4lFDztPbetwtwMkWo8zikmUa4I/RmTCgUKCm
   yGIEcd2z46hzUfAl73e6NRvD+1gv44OQQ+YQiiciUwWJd6fOb7dManoqt
   CKZ+F0sNLpiHJh4R1dbckDJoxSgpjuWEfXpDjO/WmvUi0q82RNOV1SwiK
   QRemAJXu1abMpXApnszXyZisz/gW+aSzvRlKEYoj6+MNa8EKEQhISpm6U
   w==;
X-CSE-ConnectionGUID: V5ILde/bRL+FrBURzvXn5Q==
X-CSE-MsgGUID: PNEqF8NzTW6DmM6ZPGdQtQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11401"; a="46083319"
X-IronPort-AV: E=Sophos;i="6.15,205,1739865600"; 
   d="scan'208";a="46083319"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2025 10:46:39 -0700
X-CSE-ConnectionGUID: m0OIjFNgQvWxSclk50Y9bg==
X-CSE-MsgGUID: e4b3JQOcRyeGN3qH4yoJ+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,205,1739865600"; 
   d="scan'208";a="134120937"
Received: from lkp-server01.sh.intel.com (HELO b207828170a5) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 11 Apr 2025 10:46:38 -0700
Received: from kbuild by b207828170a5 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1u3ISa-000BHm-1P;
	Fri, 11 Apr 2025 17:46:36 +0000
Date: Sat, 12 Apr 2025 01:46:35 +0800
From: kernel test robot <lkp@intel.com>
To: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 50c1241e6a8a89deec03f5186df5824abf45e080
Message-ID: <202504120129.FTPFgPXn-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: 50c1241e6a8a89deec03f5186df5824abf45e080  Bluetooth: l2cap: Check encryption key size on incoming connection

elapsed time: 1453m

configs tested: 94
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
arc                               allnoconfig    gcc-14.2.0
arc                      axs103_smp_defconfig    gcc-14.2.0
arc                   randconfig-001-20250411    gcc-14.2.0
arc                   randconfig-002-20250411    gcc-14.2.0
arm                               allnoconfig    clang-21
arm                      jornada720_defconfig    clang-21
arm                        multi_v5_defconfig    gcc-14.2.0
arm                   randconfig-001-20250411    clang-21
arm                   randconfig-002-20250411    clang-21
arm                   randconfig-003-20250411    gcc-6.5.0
arm                   randconfig-004-20250411    gcc-6.5.0
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20250411    gcc-9.5.0
arm64                 randconfig-002-20250411    gcc-9.5.0
arm64                 randconfig-003-20250411    clang-21
arm64                 randconfig-004-20250411    clang-21
csky                  randconfig-001-20250411    gcc-14.2.0
csky                  randconfig-002-20250411    gcc-9.3.0
hexagon                          allmodconfig    clang-17
hexagon                          allyesconfig    clang-21
hexagon               randconfig-001-20250411    clang-21
hexagon               randconfig-002-20250411    clang-21
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250411    gcc-12
i386        buildonly-randconfig-002-20250411    gcc-12
i386        buildonly-randconfig-003-20250411    gcc-12
i386        buildonly-randconfig-004-20250411    clang-20
i386        buildonly-randconfig-005-20250411    gcc-11
i386        buildonly-randconfig-006-20250411    gcc-12
i386                                defconfig    clang-20
loongarch                        allmodconfig    gcc-14.2.0
loongarch             randconfig-001-20250411    gcc-14.2.0
loongarch             randconfig-002-20250411    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                       bvme6000_defconfig    gcc-14.2.0
m68k                        m5307c3_defconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250411    gcc-9.3.0
nios2                 randconfig-002-20250411    gcc-7.5.0
openrisc                          allnoconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                randconfig-001-20250411    gcc-14.2.0
parisc                randconfig-002-20250411    gcc-8.5.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc               randconfig-001-20250411    gcc-9.3.0
powerpc               randconfig-002-20250411    clang-21
powerpc               randconfig-003-20250411    clang-21
powerpc64             randconfig-001-20250411    gcc-5.5.0
powerpc64             randconfig-002-20250411    gcc-5.5.0
powerpc64             randconfig-003-20250411    clang-21
riscv                             allnoconfig    gcc-14.2.0
riscv                 randconfig-001-20250411    gcc-9.3.0
riscv                 randconfig-002-20250411    gcc-9.3.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-14.2.0
s390                  randconfig-001-20250411    clang-19
s390                  randconfig-002-20250411    gcc-8.5.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                    randconfig-001-20250411    gcc-11.5.0
sh                    randconfig-002-20250411    gcc-5.5.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250411    gcc-10.3.0
sparc                 randconfig-002-20250411    gcc-14.2.0
sparc64               randconfig-001-20250411    gcc-8.5.0
sparc64               randconfig-002-20250411    gcc-8.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    gcc-12
um                    randconfig-001-20250411    clang-17
um                    randconfig-002-20250411    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250411    gcc-11
x86_64      buildonly-randconfig-002-20250411    gcc-11
x86_64      buildonly-randconfig-003-20250411    clang-20
x86_64      buildonly-randconfig-004-20250411    gcc-12
x86_64      buildonly-randconfig-005-20250411    clang-20
x86_64      buildonly-randconfig-006-20250411    gcc-12
x86_64                              defconfig    gcc-11
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250411    gcc-12.4.0
xtensa                randconfig-002-20250411    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
