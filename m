Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EC67C433DB
	for <linux-bluetooth@archiver.kernel.org>; Thu, 11 Mar 2021 23:04:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6102B64F8D
	for <linux-bluetooth@archiver.kernel.org>; Thu, 11 Mar 2021 23:04:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbhCKXD6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 11 Mar 2021 18:03:58 -0500
Received: from mga05.intel.com ([192.55.52.43]:45379 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229667AbhCKXDd (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 11 Mar 2021 18:03:33 -0500
IronPort-SDR: HJkbfxyg99o4vc5pMxGkrgKyRdWrOGqiK/x359BKZ1/VP3DK4O836F2XzRFVnWz/cHONHPHOOV
 G8InFKnj9+Kw==
X-IronPort-AV: E=McAfee;i="6000,8403,9920"; a="273793744"
X-IronPort-AV: E=Sophos;i="5.81,241,1610438400"; 
   d="scan'208";a="273793744"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2021 15:03:32 -0800
IronPort-SDR: cr6Ntuluf66IMeux038pRJ2UsGpYi5adVRA9vqPjBplRqLmItXe86zjGEQ2zoCUX3fNk7NM+JC
 cxj6exlD4Ivw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,241,1610438400"; 
   d="scan'208";a="510160952"
Received: from lkp-server02.sh.intel.com (HELO ce64c092ff93) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 11 Mar 2021 15:03:31 -0800
Received: from kbuild by ce64c092ff93 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lKUL4-00010y-DZ; Thu, 11 Mar 2021 23:03:30 +0000
Date:   Fri, 12 Mar 2021 07:02:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 c1a74160eaf1ac218733b371158432b52601beff
Message-ID: <604aa19a.bJrBaMCoube0dUMb%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: c1a74160eaf1ac218733b371158432b52601beff  Bluetooth: hci_qca: Add device_may_wakeup support

elapsed time: 728m

configs tested: 111
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc                 mpc836x_rdk_defconfig
mips                        qi_lb60_defconfig
powerpc                     tqm8555_defconfig
openrisc                 simple_smp_defconfig
powerpc                     tqm8541_defconfig
arc                      axs103_smp_defconfig
ia64                                defconfig
powerpc                     sequoia_defconfig
h8300                            alldefconfig
mips                 decstation_r4k_defconfig
arc                          axs101_defconfig
sh                   sh7724_generic_defconfig
m68k                         apollo_defconfig
arm                         lpc32xx_defconfig
m68k                          multi_defconfig
xtensa                generic_kc705_defconfig
arm                         lpc18xx_defconfig
arc                     haps_hs_smp_defconfig
um                           x86_64_defconfig
s390                             alldefconfig
h8300                    h8300h-sim_defconfig
mips                        workpad_defconfig
arm                             mxs_defconfig
openrisc                            defconfig
arm                     am200epdkit_defconfig
powerpc                      pcm030_defconfig
mips                           ip27_defconfig
powerpc                       ebony_defconfig
sh                          sdk7786_defconfig
powerpc                     asp8347_defconfig
ia64                         bigsur_defconfig
arm                           corgi_defconfig
arm                     eseries_pxa_defconfig
mips                           rs90_defconfig
arm                        mini2440_defconfig
powerpc                     tqm8560_defconfig
powerpc                  iss476-smp_defconfig
ia64                             allmodconfig
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
x86_64               randconfig-a006-20210311
x86_64               randconfig-a001-20210311
x86_64               randconfig-a005-20210311
x86_64               randconfig-a002-20210311
x86_64               randconfig-a003-20210311
x86_64               randconfig-a004-20210311
i386                 randconfig-a001-20210311
i386                 randconfig-a005-20210311
i386                 randconfig-a003-20210311
i386                 randconfig-a002-20210311
i386                 randconfig-a004-20210311
i386                 randconfig-a006-20210311
i386                 randconfig-a013-20210311
i386                 randconfig-a016-20210311
i386                 randconfig-a011-20210311
i386                 randconfig-a014-20210311
i386                 randconfig-a015-20210311
i386                 randconfig-a012-20210311
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
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
x86_64               randconfig-a011-20210311
x86_64               randconfig-a016-20210311
x86_64               randconfig-a013-20210311
x86_64               randconfig-a015-20210311
x86_64               randconfig-a014-20210311
x86_64               randconfig-a012-20210311

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
