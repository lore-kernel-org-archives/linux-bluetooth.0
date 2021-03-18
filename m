Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7B0FC433DB
	for <linux-bluetooth@archiver.kernel.org>; Thu, 18 Mar 2021 03:21:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 750B564E89
	for <linux-bluetooth@archiver.kernel.org>; Thu, 18 Mar 2021 03:21:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbhCRDU7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 17 Mar 2021 23:20:59 -0400
Received: from mga03.intel.com ([134.134.136.65]:21061 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230330AbhCRDUm (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 17 Mar 2021 23:20:42 -0400
IronPort-SDR: vrSXl/pLKf8Eg/1vSsN5HjIpK+wrY7j7VOsRfbzBpVMxEcxy+3bAh65xa682WSN+YDXPIE8gio
 4llfO37DYYCQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9926"; a="189636578"
X-IronPort-AV: E=Sophos;i="5.81,257,1610438400"; 
   d="scan'208";a="189636578"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2021 20:20:41 -0700
IronPort-SDR: m/dNaEQZ/ElMBOo/kj4bPKPOIIty63xYol1Ydk4z+6KeME+OxFzlTu9IxmOUReRhiR5I+Wsbt0
 AESt6bevTr5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,257,1610438400"; 
   d="scan'208";a="372562819"
Received: from lkp-server02.sh.intel.com (HELO 1c294c63cb86) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 17 Mar 2021 20:20:40 -0700
Received: from kbuild by 1c294c63cb86 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lMjDD-0000za-B5; Thu, 18 Mar 2021 03:20:39 +0000
Date:   Thu, 18 Mar 2021 11:20:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 87df8bcccd2cede62dfb97dc3d4ca1fe66cb4f83
Message-ID: <6052c6f4.w1PeS6Ajo9DoQWVF%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: 87df8bcccd2cede62dfb97dc3d4ca1fe66cb4f83  Bluetooth: Fix incorrect status handling in LE PHY UPDATE event

elapsed time: 728m

configs tested: 173
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
powerpc                 mpc8540_ads_defconfig
arm                         at91_dt_defconfig
arc                            hsdk_defconfig
mips                        nlm_xlr_defconfig
sh                              ul2_defconfig
mips                        workpad_defconfig
arm                         hackkit_defconfig
arm                         lpc18xx_defconfig
powerpc                      pcm030_defconfig
m68k                             allmodconfig
powerpc                     taishan_defconfig
h8300                     edosk2674_defconfig
powerpc                     redwood_defconfig
mips                        qi_lb60_defconfig
powerpc                          allmodconfig
mips                            gpr_defconfig
m68k                       bvme6000_defconfig
powerpc                      acadia_defconfig
arm                          pxa910_defconfig
sh                         ecovec24_defconfig
powerpc                 xes_mpc85xx_defconfig
arm                            mmp2_defconfig
arm                         palmz72_defconfig
arm                          iop32x_defconfig
arm                        neponset_defconfig
powerpc                     kilauea_defconfig
powerpc                      walnut_defconfig
powerpc                     rainier_defconfig
powerpc                    gamecube_defconfig
sh                            shmin_defconfig
openrisc                 simple_smp_defconfig
parisc                generic-64bit_defconfig
powerpc                     asp8347_defconfig
arm                           tegra_defconfig
powerpc                      pmac32_defconfig
mips                           gcw0_defconfig
sh                         apsh4a3a_defconfig
powerpc                         wii_defconfig
powerpc                       eiger_defconfig
mips                       bmips_be_defconfig
m68k                        stmark2_defconfig
mips                           ip28_defconfig
powerpc                    adder875_defconfig
arm                         assabet_defconfig
arc                              alldefconfig
arm                       multi_v4t_defconfig
sh                           se7619_defconfig
arm                          moxart_defconfig
powerpc                          allyesconfig
mips                           ip32_defconfig
ia64                         bigsur_defconfig
arm                        multi_v7_defconfig
powerpc                      chrp32_defconfig
powerpc                 mpc8560_ads_defconfig
powerpc                   lite5200b_defconfig
csky                             alldefconfig
arm                       imx_v4_v5_defconfig
mips                     loongson1b_defconfig
h8300                    h8300h-sim_defconfig
sh                        sh7757lcr_defconfig
arm                     eseries_pxa_defconfig
arm                            lart_defconfig
mips                      bmips_stb_defconfig
mips                    maltaup_xpa_defconfig
powerpc                     skiroot_defconfig
sh                     sh7710voipgw_defconfig
powerpc                       ebony_defconfig
arm                      footbridge_defconfig
mips                        bcm47xx_defconfig
powerpc                mpc7448_hpc2_defconfig
xtensa                              defconfig
arm                         lpc32xx_defconfig
alpha                            allyesconfig
sh                          lboxre2_defconfig
arm                           sama5_defconfig
mips                        nlm_xlp_defconfig
sh                             espt_defconfig
sh                   secureedge5410_defconfig
parisc                           allyesconfig
arc                        nsimosci_defconfig
powerpc                    sam440ep_defconfig
arm                         bcm2835_defconfig
arm                          ixp4xx_defconfig
mips                        vocore2_defconfig
xtensa                       common_defconfig
m68k                                defconfig
s390                       zfcpdump_defconfig
arm                     am200epdkit_defconfig
microblaze                          defconfig
mips                      malta_kvm_defconfig
arm                           spitz_defconfig
sh                  sh7785lcr_32bit_defconfig
nios2                         3c120_defconfig
m68k                        mvme16x_defconfig
sh                        sh7763rdp_defconfig
powerpc                     sbc8548_defconfig
arm                      pxa255-idp_defconfig
arm                          exynos_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
s390                                defconfig
sparc                            allyesconfig
sparc                               defconfig
i386                               tinyconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a006-20210317
x86_64               randconfig-a001-20210317
x86_64               randconfig-a005-20210317
x86_64               randconfig-a004-20210317
x86_64               randconfig-a003-20210317
x86_64               randconfig-a002-20210317
i386                 randconfig-a001-20210317
i386                 randconfig-a005-20210317
i386                 randconfig-a002-20210317
i386                 randconfig-a003-20210317
i386                 randconfig-a004-20210317
i386                 randconfig-a006-20210317
i386                 randconfig-a001-20210318
i386                 randconfig-a005-20210318
i386                 randconfig-a003-20210318
i386                 randconfig-a002-20210318
i386                 randconfig-a006-20210318
i386                 randconfig-a004-20210318
i386                 randconfig-a013-20210317
i386                 randconfig-a016-20210317
i386                 randconfig-a011-20210317
i386                 randconfig-a012-20210317
i386                 randconfig-a015-20210317
i386                 randconfig-a014-20210317
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a011-20210317
x86_64               randconfig-a016-20210317
x86_64               randconfig-a013-20210317
x86_64               randconfig-a014-20210317
x86_64               randconfig-a015-20210317
x86_64               randconfig-a012-20210317

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
