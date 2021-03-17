Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC7F8C433E9
	for <linux-bluetooth@archiver.kernel.org>; Wed, 17 Mar 2021 03:14:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B193464F96
	for <linux-bluetooth@archiver.kernel.org>; Wed, 17 Mar 2021 03:14:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbhCQDNf (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 16 Mar 2021 23:13:35 -0400
Received: from mga01.intel.com ([192.55.52.88]:58934 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229673AbhCQDNV (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 16 Mar 2021 23:13:21 -0400
IronPort-SDR: Kxvvubs0Rrvnxe3OdENGj/o+VrqXkrjtGFT4TJS8mYGRQ7+ugiN12+jTL1QgbKLv3egjtTZxVx
 FZrSNAUPS/yQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9925"; a="209335333"
X-IronPort-AV: E=Sophos;i="5.81,254,1610438400"; 
   d="scan'208";a="209335333"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2021 20:13:21 -0700
IronPort-SDR: fiUzmBvHwVZhzu4QgjrxmqT4UgoXgMwdGmm8Yo3x5WV0l6oG3gp03p90AgEmO45JLEqIAfGE/v
 rolQYqFPbD0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,254,1610438400"; 
   d="scan'208";a="405761185"
Received: from lkp-server02.sh.intel.com (HELO 1c294c63cb86) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 16 Mar 2021 20:13:20 -0700
Received: from kbuild by 1c294c63cb86 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lMMcZ-0000Tg-2F; Wed, 17 Mar 2021 03:13:19 +0000
Date:   Wed, 17 Mar 2021 11:12:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 17486960d79b900c45e0bb8fbcac0262848582ba
Message-ID: <605173b5.s2nDjE+pVPfwq1B0%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: 17486960d79b900c45e0bb8fbcac0262848582ba  Bluetooth: avoid deadlock between hci_dev->lock and socket lock

elapsed time: 724m

configs tested: 135
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
nds32                             allnoconfig
mips                malta_qemu_32r6_defconfig
ia64                          tiger_defconfig
arm                         bcm2835_defconfig
m68k                       m5475evb_defconfig
sh                          kfr2r09_defconfig
powerpc                      ppc64e_defconfig
arm                       netwinder_defconfig
mips                      maltaaprp_defconfig
arm                         hackkit_defconfig
arc                              allyesconfig
arm                          gemini_defconfig
sh                               j2_defconfig
arm                         vf610m4_defconfig
powerpc                      pmac32_defconfig
s390                       zfcpdump_defconfig
sh                           se7722_defconfig
arm                           h3600_defconfig
mips                          rm200_defconfig
arm                           stm32_defconfig
m68k                       bvme6000_defconfig
powerpc                     akebono_defconfig
mips                     loongson1b_defconfig
arc                         haps_hs_defconfig
arm                           u8500_defconfig
nios2                         3c120_defconfig
parisc                generic-32bit_defconfig
powerpc                      ppc6xx_defconfig
microblaze                      mmu_defconfig
csky                             alldefconfig
powerpc                  storcenter_defconfig
powerpc                       ppc64_defconfig
mips                           ip27_defconfig
sh                          r7785rp_defconfig
arm                         lubbock_defconfig
mips                    maltaup_xpa_defconfig
arm                       spear13xx_defconfig
powerpc                         ps3_defconfig
sh                           se7206_defconfig
arm                           spitz_defconfig
mips                        nlm_xlp_defconfig
powerpc                   bluestone_defconfig
mips                         tb0219_defconfig
arm                         assabet_defconfig
mips                      pistachio_defconfig
mips                  decstation_64_defconfig
h8300                     edosk2674_defconfig
arm                       mainstone_defconfig
arm                          badge4_defconfig
arm                         s3c2410_defconfig
powerpc                     tqm8560_defconfig
mips                         bigsur_defconfig
powerpc                     ep8248e_defconfig
powerpc                      cm5200_defconfig
mips                     loongson1c_defconfig
sparc64                             defconfig
arm                            mps2_defconfig
powerpc                 mpc8540_ads_defconfig
powerpc                     pseries_defconfig
arm                        neponset_defconfig
arm                        trizeps4_defconfig
sh                        edosk7705_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
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
sparc                            allyesconfig
sparc                               defconfig
i386                               tinyconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a001-20210316
i386                 randconfig-a005-20210316
i386                 randconfig-a002-20210316
i386                 randconfig-a003-20210316
i386                 randconfig-a004-20210316
i386                 randconfig-a006-20210316
x86_64               randconfig-a011-20210316
x86_64               randconfig-a016-20210316
x86_64               randconfig-a013-20210316
x86_64               randconfig-a014-20210316
x86_64               randconfig-a015-20210316
x86_64               randconfig-a012-20210316
i386                 randconfig-a013-20210316
i386                 randconfig-a016-20210316
i386                 randconfig-a011-20210316
i386                 randconfig-a012-20210316
i386                 randconfig-a015-20210316
i386                 randconfig-a014-20210316
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
x86_64               randconfig-a006-20210316
x86_64               randconfig-a001-20210316
x86_64               randconfig-a005-20210316
x86_64               randconfig-a004-20210316
x86_64               randconfig-a003-20210316
x86_64               randconfig-a002-20210316

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
