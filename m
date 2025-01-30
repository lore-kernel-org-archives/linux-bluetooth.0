Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F281AF0C3
	for <linux-bluetooth@vger.kernel.org>; Thu, 30 Jan 2025 20:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738270557; cv=none; b=XQV4jmZjWK6lIqnTunTO9LXyXFB8lIweju3aJ/sa/AUKM6E9xLMcCARU3dD40shSn/nl/saw8nfsLihpI/lbLF9tEFRlZPhT3HB3XlcPMxA+oXaYtsCf6Cwol2gxwHq8ssq5oWzAGbWxn1GRA6sK0Yv1D2XMbg74UYujp964uxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738270557; c=relaxed/simple;
	bh=mKiwZYcNR9xEhdhEw+p0yq9mKTcNMCoG/2eGLIYH2xw=;
	h=Date:From:To:Cc:Subject:Message-ID; b=YfiktQVlYSp4xLLT6DrWB7ytagpYaEv57JGPYI3za03s9Fklu27ovV8i3Rx3esky0AnUjH1V68CURJnLN7syR/mkidBanVjOASiq7vobj5SIjVnnjCsjsYFMYmEN3j29+dJEKms2dGxIcUBv70/79OzBQOniAqHEUo6Taidj/l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nHkT8bqF; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nHkT8bqF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738270555; x=1769806555;
  h=date:from:to:cc:subject:message-id;
  bh=mKiwZYcNR9xEhdhEw+p0yq9mKTcNMCoG/2eGLIYH2xw=;
  b=nHkT8bqFRn9GhscHsNlDGQdp56fKVJcVNHWOvfWEAaYyCaEr3j3W3/3g
   LUwINbriusRieg3Y7Pe0UdyGnrfxtusswWO85TqAlGTfkMFJX+YZIU6bf
   LRTDSjEvjVIU0a7fmvfk9KIKO12g98q74NE6BOcjmzyqElMhZRmP1qWuO
   24AEIqSwV5+V8goFE8IpDL3EO3I8eBh75M23fEr3le1u1GUHvzwrR1VID
   mr3J3K6P4q2p+WAtExrjLdUcLA0grHyYpo92h1eDthOFkixvyH7aYZkUw
   llG7J+z0vmsj7fz3aWa8F9wCulNjke0yKibkjnIjCLRSsKN1EwoqbtI28
   w==;
X-CSE-ConnectionGUID: TEevlL3TRx+Qt3eVDS0z4Q==
X-CSE-MsgGUID: KFn/8APCQ4Wvnm2wTE7ueg==
X-IronPort-AV: E=McAfee;i="6700,10204,11331"; a="41672836"
X-IronPort-AV: E=Sophos;i="6.13,246,1732608000"; 
   d="scan'208";a="41672836"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2025 12:55:54 -0800
X-CSE-ConnectionGUID: gI+v0q9FQ+WIkgrYcjLfWA==
X-CSE-MsgGUID: CF+drZV8SDWplFUuN7y6Ag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,246,1732608000"; 
   d="scan'208";a="114446786"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 30 Jan 2025 12:55:53 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tdbZn-000kxr-1F;
	Thu, 30 Jan 2025 20:55:51 +0000
Date: Fri, 31 Jan 2025 04:54:55 +0800
From: kernel test robot <lkp@intel.com>
To: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 e3d78d54bed506d7bc38f7d069631be0d9d0fea0
Message-ID: <202501310449.CtKuojVU-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: e3d78d54bed506d7bc38f7d069631be0d9d0fea0  Bluetooth: btintel: Add DSBR support for ScP

elapsed time: 1411m

