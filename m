Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 388B0C433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu,  2 Sep 2021 23:37:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17B6F60FDA
	for <linux-bluetooth@archiver.kernel.org>; Thu,  2 Sep 2021 23:37:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346139AbhIBXio (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 2 Sep 2021 19:38:44 -0400
Received: from mga18.intel.com ([134.134.136.126]:7411 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235909AbhIBXin (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 2 Sep 2021 19:38:43 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10095"; a="206398100"
X-IronPort-AV: E=Sophos;i="5.85,263,1624345200"; 
   d="scan'208";a="206398100"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2021 16:37:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,263,1624345200"; 
   d="scan'208";a="521439116"
Received: from lkp-server01.sh.intel.com (HELO 4fbc2b3ce5aa) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 02 Sep 2021 16:37:42 -0700
Received: from kbuild by 4fbc2b3ce5aa with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mLwH7-0009OI-OF; Thu, 02 Sep 2021 23:37:41 +0000
Date:   Fri, 03 Sep 2021 07:37:18 +0800
From:   kernel test robot <lkp@intel.com>
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 15957cab9db009c10925994b59a64410a707c17e
Message-ID: <6131602e.C1SRn1ctn1naGR9J%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: 15957cab9db009c10925994b59a64410a707c17e  Bluetooth: btusb: Add support for IMC Networks Mediatek Chip(MT7921)

elapsed time: 725m

configs tested: 238
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20210831
i386                 randconfig-c001-20210903
i386                 randconfig-c001-20210902
arm                         shannon_defconfig
powerpc                    mvme5100_defconfig
powerpc                       ppc64_defconfig
m68k                        m5272c3_defconfig
xtensa                              defconfig
um                                  defconfig
riscv                    nommu_k210_defconfig
powerpc                 mpc8540_ads_defconfig
sh                          sdk7786_defconfig
arm                            xcep_defconfig
arm                          ep93xx_defconfig
arc                          axs101_defconfig
powerpc                   motionpro_defconfig
mips                          malta_defconfig
mips                          ath25_defconfig
mips                      fuloong2e_defconfig
s390                             alldefconfig
powerpc                       eiger_defconfig
sh                        dreamcast_defconfig
arm                           viper_defconfig
openrisc                            defconfig
arm                     am200epdkit_defconfig
powerpc                     ppa8548_defconfig
powerpc                 mpc836x_mds_defconfig
mips                        maltaup_defconfig
powerpc                     pseries_defconfig
arm                        multi_v5_defconfig
arm                         lpc18xx_defconfig
x86_64                           alldefconfig
arm                      integrator_defconfig
arm                         cm_x300_defconfig
arm                           corgi_defconfig
mips                           jazz_defconfig
powerpc                      acadia_defconfig
powerpc                   microwatt_defconfig
arm                       multi_v4t_defconfig
sh                            hp6xx_defconfig
arm                          moxart_defconfig
sh                        edosk7760_defconfig
riscv                            alldefconfig
arm                          pxa168_defconfig
sh                        edosk7705_defconfig
mips                   sb1250_swarm_defconfig
powerpc                      pasemi_defconfig
powerpc                      obs600_defconfig
arm                           sama7_defconfig
h8300                            alldefconfig
nios2                            alldefconfig
arm                         assabet_defconfig
arm                           tegra_defconfig
arm                        trizeps4_defconfig
x86_64                           allyesconfig
arm                         at91_dt_defconfig
m68k                       bvme6000_defconfig
csky                                defconfig
x86_64                            allnoconfig
mips                      maltaaprp_defconfig
m68k                        m5307c3_defconfig
arm                            lart_defconfig
sh                   secureedge5410_defconfig
powerpc                     mpc83xx_defconfig
xtensa                       common_defconfig
m68k                        stmark2_defconfig
powerpc                      tqm8xx_defconfig
xtensa                generic_kc705_defconfig
riscv             nommu_k210_sdcard_defconfig
sh                        sh7785lcr_defconfig
powerpc                      pcm030_defconfig
sh                   sh7770_generic_defconfig
arm                         lpc32xx_defconfig
arm                     davinci_all_defconfig
mips                           gcw0_defconfig
sh                           se7724_defconfig
arm                          pcm027_defconfig
nds32                               defconfig
ia64                             allmodconfig
alpha                               defconfig
arm                          collie_defconfig
arm                         s3c6400_defconfig
sh                             sh03_defconfig
m68k                          multi_defconfig
powerpc                     tqm8541_defconfig
openrisc                  or1klitex_defconfig
powerpc                    adder875_defconfig
arm                           omap1_defconfig
arm                           spitz_defconfig
arm                        spear3xx_defconfig
arc                        vdk_hs38_defconfig
sparc                       sparc32_defconfig
mips                       lemote2f_defconfig
arm                     eseries_pxa_defconfig
powerpc                     redwood_defconfig
arm                         s3c2410_defconfig
sh                           se7619_defconfig
nios2                            allyesconfig
nios2                         10m50_defconfig
arm                          ixp4xx_defconfig
powerpc                        cell_defconfig
arm                              alldefconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a005-20210831
x86_64               randconfig-a001-20210831
x86_64               randconfig-a003-20210831
x86_64               randconfig-a002-20210831
x86_64               randconfig-a004-20210831
x86_64               randconfig-a006-20210831
i386                 randconfig-a005-20210831
i386                 randconfig-a002-20210831
i386                 randconfig-a003-20210831
i386                 randconfig-a006-20210831
i386                 randconfig-a004-20210831
i386                 randconfig-a001-20210831
i386                 randconfig-a005-20210902
i386                 randconfig-a004-20210902
i386                 randconfig-a006-20210902
i386                 randconfig-a002-20210902
i386                 randconfig-a001-20210902
i386                 randconfig-a003-20210902
x86_64               randconfig-a016-20210903
x86_64               randconfig-a011-20210903
x86_64               randconfig-a012-20210903
x86_64               randconfig-a015-20210903
x86_64               randconfig-a014-20210903
x86_64               randconfig-a013-20210903
i386                 randconfig-a012-20210903
i386                 randconfig-a015-20210903
i386                 randconfig-a011-20210903
i386                 randconfig-a013-20210903
i386                 randconfig-a014-20210903
i386                 randconfig-a016-20210903
x86_64               randconfig-a004-20210902
x86_64               randconfig-a006-20210902
x86_64               randconfig-a003-20210902
x86_64               randconfig-a005-20210902
x86_64               randconfig-a001-20210902
x86_64               randconfig-a002-20210902
arc                  randconfig-r043-20210831
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
s390                 randconfig-c005-20210903
mips                 randconfig-c004-20210903
x86_64               randconfig-c007-20210903
powerpc              randconfig-c003-20210903
i386                 randconfig-c001-20210903
arm                  randconfig-c002-20210903
riscv                randconfig-c006-20210903
s390                 randconfig-c005-20210901
mips                 randconfig-c004-20210901
x86_64               randconfig-c007-20210901
powerpc              randconfig-c003-20210901
i386                 randconfig-c001-20210901
arm                  randconfig-c002-20210901
riscv                randconfig-c006-20210901
x86_64               randconfig-a004-20210903
x86_64               randconfig-a006-20210903
x86_64               randconfig-a003-20210903
x86_64               randconfig-a005-20210903
x86_64               randconfig-a001-20210903
x86_64               randconfig-a002-20210903
i386                 randconfig-a005-20210903
i386                 randconfig-a004-20210903
i386                 randconfig-a006-20210903
i386                 randconfig-a002-20210903
i386                 randconfig-a001-20210903
i386                 randconfig-a003-20210903
x86_64               randconfig-a014-20210831
x86_64               randconfig-a015-20210831
x86_64               randconfig-a013-20210831
x86_64               randconfig-a016-20210831
x86_64               randconfig-a012-20210831
x86_64               randconfig-a011-20210831
i386                 randconfig-a016-20210831
i386                 randconfig-a011-20210831
i386                 randconfig-a015-20210831
i386                 randconfig-a014-20210831
i386                 randconfig-a012-20210831
i386                 randconfig-a013-20210831
i386                 randconfig-a012-20210902
i386                 randconfig-a015-20210902
i386                 randconfig-a011-20210902
i386                 randconfig-a013-20210902
i386                 randconfig-a014-20210902
i386                 randconfig-a016-20210902
hexagon              randconfig-r045-20210901
hexagon              randconfig-r041-20210901
hexagon              randconfig-r045-20210903
hexagon              randconfig-r041-20210903
riscv                randconfig-r042-20210902
hexagon              randconfig-r045-20210902
s390                 randconfig-r044-20210902
hexagon              randconfig-r041-20210902
s390                 randconfig-r044-20210831
hexagon              randconfig-r041-20210831
hexagon              randconfig-r045-20210831
riscv                randconfig-r042-20210831

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
