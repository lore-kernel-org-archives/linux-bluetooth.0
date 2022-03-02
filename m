Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8093BC43217
	for <linux-bluetooth@archiver.kernel.org>; Wed,  2 Mar 2022 04:57:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234367AbiCBE60 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 1 Mar 2022 23:58:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233841AbiCBE60 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 1 Mar 2022 23:58:26 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27B532D1E2
        for <linux-bluetooth@vger.kernel.org>; Tue,  1 Mar 2022 20:57:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646197063; x=1677733063;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=oac9i9snsjvwGQZNlC8TzcDuHRw2LoLRRM0/J7AoWSU=;
  b=cqvGJqGJFv+Y1LbDzCylAsEIkcZLo65TuVpWffGY/dv8fxSv87qH6vp4
   Dd3bs3O4Zg9gHZwWefjIZIiSLoeJtBA1y17xcW2l1uZm5kXpQ9Y7ZJ8mI
   CPnDNau2OK973t4LMZrK9WC+tuJqKT7rDtg01b3zcLDZaf7uzuhwRr93e
   gpdPKX/nPp1iMC9ksx1hyOgQPzKDQ5PlAbCOxfNX5JIFKiTK9Q4Cmn4L/
   RcLAEsPpdEDSIE74tXWb/O/GAtGgeOB67211HgziIGgnJdD0RWTZwonB6
   ijLMEsoq2v+hP9t97DwvM2E1NibZi9trredniErY2NFK16EZljOAoni7E
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10273"; a="253506135"
X-IronPort-AV: E=Sophos;i="5.90,148,1643702400"; 
   d="scan'208";a="253506135"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2022 20:57:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,148,1643702400"; 
   d="scan'208";a="709365668"
Received: from lkp-server02.sh.intel.com (HELO e9605edfa585) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 01 Mar 2022 20:57:41 -0800
Received: from kbuild by e9605edfa585 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nPH3U-00014t-LU; Wed, 02 Mar 2022 04:57:40 +0000
Date:   Wed, 02 Mar 2022 12:57:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 8c9fa1be6896314a67fdf87ee160551a892d6d51
Message-ID: <621ef921.pQ1Ud6bIc3ngX6xp%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: 8c9fa1be6896314a67fdf87ee160551a892d6d51  Bluetooth: mediatek: fix the conflict between mtk and msft vendor event

elapsed time: 720m

configs tested: 128
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                          randconfig-c001
powerpc                         ps3_defconfig
arm                       multi_v4t_defconfig
arc                                 defconfig
openrisc                  or1klitex_defconfig
ia64                            zx1_defconfig
arm                     eseries_pxa_defconfig
powerpc                      mgcoge_defconfig
arc                    vdk_hs38_smp_defconfig
mips                        vocore2_defconfig
powerpc                      tqm8xx_defconfig
arm                         nhk8815_defconfig
powerpc                mpc7448_hpc2_defconfig
xtensa                              defconfig
arm                        oxnas_v6_defconfig
sh                          polaris_defconfig
sh                          urquell_defconfig
arm                          gemini_defconfig
sh                        sh7757lcr_defconfig
mips                            ar7_defconfig
powerpc                      arches_defconfig
powerpc                        warp_defconfig
mips                           ip32_defconfig
sh                            hp6xx_defconfig
arm                            zeus_defconfig
arm                         assabet_defconfig
sh                           se7343_defconfig
mips                  decstation_64_defconfig
sh                            migor_defconfig
m68k                        stmark2_defconfig
arm                       imx_v6_v7_defconfig
arc                           tb10x_defconfig
microblaze                          defconfig
m68k                          multi_defconfig
arm                         axm55xx_defconfig
sh                         ecovec24_defconfig
sh                           se7780_defconfig
arm                  randconfig-c002-20220301
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
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc64                            defconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
arc                  randconfig-r043-20220301
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
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                                  kexec

clang tested configs:
x86_64                        randconfig-c007
powerpc              randconfig-c003-20220301
riscv                randconfig-c006-20220301
i386                          randconfig-c001
arm                  randconfig-c002-20220301
mips                 randconfig-c004-20220301
powerpc                     mpc5200_defconfig
arm                                 defconfig
powerpc                  mpc866_ads_defconfig
arm                          imote2_defconfig
mips                     cu1830-neo_defconfig
mips                      pic32mzda_defconfig
mips                           rs90_defconfig
powerpc                      walnut_defconfig
riscv                    nommu_virt_defconfig
arm                         bcm2835_defconfig
arm                         palmz72_defconfig
arm                         orion5x_defconfig
arm                        spear3xx_defconfig
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
hexagon              randconfig-r045-20220301
hexagon              randconfig-r041-20220301
riscv                randconfig-r042-20220301
s390                 randconfig-r044-20220301

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
