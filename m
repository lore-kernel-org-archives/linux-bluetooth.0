Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E78E5C4338F
	for <linux-bluetooth@archiver.kernel.org>; Tue, 10 Aug 2021 08:06:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BEF5D61058
	for <linux-bluetooth@archiver.kernel.org>; Tue, 10 Aug 2021 08:06:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237986AbhHJIGy (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 10 Aug 2021 04:06:54 -0400
Received: from mga09.intel.com ([134.134.136.24]:43659 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237800AbhHJIGw (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 10 Aug 2021 04:06:52 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10070"; a="214843629"
X-IronPort-AV: E=Sophos;i="5.84,309,1620716400"; 
   d="scan'208";a="214843629"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2021 01:06:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,309,1620716400"; 
   d="scan'208";a="671617807"
Received: from lkp-server01.sh.intel.com (HELO d053b881505b) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 10 Aug 2021 01:06:28 -0700
Received: from kbuild by d053b881505b with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mDMmK-000KN3-7H; Tue, 10 Aug 2021 08:06:28 +0000
Date:   Tue, 10 Aug 2021 16:06:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 146af22649020e6b163482bc66150683ebf893bf
Message-ID: <6112336b.ZwAW8V1Eatt5gVZ0%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: 146af22649020e6b163482bc66150683ebf893bf  Bluetooth: btusb: Fix fall-through warnings

elapsed time: 5436m

configs tested: 159
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20210804
i386                 randconfig-c001-20210805
sparc                       sparc64_defconfig
sh                            migor_defconfig
sh                  sh7785lcr_32bit_defconfig
arm                              alldefconfig
s390                             allyesconfig
mips                malta_qemu_32r6_defconfig
sh                           se7343_defconfig
sh                             shx3_defconfig
m68k                        stmark2_defconfig
arc                     haps_hs_smp_defconfig
m68k                        m5307c3_defconfig
arm                          pcm027_defconfig
arm                         lpc32xx_defconfig
sh                           sh2007_defconfig
mips                        nlm_xlp_defconfig
ia64                             allmodconfig
mips                     loongson1b_defconfig
arm                           sama5_defconfig
sh                     sh7710voipgw_defconfig
sh                          rsk7264_defconfig
mips                        qi_lb60_defconfig
powerpc                         wii_defconfig
sh                   rts7751r2dplus_defconfig
arm                       imx_v6_v7_defconfig
ia64                        generic_defconfig
mips                        bcm47xx_defconfig
mips                         tb0287_defconfig
arm                       aspeed_g4_defconfig
arm64                            alldefconfig
arc                            hsdk_defconfig
powerpc                    sam440ep_defconfig
powerpc                      mgcoge_defconfig
powerpc                       ebony_defconfig
sh                   secureedge5410_defconfig
mips                        jmr3927_defconfig
powerpc                        fsp2_defconfig
arm                      footbridge_defconfig
arm                           spitz_defconfig
powerpc                     stx_gp3_defconfig
s390                       zfcpdump_defconfig
arm                          moxart_defconfig
powerpc                       ppc64_defconfig
powerpc                 mpc837x_rdb_defconfig
arm                          gemini_defconfig
mips                       bmips_be_defconfig
parisc                           allyesconfig
s390                                defconfig
arm                       cns3420vb_defconfig
x86_64                            allnoconfig
powerpc                 canyonlands_defconfig
powerpc                      ppc44x_defconfig
sh                               j2_defconfig
csky                                defconfig
arm                     am200epdkit_defconfig
powerpc                          allmodconfig
arm                      jornada720_defconfig
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
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allmodconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                           allnoconfig
x86_64               randconfig-a002-20210805
x86_64               randconfig-a006-20210805
x86_64               randconfig-a004-20210805
x86_64               randconfig-a003-20210805
x86_64               randconfig-a001-20210805
x86_64               randconfig-a005-20210805
i386                 randconfig-a005-20210804
i386                 randconfig-a004-20210804
i386                 randconfig-a002-20210804
i386                 randconfig-a006-20210804
i386                 randconfig-a003-20210804
i386                 randconfig-a001-20210804
i386                 randconfig-a005-20210806
i386                 randconfig-a004-20210806
i386                 randconfig-a002-20210806
i386                 randconfig-a006-20210806
i386                 randconfig-a003-20210806
i386                 randconfig-a001-20210806
i386                 randconfig-a005-20210805
i386                 randconfig-a004-20210805
i386                 randconfig-a002-20210805
i386                 randconfig-a006-20210805
i386                 randconfig-a003-20210805
i386                 randconfig-a001-20210805
x86_64               randconfig-a012-20210804
x86_64               randconfig-a016-20210804
x86_64               randconfig-a011-20210804
x86_64               randconfig-a013-20210804
x86_64               randconfig-a014-20210804
x86_64               randconfig-a015-20210804
i386                 randconfig-a012-20210807
i386                 randconfig-a011-20210807
i386                 randconfig-a015-20210807
i386                 randconfig-a013-20210807
i386                 randconfig-a014-20210807
i386                 randconfig-a016-20210807
i386                 randconfig-a012-20210804
i386                 randconfig-a011-20210804
i386                 randconfig-a015-20210804
i386                 randconfig-a013-20210804
i386                 randconfig-a014-20210804
i386                 randconfig-a016-20210804
i386                 randconfig-a012-20210806
i386                 randconfig-a011-20210806
i386                 randconfig-a015-20210806
i386                 randconfig-a013-20210806
i386                 randconfig-a014-20210806
i386                 randconfig-a016-20210806
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-c001-20210804
x86_64               randconfig-c001-20210805
x86_64               randconfig-a002-20210804
x86_64               randconfig-a006-20210804
x86_64               randconfig-a004-20210804
x86_64               randconfig-a003-20210804
x86_64               randconfig-a001-20210804
x86_64               randconfig-a005-20210804

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
