Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AFFB268FD3
	for <linux-bluetooth@vger.kernel.org>; Fri, 14 Feb 2025 18:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739556478; cv=none; b=nLB1Km7IpzfilDU4BEaS90azvmRpEoCdFqq6MqkiWLvvePADs+mrtDNMTZxEo2dwqlcZBzN2YPiWGJP5mDFrH8Unq9r+qyCFVDZgd/rOe8z8Uw+rdyBLcOhVy9zWjBIgFrVpIKm/gpUSU9ej7TOdAIuW3yuciLIq5LsJIKnlqNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739556478; c=relaxed/simple;
	bh=SUezAKe/0OWapNU+2Y3YQsLM0n289XoAXqkTc4RUunU=;
	h=Date:From:To:Cc:Subject:Message-ID; b=iJruNeRq61cmiQhsv/ouoWnI54MUdytAi73dlqtUb6zJMp01n6i/m3bJxGzaFtD5aPFiuD4ah5cHyYZ80fMlWLSKrT8oFMALiJqiX6aFGNEXA30NQkdyGBu+6Hq4yaa6pTP8lrUiCRr7m1jWL+6SZNJjhLd+njf9olW9BYUCfqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H0xpK6Jr; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H0xpK6Jr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739556476; x=1771092476;
  h=date:from:to:cc:subject:message-id;
  bh=SUezAKe/0OWapNU+2Y3YQsLM0n289XoAXqkTc4RUunU=;
  b=H0xpK6JrkJUzxJv9CKUS7YuYI0HGaRlLKYEV5fx2zLKXneaH8uRfPAJt
   RY7eVlPKgs3v4D8uQFLHbVtSPfQqnMEV4D5otmI2rwl1kmAleXgRHq+Cl
   AbM4DgOQI8V6lT95eckqdSM+dumUFelFVcGrnuHQisPkHBgBZhFJ6WUeu
   xZHbCvxYJb8e9CjC43T2Gy7o8DmY0CCLhaexUkEhjs/8HEZaKwN/1FAdU
   CUuRYJAKIiShNZCGZWzOYWJxLTfg8yRA5zoMk2hbPRusit8/XnNbVpRDh
   5qG9I94fg41f2JY8cx41OxG6wdZshgP3qUZsNb4ftiPleLYBMN6vlBykv
   Q==;
X-CSE-ConnectionGUID: JvsE9yzMQSeUK3dOTFBrEw==
X-CSE-MsgGUID: W0MPP1nDSMOZHPtIc4Rm5A==
X-IronPort-AV: E=McAfee;i="6700,10204,11345"; a="65668578"
X-IronPort-AV: E=Sophos;i="6.13,286,1732608000"; 
   d="scan'208";a="65668578"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2025 10:07:55 -0800
X-CSE-ConnectionGUID: ox6TWwxTRjSspecS6VPo1Q==
X-CSE-MsgGUID: wCKC6Tn0TLmiQLF04T8ErA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,286,1732608000"; 
   d="scan'208";a="144378446"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 14 Feb 2025 10:07:54 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tj06R-001A01-2O;
	Fri, 14 Feb 2025 18:07:51 +0000
Date: Sat, 15 Feb 2025 02:06:57 +0800
From: kernel test robot <lkp@intel.com>
To: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 d0aa1ab4d278d20d5121c0952464a567c9ef9934
Message-ID: <202502150251.3nxwPLnx-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: d0aa1ab4d278d20d5121c0952464a567c9ef9934  Bluetooth: L2CAP: Fix corrupted list in hci_chan_del

elapsed time: 1191m

