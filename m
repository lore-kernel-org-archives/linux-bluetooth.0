Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A402D3732
	for <linux-bluetooth@vger.kernel.org>; Wed,  2 Jul 2025 15:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751469272; cv=none; b=e8oMqxn0Dj7K/x8P25Hl2v7/ANGK4XicP/3nt9gsn69NRrEkHQ194ZNVMN5HeJQIP/rqN3SVn05oFa3hbDwtfAaGfnQrjva+lPavdNN0mWLr6ctHyunwgAqxTe5olD8a8+in4/Yr9qLiXYEBNQnJlHgOuc8Lf7xtPz49yxg6iJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751469272; c=relaxed/simple;
	bh=kQ7LfFxe7/wKVUa4jlFCDQQIYxIafor1EuJb5Z5RlO8=;
	h=Date:From:To:Cc:Subject:Message-ID; b=KvEwa5awXv0HCzp5w19+PfYvagV3j2gYRsLSlbd8zgIvM2Nl3y8UDlxcfmcCfJwNCP3zSguNykVwT35SJc1BR6uTh1vinZYMAZpXdidIPqe3Ul32ncsKPHZ6suN/3NZ+RIgPT6F46dAC2qLdBbWYpkH//rkYwR19xXGuIXLC6Iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hnczlDIw; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hnczlDIw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751469270; x=1783005270;
  h=date:from:to:cc:subject:message-id;
  bh=kQ7LfFxe7/wKVUa4jlFCDQQIYxIafor1EuJb5Z5RlO8=;
  b=hnczlDIwsUgVz9C0EsbG1EIc5aDHf3MzWMwF6eRLxuf642GfPcAGKHcG
   A8xqrDZcwLdLN00cPO08JskfvnazQRN7syeHtJjL6D042y6IAvLENpRpN
   ayydbpOT2oLQF6ekyxJeDb3N1FMMdOU6JAH23L40KfFsfBU/5X1YvK+L3
   xfBoxRBhlF/JUFAVv1z2BkzDO1ffY3eg4rdFuFJcD6bVrsK6pGuZr/kGG
   vbZahjlopdQKx4C/AAtRrY4ZwucveWWqIVkCU3FSUXv11ck1le8k2SST4
   WeAvIj5uxMz4ovi5csxIuNWZoSMyAomoLAO4oidtw/9lLstofCgK9F3Yj
   A==;
X-CSE-ConnectionGUID: Him5YumaQ0m1XFPJMW5Ipg==
X-CSE-MsgGUID: 1VLuBhIhRJmAZBtVXayEVg==
X-IronPort-AV: E=McAfee;i="6800,10657,11482"; a="64470080"
X-IronPort-AV: E=Sophos;i="6.16,281,1744095600"; 
   d="scan'208";a="64470080"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2025 08:14:29 -0700
X-CSE-ConnectionGUID: BUTXTszXSySylDkuKV1NMA==
X-CSE-MsgGUID: MiNk3Cu+RPaO3ltWqJTe2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,281,1744095600"; 
   d="scan'208";a="154252256"
Received: from lkp-server01.sh.intel.com (HELO 0b2900756c14) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 02 Jul 2025 08:14:29 -0700
Received: from kbuild by 0b2900756c14 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uWzAI-0000mV-0y;
	Wed, 02 Jul 2025 15:14:26 +0000
Date: Wed, 02 Jul 2025 23:13:33 +0800
From: kernel test robot <lkp@intel.com>
To: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 3bc46213b81278f3a9df0324768e152de71eb9fe
Message-ID: <202507022321.LlBQ8Yrs-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: 3bc46213b81278f3a9df0324768e152de71eb9fe  Bluetooth: Fix spelling mistakes

elapsed time: 1444m

