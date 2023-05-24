Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9253FC7EE31
	for <linux-bluetooth@archiver.kernel.org>; Wed, 24 May 2023 06:53:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231889AbjEXGxI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 24 May 2023 02:53:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239812AbjEXGwY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 24 May 2023 02:52:24 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1FA2B3
        for <linux-bluetooth@vger.kernel.org>; Tue, 23 May 2023 23:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684911112; x=1716447112;
  h=date:from:to:cc:subject:message-id;
  bh=nj5NWF5A/6fCoNBDZOAvue9DGMRl5IWDJ9GMnhtj9to=;
  b=lEVEdp5xcSSPZLd5NBa2gykK7RLzyrXqJ1zawpEDaGaWnCkPBVMHPJEg
   2VQVzJ79AWDLBQ13qFco4/A5h4LG2v7FrcZADP6ifIwUy0LAG8FfClaHL
   r40Zr2wDtMqLrO9EdiLnqNr3WyppV4Y/EH1kaHWbkaQS6cpzz4Z79OiPG
   2WThyDQhWlh61sqvTEtqUCG25IfogHsZEej3oYq5d6jv8O+pzr5bE/b7s
   NhFZ193esvmnLpwmZrDVPyydFQ4H0pc41eiM+ovXDwKFI6u+otwDzDuQI
   FJboZVEvPIGfh7Rj+QNRiy3txvMZC6cLy6HXTX0InhRCQB11nE/wp1hMB
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10719"; a="355834246"
X-IronPort-AV: E=Sophos;i="6.00,188,1681196400"; 
   d="scan'208";a="355834246"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2023 23:51:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10719"; a="707377049"
X-IronPort-AV: E=Sophos;i="6.00,188,1681196400"; 
   d="scan'208";a="707377049"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 23 May 2023 23:51:51 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q1iLe-000EVN-0q;
        Wed, 24 May 2023 06:51:50 +0000
Date:   Wed, 24 May 2023 14:51:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc:     linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 ab93c2a3445889c311a40a82601cf304869a893b
Message-ID: <20230524065142.4PB2e%lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