configs tested: 216
configs skipped: 8

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    clang-21
alpha                            allyesconfig    gcc-14.2.0
alpha                               defconfig    gcc-14.2.0
arc                              allmodconfig    clang-18
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-13.2.0
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    clang-18
arc                              allyesconfig    gcc-13.2.0
arc                                 defconfig    gcc-14.2.0
arc                 nsimosci_hs_smp_defconfig    clang-20
arc                   randconfig-001-20250130    gcc-13.2.0
arc                   randconfig-002-20250130    gcc-13.2.0
arm                              allmodconfig    clang-18
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-17
arm                               allnoconfig    gcc-14.2.0
arm                              allyesconfig    clang-18
arm                              allyesconfig    gcc-14.2.0
arm                          collie_defconfig    gcc-14.2.0
arm                                 defconfig    gcc-14.2.0
arm                        multi_v7_defconfig    clang-20
arm                        mvebu_v5_defconfig    gcc-14.2.0
arm                       netwinder_defconfig    gcc-14.2.0
arm                   randconfig-001-20250130    gcc-14.2.0
arm                   randconfig-002-20250130    clang-20
arm                   randconfig-003-20250130    gcc-14.2.0
arm                   randconfig-004-20250130    clang-20
arm                           stm32_defconfig    clang-20
arm64                            allmodconfig    clang-18
arm64                             allnoconfig    gcc-14.2.0
arm64                               defconfig    gcc-14.2.0
arm64                 randconfig-001-20250130    clang-20
arm64                 randconfig-002-20250130    gcc-14.2.0
arm64                 randconfig-003-20250130    clang-20
arm64                 randconfig-004-20250130    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
csky                                defconfig    gcc-14.2.0
csky                  randconfig-001-20250130    clang-21
csky                  randconfig-001-20250130    gcc-14.2.0
csky                  randconfig-002-20250130    clang-21
csky                  randconfig-002-20250130    gcc-14.2.0
hexagon                          allmodconfig    clang-20
hexagon                          allmodconfig    clang-21
hexagon                           allnoconfig    clang-20
hexagon                           allnoconfig    gcc-14.2.0
hexagon                          allyesconfig    clang-18
hexagon                          allyesconfig    clang-21
hexagon               randconfig-001-20250130    clang-20
hexagon               randconfig-001-20250130    clang-21
hexagon               randconfig-002-20250130    clang-20
hexagon               randconfig-002-20250130    clang-21
i386                             allmodconfig    clang-19
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-19
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-19
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250130    clang-19
i386        buildonly-randconfig-002-20250130    clang-19
i386        buildonly-randconfig-003-20250130    gcc-11
i386        buildonly-randconfig-004-20250130    gcc-12
i386        buildonly-randconfig-005-20250130    gcc-12
i386        buildonly-randconfig-006-20250130    gcc-12
i386                                defconfig    clang-19
i386                  randconfig-001-20250130    gcc-12
i386                  randconfig-002-20250130    gcc-12
i386                  randconfig-003-20250130    gcc-12
i386                  randconfig-004-20250130    gcc-12
i386                  randconfig-005-20250130    gcc-12
i386                  randconfig-006-20250130    gcc-12
i386                  randconfig-007-20250130    gcc-12
i386                  randconfig-011-20250130    clang-19
i386                  randconfig-012-20250130    clang-19
i386                  randconfig-013-20250130    clang-19
i386                  randconfig-014-20250130    clang-19
i386                  randconfig-015-20250130    clang-19
i386                  randconfig-016-20250130    clang-19
i386                  randconfig-017-20250130    clang-19
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch                           defconfig    gcc-14.2.0
loongarch             randconfig-001-20250130    clang-21
loongarch             randconfig-001-20250130    gcc-14.2.0
loongarch             randconfig-002-20250130    clang-21
loongarch             randconfig-002-20250130    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                                defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
microblaze                          defconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                     loongson1b_defconfig    clang-20
mips                        omega2p_defconfig    clang-20
nios2                             allnoconfig    gcc-14.2.0
nios2                               defconfig    gcc-14.2.0
nios2                 randconfig-001-20250130    clang-21
nios2                 randconfig-001-20250130    gcc-14.2.0
nios2                 randconfig-002-20250130    clang-21
nios2                 randconfig-002-20250130    gcc-14.2.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-12
parisc                randconfig-001-20250130    clang-21
parisc                randconfig-001-20250130    gcc-14.2.0
parisc                randconfig-002-20250130    clang-21
parisc                randconfig-002-20250130    gcc-14.2.0
parisc64                            defconfig    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-16
powerpc                          allyesconfig    gcc-14.2.0
powerpc                 linkstation_defconfig    clang-20
powerpc               randconfig-001-20250130    clang-21
powerpc               randconfig-001-20250130    gcc-14.2.0
powerpc               randconfig-002-20250130    clang-16
powerpc               randconfig-002-20250130    clang-21
powerpc               randconfig-003-20250130    clang-21
powerpc               randconfig-003-20250130    gcc-14.2.0
powerpc64             randconfig-001-20250130    clang-21
powerpc64             randconfig-001-20250130    gcc-14.2.0
powerpc64             randconfig-002-20250130    clang-20
powerpc64             randconfig-002-20250130    clang-21
powerpc64             randconfig-003-20250130    clang-20
powerpc64             randconfig-003-20250130    clang-21
riscv                            allmodconfig    clang-20
riscv                            allmodconfig    gcc-14.2.0
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-20
riscv                            allyesconfig    gcc-14.2.0
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20250130    clang-20
riscv                 randconfig-001-20250130    gcc-14.2.0
riscv                 randconfig-002-20250130    gcc-14.2.0
s390                             allmodconfig    clang-19
s390                             allmodconfig    gcc-14.2.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20250130    gcc-14.2.0
s390                  randconfig-002-20250130    clang-20
s390                  randconfig-002-20250130    gcc-14.2.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-12
sh                          r7785rp_defconfig    gcc-14.2.0
sh                    randconfig-001-20250130    gcc-14.2.0
sh                    randconfig-002-20250130    gcc-14.2.0
sh                           se7722_defconfig    clang-20
sh                           se7722_defconfig    gcc-14.2.0
sh                   secureedge5410_defconfig    gcc-14.2.0
sh                        sh7763rdp_defconfig    gcc-14.2.0
sh                  sh7785lcr_32bit_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250130    gcc-14.2.0
sparc                 randconfig-002-20250130    gcc-14.2.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20250130    gcc-14.2.0
sparc64               randconfig-002-20250130    gcc-14.2.0
um                               allmodconfig    clang-20
um                               allmodconfig    clang-21
um                                allnoconfig    clang-18
um                               allyesconfig    clang-21
um                               allyesconfig    gcc-12
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250130    gcc-12
um                    randconfig-001-20250130    gcc-14.2.0
um                    randconfig-002-20250130    gcc-12
um                    randconfig-002-20250130    gcc-14.2.0
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20250130    clang-19
x86_64      buildonly-randconfig-002-20250130    gcc-12
x86_64      buildonly-randconfig-003-20250130    gcc-12
x86_64      buildonly-randconfig-004-20250130    clang-19
x86_64      buildonly-randconfig-005-20250130    gcc-12
x86_64      buildonly-randconfig-006-20250130    gcc-12
x86_64                              defconfig    clang-19
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-19
x86_64                randconfig-001-20250130    gcc-12
x86_64                randconfig-002-20250130    gcc-12
x86_64                randconfig-003-20250130    gcc-12
x86_64                randconfig-004-20250130    gcc-12
x86_64                randconfig-005-20250130    gcc-12
x86_64                randconfig-006-20250130    gcc-12
x86_64                randconfig-007-20250130    gcc-12
x86_64                randconfig-008-20250130    gcc-12
x86_64                randconfig-071-20250130    clang-19
x86_64                randconfig-072-20250130    clang-19
x86_64                randconfig-073-20250130    clang-19
x86_64                randconfig-074-20250130    clang-19
x86_64                randconfig-075-20250130    clang-19
x86_64                randconfig-076-20250130    clang-19
x86_64                randconfig-077-20250130    clang-19
x86_64                randconfig-078-20250130    clang-19
x86_64                               rhel-9.4    clang-19
x86_64                           rhel-9.4-bpf    clang-19
x86_64                         rhel-9.4-kunit    clang-19
x86_64                           rhel-9.4-ltp    clang-19
x86_64                          rhel-9.4-rust    clang-19
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250130    gcc-14.2.0
xtensa                randconfig-002-20250130    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
