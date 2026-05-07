Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04E0C3B8BD4
	for <linux-bluetooth@vger.kernel.org>; Thu,  7 May 2026 13:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778161737; cv=none; b=pPcKh3uuJTbn7Tw3+CUyQ/TR/Dc5cqyf0z8DLMD5JM5KMG8TYrxVQ+57A5tQedQUGlzyGq/rhrykRT19UfXV5MHVg23ji8v9mKFg4fQRqJXlCwOh0vvvyd6eSlriVMYkMdYUhLctN3Xa8AmTdqfAouarRlVCMy7GIBTqaAg36G4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778161737; c=relaxed/simple;
	bh=2/to3WFjwkRh8lz+buYj3mQ4H7Gsm3JzMbyek5KCZCw=;
	h=Date:From:To:Cc:Subject:Message-ID; b=LuSKIdPl0N2vQUkDjvGpsBP6xoDgAMVbrlWAoT0pMz3vvCIkvEOniZeKb2HucgkbWy8F1uGgbEeD1dynTngWqvwmbwKfwzxyUnaYE8kTkIIDq9v7HPk54Gv8UlE/keQhrpuieknwGLRTzAJLA+yg/D1u/SnpstSzjqvExwMJUM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=em0cMvw0; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="em0cMvw0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778161736; x=1809697736;
  h=date:from:to:cc:subject:message-id;
  bh=2/to3WFjwkRh8lz+buYj3mQ4H7Gsm3JzMbyek5KCZCw=;
  b=em0cMvw0/xNFPAbN8YCRJGx9hmDhQif0jjbX6bOqrVUJOM3ZWEh/yZCD
   SaditpP8Aecm3A6O7GLdDcgw61nyRqyTqx+bTM1LgD0T+pENV3OT7VCKE
   AafmK07l9xF0Ma8GAJ9fCkGgkqhJ4Z76iv/iNmKkDsVW7ZDbTna9iXuMC
   QyFV/r8KOw9eYDCgIOJN6ButAPvIBAS9ULyaCyi5HL9uJ3kI+WoV1acZ1
   WQgL7InmizyVRleeNt5viC9OtsuhaTmxicQ3l1WLY50wFEb+CLvWIrOjv
   Gecbe8fL7VnLDHHomC2GKr1KkH+QmX74//uNZqZLLZDvj7zZeNVKJypaG
   g==;
X-CSE-ConnectionGUID: plyzBo51QzS00zyYDneBjA==
X-CSE-MsgGUID: DFGi2XldRUCBmuV+QlyAOw==
X-IronPort-AV: E=McAfee;i="6800,10657,11779"; a="104568753"
X-IronPort-AV: E=Sophos;i="6.23,221,1770624000"; 
   d="scan'208";a="104568753"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2026 06:48:55 -0700
X-CSE-ConnectionGUID: yaALbuT7Qq+iS7fHfT3zxQ==
X-CSE-MsgGUID: AKcoMzY3QKOlJlnOURVWpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,221,1770624000"; 
   d="scan'208";a="241449100"
Received: from lkp-server01.sh.intel.com (HELO d6e19f2f5857) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 07 May 2026 06:48:54 -0700
Received: from kbuild by d6e19f2f5857 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wKz5v-0000000006j-3j3E;
	Thu, 07 May 2026 13:48:51 +0000
Date: Thu, 07 May 2026 21:48:41 +0800
From: kernel test robot <lkp@intel.com>
To: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 6911f19876fbf65116c61ae93a47e2316b41d5a4
Message-ID: <202605072134.zoYRSYJ5-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: 6911f19876fbf65116c61ae93a47e2316b41d5a4  Bluetooth: HIDP: serialise l2cap_unregister_user via hidp_session_sem

elapsed time: 727m

