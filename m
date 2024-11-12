Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD6DB1BF58
	for <linux-bluetooth@vger.kernel.org>; Tue, 12 Nov 2024 07:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731396597; cv=none; b=LGRC8VX1IQTVtOWRa1WuVgUXwfYBH0Y82FvZjuXiUwJq9QnfLpEXVo2LHhgHIN+XfdanjFhTiDhD3vdKDdA/FjmYaQeXkqyxnEgPlaQsb+rmkCQPguVKkq7HeWZu0DVMKuVIhb4g3BzRxpQ76Nw38ycIDayKpU9WBpCjPjyev5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731396597; c=relaxed/simple;
	bh=iZpDqr/Ilq4m9s5NRUYODB6TcS9AVL6deRs0TDmSFq8=;
	h=Date:From:To:Cc:Subject:Message-ID; b=CdyjJDT7pR5mB4fTj6MbbTaS2MZ4dYxlFpDc8kAXJpKkYxP6MWGCVEjJpxeQoAqPabSTk/A2Ic4Vs9+HqlNHV0RLUtvSrhze3gPZU/XBNgiGIh0UiLJ6D5dPoVjLWKUzjFrABJQwSJuroWuWkzFg1QEVqSbPCR4U4C6g6R+xb5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RzyAVSJj; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RzyAVSJj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731396596; x=1762932596;
  h=date:from:to:cc:subject:message-id;
  bh=iZpDqr/Ilq4m9s5NRUYODB6TcS9AVL6deRs0TDmSFq8=;
  b=RzyAVSJjVNPRw7SGCLXqitS60f4gjWbZ5+9hSJuilffWl8WnlVlaW8D9
   5PY/cAJwAJ8A+3MDWG23FRRcVxrBE6LESnfILho2dgxdGOPOq+NzcW0tR
   jm3nbbRlDs2urmWhnJnFK21wKhE0uvaTnM2wDHZ4vSP7fDWA2CCFQzHbr
   XRfVfKSSpIMj8aeUh+MGQHYYC32d74h9J0YFxTJmy4aifqrbtSqgORwBl
   MGaykM3dnni2WfXkA0bSw/u9XF765YiCk8n9ETD3SRHM6gltsnTee8Zaw
   xdZj8UWf22ybzBCWo4OhmD2aRLbiAB500Y0kK6eLlPmMa0rk0u0aJyWoP
   Q==;
X-CSE-ConnectionGUID: 45y9G28/S5SBRrJhyJuKsA==
X-CSE-MsgGUID: WK53z5ZLRuau5iN92TB7wQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11253"; a="31089381"
X-IronPort-AV: E=Sophos;i="6.12,147,1728975600"; 
   d="scan'208";a="31089381"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2024 23:29:55 -0800
X-CSE-ConnectionGUID: yrUIM0UfQKq9qLEPJ4brKA==
X-CSE-MsgGUID: j7uVVTOASiGwq1frrvxYzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,147,1728975600"; 
   d="scan'208";a="92077966"
Received: from lkp-server01.sh.intel.com (HELO bcfed0da017c) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 11 Nov 2024 23:29:54 -0800
Received: from kbuild by bcfed0da017c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tAlLT-0000aL-2g;
	Tue, 12 Nov 2024 07:29:51 +0000
Date: Tue, 12 Nov 2024 15:29:16 +0800
From: kernel test robot <lkp@intel.com>
To: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 42e8e5c1092b3dea67bb0dc0cf5cbbbff3ea01c4
Message-ID: <202411121505.NlLdDajb-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: 42e8e5c1092b3dea67bb0dc0cf5cbbbff3ea01c4  Bluetooth: hci_bcm: Use the devm_clk_get_optional() helper

elapsed time: 891m

