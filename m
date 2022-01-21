Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10531C433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 21 Jan 2022 18:37:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346158AbiAUShC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 21 Jan 2022 13:37:02 -0500
Received: from mga04.intel.com ([192.55.52.120]:29422 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241096AbiAUShC (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 21 Jan 2022 13:37:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642790222; x=1674326222;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=0sIthaLnmWZHiwsMY0uooCeLogNWeDy6TiwG+3r3NBk=;
  b=Gk6/NX1JH0hEAEZ6nlgjAYsC6mS2Yq+XU3zPEPEMznpfCqM4sPYLqdz7
   olYj3eizaEKJn54rsd6iEgLGpprujiUf6QzJDD7vLNVts5chVQlTdg1XX
   /w7Tnje/baGtjGYBq7yr3QYVmVrl0szUHIidm+0g2dW52SVr5qELu+Y1F
   5GiFwF3lXSYozAA3uEmP7RdqqZztLvgSbgBT9S4WisvGLNd6ndlGibWTe
   udfbpwg65QeuFaY7Hm8u3yYUEDnpyLUbazMMPrVtPygAPLoRh8u6Qaqye
   l5p9dYT5AZfbE08XrW7o4E2U+8/aQ3jRFQp5CXSUdoVAfOeW1mlW1Sgxa
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10234"; a="244543951"
X-IronPort-AV: E=Sophos;i="5.88,306,1635231600"; 
   d="scan'208";a="244543951"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2022 10:37:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,306,1635231600"; 
   d="scan'208";a="561966364"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 21 Jan 2022 10:37:00 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nAymS-000FZH-3c; Fri, 21 Jan 2022 18:37:00 +0000
Date:   Sat, 22 Jan 2022 02:36:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc:     linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 8d7f167752c3e4c45a39e76ffa6f7209413d3fa6
Message-ID: <61eafd38.Mm5hlScIt701WdH0%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: 8d7f167752c3e4c45a39e76ffa6f7209413d3fa6  Bluetooth: mgmt: Add MGMT Adv Monitor Device Found/Lost events

elapsed time: 725m

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
i386                          randconfig-c001
mips                 randconfig-c004-20220120
powerpc              randconfig-c003-20220120
sh                          urquell_defconfig
sh                               j2_defconfig
arm                           stm32_defconfig
sh                          landisk_defconfig
arm                           corgi_defconfig
powerpc                       eiger_defconfig
xtensa                       common_defconfig
ia64                      gensparse_defconfig
ia64                             allyesconfig
powerpc                      cm5200_defconfig
sh                           se7619_defconfig
sh                        sh7763rdp_defconfig
arc                          axs103_defconfig
m68k                       m5208evb_defconfig
powerpc                     rainier_defconfig
arm                           h5000_defconfig
arm                         lpc18xx_defconfig
arm                          exynos_defconfig
mips                         tb0226_defconfig
sh                  sh7785lcr_32bit_defconfig
m68k                                defconfig
nds32                            alldefconfig
sh                           se7722_defconfig
mips                       capcella_defconfig
sh                        apsh4ad0a_defconfig
arc                           tb10x_defconfig
powerpc                  iss476-smp_defconfig
arc                                 defconfig
m68k                         apollo_defconfig
x86_64                           alldefconfig
arm                           tegra_defconfig
um                             i386_defconfig
arm                        realview_defconfig
arm                        cerfcube_defconfig
h8300                            alldefconfig
sh                               alldefconfig
mips                     decstation_defconfig
h8300                    h8300h-sim_defconfig
xtensa                generic_kc705_defconfig
sh                          polaris_defconfig
sh                            hp6xx_defconfig
xtensa                    xip_kc705_defconfig
arm                           viper_defconfig
powerpc                 mpc834x_mds_defconfig
arm                        multi_v7_defconfig
h8300                            allyesconfig
sh                          sdk7780_defconfig
m68k                          sun3x_defconfig
sparc                       sparc32_defconfig
powerpc64                           defconfig
arc                 nsimosci_hs_smp_defconfig
mips                            ar7_defconfig
powerpc                           allnoconfig
powerpc                mpc7448_hpc2_defconfig
sh                           se7724_defconfig
arm                     eseries_pxa_defconfig
powerpc                 mpc8540_ads_defconfig
powerpc                         wii_defconfig
powerpc                      ppc40x_defconfig
s390                          debug_defconfig
arm                       imx_v6_v7_defconfig
arm                  randconfig-c002-20220120
arm                  randconfig-c002-20220116
arm                  randconfig-c002-20220117
arm                  randconfig-c002-20220118
arm                  randconfig-c002-20220119
arm                  randconfig-c002-20220121
ia64                             allmodconfig
ia64                                defconfig
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
sh                               allmodconfig
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
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allmodconfig
powerpc                          allyesconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64               randconfig-a016-20220117
x86_64               randconfig-a012-20220117
x86_64               randconfig-a013-20220117
x86_64               randconfig-a011-20220117
x86_64               randconfig-a014-20220117
x86_64               randconfig-a015-20220117
riscv                randconfig-r042-20220119
s390                 randconfig-r044-20220119
arc                  randconfig-r043-20220119
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec

clang tested configs:
x86_64                        randconfig-c007
arm                  randconfig-c002-20220120
riscv                randconfig-c006-20220120
powerpc              randconfig-c003-20220120
mips                 randconfig-c004-20220120
i386                          randconfig-c001
arm                  randconfig-c002-20220121
riscv                randconfig-c006-20220121
powerpc              randconfig-c003-20220121
mips                 randconfig-c004-20220121
powerpc                      walnut_defconfig
powerpc                 mpc8313_rdb_defconfig
powerpc                 mpc832x_rdb_defconfig
mips                        bcm63xx_defconfig
powerpc               mpc834x_itxgp_defconfig
powerpc                     kmeter1_defconfig
powerpc                       ebony_defconfig
arm                        spear3xx_defconfig
powerpc                 mpc8272_ads_defconfig
x86_64               randconfig-a005-20220117
x86_64               randconfig-a004-20220117
x86_64               randconfig-a001-20220117
x86_64               randconfig-a006-20220117
x86_64               randconfig-a002-20220117
x86_64               randconfig-a003-20220117
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
i386                 randconfig-a005-20220117
i386                 randconfig-a001-20220117
i386                 randconfig-a006-20220117
i386                 randconfig-a004-20220117
i386                 randconfig-a002-20220117
i386                 randconfig-a003-20220117
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
riscv                randconfig-r042-20220120
hexagon              randconfig-r045-20220120
hexagon              randconfig-r041-20220120

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
