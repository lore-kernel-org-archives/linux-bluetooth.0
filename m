Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3C3FEB64DD
	for <linux-bluetooth@archiver.kernel.org>; Thu, 13 Jul 2023 10:25:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232314AbjGMKZy (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 13 Jul 2023 06:25:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbjGMKZx (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 13 Jul 2023 06:25:53 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A394E77
        for <linux-bluetooth@vger.kernel.org>; Thu, 13 Jul 2023 03:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689243952; x=1720779952;
  h=date:from:to:cc:subject:message-id;
  bh=rqxUKMSDM0FHc0vqvH1t/Lffh/VW6wR7p6KxPzns0YU=;
  b=kxWb7oGJGqzww0RU8l+f3GgOIdvF9K+okW+b4KdD2NS2WnE3kD/brnta
   P9VgrpgYQIE264R/tgReRMjiL3v1gRQgHIG8i5LCYLO4qXtwmyiDVvBLI
   rWFSKygZXJg9PeTn3miauHkRFf00OId7QNlwfEswqimwA7CV0PCLJXtt0
   chh6AtymgQ3EGfHwKdCSSRpdxW95dNhUeU4xodL2VnlrJ2flSHsVr+uKm
   eWwI7fh6NWWez5UkuxdEhPrsdjBm13gJiPLI4MHksRTa0w+1hEs5dReOo
   aZH3o9TccMcS1YZpUYnebrB3FgQgzKwMXPmyR1AozXvbNCvobyGn1MoZb
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="362612242"
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="362612242"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2023 03:25:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="725252679"
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="725252679"
Received: from lkp-server01.sh.intel.com (HELO c544d7fc5005) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 13 Jul 2023 03:25:50 -0700
Received: from kbuild by c544d7fc5005 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qJtWA-0006Wj-0Y;
        Thu, 13 Jul 2023 10:25:50 +0000
Date:   Thu, 13 Jul 2023 18:24:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc:     linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 ff1b86784849f8e181641610f0acb4b77da7501d
Message-ID: <202307131848.2g36HfJn-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: ff1b86784849f8e181641610f0acb4b77da7501d  Bluetooth: hci_ldisc: check HCI_UART_PROTO_READY flag in HCIUARTGETPROTO

elapsed time: 786m

configs tested: 132
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r043-20230712   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r046-20230712   gcc  
arm                             rpc_defconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r012-20230713   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r014-20230713   gcc  
hexagon              randconfig-r041-20230712   clang
hexagon              randconfig-r045-20230712   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r004-20230712   gcc  
i386         buildonly-randconfig-r005-20230712   gcc  
i386         buildonly-randconfig-r006-20230712   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230712   gcc  
i386                 randconfig-i002-20230712   gcc  
i386                 randconfig-i003-20230712   gcc  
i386                 randconfig-i004-20230712   gcc  
i386                 randconfig-i005-20230712   gcc  
i386                 randconfig-i006-20230712   gcc  
i386                 randconfig-i011-20230712   clang
i386                 randconfig-i011-20230713   gcc  
i386                 randconfig-i012-20230712   clang
i386                 randconfig-i012-20230713   gcc  
i386                 randconfig-i013-20230712   clang
i386                 randconfig-i013-20230713   gcc  
i386                 randconfig-i014-20230712   clang
i386                 randconfig-i014-20230713   gcc  
i386                 randconfig-i015-20230712   clang
i386                 randconfig-i015-20230713   gcc  
i386                 randconfig-i016-20230712   clang
i386                 randconfig-i016-20230713   gcc  
i386                 randconfig-r024-20230712   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r012-20230713   gcc  
m68k                 randconfig-r013-20230713   gcc  
m68k                 randconfig-r015-20230713   gcc  
m68k                 randconfig-r022-20230712   gcc  
microblaze           randconfig-r002-20230713   gcc  
microblaze           randconfig-r031-20230713   gcc  
microblaze           randconfig-r033-20230713   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                 randconfig-r034-20230713   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r035-20230713   gcc  
openrisc             randconfig-r022-20230712   gcc  
openrisc             randconfig-r025-20230712   gcc  
openrisc             randconfig-r032-20230713   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r011-20230713   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                      mgcoge_defconfig   gcc  
powerpc              randconfig-r036-20230713   clang
powerpc                    sam440ep_defconfig   gcc  
powerpc                      walnut_defconfig   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r006-20230713   clang
riscv                randconfig-r015-20230713   gcc  
riscv                randconfig-r016-20230713   gcc  
riscv                randconfig-r042-20230712   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r011-20230713   gcc  
s390                 randconfig-r014-20230713   gcc  
s390                 randconfig-r044-20230712   clang
sh                               allmodconfig   gcc  
sh                            hp6xx_defconfig   gcc  
sh                           se7619_defconfig   gcc  
sh                             sh03_defconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r021-20230712   gcc  
sparc                randconfig-r023-20230712   gcc  
sparc                       sparc32_defconfig   gcc  
sparc64              randconfig-r023-20230712   gcc  
sparc64              randconfig-r026-20230712   gcc  
um                               alldefconfig   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                   randconfig-r003-20230713   gcc  
um                   randconfig-r004-20230713   gcc  
um                   randconfig-r005-20230713   gcc  
um                   randconfig-r025-20230712   gcc  
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r001-20230712   gcc  
x86_64       buildonly-randconfig-r002-20230712   gcc  
x86_64       buildonly-randconfig-r003-20230712   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-r013-20230713   gcc  
x86_64               randconfig-r031-20230713   clang
x86_64               randconfig-x001-20230712   clang
x86_64               randconfig-x002-20230712   clang
x86_64               randconfig-x003-20230712   clang
x86_64               randconfig-x004-20230712   clang
x86_64               randconfig-x005-20230712   clang
x86_64               randconfig-x006-20230712   clang
x86_64               randconfig-x011-20230712   gcc  
x86_64               randconfig-x012-20230712   gcc  
x86_64               randconfig-x013-20230712   gcc  
x86_64               randconfig-x014-20230712   gcc  
x86_64               randconfig-x015-20230712   gcc  
x86_64               randconfig-x016-20230712   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