configs tested: 121
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            alldefconfig    gcc-15.1.0
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    gcc-15.1.0
arc                   randconfig-001-20250702    gcc-10.5.0
arc                   randconfig-002-20250702    gcc-14.3.0
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-21
arm                              allyesconfig    gcc-15.1.0
arm                          pxa3xx_defconfig    clang-21
arm                   randconfig-001-20250702    clang-17
arm                   randconfig-002-20250702    clang-19
arm                   randconfig-003-20250702    clang-21
arm                   randconfig-004-20250702    clang-17
arm                           tegra_defconfig    gcc-15.1.0
arm                         vf610m4_defconfig    gcc-15.1.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20250702    clang-21
arm64                 randconfig-002-20250702    clang-21
arm64                 randconfig-003-20250702    clang-21
arm64                 randconfig-004-20250702    clang-21
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20250702    gcc-15.1.0
csky                  randconfig-002-20250702    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-21
hexagon               randconfig-001-20250702    clang-21
hexagon               randconfig-002-20250702    clang-21
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250702    clang-20
i386        buildonly-randconfig-002-20250702    gcc-12
i386        buildonly-randconfig-003-20250702    clang-20
i386        buildonly-randconfig-004-20250702    clang-20
i386        buildonly-randconfig-005-20250702    gcc-12
i386        buildonly-randconfig-006-20250702    clang-20
i386                                defconfig    clang-20
loongarch                        allmodconfig    gcc-15.1.0
loongarch                         allnoconfig    gcc-15.1.0
loongarch             randconfig-001-20250702    gcc-15.1.0
loongarch             randconfig-002-20250702    gcc-15.1.0
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
m68k                        m5307c3_defconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                           gcw0_defconfig    clang-21
mips                            gpr_defconfig    clang-18
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250702    gcc-14.2.0
nios2                 randconfig-002-20250702    gcc-14.2.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250702    gcc-12.4.0
parisc                randconfig-002-20250702    gcc-9.3.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-21
powerpc               randconfig-001-20250702    gcc-11.5.0
powerpc               randconfig-002-20250702    gcc-11.5.0
powerpc               randconfig-003-20250702    clang-21
powerpc                     sequoia_defconfig    clang-17
powerpc                     tqm8540_defconfig    gcc-15.1.0
powerpc64             randconfig-001-20250702    clang-21
powerpc64             randconfig-002-20250702    clang-19
powerpc64             randconfig-003-20250702    clang-21
riscv                            allmodconfig    clang-21
riscv                             allnoconfig    gcc-15.1.0
riscv                    nommu_virt_defconfig    clang-21
riscv                 randconfig-001-20250702    clang-21
riscv                 randconfig-002-20250702    clang-21
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-15.1.0
s390                  randconfig-001-20250702    gcc-10.5.0
s390                  randconfig-002-20250702    clang-21
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                             espt_defconfig    gcc-15.1.0
sh                    randconfig-001-20250702    gcc-15.1.0
sh                    randconfig-002-20250702    gcc-5.5.0
sh                            titan_defconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                 randconfig-001-20250702    gcc-12.4.0
sparc                 randconfig-002-20250702    gcc-15.1.0
sparc64               randconfig-001-20250702    gcc-9.3.0
sparc64               randconfig-002-20250702    gcc-11.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    gcc-12
um                    randconfig-001-20250702    clang-21
um                    randconfig-002-20250702    clang-21
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250702    gcc-12
x86_64      buildonly-randconfig-002-20250702    gcc-11
x86_64      buildonly-randconfig-003-20250702    clang-20
x86_64      buildonly-randconfig-004-20250702    clang-20
x86_64      buildonly-randconfig-005-20250702    clang-20
x86_64      buildonly-randconfig-006-20250702    gcc-12
x86_64                              defconfig    gcc-11
x86_64                          rhel-9.4-rust    clang-18
xtensa                            allnoconfig    gcc-15.1.0
xtensa                  nommu_kc705_defconfig    gcc-15.1.0
xtensa                randconfig-001-20250702    gcc-14.3.0
xtensa                randconfig-002-20250702    gcc-12.4.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
