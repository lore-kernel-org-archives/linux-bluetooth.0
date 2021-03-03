Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B95ADC433E6
	for <linux-bluetooth@archiver.kernel.org>; Wed,  3 Mar 2021 13:21:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 900C264EE7
	for <linux-bluetooth@archiver.kernel.org>; Wed,  3 Mar 2021 13:21:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358945AbhCCNTO (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 3 Mar 2021 08:19:14 -0500
Received: from mga03.intel.com ([134.134.136.65]:15347 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240903AbhCCDB7 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 2 Mar 2021 22:01:59 -0500
IronPort-SDR: p9+6ncUz/4VlESM8rCFm44Iohk5sK1sV6IZV6rob2wkAgFcIqKf6ur/ZLSzdHEzo1vJV2ngkyI
 NoYcopWRx0LA==
X-IronPort-AV: E=McAfee;i="6000,8403,9911"; a="187138820"
X-IronPort-AV: E=Sophos;i="5.81,218,1610438400"; 
   d="scan'208";a="187138820"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2021 19:00:38 -0800
IronPort-SDR: vRABZI72dZEp/+1iJSjnYaJmI55nHkXKqLB/lAXazWQEK4tE9wOFZEbGOkaeJE1XHvmi5NjS/U
 ZY+Zo/XeqeoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,218,1610438400"; 
   d="scan'208";a="518109666"
Received: from lkp-server02.sh.intel.com (HELO 2482ff9f8ac0) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 02 Mar 2021 19:00:36 -0800
Received: from kbuild by 2482ff9f8ac0 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lHHka-0000qL-8e; Wed, 03 Mar 2021 03:00:36 +0000
Date:   Wed, 03 Mar 2021 11:00:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 5cb08553f7f2536f2f5a9142a060af2a77c1d5dc
Message-ID: <603efbbd.SZD62iB21Gs+HKFh%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: 5cb08553f7f2536f2f5a9142a060af2a77c1d5dc  Bluetooth: Notify suspend on le conn failed

elapsed time: 730m

configs tested: 99
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                          ep93xx_defconfig
arm                     am200epdkit_defconfig
powerpc                        warp_defconfig
m68k                        stmark2_defconfig
riscv                    nommu_k210_defconfig
m68k                          amiga_defconfig
powerpc                      acadia_defconfig
powerpc                 mpc8540_ads_defconfig
sparc                            allyesconfig
arm                           omap1_defconfig
alpha                               defconfig
arm                         orion5x_defconfig
mips                         bigsur_defconfig
arm                        oxnas_v6_defconfig
xtensa                  nommu_kc705_defconfig
s390                       zfcpdump_defconfig
sh                      rts7751r2d1_defconfig
sparc                               defconfig
c6x                              alldefconfig
sh                 kfr2r09-romimage_defconfig
parisc                              defconfig
arm                           h3600_defconfig
arm                        vexpress_defconfig
xtensa                          iss_defconfig
arm                            zeus_defconfig
m68k                         apollo_defconfig
mips                     loongson1b_defconfig
arm                         s3c2410_defconfig
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
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
i386                               tinyconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a005-20210302
i386                 randconfig-a003-20210302
i386                 randconfig-a002-20210302
i386                 randconfig-a004-20210302
i386                 randconfig-a006-20210302
i386                 randconfig-a001-20210302
i386                 randconfig-a016-20210302
i386                 randconfig-a012-20210302
i386                 randconfig-a014-20210302
i386                 randconfig-a013-20210302
i386                 randconfig-a011-20210302
i386                 randconfig-a015-20210302
x86_64               randconfig-a006-20210302
x86_64               randconfig-a001-20210302
x86_64               randconfig-a004-20210302
x86_64               randconfig-a002-20210302
x86_64               randconfig-a005-20210302
x86_64               randconfig-a003-20210302
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
x86_64               randconfig-a013-20210302
x86_64               randconfig-a016-20210302
x86_64               randconfig-a015-20210302
x86_64               randconfig-a014-20210302
x86_64               randconfig-a012-20210302
x86_64               randconfig-a011-20210302

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
