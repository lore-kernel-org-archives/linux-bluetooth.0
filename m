Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E37DCA0FE0
	for <linux-bluetooth@archiver.kernel.org>; Thu, 31 Aug 2023 22:38:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233440AbjHaWiR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 31 Aug 2023 18:38:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232087AbjHaWiQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 31 Aug 2023 18:38:16 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F7D2FB
        for <linux-bluetooth@vger.kernel.org>; Thu, 31 Aug 2023 15:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693521493; x=1725057493;
  h=date:from:to:cc:subject:message-id;
  bh=K7qe6PnU7D0gFRFgQeixwba8iU+Ex2pJg19+WZOm1sQ=;
  b=Fopdtyk8mzSWk+EqkS8Z7w5MKgfhx/cyPlGkHcgfz8T/JAGCezKaREea
   aSVmGJzyyIm0VEo2Hg64deB/MILKYf2XhbHI2+3COPs1LpKEh8rxg4Gct
   nwvRb15WnubhgBymatPvYgKX2fGYkdwAiGa5IKoZE4W10CO/1XC4MCljq
   +7upfImip8yySL7gj647Anzsx3L81dUFVaINNYmaGmuV5OlpolXlFXFu8
   WKJcwjyZ29wq30NicAxoaP5ehrDMeVu8/FidBuxlKpl9WsG59AEcRibd6
   kqJX5UYQ9o6NqJrUvBTZA2SPdcGEL9KBgfHjCL5d3L6p3UmrjJ7eRiD9o
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="376018432"
X-IronPort-AV: E=Sophos;i="6.02,218,1688454000"; 
   d="scan'208";a="376018432"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2023 15:38:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="863320150"
X-IronPort-AV: E=Sophos;i="6.02,218,1688454000"; 
   d="scan'208";a="863320150"
Received: from lkp-server01.sh.intel.com (HELO 5d8055a4f6aa) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 31 Aug 2023 15:38:11 -0700
Received: from kbuild by 5d8055a4f6aa with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qbqIj-0000cG-0I;
        Thu, 31 Aug 2023 22:38:09 +0000
Date:   Fri, 01 Sep 2023 06:37:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc:     linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 52bf4fd43f759ac4698f041fff2cb27691698265
Message-ID: <202309010625.MhvvU5ta-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: 52bf4fd43f759ac4698f041fff2cb27691698265  Bluetooth: hci_sync: Fix handling of HCI_QUIRK_STRICT_DUPLICATE_FILTER

elapsed time: 1459m

configs tested: 160
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r003-20230831   gcc  
alpha                randconfig-r031-20230831   gcc  
alpha                randconfig-r033-20230831   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20230831   gcc  
arc                  randconfig-r011-20230831   gcc  
arc                  randconfig-r015-20230831   gcc  
arc                  randconfig-r022-20230831   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                   randconfig-001-20230831   gcc  
arm                  randconfig-r034-20230831   clang
arm64                            allmodconfig   gcc  
arm64                             allnoconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
hexagon               randconfig-001-20230831   clang
hexagon               randconfig-002-20230831   clang
hexagon              randconfig-r001-20230831   clang
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20230831   gcc  
i386         buildonly-randconfig-002-20230831   gcc  
i386         buildonly-randconfig-003-20230831   gcc  
i386         buildonly-randconfig-004-20230831   gcc  
i386         buildonly-randconfig-005-20230831   gcc  
i386         buildonly-randconfig-006-20230831   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20230831   gcc  
i386                  randconfig-002-20230831   gcc  
i386                  randconfig-003-20230831   gcc  
i386                  randconfig-004-20230831   gcc  
i386                  randconfig-005-20230831   gcc  
i386                  randconfig-006-20230831   gcc  
i386                  randconfig-011-20230831   clang
i386                  randconfig-012-20230831   clang
i386                  randconfig-013-20230831   clang
i386                  randconfig-014-20230831   clang
i386                  randconfig-015-20230831   clang
i386                  randconfig-016-20230831   clang
i386                 randconfig-r012-20230831   clang
i386                 randconfig-r013-20230831   clang
i386                 randconfig-r025-20230831   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20230831   gcc  
loongarch            randconfig-r021-20230831   gcc  
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
nios2                randconfig-r023-20230831   gcc  
nios2                randconfig-r026-20230831   gcc  
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
powerpc              randconfig-r006-20230831   gcc  
powerpc              randconfig-r016-20230831   clang
powerpc64            randconfig-r004-20230831   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                 randconfig-001-20230831   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20230831   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                   randconfig-r035-20230831   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64              randconfig-r014-20230831   gcc  
sparc64              randconfig-r032-20230831   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                   randconfig-r005-20230831   clang
um                   randconfig-r024-20230831   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-001-20230831   gcc  
x86_64       buildonly-randconfig-002-20230831   gcc  
x86_64       buildonly-randconfig-003-20230831   gcc  
x86_64       buildonly-randconfig-004-20230831   gcc  
x86_64       buildonly-randconfig-005-20230831   gcc  
x86_64       buildonly-randconfig-006-20230831   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20230831   clang
x86_64                randconfig-002-20230831   clang
x86_64                randconfig-003-20230831   clang
x86_64                randconfig-004-20230831   clang
x86_64                randconfig-005-20230831   clang
x86_64                randconfig-006-20230831   clang
x86_64                randconfig-011-20230831   gcc  
x86_64                randconfig-012-20230831   gcc  
x86_64                randconfig-013-20230831   gcc  
x86_64                randconfig-014-20230831   gcc  
x86_64                randconfig-015-20230831   gcc  
x86_64                randconfig-016-20230831   gcc  
x86_64                randconfig-071-20230831   gcc  
x86_64                randconfig-072-20230831   gcc  
x86_64                randconfig-073-20230831   gcc  
x86_64                randconfig-074-20230831   gcc  
x86_64                randconfig-075-20230831   gcc  
x86_64                randconfig-076-20230831   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa               randconfig-r002-20230831   gcc  
xtensa               randconfig-r036-20230831   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