configs tested: 212
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    clang-21
alpha                            allyesconfig    gcc-14.2.0
alpha                               defconfig    gcc-14.2.0
arc                              allmodconfig    clang-18
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    clang-18
arc                                 defconfig    gcc-14.2.0
arc                            hsdk_defconfig    gcc-14.2.0
arc                   randconfig-001-20250214    gcc-13.2.0
arc                   randconfig-001-20250214    gcc-14.2.0
arc                   randconfig-002-20250214    gcc-13.2.0
arc                   randconfig-002-20250214    gcc-14.2.0
arm                              allmodconfig    clang-18
arm                               allnoconfig    gcc-14.2.0
arm                              allyesconfig    clang-18
arm                                 defconfig    gcc-14.2.0
arm                   randconfig-001-20250214    clang-16
arm                   randconfig-001-20250214    gcc-14.2.0
arm                   randconfig-002-20250214    gcc-14.2.0
arm                   randconfig-003-20250214    clang-21
arm                   randconfig-003-20250214    gcc-14.2.0
arm                   randconfig-004-20250214    gcc-14.2.0
arm64                            allmodconfig    clang-18
arm64                             allnoconfig    gcc-14.2.0
arm64                               defconfig    gcc-14.2.0
arm64                 randconfig-001-20250214    gcc-14.2.0
arm64                 randconfig-002-20250214    gcc-14.2.0
arm64                 randconfig-003-20250214    gcc-14.2.0
arm64                 randconfig-004-20250214    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
csky                                defconfig    gcc-14.2.0
csky                  randconfig-001-20250214    clang-21
csky                  randconfig-001-20250214    gcc-14.2.0
csky                  randconfig-002-20250214    clang-21
csky                  randconfig-002-20250214    gcc-14.2.0
hexagon                          allmodconfig    clang-21
hexagon                           allnoconfig    gcc-14.2.0
hexagon                          allyesconfig    clang-18
hexagon                          allyesconfig    clang-21
hexagon                             defconfig    gcc-14.2.0
hexagon               randconfig-001-20250214    clang-21
hexagon               randconfig-002-20250214    clang-15
hexagon               randconfig-002-20250214    clang-21
i386                             allmodconfig    clang-19
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-19
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-19
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250214    gcc-12
i386        buildonly-randconfig-002-20250214    gcc-12
i386        buildonly-randconfig-003-20250214    clang-19
i386        buildonly-randconfig-003-20250214    gcc-12
i386        buildonly-randconfig-004-20250214    gcc-12
i386        buildonly-randconfig-005-20250214    gcc-12
i386        buildonly-randconfig-006-20250214    gcc-12
i386                                defconfig    clang-19
i386                  randconfig-001-20250214    gcc-12
i386                  randconfig-002-20250214    gcc-12
i386                  randconfig-003-20250214    gcc-12
i386                  randconfig-004-20250214    gcc-12
i386                  randconfig-005-20250214    gcc-12
i386                  randconfig-006-20250214    gcc-12
i386                  randconfig-007-20250214    gcc-12
i386                  randconfig-011-20250214    clang-19
i386                  randconfig-012-20250214    clang-19
i386                  randconfig-013-20250214    clang-19
i386                  randconfig-014-20250214    clang-19
i386                  randconfig-015-20250214    clang-19
i386                  randconfig-016-20250214    clang-19
i386                  randconfig-017-20250214    clang-19
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch                           defconfig    gcc-14.2.0
loongarch             randconfig-001-20250214    clang-21
loongarch             randconfig-001-20250214    gcc-14.2.0
loongarch             randconfig-002-20250214    clang-21
loongarch             randconfig-002-20250214    gcc-14.2.0
m68k                             alldefconfig    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                                defconfig    gcc-14.2.0
m68k                        m5272c3_defconfig    gcc-14.2.0
m68k                            q40_defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
microblaze                          defconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                               defconfig    gcc-14.2.0
nios2                 randconfig-001-20250214    clang-21
nios2                 randconfig-001-20250214    gcc-14.2.0
nios2                 randconfig-002-20250214    clang-21
nios2                 randconfig-002-20250214    gcc-14.2.0
openrisc                          allnoconfig    clang-21
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    clang-21
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-12
parisc                randconfig-001-20250214    clang-21
parisc                randconfig-001-20250214    gcc-14.2.0
parisc                randconfig-002-20250214    clang-21
parisc                randconfig-002-20250214    gcc-14.2.0
parisc64                            defconfig    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    clang-21
powerpc                          allyesconfig    gcc-14.2.0
powerpc                      katmai_defconfig    gcc-14.2.0
powerpc               randconfig-001-20250214    clang-21
powerpc               randconfig-001-20250214    gcc-14.2.0
powerpc               randconfig-002-20250214    clang-18
powerpc               randconfig-002-20250214    clang-21
powerpc               randconfig-003-20250214    clang-21
powerpc64             randconfig-001-20250214    clang-18
powerpc64             randconfig-001-20250214    clang-21
powerpc64             randconfig-002-20250214    clang-21
powerpc64             randconfig-002-20250214    gcc-14.2.0
powerpc64             randconfig-003-20250214    clang-21
powerpc64             randconfig-003-20250214    gcc-14.2.0
riscv                            allmodconfig    gcc-14.2.0
riscv                             allnoconfig    clang-21
riscv                            allyesconfig    gcc-14.2.0
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20250214    clang-16
riscv                 randconfig-001-20250214    clang-18
riscv                 randconfig-002-20250214    clang-16
riscv                 randconfig-002-20250214    gcc-14.2.0
s390                             allmodconfig    clang-19
s390                             allmodconfig    gcc-14.2.0
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20250214    clang-16
s390                  randconfig-001-20250214    gcc-14.2.0
s390                  randconfig-002-20250214    clang-16
s390                  randconfig-002-20250214    clang-19
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                        apsh4ad0a_defconfig    gcc-14.2.0
sh                                  defconfig    gcc-12
sh                    randconfig-001-20250214    clang-16
sh                    randconfig-001-20250214    gcc-14.2.0
sh                    randconfig-002-20250214    clang-16
sh                    randconfig-002-20250214    gcc-14.2.0
sh                          rsk7201_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250214    clang-16
sparc                 randconfig-001-20250214    gcc-14.2.0
sparc                 randconfig-002-20250214    clang-16
sparc                 randconfig-002-20250214    gcc-14.2.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20250214    clang-16
sparc64               randconfig-001-20250214    gcc-14.2.0
sparc64               randconfig-002-20250214    clang-16
sparc64               randconfig-002-20250214    gcc-14.2.0
um                               allmodconfig    clang-21
um                                allnoconfig    clang-21
um                               allyesconfig    clang-21
um                               allyesconfig    gcc-12
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250214    clang-16
um                    randconfig-001-20250214    gcc-12
um                    randconfig-002-20250214    clang-16
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20250214    clang-19
x86_64      buildonly-randconfig-001-20250214    gcc-12
x86_64      buildonly-randconfig-002-20250214    clang-19
x86_64      buildonly-randconfig-002-20250214    gcc-12
x86_64      buildonly-randconfig-003-20250214    gcc-12
x86_64      buildonly-randconfig-004-20250214    clang-19
x86_64      buildonly-randconfig-004-20250214    gcc-12
x86_64      buildonly-randconfig-005-20250214    gcc-12
x86_64      buildonly-randconfig-006-20250214    gcc-12
x86_64                              defconfig    clang-19
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-19
x86_64                randconfig-001-20250214    clang-19
x86_64                randconfig-002-20250214    clang-19
x86_64                randconfig-003-20250214    clang-19
x86_64                randconfig-004-20250214    clang-19
x86_64                randconfig-005-20250214    clang-19
x86_64                randconfig-006-20250214    clang-19
x86_64                randconfig-007-20250214    clang-19
x86_64                randconfig-008-20250214    clang-19
x86_64                randconfig-071-20250214    gcc-12
x86_64                randconfig-072-20250214    gcc-12
x86_64                randconfig-073-20250214    gcc-12
x86_64                randconfig-074-20250214    gcc-12
x86_64                randconfig-075-20250214    gcc-12
x86_64                randconfig-076-20250214    gcc-12
x86_64                randconfig-077-20250214    gcc-12
x86_64                randconfig-078-20250214    gcc-12
x86_64                               rhel-9.4    clang-19
x86_64                           rhel-9.4-bpf    clang-19
x86_64                         rhel-9.4-kunit    clang-19
x86_64                           rhel-9.4-ltp    clang-19
x86_64                          rhel-9.4-rust    clang-19
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250214    clang-16
xtensa                randconfig-001-20250214    gcc-14.2.0
xtensa                randconfig-002-20250214    clang-16
xtensa                randconfig-002-20250214    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
