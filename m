Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35214C74A5B
	for <linux-bluetooth@archiver.kernel.org>; Sat, 18 Mar 2023 13:37:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbjCRNhu (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 18 Mar 2023 09:37:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjCRNht (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 18 Mar 2023 09:37:49 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DD12233E3
        for <linux-bluetooth@vger.kernel.org>; Sat, 18 Mar 2023 06:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679146667; x=1710682667;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=Fxy5XRZQ1lff0+nJJl/2oQ98zWO+X1aHh8j9CmindZo=;
  b=UCo3IUlSPOvfU7ZxTHNSa0hd2iFjJfzXFylCD/knxEmW+GUwrlED+bZ5
   ZXpGOXa2WqRHd/bGpFsBj2dUJPnzykEQefUrgsQD7ZV62EQMchZdWVkBt
   eK0UKZGL34M8M0GKu7oi5fFlvFqY1z9zz4Yqrds10iQeyHaTZNrpJpK8U
   XNMgrBwsrP8Ho/Uk4lKrcu7WUuRWtL84T6Ge5PYb1scSwc/JXzVWRcgwO
   idOOVd2zM+uVtxdik5LdaOygjkNMxGz3n0s3otR+dbceUL/Xi4XhbRios
   r9m3hC9L8B9PLMZwdGwW9LdMAd27r+IUtTXkFg8mi6PoCdKTFLz31yRyN
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10652"; a="318834787"
X-IronPort-AV: E=Sophos;i="5.98,271,1673942400"; 
   d="scan'208";a="318834787"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2023 06:37:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10652"; a="710806854"
X-IronPort-AV: E=Sophos;i="5.98,271,1673942400"; 
   d="scan'208";a="710806854"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 18 Mar 2023 06:37:45 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pdWki-000A5q-1K;
        Sat, 18 Mar 2023 13:37:44 +0000
Date:   Sat, 18 Mar 2023 21:37:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc:     linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 3e662aa4453a38568731c6319319a3a85e2f2f96
Message-ID: <6415bea7.cEes8s0ZsCSHFPq5%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: 3e662aa4453a38568731c6319319a3a85e2f2f96  Bluetooth: NXP: Add protocol support for NXP Bluetooth chipsets

elapsed time: 797m

configs tested: 397
configs skipped: 41

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha        buildonly-randconfig-r001-20230313   gcc  
alpha        buildonly-randconfig-r002-20230313   gcc  
alpha        buildonly-randconfig-r004-20230313   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r001-20230313   gcc  
alpha                randconfig-r002-20230313   gcc  
alpha                randconfig-r016-20230312   gcc  
alpha                randconfig-r021-20230312   gcc  
alpha                randconfig-r024-20230312   gcc  
alpha                randconfig-r025-20230312   gcc  
alpha                randconfig-r026-20230313   gcc  
alpha                randconfig-r034-20230313   gcc  
alpha                randconfig-r035-20230313   gcc  
arc                              allyesconfig   gcc  
arc          buildonly-randconfig-r002-20230313   gcc  
arc          buildonly-randconfig-r004-20230312   gcc  
arc          buildonly-randconfig-r005-20230313   gcc  
arc          buildonly-randconfig-r006-20230313   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r004-20230312   gcc  
arc                  randconfig-r006-20230313   gcc  
arc                  randconfig-r011-20230313   gcc  
arc                  randconfig-r012-20230312   gcc  
arc                  randconfig-r013-20230313   gcc  
arc                  randconfig-r015-20230312   gcc  
arc                  randconfig-r022-20230313   gcc  
arc                  randconfig-r023-20230313   gcc  
arc                  randconfig-r026-20230312   gcc  
arc                  randconfig-r031-20230312   gcc  
arc                  randconfig-r031-20230313   gcc  
arc                  randconfig-r032-20230312   gcc  
arc                  randconfig-r032-20230318   gcc  
arc                  randconfig-r034-20230312   gcc  
arc                  randconfig-r043-20230312   gcc  
arc                  randconfig-r043-20230313   gcc  
arc                  randconfig-r043-20230318   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                         bcm2835_defconfig   clang
arm          buildonly-randconfig-r001-20230313   gcc  
arm          buildonly-randconfig-r004-20230313   gcc  
arm          buildonly-randconfig-r005-20230313   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r003-20230313   clang
arm                  randconfig-r004-20230312   gcc  
arm                  randconfig-r004-20230313   clang
arm                  randconfig-r005-20230312   gcc  
arm                  randconfig-r006-20230313   clang
arm                  randconfig-r011-20230313   gcc  
arm                  randconfig-r013-20230313   gcc  
arm                  randconfig-r021-20230313   gcc  
arm                  randconfig-r024-20230313   gcc  
arm                  randconfig-r025-20230313   gcc  
arm                  randconfig-r026-20230313   gcc  
arm                  randconfig-r035-20230312   gcc  
arm                  randconfig-r036-20230312   gcc  
arm                  randconfig-r046-20230312   clang
arm                  randconfig-r046-20230313   gcc  
arm                       spear13xx_defconfig   clang
arm                           stm32_defconfig   gcc  
arm                         vf610m4_defconfig   gcc  
arm64                            allyesconfig   gcc  
arm64        buildonly-randconfig-r004-20230313   gcc  
arm64        buildonly-randconfig-r006-20230313   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r001-20230312   clang
arm64                randconfig-r004-20230312   clang
arm64                randconfig-r005-20230312   clang
arm64                randconfig-r005-20230313   gcc  
arm64                randconfig-r006-20230312   clang
arm64                randconfig-r011-20230312   gcc  
arm64                randconfig-r012-20230313   clang
arm64                randconfig-r013-20230312   gcc  
arm64                randconfig-r015-20230312   gcc  
arm64                randconfig-r021-20230312   gcc  
arm64                randconfig-r023-20230313   clang
arm64                randconfig-r034-20230312   clang
arm64                randconfig-r034-20230313   gcc  
csky         buildonly-randconfig-r004-20230312   gcc  
csky         buildonly-randconfig-r005-20230313   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r002-20230312   gcc  
csky                 randconfig-r002-20230313   gcc  
csky                 randconfig-r003-20230312   gcc  
csky                 randconfig-r014-20230313   gcc  
csky                 randconfig-r022-20230313   gcc  
csky                 randconfig-r023-20230312   gcc  
csky                 randconfig-r025-20230313   gcc  
csky                 randconfig-r026-20230312   gcc  
csky                 randconfig-r033-20230313   gcc  
csky                 randconfig-r035-20230312   gcc  
csky                 randconfig-r036-20230312   gcc  
hexagon              randconfig-r001-20230313   clang
hexagon              randconfig-r015-20230312   clang
hexagon              randconfig-r016-20230313   clang
hexagon              randconfig-r031-20230313   clang
hexagon              randconfig-r041-20230312   clang
hexagon              randconfig-r041-20230313   clang
hexagon              randconfig-r045-20230312   clang
hexagon              randconfig-r045-20230313   clang
i386                             alldefconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r002-20230313   gcc  
i386         buildonly-randconfig-r003-20230313   gcc  
i386         buildonly-randconfig-r006-20230313   gcc  
i386                         debian-10.3-func   gcc  
i386                   debian-10.3-kselftests   gcc  
i386                        debian-10.3-kunit   gcc  
i386                          debian-10.3-kvm   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-a001-20230313   gcc  
i386                 randconfig-a002-20230313   gcc  
i386                 randconfig-a003-20230313   gcc  
i386                 randconfig-a004-20230313   gcc  
i386                 randconfig-a005-20230313   gcc  
i386                 randconfig-a006-20230313   gcc  
i386                 randconfig-a011-20230313   clang
i386                 randconfig-a012-20230313   clang
i386                 randconfig-a013-20230313   clang
i386                 randconfig-a014-20230313   clang
i386                 randconfig-a015-20230313   clang
i386                 randconfig-a016-20230313   clang
i386                          randconfig-c001   gcc  
i386                 randconfig-r002-20230313   gcc  
i386                 randconfig-r004-20230313   gcc  
i386                 randconfig-r005-20230313   gcc  
i386                 randconfig-r032-20230313   gcc  
i386                 randconfig-r035-20230313   gcc  
ia64                             allmodconfig   gcc  
ia64         buildonly-randconfig-r002-20230312   gcc  
ia64         buildonly-randconfig-r005-20230312   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r001-20230313   gcc  
ia64                 randconfig-r002-20230313   gcc  
ia64                 randconfig-r003-20230313   gcc  
ia64                 randconfig-r005-20230313   gcc  
ia64                 randconfig-r006-20230313   gcc  
ia64                 randconfig-r011-20230312   gcc  
ia64                 randconfig-r012-20230312   gcc  
ia64                 randconfig-r015-20230315   gcc  
ia64                 randconfig-r016-20230312   gcc  
ia64                 randconfig-r022-20230313   gcc  
ia64                 randconfig-r023-20230313   gcc  
ia64                 randconfig-r025-20230313   gcc  
ia64                 randconfig-r031-20230312   gcc  
ia64                 randconfig-r032-20230313   gcc  
ia64                 randconfig-r036-20230313   gcc  
ia64                 randconfig-r036-20230318   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch    buildonly-randconfig-r001-20230313   gcc  
loongarch    buildonly-randconfig-r002-20230313   gcc  
loongarch    buildonly-randconfig-r005-20230312   gcc  
loongarch    buildonly-randconfig-r006-20230313   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r013-20230313   gcc  
loongarch            randconfig-r016-20230312   gcc  
loongarch            randconfig-r021-20230312   gcc  
loongarch            randconfig-r022-20230312   gcc  
loongarch            randconfig-r026-20230312   gcc  
loongarch            randconfig-r031-20230313   gcc  
loongarch            randconfig-r036-20230313   gcc  
m68k                             allmodconfig   gcc  
m68k         buildonly-randconfig-r002-20230313   gcc  
m68k         buildonly-randconfig-r004-20230313   gcc  
m68k         buildonly-randconfig-r006-20230313   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r002-20230312   gcc  
m68k                 randconfig-r003-20230312   gcc  
m68k                 randconfig-r003-20230313   gcc  
m68k                 randconfig-r004-20230312   gcc  
m68k                 randconfig-r004-20230313   gcc  
m68k                 randconfig-r005-20230312   gcc  
m68k                 randconfig-r011-20230312   gcc  
m68k                 randconfig-r011-20230313   gcc  
m68k                 randconfig-r012-20230312   gcc  
m68k                 randconfig-r013-20230312   gcc  
m68k                 randconfig-r014-20230313   gcc  
m68k                 randconfig-r014-20230315   gcc  
m68k                 randconfig-r016-20230313   gcc  
m68k                 randconfig-r025-20230313   gcc  
m68k                 randconfig-r031-20230313   gcc  
m68k                 randconfig-r032-20230312   gcc  
m68k                 randconfig-r033-20230313   gcc  
m68k                 randconfig-r033-20230318   gcc  
m68k                 randconfig-r034-20230313   gcc  
m68k                 randconfig-r035-20230318   gcc  
microblaze   buildonly-randconfig-r002-20230312   gcc  
microblaze   buildonly-randconfig-r002-20230313   gcc  
microblaze   buildonly-randconfig-r006-20230312   gcc  
microblaze           randconfig-r001-20230312   gcc  
microblaze           randconfig-r001-20230313   gcc  
microblaze           randconfig-r006-20230312   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips         buildonly-randconfig-r002-20230312   gcc  
mips         buildonly-randconfig-r004-20230313   clang
mips         buildonly-randconfig-r006-20230313   clang
mips                     decstation_defconfig   gcc  
mips                 randconfig-r001-20230312   gcc  
mips                 randconfig-r003-20230312   gcc  
mips                 randconfig-r013-20230312   clang
mips                 randconfig-r015-20230313   gcc  
mips                 randconfig-r033-20230312   gcc  
mips                 randconfig-r034-20230313   clang
nios2        buildonly-randconfig-r001-20230313   gcc  
nios2        buildonly-randconfig-r003-20230312   gcc  
nios2        buildonly-randconfig-r005-20230313   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r003-20230312   gcc  
nios2                randconfig-r005-20230312   gcc  
nios2                randconfig-r006-20230312   gcc  
nios2                randconfig-r012-20230312   gcc  
nios2                randconfig-r012-20230313   gcc  
nios2                randconfig-r014-20230312   gcc  
nios2                randconfig-r015-20230313   gcc  
nios2                randconfig-r016-20230313   gcc  
nios2                randconfig-r021-20230313   gcc  
nios2                randconfig-r023-20230313   gcc  
nios2                randconfig-r025-20230312   gcc  
nios2                randconfig-r026-20230312   gcc  
nios2                randconfig-r032-20230312   gcc  
openrisc     buildonly-randconfig-r001-20230312   gcc  
openrisc     buildonly-randconfig-r003-20230312   gcc  
openrisc     buildonly-randconfig-r005-20230313   gcc  
openrisc                  or1klitex_defconfig   gcc  
openrisc             randconfig-r012-20230313   gcc  
openrisc             randconfig-r014-20230312   gcc  
openrisc             randconfig-r021-20230313   gcc  
openrisc             randconfig-r023-20230312   gcc  
openrisc             randconfig-r032-20230312   gcc  
openrisc             randconfig-r035-20230313   gcc  
openrisc             randconfig-r036-20230312   gcc  
parisc       buildonly-randconfig-r006-20230312   gcc  
parisc       buildonly-randconfig-r006-20230313   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r004-20230313   gcc  
parisc               randconfig-r005-20230312   gcc  
parisc               randconfig-r005-20230313   gcc  
parisc               randconfig-r011-20230312   gcc  
parisc               randconfig-r014-20230313   gcc  
parisc               randconfig-r021-20230313   gcc  
parisc               randconfig-r023-20230313   gcc  
parisc               randconfig-r026-20230313   gcc  
parisc               randconfig-r033-20230312   gcc  
parisc               randconfig-r033-20230313   gcc  
parisc               randconfig-r034-20230312   gcc  
parisc               randconfig-r034-20230313   gcc  
parisc               randconfig-r035-20230312   gcc  
parisc               randconfig-r036-20230313   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc      buildonly-randconfig-r001-20230312   gcc  
powerpc      buildonly-randconfig-r005-20230312   gcc  
powerpc      buildonly-randconfig-r006-20230312   gcc  
powerpc                      pasemi_defconfig   gcc  
powerpc              randconfig-c003-20230312   gcc  
powerpc              randconfig-r003-20230313   gcc  
powerpc              randconfig-r011-20230312   gcc  
powerpc              randconfig-r012-20230312   gcc  
powerpc              randconfig-r014-20230312   gcc  
powerpc              randconfig-r015-20230313   clang
powerpc              randconfig-r016-20230312   gcc  
powerpc              randconfig-r026-20230312   gcc  
powerpc              randconfig-r036-20230313   gcc  
powerpc                        warp_defconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv        buildonly-randconfig-r001-20230312   gcc  
riscv        buildonly-randconfig-r002-20230313   clang
riscv        buildonly-randconfig-r004-20230312   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r002-20230312   clang
riscv                randconfig-r003-20230313   gcc  
riscv                randconfig-r004-20230313   gcc  
riscv                randconfig-r005-20230318   clang
riscv                randconfig-r006-20230312   clang
riscv                randconfig-r011-20230313   clang
riscv                randconfig-r014-20230312   gcc  
riscv                randconfig-r024-20230312   gcc  
riscv                randconfig-r031-20230313   gcc  
riscv                randconfig-r033-20230312   clang
riscv                randconfig-r042-20230312   gcc  
riscv                randconfig-r042-20230313   clang
riscv                randconfig-r042-20230318   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390         buildonly-randconfig-r006-20230312   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r006-20230313   gcc  
s390                 randconfig-r013-20230312   gcc  
s390                 randconfig-r013-20230313   clang
s390                 randconfig-r016-20230312   gcc  
s390                 randconfig-r021-20230312   gcc  
s390                 randconfig-r023-20230312   gcc  
s390                 randconfig-r025-20230312   gcc  
s390                 randconfig-r032-20230312   clang
s390                 randconfig-r044-20230312   gcc  
s390                 randconfig-r044-20230313   clang
s390                 randconfig-r044-20230318   gcc  
sh                               allmodconfig   gcc  
sh           buildonly-randconfig-r002-20230313   gcc  
sh           buildonly-randconfig-r005-20230312   gcc  
sh           buildonly-randconfig-r006-20230313   gcc  
sh                        edosk7760_defconfig   gcc  
sh                         microdev_defconfig   gcc  
sh                   randconfig-r021-20230313   gcc  
sh                   randconfig-r023-20230313   gcc  
sh                   randconfig-r024-20230312   gcc  
sh                   randconfig-r024-20230313   gcc  
sh                   randconfig-r035-20230312   gcc  
sh                           se7206_defconfig   gcc  
sh                        sh7757lcr_defconfig   gcc  
sh                   sh7770_generic_defconfig   gcc  
sparc        buildonly-randconfig-r003-20230313   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r002-20230313   gcc  
sparc                randconfig-r005-20230312   gcc  
sparc                randconfig-r014-20230313   gcc  
sparc                randconfig-r015-20230313   gcc  
sparc                randconfig-r016-20230313   gcc  
sparc                randconfig-r021-20230312   gcc  
sparc                randconfig-r022-20230312   gcc  
sparc                randconfig-r023-20230312   gcc  
sparc                randconfig-r024-20230312   gcc  
sparc                randconfig-r032-20230313   gcc  
sparc                randconfig-r034-20230312   gcc  
sparc                randconfig-r035-20230313   gcc  
sparc                randconfig-r036-20230313   gcc  
sparc64      buildonly-randconfig-r001-20230312   gcc  
sparc64      buildonly-randconfig-r003-20230312   gcc  
sparc64      buildonly-randconfig-r003-20230313   gcc  
sparc64              randconfig-r001-20230313   gcc  
sparc64              randconfig-r002-20230312   gcc  
sparc64              randconfig-r004-20230312   gcc  
sparc64              randconfig-r004-20230313   gcc  
sparc64              randconfig-r006-20230313   gcc  
sparc64              randconfig-r012-20230313   gcc  
sparc64              randconfig-r013-20230312   gcc  
sparc64              randconfig-r014-20230312   gcc  
sparc64              randconfig-r014-20230313   gcc  
sparc64              randconfig-r015-20230312   gcc  
sparc64              randconfig-r021-20230312   gcc  
sparc64              randconfig-r021-20230313   gcc  
sparc64              randconfig-r022-20230312   gcc  
sparc64              randconfig-r024-20230312   gcc  
sparc64              randconfig-r024-20230313   gcc  
sparc64              randconfig-r025-20230313   gcc  
sparc64              randconfig-r026-20230312   gcc  
sparc64              randconfig-r034-20230312   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r004-20230313   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a001-20230313   gcc  
x86_64               randconfig-a002-20230313   gcc  
x86_64               randconfig-a003-20230313   gcc  
x86_64               randconfig-a004-20230313   gcc  
x86_64               randconfig-a005-20230313   gcc  
x86_64               randconfig-a006-20230313   gcc  
x86_64               randconfig-a011-20230313   clang
x86_64               randconfig-a012-20230313   clang
x86_64               randconfig-a013-20230313   clang
x86_64               randconfig-a014-20230313   clang
x86_64               randconfig-a015-20230313   clang
x86_64               randconfig-a016-20230313   clang
x86_64               randconfig-k001-20230313   clang
x86_64                        randconfig-k001   clang
x86_64               randconfig-r002-20230313   gcc  
x86_64               randconfig-r016-20230313   clang
x86_64               randconfig-r025-20230313   clang
x86_64               randconfig-r033-20230313   gcc  
x86_64                               rhel-8.3   gcc  
xtensa       buildonly-randconfig-r001-20230312   gcc  
xtensa       buildonly-randconfig-r004-20230312   gcc  
xtensa       buildonly-randconfig-r005-20230312   gcc  
xtensa       buildonly-randconfig-r006-20230312   gcc  
xtensa               randconfig-r001-20230312   gcc  
xtensa               randconfig-r001-20230313   gcc  
xtensa               randconfig-r003-20230312   gcc  
xtensa               randconfig-r005-20230312   gcc  
xtensa               randconfig-r015-20230312   gcc  
xtensa               randconfig-r015-20230313   gcc  
xtensa               randconfig-r016-20230312   gcc  
xtensa               randconfig-r023-20230312   gcc  
xtensa               randconfig-r024-20230313   gcc  
xtensa               randconfig-r032-20230313   gcc  
xtensa               randconfig-r033-20230312   gcc  
xtensa               randconfig-r034-20230312   gcc  
xtensa               randconfig-r034-20230318   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
