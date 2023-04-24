Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F4E1C7618E
	for <linux-bluetooth@archiver.kernel.org>; Mon, 24 Apr 2023 21:08:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232071AbjDXVIE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 24 Apr 2023 17:08:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231351AbjDXVID (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 24 Apr 2023 17:08:03 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4A5AC7
        for <linux-bluetooth@vger.kernel.org>; Mon, 24 Apr 2023 14:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682370482; x=1713906482;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=JaMbh54Tetw0s9AF32UlzkIKa1Hw4v2EKu5UGw9wg3Y=;
  b=f1Xtpxp0keydRuEm4ddaI6KTfsWfulArJ/78iYCZUcl4yD45IJ0EVrbo
   NLDnOmRnag9k0yCWRGFj2RJlNrLWUH3twDuoloOjS+dfNBGPcrcbkbx7c
   oJRLAj/OgtiEVmzgFNy/3/6Xoy0AYAH8aW2WCjukfAd08aIn79uwpmssL
   JVIhqDKst6WCDxFeHW5yh/J0yVfGsBNz1RFjZOJZ9xlNZsOP1dJQLOBxX
   ysLNs/GxL7R4ixC/7ALkYhW09PJNI3m1bFNQw+o2mFVXtdqoZSHqwwedv
   vW8L0U6m7s8lqnsUeUpql1wrdyj/XSNm8HfJLM2N0ftySzwmkTJUYARU6
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10690"; a="345315431"
X-IronPort-AV: E=Sophos;i="5.99,223,1677571200"; 
   d="scan'208";a="345315431"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2023 14:08:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10690"; a="867624540"
X-IronPort-AV: E=Sophos;i="5.99,223,1677571200"; 
   d="scan'208";a="867624540"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 24 Apr 2023 14:08:01 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pr3Pk-000iei-0X;
        Mon, 24 Apr 2023 21:08:00 +0000
Date:   Tue, 25 Apr 2023 05:07:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc:     linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next:master] BUILD SUCCESS
 d883a4669a1def6d121ccf5e64ad28260d1c9531
Message-ID: <6446ef88.q2PWb1wcKFqLDpJb%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
branch HEAD: d883a4669a1def6d121ccf5e64ad28260d1c9531  Bluetooth: hci_sync: Only allow hci_cmd_sync_queue if running

elapsed time: 880m

configs tested: 134
configs skipped: 8

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha        buildonly-randconfig-r001-20230424   gcc  
alpha        buildonly-randconfig-r002-20230423   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r013-20230424   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r016-20230424   gcc  
arc                  randconfig-r021-20230423   gcc  
arc                  randconfig-r043-20230423   gcc  
arc                  randconfig-r043-20230424   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r033-20230424   gcc  
arm                  randconfig-r046-20230423   gcc  
arm                  randconfig-r046-20230424   clang
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r006-20230424   clang
arm64                randconfig-r015-20230423   clang
csky                                defconfig   gcc  
csky                 randconfig-r004-20230423   gcc  
csky                 randconfig-r005-20230423   gcc  
csky                 randconfig-r026-20230424   gcc  
csky                 randconfig-r035-20230424   gcc  
csky                 randconfig-r036-20230424   gcc  
hexagon              randconfig-r005-20230424   clang
hexagon              randconfig-r032-20230424   clang
hexagon              randconfig-r041-20230423   clang
hexagon              randconfig-r041-20230424   clang
hexagon              randconfig-r045-20230423   clang
hexagon              randconfig-r045-20230424   clang
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-a001-20230424   clang
i386                 randconfig-a002-20230424   clang
i386                 randconfig-a003-20230424   clang
i386                 randconfig-a004-20230424   clang
i386                 randconfig-a005-20230424   clang
i386                 randconfig-a006-20230424   clang
i386                 randconfig-a011-20230424   gcc  
i386                 randconfig-a012-20230424   gcc  
i386                 randconfig-a013-20230424   gcc  
i386                 randconfig-a014-20230424   gcc  
i386                 randconfig-a015-20230424   gcc  
i386                 randconfig-a016-20230424   gcc  
i386                 randconfig-r003-20230424   clang
i386                 randconfig-r031-20230424   clang
ia64                             allmodconfig   gcc  
ia64         buildonly-randconfig-r004-20230424   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r001-20230424   gcc  
ia64                 randconfig-r014-20230423   gcc  
ia64                 randconfig-r035-20230423   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch    buildonly-randconfig-r003-20230424   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r023-20230424   gcc  
loongarch            randconfig-r031-20230423   gcc  
loongarch            randconfig-r032-20230423   gcc  
m68k                             allmodconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r004-20230424   gcc  
m68k                 randconfig-r016-20230423   gcc  
microblaze   buildonly-randconfig-r005-20230424   gcc  
microblaze           randconfig-r002-20230423   gcc  
microblaze           randconfig-r011-20230423   gcc  
microblaze           randconfig-r011-20230424   gcc  
microblaze           randconfig-r015-20230424   gcc  
microblaze           randconfig-r024-20230424   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                 randconfig-r003-20230423   clang
mips                 randconfig-r033-20230423   clang
nios2                               defconfig   gcc  
nios2                randconfig-r025-20230423   gcc  
nios2                randconfig-r034-20230424   gcc  
openrisc     buildonly-randconfig-r005-20230423   gcc  
openrisc             randconfig-r024-20230423   gcc  
parisc       buildonly-randconfig-r006-20230423   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r012-20230423   gcc  
parisc               randconfig-r025-20230424   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv        buildonly-randconfig-r004-20230423   clang
riscv                               defconfig   gcc  
riscv                randconfig-r001-20230423   gcc  
riscv                randconfig-r026-20230423   clang
riscv                randconfig-r042-20230423   clang
riscv                randconfig-r042-20230424   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r044-20230423   clang
s390                 randconfig-r044-20230424   gcc  
sh                               allmodconfig   gcc  
sh           buildonly-randconfig-r001-20230423   gcc  
sh                   randconfig-r012-20230424   gcc  
sh                   randconfig-r021-20230424   gcc  
sh                   randconfig-r034-20230423   gcc  
sh                   randconfig-r036-20230423   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r022-20230423   gcc  
sparc64      buildonly-randconfig-r002-20230424   gcc  
sparc64              randconfig-r006-20230423   gcc  
sparc64              randconfig-r013-20230423   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a001-20230424   clang
x86_64               randconfig-a002-20230424   clang
x86_64               randconfig-a003-20230424   clang
x86_64               randconfig-a004-20230424   clang
x86_64               randconfig-a005-20230424   clang
x86_64               randconfig-a006-20230424   clang
x86_64               randconfig-a011-20230424   gcc  
x86_64               randconfig-a012-20230424   gcc  
x86_64               randconfig-a013-20230424   gcc  
x86_64               randconfig-a014-20230424   gcc  
x86_64               randconfig-a015-20230424   gcc  
x86_64               randconfig-a016-20230424   gcc  
x86_64                               rhel-8.3   gcc  
xtensa       buildonly-randconfig-r003-20230423   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
