Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 900FDC6FD1D
	for <linux-bluetooth@archiver.kernel.org>; Fri, 17 Mar 2023 06:40:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbjCQGkX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 17 Mar 2023 02:40:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230061AbjCQGkW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 17 Mar 2023 02:40:22 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4E6B91B6C
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 Mar 2023 23:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679035206; x=1710571206;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=4HynlHMFlixK9+5CJ55mEaQ4fHwV36xU0L0UUMEHymY=;
  b=eYNSiWlUStMw8omfsRJE6uT5mtMurBNKk62UC/rxxswisVosu8DnRakd
   KoWo+vAgEV2VWSmdnyeLUZichwDNtqoE9vCwiUxQJjrVVsex+vMLMvKkm
   fhzeEkJGAKgpizr7QOLiaONt+SX3TbuEUiPwyNrQFutRLCnU0E97MIoaG
   sEGyPrCuwzgGt/nX4YILRebLwpQk7C88nsGrCUxhzw0+FP/hc9PGKScAU
   mwCzn7ALMSWUlBXBw7rEBpRQUa7TmKMKtDj9HcX/7u8dxwhn1PWffqWWf
   fDBKU8LshCq1myV9PCp+zy70xGQ3z7QLj0Wzt68sswdcZzbyxFj/E1YQO
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10651"; a="400775381"
X-IronPort-AV: E=Sophos;i="5.98,268,1673942400"; 
   d="scan'208";a="400775381"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2023 23:40:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10651"; a="854338804"
X-IronPort-AV: E=Sophos;i="5.98,268,1673942400"; 
   d="scan'208";a="854338804"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 16 Mar 2023 23:40:04 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pd3kt-00099s-0u;
        Fri, 17 Mar 2023 06:39:59 +0000
Date:   Fri, 17 Mar 2023 14:39:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc:     linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 8abee3773899049aefdf8eb397f426be3a219bf8
Message-ID: <64140b25.z6iNm441nIlk9wMs%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: 8abee3773899049aefdf8eb397f426be3a219bf8  Bluetooth: mgmt: Fix MGMT add advmon with RSSI command

elapsed time: 726m

configs tested: 131
configs skipped: 9

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r003-20230312   gcc  
arc                  randconfig-r026-20230315   gcc  
arc                  randconfig-r031-20230312   gcc  
arc                  randconfig-r034-20230312   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r021-20230315   gcc  
arm                  randconfig-r036-20230312   gcc  
arm                  randconfig-r046-20230312   clang
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r012-20230313   clang
arm64                randconfig-r016-20230312   gcc  
arm64                randconfig-r034-20230313   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r035-20230312   gcc  
hexagon              randconfig-r016-20230313   clang
hexagon              randconfig-r041-20230312   clang
hexagon              randconfig-r041-20230313   clang
hexagon              randconfig-r045-20230312   clang
hexagon              randconfig-r045-20230313   clang
i386                             alldefconfig   gcc  
i386                             allyesconfig   gcc  
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
ia64                             allmodconfig   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r032-20230313   gcc  
ia64                 randconfig-r036-20230313   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r002-20230312   gcc  
loongarch            randconfig-r002-20230313   gcc  
loongarch            randconfig-r031-20230313   gcc  
loongarch            randconfig-r036-20230313   gcc  
m68k                             allmodconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r001-20230313   gcc  
m68k                 randconfig-r005-20230312   gcc  
m68k                 randconfig-r023-20230315   gcc  
m68k                 randconfig-r033-20230313   gcc  
m68k                 randconfig-r034-20230313   gcc  
microblaze           randconfig-r006-20230312   gcc  
microblaze           randconfig-r013-20230313   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips         buildonly-randconfig-r004-20230313   clang
mips         buildonly-randconfig-r006-20230313   clang
mips                 randconfig-r001-20230312   gcc  
mips                 randconfig-r004-20230312   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r032-20230312   gcc  
openrisc             randconfig-r022-20230315   gcc  
openrisc             randconfig-r032-20230312   gcc  
openrisc             randconfig-r035-20230313   gcc  
openrisc             randconfig-r036-20230312   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r005-20230312   gcc  
parisc               randconfig-r012-20230313   gcc  
parisc               randconfig-r033-20230312   gcc  
parisc               randconfig-r033-20230313   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                     ep8248e_defconfig   gcc  
powerpc                       maple_defconfig   gcc  
powerpc              randconfig-r004-20230313   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv        buildonly-randconfig-r002-20230313   clang
riscv                               defconfig   gcc  
riscv                randconfig-r004-20230313   gcc  
riscv                randconfig-r011-20230313   clang
riscv                randconfig-r042-20230313   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r013-20230313   clang
s390                 randconfig-r044-20230313   clang
sh                               allmodconfig   gcc  
sh                   randconfig-r035-20230312   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r025-20230315   gcc  
sparc64              randconfig-r001-20230313   gcc  
sparc64              randconfig-r012-20230312   gcc  
sparc64              randconfig-r034-20230312   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
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
x86_64               randconfig-r002-20230313   gcc  
x86_64               randconfig-r006-20230313   gcc  
x86_64                               rhel-8.3   gcc  
xtensa               randconfig-r001-20230312   gcc  
xtensa               randconfig-r014-20230313   gcc  
xtensa               randconfig-r032-20230313   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
