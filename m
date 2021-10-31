Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C29B4C433EF
	for <linux-bluetooth@archiver.kernel.org>; Sun, 31 Oct 2021 10:31:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9671860F02
	for <linux-bluetooth@archiver.kernel.org>; Sun, 31 Oct 2021 10:31:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbhJaKdw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 31 Oct 2021 06:33:52 -0400
Received: from mga03.intel.com ([134.134.136.65]:16187 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229638AbhJaKdv (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 31 Oct 2021 06:33:51 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10153"; a="230826182"
X-IronPort-AV: E=Sophos;i="5.87,197,1631602800"; 
   d="scan'208";a="230826182"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2021 03:31:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,197,1631602800"; 
   d="scan'208";a="488248354"
Received: from lkp-server02.sh.intel.com (HELO c20d8bc80006) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 31 Oct 2021 03:31:18 -0700
Received: from kbuild by c20d8bc80006 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mh87R-0002MI-Lv; Sun, 31 Oct 2021 10:31:17 +0000
Date:   Sun, 31 Oct 2021 18:31:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS WITH WARNING
 d6cba4e6d0e202276b81117b96106859a4e2d56e
Message-ID: <617e706c.VRjQNYAVXf4mv29D%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: d6cba4e6d0e202276b81117b96106859a4e2d56e  Bluetooth: btusb: Add support using different nvm for variant WCN6855 controller

Warning reports:

https://lore.kernel.org/linux-bluetooth/202110301017.z9Vi8icx-lkp@intel.com
https://lore.kernel.org/llvm/202110301521.vOSfbIOB-lkp@intel.com

Warning in current branch:

net/bluetooth/hci_sync.c:1333:5: warning: no previous prototype for 'hci_scan_disable_sync' [-Wmissing-prototypes]
net/bluetooth/hci_sync.c:1333:5: warning: no previous prototype for function 'hci_scan_disable_sync' [-Wmissing-prototypes]
net/bluetooth/hci_sync.c:1400:5: warning: no previous prototype for 'hci_scan_disable_sync' [-Wmissing-prototypes]
net/bluetooth/hci_sync.c:1400:5: warning: no previous prototype for function 'hci_scan_disable_sync' [-Wmissing-prototypes]
net/bluetooth/hci_sync.c:1762:5: warning: no previous prototype for 'hci_passive_scan_sync' [-Wmissing-prototypes]
net/bluetooth/hci_sync.c:1762:5: warning: no previous prototype for function 'hci_passive_scan_sync' [-Wmissing-prototypes]
net/bluetooth/hci_sync.c:1971:5: warning: no previous prototype for 'hci_passive_scan_sync' [-Wmissing-prototypes]
net/bluetooth/hci_sync.c:1971:5: warning: no previous prototype for function 'hci_passive_scan_sync' [-Wmissing-prototypes]

Warning ids grouped by kconfigs:

gcc_recent_errors
|-- alpha-randconfig-c023-20211028
|   |-- net-bluetooth-hci_sync.c:warning:no-previous-prototype-for-hci_passive_scan_sync
|   `-- net-bluetooth-hci_sync.c:warning:no-previous-prototype-for-hci_scan_disable_sync
|-- alpha-randconfig-m031-20211028
|   |-- net-bluetooth-hci_sync.c:warning:no-previous-prototype-for-hci_passive_scan_sync
|   `-- net-bluetooth-hci_sync.c:warning:no-previous-prototype-for-hci_scan_disable_sync
|-- alpha-randconfig-r001-20211028
|   |-- net-bluetooth-hci_sync.c:warning:no-previous-prototype-for-hci_passive_scan_sync
|   `-- net-bluetooth-hci_sync.c:warning:no-previous-prototype-for-hci_scan_disable_sync
|-- alpha-randconfig-r004-20211028
|   |-- net-bluetooth-hci_sync.c:warning:no-previous-prototype-for-hci_passive_scan_sync
|   `-- net-bluetooth-hci_sync.c:warning:no-previous-prototype-for-hci_scan_disable_sync
|-- arc-randconfig-r036-20211029
|   |-- net-bluetooth-hci_sync.c:warning:no-previous-prototype-for-hci_passive_scan_sync
|   `-- net-bluetooth-hci_sync.c:warning:no-previous-prototype-for-hci_scan_disable_sync
|-- arm-bcm2835_defconfig
|   |-- net-bluetooth-hci_sync.c:warning:no-previous-prototype-for-hci_passive_scan_sync
|   `-- net-bluetooth-hci_sync.c:warning:no-previous-prototype-for-hci_scan_disable_sync
|-- arm-defconfig
|   |-- net-bluetooth-hci_sync.c:warning:no-previous-prototype-for-hci_passive_scan_sync
|   `-- net-bluetooth-hci_sync.c:warning:no-previous-prototype-for-hci_scan_disable_sync
|-- arm-exynos_defconfig
|   |-- net-bluetooth-hci_sync.c:warning:no-previous-prototype-for-hci_passive_scan_sync
|   `-- net-bluetooth-hci_sync.c:warning:no-previous-prototype-for-hci_scan_disable_sync
|-- arm-magician_defconfig
|   |-- net-bluetooth-hci_sync.c:warning:no-previous-prototype-for-hci_passive_scan_sync
|   `-- net-bluetooth-hci_sync.c:warning:no-previous-prototype-for-hci_scan_disable_sync
|-- arm64-defconfig
|   |-- net-bluetooth-hci_sync.c:warning:no-previous-prototype-for-hci_passive_scan_sync
|   `-- net-bluetooth-hci_sync.c:warning:no-previous-prototype-for-hci_scan_disable_sync
|-- arm64-randconfig-r032-20211028
|   |-- net-bluetooth-hci_sync.c:warning:no-previous-prototype-for-hci_passive_scan_sync
|   `-- net-bluetooth-hci_sync.c:warning:no-previous-prototype-for-hci_scan_disable_sync
|-- h8300-randconfig-r023-20211030
|   |-- net-bluetooth-hci_sync.c:warning:no-previous-prototype-for-hci_passive_scan_sync
|   `-- net-bluetooth-hci_sync.c:warning:no-previous-prototype-for-hci_scan_disable_sync
|-- h8300-randconfig-r033-20211028
|   |-- net-bluetooth-hci_sync.c:warning:no-previous-prototype-for-hci_passive_scan_sync
|   `-- net-bluetooth-hci_sync.c:warning:no-previous-prototype-for-hci_scan_disable_sync
|-- i386-randconfig-a014-20211029
|   |-- net-bluetooth-hci_sync.c:warning:no-previous-prototype-for-hci_passive_scan_sync
|   `-- net-bluetooth-hci_sync.c:warning:no-previous-prototype-for-hci_scan_disable_sync
|-- i386-randconfig-c024-20211028
|   |-- net-bluetooth-hci_sync.c:warning:no-previous-prototype-for-hci_passive_scan_sync
|   `-- net-bluetooth-hci_sync.c:warning:no-previous-prototype-for-hci_scan_disable_sync
|-- i386-randconfig-m021-20211028
|   |-- net-bluetooth-hci_sync.c:warning:no-previous-prototype-for-hci_passive_scan_sync
|   `-- net-bluetooth-hci_sync.c:warning:no-previous-prototype-for-hci_scan_disable_sync
|-- i386-randconfig-m021-20211029
|   |-- net-bluetooth-hci_sync.c:warning:no-previous-prototype-for-hci_passive_scan_sync
|   `-- net-bluetooth-hci_sync.c:warning:no-previous-prototype-for-hci_scan_disable_sync
|-- i386-randconfig-s002-20211028
|   |-- net-bluetooth-hci_sync.c:warning:no-previous-prototype-for-hci_passive_scan_sync
|   `-- net-bluetooth-hci_sync.c:warning:no-previous-prototype-for-hci_scan_disable_sync
|-- ia64-randconfig-m031-20211028
|   |-- net-bluetooth-hci_sync.c:warning:no-previous-prototype-for-hci_passive_scan_sync
|   `-- net-bluetooth-hci_sync.c:warning:no-previous-prototype-for-hci_scan_disable_sync
|-- m68k-randconfig-r015-20211028
|   |-- net-bluetooth-hci_sync.c:warning:no-previous-prototype-for-hci_passive_scan_sync
|   `-- net-bluetooth-hci_sync.c:warning:no-previous-prototype-for-hci_scan_disable_sync
|-- microblaze-randconfig-r032-20211029
|   |-- net-bluetooth-hci_sync.c:warning:no-previous-prototype-for-hci_passive_scan_sync
|   `-- net-bluetooth-hci_sync.c:warning:no-previous-prototype-for-hci_scan_disable_sync
|-- mips-randconfig-m031-20211028
|   |-- net-bluetooth-hci_sync.c:warning:no-previous-prototype-for-hci_passive_scan_sync
|   `-- net-bluetooth-hci_sync.c:warning:no-previous-prototype-for-hci_scan_disable_sync
|-- mips-randconfig-r034-20211029
|   |-- net-bluetooth-hci_sync.c:warning:no-previous-prototype-for-hci_passive_scan_sync
|   `-- net-bluetooth-hci_sync.c:warning:no-previous-prototype-for-hci_scan_disable_sync
|-- openrisc-randconfig-c024-20211028
|   |-- net-bluetooth-hci_sync.c:warning:no-previous-prototype-for-hci_passive_scan_sync
|   `-- net-bluetooth-hci_sync.c:warning:no-previous-prototype-for-hci_scan_disable_sync
|-- openrisc-randconfig-r031-20211029
|   |-- net-bluetooth-hci_sync.c:warning:no-previous-prototype-for-hci_passive_scan_sync
|   `-- net-bluetooth-hci_sync.c:warning:no-previous-prototype-for-hci_scan_disable_sync
|-- parisc-randconfig-r013-20211029
|   |-- net-bluetooth-hci_sync.c:warning:no-previous-prototype-for-hci_passive_scan_sync
|   `-- net-bluetooth-hci_sync.c:warning:no-previous-prototype-for-hci_scan_disable_sync
|-- sh-randconfig-r014-20211028
|   |-- net-bluetooth-hci_sync.c:warning:no-previous-prototype-for-hci_passive_scan_sync
|   `-- net-bluetooth-hci_sync.c:warning:no-previous-prototype-for-hci_scan_disable_sync
|-- sparc64-randconfig-r034-20211028
|   |-- net-bluetooth-hci_sync.c:warning:no-previous-prototype-for-hci_passive_scan_sync
|   `-- net-bluetooth-hci_sync.c:warning:no-previous-prototype-for-hci_scan_disable_sync
|-- x86_64-randconfig-a004-20211028
|   |-- net-bluetooth-hci_sync.c:warning:no-previous-prototype-for-hci_passive_scan_sync
|   `-- net-bluetooth-hci_sync.c:warning:no-previous-prototype-for-hci_scan_disable_sync
|-- x86_64-randconfig-a005-20211028
|   |-- net-bluetooth-hci_sync.c:warning:no-previous-prototype-for-hci_passive_scan_sync
|   `-- net-bluetooth-hci_sync.c:warning:no-previous-prototype-for-hci_scan_disable_sync
|-- x86_64-randconfig-a006-20211028
|   |-- net-bluetooth-hci_sync.c:warning:no-previous-prototype-for-hci_passive_scan_sync
|   `-- net-bluetooth-hci_sync.c:warning:no-previous-prototype-for-hci_scan_disable_sync
|-- x86_64-randconfig-a011-20211029
|   |-- net-bluetooth-hci_sync.c:warning:no-previous-prototype-for-hci_passive_scan_sync
|   `-- net-bluetooth-hci_sync.c:warning:no-previous-prototype-for-hci_scan_disable_sync
|-- x86_64-randconfig-a014-20211029
|   |-- net-bluetooth-hci_sync.c:warning:no-previous-prototype-for-hci_passive_scan_sync
|   `-- net-bluetooth-hci_sync.c:warning:no-previous-prototype-for-hci_scan_disable_sync
|-- x86_64-randconfig-a015-20211029
|   |-- net-bluetooth-hci_sync.c:warning:no-previous-prototype-for-hci_passive_scan_sync
|   `-- net-bluetooth-hci_sync.c:warning:no-previous-prototype-for-hci_scan_disable_sync
|-- x86_64-randconfig-c002-20211028
|   |-- net-bluetooth-hci_sync.c:warning:no-previous-prototype-for-hci_passive_scan_sync
|   `-- net-bluetooth-hci_sync.c:warning:no-previous-prototype-for-hci_scan_disable_sync
|-- x86_64-randconfig-m001-20211028
|   |-- net-bluetooth-hci_sync.c:warning:no-previous-prototype-for-hci_passive_scan_sync
|   `-- net-bluetooth-hci_sync.c:warning:no-previous-prototype-for-hci_scan_disable_sync
|-- x86_64-randconfig-s021-20211028
|   |-- net-bluetooth-hci_sync.c:warning:no-previous-prototype-for-hci_passive_scan_sync
|   `-- net-bluetooth-hci_sync.c:warning:no-previous-prototype-for-hci_scan_disable_sync
|-- x86_64-rhel-8.3
|   |-- net-bluetooth-hci_sync.c:warning:no-previous-prototype-for-hci_passive_scan_sync
|   `-- net-bluetooth-hci_sync.c:warning:no-previous-prototype-for-hci_scan_disable_sync
|-- x86_64-rhel-8.3-func
|   |-- net-bluetooth-hci_sync.c:warning:no-previous-prototype-for-hci_passive_scan_sync
|   `-- net-bluetooth-hci_sync.c:warning:no-previous-prototype-for-hci_scan_disable_sync
|-- x86_64-rhel-8.3-kselftests
|   |-- net-bluetooth-hci_sync.c:warning:no-previous-prototype-for-hci_passive_scan_sync
|   `-- net-bluetooth-hci_sync.c:warning:no-previous-prototype-for-hci_scan_disable_sync
`-- xtensa-randconfig-p001-20211030
    |-- net-bluetooth-hci_sync.c:warning:no-previous-prototype-for-hci_passive_scan_sync
    `-- net-bluetooth-hci_sync.c:warning:no-previous-prototype-for-hci_scan_disable_sync

clang_recent_errors
|-- arm-randconfig-r012-20211029
|   |-- net-bluetooth-hci_sync.c:warning:no-previous-prototype-for-function-hci_passive_scan_sync
|   `-- net-bluetooth-hci_sync.c:warning:no-previous-prototype-for-function-hci_scan_disable_sync
|-- arm-randconfig-r035-20211028
|   |-- net-bluetooth-hci_sync.c:warning:no-previous-prototype-for-function-hci_passive_scan_sync
|   `-- net-bluetooth-hci_sync.c:warning:no-previous-prototype-for-function-hci_scan_disable_sync
|-- hexagon-randconfig-r045-20211029
|   |-- net-bluetooth-hci_sync.c:warning:no-previous-prototype-for-function-hci_passive_scan_sync
|   `-- net-bluetooth-hci_sync.c:warning:no-previous-prototype-for-function-hci_scan_disable_sync
|-- i386-randconfig-a001-20211029
|   |-- net-bluetooth-hci_sync.c:warning:no-previous-prototype-for-function-hci_passive_scan_sync
|   `-- net-bluetooth-hci_sync.c:warning:no-previous-prototype-for-function-hci_scan_disable_sync
|-- i386-randconfig-a002-20211029
|   |-- net-bluetooth-hci_sync.c:warning:no-previous-prototype-for-function-hci_passive_scan_sync
|   `-- net-bluetooth-hci_sync.c:warning:no-previous-prototype-for-function-hci_scan_disable_sync
|-- i386-randconfig-a005-20211029
|   |-- net-bluetooth-hci_sync.c:warning:no-previous-prototype-for-function-hci_passive_scan_sync
|   `-- net-bluetooth-hci_sync.c:warning:no-previous-prototype-for-function-hci_scan_disable_sync
|-- i386-randconfig-a006-20211029
|   |-- net-bluetooth-hci_sync.c:warning:no-previous-prototype-for-function-hci_passive_scan_sync
|   `-- net-bluetooth-hci_sync.c:warning:no-previous-prototype-for-function-hci_scan_disable_sync
|-- i386-randconfig-a011-20211028
|   |-- net-bluetooth-hci_sync.c:warning:no-previous-prototype-for-function-hci_passive_scan_sync
|   `-- net-bluetooth-hci_sync.c:warning:no-previous-prototype-for-function-hci_scan_disable_sync
|-- i386-randconfig-a015-20211028
|   |-- net-bluetooth-hci_sync.c:warning:no-previous-prototype-for-function-hci_passive_scan_sync
|   `-- net-bluetooth-hci_sync.c:warning:no-previous-prototype-for-function-hci_scan_disable_sync
|-- x86_64-randconfig-a013-20211028
|   |-- net-bluetooth-hci_sync.c:warning:no-previous-prototype-for-function-hci_passive_scan_sync
|   `-- net-bluetooth-hci_sync.c:warning:no-previous-prototype-for-function-hci_scan_disable_sync
|-- x86_64-randconfig-c007-20211028
|   |-- net-bluetooth-hci_sync.c:warning:no-previous-prototype-for-function-hci_passive_scan_sync
|   `-- net-bluetooth-hci_sync.c:warning:no-previous-prototype-for-function-hci_scan_disable_sync
`-- x86_64-randconfig-r015-20211028
    |-- net-bluetooth-hci_sync.c:warning:no-previous-prototype-for-function-hci_passive_scan_sync
    `-- net-bluetooth-hci_sync.c:warning:no-previous-prototype-for-function-hci_scan_disable_sync

elapsed time: 2301m

configs tested: 172
configs skipped: 3

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20211028
powerpc              randconfig-c003-20211028
s390                       zfcpdump_defconfig
powerpc                 mpc8272_ads_defconfig
arc                              alldefconfig
sh                            shmin_defconfig
powerpc                 canyonlands_defconfig
mips                        vocore2_defconfig
sh                          landisk_defconfig
um                           x86_64_defconfig
sh                           se7751_defconfig
arm                          exynos_defconfig
m68k                          multi_defconfig
powerpc               mpc834x_itxgp_defconfig
m68k                         amcore_defconfig
sh                        apsh4ad0a_defconfig
arm                        magician_defconfig
mips                   sb1250_swarm_defconfig
arm                       omap2plus_defconfig
powerpc                     redwood_defconfig
m68k                          atari_defconfig
mips                        jmr3927_defconfig
arm                    vt8500_v6_v7_defconfig
openrisc                         alldefconfig
arm                         bcm2835_defconfig
sh                          kfr2r09_defconfig
parisc                generic-32bit_defconfig
sh                             shx3_defconfig
mips                      fuloong2e_defconfig
arm                           h3600_defconfig
arm                         s5pv210_defconfig
s390                             alldefconfig
riscv                    nommu_k210_defconfig
m68k                       m5475evb_defconfig
sh                           se7724_defconfig
powerpc                    mvme5100_defconfig
m68k                        mvme147_defconfig
arm                             pxa_defconfig
sh                          polaris_defconfig
mips                          rm200_defconfig
mips                malta_qemu_32r6_defconfig
arm                         shannon_defconfig
powerpc                     tqm8541_defconfig
sh                          rsk7269_defconfig
sh                               j2_defconfig
arm                        multi_v5_defconfig
openrisc                  or1klitex_defconfig
sh                           sh2007_defconfig
arm                          ixp4xx_defconfig
powerpc                  iss476-smp_defconfig
powerpc                  mpc885_ads_defconfig
powerpc                      ppc64e_defconfig
microblaze                          defconfig
sh                        edosk7705_defconfig
powerpc                 mpc837x_rdb_defconfig
arm                  randconfig-c002-20211028
arm                  randconfig-c002-20211029
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                                defconfig
m68k                             allmodconfig
m68k                             allyesconfig
nios2                               defconfig
nds32                             allnoconfig
nds32                               defconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
nios2                            allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
xtensa                           allyesconfig
parisc                              defconfig
s390                                defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
i386                              debian-10.3
i386                             allyesconfig
arc                              allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                           allnoconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
x86_64               randconfig-a002-20211028
x86_64               randconfig-a004-20211028
x86_64               randconfig-a005-20211028
x86_64               randconfig-a001-20211028
x86_64               randconfig-a006-20211028
x86_64               randconfig-a003-20211028
i386                 randconfig-a004-20211028
i386                 randconfig-a003-20211028
i386                 randconfig-a002-20211028
i386                 randconfig-a006-20211028
i386                 randconfig-a001-20211028
i386                 randconfig-a005-20211028
x86_64               randconfig-a015-20211029
x86_64               randconfig-a013-20211029
x86_64               randconfig-a011-20211029
x86_64               randconfig-a014-20211029
x86_64               randconfig-a012-20211029
x86_64               randconfig-a016-20211029
i386                 randconfig-a012-20211029
i386                 randconfig-a013-20211029
i386                 randconfig-a011-20211029
i386                 randconfig-a015-20211029
i386                 randconfig-a016-20211029
i386                 randconfig-a014-20211029
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allyesconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                             i386_defconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec
x86_64                           allyesconfig

clang tested configs:
arm                  randconfig-c002-20211028
powerpc              randconfig-c003-20211028
riscv                randconfig-c006-20211028
x86_64               randconfig-c007-20211028
mips                 randconfig-c004-20211028
s390                 randconfig-c005-20211028
i386                 randconfig-c001-20211028
arm                  randconfig-c002-20211029
powerpc              randconfig-c003-20211029
riscv                randconfig-c006-20211029
x86_64               randconfig-c007-20211029
mips                 randconfig-c004-20211029
s390                 randconfig-c005-20211029
i386                 randconfig-c001-20211029
x86_64               randconfig-a005-20211030
x86_64               randconfig-a004-20211030
x86_64               randconfig-a002-20211030
x86_64               randconfig-a003-20211030
x86_64               randconfig-a001-20211030
x86_64               randconfig-a006-20211030
i386                 randconfig-a004-20211029
i386                 randconfig-a003-20211029
i386                 randconfig-a002-20211029
i386                 randconfig-a001-20211029
i386                 randconfig-a006-20211029
i386                 randconfig-a005-20211029
x86_64               randconfig-a015-20211028
x86_64               randconfig-a013-20211028
x86_64               randconfig-a011-20211028
x86_64               randconfig-a014-20211028
x86_64               randconfig-a012-20211028
x86_64               randconfig-a016-20211028
i386                 randconfig-a012-20211028
i386                 randconfig-a013-20211028
i386                 randconfig-a011-20211028
i386                 randconfig-a015-20211028
i386                 randconfig-a016-20211028
i386                 randconfig-a014-20211028
hexagon              randconfig-r045-20211028
riscv                randconfig-r042-20211028
s390                 randconfig-r044-20211028
hexagon              randconfig-r041-20211028
hexagon              randconfig-r045-20211029
hexagon              randconfig-r041-20211029

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
