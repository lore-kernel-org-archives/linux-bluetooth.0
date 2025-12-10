Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B5E3009C7
	for <linux-bluetooth@vger.kernel.org>; Wed, 10 Dec 2025 18:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765390906; cv=none; b=pCdZl3ORRzsy3vUnc9A2ZaijhOKlUv7An250U8fqg6v81+/nii1JUohU8NzXXF/3/crU9+KGRLn3S1iNYgnVMxPkT7edGUcZQfwIiwQFs15EaEMYfWSY9JLXSSbr/WzwMfysQ4quQqE9sJQ1ak2te0LepSUwc8Xhc/xMw4H9Zgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765390906; c=relaxed/simple;
	bh=I7rdQE8GO8ClemWPc7y9Ub2BFM3VRHxU7odpKrbHKQ0=;
	h=Date:From:To:Cc:Subject:Message-ID; b=QGZgAPbUr9i0MBcVHA7TlMBmYx3aKLXV88KDYAvGyd/IJ5TDWeyYIzgoDNSlCJXjozgIsUnbfp6CNGgfw/vPFBTigxMKdmh5iduXz7A+PT0udOd77qP3IsJdKk6DcrFVyV5+RycDrC5GlhxD+gCAWdllarD/HjoFgrq5OGMsWCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aA4SXOCd; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aA4SXOCd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765390905; x=1796926905;
  h=date:from:to:cc:subject:message-id;
  bh=I7rdQE8GO8ClemWPc7y9Ub2BFM3VRHxU7odpKrbHKQ0=;
  b=aA4SXOCdxqQrgy9lBDGvGdQNOZjrv4JdASDjQA812YyqLvNFMVBJeiLs
   UsPIe8/8aa64oP6FsgmgC/P8dKbZfosJ3otVUOqgY2Tru/0+LYmnhBTae
   c9lYzH/QX46qqbHNPVPPW4F7jGR2NfAcPq2FzTBgL5zMhdIeHZVNaTdTC
   YwcG3efWKHYyYeNe2BaIxaqEU+gf6A+j8rxeFIQT15/iVxkIVZDmSOAPh
   UwICZT9jboIlsnBZMGsaodzuks50ZbZ5tIl/LN/O06pxNZvYVKdEzp4SU
   E0DyQV7J+3gs7UoeKv2MGwhhS0pbEjO28OQUDpPjE5ru8wGvy/s6uSD95
   g==;
X-CSE-ConnectionGUID: 3CXEOHCnSV28cLJFqOpvaQ==
X-CSE-MsgGUID: maHsLipGSsaqi0GobUtEhw==
X-IronPort-AV: E=McAfee;i="6800,10657,11638"; a="71217690"
X-IronPort-AV: E=Sophos;i="6.20,264,1758610800"; 
   d="scan'208";a="71217690"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2025 10:21:44 -0800
X-CSE-ConnectionGUID: SsGdnJhFRZCPT1P8+qFuQw==
X-CSE-MsgGUID: gx2Y0tamSrWV6C4jkpmDQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,264,1758610800"; 
   d="scan'208";a="201023651"
Received: from lkp-server01.sh.intel.com (HELO d335e3c6db51) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 10 Dec 2025 10:21:43 -0800
Received: from kbuild by d335e3c6db51 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vTOon-000000003cn-0dye;
	Wed, 10 Dec 2025 18:21:41 +0000
Date: Thu, 11 Dec 2025 02:20:48 +0800
From: kernel test robot <lkp@intel.com>
To: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 3d55304c6e437fe5e7fc02a3b7966d928bbb0b83
Message-ID: <202512110242.SzA1fMs0-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: 3d55304c6e437fe5e7fc02a3b7966d928bbb0b83  Bluetooth: MGMT: report BIS capability flags in supported settings

elapsed time: 1255m

