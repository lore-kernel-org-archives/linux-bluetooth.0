Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C12EC433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu,  3 Feb 2022 03:27:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346775AbiBCD1l (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 2 Feb 2022 22:27:41 -0500
Received: from mga12.intel.com ([192.55.52.136]:46737 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231626AbiBCD1l (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 2 Feb 2022 22:27:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643858861; x=1675394861;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=qy12Bf0gQ1OH2ECw2P9GQM/tEYmgu61+ixrhopyFWNM=;
  b=DM+YwInpUNZHtnlp81pZYWvQkfqhcexhrlevGjU1wRFBA9eY5yH56v5G
   UoND/CIVcoMaT0eiAidrd2tU1K+39afhAdID78S/Yipl3necVziaVwaYw
   DraPg7vJRKXrr4QDVSpB5ZjnlJ//vHaB6kaa+6gwAaNPsMunUsdhB36s0
   ECjgLJQUo1Uqqyjshp6orXLsBXOJ0ZXrotBnCW12oX+CGRJR7AdzkrxFY
   yDt39IAOTi1+MbQi3bLmA2ndpzxg3ZUVJmKmQ1BUFNsfUebvqT6rYNIbl
   vHsAiaK0hUu6+qELRT0ROLORG5fsC+/FywCG3jMvWXiIyHvZihPYmg8nA
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10246"; a="228036907"
X-IronPort-AV: E=Sophos;i="5.88,338,1635231600"; 
   d="scan'208";a="228036907"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2022 19:27:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,338,1635231600"; 
   d="scan'208";a="583661698"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 02 Feb 2022 19:27:40 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nFSmZ-000VVG-Mc; Thu, 03 Feb 2022 03:27:39 +0000
Date:   Thu, 03 Feb 2022 11:27:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 a5dc88794406e8e900d4aedddf9818d5d59d3aac
Message-ID: <61fb4b8e.lOYm+29445dRyWlm%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: a5dc88794406e8e900d4aedddf9818d5d59d3aac  Bluetooth: btusb: Add support for Intel Madison Peak (MsP2) device

elapsed time: 725m

configs tested: 145
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20220131
powerpc              randconfig-c003-20220131
i386                          randconfig-c001
mips                  maltasmvp_eva_defconfig
m68k                          sun3x_defconfig
arm                          iop32x_defconfig
arm                        clps711x_defconfig
sh                           se7724_defconfig
sh                         apsh4a3a_defconfig
arm64                            alldefconfig
mips                           ip32_defconfig
arm                            zeus_defconfig
powerpc                     asp8347_defconfig
csky                             alldefconfig
mips                        vocore2_defconfig
sh                               alldefconfig
parisc                generic-32bit_defconfig
arc                           tb10x_defconfig
powerpc                      ppc40x_defconfig
powerpc                mpc7448_hpc2_defconfig
arc                        nsimosci_defconfig
openrisc                  or1klitex_defconfig
arm                           viper_defconfig
mips                       capcella_defconfig
powerpc                       ppc64_defconfig
arm                         vf610m4_defconfig
mips                          rb532_defconfig
mips                  decstation_64_defconfig
powerpc                       holly_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                        sh7785lcr_defconfig
mips                           gcw0_defconfig
powerpc                      ppc6xx_defconfig
powerpc                     taishan_defconfig
sh                     sh7710voipgw_defconfig
arm                           corgi_defconfig
sh                          r7785rp_defconfig
ia64                          tiger_defconfig
microblaze                      mmu_defconfig
arm                  randconfig-c002-20220130
arm                  randconfig-c002-20220131
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
s390                             allyesconfig
i386                             allyesconfig
sparc                               defconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
sparc                            allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a004-20220131
x86_64               randconfig-a003-20220131
x86_64               randconfig-a001-20220131
x86_64               randconfig-a006-20220131
x86_64               randconfig-a005-20220131
x86_64               randconfig-a002-20220131
i386                 randconfig-a006-20220131
i386                 randconfig-a005-20220131
i386                 randconfig-a003-20220131
i386                 randconfig-a002-20220131
i386                 randconfig-a001-20220131
i386                 randconfig-a004-20220131
arc                  randconfig-r043-20220130
arc                  randconfig-r043-20220131
riscv                randconfig-r042-20220130
s390                 randconfig-r044-20220130
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec
x86_64                          rhel-8.3-func

clang tested configs:
riscv                randconfig-c006-20220130
x86_64                        randconfig-c007
arm                  randconfig-c002-20220130
powerpc              randconfig-c003-20220130
mips                 randconfig-c004-20220130
i386                          randconfig-c001
riscv                randconfig-c006-20220201
powerpc              randconfig-c003-20220201
mips                 randconfig-c004-20220201
arm                  randconfig-c002-20220201
arm                         hackkit_defconfig
arm                           spitz_defconfig
powerpc                 mpc836x_rdk_defconfig
arm                         shannon_defconfig
powerpc                        icon_defconfig
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64               randconfig-a013-20220131
x86_64               randconfig-a015-20220131
x86_64               randconfig-a014-20220131
x86_64               randconfig-a016-20220131
x86_64               randconfig-a011-20220131
x86_64               randconfig-a012-20220131
i386                 randconfig-a011-20220131
i386                 randconfig-a013-20220131
i386                 randconfig-a014-20220131
i386                 randconfig-a012-20220131
i386                 randconfig-a015-20220131
i386                 randconfig-a016-20220131
hexagon              randconfig-r045-20220130
hexagon              randconfig-r045-20220131
hexagon              randconfig-r041-20220130
hexagon              randconfig-r041-20220131
riscv                randconfig-r042-20220131
s390                 randconfig-r044-20220131

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
