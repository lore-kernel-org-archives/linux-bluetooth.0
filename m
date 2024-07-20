Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A9E91DDF6
	for <linux-bluetooth@vger.kernel.org>; Sat, 20 Jul 2024 16:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721492977; cv=none; b=KAEMEJGxW5yq78C1CHO72lf3ZlbB1XitESma9z71qBjW1wAQwHYap1Yoe1LQ5ZkPgzjbsPlStDar/Je/cflHcNT2oSpFTSIn4EdFdZ0M0Til0lC4NNaC3N0KhujBOTUEqNBchD90+3DdlsOdRyTVSq5uH2b9Zbmq/1AF/B/gJfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721492977; c=relaxed/simple;
	bh=jbvv3KchxvRNhQKCtzwwRi++GjeeKR55NSQOvBYLG+o=;
	h=Date:From:To:Cc:Subject:Message-ID; b=PlrWtX/bZg0iZaXmbfpgbow6IWqlsTvOq8oKO2yGT0jQS9CmBPtgH2StGufbS8yn8UqUkdvU3a8xzdobJso5/Qf17uXop2C6187g2+4Ob+yHaqTUOloc7A+78wK9y3bv3C08Xl49jyBp/eU6KXVRIz6B5YHR5ACe97hTXcA4Ep4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iNXIhsVu; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iNXIhsVu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721492974; x=1753028974;
  h=date:from:to:cc:subject:message-id;
  bh=jbvv3KchxvRNhQKCtzwwRi++GjeeKR55NSQOvBYLG+o=;
  b=iNXIhsVudFA40mClglNTicMTlTGTsFPKAl/4FSwcLOE3KT3M3ggmwLv7
   ahoq5kFGkeHjHHeUvBrKL58pyPgRPbapcwrqjhztuYl/JgxM2yh2PUjD3
   Fy85IK1t0lEBNCGJULXEyiKobGxy1Tcg9dkrUWSZiy6Kf7wbs4JjC4iap
   b4MzTYlMJfchBDjWlrHqID4MgwlSel5wBnDatE0TLXWNlD7Jech2/uwlt
   Dx8KddV3d/5jVjKUrS1MuHwkCPg9/dPbUjrQ+rPUsRIeJSjLm1VZBXRij
   cNSakYgHiivffhCzXAhLUIyj9T+8RCUlYGlwyQW+61Z93fdOTs6JcX3AB
   g==;
X-CSE-ConnectionGUID: AOLr/M1ASnKbyEeQnqMbjQ==
X-CSE-MsgGUID: 57RQ/PZLSz6Vmf9BOIg9IA==
X-IronPort-AV: E=McAfee;i="6700,10204,11139"; a="18946837"
X-IronPort-AV: E=Sophos;i="6.09,224,1716274800"; 
   d="scan'208";a="18946837"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2024 09:29:34 -0700
X-CSE-ConnectionGUID: GZ7G0C59Qc2z1syruQBM3w==
X-CSE-MsgGUID: 3sLooAvwTlekjszm668hWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,224,1716274800"; 
   d="scan'208";a="51155328"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 20 Jul 2024 09:29:32 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sVCxe-000jPE-1H;
	Sat, 20 Jul 2024 16:29:30 +0000
Date: Sun, 21 Jul 2024 00:28:42 +0800
From: kernel test robot <lkp@intel.com>
To: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD REGRESSION
 52828ea60dfdd05246fc92dedfad1c8bbfa2dd66
Message-ID: <202407210037.cZBFtL5x-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: 52828ea60dfdd05246fc92dedfad1c8bbfa2dd66  Bluetooth: btmtk: Fix btmtk.c undefined reference build error

Error/Warning reports:

https://lore.kernel.org/oe-kbuild-all/202407200904.hRqT3JKD-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202407200917.Dv9hKccL-lkp@intel.com

Error/Warning: (recently discovered and may have been fixed)

