Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 516BE411699
	for <linux-bluetooth@vger.kernel.org>; Thu,  9 Jul 2026 16:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783614231; cv=none; b=BDyj9N06cxE3ddSsYEQf3ta8X5n5/l75CcLfZX3N9D9pIFq6jVw6Dip/t1DiLWa5azHz4qL94troJ8fwgazNpaoRAlxCUxwxLd/dJ9P+Uw9a10AXprjRs+7Yy+Te7yipiq3F4C7VSDy2jTnXE7tenqcH9iIv0LgDUFkGE8m2nNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783614231; c=relaxed/simple;
	bh=DpJhVN4txJ5+4ZNKeNWkRbg909xwC0z0IJzRTabLXhc=;
	h=Date:From:To:Cc:Subject:Message-ID; b=f0RFFaFcF+2HLxQNifsxSUI3u8boUFP4MRLRFZdlutsmOmn/IB+lJsxF/xupW+DgMRLS7waNJ2P6SLqYF4K/beYYJ2e02mJFhEwEXDS6wA62TIve7KLm0uIF2oXlr6UahN/4xubD4wBLesGuoop5uHTPWELMIyiNHdlWt40DM50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Rk1llYxS; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Rk1llYxS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783614229; x=1815150229;
  h=date:from:to:cc:subject:message-id;
  bh=DpJhVN4txJ5+4ZNKeNWkRbg909xwC0z0IJzRTabLXhc=;
  b=Rk1llYxSwse2sWrok/4gZukempOzRRAgSfB3GY28BEUvRi3/H5YkNAqo
   GtzhGLxVlg5uP9mRnNnDkACVYFQtnzMujNDdUKaR4MW+IbulLaJ3xWC6e
   K4lJE8nFSALkua0RwL3ib57e6DNQXTEUhnRnO6Jig2ClVC+Fq57M10Eu9
   uqj8KYpuCev4Q0XG9VSnv7iEwc8ZwFcc6KLfQhPhnbZDz9hOk8byVNB5d
   Jk4xeV8lgP6tF6VaoN0d69n/OnTqAwUkbdrYKNEfoMOOtY0fkbe+/zKVX
   1SuxZMyYc0cSaALL10vKX6fFOGpMVSRWebhMgFgrQvVR0bDEhNrHpzIAw
   Q==;
X-CSE-ConnectionGUID: BjydyPSrRjOF6FwKBkqySw==
X-CSE-MsgGUID: RyP+7etTSpCuGz59s3o4fA==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="107101198"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="107101198"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2026 09:23:48 -0700
X-CSE-ConnectionGUID: uK2SN+z3TCWZurb24jMCDQ==
X-CSE-MsgGUID: 1vqea6MmS+6DGDryYGxOmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="258243263"
Received: from lkp-server02.sh.intel.com (HELO ea128546eb3d) ([10.239.97.151])
  by orviesa003.jf.intel.com with ESMTP; 09 Jul 2026 09:23:47 -0700
Received: from kbuild by ea128546eb3d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1whrXJ-00000000Hsd-1FIg;
	Thu, 09 Jul 2026 16:23:43 +0000
Date: Fri, 10 Jul 2026 00:23:17 +0800
From: kernel test robot <lkp@intel.com>
To: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 ca75417ab1793f23b3ddc91869f0809b593d6954
Message-ID: <202607100006.fYoTfTBT-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: ca75417ab1793f23b3ddc91869f0809b593d6954  Bluetooth: btintel_pcie: split coredump worker into per-trigger works

elapsed time: 890m

