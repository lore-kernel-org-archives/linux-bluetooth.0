Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 689C21E3DF2
	for <linux-bluetooth@vger.kernel.org>; Thu, 24 Oct 2024 15:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729784105; cv=none; b=FB6X2ydBFWccp/mislTXV2czbeUfq024HrkZvOMBMahmB7WADpuG6pmIjUhAx+PmX6Q4tp0VxZmOaV3/y2XM17j0JASLyFApegxeX9mSAntuiszvOdN2+RD6haZfUca59gd6v8MPMBo7M0if3A8DZ88RRCwKzsItCDcP71hBCP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729784105; c=relaxed/simple;
	bh=Q55yZgPu06QqRHVEm5pP0geMAakT7GAQpy2uChOCqZQ=;
	h=Date:From:To:Cc:Subject:Message-ID; b=X5tta/cTSIoRpllIWMqdCoGnfhjVmmqPv61rq0VHKRaC7BS4CjjH5feqP8Eq0okfBiiFN/D8QBKpbvbLLfincv5sHJFXy5+9PE1VTKs/jXw7FJ8jwYMDxIHgadqbcy73JqmV1x/x9jSP72GVF6GEvdwtSvc0QjNZ7v03w8c6cSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=azZA8+06; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="azZA8+06"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729784103; x=1761320103;
  h=date:from:to:cc:subject:message-id;
  bh=Q55yZgPu06QqRHVEm5pP0geMAakT7GAQpy2uChOCqZQ=;
  b=azZA8+06dKEdBGc2m9S0u/Tq2g9dldRhLmBxUenHHcvwAPsW2l8iVrhO
   7dJunjCClYiOcnSCb4dwTaILFY2JXOuNO/hvWWvpiIGtO7VuvuMv4aiE6
   QuJDh/np9uTlEBmJqrOiVfFc+0bW6mix3ivnNq8LEzbSG9XtcR+05ugGy
   ALytaDFjFdMrI452WzPq1LxhR/O0uxrMHSmhEW9p+wLRy+2om6dhlUdQV
   Jih0FpMGam+wcnQCQ8cL8a90xhMXBOHLUliWu8L6j1TYzE9J+eAbdXc9X
   +e2qGt38yBmj7so/udeqMCO6NMn6j1iRqa9vDKgue6nxrR/XBeNJxogRz
   A==;
X-CSE-ConnectionGUID: 151H4F/KRwGh462GAp3JMw==
X-CSE-MsgGUID: /pJ+vhjpSOWDUHGPF7NjRQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11235"; a="17049454"
X-IronPort-AV: E=Sophos;i="6.11,229,1725346800"; 
   d="scan'208";a="17049454"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 08:35:02 -0700
X-CSE-ConnectionGUID: 7/OA81oDSIm5e/5KF/Sixw==
X-CSE-MsgGUID: yoQWuljERSyYXK39vMuPyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,229,1725346800"; 
   d="scan'208";a="80805678"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 24 Oct 2024 08:35:01 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t3zrX-000Wb5-1g;
	Thu, 24 Oct 2024 15:34:59 +0000
Date: Thu, 24 Oct 2024 23:34:27 +0800
From: kernel test robot <lkp@intel.com>
To: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 fb4560832d4c91d73680538d6659ac2c024ec9d5
Message-ID: <202410242320.yQdO5plj-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: fb4560832d4c91d73680538d6659ac2c024ec9d5  Bluetooth: ISO: Fix UAF on iso_sock_timeout

elapsed time: 1531m

