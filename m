Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E47C133554B
	for <linux-bluetooth@vger.kernel.org>; Tue, 16 Dec 2025 18:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765910679; cv=none; b=GH/1d+CujVAOgrF7NCZ/V/F1XcAPOGy093hdAMdJk5Pt/ZQtYN8l5S9TIadJE4m/mZrjS1W73EqNsO9Z9QdBDQxpGAsVeq37NyZm9NEABZrL4bsxbPbkA+fM52l89OqDRCN7Ip+UO33phABCGDCxozhRntoIOJf5gcSXJX0Od7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765910679; c=relaxed/simple;
	bh=ykm8YSZUpiwDUACaIq25C6dbl6iuBDM7QEulPL1yjfY=;
	h=Date:From:To:Cc:Subject:Message-ID; b=qnEEtHRcVBpj8gtjdOtH7Pp3bv+zqwvVOHkHBcWFNhpt4BARsE8abzjCoEUmEwBTyN+Fha8SGrellrfH/e36dB3/u4mb0d3vmaQusDXTpsAEtVxw/Lkmmk7eBOD4JnZ1FzWNYzg0RxjxeIGWsI8ojFH6kzpkze0EWdrl2Sft83c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AxECxwZF; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AxECxwZF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765910678; x=1797446678;
  h=date:from:to:cc:subject:message-id;
  bh=ykm8YSZUpiwDUACaIq25C6dbl6iuBDM7QEulPL1yjfY=;
  b=AxECxwZFNQBHtx3GuzMkBZ/11W+U9LlXHxmmC352HQQfm/ms5nRsj3EH
   G+Gd4OzUxN7DDs0Dj81LxpQ7UyMmwGigbH8Abmb+5tAoElETzj/FKSyOD
   LUsTbLNHwm5FIZPD5kxpteHTAjOuJP/Zk15HMamY12EmKRgo+DEG/CQuF
   YSN/Tyqf909TAyhmWdHf0KJ++qW0TvNG8NA1u/8nM5jzbqztvEibs47Ke
   5zlMhFlY5kva1kJEW+LrDoMdlfiBYFD1VOpahffmu/aM+5FCd1Qh9/DBd
   8BdGB/rSlPdMODkZ59VfFZN9u06oc0pyDx+Yfl3v1c3DyGpE853oiBq9R
   w==;
X-CSE-ConnectionGUID: 1jTpU1mGSTSc/2GeLfRFtw==
X-CSE-MsgGUID: nrqH2o4FSZ2qbN+Fm+t/+A==
X-IronPort-AV: E=McAfee;i="6800,10657,11644"; a="71693311"
X-IronPort-AV: E=Sophos;i="6.21,153,1763452800"; 
   d="scan'208";a="71693311"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2025 10:44:32 -0800
X-CSE-ConnectionGUID: Ni27xpfpRvG+QYBZbJZvPg==
X-CSE-MsgGUID: Q8QBEIuuTrK+bw9+mWRShQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,153,1763452800"; 
   d="scan'208";a="228780093"
Received: from lkp-server02.sh.intel.com (HELO 034c7e8e53c3) ([10.239.97.151])
  by orviesa002.jf.intel.com with ESMTP; 16 Dec 2025 10:44:29 -0800
Received: from kbuild by 034c7e8e53c3 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vVa1y-000000003jq-32VR;
	Tue, 16 Dec 2025 18:44:21 +0000
Date: Wed, 17 Dec 2025 02:43:48 +0800
From: kernel test robot <lkp@intel.com>
To: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 3a7cf69ce3cfce597357cb677a4f23e0d26481a3
Message-ID: <202512170242.odxIE3e6-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: 3a7cf69ce3cfce597357cb677a4f23e0d26481a3  Bluetooth: btusb: revert use of devm_kzalloc in btusb

elapsed time: 1460m

