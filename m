Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24DC4C433F5
	for <linux-bluetooth@archiver.kernel.org>; Sat, 29 Jan 2022 13:19:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350783AbiA2NTO (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 29 Jan 2022 08:19:14 -0500
Received: from mga18.intel.com ([134.134.136.126]:62477 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237017AbiA2NTK (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 29 Jan 2022 08:19:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643462350; x=1674998350;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=r6YQRHIXJCiFrCv2X4Vrj4PXZd3sn/rw4lskUCADlMw=;
  b=WQK5Iu89Es/sJjt48wVJ+XpoYM5nizioNupRJW9UlYwHin80v5/O8wvH
   ahidLugeZYydpRfFNTcA8+73OniuORB5UZIoXRQkid3vtCFjGrPPABeDU
   Rm6Z3JPPDIMTS+NdPPAnwn/NiEGf7g3++AqXsBJ1/Ltgfn/I/4+ZdrhiK
   vkRkXDSI6ZLL84LPYZtJVf+089S+aZ0eGT9c+W6q8QqA0yt0+W6fsJ/Yj
   dP1rVCqliGa+Bm4cXMJDAguy8PIQopRmdjHDESunwRmYE/YBxV8nlNdD6
   7dM1A6+er436R5hab6GQZetRYH8za2OyYG+7c2PGBoggSIoe7KtoFOv3q
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10241"; a="230843970"
X-IronPort-AV: E=Sophos;i="5.88,326,1635231600"; 
   d="scan'208";a="230843970"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2022 05:19:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,326,1635231600"; 
   d="scan'208";a="582152233"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 29 Jan 2022 05:19:08 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nDndD-000PFC-EK; Sat, 29 Jan 2022 13:19:07 +0000
Date:   Sat, 29 Jan 2022 21:18:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 0a78117213c4bb85dfebf89b924226883597bc60
Message-ID: <61f53ea4.Ask8AnLFbAz5o6QH%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: 0a78117213c4bb85dfebf89b924226883597bc60  Merge tag 'for-net-next-2022-01-28' of git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next

elapsed time: 761m

configs tested: 201
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20220124
powerpc              randconfig-c003-20220124
arm                           stm32_defconfig
m68k                            mac_defconfig
sh                          lboxre2_defconfig
sh                           se7705_defconfig
m68k                        mvme16x_defconfig
sh                             sh03_defconfig
arc                 nsimosci_hs_smp_defconfig
mips                          rb532_defconfig
ia64                            zx1_defconfig
powerpc64                        alldefconfig
ia64                        generic_defconfig
arm64                            alldefconfig
mips                        jmr3927_defconfig
sh                           se7780_defconfig
sh                        edosk7760_defconfig
sh                             espt_defconfig
um                                  defconfig
arm                         axm55xx_defconfig
powerpc                      pcm030_defconfig
sparc                               defconfig
xtensa                           alldefconfig
arm                          pxa3xx_defconfig
m68k                                defconfig
arm                       aspeed_g5_defconfig
arm                         vf610m4_defconfig
arm                           tegra_defconfig
h8300                               defconfig
arm                         cm_x300_defconfig
sh                           se7751_defconfig
powerpc                      ppc6xx_defconfig
arc                           tb10x_defconfig
mips                           xway_defconfig
mips                 decstation_r4k_defconfig
m68k                          multi_defconfig
powerpc                      ep88xc_defconfig
powerpc                     ep8248e_defconfig
m68k                        stmark2_defconfig
powerpc                 mpc834x_itx_defconfig
arm                        shmobile_defconfig
mips                     decstation_defconfig
arm                         lubbock_defconfig
arm                          iop32x_defconfig
arm                           corgi_defconfig
arm                            hisi_defconfig
sh                             shx3_defconfig
mips                         rt305x_defconfig
arm                            pleb_defconfig
powerpc                       ppc64_defconfig
arm                          pxa910_defconfig
powerpc                 mpc837x_rdb_defconfig
openrisc                         alldefconfig
powerpc                     sequoia_defconfig
m68k                           sun3_defconfig
powerpc                 mpc834x_mds_defconfig
powerpc                     rainier_defconfig
arm                          badge4_defconfig
xtensa                    smp_lx200_defconfig
arm                        mini2440_defconfig
sh                           se7343_defconfig
sh                          polaris_defconfig
sh                           se7712_defconfig
xtensa                  audio_kc705_defconfig
mips                        vocore2_defconfig
sh                   secureedge5410_defconfig
mips                        bcm47xx_defconfig
arm                          lpd270_defconfig
ia64                             allmodconfig
mips                            ar7_defconfig
powerpc                     mpc83xx_defconfig
mips                           ip32_defconfig
powerpc                     asp8347_defconfig
sh                        sh7763rdp_defconfig
microblaze                      mmu_defconfig
arm                        multi_v7_defconfig
arm                  randconfig-c002-20220127
arm                  randconfig-c002-20220124
arm                  randconfig-c002-20220129
ia64                                defconfig
ia64                             allyesconfig
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
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a002-20220124
x86_64               randconfig-a003-20220124
x86_64               randconfig-a001-20220124
x86_64               randconfig-a004-20220124
x86_64               randconfig-a005-20220124
x86_64               randconfig-a006-20220124
i386                 randconfig-a002-20220124
i386                 randconfig-a005-20220124
i386                 randconfig-a003-20220124
i386                 randconfig-a004-20220124
i386                 randconfig-a001-20220124
i386                 randconfig-a006-20220124
riscv                randconfig-r042-20220125
arc                  randconfig-r043-20220127
arc                  randconfig-r043-20220125
arc                  randconfig-r043-20220124
s390                 randconfig-r044-20220127
s390                 randconfig-r044-20220125
riscv                randconfig-r042-20220127
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
riscv                randconfig-c006-20220129
arm                  randconfig-c002-20220129
powerpc              randconfig-c003-20220129
mips                 randconfig-c004-20220129
i386                          randconfig-c001
arm                  randconfig-c002-20220124
riscv                randconfig-c006-20220124
i386                 randconfig-c001-20220124
powerpc              randconfig-c003-20220124
mips                 randconfig-c004-20220124
x86_64               randconfig-c007-20220124
arm                    vt8500_v6_v7_defconfig
arm                         socfpga_defconfig
mips                          malta_defconfig
arm                        vexpress_defconfig
arm                         orion5x_defconfig
powerpc                      ppc44x_defconfig
powerpc                      obs600_defconfig
arm                        mvebu_v5_defconfig
powerpc                     mpc5200_defconfig
arm                         s3c2410_defconfig
powerpc                     ksi8560_defconfig
powerpc                     akebono_defconfig
riscv                             allnoconfig
hexagon                             defconfig
powerpc                      katmai_defconfig
mips                        bcm63xx_defconfig
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64               randconfig-a011-20220124
x86_64               randconfig-a013-20220124
x86_64               randconfig-a015-20220124
x86_64               randconfig-a016-20220124
x86_64               randconfig-a014-20220124
x86_64               randconfig-a012-20220124
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                 randconfig-a011-20220124
i386                 randconfig-a016-20220124
i386                 randconfig-a013-20220124
i386                 randconfig-a014-20220124
i386                 randconfig-a015-20220124
i386                 randconfig-a012-20220124
riscv                randconfig-r042-20220124
hexagon              randconfig-r045-20220124
hexagon              randconfig-r045-20220127
hexagon              randconfig-r041-20220124
hexagon              randconfig-r041-20220127
riscv                randconfig-r042-20220126
hexagon              randconfig-r045-20220126
hexagon              randconfig-r041-20220126
s390                 randconfig-r044-20220124
hexagon              randconfig-r045-20220125
hexagon              randconfig-r041-20220125

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
