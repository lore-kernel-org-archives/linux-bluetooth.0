Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 736AEC43460
	for <linux-bluetooth@archiver.kernel.org>; Tue,  6 Apr 2021 21:23:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C589613B8
	for <linux-bluetooth@archiver.kernel.org>; Tue,  6 Apr 2021 21:23:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343690AbhDFVXW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 6 Apr 2021 17:23:22 -0400
Received: from mga12.intel.com ([192.55.52.136]:52124 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1343687AbhDFVXV (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 6 Apr 2021 17:23:21 -0400
IronPort-SDR: jbwHxpoBAPgtibW7TT4N3xPPFCfzOMj91vamSazH3ITy80dEZM8LJ0zVmF/BGxyUQJ1RI7H5zR
 rDxpzOzjuC+w==
X-IronPort-AV: E=McAfee;i="6000,8403,9946"; a="172634329"
X-IronPort-AV: E=Sophos;i="5.82,201,1613462400"; 
   d="scan'208";a="172634329"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2021 14:23:12 -0700
IronPort-SDR: z89tEUwRliG2915j9wxpZrZwUjMErYjG1d9jQQXqw6MkdICifYgDn9h2RMvh96Rw83MtHUUiyp
 50fhTtX4Mt6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,201,1613462400"; 
   d="scan'208";a="598093209"
Received: from lkp-server01.sh.intel.com (HELO 69d8fcc516b7) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 06 Apr 2021 14:23:11 -0700
Received: from kbuild by 69d8fcc516b7 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lTtAE-000CIu-9Q; Tue, 06 Apr 2021 21:23:10 +0000
Date:   Wed, 07 Apr 2021 05:22:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 8ce85ada0a05e21a5386ba5c417c52ab00fcd0d1
Message-ID: <606cd12f.IKn7i4bmULQPgf5i%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: 8ce85ada0a05e21a5386ba5c417c52ab00fcd0d1  Bluetooth: LL privacy allow RPA

elapsed time: 726m

configs tested: 216
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
x86_64                           allyesconfig
riscv                            allmodconfig
i386                             allyesconfig
riscv                            allyesconfig
sh                               alldefconfig
mips                     loongson1b_defconfig
mips                      pic32mzda_defconfig
mips                         mpc30x_defconfig
mips                         cobalt_defconfig
sh                          rsk7201_defconfig
arm                        clps711x_defconfig
sh                         microdev_defconfig
powerpc                      bamboo_defconfig
mips                      pistachio_defconfig
sh                           se7619_defconfig
powerpc                         ps3_defconfig
sh                        edosk7760_defconfig
arm                        realview_defconfig
arm                           omap1_defconfig
riscv             nommu_k210_sdcard_defconfig
mips                      fuloong2e_defconfig
arm                          badge4_defconfig
arm                  colibri_pxa270_defconfig
mips                      maltaaprp_defconfig
ia64                                defconfig
sparc                            alldefconfig
powerpc                    amigaone_defconfig
powerpc                        fsp2_defconfig
powerpc                      ppc6xx_defconfig
sh                        apsh4ad0a_defconfig
arm                         lpc32xx_defconfig
arm                      footbridge_defconfig
arm                          ep93xx_defconfig
powerpc                         wii_defconfig
h8300                            alldefconfig
m68k                        stmark2_defconfig
arc                        nsimosci_defconfig
arm                        shmobile_defconfig
mips                            ar7_defconfig
arm                           spitz_defconfig
m68k                            q40_defconfig
powerpc                    mvme5100_defconfig
mips                          ath25_defconfig
powerpc                     tqm8540_defconfig
sh                        sh7785lcr_defconfig
riscv                    nommu_virt_defconfig
arm                     am200epdkit_defconfig
xtensa                  audio_kc705_defconfig
arm                      integrator_defconfig
arm                           sunxi_defconfig
powerpc                  mpc885_ads_defconfig
mips                           ip28_defconfig
sh                          sdk7780_defconfig
m68k                        m5272c3_defconfig
mips                           mtx1_defconfig
arc                     nsimosci_hs_defconfig
powerpc                 mpc836x_mds_defconfig
nds32                             allnoconfig
powerpc                     asp8347_defconfig
microblaze                          defconfig
sh                          lboxre2_defconfig
arm                          pcm027_defconfig
m68k                           sun3_defconfig
sh                           se7751_defconfig
m68k                         apollo_defconfig
arm                         vf610m4_defconfig
arm                      tct_hammer_defconfig
csky                             alldefconfig
mips                           rs90_defconfig
m68k                       bvme6000_defconfig
sh                           se7780_defconfig
xtensa                generic_kc705_defconfig
arm                          exynos_defconfig
sh                           sh2007_defconfig
sh                        edosk7705_defconfig
xtensa                  nommu_kc705_defconfig
arm                            hisi_defconfig
ia64                      gensparse_defconfig
sh                     magicpanelr2_defconfig
arm                         shannon_defconfig
powerpc                     tqm5200_defconfig
arc                      axs103_smp_defconfig
sh                         apsh4a3a_defconfig
powerpc                    klondike_defconfig
mips                     cu1000-neo_defconfig
mips                          rb532_defconfig
m68k                       m5249evb_defconfig
mips                        omega2p_defconfig
arm                             rpc_defconfig
microblaze                      mmu_defconfig
powerpc                     kilauea_defconfig
arc                          axs101_defconfig
openrisc                  or1klitex_defconfig
arm                        spear6xx_defconfig
mips                    maltaup_xpa_defconfig
arm                      jornada720_defconfig
powerpc                     tqm8541_defconfig
sh                 kfr2r09-romimage_defconfig
arm64                            alldefconfig
h8300                    h8300h-sim_defconfig
mips                       lemote2f_defconfig
openrisc                    or1ksim_defconfig
mips                        bcm47xx_defconfig
mips                           ip32_defconfig
arm                          pxa168_defconfig
nios2                            allyesconfig
powerpc                   motionpro_defconfig
sh                   sh7770_generic_defconfig
arc                           tb10x_defconfig
mips                       bmips_be_defconfig
arm                         lpc18xx_defconfig
mips                  maltasmvp_eva_defconfig
powerpc                mpc7448_hpc2_defconfig
mips                      malta_kvm_defconfig
powerpc                     skiroot_defconfig
powerpc                     kmeter1_defconfig
m68k                       m5208evb_defconfig
m68k                        m5407c3_defconfig
arc                            hsdk_defconfig
powerpc                     pseries_defconfig
arm                       versatile_defconfig
mips                   sb1250_swarm_defconfig
arm                       aspeed_g5_defconfig
arm                           viper_defconfig
mips                 decstation_r4k_defconfig
powerpc                     akebono_defconfig
arc                 nsimosci_hs_smp_defconfig
parisc                generic-64bit_defconfig
arm                        trizeps4_defconfig
arm                    vt8500_v6_v7_defconfig
mips                           gcw0_defconfig
powerpc                 mpc8560_ads_defconfig
arm                            mmp2_defconfig
powerpc                     sequoia_defconfig
arm                           tegra_defconfig
arm                       imx_v4_v5_defconfig
arm                           corgi_defconfig
sh                          kfr2r09_defconfig
powerpc                      tqm8xx_defconfig
arm                       aspeed_g4_defconfig
sparc                       sparc32_defconfig
arm                     davinci_all_defconfig
arc                        vdk_hs38_defconfig
sh                          rsk7203_defconfig
sh                          sdk7786_defconfig
sparc                       sparc64_defconfig
ia64                             allmodconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                               defconfig
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
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a004-20210406
x86_64               randconfig-a003-20210406
x86_64               randconfig-a005-20210406
x86_64               randconfig-a001-20210406
x86_64               randconfig-a002-20210406
x86_64               randconfig-a006-20210406
i386                 randconfig-a006-20210406
i386                 randconfig-a003-20210406
i386                 randconfig-a001-20210406
i386                 randconfig-a004-20210406
i386                 randconfig-a005-20210406
i386                 randconfig-a002-20210406
i386                 randconfig-a014-20210406
i386                 randconfig-a016-20210406
i386                 randconfig-a011-20210406
i386                 randconfig-a012-20210406
i386                 randconfig-a015-20210406
i386                 randconfig-a013-20210406
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
um                               allmodconfig
um                                allnoconfig
um                               allyesconfig
um                                  defconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a014-20210406
x86_64               randconfig-a015-20210406
x86_64               randconfig-a013-20210406
x86_64               randconfig-a011-20210406
x86_64               randconfig-a012-20210406
x86_64               randconfig-a016-20210406

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
