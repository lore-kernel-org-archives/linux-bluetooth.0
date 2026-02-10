Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E54833CEA2
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Feb 2026 08:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770711936; cv=none; b=bq68byxW4VytmcmadR9Gu5boN1kNNqCXwK+DvX2vRWuLPx9Oms1p4ioiIubFpIqO6Q9nY+SEA5grt025Wvqldb/rmLmduoyu2VuLp+0f0a4Kv0bcyWlFnkfLbyf0So70MT0yEYGMJ9F41mZPw2vkXbtN+w94rrbHoATgazUZjis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770711936; c=relaxed/simple;
	bh=UCfkox28+PrOlJGygBhSzFcIr4PzNrZ9VD0l2gJ1BlQ=;
	h=Date:From:To:Cc:Subject:Message-ID; b=YKI2zap5WudElxnzoUf2zyTHGoHK6qRVUSQ2q+4Hs4IzlZy1jOYTUMwddl79+L1UJHoAPaMTEm3oEpxJHY1MOuYXXSnsU9iw10czeATgJpeG7wI2ZehXo2YPXO7uNAwIx729OudueJTFM9cJtlWGgmxQ8lHB1/yWK/j79PRn364=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B8rfWygG; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B8rfWygG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770711934; x=1802247934;
  h=date:from:to:cc:subject:message-id;
  bh=UCfkox28+PrOlJGygBhSzFcIr4PzNrZ9VD0l2gJ1BlQ=;
  b=B8rfWygGHUDXkXudOH2gCo1v1xIGNpOvnf6SE/6gjPYR1ZUiYcOXSgzy
   tVrYlIxQQgnw8v9aopny/7k/GCcdNOyU10FREJxmjGwtWFK3m0hV8+sZv
   LXomLGn0oIMscTllyoL1uilGCwT+xwVZoHHmMdG0/opR4jmVM+tweSP9q
   BuZJ9WkCKc21JpPRP74GuITKQPbqYr4F1FyG+bvi1XuAN6+bP1+3xQJrw
   4YcmM/+DnHQMt7X7Qb/39UcvkYTrQRHLgRrfA8jxXOXlr8PJwJqKTut0V
   YcSvcM9x++CGP6Qh/AZ222/EwrlUk1E8xJ4P26vY+RXdF7RigB94G+gcr
   w==;
X-CSE-ConnectionGUID: HiM6vxOkQGe3havfryOevg==
X-CSE-MsgGUID: x1M3vJ0mRDSkEFdetefYXw==
X-IronPort-AV: E=McAfee;i="6800,10657,11696"; a="75679884"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; 
   d="scan'208";a="75679884"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2026 00:25:32 -0800
X-CSE-ConnectionGUID: Em2bDC3rS1yLkMvvFUwfug==
X-CSE-MsgGUID: dH0t4KfnR1qTA5MEcfHjSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; 
   d="scan'208";a="211883577"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 10 Feb 2026 00:25:31 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vpj3o-00000000ooK-135j;
	Tue, 10 Feb 2026 08:25:28 +0000
Date: Tue, 10 Feb 2026 16:24:55 +0800
From: kernel test robot <lkp@intel.com>
To: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 ac0c6f1b6a58466bfd0c3d499332e5b04b574eab
Message-ID: <202602101647.5icl9Mu4-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: ac0c6f1b6a58466bfd0c3d499332e5b04b574eab  Bluetooth: mgmt: Fix heap overflow in mgmt_mesh_add

elapsed time: 727m

