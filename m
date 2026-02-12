Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1EE02264CA
	for <linux-bluetooth@vger.kernel.org>; Thu, 12 Feb 2026 10:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770892708; cv=none; b=X+PTcQPiT2WP76bNeCRcUIbNGCVjMbElmVkljQNIyuwYyCrBHXuGR05Nk0Cwo8ymfdJ+KPQU1zQztE4yIJRW/nKsD5ZVC0el1LEz/RB2LADZvMRY0lpxK3bxbr3QrTxZ8yTcQiIqrv2rJtYRTvRq91O/o7fyYFezslF9VIu98hE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770892708; c=relaxed/simple;
	bh=S3BjKZr+O6F08cxOrTRm2aMyg3IqO0zYKCgMjbuLBxg=;
	h=Date:From:To:Cc:Subject:Message-ID; b=g03haIT8yge8XPTGNAKoA+xgo7Sn0DuKa1mFptBst5wcPrilVMDpMDAN+BR367oNCuRi2pKiwxhcU8hMwOLzrpwOTql1l5eFZKpxngnoT63cOsEyAF7obZL4EvYAxB8bWBdJ8TdTbLbfT4FaH3g7JAHugxnQvQPgAYnRpcAfYEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g/SiWrCP; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g/SiWrCP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770892706; x=1802428706;
  h=date:from:to:cc:subject:message-id;
  bh=S3BjKZr+O6F08cxOrTRm2aMyg3IqO0zYKCgMjbuLBxg=;
  b=g/SiWrCPJ3hbgDcnaV+S+i8Z5gJ1dwOuu9RS95Xcinv7Z1BEkedJrxiK
   Ng3fX/J0NjjSB64lOUvR53bPKvaRmmCiejcOGhr3l66lvKAh3yAOWD6g2
   DRUCB+0kiS/vVTgM5S6JxG1KYcaOEiVEt1Bc1WBRrq11LOTouBrfhhj70
   0YC/rm7F5kMx1XDvjkNjJwlEtarFPznbFlWe3jhMhBycVp2ZcsIhOr9T9
   8+7qqkD/oeeG5bpzZWaaFH0HV69P5nRIrJ/an2W8Pkv1pVvxZp1VLY5q2
   3FZFD1tRX7g0mdoq64zmi1r4M8kk3RZMArez0BC5tyHXFW8Hw2FW2p+kM
   A==;
X-CSE-ConnectionGUID: pKczn2VfSAuoRHsvYArUcQ==
X-CSE-MsgGUID: /BLF8LqBTC2xiHwbaedzUg==
X-IronPort-AV: E=McAfee;i="6800,10657,11698"; a="59632173"
X-IronPort-AV: E=Sophos;i="6.21,286,1763452800"; 
   d="scan'208";a="59632173"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2026 02:38:26 -0800
X-CSE-ConnectionGUID: 7RFllKe1THuxoccIqRUT6Q==
X-CSE-MsgGUID: frkMAjvuTfWbExDaUH+TVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,286,1763452800"; 
   d="scan'208";a="216777980"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 12 Feb 2026 02:38:25 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vqU5W-00000000r4S-2kBC;
	Thu, 12 Feb 2026 10:38:22 +0000
Date: Thu, 12 Feb 2026 18:37:50 +0800
From: kernel test robot <lkp@intel.com>
To: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 c2b82511ef7dfe3d096261a9741e83dfd4e717e5
Message-ID: <202602121842.VAs7vKJN-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: c2b82511ef7dfe3d096261a9741e83dfd4e717e5  Bluetooth: qca: Refactor code on the basis of chipset names

elapsed time: 871m

