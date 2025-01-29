Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE67F1DF744
	for <linux-bluetooth@vger.kernel.org>; Wed, 29 Jan 2025 16:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738167622; cv=none; b=Aw3RNc+kUpVV3Lz1mqY/2v5Fa8qDQjZEKIaUbAi0Y7wXU0n0OiRNYh00NOiHcy90Ea2cnwGy5gUIM+bF2ig7iI7c5qu0UzxVMUae38kSsWmBxj6BNR9/zWl9HurXLR3bAblbHNiJ+kcHgQ6XsbornyKjsq03hc0cjT06gU4mURI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738167622; c=relaxed/simple;
	bh=jhR+Z0kDBvvTxM/SJ+BpMIDyBIuZjKQODCoSrK+4YGc=;
	h=Date:From:To:Cc:Subject:Message-ID; b=sB7eP7eljJRKeZRYRA30ILJZ/CyxYtYEgS/DrNESTpJ4JVI/h3p3np9fKDhQxiKVw4HDkKMyPjiMTUxiCszTDWdsAalRyruZ3wesMiGNUf1EyKgUbKFsTfZDLhpD9Y6DZqO24rIcu8b/hhsK3PBUUaKiScu8+oATHs/S+gE3xPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jkDhGLJh; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jkDhGLJh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738167621; x=1769703621;
  h=date:from:to:cc:subject:message-id;
  bh=jhR+Z0kDBvvTxM/SJ+BpMIDyBIuZjKQODCoSrK+4YGc=;
  b=jkDhGLJhxXV76Q9NzWPDVrMA215JPkyT0hGdBDSs8XgFhJElM+0cetlh
   Cv/zcDq5IFwcE0siWjNuzcxgJTwF4CLoXWmzJ32Qm8MEfDX0y9Pz3k5lN
   RVJK8+kpsByxcGOt7FipS/oSbslET1Gw0TSYIbX404l/rORhMaxFGNrSV
   z1TfUWaR4oATPWIbRQmYbfr2Yp54gjWNNtCxoeQJ94BuyL/WtwXSCMFuu
   nhqhxwLekdhnF9SxjRM91xTD8mcJGh1NUVfQGLbCK+BHJFv3qWwgUlAJo
   fNjoqyLfdBv/Zqpat0s2YpOmZtg4BPTxBwfHKpNnVjOTEcH/PLbT9LWSe
   g==;
X-CSE-ConnectionGUID: 5OkFacSTRLapbCbgY/hfYg==
X-CSE-MsgGUID: fzC9NCPISDaFQxK37EKlUw==
X-IronPort-AV: E=McAfee;i="6700,10204,11330"; a="56228595"
X-IronPort-AV: E=Sophos;i="6.13,243,1732608000"; 
   d="scan'208";a="56228595"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2025 08:20:20 -0800
X-CSE-ConnectionGUID: uajk54xHSYCPAQIJn36xIw==
X-CSE-MsgGUID: NRvt9eCKSmqArTdD9PHS0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,243,1732608000"; 
   d="scan'208";a="109186792"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 29 Jan 2025 08:20:19 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tdAnZ-000j87-11;
	Wed, 29 Jan 2025 16:20:17 +0000
Date: Thu, 30 Jan 2025 00:20:03 +0800
From: kernel test robot <lkp@intel.com>
To: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 55b8d4c01dde95f9c2d1f560094e279b78e105d7
Message-ID: <202501300057.QV2uuKag-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: 55b8d4c01dde95f9c2d1f560094e279b78e105d7  Bluetooth: MGMT: Remove unused mgmt_*_discovery_complete

elapsed time: 1164m