configs tested: 194
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
alpha                               defconfig    gcc-15.2.0
arc                              allmodconfig    clang-16
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    clang-23
arc                                 defconfig    gcc-15.2.0
arc                            randconfig-001    gcc-8.5.0
arc                   randconfig-001-20260507    gcc-14.3.0
arc                   randconfig-001-20260507    gcc-8.5.0
arc                            randconfig-002    gcc-8.5.0
arc                   randconfig-002-20260507    gcc-14.3.0
arc                   randconfig-002-20260507    gcc-8.5.0
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                                 defconfig    gcc-15.2.0
arm                            randconfig-001    gcc-8.5.0
arm                   randconfig-001-20260507    gcc-14.3.0
arm                   randconfig-001-20260507    gcc-8.5.0
arm                            randconfig-002    gcc-8.5.0
arm                   randconfig-002-20260507    gcc-14.3.0
arm                   randconfig-002-20260507    gcc-8.5.0
arm                            randconfig-003    gcc-8.5.0
arm                   randconfig-003-20260507    gcc-14.3.0
arm                   randconfig-003-20260507    gcc-8.5.0
arm                            randconfig-004    gcc-8.5.0
arm                   randconfig-004-20260507    gcc-14.3.0
arm                   randconfig-004-20260507    gcc-8.5.0
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                          randconfig-001    gcc-15.2.0
arm64                 randconfig-001-20260507    gcc-15.2.0
arm64                          randconfig-002    gcc-15.2.0
arm64                 randconfig-002-20260507    gcc-15.2.0
arm64                          randconfig-003    gcc-15.2.0
arm64                 randconfig-003-20260507    gcc-15.2.0
arm64                          randconfig-004    gcc-15.2.0
arm64                 randconfig-004-20260507    gcc-15.2.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                           randconfig-001    gcc-15.2.0
csky                  randconfig-001-20260507    gcc-15.2.0
csky                           randconfig-002    gcc-15.2.0
csky                  randconfig-002-20260507    gcc-15.2.0
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    gcc-15.2.0
hexagon               randconfig-001-20260507    clang-23
hexagon               randconfig-002-20260507    clang-23
i386                             allmodconfig    clang-20
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20260507    clang-20
i386        buildonly-randconfig-002-20260507    clang-20
i386        buildonly-randconfig-003-20260507    clang-20
i386        buildonly-randconfig-004-20260507    clang-20
i386        buildonly-randconfig-005-20260507    clang-20
i386        buildonly-randconfig-006-20260507    clang-20
i386                                defconfig    gcc-15.2.0
i386                           randconfig-001    gcc-14
i386                  randconfig-001-20260507    gcc-14
i386                           randconfig-002    gcc-14
i386                  randconfig-002-20260507    gcc-14
i386                           randconfig-003    gcc-14
i386                  randconfig-003-20260507    gcc-14
i386                           randconfig-004    gcc-14
i386                  randconfig-004-20260507    gcc-14
i386                           randconfig-005    gcc-14
i386                  randconfig-005-20260507    gcc-14
i386                           randconfig-006    gcc-14
i386                  randconfig-006-20260507    gcc-14
i386                           randconfig-007    gcc-14
i386                  randconfig-007-20260507    gcc-14
i386                           randconfig-011    clang-20
i386                  randconfig-011-20260507    clang-20
i386                           randconfig-012    clang-20
i386                  randconfig-012-20260507    clang-20
i386                           randconfig-013    clang-20
i386                  randconfig-013-20260507    clang-20
i386                           randconfig-014    clang-20
i386                  randconfig-014-20260507    clang-20
i386                           randconfig-015    clang-20
i386                  randconfig-015-20260507    clang-20
i386                           randconfig-016    clang-20
i386                  randconfig-016-20260507    clang-20
i386                           randconfig-017    clang-20
i386                  randconfig-017-20260507    clang-20
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260507    clang-23
loongarch             randconfig-002-20260507    clang-23
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    clang-16
m68k                                defconfig    clang-19
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    clang-19
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
nios2                            allmodconfig    clang-23
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    clang-23
nios2                               defconfig    clang-19
nios2                 randconfig-001-20260507    clang-23
nios2                 randconfig-002-20260507    clang-23
openrisc                         allmodconfig    clang-23
openrisc                         allmodconfig    gcc-15.2.0
openrisc                          allnoconfig    clang-23
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    clang-23
parisc                           allyesconfig    clang-19
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260507    gcc-8.5.0
parisc                randconfig-002-20260507    gcc-8.5.0
parisc64                            defconfig    clang-19
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-23
powerpc                 mpc836x_rdk_defconfig    clang-23
powerpc               randconfig-001-20260507    gcc-8.5.0
powerpc               randconfig-002-20260507    gcc-8.5.0
powerpc64             randconfig-001-20260507    gcc-8.5.0
powerpc64             randconfig-002-20260507    gcc-8.5.0
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-15.2.0
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    gcc-15.2.0
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-23
sh                               allyesconfig    clang-19
sh                         ap325rxa_defconfig    gcc-15.2.0
sh                                  defconfig    gcc-14
sparc                             allnoconfig    clang-23
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260507    gcc-12.5.0
sparc                 randconfig-002-20260507    gcc-12.5.0
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260507    gcc-12.5.0
sparc64               randconfig-002-20260507    gcc-12.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260507    gcc-12.5.0
um                    randconfig-002-20260507    gcc-12.5.0
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260507    clang-20
x86_64      buildonly-randconfig-002-20260507    clang-20
x86_64      buildonly-randconfig-003-20260507    clang-20
x86_64      buildonly-randconfig-004-20260507    clang-20
x86_64      buildonly-randconfig-005-20260507    clang-20
x86_64      buildonly-randconfig-006-20260507    clang-20
x86_64                              defconfig    gcc-14
x86_64                randconfig-001-20260507    gcc-14
x86_64                randconfig-002-20260507    gcc-14
x86_64                randconfig-003-20260507    gcc-14
x86_64                randconfig-004-20260507    gcc-14
x86_64                randconfig-005-20260507    gcc-14
x86_64                randconfig-006-20260507    gcc-14
x86_64                randconfig-011-20260507    gcc-14
x86_64                randconfig-012-20260507    gcc-14
x86_64                randconfig-013-20260507    gcc-14
x86_64                randconfig-014-20260507    gcc-14
x86_64                randconfig-015-20260507    gcc-14
x86_64                randconfig-016-20260507    gcc-14
x86_64                randconfig-071-20260507    clang-20
x86_64                randconfig-072-20260507    clang-20
x86_64                randconfig-073-20260507    clang-20
x86_64                randconfig-074-20260507    clang-20
x86_64                randconfig-075-20260507    clang-20
x86_64                randconfig-076-20260507    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    clang-23
xtensa                           allyesconfig    clang-23
xtensa                           allyesconfig    gcc-15.2.0
xtensa                randconfig-001-20260507    gcc-12.5.0
xtensa                randconfig-002-20260507    gcc-12.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
