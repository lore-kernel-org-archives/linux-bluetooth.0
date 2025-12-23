Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1FFC1D9A5F
	for <linux-bluetooth@vger.kernel.org>; Tue, 23 Dec 2025 18:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766512911; cv=none; b=F3TRFU2vBeRYlcq6PH6FYvKUZ5hqrZm/Qu6zOk0YTx6r73ZIwaXj5vER5pP1/R+9VskhfhAg8wKWdQm62PwU4jmbmI2ObBOkP5UiCiSC+mWpoa8MACWOb1SFjrv8X2ShR+D3pqOkbSxnrASZWkJYDMpbH/7+8OT/XUluLKuurpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766512911; c=relaxed/simple;
	bh=V8pLBNgRLzh+ZDEfLjxMob3LlCsCX2ceg2UQicu3vcY=;
	h=Date:From:To:Cc:Subject:Message-ID; b=o8SMS23mda1F+N+mHipZa+8HqnF4bGJ+zD97Il9xHPNG7LfN5GyaOpXHJAKWHELKoznjsDWI8NmKDc47lqU96edkeYjfREVm2PeXUsnU4SqqEFJE1GS88iQ3S14y8RvkkxuAKS+0cHXRc21U+UNfmww3ALk32jdzm9pCbcKeDZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=heoPDI15; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="heoPDI15"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766512910; x=1798048910;
  h=date:from:to:cc:subject:message-id;
  bh=V8pLBNgRLzh+ZDEfLjxMob3LlCsCX2ceg2UQicu3vcY=;
  b=heoPDI15gw+UnoFyAdTz9bAQQvxO5HlXzdQ/VD9D8s+3w5xU+UzuOluR
   UX/Koij/z8xZt/8sXGOa1UgYEBLfRLrfqFjjP8dxIwP56YCggyYkF0REh
   unko+haCTQarjviopgeJO29i1mM4ted8VcN67+2/viNsxGCfPQqmGORvy
   qohWaz+G0a8xHyHxWEpsWa/qusmG/GoGayMEoSjwphwLc+ZHHWt3lHT/B
   XfNPmpws5P/+EmqUCQw80pvvesSrfgUE/Okzm9dSe97xT6kn412YMhGc4
   Xir6J1PSkuwDgRDfcjkXJjjiYBAPsTwIW1xAXdzaX9IXZa7rlhmLASW89
   Q==;
X-CSE-ConnectionGUID: GtXS7M/NQOuu+hRrI5CQoQ==
X-CSE-MsgGUID: AiMrdO4iQr2yhTHkzRuA2w==
X-IronPort-AV: E=McAfee;i="6800,10657,11651"; a="78999332"
X-IronPort-AV: E=Sophos;i="6.21,171,1763452800"; 
   d="scan'208";a="78999332"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2025 10:01:49 -0800
X-CSE-ConnectionGUID: g+rXk+44T56LGiiGmikKpw==
X-CSE-MsgGUID: yQ863nV1RPWQ7im95p0CsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,171,1763452800"; 
   d="scan'208";a="204335995"
Received: from lkp-server02.sh.intel.com (HELO dd3453e2b682) ([10.239.97.151])
  by fmviesa005.fm.intel.com with ESMTP; 23 Dec 2025 10:01:48 -0800
Received: from kbuild by dd3453e2b682 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vY6hd-000000002FJ-24Js;
	Tue, 23 Dec 2025 18:01:45 +0000
Date: Wed, 24 Dec 2025 02:01:24 +0800
From: kernel test robot <lkp@intel.com>
To: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 1d7a8fd800eb96f1175ddc3517822900c382cb80
Message-ID: <202512240219.Qb8QMkKM-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: 1d7a8fd800eb96f1175ddc3517822900c382cb80  Bluetooth: L2CAP: Add support for setting BT_PHY

elapsed time: 1340m