configs tested: 203
configs skipped: 9

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    clang-20
alpha                            allyesconfig    gcc-14.2.0
alpha                               defconfig    gcc-14.2.0
arc                              allmodconfig    clang-18
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-13.2.0
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    clang-18
arc                              allyesconfig    gcc-13.2.0
arc                                 defconfig    gcc-14.2.0
arc                     nsimosci_hs_defconfig    gcc-13.2.0
arc                   randconfig-001-20250129    gcc-13.2.0
arc                   randconfig-001-20250129    gcc-14.2.0
arc                   randconfig-002-20250129    gcc-13.2.0
arc                   randconfig-002-20250129    gcc-14.2.0
arm                              allmodconfig    clang-18
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-17
arm                               allnoconfig    gcc-14.2.0
arm                              allyesconfig    clang-18
arm                              allyesconfig    gcc-14.2.0
arm                                 defconfig    gcc-14.2.0
arm                   randconfig-001-20250129    gcc-14.2.0
arm                   randconfig-002-20250129    clang-20
arm                   randconfig-002-20250129    gcc-14.2.0
arm                   randconfig-003-20250129    gcc-14.2.0
arm                   randconfig-004-20250129    gcc-14.2.0
arm64                            allmodconfig    clang-18
arm64                             allnoconfig    gcc-14.2.0
arm64                               defconfig    gcc-14.2.0
arm64                 randconfig-001-20250129    gcc-14.2.0
arm64                 randconfig-002-20250129    gcc-14.2.0
arm64                 randconfig-003-20250129    gcc-14.2.0
arm64                 randconfig-004-20250129    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
csky                                defconfig    gcc-14.2.0
csky                  randconfig-001-20250129    gcc-14.2.0
csky                  randconfig-002-20250129    gcc-14.2.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    clang-20
hexagon                           allnoconfig    gcc-14.2.0
hexagon                          allyesconfig    clang-18
hexagon                          allyesconfig    clang-20
hexagon                             defconfig    gcc-14.2.0
hexagon               randconfig-001-20250129    clang-19
hexagon               randconfig-001-20250129    gcc-14.2.0
hexagon               randconfig-002-20250129    gcc-14.2.0
i386                             allmodconfig    clang-19
i386                              allnoconfig    clang-19
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-19
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250129    clang-19
i386        buildonly-randconfig-001-20250129    gcc-12
i386        buildonly-randconfig-002-20250129    gcc-12
i386        buildonly-randconfig-003-20250129    clang-19
i386        buildonly-randconfig-003-20250129    gcc-12
i386        buildonly-randconfig-004-20250129    clang-19
i386        buildonly-randconfig-004-20250129    gcc-12
i386        buildonly-randconfig-005-20250129    clang-19
i386        buildonly-randconfig-005-20250129    gcc-12
i386        buildonly-randconfig-006-20250129    gcc-12
i386                                defconfig    clang-19
i386                  randconfig-001-20250129    gcc-12
i386                  randconfig-002-20250129    gcc-12
i386                  randconfig-003-20250129    gcc-12
i386                  randconfig-004-20250129    gcc-12
i386                  randconfig-005-20250129    gcc-12
i386                  randconfig-006-20250129    gcc-12
i386                  randconfig-007-20250129    gcc-12
i386                  randconfig-011-20250129    gcc-12
i386                  randconfig-012-20250129    gcc-12
i386                  randconfig-013-20250129    gcc-12
i386                  randconfig-014-20250129    gcc-12
i386                  randconfig-015-20250129    gcc-12
i386                  randconfig-016-20250129    gcc-12
i386                  randconfig-017-20250129    gcc-12
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch                           defconfig    gcc-14.2.0
loongarch             randconfig-001-20250129    gcc-14.2.0
loongarch             randconfig-002-20250129    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                                defconfig    gcc-14.2.0
m68k                            q40_defconfig    gcc-13.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
microblaze                          defconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                        bcm47xx_defconfig    clang-17
mips                           ip30_defconfig    gcc-13.2.0
mips                          rb532_defconfig    clang-17
nios2                             allnoconfig    gcc-14.2.0
nios2                               defconfig    gcc-14.2.0
nios2                 randconfig-001-20250129    gcc-14.2.0
nios2                 randconfig-002-20250129    gcc-14.2.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-12
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-12
parisc                randconfig-001-20250129    gcc-14.2.0
parisc                randconfig-002-20250129    gcc-14.2.0
parisc64                            defconfig    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-16
powerpc                      arches_defconfig    clang-17
powerpc                      pcm030_defconfig    gcc-13.2.0
powerpc               randconfig-001-20250129    clang-20
powerpc               randconfig-001-20250129    gcc-14.2.0
powerpc               randconfig-002-20250129    clang-20
powerpc               randconfig-002-20250129    gcc-14.2.0
powerpc               randconfig-003-20250129    gcc-14.2.0
powerpc                     sequoia_defconfig    clang-17
powerpc                      tqm8xx_defconfig    clang-17
powerpc64             randconfig-001-20250129    clang-16
powerpc64             randconfig-001-20250129    gcc-14.2.0
powerpc64             randconfig-002-20250129    clang-18
powerpc64             randconfig-002-20250129    gcc-14.2.0
powerpc64             randconfig-003-20250129    clang-20
powerpc64             randconfig-003-20250129    gcc-14.2.0
riscv                            alldefconfig    gcc-13.2.0
riscv                            allmodconfig    clang-20
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-20
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20250129    gcc-14.2.0
riscv                 randconfig-002-20250129    gcc-14.2.0
s390                             allmodconfig    clang-19
s390                             allmodconfig    gcc-14.2.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20250129    clang-20
s390                  randconfig-002-20250129    clang-17
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-12
sh                          kfr2r09_defconfig    clang-17
sh                          r7785rp_defconfig    clang-17
sh                    randconfig-001-20250129    gcc-14.2.0
sh                    randconfig-002-20250129    gcc-14.2.0
sh                           se7751_defconfig    clang-17
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250129    gcc-14.2.0
sparc                 randconfig-002-20250129    gcc-14.2.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20250129    gcc-14.2.0
sparc64               randconfig-002-20250129    gcc-14.2.0
um                               allmodconfig    clang-20
um                                allnoconfig    clang-18
um                               allyesconfig    clang-20
um                               allyesconfig    gcc-12
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250129    gcc-12
um                    randconfig-002-20250129    gcc-12
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20250129    clang-19
x86_64      buildonly-randconfig-002-20250129    gcc-12
x86_64      buildonly-randconfig-003-20250129    gcc-12
x86_64      buildonly-randconfig-004-20250129    gcc-12
x86_64      buildonly-randconfig-005-20250129    gcc-12
x86_64      buildonly-randconfig-006-20250129    clang-19
x86_64                              defconfig    clang-19
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-19
x86_64                randconfig-001-20250129    clang-19
x86_64                randconfig-002-20250129    clang-19
x86_64                randconfig-003-20250129    clang-19
x86_64                randconfig-004-20250129    clang-19
x86_64                randconfig-005-20250129    clang-19
x86_64                randconfig-006-20250129    clang-19
x86_64                randconfig-007-20250129    clang-19
x86_64                randconfig-008-20250129    clang-19
x86_64                randconfig-071-20250129    clang-19
x86_64                randconfig-072-20250129    clang-19
x86_64                randconfig-073-20250129    clang-19
x86_64                randconfig-074-20250129    clang-19
x86_64                randconfig-075-20250129    clang-19
x86_64                randconfig-076-20250129    clang-19
x86_64                randconfig-077-20250129    clang-19
x86_64                randconfig-078-20250129    clang-19
x86_64                               rhel-9.4    clang-19
x86_64                           rhel-9.4-bpf    clang-19
x86_64                         rhel-9.4-kunit    clang-19
x86_64                           rhel-9.4-ltp    clang-19
x86_64                          rhel-9.4-rust    clang-19
xtensa                            allnoconfig    gcc-14.2.0
xtensa                  cadence_csp_defconfig    gcc-13.2.0
xtensa                       common_defconfig    gcc-13.2.0
xtensa                randconfig-001-20250129    gcc-14.2.0
xtensa                randconfig-002-20250129    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
