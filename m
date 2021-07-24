Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 998DEC4338F
	for <linux-bluetooth@archiver.kernel.org>; Sat, 24 Jul 2021 19:52:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F9D260E96
	for <linux-bluetooth@archiver.kernel.org>; Sat, 24 Jul 2021 19:52:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbhGXTLv (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 24 Jul 2021 15:11:51 -0400
Received: from mga06.intel.com ([134.134.136.31]:22043 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229481AbhGXTLu (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 24 Jul 2021 15:11:50 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10055"; a="273143073"
X-IronPort-AV: E=Sophos;i="5.84,266,1620716400"; 
   d="scan'208";a="273143073"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2021 12:52:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,266,1620716400"; 
   d="scan'208";a="578703627"
Received: from lkp-server01.sh.intel.com (HELO d053b881505b) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 24 Jul 2021 12:52:21 -0700
Received: from kbuild by d053b881505b with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1m7Nh6-0003kJ-CK; Sat, 24 Jul 2021 19:52:20 +0000
Date:   Sun, 25 Jul 2021 03:52:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 acd5aea400494ce960904cca4626dfbbe307dd47
Message-ID: <60fc6f62.0wKLzRpd+b+ykdFS%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: acd5aea400494ce960904cca4626dfbbe307dd47  Bluetooth: btusb: Add valid le states quirk

elapsed time: 723m

configs tested: 156
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20210723
i386                 randconfig-c001-20210724
powerpc                      tqm8xx_defconfig
powerpc                      obs600_defconfig
openrisc                            defconfig
arm                          pxa910_defconfig
powerpc                        icon_defconfig
powerpc                 mpc836x_mds_defconfig
powerpc                 xes_mpc85xx_defconfig
sh                             espt_defconfig
powerpc                      katmai_defconfig
sh                   rts7751r2dplus_defconfig
arm                        oxnas_v6_defconfig
nds32                            alldefconfig
sh                           se7206_defconfig
sh                           se7712_defconfig
sh                           se7343_defconfig
powerpc                     skiroot_defconfig
arm                          collie_defconfig
powerpc                     akebono_defconfig
sh                          sdk7780_defconfig
mips                        bcm47xx_defconfig
powerpc                           allnoconfig
powerpc                 mpc836x_rdk_defconfig
arm                      tct_hammer_defconfig
arm                        mvebu_v5_defconfig
sh                        apsh4ad0a_defconfig
xtensa                          iss_defconfig
sh                           se7721_defconfig
m68k                        m5407c3_defconfig
sh                          sdk7786_defconfig
csky                                defconfig
mips                      loongson3_defconfig
mips                        nlm_xlp_defconfig
arm                         socfpga_defconfig
arm                        shmobile_defconfig
powerpc                 mpc8313_rdb_defconfig
sh                            titan_defconfig
mips                 decstation_r4k_defconfig
powerpc                  iss476-smp_defconfig
parisc                generic-64bit_defconfig
arc                    vdk_hs38_smp_defconfig
powerpc                     sequoia_defconfig
m68k                       m5275evb_defconfig
arc                           tb10x_defconfig
xtensa                    xip_kc705_defconfig
arm                            xcep_defconfig
arm                             ezx_defconfig
mips                      pistachio_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
x86_64                            allnoconfig
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
s390                             allyesconfig
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
x86_64               randconfig-a003-20210724
x86_64               randconfig-a006-20210724
x86_64               randconfig-a001-20210724
x86_64               randconfig-a005-20210724
x86_64               randconfig-a004-20210724
x86_64               randconfig-a002-20210724
i386                 randconfig-a005-20210724
i386                 randconfig-a003-20210724
i386                 randconfig-a004-20210724
i386                 randconfig-a002-20210724
i386                 randconfig-a001-20210724
i386                 randconfig-a006-20210724
i386                 randconfig-a005-20210725
i386                 randconfig-a003-20210725
i386                 randconfig-a004-20210725
i386                 randconfig-a002-20210725
i386                 randconfig-a001-20210725
i386                 randconfig-a006-20210725
x86_64               randconfig-a011-20210723
x86_64               randconfig-a016-20210723
x86_64               randconfig-a013-20210723
x86_64               randconfig-a014-20210723
x86_64               randconfig-a012-20210723
x86_64               randconfig-a015-20210723
x86_64               randconfig-a011-20210725
x86_64               randconfig-a016-20210725
x86_64               randconfig-a013-20210725
x86_64               randconfig-a014-20210725
x86_64               randconfig-a012-20210725
x86_64               randconfig-a015-20210725
i386                 randconfig-a016-20210724
i386                 randconfig-a013-20210724
i386                 randconfig-a012-20210724
i386                 randconfig-a014-20210724
i386                 randconfig-a011-20210724
i386                 randconfig-a015-20210724
i386                 randconfig-a016-20210725
i386                 randconfig-a013-20210725
i386                 randconfig-a012-20210725
i386                 randconfig-a014-20210725
i386                 randconfig-a011-20210725
i386                 randconfig-a015-20210725
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-c001-20210723
x86_64               randconfig-c001-20210725
x86_64               randconfig-c001-20210724
x86_64               randconfig-a003-20210723
x86_64               randconfig-a006-20210723
x86_64               randconfig-a001-20210723
x86_64               randconfig-a005-20210723
x86_64               randconfig-a004-20210723
x86_64               randconfig-a002-20210723
x86_64               randconfig-a011-20210724
x86_64               randconfig-a016-20210724
x86_64               randconfig-a013-20210724
x86_64               randconfig-a014-20210724
x86_64               randconfig-a012-20210724
x86_64               randconfig-a015-20210724

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
