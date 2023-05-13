Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74E76C77B7C
	for <linux-bluetooth@archiver.kernel.org>; Sat, 13 May 2023 09:28:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237788AbjEMJ2M (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 13 May 2023 05:28:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232192AbjEMJ2L (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 13 May 2023 05:28:11 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEF2910D9
        for <linux-bluetooth@vger.kernel.org>; Sat, 13 May 2023 02:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683970089; x=1715506089;
  h=date:from:to:cc:subject:message-id;
  bh=NiEQepGXxw1/pdXeJHLskKyvUbE20G+0oG1C711dKJQ=;
  b=I5bY/VxZ2dLEJ8ApIb0ky5jyQBGVe2QKOR/57ThBLMiJIG/+eTC3QWIR
   3q7KRHwjrFg7KZvm/USM2mzoKajAuRTldqG97q/5h2q4C/369TZhQb2ne
   EWQviDQjD4qbm6IXVsCOnOnugxe66ENcZ8KYAyjmBUZTYPk92cQQ0t9Rl
   qn8fOtFg9Wh27SbFt3l/a2SmSaeNLXchlbaceOh/Y2qHipNCtLOzVpcpy
   CLbh8POEvlgd5Yn9ZnMWn+pKUudVNslBOO4KncMpW45Grzi0zv1VOf8YD
   DC1T5isTsQP6q1SsXYdQuJZQ7G2XYsC7oT03yEJew6JtRfVTEOiBEkuz4
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10708"; a="340276190"
X-IronPort-AV: E=Sophos;i="5.99,272,1677571200"; 
   d="scan'208";a="340276190"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2023 02:28:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10708"; a="874642383"
X-IronPort-AV: E=Sophos;i="5.99,272,1677571200"; 
   d="scan'208";a="874642383"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 13 May 2023 02:28:08 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pxlXr-0005Qf-36;
        Sat, 13 May 2023 09:28:07 +0000
Date:   Sat, 13 May 2023 17:27:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc:     linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 376b10586124d26a903f09a77f027848aa6a71cc
Message-ID: <20230513092735.3G0xU%lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: 376b10586124d26a903f09a77f027848aa6a71cc  Bluetooth: btusb: Add device 6655:8771 to device tables

elapsed time: 724m

configs tested: 161
configs skipped: 10

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r006-20230511   gcc  
alpha                randconfig-r016-20230509   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r005-20230509   gcc  
arc                  randconfig-r015-20230509   gcc  
arc                  randconfig-r022-20230509   gcc  
arc                  randconfig-r031-20230509   gcc  
arc                  randconfig-r043-20230509   gcc  
arc                  randconfig-r043-20230511   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                            hisi_defconfig   gcc  
arm                      integrator_defconfig   gcc  
arm                            qcom_defconfig   gcc  
arm                  randconfig-r021-20230511   clang
arm                  randconfig-r023-20230511   clang
arm                  randconfig-r025-20230509   gcc  
arm                  randconfig-r025-20230511   clang
arm                  randconfig-r033-20230509   clang
arm                  randconfig-r046-20230509   gcc  
arm                  randconfig-r046-20230511   clang
arm                        spear6xx_defconfig   gcc  
arm                         wpcm450_defconfig   gcc  
arm64                            allyesconfig   gcc  
arm64        buildonly-randconfig-r005-20230511   clang
arm64        buildonly-randconfig-r006-20230511   clang
arm64                               defconfig   gcc  
arm64                randconfig-r032-20230511   clang
arm64                randconfig-r035-20230511   clang
csky                                defconfig   gcc  
csky                 randconfig-r024-20230509   gcc  
csky                 randconfig-r032-20230509   gcc  
hexagon              randconfig-r002-20230511   clang
hexagon              randconfig-r003-20230509   clang
hexagon              randconfig-r004-20230509   clang
hexagon              randconfig-r041-20230509   clang
hexagon              randconfig-r041-20230511   clang
hexagon              randconfig-r045-20230509   clang
hexagon              randconfig-r045-20230511   clang
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                          randconfig-a001   gcc  
i386                          randconfig-a002   clang
i386                          randconfig-a003   gcc  
i386                          randconfig-a004   clang
i386                          randconfig-a005   gcc  
i386                          randconfig-a006   clang
i386                          randconfig-a011   clang
i386                          randconfig-a012   gcc  
i386                          randconfig-a013   clang
i386                          randconfig-a014   gcc  
i386                          randconfig-a015   clang
i386                          randconfig-a016   gcc  
ia64                             allmodconfig   gcc  
ia64         buildonly-randconfig-r005-20230509   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r003-20230511   gcc  
ia64                 randconfig-r013-20230511   gcc  
ia64                 randconfig-r035-20230509   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r002-20230512   gcc  
m68k                             allmodconfig   gcc  
m68k                         apollo_defconfig   gcc  
m68k         buildonly-randconfig-r003-20230511   gcc  
m68k                                defconfig   gcc  
m68k                       m5249evb_defconfig   gcc  
m68k                 randconfig-r011-20230509   gcc  
m68k                 randconfig-r016-20230511   gcc  
microblaze   buildonly-randconfig-r001-20230511   gcc  
microblaze           randconfig-r001-20230511   gcc  
microblaze           randconfig-r006-20230509   gcc  
microblaze           randconfig-r036-20230509   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                 randconfig-r003-20230512   clang
nios2                               defconfig   gcc  
nios2                randconfig-r012-20230509   gcc  
openrisc             randconfig-r002-20230509   gcc  
openrisc             randconfig-r011-20230511   gcc  
openrisc             randconfig-r013-20230511   gcc  
openrisc             randconfig-r024-20230511   gcc  
openrisc             randconfig-r031-20230511   gcc  
parisc       buildonly-randconfig-r002-20230509   gcc  
parisc       buildonly-randconfig-r003-20230509   gcc  
parisc                              defconfig   gcc  
parisc                generic-32bit_defconfig   gcc  
parisc               randconfig-r012-20230511   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                     mpc83xx_defconfig   gcc  
powerpc              randconfig-r022-20230511   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv             nommu_k210_sdcard_defconfig   gcc  
riscv                randconfig-r026-20230509   clang
riscv                randconfig-r034-20230511   clang
riscv                randconfig-r042-20230509   clang
riscv                randconfig-r042-20230511   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r004-20230511   clang
s390                 randconfig-r005-20230511   clang
s390                 randconfig-r014-20230511   gcc  
s390                 randconfig-r033-20230511   clang
s390                 randconfig-r034-20230509   gcc  
s390                 randconfig-r044-20230509   clang
s390                 randconfig-r044-20230511   gcc  
sh                               allmodconfig   gcc  
sh                   randconfig-r006-20230512   gcc  
sh                   randconfig-r011-20230511   gcc  
sh                   randconfig-r021-20230509   gcc  
sh                          rsk7264_defconfig   gcc  
sh                           se7722_defconfig   gcc  
sparc        buildonly-randconfig-r004-20230509   gcc  
sparc        buildonly-randconfig-r006-20230509   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r001-20230509   gcc  
sparc                randconfig-r014-20230511   gcc  
sparc                randconfig-r015-20230511   gcc  
sparc64      buildonly-randconfig-r002-20230511   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                           alldefconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64                        randconfig-a001   clang
x86_64                        randconfig-a002   gcc  
x86_64                        randconfig-a003   clang
x86_64                        randconfig-a004   gcc  
x86_64                        randconfig-a005   clang
x86_64                        randconfig-a006   gcc  
x86_64                        randconfig-a011   gcc  
x86_64                        randconfig-a012   clang
x86_64                        randconfig-a013   gcc  
x86_64                        randconfig-a014   clang
x86_64                        randconfig-a015   gcc  
x86_64                        randconfig-a016   clang
x86_64                        randconfig-k001   clang
x86_64                           rhel-8.3-bpf   gcc  
x86_64                         rhel-8.3-kunit   gcc  
x86_64                           rhel-8.3-kvm   gcc  
x86_64                           rhel-8.3-syz   gcc  
x86_64                               rhel-8.3   gcc  
xtensa       buildonly-randconfig-r004-20230511   gcc  
xtensa               randconfig-r005-20230512   gcc  
xtensa               randconfig-r012-20230511   gcc  
xtensa               randconfig-r015-20230511   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
