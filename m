Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F5A7C2B9F4
	for <linux-bluetooth@archiver.kernel.org>; Thu, 17 Jun 2021 05:12:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B9F26128C
	for <linux-bluetooth@archiver.kernel.org>; Thu, 17 Jun 2021 05:12:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbhFQFOS (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 17 Jun 2021 01:14:18 -0400
Received: from mga18.intel.com ([134.134.136.126]:64164 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229495AbhFQFOQ (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 17 Jun 2021 01:14:16 -0400
IronPort-SDR: AgP7k7UUT9/9WlI5Zvbi5DkCquZJsacoMSTJG+eQ3UuC+3H3+wlU7yPHFP+290RfRYSTCvH+ON
 7EmUpSJ8iqHg==
X-IronPort-AV: E=McAfee;i="6200,9189,10017"; a="193613572"
X-IronPort-AV: E=Sophos;i="5.83,278,1616482800"; 
   d="scan'208";a="193613572"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2021 22:12:09 -0700
IronPort-SDR: NwCu3BSKxpLLwVRTiLtUVgnLJE/hiseq9XepVPBkESfsVnnJjHjcWYBWSU4MZtg/2i+oNf5MOp
 xsd/HuYN84Ug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,278,1616482800"; 
   d="scan'208";a="404825713"
Received: from lkp-server01.sh.intel.com (HELO 4aae0cb4f5b5) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 16 Jun 2021 22:12:08 -0700
Received: from kbuild by 4aae0cb4f5b5 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1ltkJz-0001oh-G9; Thu, 17 Jun 2021 05:12:07 +0000
Date:   Thu, 17 Jun 2021 13:11:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 cbeca1470546a261dcab40f1fb6d6a06c842c6bf
Message-ID: <60cad97b.zXqi1iwYEUmTn+h0%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: cbeca1470546a261dcab40f1fb6d6a06c842c6bf  Bluetooth: btmrvl: remove redundant continue statement

elapsed time: 735m

configs tested: 118
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
nios2                            alldefconfig
sh                ecovec24-romimage_defconfig
mips                    maltaup_xpa_defconfig
arm                        vexpress_defconfig
arm                          pxa910_defconfig
m68k                       m5475evb_defconfig
arm                  colibri_pxa270_defconfig
mips                          ath79_defconfig
arm                            mps2_defconfig
arm                          moxart_defconfig
sh                            titan_defconfig
arm                         mv78xx0_defconfig
sh                            shmin_defconfig
arm                         socfpga_defconfig
nios2                         10m50_defconfig
powerpc               mpc834x_itxgp_defconfig
s390                             allyesconfig
powerpc                 mpc8560_ads_defconfig
powerpc                     tqm8555_defconfig
arm                       netwinder_defconfig
arm                        multi_v5_defconfig
powerpc                     kmeter1_defconfig
powerpc                     ppa8548_defconfig
arm                         axm55xx_defconfig
arm                        clps711x_defconfig
arm                     eseries_pxa_defconfig
x86_64                            allnoconfig
powerpc                         ps3_defconfig
sh                          urquell_defconfig
powerpc                      cm5200_defconfig
arm                          imote2_defconfig
arm                       mainstone_defconfig
mips                        maltaup_defconfig
m68k                           sun3_defconfig
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
i386                 randconfig-a002-20210615
i386                 randconfig-a006-20210615
i386                 randconfig-a004-20210615
i386                 randconfig-a001-20210615
i386                 randconfig-a005-20210615
i386                 randconfig-a003-20210615
i386                 randconfig-a015-20210616
i386                 randconfig-a013-20210616
i386                 randconfig-a016-20210616
i386                 randconfig-a012-20210616
i386                 randconfig-a014-20210616
i386                 randconfig-a011-20210616
x86_64               randconfig-a001-20210615
x86_64               randconfig-a004-20210615
x86_64               randconfig-a002-20210615
x86_64               randconfig-a003-20210615
x86_64               randconfig-a006-20210615
x86_64               randconfig-a005-20210615
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
um                            kunit_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-b001-20210615
x86_64               randconfig-b001-20210617
x86_64               randconfig-a015-20210615
x86_64               randconfig-a011-20210615
x86_64               randconfig-a012-20210615
x86_64               randconfig-a014-20210615
x86_64               randconfig-a016-20210615
x86_64               randconfig-a013-20210615
x86_64               randconfig-a015-20210617
x86_64               randconfig-a011-20210617
x86_64               randconfig-a014-20210617
x86_64               randconfig-a012-20210617
x86_64               randconfig-a013-20210617
x86_64               randconfig-a016-20210617

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