configs tested: 129
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.1.0
alpha                               defconfig    gcc-14.1.0
arc                              allmodconfig    clang-20
arc                               allnoconfig    gcc-14.1.0
arc                              allyesconfig    clang-20
arc                                 defconfig    gcc-14.1.0
arc                    vdk_hs38_smp_defconfig    gcc-14.1.0
arm                              allmodconfig    clang-20
arm                               allnoconfig    gcc-14.1.0
arm                              allyesconfig    clang-20
arm                                 defconfig    gcc-14.1.0
arm                          ixp4xx_defconfig    gcc-14.1.0
arm                           omap1_defconfig    gcc-14.1.0
arm                        spear3xx_defconfig    gcc-14.1.0
arm                           stm32_defconfig    gcc-14.1.0
arm64                            allmodconfig    clang-20
arm64                             allnoconfig    gcc-14.1.0
arm64                               defconfig    gcc-14.1.0
csky                             alldefconfig    gcc-14.1.0
csky                              allnoconfig    gcc-14.1.0
csky                                defconfig    gcc-14.1.0
hexagon                           allnoconfig    gcc-14.1.0
hexagon                             defconfig    gcc-14.1.0
i386                             allmodconfig    clang-18
i386                             allmodconfig    clang-19
i386                              allnoconfig    clang-18
i386                              allnoconfig    clang-19
i386                             allyesconfig    clang-18
i386                             allyesconfig    clang-19
i386        buildonly-randconfig-001-20241024    clang-19
i386        buildonly-randconfig-002-20241024    clang-19
i386        buildonly-randconfig-003-20241024    clang-19
i386        buildonly-randconfig-004-20241024    clang-19
i386        buildonly-randconfig-005-20241024    clang-19
i386        buildonly-randconfig-006-20241024    clang-19
i386                                defconfig    clang-18
i386                                defconfig    clang-19
i386                  randconfig-001-20241024    clang-19
i386                  randconfig-002-20241024    clang-19
i386                  randconfig-003-20241024    clang-19
i386                  randconfig-004-20241024    clang-19
i386                  randconfig-005-20241024    clang-19
i386                  randconfig-006-20241024    clang-19
i386                  randconfig-011-20241024    clang-19
i386                  randconfig-012-20241024    clang-19
i386                  randconfig-013-20241024    clang-19
i386                  randconfig-014-20241024    clang-19
i386                  randconfig-015-20241024    clang-19
i386                  randconfig-016-20241024    clang-19
loongarch                        allmodconfig    gcc-14.1.0
loongarch                         allnoconfig    gcc-14.1.0
loongarch                           defconfig    gcc-14.1.0
m68k                             allmodconfig    gcc-14.1.0
m68k                              allnoconfig    gcc-14.1.0
m68k                             allyesconfig    gcc-14.1.0
m68k                                defconfig    gcc-14.1.0
m68k                        m5272c3_defconfig    gcc-14.1.0
m68k                       m5275evb_defconfig    gcc-14.1.0
m68k                           virt_defconfig    gcc-14.1.0
microblaze                       allmodconfig    gcc-14.1.0
microblaze                        allnoconfig    gcc-14.1.0
microblaze                       allyesconfig    gcc-14.1.0
microblaze                          defconfig    gcc-14.1.0
mips                              allnoconfig    gcc-14.1.0
mips                          eyeq5_defconfig    gcc-14.1.0
nios2                             allnoconfig    gcc-14.1.0
nios2                               defconfig    gcc-14.1.0
openrisc                          allnoconfig    clang-20
openrisc                         allyesconfig    gcc-14.1.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-14.1.0
parisc                            allnoconfig    clang-20
parisc                           allyesconfig    gcc-14.1.0
parisc                              defconfig    gcc-12
parisc64                         alldefconfig    gcc-14.1.0
parisc64                            defconfig    gcc-14.1.0
powerpc                     akebono_defconfig    gcc-14.1.0
powerpc                          allmodconfig    gcc-14.1.0
powerpc                           allnoconfig    clang-20
powerpc                          allyesconfig    gcc-14.1.0
powerpc                       ebony_defconfig    gcc-14.1.0
powerpc                      ep88xc_defconfig    gcc-14.1.0
powerpc                      mgcoge_defconfig    gcc-14.1.0
powerpc               mpc834x_itxgp_defconfig    gcc-14.1.0
powerpc                     tqm8540_defconfig    gcc-14.1.0
powerpc                     tqm8548_defconfig    gcc-14.1.0
riscv                            allmodconfig    gcc-14.1.0
riscv                             allnoconfig    clang-20
riscv                            allyesconfig    gcc-14.1.0
riscv                               defconfig    gcc-12
riscv                    nommu_k210_defconfig    gcc-14.1.0
s390                             allmodconfig    gcc-14.1.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.1.0
s390                                defconfig    gcc-12
sh                               allmodconfig    gcc-14.1.0
sh                                allnoconfig    gcc-14.1.0
sh                               allyesconfig    gcc-14.1.0
sh                        apsh4ad0a_defconfig    gcc-14.1.0
sh                                  defconfig    gcc-12
sh                ecovec24-romimage_defconfig    gcc-14.1.0
sh                        edosk7760_defconfig    gcc-14.1.0
sh                      rts7751r2d1_defconfig    gcc-14.1.0
sh                           se7712_defconfig    gcc-14.1.0
sh                           se7750_defconfig    gcc-14.1.0
sh                           se7751_defconfig    gcc-14.1.0
sh                   sh7724_generic_defconfig    gcc-14.1.0
sh                             shx3_defconfig    gcc-14.1.0
sparc                            allmodconfig    gcc-14.1.0
sparc64                             defconfig    gcc-12
um                                allnoconfig    clang-20
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-18
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-18
x86_64                           allyesconfig    clang-19
x86_64                              defconfig    clang-18
x86_64                              defconfig    clang-19
x86_64                                  kexec    clang-18
x86_64                                  kexec    gcc-12
x86_64                               rhel-8.3    gcc-12
x86_64                           rhel-8.3-bpf    clang-19
x86_64                         rhel-8.3-kunit    clang-19
x86_64                           rhel-8.3-ltp    clang-19
x86_64                          rhel-8.3-rust    clang-19
xtensa                            allnoconfig    gcc-14.1.0
xtensa                  cadence_csp_defconfig    gcc-14.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