configs tested: 178
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    clang-20
alpha                               defconfig    gcc-14.2.0
arc                              allmodconfig    clang-20
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    clang-20
arc                          axs101_defconfig    clang-20
arc                                 defconfig    gcc-14.2.0
arc                   randconfig-001-20241112    gcc-14.2.0
arc                   randconfig-002-20241112    gcc-14.2.0
arm                              allmodconfig    clang-20
arm                               allnoconfig    gcc-14.2.0
arm                              allyesconfig    clang-20
arm                                 defconfig    gcc-14.2.0
arm                            dove_defconfig    clang-20
arm                      jornada720_defconfig    clang-20
arm                   randconfig-001-20241112    gcc-14.2.0
arm                   randconfig-002-20241112    gcc-14.2.0
arm                   randconfig-003-20241112    gcc-14.2.0
arm                   randconfig-004-20241112    gcc-14.2.0
arm64                            allmodconfig    clang-20
arm64                             allnoconfig    gcc-14.2.0
arm64                               defconfig    gcc-14.2.0
arm64                 randconfig-001-20241112    gcc-14.2.0
arm64                 randconfig-002-20241112    gcc-14.2.0
arm64                 randconfig-003-20241112    gcc-14.2.0
arm64                 randconfig-004-20241112    gcc-14.2.0
csky                             alldefconfig    clang-20
csky                              allnoconfig    gcc-14.2.0
csky                                defconfig    gcc-14.2.0
csky                  randconfig-001-20241112    gcc-14.2.0
csky                  randconfig-002-20241112    gcc-14.2.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    gcc-14.2.0
hexagon                          allyesconfig    clang-20
hexagon                             defconfig    gcc-14.2.0
hexagon               randconfig-001-20241112    gcc-14.2.0
hexagon               randconfig-002-20241112    gcc-14.2.0
i386                             allmodconfig    clang-19
i386                              allnoconfig    clang-19
i386                             allyesconfig    clang-19
i386        buildonly-randconfig-001-20241112    clang-19
i386        buildonly-randconfig-002-20241112    clang-19
i386        buildonly-randconfig-003-20241112    clang-19
i386        buildonly-randconfig-004-20241112    clang-19
i386        buildonly-randconfig-005-20241112    clang-19
i386        buildonly-randconfig-006-20241112    clang-19
i386                                defconfig    clang-19
i386                  randconfig-001-20241112    clang-19
i386                  randconfig-002-20241112    clang-19
i386                  randconfig-003-20241112    clang-19
i386                  randconfig-004-20241112    clang-19
i386                  randconfig-005-20241112    clang-19
i386                  randconfig-006-20241112    clang-19
i386                  randconfig-011-20241112    clang-19
i386                  randconfig-012-20241112    clang-19
i386                  randconfig-013-20241112    clang-19
i386                  randconfig-014-20241112    clang-19
i386                  randconfig-015-20241112    clang-19
i386                  randconfig-016-20241112    clang-19
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch                           defconfig    gcc-14.2.0
loongarch             randconfig-001-20241112    gcc-14.2.0
loongarch             randconfig-002-20241112    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                          amiga_defconfig    clang-20
m68k                                defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
microblaze                          defconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                           ip22_defconfig    clang-20
mips                        qi_lb60_defconfig    clang-20
nios2                             allnoconfig    gcc-14.2.0
nios2                               defconfig    gcc-14.2.0
nios2                 randconfig-001-20241112    gcc-14.2.0
nios2                 randconfig-002-20241112    gcc-14.2.0
openrisc                          allnoconfig    clang-20
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    clang-20
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-12
parisc                randconfig-001-20241112    gcc-14.2.0
parisc                randconfig-002-20241112    gcc-14.2.0
parisc64                            defconfig    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    clang-20
powerpc                          allyesconfig    clang-20
powerpc                          allyesconfig    gcc-14.2.0
powerpc                     asp8347_defconfig    clang-20
powerpc               mpc834x_itxgp_defconfig    clang-20
powerpc                 mpc836x_rdk_defconfig    clang-20
powerpc                     mpc83xx_defconfig    clang-20
powerpc                       ppc64_defconfig    clang-20
powerpc               randconfig-001-20241112    gcc-14.2.0
powerpc               randconfig-002-20241112    gcc-14.2.0
powerpc               randconfig-003-20241112    gcc-14.2.0
powerpc                     sequoia_defconfig    clang-20
powerpc64             randconfig-001-20241112    gcc-14.2.0
powerpc64             randconfig-002-20241112    gcc-14.2.0
powerpc64             randconfig-003-20241112    gcc-14.2.0
riscv                            allmodconfig    clang-20
riscv                            allmodconfig    gcc-14.2.0
riscv                             allnoconfig    clang-20
riscv                            allyesconfig    clang-20
riscv                            allyesconfig    gcc-14.2.0
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20241112    gcc-14.2.0
riscv                 randconfig-002-20241112    gcc-14.2.0
s390                             allmodconfig    gcc-14.2.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20241112    gcc-14.2.0
s390                  randconfig-002-20241112    gcc-14.2.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-12
sh                ecovec24-romimage_defconfig    clang-20
sh                          polaris_defconfig    clang-20
sh                    randconfig-001-20241112    gcc-14.2.0
sh                    randconfig-002-20241112    gcc-14.2.0
sh                           se7343_defconfig    clang-20
sparc                            allmodconfig    gcc-14.2.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20241112    gcc-14.2.0
sparc64               randconfig-002-20241112    gcc-14.2.0
um                               allmodconfig    clang-20
um                                allnoconfig    clang-20
um                               allyesconfig    clang-20
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20241112    gcc-14.2.0
um                    randconfig-002-20241112    gcc-14.2.0
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20241112    gcc-12
x86_64      buildonly-randconfig-002-20241112    gcc-12
x86_64      buildonly-randconfig-003-20241112    gcc-12
x86_64      buildonly-randconfig-004-20241112    gcc-12
x86_64      buildonly-randconfig-005-20241112    gcc-12
x86_64      buildonly-randconfig-006-20241112    gcc-12
x86_64                              defconfig    clang-19
x86_64                                  kexec    gcc-12
x86_64                randconfig-001-20241112    gcc-12
x86_64                randconfig-002-20241112    gcc-12
x86_64                randconfig-003-20241112    gcc-12
x86_64                randconfig-004-20241112    gcc-12
x86_64                randconfig-005-20241112    gcc-12
x86_64                randconfig-006-20241112    gcc-12
x86_64                randconfig-011-20241112    gcc-12
x86_64                randconfig-012-20241112    gcc-12
x86_64                randconfig-013-20241112    gcc-12
x86_64                randconfig-014-20241112    gcc-12
x86_64                randconfig-015-20241112    gcc-12
x86_64                randconfig-016-20241112    gcc-12
x86_64                randconfig-071-20241112    gcc-12
x86_64                randconfig-072-20241112    gcc-12
x86_64                randconfig-073-20241112    gcc-12
x86_64                randconfig-074-20241112    gcc-12
x86_64                randconfig-075-20241112    gcc-12
x86_64                randconfig-076-20241112    gcc-12
x86_64                               rhel-8.3    gcc-12
x86_64                           rhel-8.3-bpf    clang-19
x86_64                         rhel-8.3-kunit    clang-19
x86_64                           rhel-8.3-ltp    clang-19
x86_64                          rhel-8.3-rust    clang-19
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20241112    gcc-14.2.0
xtensa                randconfig-002-20241112    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