drivers/bluetooth/btusb.c:2705:15: error: implicit declaration of function 'btmtk_usb_subsys_reset' [-Wimplicit-function-declaration]
drivers/bluetooth/btusb.c:2705:8: error: call to undeclared function 'btmtk_usb_subsys_reset'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
drivers/bluetooth/btusb.c:2720:21: error: assignment to 'struct urb *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
drivers/bluetooth/btusb.c:2720:23: error: implicit declaration of function 'alloc_mtk_intr_urb' [-Wimplicit-function-declaration]
drivers/bluetooth/btusb.c:2720:7: error: incompatible integer to pointer conversion assigning to 'struct urb *' from 'int' [-Wint-conversion]
drivers/bluetooth/btusb.c:2720:9: error: call to undeclared function 'alloc_mtk_intr_urb'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
drivers/bluetooth/btusb.c:2749:16: error: implicit declaration of function 'btmtk_usb_setup' [-Wimplicit-function-declaration]
drivers/bluetooth/btusb.c:2749:9: error: call to undeclared function 'btmtk_usb_setup'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
drivers/bluetooth/btusb.c:2760:16: error: implicit declaration of function 'btmtk_usb_shutdown'; did you mean 'btusb_mtk_shutdown'? [-Wimplicit-function-declaration]
drivers/bluetooth/btusb.c:2760:9: error: call to undeclared function 'btmtk_usb_shutdown'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
drivers/bluetooth/btusb.c:3869:20: error: use of undeclared identifier 'btmtk_usb_recv_acl'; did you mean 'btusb_recv_acl'?
drivers/bluetooth/btusb.c:3869:34: error: 'btmtk_usb_recv_acl' undeclared (first use in this function); did you mean 'btusb_recv_acl'?
drivers/bluetooth/btusb.c:3870:19: error: use of undeclared identifier 'btmtk_usb_suspend'
drivers/bluetooth/btusb.c:3870:33: error: 'btmtk_usb_suspend' undeclared (first use in this function)
drivers/bluetooth/btusb.c:3871:18: error: use of undeclared identifier 'btmtk_usb_resume'
drivers/bluetooth/btusb.c:3871:32: error: 'btmtk_usb_resume' undeclared (first use in this function)

Error/Warning ids grouped by kconfigs:

