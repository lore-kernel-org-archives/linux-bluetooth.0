Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 311C8C433B4
	for <linux-bluetooth@archiver.kernel.org>; Tue, 13 Apr 2021 04:32:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10153613AF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 13 Apr 2021 04:32:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbhDMEdE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 13 Apr 2021 00:33:04 -0400
Received: from mga01.intel.com ([192.55.52.88]:38442 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229946AbhDMEdE (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 13 Apr 2021 00:33:04 -0400
IronPort-SDR: iP9AWVAXeDGHtPCbtJlenLZrSiAXm6wYXBL6VW0ItB+LMB5OqjNYQdgMFNgoVErDTy7ZuNbBML
 +y+FpJNaW8TQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9952"; a="214807951"
X-IronPort-AV: E=Sophos;i="5.82,218,1613462400"; 
   d="scan'208";a="214807951"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2021 21:32:44 -0700
IronPort-SDR: 7Ciyf44ACZShVjk411/cca/9fqDV74IVxJB6AHTbZ1EWJAu/zDTyPfrF6yGHGbXk87Na2Q53X+
 0y9gMapERTlw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,218,1613462400"; 
   d="scan'208";a="417697457"
Received: from lkp-server01.sh.intel.com (HELO 69d8fcc516b7) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 12 Apr 2021 21:32:42 -0700
Received: from kbuild by 69d8fcc516b7 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lWAjB-0000oz-TC; Tue, 13 Apr 2021 04:32:41 +0000
Date:   Tue, 13 Apr 2021 12:32:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 13e66a52f780fd5523c5b27fda9c00c570f1b11e
Message-ID: <60751ed6.wUe0ERZTOQ892HJf%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: 13e66a52f780fd5523c5b27fda9c00c570f1b11e  Bluetooth: btusb: Add support for Lite-On Mediatek Chip

elapsed time: 721m

configs tested: 165
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
nios2                            allyesconfig
sh                         microdev_defconfig
sh                             espt_defconfig
riscv             nommu_k210_sdcard_defconfig
mips                           ip32_defconfig
arm                        oxnas_v6_defconfig
h8300                       h8s-sim_defconfig
arc                      axs103_smp_defconfig
powerpc                    socrates_defconfig
powerpc                   lite5200b_defconfig
riscv                             allnoconfig
mips                         cobalt_defconfig
mips                         tb0219_defconfig
mips                           mtx1_defconfig
m68k                       m5249evb_defconfig
mips                          malta_defconfig
arm                          pxa168_defconfig
arc                          axs103_defconfig
openrisc                         alldefconfig
mips                          rm200_defconfig
powerpc                     skiroot_defconfig
arm                            mps2_defconfig
ia64                                defconfig
um                                  defconfig
powerpc                      pcm030_defconfig
arm                         mv78xx0_defconfig
arm                          exynos_defconfig
arm                       multi_v4t_defconfig
mips                           ip22_defconfig
sh                           se7750_defconfig
mips                           rs90_defconfig
powerpc                    gamecube_defconfig
arc                     nsimosci_hs_defconfig
ia64                          tiger_defconfig
powerpc                     tqm8555_defconfig
arm                             pxa_defconfig
xtensa                generic_kc705_defconfig
arm                       imx_v6_v7_defconfig
xtensa                    smp_lx200_defconfig
sparc64                          alldefconfig
arm                        spear3xx_defconfig
arm                  colibri_pxa300_defconfig
powerpc                    ge_imp3a_defconfig
arm                        trizeps4_defconfig
sh                          urquell_defconfig
powerpc                 linkstation_defconfig
mips                      malta_kvm_defconfig
arm                             rpc_defconfig
powerpc                      ppc64e_defconfig
arm                            zeus_defconfig
powerpc                 mpc832x_rdb_defconfig
m68k                          atari_defconfig
sh                   sh7724_generic_defconfig
sh                             sh03_defconfig
arm                         s5pv210_defconfig
powerpc                     tqm8540_defconfig
sh                   rts7751r2dplus_defconfig
mips                      maltaaprp_defconfig
powerpc                     powernv_defconfig
sh                          r7785rp_defconfig
powerpc                      arches_defconfig
powerpc                      makalu_defconfig
powerpc                 mpc8560_ads_defconfig
mips                     cu1000-neo_defconfig
mips                        jmr3927_defconfig
sparc                       sparc64_defconfig
arm                          ixp4xx_defconfig
sh                          landisk_defconfig
powerpc                      bamboo_defconfig
xtensa                              defconfig
mips                 decstation_r4k_defconfig
arc                     haps_hs_smp_defconfig
sh                           se7712_defconfig
arm                            mmp2_defconfig
arm                            xcep_defconfig
arm                          ep93xx_defconfig
m68k                            mac_defconfig
arm                  colibri_pxa270_defconfig
mips                           ci20_defconfig
powerpc                     pq2fads_defconfig
sh                           se7751_defconfig
m68k                          amiga_defconfig
arm                         vf610m4_defconfig
arm                         lpc32xx_defconfig
h8300                            alldefconfig
ia64                             allmodconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
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
i386                 randconfig-a003-20210412
i386                 randconfig-a001-20210412
i386                 randconfig-a006-20210412
i386                 randconfig-a005-20210412
i386                 randconfig-a004-20210412
i386                 randconfig-a002-20210412
i386                 randconfig-a003-20210413
i386                 randconfig-a001-20210413
i386                 randconfig-a006-20210413
i386                 randconfig-a005-20210413
i386                 randconfig-a004-20210413
i386                 randconfig-a002-20210413
x86_64               randconfig-a014-20210412
x86_64               randconfig-a015-20210412
x86_64               randconfig-a011-20210412
x86_64               randconfig-a013-20210412
x86_64               randconfig-a012-20210412
x86_64               randconfig-a016-20210412
i386                 randconfig-a015-20210412
i386                 randconfig-a014-20210412
i386                 randconfig-a013-20210412
i386                 randconfig-a012-20210412
i386                 randconfig-a016-20210412
i386                 randconfig-a011-20210412
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                               defconfig
riscv                          rv32_defconfig
um                               allmodconfig
um                                allnoconfig
um                               allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a003-20210412
x86_64               randconfig-a002-20210412
x86_64               randconfig-a001-20210412
x86_64               randconfig-a005-20210412
x86_64               randconfig-a006-20210412
x86_64               randconfig-a004-20210412

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
