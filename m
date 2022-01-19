Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 640A5C433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 Jan 2022 08:20:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352287AbiASIU3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 19 Jan 2022 03:20:29 -0500
Received: from mga12.intel.com ([192.55.52.136]:56693 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1352271AbiASIUY (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 19 Jan 2022 03:20:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642580424; x=1674116424;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=WSmIZ4d8n2THOykZZ97EIk1Jn7daXEsaauWd2acgnsc=;
  b=kuH1SOhhm2Xf6WvuylsU5tjaeq84GSFfGSW263nn4pY7kFajj4HX1qNG
   vE5YtI0PvjPEbQgajkCoJm8wRA4hhJ6OGkFw/RCWQJFogW0pmqhy6F5mn
   0Gvm9eoIxVej8dVb9CLPqrDHeaX2FFwOM1pQdvzGfd532N1W7zv333dnx
   CfzGY2KPxLxi7XMcODU3xa5e26UvJKBsOWD1S/K7gDClEDiyumIMyesgv
   MHIcCFNaohmTHwFV39HEaMIhiUQE89vncwcKl/69oIIWzvprzQtx3nnuC
   bPTZplgJmtigf1Xk0u+DyiBxhIwP4fBRLJs8gz8axjcJCwGYXI6Ib90lX
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10231"; a="224992028"
X-IronPort-AV: E=Sophos;i="5.88,299,1635231600"; 
   d="scan'208";a="224992028"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2022 00:20:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,299,1635231600"; 
   d="scan'208";a="615628882"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 19 Jan 2022 00:20:22 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nA6Cb-000DP5-W2; Wed, 19 Jan 2022 08:20:21 +0000
Date:   Wed, 19 Jan 2022 16:19:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc:     linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 4fd8a97fcea493c0a65b5ff52a8042e7e22486a3
Message-ID: <61e7c988.dYvR6x923WWEJ0Oc%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: 4fd8a97fcea493c0a65b5ff52a8042e7e22486a3  bluetooth: mgmt: Add MGMT Adv Monitor Device Found/Lost events

elapsed time: 724m

configs tested: 153
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20220117
mips                 randconfig-c004-20220117
powerpc              randconfig-c003-20220118
powerpc              randconfig-c003-20220117
i386                          randconfig-c001
mips                         db1xxx_defconfig
arm64                            alldefconfig
sh                        dreamcast_defconfig
m68k                          atari_defconfig
sh                            shmin_defconfig
mips                  decstation_64_defconfig
sh                          sdk7786_defconfig
arm                      footbridge_defconfig
csky                                defconfig
powerpc                  iss476-smp_defconfig
mips                        bcm47xx_defconfig
h8300                    h8300h-sim_defconfig
sh                          rsk7201_defconfig
arm                       omap2plus_defconfig
arm                         axm55xx_defconfig
arc                        vdk_hs38_defconfig
sh                     sh7710voipgw_defconfig
arm                        multi_v7_defconfig
mips                       bmips_be_defconfig
sh                     magicpanelr2_defconfig
openrisc                            defconfig
sh                   sh7770_generic_defconfig
arc                           tb10x_defconfig
arm                        oxnas_v6_defconfig
m68k                          hp300_defconfig
powerpc                      chrp32_defconfig
xtensa                         virt_defconfig
powerpc                        cell_defconfig
sh                      rts7751r2d1_defconfig
arm                         vf610m4_defconfig
alpha                            allyesconfig
nios2                         3c120_defconfig
powerpc                     rainier_defconfig
powerpc                       ppc64_defconfig
sh                           se7721_defconfig
arm                       imx_v6_v7_defconfig
arm                           tegra_defconfig
xtensa                    smp_lx200_defconfig
powerpc                           allnoconfig
arm                  randconfig-c002-20220116
arm                  randconfig-c002-20220117
arm                  randconfig-c002-20220118
arm                  randconfig-c002-20220119
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
nds32                               defconfig
nios2                            allyesconfig
alpha                               defconfig
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
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
x86_64               randconfig-a016-20220117
x86_64               randconfig-a012-20220117
x86_64               randconfig-a013-20220117
x86_64               randconfig-a011-20220117
x86_64               randconfig-a014-20220117
x86_64               randconfig-a015-20220117
i386                 randconfig-a012-20220117
i386                 randconfig-a016-20220117
i386                 randconfig-a014-20220117
i386                 randconfig-a015-20220117
i386                 randconfig-a011-20220117
i386                 randconfig-a013-20220117
riscv                randconfig-r042-20220119
riscv                randconfig-r042-20220117
arc                  randconfig-r043-20220116
arc                  randconfig-r043-20220117
s390                 randconfig-r044-20220119
s390                 randconfig-r044-20220117
arc                  randconfig-r043-20220118
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
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec

clang tested configs:
arm                  randconfig-c002-20220116
x86_64                        randconfig-c007
arm                  randconfig-c002-20220118
riscv                randconfig-c006-20220118
riscv                randconfig-c006-20220116
powerpc              randconfig-c003-20220116
powerpc              randconfig-c003-20220118
i386                          randconfig-c001
mips                 randconfig-c004-20220116
s390                 randconfig-c005-20220116
arm                  randconfig-c002-20220119
riscv                randconfig-c006-20220119
powerpc              randconfig-c003-20220119
s390                 randconfig-c005-20220119
mips                 randconfig-c004-20220119
arm                                 defconfig
riscv                            alldefconfig
arm                            mmp2_defconfig
arm                       imx_v4_v5_defconfig
powerpc                     kilauea_defconfig
i386                             allyesconfig
powerpc               mpc834x_itxgp_defconfig
mips                      pic32mzda_defconfig
mips                        omega2p_defconfig
mips                        bcm63xx_defconfig
powerpc                      ppc64e_defconfig
x86_64               randconfig-a005-20220117
x86_64               randconfig-a004-20220117
x86_64               randconfig-a001-20220117
x86_64               randconfig-a006-20220117
x86_64               randconfig-a002-20220117
x86_64               randconfig-a003-20220117
i386                 randconfig-a005-20220117
i386                 randconfig-a001-20220117
i386                 randconfig-a006-20220117
i386                 randconfig-a004-20220117
i386                 randconfig-a002-20220117
i386                 randconfig-a003-20220117
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
