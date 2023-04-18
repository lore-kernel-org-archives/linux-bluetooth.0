Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30C4BC77B76
	for <linux-bluetooth@archiver.kernel.org>; Tue, 18 Apr 2023 07:56:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231247AbjDRH4e (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 18 Apr 2023 03:56:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231175AbjDRH4d (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 18 Apr 2023 03:56:33 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE12910F4
        for <linux-bluetooth@vger.kernel.org>; Tue, 18 Apr 2023 00:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681804588; x=1713340588;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=mRrjNbWyznqT9KtKsiOeimxv2me28/IyAWOdJ93gXSI=;
  b=n8IXDq8i0oJC9UUDmCWFW1+ifQRPZGIno5hMW4r3bmdl8E9QJmAssVZH
   PCmm7jJtTsV1Jqs5r1pKUkHKBSXG4u6yDPta69td+2njoxR/Bj+SzkO6h
   cMi29+a7t5Sff92ncnsBuYaLDd9peWSLSk/4Jo2Nslzz+GfVo9yAIsaAm
   ZhAH0TS4hqxawrfp3fqXn0ZgjLAIgx44M8P66KjtLDdCzB5KVCFYgcNko
   GD52V7CqJz4Jy/qOn3oLzxv4ybNu5vkZJCdZGEk7ygRYVbg1IBQtncuQW
   svu4bGr8zkKGkDuJ1C1RjiDytyEGD3q7mqmuXqKZICEKVlEPhn/eJr8W/
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10683"; a="333906910"
X-IronPort-AV: E=Sophos;i="5.99,206,1677571200"; 
   d="scan'208";a="333906910"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2023 00:56:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10683"; a="723542211"
X-IronPort-AV: E=Sophos;i="5.99,206,1677571200"; 
   d="scan'208";a="723542211"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 18 Apr 2023 00:56:26 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pogCQ-000d89-08;
        Tue, 18 Apr 2023 07:56:26 +0000
Date:   Tue, 18 Apr 2023 15:55:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc:     linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 0330a285b7f111b6b6e420d038f17e1de41f7bb9
Message-ID: <643e4cf9.SV87NTZ4CNH0Lbfz%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: 0330a285b7f111b6b6e420d038f17e1de41f7bb9  Bluetooth: btrtl: Firmware format v2 support

elapsed time: 725m

configs tested: 136
configs skipped: 12

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r001-20230417   gcc  
alpha                randconfig-r004-20230417   gcc  
alpha                randconfig-r016-20230416   gcc  
alpha                randconfig-r033-20230416   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r025-20230417   gcc  
arc                  randconfig-r032-20230416   gcc  
arc                  randconfig-r043-20230416   gcc  
arc                  randconfig-r043-20230417   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r015-20230417   gcc  
arm                  randconfig-r021-20230416   clang
arm                  randconfig-r025-20230416   clang
arm                  randconfig-r046-20230416   clang
arm                  randconfig-r046-20230417   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r026-20230416   gcc  
arm64                randconfig-r036-20230417   gcc  
csky         buildonly-randconfig-r003-20230416   gcc  
csky         buildonly-randconfig-r005-20230416   gcc  
csky         buildonly-randconfig-r006-20230416   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r006-20230417   gcc  
csky                 randconfig-r023-20230416   gcc  
hexagon              randconfig-r003-20230417   clang
hexagon              randconfig-r036-20230418   clang
hexagon              randconfig-r041-20230416   clang
hexagon              randconfig-r041-20230417   clang
hexagon              randconfig-r045-20230416   clang
hexagon              randconfig-r045-20230417   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r001-20230417   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-a001-20230417   gcc  
i386                 randconfig-a002-20230417   gcc  
i386                 randconfig-a003-20230417   gcc  
i386                 randconfig-a004-20230417   gcc  
i386                 randconfig-a005-20230417   gcc  
i386                 randconfig-a006-20230417   gcc  
i386                 randconfig-a011-20230417   clang
i386                 randconfig-a012-20230417   clang
i386                 randconfig-a013-20230417   clang
i386                 randconfig-a014-20230417   clang
i386                 randconfig-a015-20230417   clang
i386                 randconfig-a016-20230417   clang
i386                 randconfig-r023-20230417   clang
ia64                             allmodconfig   gcc  
ia64         buildonly-randconfig-r004-20230417   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r013-20230416   gcc  
ia64                 randconfig-r015-20230416   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch    buildonly-randconfig-r005-20230417   gcc  
loongarch                           defconfig   gcc  
m68k                             allmodconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r003-20230416   gcc  
m68k                 randconfig-r004-20230416   gcc  
m68k                 randconfig-r034-20230417   gcc  
microblaze   buildonly-randconfig-r002-20230416   gcc  
microblaze           randconfig-r021-20230417   gcc  
microblaze           randconfig-r024-20230416   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                 randconfig-r001-20230416   gcc  
mips                 randconfig-r031-20230418   gcc  
nios2        buildonly-randconfig-r003-20230417   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r011-20230417   gcc  
nios2                randconfig-r014-20230416   gcc  
nios2                randconfig-r022-20230417   gcc  
openrisc             randconfig-r006-20230416   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r031-20230417   gcc  
parisc               randconfig-r032-20230418   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc              randconfig-r002-20230417   gcc  
powerpc              randconfig-r011-20230416   gcc  
powerpc              randconfig-r031-20230416   clang
powerpc              randconfig-r033-20230417   gcc  
powerpc              randconfig-r036-20230416   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r012-20230417   clang
riscv                randconfig-r042-20230416   gcc  
riscv                randconfig-r042-20230417   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r005-20230416   clang
s390                 randconfig-r034-20230418   clang
s390                 randconfig-r044-20230416   gcc  
s390                 randconfig-r044-20230417   clang
sh                               allmodconfig   gcc  
sh           buildonly-randconfig-r002-20230417   gcc  
sh           buildonly-randconfig-r004-20230416   gcc  
sh                   randconfig-r005-20230417   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r016-20230417   gcc  
sparc64              randconfig-r013-20230417   gcc  
sparc64              randconfig-r014-20230417   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a001-20230417   gcc  
x86_64               randconfig-a002-20230417   gcc  
x86_64               randconfig-a003-20230417   gcc  
x86_64               randconfig-a004-20230417   gcc  
x86_64               randconfig-a005-20230417   gcc  
x86_64               randconfig-a006-20230417   gcc  
x86_64                        randconfig-a011   gcc  
x86_64                        randconfig-a012   clang
x86_64                        randconfig-a013   gcc  
x86_64                        randconfig-a014   clang
x86_64                        randconfig-a015   gcc  
x86_64                        randconfig-a016   clang
x86_64                               rhel-8.3   gcc  
xtensa       buildonly-randconfig-r006-20230417   gcc  
xtensa               randconfig-r012-20230416   gcc  
xtensa               randconfig-r035-20230417   gcc  
xtensa               randconfig-r035-20230418   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