configs tested: 199
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    gcc-15.1.0
arc                              allmodconfig    clang-16
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    clang-22
arc                              allyesconfig    gcc-15.1.0
arc                                 defconfig    gcc-15.1.0
arc                   randconfig-001-20251216    gcc-8.5.0
arc                   randconfig-002-20251216    gcc-8.5.0
arm                               allnoconfig    clang-22
arm                               allnoconfig    gcc-15.1.0
arm                              allyesconfig    clang-16
arm                              allyesconfig    gcc-15.1.0
arm                                 defconfig    gcc-15.1.0
arm                   milbeaut_m10v_defconfig    gcc-15.1.0
arm                   randconfig-001-20251216    gcc-8.5.0
arm                   randconfig-002-20251216    gcc-8.5.0
arm                   randconfig-003-20251216    gcc-8.5.0
arm                   randconfig-004-20251216    gcc-8.5.0
arm64                            allmodconfig    clang-19
arm64                            allmodconfig    clang-22
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    gcc-15.1.0
arm64                 randconfig-001-20251216    gcc-10.5.0
arm64                 randconfig-002-20251216    gcc-10.5.0
arm64                 randconfig-003-20251216    gcc-10.5.0
arm64                 randconfig-004-20251216    gcc-10.5.0
csky                             allmodconfig    gcc-15.1.0
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    gcc-15.1.0
csky                  randconfig-001-20251216    gcc-10.5.0
csky                  randconfig-002-20251216    gcc-10.5.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    gcc-15.1.0
hexagon                           allnoconfig    clang-22
hexagon                           allnoconfig    gcc-15.1.0
hexagon                             defconfig    gcc-15.1.0
hexagon               randconfig-001-20251216    gcc-8.5.0
hexagon               randconfig-002-20251216    gcc-8.5.0
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-15.1.0
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20251216    gcc-14
i386        buildonly-randconfig-002-20251216    gcc-14
i386        buildonly-randconfig-003-20251216    gcc-14
i386        buildonly-randconfig-004-20251216    gcc-14
i386        buildonly-randconfig-005-20251216    gcc-14
i386        buildonly-randconfig-006-20251216    gcc-14
i386                                defconfig    gcc-15.1.0
i386                  randconfig-001-20251216    gcc-14
i386                  randconfig-002-20251216    gcc-14
i386                  randconfig-003-20251216    gcc-14
i386                  randconfig-004-20251216    gcc-14
i386                  randconfig-005-20251216    gcc-14
i386                  randconfig-006-20251216    gcc-14
i386                  randconfig-007-20251216    gcc-14
i386                  randconfig-011-20251216    gcc-13
i386                  randconfig-012-20251216    gcc-13
i386                  randconfig-013-20251216    gcc-13
i386                  randconfig-014-20251216    gcc-13
i386                  randconfig-015-20251216    gcc-13
i386                  randconfig-016-20251216    gcc-13
i386                  randconfig-017-20251216    gcc-13
loongarch                        allmodconfig    clang-19
loongarch                        allmodconfig    clang-22
loongarch                         allnoconfig    clang-22
loongarch                         allnoconfig    gcc-15.1.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20251216    gcc-8.5.0
loongarch             randconfig-002-20251216    gcc-8.5.0
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    clang-16
m68k                             allyesconfig    gcc-15.1.0
m68k                                defconfig    clang-19
m68k                        m5272c3_defconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    clang-19
mips                             allmodconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                             allyesconfig    gcc-15.1.0
mips                           ip30_defconfig    gcc-15.1.0
nios2                            allmodconfig    clang-22
nios2                             allnoconfig    clang-22
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-19
nios2                 randconfig-001-20251216    gcc-8.5.0
nios2                 randconfig-002-20251216    gcc-8.5.0
openrisc                         allmodconfig    clang-22
openrisc                          allnoconfig    clang-22
openrisc                          allnoconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    clang-22
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    clang-19
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20251216    clang-22
parisc                randconfig-002-20251216    clang-22
parisc64                            defconfig    clang-19
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-22
powerpc                           allnoconfig    gcc-15.1.0
powerpc                      bamboo_defconfig    gcc-15.1.0
powerpc                      ep88xc_defconfig    gcc-15.1.0
powerpc               randconfig-001-20251216    clang-22
powerpc               randconfig-002-20251216    clang-22
powerpc64             randconfig-001-20251216    clang-22
powerpc64             randconfig-002-20251216    clang-22
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-15.1.0
riscv                 randconfig-001-20251216    clang-17
riscv                 randconfig-002-20251216    clang-17
s390                             allmodconfig    clang-18
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    gcc-15.1.0
s390                  randconfig-001-20251216    clang-17
s390                  randconfig-002-20251216    clang-17
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    clang-22
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    clang-19
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-14
sh                    randconfig-001-20251216    clang-17
sh                    randconfig-002-20251216    clang-17
sh                           se7712_defconfig    gcc-15.1.0
sparc                             allnoconfig    clang-22
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20251216    gcc-8.5.0
sparc                 randconfig-002-20251216    gcc-8.5.0
sparc64                          allmodconfig    clang-22
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20251216    gcc-8.5.0
sparc64               randconfig-002-20251216    gcc-8.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-14
um                               allyesconfig    gcc-15.1.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20251216    gcc-8.5.0
um                    randconfig-002-20251216    gcc-8.5.0
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                            allnoconfig    clang-22
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20251216    clang-20
x86_64      buildonly-randconfig-002-20251216    clang-20
x86_64      buildonly-randconfig-003-20251216    clang-20
x86_64      buildonly-randconfig-004-20251216    clang-20
x86_64      buildonly-randconfig-005-20251216    clang-20
x86_64      buildonly-randconfig-006-20251216    clang-20
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20251216    clang-20
x86_64                randconfig-002-20251216    clang-20
x86_64                randconfig-003-20251216    clang-20
x86_64                randconfig-004-20251216    clang-20
x86_64                randconfig-005-20251216    clang-20
x86_64                randconfig-006-20251216    clang-20
x86_64                randconfig-011-20251216    clang-20
x86_64                randconfig-012-20251216    clang-20
x86_64                randconfig-013-20251216    clang-20
x86_64                randconfig-014-20251216    clang-20
x86_64                randconfig-015-20251216    clang-20
x86_64                randconfig-016-20251216    clang-20
x86_64                randconfig-071-20251216    gcc-14
x86_64                randconfig-072-20251216    gcc-14
x86_64                randconfig-073-20251216    gcc-14
x86_64                randconfig-074-20251216    gcc-14
x86_64                randconfig-075-20251216    gcc-14
x86_64                randconfig-076-20251216    gcc-14
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    clang-22
xtensa                            allnoconfig    gcc-15.1.0
xtensa                           allyesconfig    clang-22
xtensa                randconfig-001-20251216    gcc-8.5.0
xtensa                randconfig-002-20251216    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
