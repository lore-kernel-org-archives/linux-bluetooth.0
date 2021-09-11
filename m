Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0B13C433F5
	for <linux-bluetooth@archiver.kernel.org>; Sat, 11 Sep 2021 12:40:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C29B5611F2
	for <linux-bluetooth@archiver.kernel.org>; Sat, 11 Sep 2021 12:40:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235781AbhIKMlQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 11 Sep 2021 08:41:16 -0400
Received: from mga06.intel.com ([134.134.136.31]:14163 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230249AbhIKMlP (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 11 Sep 2021 08:41:15 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10103"; a="282302824"
X-IronPort-AV: E=Sophos;i="5.85,285,1624345200"; 
   d="scan'208";a="282302824"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2021 05:40:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,285,1624345200"; 
   d="scan'208";a="695498433"
Received: from lkp-server01.sh.intel.com (HELO 730d49888f40) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 11 Sep 2021 05:40:00 -0700
Received: from kbuild by 730d49888f40 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mP2IZ-0005QY-Kd; Sat, 11 Sep 2021 12:39:59 +0000
Date:   Sat, 11 Sep 2021 20:39:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 2fc7acb69fa3573d4bf7a90c323296d840daf330
Message-ID: <613ca37e.RrGb5BPurio0eMqX%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: 2fc7acb69fa3573d4bf7a90c323296d840daf330  Bluetooth: hci_uart: fix GPF in h5_recv

elapsed time: 1714m

configs tested: 171
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20210910
xtensa                    xip_kc705_defconfig
mips                        bcm47xx_defconfig
powerpc                     tqm8548_defconfig
arm                      jornada720_defconfig
arm                          imote2_defconfig
sh                                  defconfig
ia64                         bigsur_defconfig
powerpc                     kmeter1_defconfig
powerpc                   bluestone_defconfig
um                             i386_defconfig
arm                         s5pv210_defconfig
powerpc                 mpc837x_rdb_defconfig
powerpc                     akebono_defconfig
nios2                         3c120_defconfig
sh                         ap325rxa_defconfig
m68k                          atari_defconfig
h8300                    h8300h-sim_defconfig
m68k                          multi_defconfig
arm                         s3c6400_defconfig
xtensa                    smp_lx200_defconfig
powerpc                    gamecube_defconfig
sh                            migor_defconfig
microblaze                      mmu_defconfig
sh                          rsk7264_defconfig
arc                    vdk_hs38_smp_defconfig
arm                           stm32_defconfig
arm                         assabet_defconfig
mips                       rbtx49xx_defconfig
m68k                       m5475evb_defconfig
powerpc                          g5_defconfig
arm                         lubbock_defconfig
sh                   sh7770_generic_defconfig
arm                        cerfcube_defconfig
arm                          pxa910_defconfig
mips                         tb0287_defconfig
h8300                       h8s-sim_defconfig
mips                           ip27_defconfig
powerpc                     ksi8560_defconfig
powerpc                     tqm8541_defconfig
m68k                             alldefconfig
powerpc                   microwatt_defconfig
mips                          ath25_defconfig
arm                            zeus_defconfig
arm                      tct_hammer_defconfig
arm                        magician_defconfig
powerpc                     tqm8540_defconfig
microblaze                          defconfig
powerpc                     mpc5200_defconfig
arm                  colibri_pxa300_defconfig
arm                        clps711x_defconfig
s390                             alldefconfig
ia64                      gensparse_defconfig
sh                           se7712_defconfig
arm                          ixp4xx_defconfig
powerpc                      pmac32_defconfig
arm                         lpc18xx_defconfig
powerpc                      bamboo_defconfig
um                                  defconfig
m68k                       m5208evb_defconfig
arm                          ep93xx_defconfig
powerpc                 canyonlands_defconfig
arm                       omap2plus_defconfig
arm                           spitz_defconfig
m68k                            mac_defconfig
mips                           ip32_defconfig
alpha                            alldefconfig
powerpc                 mpc8560_ads_defconfig
arm                         mv78xx0_defconfig
powerpc                mpc7448_hpc2_defconfig
powerpc                 mpc832x_rdb_defconfig
sh                           se7724_defconfig
parisc                generic-64bit_defconfig
csky                             alldefconfig
sh                            hp6xx_defconfig
powerpc                    adder875_defconfig
parisc                              defconfig
sh                          r7785rp_defconfig
arm                           h5000_defconfig
powerpc                 mpc834x_itx_defconfig
sh                        edosk7760_defconfig
ia64                            zx1_defconfig
openrisc                    or1ksim_defconfig
mips                        workpad_defconfig
arm                         palmz72_defconfig
arm                       versatile_defconfig
x86_64               randconfig-c001-20210910
arm                  randconfig-c002-20210910
x86_64                            allnoconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                                defconfig
m68k                             allmodconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
xtensa                           allyesconfig
s390                             allyesconfig
s390                             allmodconfig
s390                                defconfig
parisc                           allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
i386                             allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
powerpc                          allyesconfig
x86_64               randconfig-a013-20210910
x86_64               randconfig-a016-20210910
x86_64               randconfig-a012-20210910
x86_64               randconfig-a011-20210910
x86_64               randconfig-a014-20210910
x86_64               randconfig-a015-20210910
i386                 randconfig-a016-20210910
i386                 randconfig-a011-20210910
i386                 randconfig-a012-20210910
i386                 randconfig-a013-20210910
i386                 randconfig-a014-20210910
i386                 randconfig-a015-20210910
riscv                randconfig-r042-20210910
s390                 randconfig-r044-20210910
arc                  randconfig-r043-20210910
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allyesconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec
x86_64                           allyesconfig

clang tested configs:
x86_64               randconfig-c007-20210910
mips                 randconfig-c004-20210910
powerpc              randconfig-c003-20210910
i386                 randconfig-c001-20210910
s390                 randconfig-c005-20210910
x86_64               randconfig-a002-20210910
x86_64               randconfig-a003-20210910
x86_64               randconfig-a004-20210910
x86_64               randconfig-a006-20210910
x86_64               randconfig-a001-20210910
x86_64               randconfig-a005-20210910
i386                 randconfig-a004-20210910
i386                 randconfig-a005-20210910
i386                 randconfig-a002-20210910
i386                 randconfig-a006-20210910
i386                 randconfig-a001-20210910
i386                 randconfig-a003-20210910
hexagon              randconfig-r045-20210910
hexagon              randconfig-r041-20210910

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
