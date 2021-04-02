Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9767EC43460
	for <linux-bluetooth@archiver.kernel.org>; Fri,  2 Apr 2021 21:22:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6BC1F610E8
	for <linux-bluetooth@archiver.kernel.org>; Fri,  2 Apr 2021 21:22:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235559AbhDBVWm (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 2 Apr 2021 17:22:42 -0400
Received: from mga12.intel.com ([192.55.52.136]:59792 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235523AbhDBVWl (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 2 Apr 2021 17:22:41 -0400
IronPort-SDR: is2S+q8jRQDPtNiAwWEJs6hxff8+dQ2Q7LHPnRFxsbp8FFJGv9Ic3+1EyuKMEx5AmTOaOsABI2
 4kQuSOjA0YaQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9942"; a="171957202"
X-IronPort-AV: E=Sophos;i="5.81,300,1610438400"; 
   d="scan'208";a="171957202"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2021 14:22:40 -0700
IronPort-SDR: tWJj9kjSsh49Vlj9/KBtjCqX5fPzfrUaqm1m8kYILPOMla3GSfyVSqGLK/VyKX7nDezhwMA2N1
 GbnFQxNab25w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,300,1610438400"; 
   d="scan'208";a="379809517"
Received: from lkp-server01.sh.intel.com (HELO 69d8fcc516b7) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 02 Apr 2021 14:22:38 -0700
Received: from kbuild by 69d8fcc516b7 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lSRFW-0007M1-3z; Fri, 02 Apr 2021 21:22:38 +0000
Date:   Sat, 03 Apr 2021 05:22:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 27e554a4fcd84e499bf0a82122b8c4c3f1de38b6
Message-ID: <60678b0d.TuC6jhbZjCpWVYau%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: 27e554a4fcd84e499bf0a82122b8c4c3f1de38b6  Bluetooth: btusb: Enable quirk boolean flag for Mediatek Chip.

elapsed time: 723m

configs tested: 231
configs skipped: 2

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
sh                          rsk7203_defconfig
arc                    vdk_hs38_smp_defconfig
mips                       rbtx49xx_defconfig
arm                           h5000_defconfig
powerpc                     powernv_defconfig
mips                      malta_kvm_defconfig
m68k                        mvme16x_defconfig
powerpc                      ppc40x_defconfig
mips                         tb0226_defconfig
xtensa                generic_kc705_defconfig
sh                            titan_defconfig
arm                      footbridge_defconfig
arm                             ezx_defconfig
arm                        trizeps4_defconfig
alpha                            alldefconfig
arm                           sama5_defconfig
sh                         apsh4a3a_defconfig
arm                           omap1_defconfig
mips                          rm200_defconfig
parisc                generic-64bit_defconfig
powerpc                     mpc83xx_defconfig
ia64                      gensparse_defconfig
powerpc                   bluestone_defconfig
sh                          rsk7264_defconfig
powerpc                      ppc64e_defconfig
powerpc                     tqm8548_defconfig
sh                           se7619_defconfig
mips                      fuloong2e_defconfig
powerpc                     sequoia_defconfig
arm                          ixp4xx_defconfig
arm                          pxa910_defconfig
arm                          lpd270_defconfig
powerpc                      tqm8xx_defconfig
arm                         hackkit_defconfig
arm                        mvebu_v5_defconfig
mips                          rb532_defconfig
m68k                            mac_defconfig
mips                     cu1830-neo_defconfig
mips                     cu1000-neo_defconfig
mips                             allmodconfig
mips                      pistachio_defconfig
riscv                          rv32_defconfig
powerpc                 mpc836x_mds_defconfig
powerpc                     redwood_defconfig
parisc                generic-32bit_defconfig
mips                            gpr_defconfig
powerpc                     tqm8540_defconfig
sh                     magicpanelr2_defconfig
sh                             sh03_defconfig
powerpc                          g5_defconfig
powerpc                      katmai_defconfig
arm                        mini2440_defconfig
sh                            migor_defconfig
powerpc                     akebono_defconfig
powerpc                     ppa8548_defconfig
s390                                defconfig
powerpc                      makalu_defconfig
openrisc                    or1ksim_defconfig
arm                     eseries_pxa_defconfig
m68k                            q40_defconfig
um                           x86_64_defconfig
powerpc                      acadia_defconfig
arm                             pxa_defconfig
mips                        workpad_defconfig
nios2                         10m50_defconfig
arm                          iop32x_defconfig
ia64                             alldefconfig
powerpc                      ep88xc_defconfig
arm                        neponset_defconfig
arm                          pxa168_defconfig
mips                 decstation_r4k_defconfig
sh                          lboxre2_defconfig
m68k                          hp300_defconfig
powerpc                 mpc8540_ads_defconfig
arc                        nsim_700_defconfig
arm                         lpc32xx_defconfig
powerpc                     tqm8560_defconfig
mips                           ip27_defconfig
m68k                       bvme6000_defconfig
arm                        cerfcube_defconfig
m68k                           sun3_defconfig
powerpc                     ksi8560_defconfig
powerpc                     tqm5200_defconfig
m68k                        mvme147_defconfig
sh                           sh2007_defconfig
mips                   sb1250_swarm_defconfig
arm                        shmobile_defconfig
m68k                         apollo_defconfig
xtensa                          iss_defconfig
sh                          rsk7201_defconfig
arm                     am200epdkit_defconfig
h8300                    h8300h-sim_defconfig
arm                        oxnas_v6_defconfig
powerpc                    amigaone_defconfig
sh                           se7724_defconfig
powerpc                         wii_defconfig
arm                       multi_v4t_defconfig
sh                        sh7785lcr_defconfig
mips                        qi_lb60_defconfig
arm                           tegra_defconfig
mips                  cavium_octeon_defconfig
mips                     loongson1c_defconfig
arm                         palmz72_defconfig
sh                     sh7710voipgw_defconfig
mips                        vocore2_defconfig
powerpc                 mpc8315_rdb_defconfig
sh                 kfr2r09-romimage_defconfig
arm                             rpc_defconfig
sparc64                             defconfig
powerpc                 mpc834x_mds_defconfig
mips                          malta_defconfig
powerpc                       eiger_defconfig
ia64                         bigsur_defconfig
xtensa                       common_defconfig
mips                           gcw0_defconfig
mips                        omega2p_defconfig
sh                           se7780_defconfig
arc                 nsimosci_hs_smp_defconfig
sh                ecovec24-romimage_defconfig
powerpc                   lite5200b_defconfig
arm                         s5pv210_defconfig
arm                          imote2_defconfig
m68k                             alldefconfig
sh                          r7780mp_defconfig
powerpc                           allnoconfig
mips                         tb0219_defconfig
mips                malta_qemu_32r6_defconfig
arm                           corgi_defconfig
m68k                       m5208evb_defconfig
mips                       capcella_defconfig
arm                          exynos_defconfig
powerpc                 mpc837x_rdb_defconfig
mips                           ci20_defconfig
powerpc                  iss476-smp_defconfig
sh                           se7750_defconfig
riscv                    nommu_k210_defconfig
arm                         lpc18xx_defconfig
arm                          moxart_defconfig
s390                             allyesconfig
sh                          urquell_defconfig
sh                           se7712_defconfig
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
s390                             allmodconfig
parisc                           allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
x86_64               randconfig-a004-20210402
x86_64               randconfig-a005-20210402
x86_64               randconfig-a003-20210402
x86_64               randconfig-a001-20210402
x86_64               randconfig-a002-20210402
x86_64               randconfig-a006-20210402
i386                 randconfig-a006-20210402
i386                 randconfig-a003-20210402
i386                 randconfig-a001-20210402
i386                 randconfig-a004-20210402
i386                 randconfig-a005-20210402
i386                 randconfig-a002-20210402
i386                 randconfig-a006-20210401
i386                 randconfig-a003-20210401
i386                 randconfig-a001-20210401
i386                 randconfig-a004-20210401
i386                 randconfig-a002-20210401
i386                 randconfig-a005-20210401
i386                 randconfig-a014-20210402
i386                 randconfig-a016-20210402
i386                 randconfig-a011-20210402
i386                 randconfig-a012-20210402
i386                 randconfig-a013-20210402
i386                 randconfig-a015-20210402
i386                 randconfig-a014-20210401
i386                 randconfig-a011-20210401
i386                 randconfig-a016-20210401
i386                 randconfig-a012-20210401
i386                 randconfig-a013-20210401
i386                 randconfig-a015-20210401
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
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
x86_64               randconfig-a004-20210401
x86_64               randconfig-a005-20210401
x86_64               randconfig-a003-20210401
x86_64               randconfig-a001-20210401
x86_64               randconfig-a002-20210401
x86_64               randconfig-a006-20210401
x86_64               randconfig-a014-20210402
x86_64               randconfig-a015-20210402
x86_64               randconfig-a011-20210402
x86_64               randconfig-a013-20210402
x86_64               randconfig-a012-20210402
x86_64               randconfig-a016-20210402

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
