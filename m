Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83931C64EC4
	for <linux-bluetooth@archiver.kernel.org>; Fri,  3 Mar 2023 08:08:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229985AbjCCIIE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 3 Mar 2023 03:08:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbjCCIID (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 3 Mar 2023 03:08:03 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85BF057D05
        for <linux-bluetooth@vger.kernel.org>; Fri,  3 Mar 2023 00:07:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677830836; x=1709366836;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=4dlaoX1OzVEcLSIhn1nBHUbw8io9yLEjBa7K96+nkYM=;
  b=gfwPRUqIy72KF6xXeOONoXHSmy54lHZKCo1ZeCx2keixu+WJPK94aRz6
   CTU3ma4lSwQdyecYlIu/wRKPQilhuBY7Ss8gRJi5OKPJpvnQF1MpArths
   +0qCMbd9vTcirtKtt6zOMxXQeG1n0W23Soy0SM75YLh0P6lab5wh5KMx7
   1Qse8R7wCWCrFDdJNK9OWhAeOWQI2lgDTG/jixoYpR2aB0MPH1sD5mVz9
   SOWuPYS5zAB6NfeEHykjMOj5xbgdhTVrXQBWYebNZjPcQw/GPx3AWV9Zf
   m1oPowTZq5aIwBSqywiIe4/h2bbQpP63HYKKpw4BRB6X0GQ4y1Iya5+gB
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10637"; a="323283711"
X-IronPort-AV: E=Sophos;i="5.98,230,1673942400"; 
   d="scan'208";a="323283711"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2023 00:07:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10637"; a="744158984"
X-IronPort-AV: E=Sophos;i="5.98,230,1673942400"; 
   d="scan'208";a="744158984"
Received: from lkp-server01.sh.intel.com (HELO 776573491cc5) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 03 Mar 2023 00:07:04 -0800
Received: from kbuild by 776573491cc5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pY0RT-0001JS-1L;
        Fri, 03 Mar 2023 08:07:03 +0000
Date:   Fri, 03 Mar 2023 16:06:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc:     linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 80fb206d284067092e7e7b9e81646194138ff533
Message-ID: <6401aa98.5lQagdT3h92Cf/dO%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: 80fb206d284067092e7e7b9e81646194138ff533  Bluetooth: hci_sync: Fix smatch warning

elapsed time: 721m

configs tested: 118
configs skipped: 9

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r043-20230302   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                       imx_v4_v5_defconfig   clang
arm                           imxrt_defconfig   gcc  
arm                  randconfig-r006-20230302   clang
arm                  randconfig-r046-20230302   gcc  
arm64                            allyesconfig   gcc  
arm64        buildonly-randconfig-r001-20230302   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r005-20230302   gcc  
arm64                randconfig-r011-20230303   gcc  
csky                             alldefconfig   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r002-20230302   gcc  
csky                 randconfig-r012-20230302   gcc  
csky                 randconfig-r022-20230302   gcc  
hexagon      buildonly-randconfig-r005-20230302   clang
hexagon              randconfig-r021-20230302   clang
hexagon              randconfig-r041-20230302   clang
hexagon              randconfig-r045-20230302   clang
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
i386                          randconfig-c001   gcc  
ia64                             allmodconfig   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r015-20230303   gcc  
ia64                 randconfig-r036-20230302   gcc  
ia64                          tiger_defconfig   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
m68k                             allmodconfig   gcc  
m68k                                defconfig   gcc  
m68k                            mac_defconfig   gcc  
m68k                 randconfig-r004-20230302   gcc  
m68k                 randconfig-r011-20230302   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                           ip27_defconfig   clang
mips                    maltaup_xpa_defconfig   gcc  
mips                 randconfig-r001-20230302   clang
nios2                               defconfig   gcc  
nios2                randconfig-r031-20230302   gcc  
nios2                randconfig-r033-20230302   gcc  
openrisc             randconfig-r003-20230302   gcc  
openrisc             randconfig-r014-20230302   gcc  
openrisc             randconfig-r025-20230302   gcc  
parisc       buildonly-randconfig-r003-20230302   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r024-20230302   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc      buildonly-randconfig-r002-20230302   clang
powerpc                       ebony_defconfig   clang
powerpc                     mpc83xx_defconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv        buildonly-randconfig-r006-20230302   clang
riscv                               defconfig   gcc  
riscv             nommu_k210_sdcard_defconfig   gcc  
riscv                randconfig-r042-20230302   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r015-20230302   clang
s390                 randconfig-r016-20230303   gcc  
s390                 randconfig-r044-20230302   clang
sh                               allmodconfig   gcc  
sh                        edosk7705_defconfig   gcc  
sh                             espt_defconfig   gcc  
sh                               j2_defconfig   gcc  
sh                   randconfig-r012-20230303   gcc  
sh                   randconfig-r016-20230302   gcc  
sh                            titan_defconfig   gcc  
sparc                               defconfig   gcc  
sparc64              randconfig-r035-20230302   gcc  
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
xtensa               randconfig-r014-20230303   gcc  
xtensa               randconfig-r026-20230302   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
