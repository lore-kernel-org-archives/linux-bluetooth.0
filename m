Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E0E8C7EE26
	for <linux-bluetooth@archiver.kernel.org>; Tue, 23 May 2023 12:12:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231621AbjEWMMR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 23 May 2023 08:12:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbjEWMMP (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 23 May 2023 08:12:15 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEC90118
        for <linux-bluetooth@vger.kernel.org>; Tue, 23 May 2023 05:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684843934; x=1716379934;
  h=date:from:to:cc:subject:message-id;
  bh=0zGKPVH9gD1K1wK3MPBk4rsYInCrB6jipQaBiGuvYo4=;
  b=DKutEfxVZPUGIAgCLMCZc4I4RLrcG/K4sM6dT8bvVUeW1LTBm2dlx6zy
   6ejBGBnjWZv5rnU6lwk+4TXL9sH9myJpY6ww+DPlrF77W6GOh3JTni+RK
   MTwUlpB6kpKPCJSn53XlgThHacvt18lxtOtzyzmIzBq7K57Gu85PbDuWu
   QZB9WbTcrsT3BHMj7dMbuMBLJoa1325DweO1zRuMs6unxa8xSmhQdo0sO
   LkWR33axGXCvuo9pa+6+JFyN7KYdsLaYG/1YBuq14zQOU86Vf2xJepixT
   GAiNQnpH7x5jtWjQz2cwsmJIasaqlFIvBbP0ekZcoLFGSb+OAUmPR+x4p
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10718"; a="350727282"
X-IronPort-AV: E=Sophos;i="6.00,186,1681196400"; 
   d="scan'208";a="350727282"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2023 05:12:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10718"; a="703909484"
X-IronPort-AV: E=Sophos;i="6.00,186,1681196400"; 
   d="scan'208";a="703909484"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 23 May 2023 05:12:12 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q1Qs8-000Dji-08;
        Tue, 23 May 2023 12:12:12 +0000
Date:   Tue, 23 May 2023 20:11:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc:     linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 fb576dc482524416a830398d86b60f0100236a00
Message-ID: <20230523121159.XvRQ1%lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

tree/branch: INFO setup_repo_specs: /db/releases/20230523172912/lkp-src/repo/*/bluetooth-next
https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: fb576dc482524416a830398d86b60f0100236a00  Bluetooth: ISO: Fix CIG auto-allocation to select configurable CIG

elapsed time: 729m

configs tested: 155
configs skipped: 8

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha        buildonly-randconfig-r005-20230521   gcc  
alpha        buildonly-randconfig-r006-20230522   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r004-20230522   gcc  
arc                              allyesconfig   gcc  
arc          buildonly-randconfig-r003-20230521   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r012-20230521   gcc  
arc                  randconfig-r012-20230522   gcc  
arc                  randconfig-r043-20230521   gcc  
arc                  randconfig-r043-20230522   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm          buildonly-randconfig-r004-20230521   clang
arm                                 defconfig   gcc  
arm                  randconfig-r046-20230521   clang
arm                  randconfig-r046-20230522   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r004-20230521   clang
arm64                randconfig-r014-20230521   gcc  
arm64                randconfig-r033-20230521   clang
csky                                defconfig   gcc  
csky                 randconfig-r002-20230521   gcc  
csky                 randconfig-r031-20230521   gcc  
csky                 randconfig-r031-20230522   gcc  
csky                 randconfig-r032-20230522   gcc  
hexagon              randconfig-r005-20230521   clang
hexagon              randconfig-r014-20230522   clang
hexagon              randconfig-r015-20230522   clang
hexagon              randconfig-r025-20230522   clang
hexagon              randconfig-r032-20230521   clang
hexagon              randconfig-r041-20230521   clang
hexagon              randconfig-r041-20230522   clang
hexagon              randconfig-r045-20230521   clang
hexagon              randconfig-r045-20230522   clang
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-a001-20230522   gcc  
i386                 randconfig-a002-20230522   gcc  
i386                 randconfig-a003-20230522   gcc  
i386                 randconfig-a004-20230522   gcc  
i386                 randconfig-a006-20230522   gcc  
i386                 randconfig-r011-20230522   clang
i386                 randconfig-r033-20230522   gcc  
ia64                             allmodconfig   gcc  
ia64         buildonly-randconfig-r001-20230522   gcc  
ia64         buildonly-randconfig-r002-20230521   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r003-20230522   gcc  
ia64                 randconfig-r016-20230522   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch    buildonly-randconfig-r002-20230522   gcc  
loongarch                           defconfig   gcc  
m68k                             alldefconfig   gcc  
m68k                             allmodconfig   gcc  
m68k                       bvme6000_defconfig   gcc  
m68k                                defconfig   gcc  
m68k                       m5249evb_defconfig   gcc  
m68k                 randconfig-r036-20230522   gcc  
microblaze   buildonly-randconfig-r005-20230522   gcc  
microblaze   buildonly-randconfig-r006-20230521   gcc  
microblaze           randconfig-r006-20230522   gcc  
microblaze           randconfig-r016-20230521   gcc  
microblaze           randconfig-r024-20230522   gcc  
microblaze           randconfig-r036-20230521   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                        bcm47xx_defconfig   gcc  
mips                            gpr_defconfig   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r003-20230521   gcc  
nios2                randconfig-r006-20230521   gcc  
nios2                randconfig-r013-20230521   gcc  
nios2                randconfig-r015-20230521   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                 mpc8560_ads_defconfig   clang
powerpc                      ppc40x_defconfig   gcc  
powerpc              randconfig-r023-20230522   clang
powerpc              randconfig-r034-20230521   clang
powerpc                     tqm8548_defconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r001-20230521   clang
riscv                randconfig-r002-20230522   gcc  
riscv                randconfig-r011-20230521   gcc  
riscv                randconfig-r042-20230521   gcc  
riscv                randconfig-r042-20230522   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r022-20230522   clang
s390                 randconfig-r044-20230521   gcc  
s390                 randconfig-r044-20230522   clang
sh                               allmodconfig   gcc  
sh                          polaris_defconfig   gcc  
sh                   randconfig-r026-20230522   gcc  
sh                   randconfig-r035-20230522   gcc  
sh                          sdk7786_defconfig   gcc  
sh                           sh2007_defconfig   gcc  
sparc        buildonly-randconfig-r004-20230522   gcc  
sparc                               defconfig   gcc  
sparc64      buildonly-randconfig-r003-20230522   gcc  
sparc64              randconfig-r005-20230522   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a001-20230522   gcc  
x86_64               randconfig-a002-20230522   gcc  
x86_64               randconfig-a003-20230522   gcc  
x86_64               randconfig-a004-20230522   gcc  
x86_64               randconfig-a005-20230522   gcc  
x86_64               randconfig-a006-20230522   gcc  
x86_64               randconfig-a011-20230522   clang
x86_64               randconfig-a012-20230522   clang
x86_64               randconfig-a013-20230522   clang
x86_64               randconfig-a014-20230522   clang
x86_64               randconfig-a015-20230522   clang
x86_64               randconfig-a016-20230522   clang
x86_64                        randconfig-x051   gcc  
x86_64                        randconfig-x052   clang
x86_64                        randconfig-x053   gcc  
x86_64                        randconfig-x054   clang
x86_64                        randconfig-x055   gcc  
x86_64                        randconfig-x056   clang
x86_64               randconfig-x061-20230522   clang
x86_64               randconfig-x062-20230522   clang
x86_64               randconfig-x063-20230522   clang
x86_64               randconfig-x064-20230522   clang
x86_64               randconfig-x065-20230522   clang
x86_64               randconfig-x066-20230522   clang
x86_64               randconfig-x071-20230522   gcc  
x86_64               randconfig-x072-20230522   gcc  
x86_64               randconfig-x073-20230522   gcc  
x86_64               randconfig-x074-20230522   gcc  
x86_64               randconfig-x075-20230522   gcc  
x86_64               randconfig-x076-20230522   gcc  
x86_64               randconfig-x081-20230522   gcc  
x86_64               randconfig-x082-20230522   gcc  
x86_64               randconfig-x083-20230522   gcc  
x86_64               randconfig-x084-20230522   gcc  
x86_64               randconfig-x085-20230522   gcc  
x86_64               randconfig-x086-20230522   gcc  
x86_64                               rhel-8.3   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
