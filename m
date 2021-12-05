Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84177C433F5
	for <linux-bluetooth@archiver.kernel.org>; Sun,  5 Dec 2021 10:59:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233029AbhLELCz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 5 Dec 2021 06:02:55 -0500
Received: from mga06.intel.com ([134.134.136.31]:63929 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232844AbhLELCz (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 5 Dec 2021 06:02:55 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10188"; a="297976220"
X-IronPort-AV: E=Sophos;i="5.87,289,1631602800"; 
   d="scan'208";a="297976220"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2021 02:59:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,289,1631602800"; 
   d="scan'208";a="678655419"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 05 Dec 2021 02:59:27 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mtpEs-000K4E-Gf; Sun, 05 Dec 2021 10:59:26 +0000
Date:   Sun, 05 Dec 2021 18:58:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 aeb8b133415a7de34e66d1da42c9824248b212cc
Message-ID: <61ac9b72.gGE6DzSr06kYAJXZ%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: aeb8b133415a7de34e66d1da42c9824248b212cc  Bluetooth: hci_sync: Set Privacy Mode when updating the resolving list

elapsed time: 1059m

configs tested: 140
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                            allyesconfig
arm                              allyesconfig
arm                              allmodconfig
arm                                 defconfig
arm64                               defconfig
powerpc                     mpc5200_defconfig
sh                      rts7751r2d1_defconfig
nios2                               defconfig
arm                        clps711x_defconfig
arc                              allyesconfig
sh                            hp6xx_defconfig
riscv                    nommu_k210_defconfig
openrisc                         alldefconfig
sh                        sh7785lcr_defconfig
arm                         axm55xx_defconfig
powerpc                 mpc832x_rdb_defconfig
m68k                          atari_defconfig
powerpc                     tqm8560_defconfig
sh                     sh7710voipgw_defconfig
arm                       aspeed_g5_defconfig
powerpc                      cm5200_defconfig
powerpc                     skiroot_defconfig
arm                           sunxi_defconfig
arm                          ep93xx_defconfig
m68k                            mac_defconfig
arm                          badge4_defconfig
arc                     nsimosci_hs_defconfig
mips                      pic32mzda_defconfig
powerpc                     tqm8541_defconfig
powerpc                      tqm8xx_defconfig
powerpc                      walnut_defconfig
m68k                        m5407c3_defconfig
ia64                          tiger_defconfig
xtensa                       common_defconfig
sh                   sh7724_generic_defconfig
powerpc                    socrates_defconfig
sh                           se7712_defconfig
arm                           stm32_defconfig
arm                      integrator_defconfig
sh                           se7780_defconfig
arm                         lubbock_defconfig
s390                       zfcpdump_defconfig
sh                        sh7757lcr_defconfig
sh                           se7721_defconfig
um                           x86_64_defconfig
arm                            qcom_defconfig
powerpc                 mpc8272_ads_defconfig
arm                        mvebu_v5_defconfig
arm                            mps2_defconfig
arm                         cm_x300_defconfig
powerpc                    amigaone_defconfig
powerpc                     mpc83xx_defconfig
m68k                           sun3_defconfig
sh                              ul2_defconfig
arm                          moxart_defconfig
h8300                    h8300h-sim_defconfig
powerpc                     mpc512x_defconfig
sh                         apsh4a3a_defconfig
powerpc                          g5_defconfig
sh                            migor_defconfig
arm                  randconfig-c002-20211205
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nds32                             allnoconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
h8300                            allyesconfig
xtensa                           allyesconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allmodconfig
mips                             allyesconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a006-20211205
x86_64               randconfig-a005-20211205
x86_64               randconfig-a001-20211205
x86_64               randconfig-a002-20211205
x86_64               randconfig-a004-20211205
x86_64               randconfig-a003-20211205
i386                 randconfig-a001-20211205
i386                 randconfig-a005-20211205
i386                 randconfig-a003-20211205
i386                 randconfig-a002-20211205
i386                 randconfig-a006-20211205
i386                 randconfig-a004-20211205
i386                 randconfig-a001-20211203
i386                 randconfig-a005-20211203
i386                 randconfig-a002-20211203
i386                 randconfig-a003-20211203
i386                 randconfig-a006-20211203
i386                 randconfig-a004-20211203
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a016-20211205
x86_64               randconfig-a011-20211205
x86_64               randconfig-a013-20211205
x86_64               randconfig-a015-20211205
x86_64               randconfig-a012-20211205
x86_64               randconfig-a014-20211205
i386                 randconfig-a013-20211205
i386                 randconfig-a016-20211205
i386                 randconfig-a011-20211205
i386                 randconfig-a014-20211205
i386                 randconfig-a012-20211205
i386                 randconfig-a015-20211205
hexagon              randconfig-r045-20211205
s390                 randconfig-r044-20211205
riscv                randconfig-r042-20211205
hexagon              randconfig-r041-20211205

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
