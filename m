Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB443C433FE
	for <linux-bluetooth@archiver.kernel.org>; Fri,  4 Dec 2020 23:07:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A02AE22D01
	for <linux-bluetooth@archiver.kernel.org>; Fri,  4 Dec 2020 23:07:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726263AbgLDXH1 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 4 Dec 2020 18:07:27 -0500
Received: from mga07.intel.com ([134.134.136.100]:54366 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725960AbgLDXH1 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 4 Dec 2020 18:07:27 -0500
IronPort-SDR: DRyhtA1iKLoDL6VFA9o9a1RdJKY14Tp+TRIwP4m99ByR9XFc3Xuv9P7XgrswHpfHcy9OXqN7HW
 2IxCgFL65wMg==
X-IronPort-AV: E=McAfee;i="6000,8403,9825"; a="237577706"
X-IronPort-AV: E=Sophos;i="5.78,394,1599548400"; 
   d="scan'208";a="237577706"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2020 15:06:35 -0800
IronPort-SDR: WWeZopRlP3zmHKYkYhmXMdVWj482EpHsMTQMfWwSiCCUtgKofVsO+d1WKdGlYTU7N8jOlYPSXt
 pPUt43EdOVGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,393,1599548400"; 
   d="scan'208";a="366477861"
Received: from lkp-server02.sh.intel.com (HELO f74a175f0d75) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 04 Dec 2020 15:06:33 -0800
Received: from kbuild by f74a175f0d75 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1klK9o-0000Zm-El; Fri, 04 Dec 2020 23:06:32 +0000
Date:   Sat, 05 Dec 2020 07:06:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 f71b680cb35f9d2ef99f9234f4c814ae221a62d2
Message-ID: <5fcac0f4.gne/rWjepd/BjtvB%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git  master
branch HEAD: f71b680cb35f9d2ef99f9234f4c814ae221a62d2  Bluetooth: Set missing suspend task bits

elapsed time: 723m

configs tested: 109
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                              allmodconfig
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
powerpc                     tqm8555_defconfig
s390                                defconfig
sh                           se7721_defconfig
m68k                          amiga_defconfig
sh                          r7785rp_defconfig
sh                         microdev_defconfig
m68k                       m5275evb_defconfig
arm                        shmobile_defconfig
arm                          pcm027_defconfig
arm                           u8500_defconfig
powerpc                      ppc6xx_defconfig
arm                         vf610m4_defconfig
powerpc                   motionpro_defconfig
nds32                               defconfig
mips                           jazz_defconfig
powerpc                        cell_defconfig
ia64                             alldefconfig
powerpc                     redwood_defconfig
m68k                       m5208evb_defconfig
arm                           stm32_defconfig
powerpc                     pseries_defconfig
mips                         tb0219_defconfig
arm                          prima2_defconfig
sh                            titan_defconfig
powerpc                       eiger_defconfig
arm                        trizeps4_defconfig
sh                          lboxre2_defconfig
powerpc                    amigaone_defconfig
powerpc               mpc834x_itxgp_defconfig
arm                        spear3xx_defconfig
powerpc                 mpc8272_ads_defconfig
sh                             espt_defconfig
arm                        multi_v5_defconfig
arm                         nhk8815_defconfig
m68k                            q40_defconfig
sparc64                             defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
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
x86_64               randconfig-a004-20201204
x86_64               randconfig-a006-20201204
x86_64               randconfig-a002-20201204
x86_64               randconfig-a001-20201204
x86_64               randconfig-a005-20201204
x86_64               randconfig-a003-20201204
i386                 randconfig-a005-20201204
i386                 randconfig-a004-20201204
i386                 randconfig-a001-20201204
i386                 randconfig-a002-20201204
i386                 randconfig-a006-20201204
i386                 randconfig-a003-20201204
i386                 randconfig-a014-20201204
i386                 randconfig-a013-20201204
i386                 randconfig-a011-20201204
i386                 randconfig-a015-20201204
i386                 randconfig-a012-20201204
i386                 randconfig-a016-20201204
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a016-20201204
x86_64               randconfig-a012-20201204
x86_64               randconfig-a014-20201204
x86_64               randconfig-a013-20201204
x86_64               randconfig-a015-20201204
x86_64               randconfig-a011-20201204

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
