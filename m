Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE8E7081A
	for <linux-bluetooth@vger.kernel.org>; Sun,  9 Aug 2026 03:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786246684; cv=none; b=KREjt4xLRlmcoBfchLER8mdfER533ptM93JER8iSnSun+LHo1dWeShousYyh0Q9ZoPkFPPugVI7KTDW6qt7KLzEp40gFwkbIRyTYzXvnxwBTtIAcg9WGVWOW4/taru/G7TmGduLevSTqxOsD16wPDMqxxdEmNdbwrfMBNxxQg5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786246684; c=relaxed/simple;
	bh=94CcX4vrTAzNl0SChOZ9JKRv21AxhsfNPQ8s5TEKM98=;
	h=Date:From:To:Cc:Subject:Message-ID; b=GFAdvWnB8hOvgvVySgTxAM/nqjw5i6JS94SrGaxjNHrBaKUDphL5MyUoGSAJZPYaSg9h1c2taMJEWgtu1Lgzrg5M8y+jZsqVN5i0AF7Y1OwKBpHpX31wKzak+PCFHmQpSEDPY+TTSRrVWpRk+O/y5HBixDdk9idly880IQK8iP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EKHxRuGy; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EKHxRuGy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786246682; x=1817782682;
  h=date:from:to:cc:subject:message-id;
  bh=94CcX4vrTAzNl0SChOZ9JKRv21AxhsfNPQ8s5TEKM98=;
  b=EKHxRuGydEH8Exq8ZG94SMjX88bmOYSEgSCi/xeQr6zr4X0neAq4rd6D
   a2lqXnTz3EyPQmzg1+qrspW6sFgbs9sy7B7USw0MXXhxxqruQLAfPUKqH
   8X5gyItU465lOz7F/ZSoYQIG6FV+PTI8TvcAM6EktJbkU2T6FG3RvffHj
   u/Z3Ijaw65jUW8Dcx8T/MeqCijiTPvTiZpHiojGAwmqO2zoBTLuTrUII9
   eMopz11K9rBh/M8F0OsmFBe1c4pAZiAC+KE6BV5LQJ4gj/kDqIP3xgE9d
   HZGcrG6L0btKH5pQLnFaNfZF9TLtPRP7vc3stI/ybGtemCJLu0P1rf36y
   g==;
X-CSE-ConnectionGUID: dMT9A6wST6qps9+eVP5RyA==
X-CSE-MsgGUID: MVFN4Ab2Q4Sdx/AGwVmy6g==
X-IronPort-AV: E=McAfee;i="6800,10657,11869"; a="90482307"
X-IronPort-AV: E=Sophos;i="6.25,213,1779174000"; 
   d="scan'208";a="90482307"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2026 20:38:02 -0700
X-CSE-ConnectionGUID: Bt7Oaw5WRFKKcTSMgPhY3Q==
X-CSE-MsgGUID: kBodSfzYTRedyMPBx7zAoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,213,1779174000"; 
   d="scan'208";a="258429107"
Received: from lkp-server01.sh.intel.com (HELO 6eda058d650d) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 08 Aug 2026 20:38:00 -0700
Received: from kbuild by 6eda058d650d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wsuMH-00000000LPx-3BYD;
	Sun, 09 Aug 2026 03:37:57 +0000
Date: Sun, 09 Aug 2026 11:37:46 +0800
From: kernel test robot <lkp@intel.com>
To: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 43a556b2fd43f2df6dded59c2e26560a27874c24
Message-ID: <202608091122.v9jdFAUc-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: 43a556b2fd43f2df6dded59c2e26560a27874c24  Bluetooth: RFCOMM: take rfcomm_mutex for the deferred setup accept

elapsed time: 1894m