configs tested: 262
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
alpha                               defconfig    gcc-15.2.0
arc                              allmodconfig    clang-16
arc                              allmodconfig    gcc-15.2.0
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    clang-22
arc                              allyesconfig    gcc-15.2.0
arc                          axs101_defconfig    gcc-11.5.0
arc                                 defconfig    gcc-15.2.0
arc                        nsim_700_defconfig    clang-22
arc                        nsimosci_defconfig    gcc-15.2.0
arc                   randconfig-001-20260210    clang-20
arc                   randconfig-002-20260210    clang-20
arm                               allnoconfig    clang-22
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                              allyesconfig    gcc-15.2.0
arm                                 defconfig    clang-22
arm                                 defconfig    gcc-15.2.0
arm                       imx_v4_v5_defconfig    gcc-15.2.0
arm                       multi_v4t_defconfig    gcc-11.5.0
arm                          pxa168_defconfig    clang-22
arm                            qcom_defconfig    clang-22
arm                   randconfig-001-20260210    clang-20
arm                   randconfig-002-20260210    clang-20
arm                   randconfig-003-20260210    clang-20
arm                   randconfig-004-20260210    clang-20
arm                         s5pv210_defconfig    gcc-11.5.0
arm                           sama5_defconfig    clang-22
arm                       versatile_defconfig    clang-22
arm64                            allmodconfig    clang-19
arm64                            allmodconfig    clang-22
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260210    clang-22
arm64                 randconfig-002-20260210    clang-22
arm64                 randconfig-003-20260210    clang-22
arm64                 randconfig-004-20260210    clang-22
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    clang-22
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260210    clang-22
csky                  randconfig-001-20260210    gcc-14.3.0
csky                  randconfig-002-20260210    clang-22
csky                  randconfig-002-20260210    gcc-9.5.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    clang-22
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    clang-22
hexagon                             defconfig    gcc-15.2.0
hexagon               randconfig-001-20260210    clang-22
hexagon               randconfig-002-20260210    clang-22
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260210    clang-20
i386        buildonly-randconfig-002-20260210    clang-20
i386        buildonly-randconfig-002-20260210    gcc-14
i386        buildonly-randconfig-003-20260210    clang-20
i386        buildonly-randconfig-003-20260210    gcc-14
i386        buildonly-randconfig-004-20260210    clang-20
i386        buildonly-randconfig-005-20260210    clang-20
i386        buildonly-randconfig-006-20260210    clang-20
i386                                defconfig    clang-20
i386                                defconfig    gcc-15.2.0
i386                  randconfig-001-20260210    gcc-14
i386                  randconfig-002-20260210    gcc-14
i386                  randconfig-003-20260210    gcc-14
i386                  randconfig-004-20260210    gcc-14
i386                  randconfig-005-20260210    gcc-14
i386                  randconfig-006-20260210    gcc-14
i386                  randconfig-007-20260210    gcc-14
i386                  randconfig-011-20260210    gcc-14
i386                  randconfig-012-20260210    gcc-14
i386                  randconfig-013-20260210    gcc-14
i386                  randconfig-014-20260210    gcc-14
i386                  randconfig-015-20260210    gcc-14
i386                  randconfig-016-20260210    gcc-14
i386                  randconfig-017-20260210    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                        allmodconfig    clang-22
loongarch                         allnoconfig    clang-22
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch                loongson32_defconfig    clang-22
loongarch                loongson32_defconfig    gcc-11.5.0
loongarch             randconfig-001-20260210    clang-22
loongarch             randconfig-002-20260210    clang-22
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    clang-16
m68k                             allyesconfig    gcc-15.2.0
m68k                          atari_defconfig    clang-22
m68k                                defconfig    clang-19
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    clang-19
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
mips                          ath79_defconfig    gcc-15.2.0
mips                     cu1000-neo_defconfig    gcc-15.2.0
mips                          eyeq6_defconfig    gcc-15.2.0
mips                           gcw0_defconfig    clang-22
mips                           ip30_defconfig    clang-22
nios2                            alldefconfig    gcc-11.5.0
nios2                            allmodconfig    clang-22
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    clang-22
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-19
nios2                 randconfig-001-20260210    clang-22
nios2                 randconfig-002-20260210    clang-22
openrisc                         allmodconfig    clang-22
openrisc                         allmodconfig    gcc-15.2.0
openrisc                          allnoconfig    clang-22
openrisc                          allnoconfig    gcc-15.2.0
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    clang-22
parisc                            allnoconfig    gcc-15.2.0
parisc                           allyesconfig    clang-19
parisc                           allyesconfig    gcc-15.2.0
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260210    clang-19
parisc                randconfig-002-20260210    clang-19
parisc64                            defconfig    clang-19
powerpc                     akebono_defconfig    gcc-11.5.0
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-22
powerpc                           allnoconfig    gcc-15.2.0
powerpc                  iss476-smp_defconfig    clang-22
powerpc                     kmeter1_defconfig    gcc-15.2.0
powerpc                     ksi8560_defconfig    gcc-15.2.0
powerpc                 mpc832x_rdb_defconfig    clang-22
powerpc                 mpc832x_rdb_defconfig    gcc-15.2.0
powerpc                  mpc885_ads_defconfig    gcc-15.2.0
powerpc               randconfig-001-20260210    clang-19
powerpc               randconfig-002-20260210    clang-19
powerpc                     taishan_defconfig    clang-22
powerpc                     tqm8555_defconfig    gcc-15.2.0
powerpc                        warp_defconfig    clang-22
powerpc64             randconfig-001-20260210    clang-19
powerpc64             randconfig-002-20260210    clang-19
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    clang-22
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-22
riscv                               defconfig    gcc-15.2.0
riscv             nommu_k210_sdcard_defconfig    clang-22
riscv                 randconfig-001-20260210    gcc-10.5.0
riscv                 randconfig-001-20260210    gcc-11.5.0
riscv                 randconfig-002-20260210    gcc-11.5.0
riscv                 randconfig-002-20260210    gcc-8.5.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    clang-22
s390                                defconfig    gcc-15.2.0
s390                  randconfig-001-20260210    gcc-11.5.0
s390                  randconfig-002-20260210    clang-22
s390                  randconfig-002-20260210    gcc-11.5.0
sh                               alldefconfig    gcc-15.2.0
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-22
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    clang-19
sh                               allyesconfig    gcc-15.2.0
sh                                  defconfig    gcc-14
sh                             espt_defconfig    gcc-15.2.0
sh                    randconfig-001-20260210    gcc-11.5.0
sh                    randconfig-001-20260210    gcc-14.3.0
sh                    randconfig-002-20260210    gcc-11.5.0
sh                    randconfig-002-20260210    gcc-15.2.0
sh                          rsk7203_defconfig    gcc-15.2.0
sh                           se7750_defconfig    gcc-15.2.0
sparc                             allnoconfig    clang-22
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260210    gcc-14.3.0
sparc                 randconfig-001-20260210    gcc-15.2.0
sparc                 randconfig-002-20260210    gcc-14.3.0
sparc                 randconfig-002-20260210    gcc-15.2.0
sparc64                          allmodconfig    clang-22
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260210    gcc-11.5.0
sparc64               randconfig-001-20260210    gcc-14.3.0
sparc64               randconfig-002-20260210    clang-22
sparc64               randconfig-002-20260210    gcc-14.3.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-14
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260210    clang-19
um                    randconfig-001-20260210    gcc-14.3.0
um                    randconfig-002-20260210    gcc-14
um                    randconfig-002-20260210    gcc-14.3.0
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                            allnoconfig    clang-22
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260210    clang-20
x86_64      buildonly-randconfig-001-20260210    gcc-14
x86_64      buildonly-randconfig-002-20260210    clang-20
x86_64      buildonly-randconfig-002-20260210    gcc-14
x86_64      buildonly-randconfig-003-20260210    clang-20
x86_64      buildonly-randconfig-003-20260210    gcc-14
x86_64      buildonly-randconfig-004-20260210    gcc-14
x86_64      buildonly-randconfig-005-20260210    clang-20
x86_64      buildonly-randconfig-005-20260210    gcc-14
x86_64      buildonly-randconfig-006-20260210    gcc-14
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260210    gcc-14
x86_64                randconfig-002-20260210    gcc-14
x86_64                randconfig-003-20260210    gcc-14
x86_64                randconfig-004-20260210    gcc-14
x86_64                randconfig-005-20260210    gcc-14
x86_64                randconfig-006-20260210    gcc-14
x86_64                randconfig-011-20260210    clang-20
x86_64                randconfig-012-20260210    clang-20
x86_64                randconfig-013-20260210    clang-20
x86_64                randconfig-014-20260210    clang-20
x86_64                randconfig-015-20260210    clang-20
x86_64                randconfig-016-20260210    clang-20
x86_64                randconfig-016-20260210    gcc-13
x86_64                randconfig-071-20260210    clang-20
x86_64                randconfig-071-20260210    gcc-14
x86_64                randconfig-072-20260210    clang-20
x86_64                randconfig-073-20260210    clang-20
x86_64                randconfig-073-20260210    gcc-14
x86_64                randconfig-074-20260210    clang-20
x86_64                randconfig-075-20260210    clang-20
x86_64                randconfig-075-20260210    gcc-14
x86_64                randconfig-076-20260210    clang-20
x86_64                randconfig-076-20260210    gcc-14
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    clang-22
xtensa                            allnoconfig    gcc-15.2.0
xtensa                           allyesconfig    clang-22
xtensa                           allyesconfig    gcc-15.2.0
xtensa                  cadence_csp_defconfig    clang-22
xtensa                randconfig-001-20260210    gcc-14.3.0
xtensa                randconfig-001-20260210    gcc-8.5.0
xtensa                randconfig-002-20260210    gcc-14.3.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
