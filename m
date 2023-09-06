Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E994EB8FAD
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 Sep 2023 06:54:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232686AbjIFGyh (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 6 Sep 2023 02:54:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231979AbjIFGyh (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 6 Sep 2023 02:54:37 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3207E63
        for <linux-bluetooth@vger.kernel.org>; Tue,  5 Sep 2023 23:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693983237; x=1725519237;
  h=date:from:to:cc:subject:message-id;
  bh=yGjB0FaJUHvTPSoUDvWaqU1tziCjei3rRGwl//z7QnU=;
  b=GIWYV3y6tuj9OZ2Y0R48a+BrTpSbhMA4APMf8pdaU3TbiBCoLZT1696s
   DVN9Vo1vlRhkCf4b5OPI97Kq+P5VLQ+43YH24FOjy1iAsvRUbPB+4zeIb
   nPZicXS+f4VWc8ZJY3Gce9ZcgisJNQcyLktgOI73lv8ptbM85IW5++Obw
   isck9uOR6pUSL5BrkmJvbSWTGmtnP8aFUrtn6HDy+WFCi/bkbbCnNFruR
   3LI3Nu1NfwmlOBd+/0zbLcNT5usV9mSTxd2G0lO9iyKEXoIZ8CNbnRNl/
   BwyTFh0U7b+57gcIqN5wZ+oUt9N/o3jYs+DiKGmPDhI1fqii6LELzF3Gd
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="357299548"
X-IronPort-AV: E=Sophos;i="6.02,231,1688454000"; 
   d="scan'208";a="357299548"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2023 23:52:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="811536428"
X-IronPort-AV: E=Sophos;i="6.02,231,1688454000"; 
   d="scan'208";a="811536428"
Received: from lkp-server02.sh.intel.com (HELO e0b2ea88afd5) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 05 Sep 2023 23:52:50 -0700
Received: from kbuild by e0b2ea88afd5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qdmPA-0002XT-2D;
        Wed, 06 Sep 2023 06:52:48 +0000
Date:   Wed, 06 Sep 2023 14:52:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc:     linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 2595dd981e7478108540095a81495c473ef47750
Message-ID: <202309061441.meQIqSWw-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: 2595dd981e7478108540095a81495c473ef47750  Bluetooth: ISO: Fix handling of listen for unicast

elapsed time: 728m

configs tested: 166
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r006-20230906   gcc  
alpha                randconfig-r011-20230906   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20230906   gcc  
arc                  randconfig-r021-20230906   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                   randconfig-001-20230906   gcc  
arm64                            allmodconfig   gcc  
arm64                             allnoconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r034-20230906   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r004-20230906   gcc  
csky                 randconfig-r015-20230906   gcc  
csky                 randconfig-r023-20230906   gcc  
hexagon               randconfig-001-20230906   clang
hexagon               randconfig-002-20230906   clang
hexagon              randconfig-r001-20230906   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20230906   gcc  
i386         buildonly-randconfig-002-20230906   gcc  
i386         buildonly-randconfig-003-20230906   gcc  
i386         buildonly-randconfig-004-20230906   gcc  
i386         buildonly-randconfig-005-20230906   gcc  
i386         buildonly-randconfig-006-20230906   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20230906   gcc  
i386                  randconfig-002-20230906   gcc  
i386                  randconfig-003-20230906   gcc  
i386                  randconfig-004-20230906   gcc  
i386                  randconfig-005-20230906   gcc  
i386                  randconfig-006-20230906   gcc  
i386                  randconfig-011-20230906   clang
i386                  randconfig-012-20230906   clang
i386                  randconfig-013-20230906   clang
i386                  randconfig-014-20230906   clang
i386                  randconfig-015-20230906   clang
i386                  randconfig-016-20230906   clang
i386                 randconfig-r024-20230906   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20230906   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                       m5475evb_defconfig   gcc  
m68k                 randconfig-r022-20230906   gcc  
m68k                 randconfig-r035-20230906   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
microblaze           randconfig-r025-20230906   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                           ip32_defconfig   gcc  
mips                 randconfig-r031-20230906   clang
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
openrisc             randconfig-r003-20230906   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                generic-32bit_defconfig   gcc  
parisc               randconfig-r002-20230906   gcc  
parisc               randconfig-r014-20230906   gcc  
parisc               randconfig-r032-20230906   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   gcc  
powerpc              randconfig-r005-20230906   gcc  
powerpc64            randconfig-r016-20230906   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                 randconfig-001-20230906   gcc  
riscv                randconfig-r012-20230906   clang
riscv                randconfig-r033-20230906   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20230906   clang
sh                               alldefconfig   gcc  
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
sparc64              randconfig-r026-20230906   gcc  
sparc64              randconfig-r036-20230906   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                   randconfig-r013-20230906   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-001-20230906   gcc  
x86_64       buildonly-randconfig-002-20230906   gcc  
x86_64       buildonly-randconfig-003-20230906   gcc  
x86_64       buildonly-randconfig-004-20230906   gcc  
x86_64       buildonly-randconfig-005-20230906   gcc  
x86_64       buildonly-randconfig-006-20230906   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20230906   clang
x86_64                randconfig-002-20230906   clang
x86_64                randconfig-003-20230906   clang
x86_64                randconfig-004-20230906   clang
x86_64                randconfig-005-20230906   clang
x86_64                randconfig-006-20230906   clang
x86_64                randconfig-011-20230906   gcc  
x86_64                randconfig-012-20230906   gcc  
x86_64                randconfig-013-20230906   gcc  
x86_64                randconfig-014-20230906   gcc  
x86_64                randconfig-015-20230906   gcc  
x86_64                randconfig-016-20230906   gcc  
x86_64                randconfig-071-20230906   gcc  
x86_64                randconfig-072-20230906   gcc  
x86_64                randconfig-073-20230906   gcc  
x86_64                randconfig-074-20230906   gcc  
x86_64                randconfig-075-20230906   gcc  
x86_64                randconfig-076-20230906   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                    smp_lx200_defconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
