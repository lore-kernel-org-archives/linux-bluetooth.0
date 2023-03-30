Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D646AC77B62
	for <linux-bluetooth@archiver.kernel.org>; Thu, 30 Mar 2023 08:35:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbjC3IfV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 30 Mar 2023 04:35:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbjC3IfQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 30 Mar 2023 04:35:16 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFD5072BA
        for <linux-bluetooth@vger.kernel.org>; Thu, 30 Mar 2023 01:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680165304; x=1711701304;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=2AE0bKoPDrjdd0abKFqMtlUibgy/Vzrta18MV1JZIJ0=;
  b=gNFpTJvmacOFO5lxFMw40Jz/nSB1MWyG2hmnD15xGqraGCt0zrSrud88
   8u77RWfio3o9xG50XUNOm4QqYcZUAttHrpAUYoqSW02q2/DusFRvpKe2Z
   e1QZpG2ufFUhK8Ckddghx6VblJ/CRjhTKlQkWD1IotzH0RcNdLWPsQ+cf
   dOJ+ho4o8vH96Ha2b4zJHbwDkXhDdLXfssekvfKySupQf8CW2acGBrAnb
   VyJWqHRX9gkG0k1nqLA3io/hqq2fxJ725sNqcHS6mzzL2pjG6WRKklHYK
   amuwXGW9ekVjklg0k9JThHWuHmuGNp+mnlY47FZIOrG45SJjX+L5R3Yrn
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="343557715"
X-IronPort-AV: E=Sophos;i="5.98,303,1673942400"; 
   d="scan'208";a="343557715"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2023 01:35:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="749100609"
X-IronPort-AV: E=Sophos;i="5.98,303,1673942400"; 
   d="scan'208";a="749100609"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 30 Mar 2023 01:34:47 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1phnk1-000Kcb-33;
        Thu, 30 Mar 2023 08:34:41 +0000
Date:   Thu, 30 Mar 2023 16:33:49 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc:     linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 5b23f8375a3685b93022feb625a2c4b43e5c0ad3
Message-ID: <6425496d.kj3hd+JB6e0+VGe5%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: 5b23f8375a3685b93022feb625a2c4b43e5c0ad3  Bluetooth: btintel: Add LE States quirk support

elapsed time: 725m

configs tested: 100
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r015-20230329   gcc  
alpha                randconfig-r034-20230329   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r035-20230329   gcc  
arc                  randconfig-r043-20230329   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r046-20230329   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r002-20230329   gcc  
arm64                randconfig-r025-20230329   clang
csky                                defconfig   gcc  
csky                 randconfig-r033-20230329   gcc  
hexagon              randconfig-r041-20230329   clang
hexagon              randconfig-r045-20230329   clang
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
ia64                                defconfig   gcc  
ia64                 randconfig-r003-20230329   gcc  
ia64                 randconfig-r031-20230329   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r013-20230329   gcc  
m68k                             allmodconfig   gcc  
m68k         buildonly-randconfig-r002-20230329   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r014-20230329   gcc  
microblaze           randconfig-r036-20230329   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                 randconfig-r012-20230329   gcc  
nios2        buildonly-randconfig-r003-20230329   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r011-20230329   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r001-20230329   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc              randconfig-r024-20230329   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r016-20230329   clang
riscv                randconfig-r026-20230329   clang
riscv                randconfig-r042-20230329   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r005-20230329   gcc  
s390                 randconfig-r044-20230329   clang
sh                               allmodconfig   gcc  
sh                   randconfig-r004-20230329   gcc  
sh                   randconfig-r006-20230329   gcc  
sh                   randconfig-r021-20230329   gcc  
sh                   randconfig-r032-20230329   gcc  
sparc                               defconfig   gcc  
sparc64      buildonly-randconfig-r005-20230329   gcc  
sparc64      buildonly-randconfig-r006-20230329   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
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
x86_64                               rhel-8.3   gcc  
xtensa               randconfig-r022-20230329   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