recent_errors
|-- arm64-randconfig-051-20240720
|   |-- arch-arm64-boot-dts-qcom-qrb5165-rb5-vision-mezzanine.dtb:bluetooth:vddbtcmx-supply-is-a-required-property
|   |-- arch-arm64-boot-dts-qcom-qrb5165-rb5-vision-mezzanine.dtb:bluetooth:vddrfa0p8-supply-is-a-required-property
|   |-- arch-arm64-boot-dts-qcom-qrb5165-rb5-vision-mezzanine.dtb:bluetooth:vddrfa1p2-supply-is-a-required-property
|   |-- arch-arm64-boot-dts-qcom-qrb5165-rb5-vision-mezzanine.dtb:bluetooth:vddrfa1p7-supply-is-a-required-property
|   |-- arch-arm64-boot-dts-qcom-qrb5165-rb5-vision-mezzanine.dtb:bluetooth:vddrfacmn-supply-is-a-required-property
|   |-- arch-arm64-boot-dts-qcom-qrb5165-rb5.dtb:bluetooth:vddbtcmx-supply-is-a-required-property
|   |-- arch-arm64-boot-dts-qcom-qrb5165-rb5.dtb:bluetooth:vddrfa0p8-supply-is-a-required-property
|   |-- arch-arm64-boot-dts-qcom-qrb5165-rb5.dtb:bluetooth:vddrfa1p2-supply-is-a-required-property
|   |-- arch-arm64-boot-dts-qcom-qrb5165-rb5.dtb:bluetooth:vddrfa1p7-supply-is-a-required-property
|   |-- arch-arm64-boot-dts-qcom-qrb5165-rb5.dtb:bluetooth:vddrfacmn-supply-is-a-required-property
|   |-- arch-arm64-boot-dts-qcom-sm8650-qrd.dtb:bluetooth:vddrfa1p8-supply-is-a-required-property
|   |-- arch-arm64-boot-dts-qcom-sm8650-qrd.dtb:bluetooth:vddrfacmn-supply-is-a-required-property
|   |-- arch-arm64-boot-dts-qcom-sm8650-qrd.dtb:bluetooth:vddwlcx-supply-is-a-required-property
|   `-- arch-arm64-boot-dts-qcom-sm8650-qrd.dtb:bluetooth:vddwlmx-supply-is-a-required-property
|-- csky-randconfig-001-20240720
|   |-- drivers-bluetooth-btusb.c:error:assignment-to-struct-urb-from-int-makes-pointer-from-integer-without-a-cast
|   |-- drivers-bluetooth-btusb.c:error:btmtk_usb_recv_acl-undeclared-(first-use-in-this-function)
|   |-- drivers-bluetooth-btusb.c:error:btmtk_usb_resume-undeclared-(first-use-in-this-function)
|   |-- drivers-bluetooth-btusb.c:error:btmtk_usb_suspend-undeclared-(first-use-in-this-function)
|   |-- drivers-bluetooth-btusb.c:error:implicit-declaration-of-function-alloc_mtk_intr_urb
|   |-- drivers-bluetooth-btusb.c:error:implicit-declaration-of-function-btmtk_usb_setup
|   |-- drivers-bluetooth-btusb.c:error:implicit-declaration-of-function-btmtk_usb_shutdown
|   `-- drivers-bluetooth-btusb.c:error:implicit-declaration-of-function-btmtk_usb_subsys_reset
|-- i386-buildonly-randconfig-005-20240720
|   |-- drivers-bluetooth-btusb.c:error:call-to-undeclared-function-alloc_mtk_intr_urb-ISO-C99-and-later-do-not-support-implicit-function-declarations
|   |-- drivers-bluetooth-btusb.c:error:call-to-undeclared-function-btmtk_usb_setup-ISO-C99-and-later-do-not-support-implicit-function-declarations
|   |-- drivers-bluetooth-btusb.c:error:call-to-undeclared-function-btmtk_usb_shutdown-ISO-C99-and-later-do-not-support-implicit-function-declarations
|   |-- drivers-bluetooth-btusb.c:error:call-to-undeclared-function-btmtk_usb_subsys_reset-ISO-C99-and-later-do-not-support-implicit-function-declarations
|   |-- drivers-bluetooth-btusb.c:error:incompatible-integer-to-pointer-conversion-assigning-to-struct-urb-from-int
|   |-- drivers-bluetooth-btusb.c:error:use-of-undeclared-identifier-btmtk_usb_recv_acl
|   |-- drivers-bluetooth-btusb.c:error:use-of-undeclared-identifier-btmtk_usb_resume
|   `-- drivers-bluetooth-btusb.c:error:use-of-undeclared-identifier-btmtk_usb_suspend
`-- mips-randconfig-r111-20240720
    |-- drivers-bluetooth-btusb.c:error:call-to-undeclared-function-alloc_mtk_intr_urb-ISO-C99-and-later-do-not-support-implicit-function-declarations
    |-- drivers-bluetooth-btusb.c:error:call-to-undeclared-function-btmtk_usb_setup-ISO-C99-and-later-do-not-support-implicit-function-declarations
    |-- drivers-bluetooth-btusb.c:error:call-to-undeclared-function-btmtk_usb_shutdown-ISO-C99-and-later-do-not-support-implicit-function-declarations
    |-- drivers-bluetooth-btusb.c:error:call-to-undeclared-function-btmtk_usb_subsys_reset-ISO-C99-and-later-do-not-support-implicit-function-declarations
    |-- drivers-bluetooth-btusb.c:error:incompatible-integer-to-pointer-conversion-assigning-to-struct-urb-from-int
    |-- drivers-bluetooth-btusb.c:error:use-of-undeclared-identifier-btmtk_usb_recv_acl
    |-- drivers-bluetooth-btusb.c:error:use-of-undeclared-identifier-btmtk_usb_resume
    `-- drivers-bluetooth-btusb.c:error:use-of-undeclared-identifier-btmtk_usb_suspend

elapsed time: 1449m

configs tested: 166
configs skipped: 8

tested configs:
alpha                             allnoconfig   gcc-13.2.0
alpha                            allyesconfig   gcc-13.3.0
alpha                               defconfig   gcc-13.2.0
arc                              allmodconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                              allyesconfig   gcc-13.2.0
arc                          axs101_defconfig   gcc-13.2.0
arc                      axs103_smp_defconfig   gcc-13.2.0
arc                                 defconfig   gcc-13.2.0
arc                   randconfig-001-20240720   gcc-13.2.0
arc                   randconfig-002-20240720   gcc-13.2.0
arm                              allmodconfig   gcc-13.2.0
arm                              allmodconfig   gcc-14.1.0
arm                               allnoconfig   gcc-13.2.0
arm                              allyesconfig   gcc-13.2.0
arm                              allyesconfig   gcc-14.1.0
arm                                 defconfig   gcc-13.2.0
arm                   randconfig-001-20240720   gcc-13.2.0
arm                   randconfig-002-20240720   gcc-13.2.0
arm                   randconfig-003-20240720   gcc-13.2.0
arm                   randconfig-004-20240720   gcc-13.2.0
arm                           stm32_defconfig   gcc-13.2.0
arm64                            allmodconfig   clang-19
arm64                            allmodconfig   gcc-13.2.0
arm64                             allnoconfig   gcc-13.2.0
arm64                               defconfig   gcc-13.2.0
arm64                 randconfig-001-20240720   gcc-13.2.0
arm64                 randconfig-002-20240720   gcc-13.2.0
arm64                 randconfig-003-20240720   gcc-13.2.0
arm64                 randconfig-004-20240720   gcc-13.2.0
csky                              allnoconfig   gcc-13.2.0
csky                                defconfig   gcc-13.2.0
csky                  randconfig-001-20240720   gcc-13.2.0
csky                  randconfig-002-20240720   gcc-13.2.0
hexagon                          allmodconfig   clang-19
hexagon                          allyesconfig   clang-19
i386                             allmodconfig   clang-18
i386                             allmodconfig   gcc-13
i386                              allnoconfig   clang-18
i386                              allnoconfig   gcc-13
i386                             allyesconfig   clang-18
i386                             allyesconfig   gcc-13
i386         buildonly-randconfig-001-20240720   clang-18
i386         buildonly-randconfig-002-20240720   clang-18
i386         buildonly-randconfig-002-20240720   gcc-13
i386         buildonly-randconfig-003-20240720   clang-18
i386         buildonly-randconfig-003-20240720   gcc-13
i386         buildonly-randconfig-004-20240720   clang-18
i386         buildonly-randconfig-005-20240720   clang-18
i386         buildonly-randconfig-006-20240720   clang-18
i386         buildonly-randconfig-006-20240720   gcc-11
i386                                defconfig   clang-18
i386                  randconfig-001-20240720   clang-18
i386                  randconfig-001-20240720   gcc-7
i386                  randconfig-002-20240720   clang-18
i386                  randconfig-003-20240720   clang-18
i386                  randconfig-004-20240720   clang-18
i386                  randconfig-005-20240720   clang-18
i386                  randconfig-005-20240720   gcc-13
i386                  randconfig-006-20240720   clang-18
i386                  randconfig-006-20240720   gcc-11
i386                  randconfig-011-20240720   clang-18
i386                  randconfig-011-20240720   gcc-13
i386                  randconfig-012-20240720   clang-18
i386                  randconfig-012-20240720   gcc-13
i386                  randconfig-013-20240720   clang-18
i386                  randconfig-013-20240720   gcc-13
i386                  randconfig-014-20240720   clang-18
i386                  randconfig-014-20240720   gcc-13
i386                  randconfig-015-20240720   clang-18
i386                  randconfig-015-20240720   gcc-12
i386                  randconfig-016-20240720   clang-18
i386                  randconfig-016-20240720   gcc-13
loongarch                        allmodconfig   gcc-14.1.0
loongarch                         allnoconfig   gcc-13.2.0
loongarch                           defconfig   gcc-13.2.0
loongarch             randconfig-001-20240720   gcc-13.2.0
loongarch             randconfig-002-20240720   gcc-13.2.0
m68k                             alldefconfig   gcc-13.2.0
m68k                             allmodconfig   gcc-14.1.0
m68k                              allnoconfig   gcc-13.2.0
m68k                             allyesconfig   gcc-14.1.0
m68k                                defconfig   gcc-13.2.0
m68k                       m5249evb_defconfig   gcc-13.2.0
m68k                        m5407c3_defconfig   gcc-13.2.0
m68k                        mvme147_defconfig   gcc-13.2.0
m68k                           sun3_defconfig   gcc-13.2.0
microblaze                       allmodconfig   gcc-14.1.0
microblaze                        allnoconfig   gcc-13.2.0
microblaze                       allyesconfig   gcc-14.1.0
microblaze                          defconfig   gcc-13.2.0
mips                              allnoconfig   gcc-13.2.0
mips                     decstation_defconfig   gcc-13.2.0
mips                       lemote2f_defconfig   gcc-13.2.0
mips                          rb532_defconfig   gcc-13.2.0
nios2                             allnoconfig   gcc-13.2.0
nios2                               defconfig   gcc-13.2.0
nios2                 randconfig-001-20240720   gcc-13.2.0
nios2                 randconfig-002-20240720   gcc-13.2.0
openrisc                          allnoconfig   gcc-14.1.0
openrisc                         allyesconfig   gcc-14.1.0
openrisc                            defconfig   gcc-14.1.0
parisc                           allmodconfig   gcc-14.1.0
parisc                            allnoconfig   gcc-14.1.0
parisc                           allyesconfig   gcc-14.1.0
parisc                              defconfig   gcc-14.1.0
parisc                randconfig-001-20240720   gcc-13.2.0
parisc                randconfig-002-20240720   gcc-13.2.0
parisc64                            defconfig   gcc-13.2.0
powerpc                          allmodconfig   gcc-14.1.0
powerpc                           allnoconfig   gcc-14.1.0
powerpc                          allyesconfig   gcc-14.1.0
powerpc                      pmac32_defconfig   gcc-13.2.0
powerpc                         ps3_defconfig   gcc-13.2.0
powerpc               randconfig-001-20240720   gcc-13.2.0
powerpc               randconfig-002-20240720   gcc-13.2.0
powerpc               randconfig-003-20240720   gcc-13.2.0
powerpc                     redwood_defconfig   gcc-13.2.0
powerpc64             randconfig-001-20240720   gcc-13.2.0
powerpc64             randconfig-002-20240720   gcc-13.2.0
powerpc64             randconfig-003-20240720   gcc-13.2.0
riscv                            allmodconfig   gcc-14.1.0
riscv                             allnoconfig   gcc-14.1.0
riscv                            allyesconfig   gcc-14.1.0
riscv                               defconfig   gcc-14.1.0
riscv                 randconfig-001-20240720   gcc-13.2.0
riscv                 randconfig-002-20240720   gcc-13.2.0
s390                             allmodconfig   clang-19
s390                              allnoconfig   clang-19
s390                              allnoconfig   gcc-14.1.0
s390                             allyesconfig   clang-19
s390                             allyesconfig   gcc-14.1.0
s390                                defconfig   gcc-14.1.0
s390                  randconfig-001-20240720   gcc-13.2.0
s390                  randconfig-002-20240720   gcc-13.2.0
sh                               allmodconfig   gcc-14.1.0
sh                                allnoconfig   gcc-13.2.0
sh                               allyesconfig   gcc-14.1.0
sh                        apsh4ad0a_defconfig   gcc-13.2.0
sh                                  defconfig   gcc-14.1.0
sh                    randconfig-001-20240720   gcc-13.2.0
sh                    randconfig-002-20240720   gcc-13.2.0
sparc                            allmodconfig   gcc-14.1.0
sparc64                             defconfig   gcc-14.1.0
sparc64               randconfig-001-20240720   gcc-13.2.0
sparc64               randconfig-002-20240720   gcc-13.2.0
um                               allmodconfig   clang-19
um                               allmodconfig   gcc-13.3.0
um                                allnoconfig   clang-17
um                                allnoconfig   gcc-14.1.0
um                               allyesconfig   gcc-13
um                               allyesconfig   gcc-13.3.0
um                                  defconfig   gcc-14.1.0
um                             i386_defconfig   gcc-13.2.0
um                             i386_defconfig   gcc-14.1.0
um                    randconfig-001-20240720   gcc-13.2.0
um                    randconfig-002-20240720   gcc-13.2.0
um                           x86_64_defconfig   gcc-14.1.0
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64                              defconfig   clang-18
x86_64                              defconfig   gcc-13
x86_64                          rhel-8.3-rust   clang-18
xtensa                            allnoconfig   gcc-13.2.0
xtensa                randconfig-001-20240720   gcc-13.2.0
xtensa                randconfig-002-20240720   gcc-13.2.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