configs tested: 186
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    gcc-15.1.0
arc                              allmodconfig    clang-16
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    clang-22
arc                          axs103_defconfig    gcc-15.1.0
arc                                 defconfig    gcc-15.1.0
arc                   randconfig-001-20251210    gcc-11.5.0
arc                   randconfig-002-20251210    gcc-11.5.0
arm                               allnoconfig    gcc-15.1.0
arm                              allyesconfig    clang-16
arm                                 defconfig    gcc-15.1.0
arm                        neponset_defconfig    gcc-15.1.0
arm                           omap1_defconfig    gcc-15.1.0
arm                   randconfig-001-20251210    gcc-11.5.0
arm                   randconfig-002-20251210    gcc-11.5.0
arm                   randconfig-003-20251210    gcc-11.5.0
arm                   randconfig-004-20251210    gcc-11.5.0
arm                           sama5_defconfig    gcc-15.1.0
arm                         vf610m4_defconfig    gcc-15.1.0
arm64                            allmodconfig    clang-22
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    gcc-15.1.0
arm64                 randconfig-001-20251210    clang-17
arm64                 randconfig-002-20251210    clang-17
arm64                 randconfig-003-20251210    clang-17
arm64                 randconfig-004-20251210    clang-17
csky                             allmodconfig    gcc-15.1.0
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    gcc-15.1.0
csky                  randconfig-001-20251210    clang-17
csky                  randconfig-002-20251210    clang-17
hexagon                          allmodconfig    gcc-15.1.0
hexagon                           allnoconfig    gcc-15.1.0
hexagon                             defconfig    gcc-15.1.0
hexagon               randconfig-001-20251210    gcc-10.5.0
hexagon               randconfig-002-20251210    gcc-10.5.0
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-15.1.0
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20251210    clang-20
i386        buildonly-randconfig-002-20251210    clang-20
i386        buildonly-randconfig-003-20251210    clang-20
i386        buildonly-randconfig-004-20251210    clang-20
i386        buildonly-randconfig-005-20251210    clang-20
i386        buildonly-randconfig-006-20251210    clang-20
i386                                defconfig    gcc-15.1.0
i386                  randconfig-001-20251210    clang-20
i386                  randconfig-002-20251210    clang-20
i386                  randconfig-003-20251210    clang-20
i386                  randconfig-004-20251210    clang-20
i386                  randconfig-005-20251210    clang-20
i386                  randconfig-006-20251210    clang-20
i386                  randconfig-007-20251210    clang-20
i386                  randconfig-011-20251210    gcc-14
i386                  randconfig-012-20251210    gcc-14
i386                  randconfig-013-20251210    gcc-14
i386                  randconfig-014-20251210    gcc-14
i386                  randconfig-015-20251210    gcc-14
i386                  randconfig-016-20251210    gcc-14
i386                  randconfig-017-20251210    gcc-14
loongarch                        allmodconfig    clang-22
loongarch                         allnoconfig    gcc-15.1.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20251210    gcc-10.5.0
loongarch             randconfig-002-20251210    gcc-10.5.0
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    clang-16
m68k                          amiga_defconfig    gcc-15.1.0
m68k                                defconfig    clang-19
m68k                       m5275evb_defconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    clang-19
mips                             allmodconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                             allyesconfig    gcc-15.1.0
nios2                            allmodconfig    clang-22
nios2                             allnoconfig    clang-22
nios2                               defconfig    clang-19
nios2                 randconfig-001-20251210    gcc-10.5.0
nios2                 randconfig-002-20251210    gcc-10.5.0
openrisc                         allmodconfig    clang-22
openrisc                          allnoconfig    clang-22
openrisc                            defconfig    gcc-15.1.0
parisc                           alldefconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    clang-22
parisc                           allyesconfig    clang-19
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20251210    clang-19
parisc                randconfig-002-20251210    clang-19
parisc64                            defconfig    clang-19
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-22
powerpc                      bamboo_defconfig    gcc-15.1.0
powerpc                          g5_defconfig    gcc-15.1.0
powerpc                     kmeter1_defconfig    gcc-15.1.0
powerpc               randconfig-001-20251210    clang-19
powerpc               randconfig-002-20251210    clang-19
powerpc                     taishan_defconfig    gcc-15.1.0
powerpc                     tqm8541_defconfig    gcc-15.1.0
powerpc                         wii_defconfig    gcc-15.1.0
powerpc64             randconfig-001-20251210    clang-19
powerpc64             randconfig-002-20251210    clang-19
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    clang-22
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-15.1.0
riscv                 randconfig-001-20251210    clang-22
riscv                 randconfig-002-20251210    clang-22
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    gcc-15.1.0
s390                  randconfig-001-20251210    clang-22
s390                  randconfig-002-20251210    clang-22
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    clang-22
sh                               allyesconfig    clang-19
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-14
sh                    randconfig-001-20251210    clang-22
sh                    randconfig-002-20251210    clang-22
sh                          rsk7264_defconfig    gcc-15.1.0
sh                      rts7751r2d1_defconfig    gcc-15.1.0
sparc                             allnoconfig    clang-22
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20251210    gcc-15.1.0
sparc                 randconfig-002-20251210    gcc-15.1.0
sparc64                          allmodconfig    clang-22
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20251210    gcc-15.1.0
sparc64               randconfig-002-20251210    gcc-15.1.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-15.1.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20251210    gcc-15.1.0
um                    randconfig-002-20251210    gcc-15.1.0
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-22
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20251210    clang-20
x86_64      buildonly-randconfig-002-20251210    clang-20
x86_64      buildonly-randconfig-003-20251210    clang-20
x86_64      buildonly-randconfig-004-20251210    clang-20
x86_64      buildonly-randconfig-005-20251210    clang-20
x86_64      buildonly-randconfig-006-20251210    clang-20
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20251210    gcc-14
x86_64                randconfig-002-20251210    gcc-14
x86_64                randconfig-003-20251210    gcc-14
x86_64                randconfig-004-20251210    gcc-14
x86_64                randconfig-005-20251210    gcc-14
x86_64                randconfig-006-20251210    gcc-14
x86_64                randconfig-011-20251210    clang-20
x86_64                randconfig-012-20251210    clang-20
x86_64                randconfig-013-20251210    clang-20
x86_64                randconfig-014-20251210    clang-20
x86_64                randconfig-015-20251210    clang-20
x86_64                randconfig-016-20251210    clang-20
x86_64                randconfig-071-20251210    clang-20
x86_64                randconfig-072-20251210    clang-20
x86_64                randconfig-073-20251210    clang-20
x86_64                randconfig-074-20251210    clang-20
x86_64                randconfig-075-20251210    clang-20
x86_64                randconfig-076-20251210    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    clang-22
xtensa                           allyesconfig    clang-22
xtensa                randconfig-001-20251210    gcc-15.1.0
xtensa                randconfig-002-20251210    gcc-15.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
