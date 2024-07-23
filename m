Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DDE91DA22
	for <linux-bluetooth@vger.kernel.org>; Tue, 23 Jul 2024 15:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721749603; cv=none; b=naXnkjoR0f/gbzHP8ypg+zxMDqhWKipDD3v3VsVrmJdvfE5/2mLrOEIdfkZAE+FanwuPwGQiZu3TMyulp5ktKJvRHuFYCd914GAPUA3qQO0v2Qq7R/S7/4SCKK1y40si20pMmwM2KbwBCOB44yzwXK3uwagyNQ99105g/3o0grk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721749603; c=relaxed/simple;
	bh=YykV1wncQV5qAWzvCQ/stiQ/s0wU9isBsR5kLujKbYw=;
	h=Date:From:To:Cc:Subject:Message-ID; b=fO4DksQWiPi/b/0W+i08dTEs/TTFda0FtfdolgSMuU6gGOtycTa9EPO8CUEqs+UacGOnJwyeqh8RY7/EBjxO2VFr44BJY+6SzDqfTdGh5moET/sqyhuY5/Dw54umOHr8MqYd3SoNYiOLLQzkPW34OgDQOoGTtpM5UMYW+PfZk+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KrxABGJF; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KrxABGJF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721749601; x=1753285601;
  h=date:from:to:cc:subject:message-id;
  bh=YykV1wncQV5qAWzvCQ/stiQ/s0wU9isBsR5kLujKbYw=;
  b=KrxABGJFIp9wSWDTpFJYxIS+7/EnH4y+GjcZCn2Q/UlGUO4jxsYDM1jq
   FvrvLHx8dI1xlYgpyA+8SzZixQ/D3qXdv57HTx8E9ZmEeanS4JasHmQn5
   hmkTlLTgCWJ0qG6k97XY8rGe61TTbBe3RrnF6Ox8KVqFiKJwk8DKUd/Oy
   txeQOqTT+a3toNGQb8rTh56pV9Kfd5Q3nB1p8gHsPB7/BWtAISgQiUuej
   qJG9yKQahVn/poD5/wOJOiyxfht1H8DC4PJBdfMJ7+PLaqXSbUBfwYW+0
   G99w0IHo01PPbhRSkUqVmYNhfeHxBRpScIft//bdX0hm/Q7yDg5cwuZuN
   g==;
X-CSE-ConnectionGUID: PbYcNlq6TcufL655f1r5gQ==
X-CSE-MsgGUID: ynXDMVZESCGM+aI9Fpo8tg==
X-IronPort-AV: E=McAfee;i="6700,10204,11142"; a="19193818"
X-IronPort-AV: E=Sophos;i="6.09,230,1716274800"; 
   d="scan'208";a="19193818"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2024 08:46:41 -0700
X-CSE-ConnectionGUID: Y0A+UXVvSmqsBitXM5Uq7w==
X-CSE-MsgGUID: tryzIHhNSA+qNxZTXfKSgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,230,1716274800"; 
   d="scan'208";a="52295643"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 23 Jul 2024 08:46:39 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sWHim-000m4c-35;
	Tue, 23 Jul 2024 15:46:36 +0000
Date: Tue, 23 Jul 2024 23:46:15 +0800
From: kernel test robot <lkp@intel.com>
To: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD REGRESSION
 c707097a446ce3d284bc9f05736dc4701d2b8168
Message-ID: <202407232311.FeGJfo4H-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: c707097a446ce3d284bc9f05736dc4701d2b8168  Bluetooth: btintel: Allow configuring drive strength of BRI

Error/Warning ids grouped by kconfigs:

recent_errors
|-- arm64-randconfig-051-20240723
|   |-- arch-arm64-boot-dts-qcom-sm8650-qrd.dtb:bluetooth:vddrfa1p8-supply-is-a-required-property
|   |-- arch-arm64-boot-dts-qcom-sm8650-qrd.dtb:bluetooth:vddrfacmn-supply-is-a-required-property
|   |-- arch-arm64-boot-dts-qcom-sm8650-qrd.dtb:bluetooth:vddwlcx-supply-is-a-required-property
|   `-- arch-arm64-boot-dts-qcom-sm8650-qrd.dtb:bluetooth:vddwlmx-supply-is-a-required-property
`-- sparc-randconfig-001-20240723
    |-- (.head.text):relocation-truncated-to-fit:R_SPARC_WDISP22-against-init.text
    `-- (.init.text):relocation-truncated-to-fit:R_SPARC_WDISP22-against-symbol-leon_smp_cpu_startup-defined-in-.text-section-in-arch-sparc-kernel-trampoline_32.o

elapsed time: 1377m

configs tested: 286
configs skipped: 8

tested configs:
alpha                             allnoconfig   gcc-13.2.0
alpha                             allnoconfig   gcc-13.3.0
alpha                            allyesconfig   gcc-13.3.0
alpha                               defconfig   gcc-13.2.0
alpha                               defconfig   gcc-13.3.0
arc                              allmodconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                              allyesconfig   gcc-13.2.0
arc                          axs101_defconfig   gcc-13.2.0
arc                                 defconfig   gcc-13.2.0
arc                   randconfig-001-20240723   gcc-13.2.0
arc                   randconfig-002-20240723   gcc-13.2.0
arc                        vdk_hs38_defconfig   gcc-13.2.0
arm                              allmodconfig   gcc-13.2.0
arm                              allmodconfig   gcc-14.1.0
arm                               allnoconfig   clang-19
arm                               allnoconfig   gcc-13.2.0
arm                              allyesconfig   gcc-13.2.0
arm                              allyesconfig   gcc-14.1.0
arm                         axm55xx_defconfig   clang-19
arm                          collie_defconfig   gcc-13.2.0
arm                                 defconfig   clang-14
arm                                 defconfig   gcc-13.2.0
arm                         lpc32xx_defconfig   gcc-13.2.0
arm                            mmp2_defconfig   gcc-14.1.0
arm                          moxart_defconfig   gcc-13.2.0
arm                        neponset_defconfig   gcc-13.2.0
arm                        neponset_defconfig   gcc-14.1.0
arm                       omap2plus_defconfig   gcc-13.2.0
arm                   randconfig-001-20240723   gcc-13.2.0
arm                   randconfig-001-20240723   gcc-14.1.0
arm                   randconfig-002-20240723   gcc-13.2.0
arm                   randconfig-002-20240723   gcc-14.1.0
arm                   randconfig-003-20240723   gcc-13.2.0
arm                   randconfig-003-20240723   gcc-14.1.0
arm                   randconfig-004-20240723   clang-19
arm                   randconfig-004-20240723   gcc-13.2.0
arm                          sp7021_defconfig   gcc-13.2.0
arm                        vexpress_defconfig   gcc-13.2.0
arm64                            alldefconfig   gcc-13.2.0
arm64                            allmodconfig   clang-19
arm64                            allmodconfig   gcc-13.2.0
arm64                             allnoconfig   gcc-13.2.0
arm64                             allnoconfig   gcc-14.1.0
arm64                               defconfig   gcc-13.2.0
arm64                               defconfig   gcc-14.1.0
arm64                 randconfig-001-20240723   gcc-13.2.0
arm64                 randconfig-001-20240723   gcc-14.1.0
arm64                 randconfig-002-20240723   gcc-13.2.0
arm64                 randconfig-002-20240723   gcc-14.1.0
arm64                 randconfig-003-20240723   clang-19
arm64                 randconfig-003-20240723   gcc-13.2.0
arm64                 randconfig-004-20240723   clang-16
arm64                 randconfig-004-20240723   gcc-13.2.0
csky                              allnoconfig   gcc-13.2.0
csky                              allnoconfig   gcc-14.1.0
csky                                defconfig   gcc-13.2.0
csky                                defconfig   gcc-14.1.0
csky                  randconfig-001-20240723   gcc-13.2.0
csky                  randconfig-001-20240723   gcc-14.1.0
csky                  randconfig-002-20240723   gcc-13.2.0
csky                  randconfig-002-20240723   gcc-14.1.0
hexagon                          allmodconfig   clang-19
hexagon                           allnoconfig   clang-19
hexagon                          allyesconfig   clang-19
hexagon                             defconfig   clang-19
hexagon               randconfig-001-20240723   clang-19
hexagon               randconfig-002-20240723   clang-19
i386                             allmodconfig   clang-18
i386                             allmodconfig   gcc-13
i386                              allnoconfig   clang-18
i386                              allnoconfig   gcc-13
i386                             allyesconfig   clang-18
i386                             allyesconfig   gcc-13
i386         buildonly-randconfig-001-20240723   gcc-8
i386         buildonly-randconfig-002-20240723   gcc-8
i386         buildonly-randconfig-003-20240723   gcc-13
i386         buildonly-randconfig-003-20240723   gcc-8
i386         buildonly-randconfig-004-20240723   gcc-12
i386         buildonly-randconfig-004-20240723   gcc-8
i386         buildonly-randconfig-005-20240723   clang-18
i386         buildonly-randconfig-005-20240723   gcc-8
i386         buildonly-randconfig-006-20240723   clang-18
i386         buildonly-randconfig-006-20240723   gcc-8
i386                                defconfig   clang-18
i386                  randconfig-001-20240723   clang-18
i386                  randconfig-001-20240723   gcc-8
i386                  randconfig-002-20240723   gcc-12
i386                  randconfig-002-20240723   gcc-8
i386                  randconfig-003-20240723   gcc-13
i386                  randconfig-003-20240723   gcc-8
i386                  randconfig-004-20240723   gcc-10
i386                  randconfig-004-20240723   gcc-8
i386                  randconfig-005-20240723   gcc-13
i386                  randconfig-005-20240723   gcc-8
i386                  randconfig-006-20240723   gcc-13
i386                  randconfig-006-20240723   gcc-8
i386                  randconfig-011-20240723   gcc-11
i386                  randconfig-011-20240723   gcc-8
i386                  randconfig-012-20240723   clang-18
i386                  randconfig-012-20240723   gcc-8
i386                  randconfig-013-20240723   clang-18
i386                  randconfig-013-20240723   gcc-8
i386                  randconfig-014-20240723   gcc-7
i386                  randconfig-014-20240723   gcc-8
i386                  randconfig-015-20240723   gcc-13
i386                  randconfig-015-20240723   gcc-8
i386                  randconfig-016-20240723   clang-18
i386                  randconfig-016-20240723   gcc-8
loongarch                        allmodconfig   gcc-14.1.0
loongarch                         allnoconfig   gcc-13.2.0
loongarch                         allnoconfig   gcc-14.1.0
loongarch                           defconfig   gcc-13.2.0
loongarch                           defconfig   gcc-14.1.0
loongarch                 loongson3_defconfig   gcc-13.2.0
loongarch             randconfig-001-20240723   gcc-13.2.0
loongarch             randconfig-001-20240723   gcc-14.1.0
loongarch             randconfig-002-20240723   gcc-13.2.0
loongarch             randconfig-002-20240723   gcc-14.1.0
m68k                             allmodconfig   gcc-14.1.0
m68k                              allnoconfig   gcc-13.2.0
m68k                              allnoconfig   gcc-14.1.0
m68k                             allyesconfig   gcc-14.1.0
m68k                          atari_defconfig   gcc-13.2.0
m68k                                defconfig   gcc-13.2.0
m68k                                defconfig   gcc-14.1.0
m68k                       m5475evb_defconfig   gcc-13.2.0
m68k                            mac_defconfig   gcc-13.2.0
m68k                        mvme147_defconfig   gcc-13.2.0
microblaze                       allmodconfig   gcc-14.1.0
microblaze                        allnoconfig   gcc-13.2.0
microblaze                        allnoconfig   gcc-14.1.0
microblaze                       allyesconfig   gcc-14.1.0
microblaze                          defconfig   gcc-13.2.0
microblaze                          defconfig   gcc-14.1.0
microblaze                      mmu_defconfig   gcc-14.1.0
mips                              allnoconfig   gcc-13.2.0
mips                              allnoconfig   gcc-14.1.0
mips                     cu1000-neo_defconfig   gcc-13.2.0
mips                            gpr_defconfig   clang-19
mips                           ip28_defconfig   gcc-13.2.0
mips                     loongson1c_defconfig   gcc-13.2.0
mips                      maltaaprp_defconfig   clang-14
mips                        maltaup_defconfig   gcc-13.2.0
mips                      pic32mzda_defconfig   gcc-13.2.0
mips                          rb532_defconfig   clang-19
mips                   sb1250_swarm_defconfig   gcc-14.1.0
nios2                             allnoconfig   gcc-13.2.0
nios2                             allnoconfig   gcc-14.1.0
nios2                               defconfig   gcc-13.2.0
nios2                               defconfig   gcc-14.1.0
nios2                 randconfig-001-20240723   gcc-13.2.0
nios2                 randconfig-001-20240723   gcc-14.1.0
nios2                 randconfig-002-20240723   gcc-13.2.0
nios2                 randconfig-002-20240723   gcc-14.1.0
openrisc                          allnoconfig   gcc-14.1.0
openrisc                         allyesconfig   gcc-14.1.0
openrisc                            defconfig   gcc-14.1.0
parisc                           allmodconfig   gcc-14.1.0
parisc                            allnoconfig   gcc-14.1.0
parisc                           allyesconfig   gcc-14.1.0
parisc                              defconfig   gcc-14.1.0
parisc                randconfig-001-20240723   gcc-13.2.0
parisc                randconfig-001-20240723   gcc-14.1.0
parisc                randconfig-002-20240723   gcc-13.2.0
parisc                randconfig-002-20240723   gcc-14.1.0
parisc64                            defconfig   gcc-13.2.0
parisc64                            defconfig   gcc-14.1.0
powerpc                          allmodconfig   gcc-14.1.0
powerpc                           allnoconfig   gcc-14.1.0
powerpc                          allyesconfig   clang-19
powerpc                          allyesconfig   gcc-14.1.0
powerpc                      ep88xc_defconfig   gcc-13.2.0
powerpc                    ge_imp3a_defconfig   gcc-13.2.0
powerpc                 mpc8313_rdb_defconfig   gcc-13.2.0
powerpc                 mpc836x_rdk_defconfig   gcc-13.2.0
powerpc                 mpc837x_rdb_defconfig   gcc-13.2.0
powerpc                       ppc64_defconfig   clang-19
powerpc               randconfig-001-20240723   gcc-13.2.0
powerpc               randconfig-001-20240723   gcc-14.1.0
powerpc               randconfig-002-20240723   gcc-13.2.0
powerpc               randconfig-002-20240723   gcc-14.1.0
powerpc               randconfig-003-20240723   gcc-13.2.0
powerpc               randconfig-003-20240723   gcc-14.1.0
powerpc                     taishan_defconfig   clang-19
powerpc                     taishan_defconfig   gcc-13.2.0
powerpc                     tqm5200_defconfig   gcc-14.1.0
powerpc64             randconfig-001-20240723   gcc-13.2.0
powerpc64             randconfig-001-20240723   gcc-14.1.0
powerpc64             randconfig-002-20240723   gcc-13.2.0
powerpc64             randconfig-002-20240723   gcc-14.1.0
powerpc64             randconfig-003-20240723   clang-14
powerpc64             randconfig-003-20240723   gcc-13.2.0
riscv                            allmodconfig   clang-19
riscv                            allmodconfig   gcc-14.1.0
riscv                             allnoconfig   gcc-14.1.0
riscv                            allyesconfig   clang-19
riscv                            allyesconfig   gcc-14.1.0
riscv                               defconfig   gcc-14.1.0
riscv                    nommu_virt_defconfig   clang-19
riscv                 randconfig-001-20240723   gcc-13.2.0
riscv                 randconfig-001-20240723   gcc-14.1.0
riscv                 randconfig-002-20240723   clang-17
riscv                 randconfig-002-20240723   gcc-13.2.0
s390                             allmodconfig   clang-19
s390                              allnoconfig   clang-19
s390                              allnoconfig   gcc-14.1.0
s390                             allyesconfig   clang-19
s390                             allyesconfig   gcc-14.1.0
s390                                defconfig   gcc-14.1.0
s390                  randconfig-001-20240723   clang-19
s390                  randconfig-001-20240723   gcc-13.2.0
s390                  randconfig-002-20240723   clang-19
s390                  randconfig-002-20240723   gcc-13.2.0
sh                               allmodconfig   gcc-14.1.0
sh                                allnoconfig   gcc-13.2.0
sh                                allnoconfig   gcc-14.1.0
sh                               allyesconfig   gcc-14.1.0
sh                         ap325rxa_defconfig   gcc-13.2.0
sh                                  defconfig   gcc-14.1.0
sh                    randconfig-001-20240723   gcc-13.2.0
sh                    randconfig-001-20240723   gcc-14.1.0
sh                    randconfig-002-20240723   gcc-13.2.0
sh                    randconfig-002-20240723   gcc-14.1.0
sh                           se7724_defconfig   gcc-13.2.0
sh                           se7751_defconfig   gcc-13.2.0
sh                            shmin_defconfig   gcc-13.2.0
sh                             shx3_defconfig   gcc-13.2.0
sh                          urquell_defconfig   gcc-14.1.0
sparc                            allmodconfig   gcc-14.1.0
sparc                       sparc32_defconfig   gcc-13.2.0
sparc64                             defconfig   gcc-14.1.0
sparc64               randconfig-001-20240723   gcc-13.2.0
sparc64               randconfig-001-20240723   gcc-14.1.0
sparc64               randconfig-002-20240723   gcc-13.2.0
sparc64               randconfig-002-20240723   gcc-14.1.0
um                               allmodconfig   clang-19
um                               allmodconfig   gcc-13.3.0
um                                allnoconfig   clang-17
um                                allnoconfig   gcc-14.1.0
um                               allyesconfig   gcc-13
um                               allyesconfig   gcc-13.3.0
um                                  defconfig   gcc-14.1.0
um                             i386_defconfig   gcc-14.1.0
um                    randconfig-001-20240723   gcc-10
um                    randconfig-001-20240723   gcc-13.2.0
um                    randconfig-002-20240723   gcc-13.2.0
um                    randconfig-002-20240723   gcc-8
um                           x86_64_defconfig   clang-15
um                           x86_64_defconfig   gcc-14.1.0
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240723   gcc-10
x86_64       buildonly-randconfig-002-20240723   gcc-10
x86_64       buildonly-randconfig-003-20240723   gcc-10
x86_64       buildonly-randconfig-004-20240723   gcc-10
x86_64       buildonly-randconfig-005-20240723   gcc-10
x86_64       buildonly-randconfig-006-20240723   gcc-10
x86_64                              defconfig   clang-18
x86_64                              defconfig   gcc-13
x86_64                randconfig-001-20240723   gcc-10
x86_64                randconfig-002-20240723   gcc-10
x86_64                randconfig-003-20240723   gcc-10
x86_64                randconfig-004-20240723   gcc-10
x86_64                randconfig-005-20240723   gcc-10
x86_64                randconfig-006-20240723   gcc-10
x86_64                randconfig-011-20240723   gcc-10
x86_64                randconfig-012-20240723   gcc-10
x86_64                randconfig-013-20240723   gcc-10
x86_64                randconfig-014-20240723   gcc-10
x86_64                randconfig-015-20240723   gcc-10
x86_64                randconfig-016-20240723   gcc-10
x86_64                randconfig-071-20240723   gcc-10
x86_64                randconfig-072-20240723   gcc-10
x86_64                randconfig-073-20240723   gcc-10
x86_64                randconfig-074-20240723   gcc-10
x86_64                randconfig-075-20240723   gcc-10
x86_64                randconfig-076-20240723   gcc-10
x86_64                          rhel-8.3-rust   clang-18
xtensa                            allnoconfig   gcc-13.2.0
xtensa                            allnoconfig   gcc-14.1.0
xtensa                randconfig-001-20240723   gcc-13.2.0
xtensa                randconfig-001-20240723   gcc-14.1.0
xtensa                randconfig-002-20240723   gcc-13.2.0
xtensa                randconfig-002-20240723   gcc-14.1.0
xtensa                         virt_defconfig   gcc-13.2.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