tree/branch: INFO setup_repo_specs: /db/releases/20230524121217/lkp-src/repo/*/bluetooth-next
https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: ab93c2a3445889c311a40a82601cf304869a893b  Bluetooth: btrtl: Add Realtek devcoredump support

elapsed time: 722m

configs tested: 203
configs skipped: 16

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha        buildonly-randconfig-r002-20230522   gcc  
alpha        buildonly-randconfig-r004-20230521   gcc  
alpha        buildonly-randconfig-r006-20230521   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r002-20230522   gcc  
alpha                randconfig-r011-20230522   gcc  
alpha                randconfig-r013-20230521   gcc  
alpha                randconfig-r013-20230523   gcc  
alpha                randconfig-r014-20230523   gcc  
alpha                randconfig-r025-20230522   gcc  
alpha                randconfig-r033-20230521   gcc  
arc                              allyesconfig   gcc  
arc                          axs101_defconfig   gcc  
arc                                 defconfig   gcc  
arc                            hsdk_defconfig   gcc  
arc                        nsimosci_defconfig   gcc  
arc                  randconfig-r015-20230521   gcc  
arc                  randconfig-r043-20230521   gcc  
arc                  randconfig-r043-20230522   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                       imx_v6_v7_defconfig   gcc  
arm                  randconfig-r032-20230522   clang
arm                  randconfig-r046-20230521   clang
arm                  randconfig-r046-20230522   gcc  
arm64                            allyesconfig   gcc  
arm64        buildonly-randconfig-r005-20230522   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r001-20230521   clang
arm64                randconfig-r011-20230523   gcc  
arm64                randconfig-r016-20230522   clang
arm64                randconfig-r035-20230521   clang
csky                                defconfig   gcc  
csky                 randconfig-r012-20230521   gcc  
csky                 randconfig-r022-20230522   gcc  
csky                 randconfig-r023-20230522   gcc  
csky                 randconfig-r026-20230521   gcc  
hexagon      buildonly-randconfig-r002-20230521   clang
hexagon              randconfig-r036-20230521   clang
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
i386                 randconfig-a005-20230522   gcc  
i386                 randconfig-a006-20230522   gcc  
i386                 randconfig-a011-20230522   clang
i386                 randconfig-a012-20230522   clang
i386                 randconfig-a013-20230522   clang
i386                 randconfig-a014-20230522   clang
i386                 randconfig-a015-20230522   clang
i386                 randconfig-a016-20230522   clang
i386                 randconfig-i051-20230524   gcc  
i386                 randconfig-i052-20230524   gcc  
i386                 randconfig-i053-20230524   gcc  
i386                 randconfig-i054-20230524   gcc  
i386                 randconfig-i055-20230524   gcc  
i386                 randconfig-i056-20230524   gcc  
i386                 randconfig-i061-20230523   clang
i386                 randconfig-i062-20230523   clang
i386                 randconfig-i063-20230523   clang
i386                 randconfig-i064-20230523   clang
i386                 randconfig-i065-20230523   clang
i386                 randconfig-i066-20230523   clang
ia64                             allmodconfig   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r002-20230523   gcc  
ia64                 randconfig-r015-20230523   gcc  
ia64                 randconfig-r016-20230521   gcc  
ia64                 randconfig-r023-20230521   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r005-20230521   gcc  
loongarch            randconfig-r005-20230522   gcc  
loongarch            randconfig-r012-20230522   gcc  
loongarch            randconfig-r012-20230523   gcc  
loongarch            randconfig-r022-20230521   gcc  
m68k                             allmodconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r014-20230522   gcc  
m68k                 randconfig-r024-20230522   gcc  
microblaze   buildonly-randconfig-r001-20230522   gcc  
microblaze           randconfig-r004-20230521   gcc  
microblaze           randconfig-r032-20230521   gcc  
microblaze           randconfig-r034-20230521   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips         buildonly-randconfig-r004-20230522   clang
mips                 randconfig-r004-20230522   clang
nios2        buildonly-randconfig-r003-20230522   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r001-20230522   gcc  
nios2                randconfig-r021-20230522   gcc  
nios2                randconfig-r025-20230521   gcc  
openrisc             randconfig-r015-20230522   gcc  
parisc       buildonly-randconfig-r001-20230521   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r036-20230522   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                      chrp32_defconfig   gcc  
powerpc              randconfig-r006-20230521   clang
powerpc              randconfig-r022-20230521   gcc  
powerpc              randconfig-r031-20230521   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r006-20230522   gcc  
riscv                randconfig-r024-20230522   clang
riscv                randconfig-r035-20230521   clang
riscv                randconfig-r042-20230521   gcc  
riscv                randconfig-r042-20230522   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r006-20230523   clang
s390                 randconfig-r011-20230521   gcc  
s390                 randconfig-r013-20230521   gcc  
s390                 randconfig-r021-20230521   gcc  
s390                 randconfig-r044-20230521   gcc  
s390                 randconfig-r044-20230522   clang
sh                               allmodconfig   gcc  
sh           buildonly-randconfig-r005-20230521   gcc  
sh                   randconfig-r015-20230521   gcc  
sh                           se7705_defconfig   gcc  
sh                     sh7710voipgw_defconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r015-20230522   gcc  
sparc                randconfig-r022-20230522   gcc  
sparc                randconfig-r023-20230522   gcc  
sparc                randconfig-r025-20230521   gcc  
sparc                randconfig-r033-20230522   gcc  
sparc64      buildonly-randconfig-r006-20230522   gcc  
sparc64              randconfig-r001-20230523   gcc  
sparc64              randconfig-r016-20230521   gcc  
sparc64              randconfig-r034-20230522   gcc  
sparc64              randconfig-r035-20230522   gcc  
um                                  defconfig   gcc  
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
x86_64               randconfig-r013-20230522   clang
x86_64               randconfig-x051-20230522   clang
x86_64               randconfig-x052-20230522   clang
x86_64               randconfig-x053-20230522   clang
x86_64               randconfig-x054-20230522   clang
x86_64               randconfig-x055-20230522   clang
x86_64               randconfig-x056-20230522   clang
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
x86_64                        randconfig-x081   gcc  
x86_64               randconfig-x082-20230522   gcc  
x86_64                        randconfig-x082   clang
x86_64               randconfig-x083-20230522   gcc  
x86_64                        randconfig-x083   gcc  
x86_64               randconfig-x084-20230522   gcc  
x86_64                        randconfig-x084   clang
x86_64               randconfig-x085-20230522   gcc  
x86_64                        randconfig-x085   gcc  
x86_64               randconfig-x086-20230522   gcc  
x86_64                        randconfig-x086   clang
x86_64                               rhel-8.3   gcc  
xtensa       buildonly-randconfig-r003-20230521   gcc  
xtensa               randconfig-r002-20230521   gcc  
xtensa               randconfig-r003-20230522   gcc  
xtensa               randconfig-r024-20230521   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
