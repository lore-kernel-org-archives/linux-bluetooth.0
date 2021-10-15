Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FE35C433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri, 15 Oct 2021 19:20:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02C7A61163
	for <linux-bluetooth@archiver.kernel.org>; Fri, 15 Oct 2021 19:20:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230372AbhJOTWS (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 15 Oct 2021 15:22:18 -0400
Received: from mga07.intel.com ([134.134.136.100]:46624 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230009AbhJOTWN (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 15 Oct 2021 15:22:13 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10138"; a="291454362"
X-IronPort-AV: E=Sophos;i="5.85,376,1624345200"; 
   d="scan'208";a="291454362"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2021 12:20:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,376,1624345200"; 
   d="scan'208";a="481807344"
Received: from lkp-server02.sh.intel.com (HELO 08b2c502c3de) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 15 Oct 2021 12:20:05 -0700
Received: from kbuild by 08b2c502c3de with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mbSkO-0008Iw-2o; Fri, 15 Oct 2021 19:20:04 +0000
Date:   Sat, 16 Oct 2021 03:19:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 b8f5482c9638915c19963f06d2f4094e276aaab6
Message-ID: <6169d450.ZGKQVMBN9SCn0FuX%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: b8f5482c9638915c19963f06d2f4094e276aaab6  Bluetooth: vhci: Add support for setting msft_opcode and aosp_capable

elapsed time: 1510m

configs tested: 174
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allmodconfig
arm                              allyesconfig
mips                 randconfig-c004-20211015
i386                 randconfig-c001-20211015
i386                 randconfig-c001-20211014
mips                     loongson1b_defconfig
arm                            mmp2_defconfig
mips                          rb532_defconfig
arm                          exynos_defconfig
sh                        edosk7705_defconfig
h8300                       h8s-sim_defconfig
arm                           h3600_defconfig
powerpc                       ppc64_defconfig
mips                  decstation_64_defconfig
ia64                            zx1_defconfig
mips                           ci20_defconfig
arm                            zeus_defconfig
sh                           se7206_defconfig
sh                         ap325rxa_defconfig
powerpc                     ep8248e_defconfig
powerpc                     mpc83xx_defconfig
mips                           ip32_defconfig
powerpc                     stx_gp3_defconfig
mips                        bcm63xx_defconfig
arm                        spear3xx_defconfig
sh                          polaris_defconfig
powerpc                     rainier_defconfig
arm                             ezx_defconfig
s390                             alldefconfig
mips                 decstation_r4k_defconfig
arm                          collie_defconfig
arm                            qcom_defconfig
arc                      axs103_smp_defconfig
powerpc                   currituck_defconfig
powerpc                     skiroot_defconfig
xtensa                         virt_defconfig
mips                         bigsur_defconfig
arc                              alldefconfig
m68k                            q40_defconfig
sh                        edosk7760_defconfig
mips                malta_qemu_32r6_defconfig
powerpc                   lite5200b_defconfig
arm                         orion5x_defconfig
sh                          rsk7203_defconfig
sparc                            allyesconfig
mips                     loongson1c_defconfig
arm                         lpc32xx_defconfig
powerpc                      tqm8xx_defconfig
powerpc                    adder875_defconfig
arc                        nsim_700_defconfig
parisc                           alldefconfig
powerpc                    socrates_defconfig
arm                        mvebu_v5_defconfig
riscv                    nommu_k210_defconfig
sh                           se7722_defconfig
arm                         s3c6400_defconfig
sparc                       sparc32_defconfig
powerpc                     tqm8540_defconfig
arm                         socfpga_defconfig
m68k                       m5208evb_defconfig
powerpc                     tqm5200_defconfig
sh                        dreamcast_defconfig
arm                          gemini_defconfig
powerpc                      pasemi_defconfig
m68k                         apollo_defconfig
arm                       imx_v6_v7_defconfig
sh                            migor_defconfig
arm                  colibri_pxa300_defconfig
s390                          debug_defconfig
sh                               j2_defconfig
sh                             espt_defconfig
mips                        bcm47xx_defconfig
powerpc                      obs600_defconfig
microblaze                      mmu_defconfig
arm                      integrator_defconfig
powerpc                    sam440ep_defconfig
sh                          rsk7269_defconfig
arm                          lpd270_defconfig
powerpc                 mpc8560_ads_defconfig
arm                        vexpress_defconfig
powerpc                      pmac32_defconfig
riscv                            allmodconfig
powerpc                 mpc8315_rdb_defconfig
s390                       zfcpdump_defconfig
powerpc                     mpc5200_defconfig
ia64                             allmodconfig
arm                          simpad_defconfig
mips                   sb1250_swarm_defconfig
arm                  randconfig-c002-20211015
x86_64               randconfig-c001-20211015
arm                  randconfig-c002-20211014
x86_64               randconfig-c001-20211014
ia64                                defconfig
ia64                             allyesconfig
m68k                                defconfig
m68k                             allmodconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
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
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a006-20211014
x86_64               randconfig-a004-20211014
x86_64               randconfig-a001-20211014
x86_64               randconfig-a005-20211014
x86_64               randconfig-a002-20211014
x86_64               randconfig-a003-20211014
i386                 randconfig-a003-20211014
i386                 randconfig-a001-20211014
i386                 randconfig-a005-20211014
i386                 randconfig-a004-20211014
i386                 randconfig-a002-20211014
i386                 randconfig-a006-20211014
i386                 randconfig-a016-20211015
i386                 randconfig-a014-20211015
i386                 randconfig-a011-20211015
i386                 randconfig-a015-20211015
i386                 randconfig-a012-20211015
i386                 randconfig-a013-20211015
arc                  randconfig-r043-20211014
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allyesconfig
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a012-20211014
x86_64               randconfig-a015-20211014
x86_64               randconfig-a016-20211014
x86_64               randconfig-a014-20211014
x86_64               randconfig-a011-20211014
x86_64               randconfig-a013-20211014
i386                 randconfig-a016-20211014
i386                 randconfig-a014-20211014
i386                 randconfig-a011-20211014
i386                 randconfig-a015-20211014
i386                 randconfig-a012-20211014
i386                 randconfig-a013-20211014
hexagon              randconfig-r041-20211014
s390                 randconfig-r044-20211014
riscv                randconfig-r042-20211014
hexagon              randconfig-r045-20211014
hexagon              randconfig-r041-20211015
hexagon              randconfig-r045-20211015

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