configs tested: 149
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allnoconfig    gcc-16.1.0
alpha                           allyesconfig    gcc-16.1.0
alpha                              defconfig    gcc-16.1.0
arc                             allmodconfig    gcc-16.1.0
arc                             allyesconfig    gcc-16.1.0
arc                  randconfig-001-20260808    gcc-8.5.0
arc                  randconfig-001-20260809    gcc-12.5.0
arc                  randconfig-002-20260808    gcc-9.5.0
arc                  randconfig-002-20260809    gcc-12.5.0
arm                  randconfig-001-20260808    gcc-13.4.0
arm                  randconfig-001-20260809    gcc-12.5.0
arm                  randconfig-002-20260808    gcc-8.5.0
arm                  randconfig-002-20260809    gcc-12.5.0
arm                  randconfig-003-20260808    gcc-10.5.0
arm                  randconfig-003-20260809    gcc-12.5.0
arm                  randconfig-004-20260808    clang-24
arm                  randconfig-004-20260809    gcc-12.5.0
arm64                         randconfig-001    gcc-14.3.0
arm64                randconfig-001-20260808    gcc-15.2.0
arm64                randconfig-001-20260809    gcc-14.3.0
arm64                randconfig-002-20260808    clang-24
arm64                randconfig-002-20260809    gcc-14.3.0
arm64                randconfig-003-20260808    gcc-15.2.0
arm64                randconfig-003-20260809    gcc-14.3.0
arm64                randconfig-004-20260808    gcc-13.4.0
arm64                randconfig-004-20260809    gcc-14.3.0
csky                            allmodconfig    gcc-16.1.0
csky                 randconfig-001-20260808    gcc-16.1.0
csky                 randconfig-001-20260809    gcc-14.3.0
csky                 randconfig-002-20260808    gcc-11.5.0
csky                 randconfig-002-20260809    gcc-14.3.0
hexagon                       randconfig-001    gcc-12.5.0
hexagon              randconfig-001-20260809    clang-17
hexagon              randconfig-001-20260809    gcc-12.5.0
hexagon              randconfig-002-20260809    clang-17
hexagon              randconfig-002-20260809    gcc-12.5.0
i386                            allmodconfig    gcc-14
i386       buildonly-randconfig-001-20260809    clang-22
i386       buildonly-randconfig-002-20260809    clang-22
i386       buildonly-randconfig-003-20260809    clang-22
i386       buildonly-randconfig-004-20260809    clang-22
i386       buildonly-randconfig-004-20260809    gcc-14
i386       buildonly-randconfig-005-20260809    clang-22
i386       buildonly-randconfig-005-20260809    gcc-14
i386       buildonly-randconfig-006-20260809    clang-22
i386                 randconfig-001-20260809    clang-22
i386                 randconfig-002-20260809    clang-22
i386                 randconfig-003-20260809    clang-22
i386                 randconfig-004-20260809    clang-22
i386                 randconfig-005-20260809    clang-22
i386                 randconfig-006-20260809    clang-22
i386                 randconfig-007-20260809    clang-22
i386                 randconfig-011-20260809    clang-22
i386                 randconfig-011-20260809    gcc-14
i386                 randconfig-012-20260809    clang-22
i386                 randconfig-013-20260809    clang-22
i386                 randconfig-013-20260809    gcc-14
i386                 randconfig-014-20260809    clang-22
i386                 randconfig-014-20260809    gcc-14
i386                 randconfig-015-20260809    clang-22
i386                 randconfig-015-20260809    gcc-14
i386                 randconfig-016-20260809    clang-22
i386                 randconfig-017-20260809    clang-22
loongarch                          defconfig    clang-24
loongarch            randconfig-001-20260809    clang-18
loongarch            randconfig-001-20260809    gcc-12.5.0
loongarch            randconfig-002-20260809    gcc-12.5.0
nios2                           allmodconfig    gcc-11.5.0
nios2                            allnoconfig    gcc-11.5.0
nios2                randconfig-001-20260809    gcc-12.5.0
nios2                randconfig-001-20260809    gcc-8.5.0
nios2                randconfig-002-20260809    gcc-12.5.0
nios2                randconfig-002-20260809    gcc-8.5.0
parisc                          allmodconfig    gcc-16.1.0
parisc                          allyesconfig    gcc-16.1.0
parisc                             defconfig    gcc-16.1.0
parisc               randconfig-001-20260809    gcc-15.2.0
parisc               randconfig-001-20260809    gcc-8.5.0
parisc               randconfig-002-20260809    gcc-8.5.0
powerpc              randconfig-001-20260809    clang-24
powerpc              randconfig-001-20260809    gcc-8.5.0
powerpc              randconfig-002-20260809    clang-24
powerpc              randconfig-002-20260809    gcc-8.5.0
powerpc64            randconfig-001-20260809    clang-17
powerpc64            randconfig-001-20260809    gcc-8.5.0
powerpc64            randconfig-002-20260809    clang-24
powerpc64            randconfig-002-20260809    gcc-8.5.0
riscv                randconfig-001-20260809    clang-24
riscv                randconfig-002-20260809    clang-20
riscv                randconfig-002-20260809    clang-24
s390                 randconfig-001-20260809    clang-24
s390                 randconfig-001-20260809    gcc-11.5.0
s390                 randconfig-002-20260809    clang-24
sh                                 defconfig    gcc-16.1.0
sh                   randconfig-001-20260809    clang-24
sh                   randconfig-001-20260809    gcc-16.1.0
sh                   randconfig-002-20260809    clang-24
sh                   randconfig-002-20260809    gcc-10.5.0
sh                          se7206_defconfig    gcc-16.1.0
sparc                         randconfig-001    gcc-11.5.0
sparc                randconfig-001-20260809    gcc-11.5.0
sparc                randconfig-001-20260809    gcc-8.5.0
sparc                randconfig-002-20260809    gcc-11.5.0
sparc64              randconfig-001-20260809    gcc-11.5.0
sparc64              randconfig-001-20260809    gcc-9.5.0
sparc64              randconfig-002-20260809    clang-24
sparc64              randconfig-002-20260809    gcc-11.5.0
um                   randconfig-001-20260809    clang-18
um                   randconfig-001-20260809    gcc-11.5.0
um                   randconfig-002-20260809    clang-17
um                   randconfig-002-20260809    gcc-11.5.0
x86_64     buildonly-randconfig-001-20260809    clang-22
x86_64     buildonly-randconfig-002-20260809    clang-22
x86_64     buildonly-randconfig-002-20260809    gcc-14
x86_64     buildonly-randconfig-003-20260809    clang-22
x86_64     buildonly-randconfig-003-20260809    gcc-14
x86_64     buildonly-randconfig-004-20260809    clang-22
x86_64     buildonly-randconfig-005-20260809    clang-22
x86_64     buildonly-randconfig-006-20260809    clang-22
x86_64     buildonly-randconfig-006-20260809    gcc-14
x86_64                                 kexec    clang-22
x86_64               randconfig-001-20260808    clang-22
x86_64               randconfig-001-20260809    clang-22
x86_64               randconfig-002-20260808    gcc-14
x86_64               randconfig-002-20260809    clang-22
x86_64               randconfig-003-20260808    gcc-14
x86_64               randconfig-003-20260809    clang-22
x86_64               randconfig-004-20260808    clang-22
x86_64               randconfig-004-20260809    clang-22
x86_64               randconfig-005-20260808    clang-22
x86_64               randconfig-005-20260809    clang-22
x86_64               randconfig-006-20260808    clang-22
x86_64               randconfig-006-20260809    clang-22
x86_64               randconfig-011-20260809    gcc-14
x86_64               randconfig-012-20260809    gcc-14
x86_64               randconfig-013-20260809    gcc-14
x86_64               randconfig-014-20260809    gcc-14
x86_64               randconfig-015-20260809    gcc-14
x86_64               randconfig-016-20260809    gcc-14
x86_64               randconfig-071-20260809    clang-22
x86_64               randconfig-072-20260809    clang-22
x86_64               randconfig-073-20260809    clang-22
x86_64               randconfig-074-20260809    clang-22
x86_64               randconfig-075-20260809    clang-22
x86_64               randconfig-076-20260809    clang-22
x86_64                          rhel-9.4-bpf    gcc-14
xtensa               randconfig-001-20260809    gcc-11.5.0
xtensa               randconfig-001-20260809    gcc-13.4.0
xtensa               randconfig-002-20260809    gcc-11.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
