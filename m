Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35562C77B7C
	for <linux-bluetooth@archiver.kernel.org>; Thu,  4 May 2023 06:23:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbjEDGXB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 4 May 2023 02:23:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbjEDGW4 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 4 May 2023 02:22:56 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4733A2D59
        for <linux-bluetooth@vger.kernel.org>; Wed,  3 May 2023 23:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683181375; x=1714717375;
  h=date:from:to:cc:subject:message-id;
  bh=QoqLVw1mlyacDDicAaduA0LmIh0lZW6r2GQa3m2T78o=;
  b=aY5tS+Zb+f9m7wPQXJ5oMZxvDDEWg4yUWCN/urp/2hL4u+UJM5Cqfq7G
   WYG0i5r54cHcucie5blZ8Fizu6T/F9A86EtvuXz1zg+lP8Pm6OcnYJAAr
   MXGL8qi3aeojJn4BqWulA3wL1c89KMZwPf6Ohr0xx0SyRhWPoI7N4dxJN
   POZvSWzXNKEStq5r6nulYRMrqJiBnVUMf0dan1/nI2bU3n4KY5cC8QJPE
   eBeFEI2yb2opLrzZLJlUZCeO4UGjkkgRMaGngfEMbANhkm4JAiLE9v5Xk
   QMeUwCGVr4RX15wH/QylwDs+Ye9jr8QsLRw0T8v3CQXvA9Is1liqqGA+f
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10699"; a="337989516"
X-IronPort-AV: E=Sophos;i="5.99,249,1677571200"; 
   d="scan'208";a="337989516"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2023 23:22:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10699"; a="647196879"
X-IronPort-AV: E=Sophos;i="5.99,249,1677571200"; 
   d="scan'208";a="647196879"
Received: from lkp-server01.sh.intel.com (HELO e3434d64424d) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 03 May 2023 23:22:52 -0700
Received: from kbuild by e3434d64424d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1puSMd-0002dk-2A;
        Thu, 04 May 2023 06:22:51 +0000
Date:   Thu, 04 May 2023 14:22:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc:     linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 e6e576ec4e728b201a801374b0cec649a4473908
Message-ID: <20230504062215.OM3me%lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: e6e576ec4e728b201a801374b0cec649a4473908  Bluetooth: Unlink CISes when LE disconnects in hci_conn_del

elapsed time: 721m

configs tested: 140
configs skipped: 14

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha        buildonly-randconfig-r002-20230502   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r002-20230430   gcc  
alpha                randconfig-r012-20230501   gcc  
alpha                randconfig-r025-20230502   gcc  
alpha                randconfig-r032-20230501   gcc  
arc                              allyesconfig   gcc  
arc          buildonly-randconfig-r001-20230430   gcc  
arc          buildonly-randconfig-r003-20230502   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r006-20230501   gcc  
arc                  randconfig-r013-20230501   gcc  
arc                  randconfig-r043-20230430   gcc  
arc                  randconfig-r043-20230501   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r026-20230502   clang
arm                  randconfig-r046-20230430   gcc  
arm                  randconfig-r046-20230501   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r016-20230502   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r015-20230502   gcc  
csky                 randconfig-r023-20230502   gcc  
hexagon              randconfig-r041-20230430   clang
hexagon              randconfig-r041-20230501   clang
hexagon              randconfig-r045-20230430   clang
hexagon              randconfig-r045-20230501   clang
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-a001-20230501   gcc  
i386                 randconfig-a002-20230501   gcc  
i386                 randconfig-a003-20230501   gcc  
i386                 randconfig-a004-20230501   gcc  
i386                 randconfig-a005-20230501   gcc  
i386                 randconfig-a006-20230501   gcc  
i386                 randconfig-a011-20230501   clang
i386                 randconfig-a012-20230501   clang
i386                 randconfig-a013-20230501   clang
i386                 randconfig-a014-20230501   clang
i386                 randconfig-a015-20230501   clang
i386                 randconfig-a016-20230501   clang
ia64                             allmodconfig   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r003-20230501   gcc  
ia64                 randconfig-r013-20230430   gcc  
ia64                 randconfig-r031-20230501   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
m68k                             allmodconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r006-20230502   gcc  
m68k                 randconfig-r036-20230501   gcc  
microblaze   buildonly-randconfig-r001-20230502   gcc  
microblaze           randconfig-r006-20230430   gcc  
microblaze           randconfig-r014-20230430   gcc  
microblaze           randconfig-r033-20230501   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips         buildonly-randconfig-r004-20230430   clang
mips         buildonly-randconfig-r006-20230502   gcc  
mips                 randconfig-r005-20230501   clang
mips                 randconfig-r014-20230501   gcc  
mips                 randconfig-r032-20230430   clang
nios2                               defconfig   gcc  
nios2                randconfig-r001-20230430   gcc  
nios2                randconfig-r004-20230501   gcc  
nios2                randconfig-r012-20230502   gcc  
nios2                randconfig-r014-20230502   gcc  
openrisc     buildonly-randconfig-r006-20230430   gcc  
openrisc             randconfig-r011-20230501   gcc  
openrisc             randconfig-r011-20230502   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r016-20230501   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc      buildonly-randconfig-r006-20230501   clang
powerpc              randconfig-r002-20230502   clang
powerpc              randconfig-r013-20230502   gcc  
powerpc              randconfig-r015-20230430   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv        buildonly-randconfig-r003-20230501   clang
riscv        buildonly-randconfig-r005-20230430   clang
riscv                               defconfig   gcc  
riscv                randconfig-r003-20230502   clang
riscv                randconfig-r004-20230430   gcc  
riscv                randconfig-r042-20230430   clang
riscv                randconfig-r042-20230501   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390         buildonly-randconfig-r004-20230502   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r016-20230430   clang
s390                 randconfig-r022-20230502   gcc  
s390                 randconfig-r031-20230430   gcc  
s390                 randconfig-r044-20230430   clang
s390                 randconfig-r044-20230501   clang
sh                               allmodconfig   gcc  
sh                   randconfig-r011-20230430   gcc  
sparc        buildonly-randconfig-r001-20230501   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r003-20230430   gcc  
sparc                randconfig-r004-20230502   gcc  
sparc64      buildonly-randconfig-r002-20230501   gcc  
sparc64              randconfig-r001-20230502   gcc  
sparc64              randconfig-r005-20230430   gcc  
sparc64              randconfig-r005-20230502   gcc  
sparc64              randconfig-r012-20230430   gcc  
sparc64              randconfig-r015-20230501   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a001-20230501   gcc  
x86_64               randconfig-a002-20230501   gcc  
x86_64               randconfig-a003-20230501   gcc  
x86_64               randconfig-a004-20230501   gcc  
x86_64               randconfig-a005-20230501   gcc  
x86_64               randconfig-a006-20230501   gcc  
x86_64               randconfig-a011-20230501   clang
x86_64               randconfig-a012-20230501   clang
x86_64               randconfig-a013-20230501   clang
x86_64               randconfig-a014-20230501   clang
x86_64               randconfig-a015-20230501   clang
x86_64               randconfig-a016-20230501   clang
x86_64               randconfig-r034-20230501   gcc  
x86_64                               rhel-8.3   gcc  
xtensa       buildonly-randconfig-r005-20230501   gcc  
xtensa               randconfig-r001-20230501   gcc  
xtensa               randconfig-r002-20230501   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
