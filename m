Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD4603126A9
	for <linux-bluetooth@vger.kernel.org>; Wed, 10 Sep 2025 21:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757540471; cv=none; b=GbQkSB8eKH8SRxfjuMU82cx3u+USVbiUfLasNjb1L2JK7Yg8tNmP4X/8cW8NOm+G7WngOhhIlHuEXqhdx0w78BO3T4ZzZ2a1Eau7X7vU5iN5PcHPijM0jvJNc3VCTw8+Nny5Pw648Z4xFsJjpc1AlLuZ7F4iS94A1yD5UD33UNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757540471; c=relaxed/simple;
	bh=Ed5c2w1jFpnwlvJO5lbqEwA6hdWSyA+sowKo3tjxIUo=;
	h=Date:From:To:Cc:Subject:Message-ID; b=ZrgtpXDFs+RtJhT8wJCHSpEjsuhva/UczfMF1/XUTYgrks6BFEhgG58hJnDXruAqIsGwd7cP1EG1ksL7c/30RcJKj0uceixYg4X3JExLJ3Ifj1EudFvKpf2ph7pKeK6f9ph0EpWgxnNTxXmryi1Joy2AS6CIrtBO7L24LpaogLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UF28yZAk; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UF28yZAk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757540468; x=1789076468;
  h=date:from:to:cc:subject:message-id;
  bh=Ed5c2w1jFpnwlvJO5lbqEwA6hdWSyA+sowKo3tjxIUo=;
  b=UF28yZAkz6120gSxOgnUpsvnk4S6DpcgIc3HhBUUcz/JoL7PsDY4N14l
   yMXMZl09SpL6q68vlnOGNZjaitu3HhJLZjJpWDfNnmcEsCHmEugpWu63l
   XGe6c78iQwEzBTKRRRmNnoigspMm2gV38ZVqptntjhX0WgZ0MyV8W6tbc
   tlpxdvZeqg4DDE1i//BPi4xi9qGzZsuLOmHqwOHvEKZe8YEEIX9Ga2Nh2
   UKuhtV4GWhkrsR3vcV4c/gQiyc61ri/Ou6bEScJ+5Xf3Y0dlbecw3PrD4
   ps1LfeJW2IxdrydY7YSP0EX4f9zgjgzalFZffMO5L5uk5fQ26GTCq/e+c
   A==;
X-CSE-ConnectionGUID: LJy0WxjKT66mDuPxndXgyw==
X-CSE-MsgGUID: Wn55HgZaRJi9dO5oSUPPCA==
X-IronPort-AV: E=McAfee;i="6800,10657,11549"; a="63498746"
X-IronPort-AV: E=Sophos;i="6.18,255,1751266800"; 
   d="scan'208";a="63498746"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2025 14:41:08 -0700
X-CSE-ConnectionGUID: RaxhIVyJR7WhX7w6624qug==
X-CSE-MsgGUID: +gfpJDJDRSukvb5wIxPWbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,255,1751266800"; 
   d="scan'208";a="177543895"
Received: from lkp-server01.sh.intel.com (HELO 114d98da2b6c) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 10 Sep 2025 14:41:07 -0700
Received: from kbuild by 114d98da2b6c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uwSYq-0006Ip-2j;
	Wed, 10 Sep 2025 21:41:04 +0000
Date: Thu, 11 Sep 2025 05:40:58 +0800
From: kernel test robot <lkp@intel.com>
To: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 6c7e4432e56e2d3c375927f2be7449fd51c16e52
Message-ID: <202509110549.CKbH3jZ9-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: 6c7e4432e56e2d3c375927f2be7449fd51c16e52  Bluetooth: bcsp: receive data only if registered

elapsed time: 1481m

configs tested: 113
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    gcc-15.1.0
arc                   randconfig-001-20250910    gcc-13.4.0
arc                   randconfig-002-20250910    gcc-8.5.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    gcc-15.1.0
arm                          moxart_defconfig    gcc-15.1.0
arm                            qcom_defconfig    clang-22
arm                   randconfig-001-20250910    gcc-8.5.0
arm                   randconfig-002-20250910    gcc-8.5.0
arm                   randconfig-003-20250910    clang-16
arm                   randconfig-004-20250910    gcc-8.5.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20250910    clang-22
arm64                 randconfig-002-20250910    clang-22
arm64                 randconfig-003-20250910    gcc-9.5.0
arm64                 randconfig-004-20250910    gcc-13.4.0
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20250910    gcc-12.5.0
csky                  randconfig-002-20250910    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-22
hexagon               randconfig-001-20250910    clang-22
hexagon               randconfig-002-20250910    clang-22
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386        buildonly-randconfig-001-20250910    gcc-14
i386        buildonly-randconfig-002-20250910    gcc-13
i386        buildonly-randconfig-003-20250910    clang-20
i386        buildonly-randconfig-004-20250910    clang-20
i386        buildonly-randconfig-005-20250910    gcc-14
i386        buildonly-randconfig-006-20250910    clang-20
i386                                defconfig    clang-20
loongarch                         allnoconfig    clang-22
loongarch             randconfig-001-20250910    clang-18
loongarch             randconfig-002-20250910    clang-18
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
m68k                        m5407c3_defconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20250910    gcc-11.5.0
nios2                 randconfig-002-20250910    gcc-9.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250910    gcc-10.5.0
parisc                randconfig-002-20250910    gcc-9.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                    amigaone_defconfig    gcc-15.1.0
powerpc                   bluestone_defconfig    clang-22
powerpc                          g5_defconfig    gcc-15.1.0
powerpc               randconfig-001-20250910    gcc-8.5.0
powerpc               randconfig-002-20250910    gcc-8.5.0
powerpc               randconfig-003-20250910    clang-22
powerpc64             randconfig-002-20250910    gcc-11.5.0
powerpc64             randconfig-003-20250910    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                 randconfig-001-20250910    clang-22
riscv                 randconfig-002-20250910    clang-22
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                  randconfig-001-20250910    clang-22
s390                  randconfig-002-20250910    clang-22
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                    randconfig-001-20250910    gcc-15.1.0
sh                    randconfig-002-20250910    gcc-12.5.0
sh                           se7780_defconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250910    gcc-8.5.0
sparc                 randconfig-002-20250910    gcc-8.5.0
sparc64                          alldefconfig    gcc-15.1.0
sparc64               randconfig-001-20250910    gcc-8.5.0
sparc64               randconfig-002-20250910    gcc-12.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-14
um                    randconfig-001-20250910    clang-22
um                    randconfig-002-20250910    clang-22
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250910    gcc-14
x86_64      buildonly-randconfig-002-20250910    clang-20
x86_64      buildonly-randconfig-003-20250910    gcc-14
x86_64      buildonly-randconfig-004-20250910    clang-20
x86_64      buildonly-randconfig-005-20250910    gcc-14
x86_64      buildonly-randconfig-006-20250910    clang-20
x86_64                              defconfig    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250910    gcc-8.5.0
xtensa                randconfig-002-20250910    gcc-10.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
