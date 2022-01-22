Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 446FCC433F5
	for <linux-bluetooth@archiver.kernel.org>; Sat, 22 Jan 2022 12:39:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232035AbiAVMji (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 22 Jan 2022 07:39:38 -0500
Received: from mga17.intel.com ([192.55.52.151]:33363 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230360AbiAVMji (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 22 Jan 2022 07:39:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642855178; x=1674391178;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=/oaMs9DJMRhTqUe7YEpyY5rN0hAf+yXfK0HQ1aAZ0Fg=;
  b=TG44FDWOq0FMAZWlRBJ8SUvpC16sEOm+82MDuShprpGLNu/Ew9N/Pi+X
   85AO8u/DieANnyFwpI187emnstr449pebRAaU1GRZfuCnT14X+7ntFjCp
   6YQqO3xQB6oho6dJCZv+zR/P7kc2DDNG9euaf2y1uODdFOzPq8g07i4yg
   8ev0VB7/9N62p2iJ98HZz/Kc8XauMUSi22uYtZMdjmsVqSLqhc7R7z771
   RspFsqGqI9s4OJVDsO/JroJhOUKaoFuLN6MmJmMVa54elMVDF1fiSS9My
   OVe0TOuDzOqhIfv3tLabojVrIObzuI+MyepTCz5z/y7V54jMXHLjfYU+o
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10234"; a="226493783"
X-IronPort-AV: E=Sophos;i="5.88,308,1635231600"; 
   d="scan'208";a="226493783"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2022 04:39:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,308,1635231600"; 
   d="scan'208";a="673198910"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 22 Jan 2022 04:39:37 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nBFg8-000GOo-FV; Sat, 22 Jan 2022 12:39:36 +0000
Date:   Sat, 22 Jan 2022 20:39:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 db3f1f9b5d88d8d7f9eaa486f71784dd319285ff
Message-ID: <61ebfb03.PYVhd9Qf3p51ElNk%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: db3f1f9b5d88d8d7f9eaa486f71784dd319285ff  Bluetooth: btmtksdio: mask out interrupt status

elapsed time: 720m

configs tested: 143
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                          randconfig-c001
powerpc              randconfig-c003-20220120
i386                 randconfig-c001-20220117
sh                        apsh4ad0a_defconfig
sh                        dreamcast_defconfig
powerpc                 mpc837x_rdb_defconfig
sh                          polaris_defconfig
nds32                             allnoconfig
m68k                            q40_defconfig
powerpc                  storcenter_defconfig
arc                     nsimosci_hs_defconfig
xtensa                  nommu_kc705_defconfig
sh                        sh7763rdp_defconfig
arm                           stm32_defconfig
s390                             allmodconfig
arc                          axs103_defconfig
arm                         lpc18xx_defconfig
arm                          exynos_defconfig
mips                         tb0226_defconfig
sh                  sh7785lcr_32bit_defconfig
m68k                                defconfig
m68k                         apollo_defconfig
x86_64                           alldefconfig
arm                           tegra_defconfig
sh                           se7206_defconfig
ia64                          tiger_defconfig
arm                         nhk8815_defconfig
xtensa                    xip_kc705_defconfig
arm                           viper_defconfig
powerpc                 mpc834x_mds_defconfig
arm                        multi_v7_defconfig
mips                           gcw0_defconfig
nios2                         10m50_defconfig
mips                             allyesconfig
arm                           h5000_defconfig
powerpc                         ps3_defconfig
powerpc                       maple_defconfig
sh                           se7751_defconfig
sh                          sdk7780_defconfig
ia64                            zx1_defconfig
arm                         s3c6400_defconfig
h8300                            alldefconfig
sh                     sh7710voipgw_defconfig
arm                  randconfig-c002-20220120
arm                  randconfig-c002-20220121
ia64                                defconfig
ia64                             allmodconfig
ia64                             allyesconfig
m68k                             allyesconfig
m68k                             allmodconfig
nios2                               defconfig
arc                              allyesconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                                defconfig
s390                             allyesconfig
parisc                           allyesconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allmodconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
powerpc                          allyesconfig
i386                          randconfig-a003
i386                          randconfig-a001
i386                          randconfig-a005
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
arc                  randconfig-r043-20220120
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec

clang tested configs:
x86_64                        randconfig-c007
arm                  randconfig-c002-20220121
riscv                randconfig-c006-20220121
powerpc              randconfig-c003-20220121
mips                 randconfig-c004-20220121
i386                          randconfig-c001
arm                  randconfig-c002-20220120
riscv                randconfig-c006-20220120
powerpc              randconfig-c003-20220120
mips                 randconfig-c004-20220120
mips                      maltaaprp_defconfig
powerpc                       ebony_defconfig
riscv                            alldefconfig
arm                  colibri_pxa270_defconfig
powerpc                     ksi8560_defconfig
powerpc                    mvme5100_defconfig
arm                        spear3xx_defconfig
i386                 randconfig-a005-20220117
i386                 randconfig-a001-20220117
i386                 randconfig-a006-20220117
i386                 randconfig-a004-20220117
i386                 randconfig-a002-20220117
i386                 randconfig-a003-20220117
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
x86_64               randconfig-a005-20220117
x86_64               randconfig-a004-20220117
x86_64               randconfig-a001-20220117
x86_64               randconfig-a006-20220117
x86_64               randconfig-a002-20220117
x86_64               randconfig-a003-20220117
hexagon              randconfig-r045-20220120
hexagon              randconfig-r041-20220120
riscv                randconfig-r042-20220120
s390                 randconfig-r044-20220120

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
