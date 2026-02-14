Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 589FB1DF75D
	for <linux-bluetooth@vger.kernel.org>; Sat, 14 Feb 2026 07:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771052538; cv=none; b=rVvN8rzdOOLYE3nUHeA6O2Q2SsUyd56x5oIHO63emAC+kmmn57Xtz6JQov0h4DRqHhPcMAl06sfysNZpuGvcd3IZKW08368IjyWvKVrB6w+TqPHUAlDpN7Ms0nB6+xaWJwT9Ep2M7EJsyfVwR5fG3W4baY7TrPmwsGRM2MiIEAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771052538; c=relaxed/simple;
	bh=tVoMWbRZQU0TJc/3KGPmWpOQkb8upKoOrIEouGwEdIc=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Sae6Rjqr31+VGdSiSua95jC6CiswVza5LDzGuxsdV9eo+X9o6UsMDWPo01NgyCq0JHocghsBim/Z2uAmSSlIC4qYTAnHl7vBSx8uaDmr7e/b05kMQ4iRIVkRJejReZAIS7YasxZ6lmY3yUw0wJ61NIcLQkadfUZQCV0Fm053cz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GFyPhXhf; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GFyPhXhf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771052537; x=1802588537;
  h=date:from:to:cc:subject:message-id;
  bh=tVoMWbRZQU0TJc/3KGPmWpOQkb8upKoOrIEouGwEdIc=;
  b=GFyPhXhfU0+zqxQ2NhpRfkHdqUppv3SDUQsi/c0SkU7kQYpQcpU+e2zu
   n6T3VcMiBHybVRjyR/xsh3W8UqXHKXdC+ZQwIXahzQHRabpdMrC1zgT7K
   43vKTypUNLCqxCWRYE4VFW5X+wO8REWqO/sbjg06SKFr9rPJ25vAJ1MHK
   I/Ixe0NqXDTWYX+hEnPsEiZKcs8Mua7BYtrRtR6cj+iCXSd7Rqn3Rsm6d
   wfTibzetpf2yphA0GyskbdGFnTJqFYxTxl3iBMh8jG+CwM13X69rssUXW
   6LE2zgvfXzlqsQXLvvBdd06P1qd3YEEQF32gPvAzZ6cDfEVRZA6R1nQ99
   w==;
X-CSE-ConnectionGUID: kIzMFfUDTQKLitFZVSr3KA==
X-CSE-MsgGUID: aw+MCCgjQZe+2idyVzIuZQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11700"; a="82955323"
X-IronPort-AV: E=Sophos;i="6.21,290,1763452800"; 
   d="scan'208";a="82955323"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2026 23:02:17 -0800
X-CSE-ConnectionGUID: iWpU+EngSU+5UUqwy+wQuQ==
X-CSE-MsgGUID: QT03pu8RS4G6E6hPPeWGsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,290,1763452800"; 
   d="scan'208";a="212961524"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 13 Feb 2026 23:02:16 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vr9fR-00000000wKK-1237;
	Sat, 14 Feb 2026 07:02:13 +0000
Date: Sat, 14 Feb 2026 15:01:54 +0800
From: kernel test robot <lkp@intel.com>
To: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 c53e4c6306b8a212ffb032a04e50cb85bb5b022c
Message-ID: <202602141546.dpbqRWtM-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: c53e4c6306b8a212ffb032a04e50cb85bb5b022c  Bluetooth: L2CAP: Fix response to L2CAP_ECRED_CONN_REQ

elapsed time: 731m

