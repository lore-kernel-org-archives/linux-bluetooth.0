Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF13BC433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu, 21 Oct 2021 05:52:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94E7760E9B
	for <linux-bluetooth@archiver.kernel.org>; Thu, 21 Oct 2021 05:52:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbhJUFye (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 21 Oct 2021 01:54:34 -0400
Received: from mga06.intel.com ([134.134.136.31]:25362 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229499AbhJUFyd (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 21 Oct 2021 01:54:33 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10143"; a="289794252"
X-IronPort-AV: E=Sophos;i="5.87,168,1631602800"; 
   d="scan'208";a="289794252"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2021 22:52:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,168,1631602800"; 
   d="scan'208";a="444653646"
Received: from lkp-server02.sh.intel.com (HELO 08b2c502c3de) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 20 Oct 2021 22:52:16 -0700
Received: from kbuild by 08b2c502c3de with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mdQzw-000E3b-75; Thu, 21 Oct 2021 05:52:16 +0000
Date:   Thu, 21 Oct 2021 13:52:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 7a517ac9c00bab519770c0790b47845b8f5ecebb
Message-ID: <6171000e.aAb8X3Bv3HATlzoC%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: 7a517ac9c00bab519770c0790b47845b8f5ecebb  Bluetooth: btsdio: Do not bind to non-removable BCM4345 and BCM43455

elapsed time: 990m

configs tested: 152
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allmodconfig
arm                              allyesconfig
i386                 randconfig-c001-20211019
powerpc                    amigaone_defconfig
mips                        maltaup_defconfig
arm                      pxa255-idp_defconfig
arm                            hisi_defconfig
s390                             alldefconfig
sh                           se7780_defconfig
powerpc                     mpc5200_defconfig
m68k                        mvme16x_defconfig
openrisc                            defconfig
h8300                     edosk2674_defconfig
powerpc                 mpc834x_itx_defconfig
mips                     decstation_defconfig
arm                         shannon_defconfig
csky                             alldefconfig
m68k                          sun3x_defconfig
powerpc                      ppc40x_defconfig
sh                             shx3_defconfig
sh                             espt_defconfig
arc                           tb10x_defconfig
arm                         palmz72_defconfig
arm                             ezx_defconfig
h8300                            alldefconfig
sh                            hp6xx_defconfig
nds32                             allnoconfig
arm                         s3c6400_defconfig
powerpc                   lite5200b_defconfig
sh                           se7712_defconfig
arm                        vexpress_defconfig
sh                 kfr2r09-romimage_defconfig
sh                          kfr2r09_defconfig
powerpc                     sequoia_defconfig
arm                          exynos_defconfig
arm                         orion5x_defconfig
mips                         rt305x_defconfig
mips                        workpad_defconfig
arm                          gemini_defconfig
arm                             mxs_defconfig
arm                        mini2440_defconfig
mips                      maltasmvp_defconfig
mips                             allyesconfig
arm                            mps2_defconfig
powerpc                     ppa8548_defconfig
mips                           gcw0_defconfig
mips                       rbtx49xx_defconfig
mips                          ath25_defconfig
xtensa                  nommu_kc705_defconfig
arm                  randconfig-c002-20211019
x86_64               randconfig-c001-20211019
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                                defconfig
m68k                             allmodconfig
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
s390                             allyesconfig
parisc                           allyesconfig
parisc                              defconfig
s390                             allmodconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
i386                              debian-10.3
arc                              allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a004-20211020
i386                 randconfig-a003-20211020
i386                 randconfig-a002-20211020
i386                 randconfig-a005-20211020
i386                 randconfig-a006-20211020
i386                 randconfig-a001-20211020
x86_64               randconfig-a015-20211019
x86_64               randconfig-a012-20211019
x86_64               randconfig-a016-20211019
x86_64               randconfig-a014-20211019
x86_64               randconfig-a013-20211019
x86_64               randconfig-a011-20211019
i386                 randconfig-a014-20211019
i386                 randconfig-a016-20211019
i386                 randconfig-a011-20211019
i386                 randconfig-a015-20211019
i386                 randconfig-a012-20211019
i386                 randconfig-a013-20211019
i386                 randconfig-a012-20211021
i386                 randconfig-a013-20211021
i386                 randconfig-a011-20211021
i386                 randconfig-a016-20211021
i386                 randconfig-a015-20211021
i386                 randconfig-a014-20211021
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
arm                  randconfig-c002-20211019
mips                 randconfig-c004-20211019
i386                 randconfig-c001-20211019
s390                 randconfig-c005-20211019
x86_64               randconfig-c007-20211019
riscv                randconfig-c006-20211019
powerpc              randconfig-c003-20211019
x86_64               randconfig-a004-20211019
x86_64               randconfig-a006-20211019
x86_64               randconfig-a005-20211019
x86_64               randconfig-a001-20211019
x86_64               randconfig-a002-20211019
x86_64               randconfig-a003-20211019
i386                 randconfig-a001-20211019
i386                 randconfig-a003-20211019
i386                 randconfig-a004-20211019
i386                 randconfig-a005-20211019
i386                 randconfig-a002-20211019
i386                 randconfig-a006-20211019
x86_64               randconfig-a013-20211020
x86_64               randconfig-a015-20211020
x86_64               randconfig-a011-20211020
x86_64               randconfig-a014-20211020
x86_64               randconfig-a016-20211020
x86_64               randconfig-a012-20211020
hexagon              randconfig-r041-20211019
hexagon              randconfig-r045-20211019
riscv                randconfig-r042-20211020
s390                 randconfig-r044-20211020
hexagon              randconfig-r045-20211020
hexagon              randconfig-r041-20211020

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
