Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CFC5C47096
	for <linux-bluetooth@archiver.kernel.org>; Fri,  4 Jun 2021 02:28:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64DB06140B
	for <linux-bluetooth@archiver.kernel.org>; Fri,  4 Jun 2021 02:28:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbhFDCa2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 3 Jun 2021 22:30:28 -0400
Received: from mga12.intel.com ([192.55.52.136]:18196 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229576AbhFDCa1 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 3 Jun 2021 22:30:27 -0400
IronPort-SDR: 7iqgzcYa/mkLQkS6g/eHX6gtRpkB+gt+8ctbx5jyG87H3TSUqqUqhGRBhZXJg2MlKPUgOWmI4o
 HPGUxo/v8Cbw==
X-IronPort-AV: E=McAfee;i="6200,9189,10004"; a="183890280"
X-IronPort-AV: E=Sophos;i="5.83,246,1616482800"; 
   d="scan'208";a="183890280"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2021 19:28:39 -0700
IronPort-SDR: 8Tkyly0ENbdgptwi67PBMCos4ZGhjjnpG97vuuPJakpJPfum3Q6tWTAOFjJdu0PQMQym4Yhtnz
 7LWGraPS6AWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,246,1616482800"; 
   d="scan'208";a="483724613"
Received: from lkp-server02.sh.intel.com (HELO 1ec8406c5392) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 03 Jun 2021 19:28:37 -0700
Received: from kbuild by 1ec8406c5392 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lozZd-0006ak-7O; Fri, 04 Jun 2021 02:28:37 +0000
Date:   Fri, 04 Jun 2021 10:28:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 e62473c516b6bf2a9adb2bb37bdab1ae0f4a0511
Message-ID: <60b98fc7.fOmoUJlr6krXIMzq%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: e62473c516b6bf2a9adb2bb37bdab1ae0f4a0511  Bluetooth: smp: Use the correct print format

elapsed time: 721m

configs tested: 185
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                         socfpga_defconfig
arm                            qcom_defconfig
sh                          sdk7786_defconfig
mips                       rbtx49xx_defconfig
mips                        vocore2_defconfig
mips                           ip27_defconfig
powerpc                      pasemi_defconfig
m68k                       m5249evb_defconfig
arm                         lpc32xx_defconfig
nios2                            alldefconfig
arm                      tct_hammer_defconfig
powerpc                      cm5200_defconfig
mips                       capcella_defconfig
ia64                      gensparse_defconfig
sh                            hp6xx_defconfig
sh                         ap325rxa_defconfig
powerpc                 xes_mpc85xx_defconfig
sh                         apsh4a3a_defconfig
arc                         haps_hs_defconfig
arm                         mv78xx0_defconfig
sh                         ecovec24_defconfig
arc                                 defconfig
powerpc                    amigaone_defconfig
arc                 nsimosci_hs_smp_defconfig
sh                   sh7770_generic_defconfig
m68k                       m5275evb_defconfig
powerpc                 mpc836x_mds_defconfig
m68k                        m5407c3_defconfig
m68k                        mvme16x_defconfig
arc                    vdk_hs38_smp_defconfig
powerpc                      katmai_defconfig
mips                         mpc30x_defconfig
powerpc                      acadia_defconfig
powerpc64                        alldefconfig
arm                          collie_defconfig
arc                     nsimosci_hs_defconfig
m68k                             alldefconfig
arm                         lpc18xx_defconfig
arc                      axs103_smp_defconfig
sh                        dreamcast_defconfig
arm                         s3c6400_defconfig
sparc                       sparc32_defconfig
powerpc                     tqm8540_defconfig
mips                           rs90_defconfig
m68k                         amcore_defconfig
arm                        cerfcube_defconfig
powerpc                 canyonlands_defconfig
powerpc                 mpc832x_rdb_defconfig
powerpc                        warp_defconfig
arm                        neponset_defconfig
nios2                         3c120_defconfig
powerpc                      pcm030_defconfig
powerpc                   lite5200b_defconfig
arm                           u8500_defconfig
um                                  defconfig
nds32                             allnoconfig
powerpc                      walnut_defconfig
mips                      pic32mzda_defconfig
mips                           jazz_defconfig
mips                malta_qemu_32r6_defconfig
powerpc                      tqm8xx_defconfig
sh                          urquell_defconfig
arm                  colibri_pxa270_defconfig
um                            kunit_defconfig
mips                       bmips_be_defconfig
powerpc                     mpc83xx_defconfig
mips                  decstation_64_defconfig
xtensa                    xip_kc705_defconfig
powerpc                 mpc8560_ads_defconfig
arm                           sunxi_defconfig
mips                           mtx1_defconfig
sh                           se7712_defconfig
powerpc                     rainier_defconfig
arm                         orion5x_defconfig
powerpc                     mpc5200_defconfig
powerpc                 mpc834x_itx_defconfig
arm                           stm32_defconfig
powerpc                 mpc85xx_cds_defconfig
mips                  cavium_octeon_defconfig
powerpc                  storcenter_defconfig
arm                         palmz72_defconfig
mips                          rb532_defconfig
powerpc                    sam440ep_defconfig
arm                         s5pv210_defconfig
sh                          lboxre2_defconfig
mips                         tb0219_defconfig
mips                     loongson2k_defconfig
arc                              alldefconfig
mips                      pistachio_defconfig
sh                        sh7757lcr_defconfig
arm                      pxa255-idp_defconfig
arm                           spitz_defconfig
arm                        vexpress_defconfig
arm                           viper_defconfig
sh                   rts7751r2dplus_defconfig
arm                          simpad_defconfig
riscv                            allyesconfig
arm                          exynos_defconfig
arm                           tegra_defconfig
sh                  sh7785lcr_32bit_defconfig
powerpc                      bamboo_defconfig
powerpc                       ppc64_defconfig
arc                        nsimosci_defconfig
ia64                                defconfig
x86_64                              defconfig
powerpc                     skiroot_defconfig
mips                 decstation_r4k_defconfig
powerpc                         ps3_defconfig
sh                           se7206_defconfig
powerpc                    gamecube_defconfig
mips                      maltasmvp_defconfig
m68k                        stmark2_defconfig
x86_64                            allnoconfig
ia64                             allmodconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
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
i386                 randconfig-a003-20210603
i386                 randconfig-a006-20210603
i386                 randconfig-a004-20210603
i386                 randconfig-a001-20210603
i386                 randconfig-a002-20210603
i386                 randconfig-a005-20210603
x86_64               randconfig-a015-20210603
x86_64               randconfig-a011-20210603
x86_64               randconfig-a012-20210603
x86_64               randconfig-a014-20210603
x86_64               randconfig-a016-20210603
x86_64               randconfig-a013-20210603
i386                 randconfig-a015-20210603
i386                 randconfig-a013-20210603
i386                 randconfig-a011-20210603
i386                 randconfig-a016-20210603
i386                 randconfig-a014-20210603
i386                 randconfig-a012-20210603
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-b001-20210603
x86_64               randconfig-a002-20210603
x86_64               randconfig-a004-20210603
x86_64               randconfig-a003-20210603
x86_64               randconfig-a006-20210603
x86_64               randconfig-a005-20210603
x86_64               randconfig-a001-20210603

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