configs tested: 236
configs skipped: 6

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
arc                                 defconfig    gcc-15.2.0
arc                   randconfig-001-20260212    gcc-10.5.0
arc                   randconfig-001-20260212    gcc-9.5.0
arc                   randconfig-002-20260212    gcc-10.5.0
arc                   randconfig-002-20260212    gcc-8.5.0
arm                               allnoconfig    clang-22
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                              allyesconfig    gcc-15.2.0
arm                                 defconfig    gcc-15.2.0
arm                           omap1_defconfig    gcc-15.2.0
arm                          pxa3xx_defconfig    gcc-15.2.0
arm                   randconfig-001-20260212    gcc-10.5.0
arm                   randconfig-001-20260212    gcc-8.5.0
arm                   randconfig-002-20260212    gcc-10.5.0
arm                   randconfig-003-20260212    clang-22
arm                   randconfig-003-20260212    gcc-10.5.0
arm                   randconfig-004-20260212    gcc-10.5.0
arm                   randconfig-004-20260212    gcc-8.5.0
arm64                            allmodconfig    clang-19
arm64                            allmodconfig    clang-22
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260212    gcc-10.5.0
arm64                 randconfig-002-20260212    gcc-10.5.0
arm64                 randconfig-003-20260212    gcc-10.5.0
arm64                 randconfig-004-20260212    gcc-10.5.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260212    gcc-10.5.0
csky                  randconfig-002-20260212    gcc-10.5.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    clang-22
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    gcc-15.2.0
hexagon               randconfig-001-20260212    clang-18
hexagon               randconfig-001-20260212    clang-22
hexagon               randconfig-002-20260212    clang-18
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260212    gcc-14
i386        buildonly-randconfig-002-20260212    gcc-14
i386        buildonly-randconfig-003-20260212    clang-20
i386        buildonly-randconfig-003-20260212    gcc-14
i386        buildonly-randconfig-004-20260212    gcc-13
i386        buildonly-randconfig-004-20260212    gcc-14
i386        buildonly-randconfig-005-20260212    gcc-14
i386        buildonly-randconfig-006-20260212    gcc-14
i386                                defconfig    gcc-15.2.0
i386                  randconfig-001-20260212    clang-20
i386                  randconfig-002-20260212    clang-20
i386                  randconfig-003-20260212    clang-20
i386                  randconfig-004-20260212    clang-20
i386                  randconfig-005-20260212    clang-20
i386                  randconfig-005-20260212    gcc-14
i386                  randconfig-006-20260212    clang-20
i386                  randconfig-006-20260212    gcc-14
i386                  randconfig-007-20260212    clang-20
i386                  randconfig-011-20260212    gcc-12
i386                  randconfig-011-20260212    gcc-14
i386                  randconfig-012-20260212    gcc-12
i386                  randconfig-013-20260212    clang-20
i386                  randconfig-013-20260212    gcc-12
i386                  randconfig-014-20260212    clang-20
i386                  randconfig-014-20260212    gcc-12
i386                  randconfig-015-20260212    clang-20
i386                  randconfig-015-20260212    gcc-12
i386                  randconfig-016-20260212    gcc-12
i386                  randconfig-016-20260212    gcc-14
i386                  randconfig-017-20260212    clang-20
i386                  randconfig-017-20260212    gcc-12
loongarch                        allmodconfig    clang-19
loongarch                        allmodconfig    clang-22
loongarch                         allnoconfig    clang-22
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260212    clang-18
loongarch             randconfig-002-20260212    clang-18
loongarch             randconfig-002-20260212    clang-22
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    clang-16
m68k                             allyesconfig    gcc-15.2.0
m68k                                defconfig    clang-19
m68k                        mvme147_defconfig    gcc-15.2.0
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    clang-19
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
mips                   sb1250_swarm_defconfig    gcc-15.2.0
nios2                            allmodconfig    clang-22
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    clang-22
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-19
nios2                 randconfig-001-20260212    clang-18
nios2                 randconfig-001-20260212    gcc-11.5.0
nios2                 randconfig-002-20260212    clang-18
nios2                 randconfig-002-20260212    gcc-8.5.0
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
parisc                randconfig-001-20260212    gcc-10.5.0
parisc                randconfig-001-20260212    gcc-8.5.0
parisc                randconfig-002-20260212    gcc-10.5.0
parisc                randconfig-002-20260212    gcc-8.5.0
parisc64                            defconfig    clang-19
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-22
powerpc                           allnoconfig    gcc-15.2.0
powerpc                     powernv_defconfig    gcc-15.2.0
powerpc               randconfig-001-20260212    clang-22
powerpc               randconfig-001-20260212    gcc-10.5.0
powerpc               randconfig-002-20260212    gcc-10.5.0
powerpc                     stx_gp3_defconfig    gcc-15.2.0
powerpc                     tqm8541_defconfig    gcc-15.2.0
powerpc                     tqm8555_defconfig    gcc-15.2.0
powerpc64                        alldefconfig    gcc-15.2.0
powerpc64             randconfig-001-20260212    clang-22
powerpc64             randconfig-001-20260212    gcc-10.5.0
powerpc64             randconfig-002-20260212    gcc-10.5.0
powerpc64             randconfig-002-20260212    gcc-11.5.0
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    clang-22
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-15.2.0
riscv                 randconfig-001-20260212    gcc-9.5.0
riscv                 randconfig-002-20260212    gcc-9.5.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    gcc-15.2.0
s390                  randconfig-001-20260212    gcc-9.5.0
s390                  randconfig-002-20260212    gcc-9.5.0
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-22
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    clang-19
sh                               allyesconfig    gcc-15.2.0
sh                                  defconfig    gcc-14
sh                          kfr2r09_defconfig    gcc-15.2.0
sh                    randconfig-001-20260212    gcc-9.5.0
sh                    randconfig-002-20260212    gcc-9.5.0
sh                           se7712_defconfig    gcc-15.2.0
sh                        sh7763rdp_defconfig    gcc-15.2.0
sparc                            alldefconfig    gcc-15.2.0
sparc                             allnoconfig    clang-22
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260212    gcc-13.4.0
sparc                 randconfig-002-20260212    gcc-13.4.0
sparc64                          allmodconfig    clang-22
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260212    gcc-13.4.0
sparc64               randconfig-002-20260212    gcc-13.4.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-14
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260212    gcc-13.4.0
um                    randconfig-002-20260212    gcc-13.4.0
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                            allnoconfig    clang-22
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260212    clang-20
x86_64      buildonly-randconfig-002-20260212    clang-20
x86_64      buildonly-randconfig-003-20260212    clang-20
x86_64      buildonly-randconfig-003-20260212    gcc-14
x86_64      buildonly-randconfig-004-20260212    clang-20
x86_64      buildonly-randconfig-005-20260212    clang-20
x86_64      buildonly-randconfig-006-20260212    clang-20
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260212    clang-20
x86_64                randconfig-002-20260212    clang-20
x86_64                randconfig-003-20260212    clang-20
x86_64                randconfig-004-20260212    clang-20
x86_64                randconfig-005-20260212    clang-20
x86_64                randconfig-006-20260212    clang-20
x86_64                randconfig-011-20260212    gcc-14
x86_64                randconfig-012-20260212    gcc-14
x86_64                randconfig-013-20260212    gcc-14
x86_64                randconfig-014-20260212    gcc-14
x86_64                randconfig-015-20260212    gcc-14
x86_64                randconfig-016-20260212    gcc-14
x86_64                randconfig-071-20260212    clang-20
x86_64                randconfig-071-20260212    gcc-14
x86_64                randconfig-072-20260212    gcc-14
x86_64                randconfig-073-20260212    gcc-14
x86_64                randconfig-074-20260212    gcc-14
x86_64                randconfig-075-20260212    gcc-14
x86_64                randconfig-076-20260212    clang-20
x86_64                randconfig-076-20260212    gcc-14
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
xtensa                generic_kc705_defconfig    gcc-15.2.0
xtensa                randconfig-001-20260212    gcc-13.4.0
xtensa                randconfig-002-20260212    gcc-13.4.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