configs tested: 174
configs skipped: 8

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    gcc-15.1.0
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    gcc-15.1.0
arc                                 defconfig    gcc-15.1.0
arc                   randconfig-001-20251223    gcc-8.5.0
arc                   randconfig-002-20251223    gcc-8.5.0
arm                               allnoconfig    clang-22
arm                               allnoconfig    gcc-15.1.0
arm                              allyesconfig    gcc-15.1.0
arm                   randconfig-001-20251223    clang-22
arm                   randconfig-002-20251223    gcc-10.5.0
arm                   randconfig-003-20251223    clang-20
arm                   randconfig-004-20251223    gcc-8.5.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20251223    clang-17
arm64                 randconfig-002-20251223    clang-22
arm64                 randconfig-003-20251223    clang-18
arm64                 randconfig-004-20251223    gcc-9.5.0
csky                             allmodconfig    gcc-15.1.0
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20251223    gcc-11.5.0
csky                  randconfig-002-20251223    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                           allnoconfig    gcc-15.1.0
hexagon               randconfig-001-20251223    clang-22
hexagon               randconfig-002-20251223    clang-22
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-15.1.0
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20251223    clang-20
i386        buildonly-randconfig-002-20251223    gcc-14
i386        buildonly-randconfig-003-20251223    clang-20
i386        buildonly-randconfig-004-20251223    clang-20
i386        buildonly-randconfig-005-20251223    gcc-14
i386        buildonly-randconfig-006-20251223    clang-20
i386                                defconfig    clang-20
i386                  randconfig-001-20251223    clang-20
i386                  randconfig-002-20251223    gcc-14
i386                  randconfig-003-20251223    clang-20
i386                  randconfig-004-20251223    gcc-14
i386                  randconfig-005-20251223    gcc-13
i386                  randconfig-006-20251223    gcc-14
i386                  randconfig-007-20251223    gcc-14
i386                  randconfig-011-20251223    gcc-12
i386                  randconfig-012-20251223    gcc-14
i386                  randconfig-013-20251223    gcc-12
i386                  randconfig-014-20251223    gcc-14
i386                  randconfig-015-20251223    gcc-14
i386                  randconfig-016-20251223    gcc-14
i386                  randconfig-017-20251223    clang-20
loongarch                         allnoconfig    clang-22
loongarch                         allnoconfig    gcc-15.1.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20251223    gcc-15.1.0
loongarch             randconfig-002-20251223    clang-22
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
m68k                                defconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                             allmodconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                             allyesconfig    gcc-15.1.0
mips                      maltaaprp_defconfig    clang-22
nios2                             allnoconfig    clang-22
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20251223    gcc-11.5.0
nios2                 randconfig-002-20251223    gcc-11.5.0
openrisc                          allnoconfig    clang-22
openrisc                          allnoconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    clang-22
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20251223    gcc-8.5.0
parisc                randconfig-002-20251223    gcc-8.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-22
powerpc                           allnoconfig    gcc-15.1.0
powerpc               mpc834x_itxgp_defconfig    clang-22
powerpc               randconfig-001-20251223    clang-22
powerpc               randconfig-002-20251223    clang-22
powerpc64             randconfig-001-20251223    clang-17
powerpc64             randconfig-002-20251223    clang-22
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-22
riscv                 randconfig-001-20251223    gcc-8.5.0
riscv                 randconfig-002-20251223    clang-22
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    clang-22
s390                  randconfig-001-20251223    gcc-14.3.0
s390                  randconfig-002-20251223    gcc-14.3.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    clang-22
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                         ecovec24_defconfig    gcc-15.1.0
sh                    randconfig-001-20251223    gcc-10.5.0
sh                    randconfig-002-20251223    gcc-15.1.0
sh                            shmin_defconfig    gcc-15.1.0
sparc                            alldefconfig    gcc-15.1.0
sparc                             allnoconfig    clang-22
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20251223    gcc-15.1.0
sparc                 randconfig-002-20251223    gcc-12.5.0
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20251223    gcc-8.5.0
sparc64               randconfig-002-20251223    gcc-8.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-14
um                                  defconfig    clang-22
um                             i386_defconfig    gcc-14
um                    randconfig-001-20251223    clang-22
um                    randconfig-002-20251223    gcc-14
um                           x86_64_defconfig    clang-22
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                            allnoconfig    clang-22
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20251223    clang-20
x86_64      buildonly-randconfig-002-20251223    clang-20
x86_64      buildonly-randconfig-003-20251223    clang-20
x86_64      buildonly-randconfig-003-20251223    gcc-14
x86_64      buildonly-randconfig-004-20251223    clang-20
x86_64      buildonly-randconfig-004-20251223    gcc-14
x86_64      buildonly-randconfig-005-20251223    clang-20
x86_64      buildonly-randconfig-006-20251223    clang-20
x86_64                              defconfig    gcc-14
x86_64                randconfig-001-20251223    gcc-14
x86_64                randconfig-002-20251223    clang-20
x86_64                randconfig-003-20251223    gcc-14
x86_64                randconfig-004-20251223    clang-20
x86_64                randconfig-005-20251223    gcc-14
x86_64                randconfig-006-20251223    clang-20
x86_64                randconfig-011-20251223    gcc-14
x86_64                randconfig-012-20251223    clang-20
x86_64                randconfig-013-20251223    clang-20
x86_64                randconfig-014-20251223    clang-20
x86_64                randconfig-015-20251223    gcc-14
x86_64                randconfig-016-20251223    gcc-14
x86_64                randconfig-071-20251223    gcc-14
x86_64                randconfig-072-20251223    clang-20
x86_64                randconfig-073-20251223    clang-20
x86_64                randconfig-074-20251223    gcc-14
x86_64                randconfig-075-20251223    gcc-14
x86_64                randconfig-076-20251223    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    clang-22
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20251223    gcc-8.5.0
xtensa                randconfig-002-20251223    gcc-15.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