configs tested: 216
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
alpha                               defconfig    gcc-15.2.0
arc                              allmodconfig    clang-16
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    clang-22
arc                                 defconfig    gcc-15.2.0
arc                   randconfig-001-20260214    clang-22
arc                   randconfig-002-20260214    clang-22
arc                        vdk_hs38_defconfig    gcc-15.2.0
arc                    vdk_hs38_smp_defconfig    gcc-15.2.0
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                         at91_dt_defconfig    clang-22
arm                                 defconfig    gcc-15.2.0
arm                         lpc32xx_defconfig    clang-22
arm                          moxart_defconfig    gcc-15.2.0
arm                            mps2_defconfig    clang-22
arm                         mv78xx0_defconfig    gcc-15.2.0
arm                        neponset_defconfig    gcc-15.2.0
arm                           omap1_defconfig    gcc-15.2.0
arm                       omap2plus_defconfig    gcc-15.2.0
arm                   randconfig-001-20260214    clang-22
arm                   randconfig-002-20260214    clang-22
arm                   randconfig-003-20260214    clang-22
arm                   randconfig-004-20260214    clang-22
arm                           sama7_defconfig    clang-22
arm                           spitz_defconfig    gcc-15.2.0
arm64                            allmodconfig    clang-22
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260214    gcc-8.5.0
arm64                 randconfig-002-20260214    gcc-8.5.0
arm64                 randconfig-003-20260214    gcc-8.5.0
arm64                 randconfig-004-20260214    gcc-8.5.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260214    gcc-8.5.0
csky                  randconfig-002-20260214    gcc-8.5.0
hexagon                          alldefconfig    gcc-15.2.0
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    gcc-15.2.0
hexagon               randconfig-001-20260214    clang-22
hexagon               randconfig-002-20260214    clang-22
i386                             allmodconfig    clang-20
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20260214    clang-20
i386        buildonly-randconfig-002-20260214    clang-20
i386        buildonly-randconfig-003-20260214    clang-20
i386        buildonly-randconfig-004-20260214    clang-20
i386        buildonly-randconfig-005-20260214    clang-20
i386        buildonly-randconfig-006-20260214    clang-20
i386                                defconfig    gcc-15.2.0
i386                  randconfig-001-20260214    clang-20
i386                  randconfig-002-20260214    clang-20
i386                  randconfig-003-20260214    clang-20
i386                  randconfig-004-20260214    clang-20
i386                  randconfig-005-20260214    clang-20
i386                  randconfig-006-20260214    clang-20
i386                  randconfig-007-20260214    clang-20
i386                  randconfig-011-20260214    gcc-14
i386                  randconfig-012-20260214    gcc-14
i386                  randconfig-013-20260214    gcc-14
i386                  randconfig-014-20260214    gcc-14
i386                  randconfig-015-20260214    gcc-14
i386                  randconfig-016-20260214    gcc-14
i386                  randconfig-017-20260214    gcc-14
loongarch                        allmodconfig    clang-22
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260214    clang-22
loongarch             randconfig-002-20260214    clang-22
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    clang-16
m68k                                defconfig    clang-19
m68k                            q40_defconfig    clang-22
m68k                          sun3x_defconfig    gcc-15.2.0
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    clang-19
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
mips                        bcm63xx_defconfig    gcc-15.2.0
mips                         cobalt_defconfig    clang-22
mips                      fuloong2e_defconfig    gcc-15.2.0
mips                            gpr_defconfig    clang-22
mips                       lemote2f_defconfig    clang-22
mips                      malta_kvm_defconfig    clang-22
mips                malta_qemu_32r6_defconfig    gcc-15.2.0
mips                          rm200_defconfig    clang-22
nios2                            allmodconfig    clang-22
nios2                             allnoconfig    clang-22
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-19
nios2                 randconfig-001-20260214    clang-22
nios2                 randconfig-002-20260214    clang-22
openrisc                         allmodconfig    clang-22
openrisc                          allnoconfig    clang-22
openrisc                          allnoconfig    gcc-15.2.0
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    clang-22
parisc                            allnoconfig    gcc-15.2.0
parisc                           allyesconfig    clang-19
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260214    clang-22
parisc                randconfig-002-20260214    clang-22
parisc64                            defconfig    clang-19
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-22
powerpc                           allnoconfig    gcc-15.2.0
powerpc                      bamboo_defconfig    clang-22
powerpc                        cell_defconfig    gcc-15.2.0
powerpc                          g5_defconfig    gcc-15.2.0
powerpc                    ge_imp3a_defconfig    gcc-15.2.0
powerpc               mpc834x_itxgp_defconfig    clang-22
powerpc                     powernv_defconfig    gcc-15.2.0
powerpc               randconfig-001-20260214    clang-22
powerpc               randconfig-002-20260214    clang-22
powerpc                         wii_defconfig    gcc-15.2.0
powerpc64             randconfig-001-20260214    clang-22
powerpc64             randconfig-002-20260214    clang-22
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    clang-22
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-22
riscv                               defconfig    gcc-15.2.0
riscv                 randconfig-001-20260214    clang-20
riscv                 randconfig-002-20260214    clang-20
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    gcc-15.2.0
s390                  randconfig-001-20260214    clang-20
s390                  randconfig-002-20260214    clang-20
sh                               alldefconfig    clang-22
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-22
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    clang-19
sh                                  defconfig    gcc-14
sh                         ecovec24_defconfig    clang-22
sh                          polaris_defconfig    gcc-15.2.0
sh                    randconfig-001-20260214    clang-20
sh                    randconfig-002-20260214    clang-20
sh                          rsk7203_defconfig    gcc-15.2.0
sparc                             allnoconfig    clang-22
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260214    gcc-14.3.0
sparc                 randconfig-002-20260214    gcc-14.3.0
sparc64                          allmodconfig    clang-22
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260214    gcc-14.3.0
sparc64               randconfig-002-20260214    gcc-14.3.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260214    gcc-14.3.0
um                    randconfig-002-20260214    gcc-14.3.0
um                           x86_64_defconfig    gcc-14
x86_64                           alldefconfig    gcc-15.2.0
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                            allnoconfig    clang-22
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260214    clang-20
x86_64      buildonly-randconfig-002-20260214    clang-20
x86_64      buildonly-randconfig-003-20260214    clang-20
x86_64      buildonly-randconfig-004-20260214    clang-20
x86_64      buildonly-randconfig-005-20260214    clang-20
x86_64      buildonly-randconfig-006-20260214    clang-20
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260214    clang-20
x86_64                randconfig-002-20260214    clang-20
x86_64                randconfig-003-20260214    clang-20
x86_64                randconfig-004-20260214    clang-20
x86_64                randconfig-005-20260214    clang-20
x86_64                randconfig-006-20260214    clang-20
x86_64                randconfig-011-20260214    gcc-14
x86_64                randconfig-012-20260214    gcc-14
x86_64                randconfig-013-20260214    gcc-14
x86_64                randconfig-014-20260214    gcc-14
x86_64                randconfig-015-20260214    gcc-14
x86_64                randconfig-016-20260214    gcc-14
x86_64                randconfig-071-20260214    clang-20
x86_64                randconfig-072-20260214    clang-20
x86_64                randconfig-073-20260214    clang-20
x86_64                randconfig-074-20260214    clang-20
x86_64                randconfig-075-20260214    clang-20
x86_64                randconfig-076-20260214    clang-20
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
xtensa                       common_defconfig    gcc-15.2.0
xtensa                          iss_defconfig    clang-22
xtensa                randconfig-001-20260214    gcc-14.3.0
xtensa                randconfig-002-20260214    gcc-14.3.0
xtensa                    smp_lx200_defconfig    gcc-15.2.0
xtensa                    xip_kc705_defconfig    gcc-15.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
