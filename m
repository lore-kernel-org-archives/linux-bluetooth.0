Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DA99C433E0
	for <linux-bluetooth@archiver.kernel.org>; Mon, 28 Dec 2020 11:20:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E08EE229C5
	for <linux-bluetooth@archiver.kernel.org>; Mon, 28 Dec 2020 11:20:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727211AbgL1LUH (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 28 Dec 2020 06:20:07 -0500
Received: from mga14.intel.com ([192.55.52.115]:24242 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727165AbgL1LUH (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 28 Dec 2020 06:20:07 -0500
IronPort-SDR: 8rhgHyekVflehZBTn8ucPom17YfKFK6NliuvA8D2w2denru0qyz247EdYoytDsCmtKZCiZdr+F
 EiowGraPwp0g==
X-IronPort-AV: E=McAfee;i="6000,8403,9847"; a="175596482"
X-IronPort-AV: E=Sophos;i="5.78,455,1599548400"; 
   d="scan'208";a="175596482"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2020 03:19:25 -0800
IronPort-SDR: iuVco1mT4U0AUopvKj9Lj5oDWgWbxmkx9Bjv1L2/RZmlUQ1JllkWn2a+M02TscbTxL2nw8On6d
 3R2NufVXM/Sw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,455,1599548400"; 
   d="scan'208";a="494288419"
Received: from lkp-server02.sh.intel.com (HELO 4242b19f17ef) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 28 Dec 2020 03:19:23 -0800
Received: from kbuild by 4242b19f17ef with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1ktqYc-0002sv-Qi; Mon, 28 Dec 2020 11:19:22 +0000
Date:   Mon, 28 Dec 2020 19:18:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 a5687c644015a097304a2e47476c0ecab2065734
Message-ID: <5fe9bf0a.YV9VArVOOZ2REnSR%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git  master
branch HEAD: a5687c644015a097304a2e47476c0ecab2065734  Bluetooth: Fix initializing response id after clearing struct

elapsed time: 721m

configs tested: 113
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                     davinci_all_defconfig
m68k                          sun3x_defconfig
arm                            xcep_defconfig
m68k                       m5275evb_defconfig
arm                         s5pv210_defconfig
arm                         mv78xx0_defconfig
mips                  maltasmvp_eva_defconfig
mips                         db1xxx_defconfig
arc                         haps_hs_defconfig
arm                          badge4_defconfig
powerpc                  mpc866_ads_defconfig
xtensa                         virt_defconfig
powerpc                 mpc8540_ads_defconfig
arm                            hisi_defconfig
m68k                        mvme147_defconfig
sh                         ecovec24_defconfig
mips                malta_kvm_guest_defconfig
arm                         s3c6400_defconfig
mips                            ar7_defconfig
m68k                         amcore_defconfig
alpha                            allyesconfig
h8300                    h8300h-sim_defconfig
arm                             mxs_defconfig
arm                        vexpress_defconfig
arm                        magician_defconfig
mips                        nlm_xlp_defconfig
m68k                             alldefconfig
xtensa                    xip_kc705_defconfig
ia64                        generic_defconfig
ia64                          tiger_defconfig
powerpc                     kilauea_defconfig
arm                      jornada720_defconfig
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
alpha                               defconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
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
x86_64               randconfig-a001-20201227
x86_64               randconfig-a006-20201227
x86_64               randconfig-a004-20201227
x86_64               randconfig-a002-20201227
x86_64               randconfig-a003-20201227
x86_64               randconfig-a005-20201227
i386                 randconfig-a005-20201228
i386                 randconfig-a002-20201228
i386                 randconfig-a004-20201228
i386                 randconfig-a006-20201228
i386                 randconfig-a003-20201228
i386                 randconfig-a001-20201228
i386                 randconfig-a002-20201227
i386                 randconfig-a005-20201227
i386                 randconfig-a006-20201227
i386                 randconfig-a004-20201227
i386                 randconfig-a003-20201227
i386                 randconfig-a001-20201227
i386                 randconfig-a011-20201227
i386                 randconfig-a016-20201227
i386                 randconfig-a012-20201227
i386                 randconfig-a014-20201227
i386                 randconfig-a015-20201227
i386                 randconfig-a013-20201227
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
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a015-20201227
x86_64               randconfig-a014-20201227
x86_64               randconfig-a016-20201227
x86_64               randconfig-a012-20201227
x86_64               randconfig-a013-20201227
x86_64               randconfig-a011-20201227

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
