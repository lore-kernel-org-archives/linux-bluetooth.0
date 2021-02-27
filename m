Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03D82C433DB
	for <linux-bluetooth@archiver.kernel.org>; Sat, 27 Feb 2021 09:24:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC2A864EBC
	for <linux-bluetooth@archiver.kernel.org>; Sat, 27 Feb 2021 09:24:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbhB0JYf (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 27 Feb 2021 04:24:35 -0500
Received: from mga02.intel.com ([134.134.136.20]:26126 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229863AbhB0JYe (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 27 Feb 2021 04:24:34 -0500
IronPort-SDR: WhbmRBK9WGueiu+BdlGetTcswErAywqxape+eIgFMgFXoArKrHYOjrobxG6pdwR9KAF6uz95Dn
 ECHt920nMfCw==
X-IronPort-AV: E=McAfee;i="6000,8403,9907"; a="173231597"
X-IronPort-AV: E=Sophos;i="5.81,210,1610438400"; 
   d="scan'208";a="173231597"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2021 01:23:53 -0800
IronPort-SDR: RSXwaTvk1q3ruRbio4x6ix8Zf6xFOKKeqVyNinN0mGLGsFCeYhaUpq8Z0ZAVwhH9JSk0icjZHW
 AzqX4dYbYFXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,210,1610438400"; 
   d="scan'208";a="443422086"
Received: from lkp-server01.sh.intel.com (HELO 16660e54978b) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 27 Feb 2021 01:23:51 -0800
Received: from kbuild by 16660e54978b with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lFvpH-0003eQ-4U; Sat, 27 Feb 2021 09:23:51 +0000
Date:   Sat, 27 Feb 2021 17:23:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 201cf3976c065fc47ab260302d06690f73587df9
Message-ID: <603a0f87.Ul7sTSY7731MAtMF%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: 201cf3976c065fc47ab260302d06690f73587df9  Bluetooth: btusb: Fix incorrect type in assignment and uninitialized symbol

elapsed time: 722m

configs tested: 107
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                           sama5_defconfig
arm                            lart_defconfig
powerpc                        warp_defconfig
arm                            dove_defconfig
m68k                          multi_defconfig
arm                  colibri_pxa300_defconfig
powerpc                      pcm030_defconfig
powerpc                      obs600_defconfig
powerpc                     pseries_defconfig
arm                      pxa255-idp_defconfig
powerpc                 mpc832x_mds_defconfig
mips                     loongson1c_defconfig
mips                       bmips_be_defconfig
powerpc                 mpc834x_mds_defconfig
sh                         ecovec24_defconfig
arm                         bcm2835_defconfig
powerpc               mpc834x_itxgp_defconfig
sh                           sh2007_defconfig
mips                        vocore2_defconfig
mips                           ci20_defconfig
m68k                                defconfig
arm                       omap2plus_defconfig
powerpc                          g5_defconfig
sparc                            alldefconfig
powerpc                     sbc8548_defconfig
riscv                    nommu_virt_defconfig
powerpc                mpc7448_hpc2_defconfig
powerpc                  mpc885_ads_defconfig
arm                        spear6xx_defconfig
m68k                        m5407c3_defconfig
arc                         haps_hs_defconfig
mips                          malta_defconfig
powerpc                    gamecube_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
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
sparc                               defconfig
i386                               tinyconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a001-20210226
x86_64               randconfig-a002-20210226
x86_64               randconfig-a003-20210226
x86_64               randconfig-a005-20210226
x86_64               randconfig-a004-20210226
x86_64               randconfig-a006-20210226
i386                 randconfig-a005-20210226
i386                 randconfig-a006-20210226
i386                 randconfig-a004-20210226
i386                 randconfig-a001-20210226
i386                 randconfig-a003-20210226
i386                 randconfig-a002-20210226
i386                 randconfig-a013-20210226
i386                 randconfig-a012-20210226
i386                 randconfig-a011-20210226
i386                 randconfig-a014-20210226
i386                 randconfig-a016-20210226
i386                 randconfig-a015-20210226
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a015-20210226
x86_64               randconfig-a011-20210226
x86_64               randconfig-a012-20210226
x86_64               randconfig-a016-20210226
x86_64               randconfig-a013-20210226
x86_64               randconfig-a014-20210226

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