configs tested: 274
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-16.1.0
alpha                            allyesconfig    gcc-16.1.0
alpha                               defconfig    gcc-16.1.0
arc                              allmodconfig    clang-23
arc                              allmodconfig    gcc-16.1.0
arc                               allnoconfig    gcc-16.1.0
arc                              allyesconfig    clang-23
arc                              allyesconfig    gcc-16.1.0
arc                                 defconfig    gcc-16.1.0
arc                   randconfig-001-20260709    gcc-8.5.0
arc                   randconfig-002-20260709    gcc-8.5.0
arm                               allnoconfig    clang-23
arm                               allnoconfig    gcc-16.1.0
arm                              allyesconfig    clang-23
arm                              allyesconfig    gcc-16.1.0
arm                                 defconfig    clang-23
arm                                 defconfig    gcc-16.1.0
arm                   randconfig-001-20260709    gcc-8.5.0
arm                   randconfig-002-20260709    gcc-8.5.0
arm                   randconfig-003-20260709    gcc-8.5.0
arm                   randconfig-004-20260709    gcc-8.5.0
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-16.1.0
arm64                               defconfig    gcc-16.1.0
arm64                 randconfig-001-20260709    clang-22
arm64                 randconfig-001-20260709    gcc-16.1.0
arm64                 randconfig-002-20260709    gcc-16.1.0
arm64                 randconfig-002-20260709    gcc-8.5.0
arm64                 randconfig-003-20260709    clang-22
arm64                 randconfig-003-20260709    gcc-16.1.0
arm64                 randconfig-004-20260709    gcc-16.1.0
arm64                 randconfig-004-20260709    gcc-8.5.0
csky                             allmodconfig    gcc-16.1.0
csky                              allnoconfig    gcc-16.1.0
csky                                defconfig    gcc-16.1.0
csky                  randconfig-001-20260709    gcc-14.3.0
csky                  randconfig-001-20260709    gcc-16.1.0
csky                  randconfig-002-20260709    gcc-16.1.0
hexagon                          allmodconfig    clang-23
hexagon                          allmodconfig    gcc-16.1.0
hexagon                           allnoconfig    clang-23
hexagon                           allnoconfig    gcc-16.1.0
hexagon                             defconfig    clang-23
hexagon                             defconfig    gcc-16.1.0
hexagon               randconfig-001-20260709    clang-18
hexagon               randconfig-002-20260709    clang-18
i386                             allmodconfig    clang-22
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-16.1.0
i386                             allyesconfig    clang-22
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260709    gcc-14
i386        buildonly-randconfig-002-20260709    gcc-14
i386        buildonly-randconfig-003-20260709    gcc-14
i386        buildonly-randconfig-004-20260709    gcc-14
i386        buildonly-randconfig-005-20260709    gcc-14
i386        buildonly-randconfig-006-20260709    gcc-14
i386                                defconfig    clang-22
i386                                defconfig    gcc-16.1.0
i386                  randconfig-001-20260709    clang-22
i386                  randconfig-001-20260709    gcc-14
i386                  randconfig-002-20260709    gcc-14
i386                  randconfig-003-20260709    clang-22
i386                  randconfig-003-20260709    gcc-14
i386                  randconfig-004-20260709    clang-22
i386                  randconfig-004-20260709    gcc-14
i386                  randconfig-005-20260709    gcc-14
i386                  randconfig-006-20260709    gcc-14
i386                  randconfig-007-20260709    clang-22
i386                  randconfig-007-20260709    gcc-14
i386                           randconfig-011    clang-22
i386                           randconfig-011    gcc-14
i386                  randconfig-011-20260709    clang-22
i386                  randconfig-011-20260709    gcc-14
i386                           randconfig-012    clang-22
i386                           randconfig-012    gcc-14
i386                  randconfig-012-20260709    gcc-14
i386                           randconfig-013    gcc-14
i386                  randconfig-013-20260709    clang-22
i386                  randconfig-013-20260709    gcc-14
i386                           randconfig-014    clang-22
i386                           randconfig-014    gcc-14
i386                  randconfig-014-20260709    gcc-14
i386                           randconfig-015    gcc-14
i386                  randconfig-015-20260709    clang-22
i386                  randconfig-015-20260709    gcc-14
i386                           randconfig-016    gcc-14
i386                  randconfig-016-20260709    clang-22
i386                  randconfig-016-20260709    gcc-14
i386                           randconfig-017    gcc-14
i386                  randconfig-017-20260709    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    clang-20
loongarch                         allnoconfig    gcc-16.1.0
loongarch                           defconfig    clang-23
loongarch             randconfig-001-20260709    clang-18
loongarch             randconfig-002-20260709    clang-18
m68k                             allmodconfig    gcc-16.1.0
m68k                              allnoconfig    gcc-16.1.0
m68k                             allyesconfig    clang-23
m68k                             allyesconfig    gcc-16.1.0
m68k                                defconfig    clang-23
m68k                      m54418evb_defconfig    gcc-16.1.0
microblaze                        allnoconfig    gcc-16.1.0
microblaze                       allyesconfig    gcc-16.1.0
microblaze                          defconfig    clang-23
mips                             allmodconfig    gcc-16.1.0
mips                              allnoconfig    gcc-16.1.0
mips                             allyesconfig    gcc-16.1.0
mips                      malta_kvm_defconfig    gcc-16.1.0
nios2                            allmodconfig    clang-20
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    clang-23
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-23
nios2                 randconfig-001-20260709    clang-18
nios2                 randconfig-002-20260709    clang-18
openrisc                         allmodconfig    clang-20
openrisc                         allmodconfig    gcc-16.1.0
openrisc                          allnoconfig    clang-23
openrisc                          allnoconfig    gcc-16.1.0
openrisc                            defconfig    gcc-16.1.0
parisc                           allmodconfig    gcc-16.1.0
parisc                            allnoconfig    clang-23
parisc                            allnoconfig    gcc-16.1.0
parisc                           allyesconfig    clang-17
parisc                           allyesconfig    gcc-16.1.0
parisc                              defconfig    gcc-16.1.0
parisc                         randconfig-001    gcc-8.5.0
parisc                randconfig-001-20260709    clang-23
parisc                randconfig-001-20260709    gcc-9.5.0
parisc                         randconfig-002    gcc-12.5.0
parisc                randconfig-002-20260709    clang-23
parisc                randconfig-002-20260709    gcc-8.5.0
parisc64                            defconfig    clang-23
powerpc                          allmodconfig    gcc-16.1.0
powerpc                           allnoconfig    clang-23
powerpc                           allnoconfig    gcc-16.1.0
powerpc                   microwatt_defconfig    gcc-16.1.0
powerpc                        randconfig-001    gcc-10.5.0
powerpc               randconfig-001-20260709    clang-23
powerpc               randconfig-001-20260709    gcc-14.3.0
powerpc                        randconfig-002    gcc-8.5.0
powerpc               randconfig-002-20260709    clang-23
powerpc64                      randconfig-001    clang-16
powerpc64             randconfig-001-20260709    clang-19
powerpc64             randconfig-001-20260709    clang-23
powerpc64                      randconfig-002    clang-23
powerpc64             randconfig-002-20260709    clang-23
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                             allnoconfig    gcc-16.1.0
riscv                            allyesconfig    clang-23
riscv                               defconfig    gcc-16.1.0
riscv                          randconfig-001    clang-22
riscv                 randconfig-001-20260709    clang-22
riscv                          randconfig-002    clang-22
riscv                 randconfig-002-20260709    clang-22
s390                             allmodconfig    clang-17
s390                             allmodconfig    clang-23
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-16.1.0
s390                                defconfig    gcc-16.1.0
s390                           randconfig-001    clang-22
s390                  randconfig-001-20260709    clang-22
s390                           randconfig-002    clang-22
s390                  randconfig-002-20260709    clang-22
sh                               allmodconfig    gcc-16.1.0
sh                                allnoconfig    clang-23
sh                                allnoconfig    gcc-16.1.0
sh                               allyesconfig    clang-17
sh                               allyesconfig    gcc-16.1.0
sh                                  defconfig    gcc-14
sh                             randconfig-001    clang-22
sh                    randconfig-001-20260709    clang-22
sh                             randconfig-002    clang-22
sh                    randconfig-002-20260709    clang-22
sparc                             allnoconfig    clang-23
sparc                             allnoconfig    gcc-16.1.0
sparc                               defconfig    gcc-16.1.0
sparc                 randconfig-001-20260709    gcc-8.5.0
sparc                 randconfig-002-20260709    gcc-8.5.0
sparc64                          allmodconfig    clang-20
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260709    gcc-8.5.0
sparc64               randconfig-002-20260709    gcc-8.5.0
um                               allmodconfig    clang-17
um                               allmodconfig    clang-23
um                                allnoconfig    clang-16
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-14
um                               allyesconfig    gcc-16.1.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260709    gcc-8.5.0
um                    randconfig-002-20260709    gcc-8.5.0
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-22
x86_64                            allnoconfig    clang-22
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-22
x86_64               buildonly-randconfig-001    clang-22
x86_64      buildonly-randconfig-001-20260709    clang-22
x86_64      buildonly-randconfig-001-20260709    gcc-13
x86_64               buildonly-randconfig-002    clang-22
x86_64      buildonly-randconfig-002-20260709    clang-22
x86_64      buildonly-randconfig-002-20260709    gcc-14
x86_64               buildonly-randconfig-003    clang-22
x86_64      buildonly-randconfig-003-20260709    clang-22
x86_64               buildonly-randconfig-004    clang-22
x86_64      buildonly-randconfig-004-20260709    clang-22
x86_64      buildonly-randconfig-004-20260709    gcc-14
x86_64               buildonly-randconfig-005    clang-22
x86_64      buildonly-randconfig-005-20260709    clang-22
x86_64               buildonly-randconfig-006    clang-22
x86_64      buildonly-randconfig-006-20260709    clang-22
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-22
x86_64                         randconfig-001    clang-22
x86_64                randconfig-001-20260709    clang-22
x86_64                randconfig-001-20260709    gcc-14
x86_64                         randconfig-002    clang-22
x86_64                randconfig-002-20260709    clang-22
x86_64                randconfig-002-20260709    gcc-14
x86_64                         randconfig-003    clang-22
x86_64                randconfig-003-20260709    clang-22
x86_64                randconfig-003-20260709    gcc-14
x86_64                         randconfig-004    clang-22
x86_64                randconfig-004-20260709    clang-22
x86_64                randconfig-004-20260709    gcc-14
x86_64                         randconfig-005    clang-22
x86_64                randconfig-005-20260709    clang-22
x86_64                randconfig-005-20260709    gcc-14
x86_64                         randconfig-006    clang-22
x86_64                randconfig-006-20260709    clang-22
x86_64                randconfig-006-20260709    gcc-14
x86_64                         randconfig-011    gcc-14
x86_64                randconfig-011-20260709    gcc-14
x86_64                         randconfig-012    gcc-14
x86_64                randconfig-012-20260709    gcc-14
x86_64                         randconfig-013    gcc-14
x86_64                randconfig-013-20260709    gcc-14
x86_64                         randconfig-014    gcc-14
x86_64                randconfig-014-20260709    gcc-14
x86_64                         randconfig-015    gcc-14
x86_64                randconfig-015-20260709    gcc-14
x86_64                         randconfig-016    gcc-14
x86_64                randconfig-016-20260709    gcc-14
x86_64                         randconfig-071    clang-22
x86_64                randconfig-071-20260709    clang-22
x86_64                         randconfig-072    clang-22
x86_64                randconfig-072-20260709    clang-22
x86_64                         randconfig-073    clang-22
x86_64                randconfig-073-20260709    clang-22
x86_64                         randconfig-074    clang-22
x86_64                randconfig-074-20260709    clang-22
x86_64                         randconfig-075    clang-22
x86_64                randconfig-075-20260709    clang-22
x86_64                         randconfig-076    clang-22
x86_64                randconfig-076-20260709    clang-22
x86_64                               rhel-9.4    clang-22
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-22
x86_64                    rhel-9.4-kselftests    clang-22
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-22
xtensa                            allnoconfig    clang-23
xtensa                            allnoconfig    gcc-16.1.0
xtensa                           allyesconfig    clang-20
xtensa                randconfig-001-20260709    gcc-8.5.0
xtensa                randconfig-002-20260709    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
