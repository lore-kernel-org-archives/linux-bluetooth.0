Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 692ECC77B7A
	for <linux-bluetooth@archiver.kernel.org>; Sat,  3 Jun 2023 13:10:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbjFCNKh (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 3 Jun 2023 09:10:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjFCNKg (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 3 Jun 2023 09:10:36 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4426A180
        for <linux-bluetooth@vger.kernel.org>; Sat,  3 Jun 2023 06:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685797835; x=1717333835;
  h=date:from:to:cc:subject:message-id;
  bh=d1Y+zA/7rAxYNmKdQmiBXO0f7mwYQFSJFJDxLHBz+mQ=;
  b=TRqGhAdsEMa6fprwjJk054FDQwp5Y2AyU/g9yDPtFEfSgeXjudosCpwJ
   d7rPlhhXi4j3HrmW/GuPIdEEl1Ipr3mppS0JQYoBDrkaizv599NNBnOYj
   p0OF9cWLiGk7LiS8ZpBXEog0024t/ufS3CIb9KkCrsoyoEkYieHBnu9s0
   WDTTmSni0TWjwKPdkGMT+UuDEh/SZWp9z9i9sYhSej/DUn89c+/b8Bqqh
   DDQp2JPdcdqOIonqIlOWD6CeHA2lkgT7wnTeF58RL1CJYV8vOXrLzN5Yz
   JoVrdhdKDdgVGyu4oj5iCEP8InwatSkjghdzkxM3H22TJq+2dKZxXIwir
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10730"; a="345653778"
X-IronPort-AV: E=Sophos;i="6.00,216,1681196400"; 
   d="scan'208";a="345653778"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2023 06:10:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10730"; a="954808222"
X-IronPort-AV: E=Sophos;i="6.00,216,1681196400"; 
   d="scan'208";a="954808222"
Received: from lkp-server01.sh.intel.com (HELO 15ab08e44a81) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 03 Jun 2023 06:10:33 -0700
Received: from kbuild by 15ab08e44a81 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q5R1c-0001bp-26;
        Sat, 03 Jun 2023 13:10:32 +0000
Date:   Sat, 03 Jun 2023 21:09:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc:     linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 280ae657262de6ac451fca1b8052cf78d3963ea3
Message-ID: <20230603130942.21uOG%lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: 280ae657262de6ac451fca1b8052cf78d3963ea3  Bluetooth: hci_event: fix Set CIG Parameters error status handling

elapsed time: 722m

configs tested: 132
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r021-20230602   gcc  
arc                              allyesconfig   gcc  
arc                          axs101_defconfig   gcc  
arc          buildonly-randconfig-r005-20230602   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r006-20230602   gcc  
arc                  randconfig-r015-20230601   gcc  
arc                  randconfig-r043-20230531   gcc  
arc                           tb10x_defconfig   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                         bcm2835_defconfig   clang
arm                                 defconfig   gcc  
arm                  randconfig-r032-20230531   clang
arm                  randconfig-r046-20230531   gcc  
arm                           sunxi_defconfig   gcc  
arm64                            allyesconfig   gcc  
arm64        buildonly-randconfig-r001-20230602   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r025-20230602   clang
csky         buildonly-randconfig-r004-20230602   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r001-20230602   gcc  
hexagon              randconfig-r016-20230601   clang
hexagon              randconfig-r041-20230531   clang
hexagon              randconfig-r045-20230531   clang
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230531   gcc  
i386                 randconfig-i002-20230531   gcc  
i386                 randconfig-i003-20230531   gcc  
i386                 randconfig-i004-20230531   gcc  
i386                 randconfig-i005-20230531   gcc  
i386                 randconfig-i006-20230531   gcc  
i386                 randconfig-i051-20230602   gcc  
i386                 randconfig-i052-20230602   gcc  
i386                 randconfig-i053-20230602   gcc  
i386                 randconfig-i054-20230602   gcc  
i386                 randconfig-i055-20230602   gcc  
i386                 randconfig-i056-20230602   gcc  
i386                 randconfig-i061-20230531   gcc  
i386                 randconfig-i062-20230531   gcc  
i386                 randconfig-i063-20230531   gcc  
i386                 randconfig-i064-20230531   gcc  
i386                 randconfig-i065-20230531   gcc  
i386                 randconfig-i066-20230531   gcc  
i386                 randconfig-r012-20230601   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
m68k                             allmodconfig   gcc  
m68k                         amcore_defconfig   gcc  
m68k                          atari_defconfig   gcc  
m68k                                defconfig   gcc  
m68k                       m5249evb_defconfig   gcc  
m68k                        m5307c3_defconfig   gcc  
m68k                 randconfig-r034-20230531   gcc  
m68k                        stmark2_defconfig   gcc  
m68k                          sun3x_defconfig   gcc  
microblaze                      mmu_defconfig   gcc  
microblaze           randconfig-r013-20230601   gcc  
microblaze           randconfig-r023-20230602   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                          ath79_defconfig   clang
mips                           ci20_defconfig   gcc  
mips                     decstation_defconfig   gcc  
mips                       lemote2f_defconfig   clang
mips                 randconfig-r033-20230531   clang
nios2                            alldefconfig   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r004-20230602   gcc  
openrisc             randconfig-r011-20230601   gcc  
openrisc             randconfig-r031-20230531   gcc  
parisc       buildonly-randconfig-r006-20230602   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r022-20230602   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                    ge_imp3a_defconfig   clang
powerpc                   motionpro_defconfig   gcc  
powerpc                 mpc836x_rdk_defconfig   clang
powerpc                      pcm030_defconfig   gcc  
powerpc                      ppc44x_defconfig   clang
powerpc                      ppc6xx_defconfig   gcc  
powerpc                     tqm8560_defconfig   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r005-20230602   gcc  
riscv                randconfig-r042-20230531   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r002-20230602   gcc  
s390                 randconfig-r044-20230531   clang
sh                               allmodconfig   gcc  
sh           buildonly-randconfig-r002-20230602   gcc  
sh                        edosk7760_defconfig   gcc  
sh                             espt_defconfig   gcc  
sh                            hp6xx_defconfig   gcc  
sh                 kfr2r09-romimage_defconfig   gcc  
sh                            migor_defconfig   gcc  
sh                          rsk7264_defconfig   gcc  
sh                          rsk7269_defconfig   gcc  
sh                           se7722_defconfig   gcc  
sh                             sh03_defconfig   gcc  
sh                          urquell_defconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r026-20230602   gcc  
sparc                randconfig-r036-20230531   gcc  
sparc64              randconfig-r024-20230602   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a001-20230531   gcc  
x86_64               randconfig-a002-20230531   gcc  
x86_64               randconfig-a003-20230531   gcc  
x86_64               randconfig-a004-20230531   gcc  
x86_64               randconfig-a005-20230531   gcc  
x86_64               randconfig-a006-20230531   gcc  
x86_64               randconfig-r003-20230602   gcc  
x86_64                               rhel-8.3   gcc  
xtensa       buildonly-randconfig-r003-20230602   gcc  
xtensa                    xip_kc705_defconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
