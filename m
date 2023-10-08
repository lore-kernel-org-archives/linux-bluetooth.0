Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A95DE95A67
	for <linux-bluetooth@archiver.kernel.org>; Sun,  8 Oct 2023 00:36:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344222AbjJHAgn (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 7 Oct 2023 20:36:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbjJHAgm (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 7 Oct 2023 20:36:42 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67B18D6
        for <linux-bluetooth@vger.kernel.org>; Sat,  7 Oct 2023 17:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696725401; x=1728261401;
  h=date:from:to:cc:subject:message-id;
  bh=UmcJ3Y0uH5/4Rwc+86x8IzePuevdH1NPQZQo9TbPbyY=;
  b=XNvUsWbxSY1Kovlbc8/mWsUrd5ZvMm/A2fcLfpBz0CFSRLIWS/pN00cs
   8VCppUJbSFR595z7AYp0ozPakEQN4vwYrkoZz6zyhZXpvu7hEb+mNEv/9
   1QI3cMswGfaK9CNQCeOECcmZFrtDGdIiDZVvQincjoeQn/jVAX7KWbDj8
   uBWjIbKKpmAlz+H54WouCGHPcNeav2xz2t3RUoNUPyIqWr0dPs/HE+Txd
   42XBEkp6ljU/jQmfjdvWqEQRe35pv41Lqm08ywiZMel7dve4oixGdTCvP
   PDlaLouwVS53kxzkYeEc/DCV2TSzCiS2jCBZ9JhVv0cDAwSHrKo8u1v9/
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10856"; a="450464475"
X-IronPort-AV: E=Sophos;i="6.03,207,1694761200"; 
   d="scan'208";a="450464475"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2023 17:36:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10856"; a="729262958"
X-IronPort-AV: E=Sophos;i="6.03,207,1694761200"; 
   d="scan'208";a="729262958"
Received: from lkp-server01.sh.intel.com (HELO 8a3a91ad4240) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 07 Oct 2023 17:36:39 -0700
Received: from kbuild by 8a3a91ad4240 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qpHmf-0004y8-0U;
        Sun, 08 Oct 2023 00:36:37 +0000
Date:   Sun, 08 Oct 2023 08:36:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc:     linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS WITH WARNING
 3ef20de6b2a89a5341b42a33586c437c6e7eb09f
Message-ID: <202310080801.v1qAGQbA-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: 3ef20de6b2a89a5341b42a33586c437c6e7eb09f  Bluetooth: btrtl: Ignore error return for hci_devcd_register()

Warning: (recently discovered and may have been fixed)

include/linux/fortify-string.h:63:33: warning: '__builtin_memcmp_eq' specified bound 6 exceeds source size 0 [-Wstringop-overread]

Warning ids grouped by kconfigs:

gcc_recent_errors
`-- i386-randconfig-002-20231007
    `-- include-linux-fortify-string.h:warning:__builtin_memcmp_eq-specified-bound-exceeds-source-size

elapsed time: 1358m

configs tested: 107
configs skipped: 2

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20231007   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                   randconfig-001-20231007   gcc  
arm64                            allmodconfig   gcc  
arm64                             allnoconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20231007   gcc  
i386         buildonly-randconfig-002-20231007   gcc  
i386         buildonly-randconfig-003-20231007   gcc  
i386         buildonly-randconfig-004-20231007   gcc  
i386         buildonly-randconfig-005-20231007   gcc  
i386         buildonly-randconfig-006-20231007   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20231007   gcc  
i386                  randconfig-002-20231007   gcc  
i386                  randconfig-003-20231007   gcc  
i386                  randconfig-004-20231007   gcc  
i386                  randconfig-005-20231007   gcc  
i386                  randconfig-006-20231007   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20231007   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20231007   gcc  
x86_64                randconfig-002-20231007   gcc  
x86_64                randconfig-003-20231007   gcc  
x86_64                randconfig-004-20231007   gcc  
x86_64                randconfig-005-20231007   gcc  
x86_64                randconfig-006-20231007   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
