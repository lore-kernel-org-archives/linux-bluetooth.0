Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D90ACC433EF
	for <linux-bluetooth@archiver.kernel.org>; Sat,  4 Sep 2021 12:16:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B670060231
	for <linux-bluetooth@archiver.kernel.org>; Sat,  4 Sep 2021 12:16:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236418AbhIDMRG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 4 Sep 2021 08:17:06 -0400
Received: from mga05.intel.com ([192.55.52.43]:44170 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236349AbhIDMRF (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 4 Sep 2021 08:17:05 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10096"; a="305193339"
X-IronPort-AV: E=Sophos;i="5.85,268,1624345200"; 
   d="scan'208";a="305193339"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2021 05:16:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,268,1624345200"; 
   d="scan'208";a="692829539"
Received: from lkp-server01.sh.intel.com (HELO 2115029a3e5c) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 04 Sep 2021 05:16:01 -0700
Received: from kbuild by 2115029a3e5c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mMUaX-0001UN-8b; Sat, 04 Sep 2021 12:16:01 +0000
Date:   Sat, 04 Sep 2021 20:15:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc:     linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 49d8a5606428ca0962d09050a5af81461ff90fbb
Message-ID: <6133636f.i1HJf5hYN9V3YWer%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: 49d8a5606428ca0962d09050a5af81461ff90fbb  Bluetooth: fix init and cleanup of sco_conn.timeout_work

elapsed time: 727m

configs tested: 141
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20210904
um                               alldefconfig
powerpc                     kilauea_defconfig
sh                           se7343_defconfig
mips                        workpad_defconfig
powerpc                      pasemi_defconfig
sh                   sh7770_generic_defconfig
powerpc                mpc7448_hpc2_defconfig
arm                         socfpga_defconfig
arm                        spear6xx_defconfig
powerpc                 mpc8560_ads_defconfig
m68k                         amcore_defconfig
sparc                       sparc64_defconfig
sh                           se7206_defconfig
mips                       capcella_defconfig
microblaze                      mmu_defconfig
arm                          collie_defconfig
powerpc                 mpc836x_mds_defconfig
arc                     haps_hs_smp_defconfig
powerpc                    klondike_defconfig
powerpc                     tqm8548_defconfig
powerpc                        cell_defconfig
h8300                     edosk2674_defconfig
s390                             allmodconfig
powerpc                     mpc83xx_defconfig
mips                           gcw0_defconfig
riscv                               defconfig
xtensa                       common_defconfig
powerpc                     tqm8540_defconfig
sh                          urquell_defconfig
xtensa                  nommu_kc705_defconfig
mips                         rt305x_defconfig
mips                        maltaup_defconfig
arm                         s5pv210_defconfig
arm                           viper_defconfig
powerpc                  mpc866_ads_defconfig
powerpc                 mpc8313_rdb_defconfig
arm                      pxa255-idp_defconfig
ia64                         bigsur_defconfig
nds32                            alldefconfig
powerpc                          g5_defconfig
arm                         lubbock_defconfig
h8300                    h8300h-sim_defconfig
openrisc                 simple_smp_defconfig
arm                    vt8500_v6_v7_defconfig
arm                            lart_defconfig
sh                         ecovec24_defconfig
sh                   rts7751r2dplus_defconfig
powerpc                      makalu_defconfig
powerpc                     akebono_defconfig
sh                         microdev_defconfig
mips                      maltaaprp_defconfig
powerpc                 mpc85xx_cds_defconfig
sh                          rsk7264_defconfig
powerpc                     tqm5200_defconfig
mips                    maltaup_xpa_defconfig
arm                  randconfig-c002-20210904
x86_64                            allnoconfig
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
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
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
x86_64               randconfig-a006-20210904
x86_64               randconfig-a004-20210904
x86_64               randconfig-a003-20210904
x86_64               randconfig-a005-20210904
x86_64               randconfig-a001-20210904
x86_64               randconfig-a002-20210904
i386                 randconfig-a005-20210904
i386                 randconfig-a004-20210904
i386                 randconfig-a006-20210904
i386                 randconfig-a002-20210904
i386                 randconfig-a003-20210904
i386                 randconfig-a001-20210904
arc                  randconfig-r043-20210904
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
s390                 randconfig-c005-20210904
mips                 randconfig-c004-20210904
powerpc              randconfig-c003-20210904
x86_64               randconfig-c007-20210904
i386                 randconfig-c001-20210904
arm                  randconfig-c002-20210904
riscv                randconfig-c006-20210904
x86_64               randconfig-a011-20210904
x86_64               randconfig-a016-20210904
x86_64               randconfig-a012-20210904
x86_64               randconfig-a015-20210904
x86_64               randconfig-a014-20210904
x86_64               randconfig-a013-20210904
i386                 randconfig-a012-20210904
i386                 randconfig-a015-20210904
i386                 randconfig-a011-20210904
i386                 randconfig-a013-20210904
i386                 randconfig-a014-20210904
i386                 randconfig-a016-20210904
riscv                randconfig-r042-20210904
hexagon              randconfig-r045-20210904
s390                 randconfig-r044-20210904
hexagon              randconfig-r041-20210904

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
